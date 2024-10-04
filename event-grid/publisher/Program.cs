using Dapr.Client;
using Microsoft.AspNetCore.Mvc;
using models;
using System.Text.Json;

var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

var eventGridBindingName = "publishEvent";

app.MapGet("/", () => "Hello World!");

app.MapPost("/" + eventGridBindingName, async ([FromBody] IList<PublishEvent> jsonContent) =>
{
    string jsonString = JsonSerializer.Serialize(jsonContent);
    Console.WriteLine(jsonString);

    IList<PublishEvent> fakeValue = [];
    PublishEvent fakeEvent = new PublishEvent()
    {
        id = "123",
        subject = "test program",
        eventType = "output",
        eventTime = "2024-09-23T10:25:53+0000",
        data = new EventData
        {
            model = "Ducati",
            number = "moster"
        }

    };
    fakeValue.Append(fakeEvent);
    var data = JsonSerializer.Serialize(fakeValue);
    Console.WriteLine("data = " + data);
    using var client = new DaprClientBuilder().Build();
    await client.InvokeBindingAsync(eventGridBindingName, "create", jsonContent);
    Console.WriteLine($"New Event Published ${1}");
});

app.Run();



