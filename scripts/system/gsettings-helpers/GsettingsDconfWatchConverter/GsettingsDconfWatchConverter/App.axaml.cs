using Autofac;
using Avalonia;
using Avalonia.Controls.ApplicationLifetimes;
using Avalonia.Markup.Xaml;
using GsettingsDconfWatchConverter.Views;

namespace GsettingsDconfWatchConverter;

public class App : Application
{
    public override void Initialize()
    {
        AvaloniaXamlLoader.Load(this);
    }

    public override async void OnFrameworkInitializationCompleted()
    {
        var fullArguments = Environment.GetCommandLineArgs();
        
        // foreach (var argument in fullArguments)
        // {
        //     if (argument.ToLower().Contains("fullscreen"))
        //     {
        //         useFullscreen = true;
        //     }
        //     
        //     if (argument.ToLower().Contains("usemocks"))
        //     {
        //         useMocks = true;
        //     }
        // }
        
        var dependencyContainer = await DependencyInjectionRoot.GetBuiltContainer();

        await using var scope = dependencyContainer.BeginLifetimeScope();
        
        var loggerApplication = scope.Resolve<ILogger>();
        
        loggerApplication.Information("Application started. About to fire up MainWindow if IClassicDesktopStyleApplicationLifetime or MainView if ISingleViewApplicationLifetime");
        
        if (ApplicationLifetime is IClassicDesktopStyleApplicationLifetime desktop)
        {
            var mainWindow = scope.Resolve<MainWindow>();
            
            desktop.MainWindow = mainWindow;
        }
        // else if (ApplicationLifetime is ISingleViewApplicationLifetime singleViewPlatform)
        // {
        //     singleViewPlatform.MainView = scope.Resolve<MainView>();
        // }
        

        base.OnFrameworkInitializationCompleted();
    }
}
