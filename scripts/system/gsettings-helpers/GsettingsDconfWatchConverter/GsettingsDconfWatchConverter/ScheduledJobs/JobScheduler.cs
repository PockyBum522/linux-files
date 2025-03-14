// using GsettingsDconfWatchConverter.ScheduledJobs.FireOnce;
// using GsettingsDconfWatchConverter.ScheduledJobs.Recurring;
//
// namespace GsettingsDconfWatchConverter.ScheduledJobs;
//
// public class JobScheduler(ILogger logger, IScheduler scheduler)
// {
//     private const int FastStartJobsSeconds = 3;
//     private const int DelayedStartJobsSeconds = 10;
//
//     private readonly Random _random = new();
//
//     public async Task Start()
//     {
//         // To add a new scheduled job, first configure it by copying any of the methods below
//         // Configure it for new job name and type
//         // Then register it near the top of DependencyInjectionRoot 
//         
//         await SetupFireOnceJob<SendMotorHandshakeJob>("HardwareJobs", 1);
//         
//         await setupRecurringJob<AlarmsCheckJob>("AlarmJobs", DelayedStartJobsSeconds, 5);
//         await setupRecurringJob<ReadRtdsJob>("HardwareJobs", 1, 1);
//         await setupRecurringJob<UpdateWatchdogFileJob>("WatchdogJobs", (int)(DelayedStartJobsSeconds + (_random.NextDouble() * 10)), 10);
//         await setupRecurringJob<ReadMotorSpeedJob>("SerialHardwareJobs", DelayedStartJobsSeconds, 2);
//         await setupRecurringJob<RunningProgramCheckJob>("SerialHardwareJobs", FastStartJobsSeconds, 3);
//         await setupRecurringJob<WriteBathLogJob>("LogJobs", (int)(DelayedStartJobsSeconds + (_random.NextDouble() * 10)), 10);
//         await setupRecurringJob<StopBathMovementAfterElapsedTimeJob>("HardwareJobs", FastStartJobsSeconds, 1);
//         await setupRecurringJob<HeaterControlJob>("HardwareJobs", DelayedStartJobsSeconds, 2);
//         await setupRecurringJob<RotovapControlViewModelUpdateControlsJob>("ViewUpdateJobs", FastStartJobsSeconds, 1);
//         await setupRecurringJob<ControlViewModelUpdatePlotJob>("ViewUpdateJobs", FastStartJobsSeconds, 3);
//         await setupRecurringJob<IHideCursorJob>("HideCursorJobs", 1, 5);
//         
//         await scheduler.Start();
//     }
//     
//     // Fire once on startup
//     private async Task SetupFireOnceJob<T>(string jobFriendlyGroupName, int firstRunAtSeconds) where T : IJob
//     {
//         var jobFriendlyName = typeof(T).ToString();
//
//         var lastIndexOfPeriodCharacter = jobFriendlyName.LastIndexOf('.') + 1;
//
//         jobFriendlyName = jobFriendlyName[lastIndexOfPeriodCharacter..];
//
//         var jobIdentityName = jobFriendlyName.Replace("Job", "");
//         
//         var jobDetails = JobBuilder.Create<T>()
//             .WithIdentity(jobIdentityName, jobFriendlyGroupName)
//             .Build();
//
//         var runAt = DateTimeOffset.Now + TimeSpan.FromSeconds(firstRunAtSeconds);
//         
//         logger.Information("Setting up {ThisName} schedule, will begin running at: {RunAt}", jobFriendlyName, runAt);
//         
//         // Trigger the job to run now, and then repeat
//         var trigger = TriggerBuilder.Create()
//             .WithIdentity($"{jobIdentityName}Triggers", $"{jobFriendlyGroupName}Triggers")
//             .StartAt(runAt)
//             .Build();
//
//         logger.Information("Setting up new (fire once) scheduled job, jobFriendlyName: {JobName}, jobFriendlyGroupName: {GroupName}, firstRunAtSeconds: {FirstRunAtSeconds}", jobFriendlyName, jobFriendlyGroupName, firstRunAtSeconds);
//
//         // Tell Quartz to schedule the job using our trigger
//         await scheduler.ScheduleJob(jobDetails, trigger);
//     }
//
//     // Recurring
//     private async Task setupRecurringJob<T>(string jobFriendlyGroupName, int firstRunAtSeconds, int repeatEverySeconds) where T : IJob
//     {
//         var jobFriendlyName = typeof(T).ToString();
//
//         var lastIndexOfPeriodCharacter = jobFriendlyName.LastIndexOf('.') + 1;
//
//         jobFriendlyName = jobFriendlyName[lastIndexOfPeriodCharacter..];
//
//         var jobIdentityName = jobFriendlyName.Replace("Job", "");
//         
//         var jobDetails = JobBuilder.Create<T>()
//             .WithIdentity(jobIdentityName, jobFriendlyGroupName)
//             .Build();
//         
//         var runAt = DateTimeOffset.Now + TimeSpan.FromSeconds(firstRunAtSeconds);
//         
//         logger.Information("Setting up {ThisName} schedule, will begin running at: {RunAt}", jobFriendlyName, runAt);
//         
//         // Trigger the job to run now, and then repeat
//         var trigger = TriggerBuilder.Create()
//             .WithIdentity($"{jobIdentityName}Triggers", $"{jobFriendlyGroupName}Triggers")
//             .StartAt(runAt)
//             .WithSimpleSchedule(x => x
//                 .WithIntervalInSeconds(repeatEverySeconds)
//                 .RepeatForever())
//             .Build();
//
//         logger.Information("Setting up new (recurring) scheduled job, jobFriendlyName: {JobName}, jobFriendlyGroupName: {GroupName}, firstRunAtSeconds: {FirstRunAtSeconds}, repeatEverySeconds: {RepeatEverySeconds}", jobFriendlyName, jobFriendlyGroupName, firstRunAtSeconds, repeatEverySeconds);
//         
//         // Tell Quartz to schedule the job using our trigger
//         await scheduler.ScheduleJob(jobDetails, trigger);
//     }
// }