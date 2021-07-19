class Report {
  final int id;
  double calf;
  double hips;
  double belly;
  double waist;
  double chest;
  double biceps;
  double weight;
  double height;
  String dietOpinion;
  String workoutOpinion;
  int menteeId;
  String date;
  Report({
    required this.id,
    required this.menteeId,
    required this.date,
    this.calf = 0,
    this.hips = 0,
    this.belly = 0,
    this.waist = 0,
    this.chest = 0,
    this.biceps = 0,
    this.weight = 0,
    this.height = 0,
    this.dietOpinion = '',
    this.workoutOpinion = ''
  });
  factory Report.fromJson(Map<String, dynamic> body) {
    return Report(
        date: body['created_at'],
        id: body['id'],
        menteeId: body['mentee_id'],
        calf: body['calf'],
        hips: body['hips'],
        belly: body['belly'],
        waist: body['waist'],
        chest: body['chest'],
        biceps: body['biceps'],
        weight: body['weight'],
        height: body['height'],
        dietOpinion: body['diet_opinion'],
        workoutOpinion: body['workout_opinion']);
  }
}
