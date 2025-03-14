using Quartz.Logging;
using LogContext = Serilog.Context.LogContext;

namespace GsettingsDconfWatchConverter.Logic;

public class CustomSerilogLogProvider(ILogger logger) : ILogProvider
{
    private ILogger _logger { get; set; } = logger ?? throw new ArgumentNullException(nameof(logger));

    public Logger GetLogger(string name)
    {
        return new SerilogLogger(_logger.ForContext("SourceContext", name, destructureObjects: false)).Log;   
    }

    // private object ForContext(string name)
    // {
    //     return Logger.ForContext("SourceContext", name, destructureObjects: false);
    // }

    public IDisposable OpenNestedContext(string message)
    {
        return LogContext.PushProperty("Ndc", message);            
    }

    public IDisposable OpenMappedContext(string key, object value, bool destructure = false)
    {
        return LogContext.PushProperty(key, value);   
    }

    private class SerilogLogger
    {
        private ILogger _logger;        

        public SerilogLogger(ILogger logger)
        {
            this._logger = logger;
        }

        public bool Log(LogLevel logLevel, Func<string> messageFunc, Exception exception, params object[] formatParameters)
        {
            var translatedLevel = translateLevel(logLevel);
            
            return _logger.IsEnabled(translatedLevel);

            // Delete this if quartz logger context stuff works fine
            
            // if (!_logger.IsEnabled(translatedLevel))
            // {
            //     return false;
            // }
            //
            // if (exception != null)
            // {
            //     LogException(translatedLevel, messageFunc, exception, formatParameters);
            // }
            // else
            // {
            //     LogMessage(translatedLevel, messageFunc, formatParameters);
            // }
            //
            // return true;
        }

        // private void LogMessage(Serilog.Events.LogEventLevel logLevel, Func<string> messageFunc, object[] formatParameters)
        // {
        //     _logger.Write(logLevel, messageFunc(), formatParameters);            
        // }
        //
        // private void LogException(Serilog.Events.LogEventLevel logLevel, Func<string> messageFunc, Exception exception, object[] formatParams)
        // {            
        //     _logger.Write(logLevel, exception, messageFunc(), formatParams);
        // }

        private static Serilog.Events.LogEventLevel translateLevel(LogLevel logLevel)
        {
            switch (logLevel)
            {
                case LogLevel.Fatal:
                    return Serilog.Events.LogEventLevel.Fatal;
                case LogLevel.Error:
                    return Serilog.Events.LogEventLevel.Error; 
                case LogLevel.Warn:
                    return Serilog.Events.LogEventLevel.Warning; 
                case LogLevel.Info:
                    return Serilog.Events.LogEventLevel.Information; 
                case LogLevel.Trace:
                    return Serilog.Events.LogEventLevel.Verbose; 
                default:
                    return Serilog.Events.LogEventLevel.Debug; 
            }
        }
    }                      
}