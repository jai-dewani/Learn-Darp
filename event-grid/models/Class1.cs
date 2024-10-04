using System.Text.Json.Serialization;

namespace models;

public class PublishEvent
{
    [JsonPropertyName("id")]
    public string id { get; set; }

    [JsonPropertyName("eventType")]
    public string eventType { get; set; }

    [JsonPropertyName("subject")]
    public string subject { get; set; }

    [JsonPropertyName("eventTime")]
    public string eventTime { get; set; }

    [JsonPropertyName("data")]
    public EventData data { get; set; }
}

public class EventData
{
    [JsonPropertyName("model")]
    public string model { get; set; }

    [JsonPropertyName("number")]
    public string number { get; set; }
}