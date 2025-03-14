using System.Runtime.Versioning;
using System.Threading.Tasks;
using Avalonia;
using Avalonia.Browser;
using Avalonia.ReactiveUI;

[assembly: SupportedOSPlatform("browser")]

namespace GsettingsDconfWatchConverter.Browser;

internal sealed class Program
{
    // ReSharper disable once UnusedParameter.Local because args will actually get used later for fullscreen argument we pass when executing the binary
    private static Task Main(string[] args) => BuildAvaloniaApp()
        .WithInterFont()
        .UseReactiveUI()
        .StartBrowserAppAsync("out");

    public static AppBuilder BuildAvaloniaApp()
        => AppBuilder.Configure<App>();
}