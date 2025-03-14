// namespace GsettingsDconfWatchConverter.ScheduledJobs.Recurring;
//
// [DisallowConcurrentExecution]
// public class AlarmsCheckJob(
//     ILogger loggerApplication,
//     RotovapControllerState rotovapControllerState,
//     IBathController bathController)
//     : IJob
// {
//     public Task Execute(IJobExecutionContext context)
//     {
//         loggerApplication.Information("Firing scheduled job {ThisName}", nameof(AlarmsCheckJob));
//         
//         if (rotovapControllerState.ControllerAlarmed)
//             loggerApplication.Warning("Unit alarm, code is: {AlarmCode}", rotovapControllerState.AlarmLastCode);
//
//         alarmIfTemperatureSetpointExceedsMaximum();
//         
//         alarmIfBathRetriesOutOfBounds();
//
//         alarmIfRtdTemperaturesOutOfBounds();
//
//         alarmIfRtdTemperaturesUninitialized();
//         
//         alarmIfCoilExceedsBathTemperature();
//         
//         // If nothing above halted heater, then read out temps normally:
//         loggerApplication.Information("BathController RTD temperature: {BathTemperatureC}", rotovapControllerState.BathActualTemperature);
//         loggerApplication.Information("Coil RTD temperature: {CoilTemperatureC}", rotovapControllerState.CoilActualTemperature);
//
//         return Task.CompletedTask;
//     }
//
//     private void alarmIfTemperatureSetpointExceedsMaximum()
//     {
//         if (rotovapControllerState.BathTemperatureSetpoint > (rotovapControllerState.MaximumPermittedBathTempForAlarm - 9))
//         {
//             fireAlarm(rotovapControllerState.AlarmCodes.AlarmCodeBathSetpointExceedsMaximum);
//         }
//     }
//
//     private void alarmIfCoilExceedsBathTemperature()
//     {
//         if (rotovapControllerState.CoilActualTemperature >
//             rotovapControllerState.BathActualTemperature + rotovapControllerState.CoilOverBathRtdMarginForAlarm)
//         {
//             fireAlarm(rotovapControllerState.AlarmCodes.AlarmCodeCoilOverBathRtdMarginExceeded);
//         }
//     }
//
//     private void alarmIfBathRetriesOutOfBounds()
//     {
//         if (bathController.BathRtdReadRetries < 10)
//             fireAlarm(rotovapControllerState.AlarmCodes.AlarmCodeBathRtdReadRetriesExceeded);
//         
//         if (bathController.BathRtdReadRetries < 10)
//             fireAlarm(rotovapControllerState.AlarmCodes.AlarmCodeCoilRtdReadRetriesExceeded);
//     }
//
//     private void fireAlarm(string alarmCode)
//     {
//         rotovapControllerState.IsHeaterEnabled = false;
//         rotovapControllerState.AlarmLastCode = alarmCode;
//         rotovapControllerState.ControllerAlarmed = true;
//     }
//
//     private void alarmIfRtdTemperaturesOutOfBounds()
//     {
//         if (rotovapControllerState.BathActualTemperature > rotovapControllerState.MaximumPermittedBathTempForAlarm)
//             fireAlarm(rotovapControllerState.AlarmCodes.AlarmCodeBathTemperatureExceedsMaximum);
//             
//         if (rotovapControllerState.CoilActualTemperature > rotovapControllerState.MaximumPermittedBathTempForAlarm)
//             fireAlarm(rotovapControllerState.AlarmCodes.AlarmCodeCoilTemperatureExceedsMaximum);
//     }
//
//     private void alarmIfRtdTemperaturesUninitialized()
//     {
//         if (rotovapControllerState.BathActualTemperature is > 999.8d and < 1000.1d)
//             fireAlarm(rotovapControllerState.AlarmCodes.AlarmCodeBathActualTemperatureWasUninitialized);
//         
//         if (rotovapControllerState.CoilActualTemperature is > 999.8d and < 1000.1d)
//             fireAlarm(rotovapControllerState.AlarmCodes.AlarmCodeCoilActualTemperatureWasUninitialized);
//     }
// }