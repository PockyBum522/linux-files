using System.Collections.ObjectModel;
using System.ComponentModel;
using System.IO.Ports;
using System.Linq;
using System.Linq.Expressions;
using System.Runtime.CompilerServices;
using System.Threading;
using Avalonia.Interactivity;
using Avalonia.Platform.Storage;
using CommunityToolkit.Mvvm.ComponentModel;
using CommunityToolkit.Mvvm.Input;
using DynamicData.Kernel;

namespace GsettingsDconfWatchConverter.ViewModels;

public partial class MainViewModel : ObservableObject
{
    public MainViewModel() { }

    private readonly ILogger? _logger;
    public MainViewModel(ILogger logger)
    {
        _logger = logger;
    }
    
    [ObservableProperty]
    private string rawDconfText = "";
    
    [ObservableProperty]
    private string convertedOutputText = "";
    
    [RelayCommand]
    private void convertDconfOutputToScriptable()
    {
        _logger?.Information("Converting dconf to Scriptable");
        _logger?.Information("");
        _logger?.Information("[START]");

        var rawDconfLines = RawDconfText.Split(Environment.NewLine);

        var dconfLinesList = CleanFirstLinesIfBlank(rawDconfLines);

        var convertedLines = new List<string>();
        
        for (var i = 0; i < dconfLinesList.Count; i++)
        {
            // Gotta modify the collection potentially so
            var line = dconfLinesList[i];

            line = line.Trim();

            line = line.TrimStart('#');

            if (line.StartsWith("/"))
            {
                // Then we're on a setting key
                line = line.Replace('/', '.');

                line = line.TrimStart('/');
                
                // Find last .
                var lastDotPositon = line.LastIndexOf('.');

                var dotReplacedLineFirst = line.Substring(0, lastDotPositon);
                var dotReplacedLineSecond = line.Substring(lastDotPositon + 1);
                
                // Now take the last dot out
                var newLine = dotReplacedLineFirst + ' ' + dotReplacedLineSecond;

                newLine = newLine.TrimStart('.');
                
                // Now add the next line onto this one
                var nextLine = dconfLinesList[i + 1];
                
                nextLine = nextLine.Trim();
                
                nextLine =  nextLine.TrimStart('#');
                
                nextLine =  nextLine.TrimStart();
                
                newLine = $"{newLine} \"{nextLine}\"";
                
                // Now remove that next line since we just moved it up onto this one
                dconfLinesList.RemoveAt(i + 1);
                
                convertedLines.Add(newLine);
            }
        }

        var prefixedRunInSessionLines = PrefixAllLines("run-in-user-session gsettings set ", convertedLines);
        
        var prefixedLines = PrefixAllLines("gsettings set ", convertedLines);
        
        ConvertedOutputText = "# RUN IN USER SESSION LINES:" + Environment.NewLine; 
        ConvertedOutputText += Environment.NewLine; 
        
        ConvertedOutputText += string.Join(Environment.NewLine, prefixedRunInSessionLines);
        
        ConvertedOutputText += Environment.NewLine; 
        ConvertedOutputText += Environment.NewLine; 

        ConvertedOutputText += "# RUN NORMALLY LINES:" + Environment.NewLine; 
        ConvertedOutputText += Environment.NewLine; 
        
        ConvertedOutputText += string.Join(Environment.NewLine, prefixedLines);
        ConvertedOutputText += Environment.NewLine;

        _logger?.Information("[END]");
    }

    private List<string> PrefixAllLines(string prefix, List<string> lines)
    {
        var returnList = new List<string>();
        
        foreach (var line in lines)
        {
            returnList.Add(prefix + line);
        }
        
        return returnList;
    }

    private List<string> CleanFirstLinesIfBlank(string[] rawDconfLines)
    {
        var convertedList = rawDconfLines.ToList();

        if (convertedList.Count < 1) return [];

        var countdown = 10;
        while (countdown-- > 0)
        {
            if (!string.IsNullOrWhiteSpace(convertedList.FirstOrDefault())) continue;
            
            convertedList.RemoveAt(0);
        }

        return convertedList;
    }

    private string GetPropertyName([CallerMemberName] string? propertyName = null)
    {
        if (propertyName is null) throw new NullReferenceException("Error getting property name automatically");
        
        return propertyName;
    }
}