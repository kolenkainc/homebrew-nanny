﻿using System;
using System.IO;
using System.Reflection;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Nanny.Console.Commands;
using Nanny.Console.Printers;
using Serilog;

namespace Nanny.Console
{
    public class Program
    {
        private IHost _host;

        public Program()
        {
            var builder = new ConfigurationBuilder()
                .SetBasePath(Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location))
                .AddJsonFile("appsettings.json", optional: false, reloadOnChange: true)
                .AddJsonFile($"appsettings.{Environment.GetEnvironmentVariable("ASPNETCORE_ENVIRONMENT") ?? "Production"}.json", optional: true, reloadOnChange: true)
                .AddEnvironmentVariables();
            Log.Logger = new LoggerConfiguration()
                .ReadFrom.Configuration(builder.Build())
                .CreateLogger();
            _host = Host.CreateDefaultBuilder()
                .ConfigureServices((context, services) =>
                {
                    services.AddLogging(l =>
                    {
                        l.ClearProviders();
                        l.AddSerilog(Log.Logger);
                    });
                    services.AddTransient<CommandList>();
                    services.AddTransient<IPrinter, ConsolePrinter>();
                })
                .Build();
        }

        static void Main(string[] args)
        {
            try
            {
                Log.Logger.Information("Getting started...");
                Program program = new Program();
                program.Run(args);
            }
            catch (Exception ex)    
            {
                Log.Logger.Fatal(ex, "Host terminated unexpectedly");
            }
            finally
            {
                Log.CloseAndFlush();
            }
        }

        public void Run(string[] args)
        {
            var list = ActivatorUtilities.CreateInstance<CommandList>(_host.Services);
            ActivatorUtilities.CreateInstance<ConsolePrinter>(
                _host.Services,
                list.Find(args, new HelpCommand())
                )
                .Print();
        }
    }
}
