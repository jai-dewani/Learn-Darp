using models;
using Microsoft.AspNetCore.Mvc;

var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

IList<PublishEvent> allEvents = [];

app.MapGet("/", () => "Hello World!");

app.MapGet("/getAllEvents", () => allEvents);

app.MapPost("/deleteAllEvents", () => {
    allEvents = [];
});

app.MapPost("/processEvent", ([FromBody] IList<PublishEvent> jsonContent) =>
{
    allEvents = allEvents.Union(jsonContent).ToList();
});

app.Run();
