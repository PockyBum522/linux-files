namespace GsettingsDconfWatchConverter.Logic;

public class FileHelpers
{
    public void DeleteFilesOlderThan(string pathToWork, TimeSpan timeOlderThanToDelete)
    {
        foreach (var logFile in Directory.GetFiles(pathToWork))
        {
            var fileInfo = new FileInfo(logFile);
    
            if (fileInfo.LastWriteTime < DateTimeOffset.Now - timeOlderThanToDelete)
            {
                File.Delete(logFile);
            }
        }
    }
    
    public string GetCurrentTimestamp(bool filenameSafe = true)
    {
        if (!filenameSafe)
            return DateTimeOffset.Now.ToString("yyyy/M/d HH:mm:ss");
    
        var timestampString = DateTimeOffset.Now.ToString("yyyy-M-d_HH");
    
        timestampString += "h";
        timestampString += DateTimeOffset.Now.ToString("mm");
        timestampString += "m";
        timestampString += DateTimeOffset.Now.ToString("ss");
        timestampString += "s";
    
        return timestampString;
    }
}