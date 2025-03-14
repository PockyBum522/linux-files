using System.ComponentModel;
using System.Globalization;
using Avalonia.Data.Converters;

namespace GsettingsDconfWatchConverter.Views.ViewUtilities;

public class EnumDescriptionConverter : IValueConverter
{
    private string getEnumDescription(Enum enumObj)
    {
        var fieldInfo = enumObj.GetType().GetField(enumObj.ToString());

        if (fieldInfo is null)
            throw new NullReferenceException();
        
        var attribArray = fieldInfo.GetCustomAttributes(false);

        if (attribArray.Length == 0)
        {
            return enumObj.ToString();
        }

        // Otherwise:
        DescriptionAttribute? attrib = null;

        foreach (var att in attribArray)
        {
            if (att is DescriptionAttribute)
                attrib = att as DescriptionAttribute;
        }

        if (attrib != null)
            return attrib.Description;

        return enumObj.ToString();
    }

    object IValueConverter.Convert(object? value, Type targetType, object? parameter, CultureInfo culture)
    {
        var myEnum = (Enum?)value;

        if (myEnum is null)
            throw new NullReferenceException();
        
        var description = getEnumDescription(myEnum);
        
        return description;
    }

    object IValueConverter.ConvertBack(object? value, Type targetType, object? parameter, CultureInfo culture)
    {
        return string.Empty;
    }
}