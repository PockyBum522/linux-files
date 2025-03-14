// namespace GsettingsDconfWatchConverter.ScheduledJobs.FireOnce;
//
// public class SendMotorHandshakeJob(
//     ILogger loggerApplication,
//     RotovapControllerState rotovapControllerState,
//     IMotorController motorController)
//     : IJob
// {
//     public Task Execute(IJobExecutionContext context)
//     {
//         loggerApplication.Information("Firing scheduled job {ThisName}", nameof(SendMotorHandshakeJob));
//             
//         motorController.OpenSerialPort();
//
//         motorController.SendMotorHandshake();
//         
//         loggerApplication.Information("Finished job {ThisName}", nameof(SendMotorHandshakeJob));
//
//         rotovapControllerState.ControlsReady = true;
//         
//         return Task.CompletedTask;
//     }
// }