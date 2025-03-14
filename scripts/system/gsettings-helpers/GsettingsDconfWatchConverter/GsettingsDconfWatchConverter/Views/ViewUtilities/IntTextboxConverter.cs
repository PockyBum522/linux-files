using System.Globalization;
using Avalonia.Data.Converters;

namespace GsettingsDconfWatchConverter.Views.ViewUtilities;

public class IntTextboxConverter : IValueConverter
{
    public static readonly IntTextboxConverter Instance = new();

    public object? Convert(object? value, Type targetType, object? parameter, CultureInfo culture)
    {
        if (value is null) value = "0";
            
        return value.ToString();
    }

    public object ConvertBack(object? value, Type targetType, object? parameter, CultureInfo culture)
    {
        if (value is null ||
            string.IsNullOrWhiteSpace((string)value))
        {
            value = "0";
        }
        
        return int.Parse((string)value);
    }
}