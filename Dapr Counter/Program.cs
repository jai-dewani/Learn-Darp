using Dapr.Client;

const string storeName = "statestore";
const string sqlLiteStateStore = "sqllitestatestore";
const string key = "counter";

var daprClient = new DaprClientBuilder().Build();

// var log = await GetLog();
// Console.WriteLine($"Date = {log.Date} | Value = {log.value} | Level = {log.level}");

await Counter();

async Task Counter()
{
    var counter = await daprClient.GetStateAsync<int>(sqlLiteStateStore, key);

    while (true)
    {
        Console.WriteLine($"Counter = {counter++}");
        await daprClient.SaveStateAsync(sqlLiteStateStore, key, counter);
        await Task.Delay(1000);
    }
}

async Task SetLog()
{
    string key = "log";
    var value = new Logs
    {
        Date = DateTime.Now,
        level = 1,
        value = "New log"
    };
    await daprClient.SaveStateAsync(sqlLiteStateStore, key, value);
}

async Task<Logs> GetLog()
{
    string key = "log";
    var value = await daprClient.GetStateAsync<Logs>(sqlLiteStateStore, key);
    return value;
}


class Logs
{
    public DateTime Date { get; set; }
    public string value { get; set; }
    public int level { get; set; }
}