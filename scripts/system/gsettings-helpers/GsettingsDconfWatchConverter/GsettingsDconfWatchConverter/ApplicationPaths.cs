using System.Runtime.InteropServices;

namespace GsettingsDconfWatchConverter;

public static class ApplicationPaths
{
    static ApplicationPaths()
    {
        if (RuntimeInformation.IsOSPlatform(OSPlatform.Windows))
        {
            var basePath = @"C:\Users\Public\Documents\Kit\GsettingsDconfWatchConverter\";

            setAllPaths(basePath);
        }

        if (RuntimeInformation.IsOSPlatform(OSPlatform.Linux))
        {
            var basePath = Path.Join(Environment.GetFolderPath(Environment.SpecialFolder.UserProfile), "Kit", "GsettingsDconfWatchConverter");
            
            setAllPaths(basePath);
        }

        if (string.IsNullOrWhiteSpace(ApplicationLoggingDirectory) ||
            string.IsNullOrWhiteSpace(UserSettingsDirectory))
        {
            throw new Exception("OS Could not be detected automatically");
        }
        
        Directory.CreateDirectory(ApplicationLoggingDirectory);
        Directory.CreateDirectory(UserSettingsDirectory);
    }

    private static void setAllPaths(string basePath)
    {
        var logBasePath = Path.Join(basePath, "Logs");
            
        ApplicationLoggingDirectory = Path.Join(logBasePath, "Application Logs");
        
        UserSettingsDirectory = Path.Join(basePath, "Configuration");
    }
    
    public static string ApplicationLoggingDirectory { get; private set; }
    
    public static string UserSettingsDirectory { get; private set; }
}