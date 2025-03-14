using System;
using System.Threading;
using Avalonia;
using Avalonia.ReactiveUI;
using Serilog;

namespace GsettingsDconfWatchConverter.Desktop;

public static class Program
{
    // Initialization code. Don't use any Avalonia, third-party APIs or any
    // SynchronizationContext-reliant code before AppMain is called: things aren't initialized
    // yet and stuff might break.
    [STAThread]
    public static void Main(string[] args)
    {
        // if (args.Length < 2)
        // {
        //     Console.WriteLine("You may optionally provide up to 2 arguments:");
        //     Console.WriteLine();
        //     Console.WriteLine("Options are:");
        //     Console.WriteLine("--fullscreen = Run application fullscreened");
        //     Console.WriteLine("--useMocks = Run application without actual hardware");
        // }
        
        try
        {
            BuildAvaloniaApp()
                .StartWithClassicDesktopLifetime(args);
        }
        catch (Exception ex)
        {
            DependencyInjectionRoot.LoggerApplication.Warning("Unhandled exception in main thread: {ExMessage}", ex.Message);
        }
        finally
        {
            var counter = 20;

            while (counter-- > 0)
            {
                Log.CloseAndFlush();
                
                Thread.Sleep(100);
            }
        }
    }
    
    // Avalonia configuration, don't remove; also used by visual designer.
    public static AppBuilder BuildAvaloniaApp()
        => AppBuilder.Configure<App>()
            .UsePlatformDetect()
            .WithInterFont()
            .LogToTrace()
            .UseReactiveUI();
}
