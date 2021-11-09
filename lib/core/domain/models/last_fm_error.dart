class LastFmError {
    LastFmError({
        this.message,
        this.error,
    });

    String? message;
    int? error;

    factory LastFmError.fromJson(Map<String, dynamic> json) => LastFmError(
        message: json["message"],
        error: json["error"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "error": error,
    };
}
