import '../models/workout_model.dart';
import '../models/exercise_model.dart';

class MockWorkouts {
  MockWorkouts._();

  static final List<WorkoutModel> workouts = [
    const WorkoutModel(
      id: 'w_01',
      title: 'Full Body HIIT Blast',
      description:
          'High intensity interval circuit designed to torch calories, spike metabolism, and tone muscles across the entire kinetic chain.',
      category: 'HIIT',
      difficulty: WorkoutDifficulty.intermediate,
      durationMinutes: 28,
      caloriesBurned: 320,
      imageUrl:
          'https://images.unsplash.com/photo-1517838277536-f5f99be501cd?w=800&auto=format&fit=crop&q=80',
      equipment: ['Yoga Mat', 'Timer'],
      targetMuscles: ['Full Body', 'Quads', 'Core', 'Shoulders'],
      isFeatured: true,
      rating: 4.9,
      exercises: [
        ExerciseModel(
          id: 'ex_01',
          name: 'Jumping Jacks Warmup',
          description:
              'Rhythmic full body jump jacks to elevate core temperature and heart rate.',
          durationSeconds: 45,
          imageUrl: '',
          tips:
              'Land softly on the balls of your feet and keep your arms straight.',
        ),
        ExerciseModel(
          id: 'ex_02',
          name: 'Burpees with Push-Up',
          description:
              'Squat down, kick feet back, perform a chest-to-deck push-up, jump back up with explosive power.',
          reps: 12,
          sets: 3,
          restSeconds: 25,
          imageUrl: '',
          tips: 'Keep your core brace tight during the push-up phase.',
        ),
        ExerciseModel(
          id: 'ex_03',
          name: 'High Knees Sprint',
          description:
              'Rapid sprint in place lifting knees to hip height with aggressive arm pump.',
          durationSeconds: 40,
          restSeconds: 20,
          imageUrl: '',
          tips: 'Keep your torso tall, do not lean backwards.',
        ),
        ExerciseModel(
          id: 'ex_04',
          name: 'Mountain Climbers',
          description:
              'From a plank position, drive knees alternately toward the chest at a brisk cadence.',
          durationSeconds: 45,
          restSeconds: 20,
          imageUrl: '',
          tips: 'Keep hips aligned with shoulders, avoid piking up.',
        ),
        ExerciseModel(
          id: 'ex_05',
          name: 'Jump Squats',
          description:
              'Sink into a deep parallel squat and explode straight up, landing smoothly into the next squat.',
          reps: 15,
          sets: 3,
          restSeconds: 30,
          imageUrl: '',
          tips: 'Absorb the landing softly through heels and midfoot.',
        ),
      ],
    ),
    const WorkoutModel(
      id: 'w_02',
      title: 'Dumbbell Upper Body Power',
      description:
          'Compound strength session targeting the chest, lats, deltoids, and arms with progressive dumbbell overload.',
      category: 'Strength',
      difficulty: WorkoutDifficulty.advanced,
      durationMinutes: 45,
      caloriesBurned: 390,
      imageUrl:
          'https://images.unsplash.com/photo-1581009146145-b5ef050c2e1e?w=800&auto=format&fit=crop&q=80',
      equipment: ['Dumbbells', 'Flat Bench'],
      targetMuscles: ['Chest', 'Lats', 'Deltoids', 'Triceps', 'Biceps'],
      isFeatured: true,
      rating: 4.8,
      exercises: [
        ExerciseModel(
          id: 'ex_06',
          name: 'Dumbbell Bench Press',
          description:
              'Lie flat, press dumbbells smoothly upward over chest and lower with 3-second eccentric tempo.',
          reps: 10,
          sets: 4,
          restSeconds: 60,
          imageUrl: '',
          tips: 'Retract shoulder blades and plant feet firmly on the floor.',
        ),
        ExerciseModel(
          id: 'ex_07',
          name: 'Single Arm Dumbbell Row',
          description:
              'Hinge forward with one knee on bench, pull dumbbell to hip crease engaging lat muscle.',
          reps: 12,
          sets: 3,
          restSeconds: 45,
          imageUrl: '',
          tips: 'Pull with the elbow, avoid twisting your torso.',
        ),
        ExerciseModel(
          id: 'ex_08',
          name: 'Seated Overhead Dumbbell Press',
          description:
              'Press dumbbells vertically overhead, locking out safely with wrists aligned over elbows.',
          reps: 10,
          sets: 3,
          restSeconds: 45,
          imageUrl: '',
          tips: 'Keep ribs pinned down to protect the lower back.',
        ),
        ExerciseModel(
          id: 'ex_09',
          name: 'Incline Bicep Curls',
          description:
              'Sit on inclined bench and curl dumbbells simultaneously with full supination at top.',
          reps: 12,
          sets: 3,
          restSeconds: 30,
          imageUrl: '',
          tips: 'Maintain stationary elbows throughout the range of motion.',
        ),
        ExerciseModel(
          id: 'ex_10',
          name: 'Overhead Tricep Extension',
          description:
              'Hold dumbbell overhead with both hands, lower behind head toward upper back, extend fully.',
          reps: 12,
          sets: 3,
          restSeconds: 30,
          imageUrl: '',
          tips: 'Keep elbows tucked pointing forward.',
        ),
      ],
    ),
    const WorkoutModel(
      id: 'w_03',
      title: 'Morning Vinyasa Flow',
      description:
          'Energizing yoga flow to awaken joints, lengthen tight hamstrings and hips, and cultivate mindful breath alignment.',
      category: 'Yoga',
      difficulty: WorkoutDifficulty.beginner,
      durationMinutes: 20,
      caloriesBurned: 130,
      imageUrl:
          'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?w=800&auto=format&fit=crop&q=80',
      equipment: ['Yoga Mat'],
      targetMuscles: ['Spine', 'Hamstrings', 'Hips', 'Shoulders'],
      isFeatured: true,
      rating: 4.9,
      exercises: [
        ExerciseModel(
          id: 'ex_11',
          name: 'Cat-Cow Spinal Waves',
          description:
              'On all fours, inhale as belly drops and gaze lifts; exhale as spine rounds toward ceiling.',
          durationSeconds: 60,
          imageUrl: '',
          tips: 'Synchronize movement with the natural rhythm of breath.',
        ),
        ExerciseModel(
          id: 'ex_12',
          name: 'Downward Facing Dog',
          description:
              'Lift hips high into inverted V, pressing through palms and pedaling out heels.',
          durationSeconds: 60,
          imageUrl: '',
          tips:
              'Keep spine long; feel free to bend knees slightly if hamstrings are tight.',
        ),
        ExerciseModel(
          id: 'ex_13',
          name: 'Sun Salutation A Flow',
          description:
              'Continuous sequence from mountain pose to forward fold, chaturanga, upward dog, and down dog.',
          reps: 5,
          sets: 1,
          durationSeconds: 180,
          imageUrl: '',
          tips: 'Flow seamlessly on each inhale and exhale.',
        ),
        ExerciseModel(
          id: 'ex_14',
          name: 'Warrior II Hold',
          description:
              'Deep lunge through front knee, arms parallel to ground, gaze focused over front fingertips.',
          durationSeconds: 60,
          imageUrl: '',
          tips: 'Root down firmly into the pinky edge of back foot.',
        ),
        ExerciseModel(
          id: 'ex_15',
          name: 'Child’s Pose Meditation',
          description:
              'Knees wide, big toes touching, chest resting on floor with arms reaching forward.',
          durationSeconds: 90,
          imageUrl: '',
          tips: 'Surrender all tension in hips and neck.',
        ),
      ],
    ),
    const WorkoutModel(
      id: 'w_04',
      title: 'Core & Six-Pack Shred',
      description:
          'Targeted abdominal workout isolating rectus abdominis, obliques, and transverse abdominis with zero back strain.',
      category: 'Core',
      difficulty: WorkoutDifficulty.intermediate,
      durationMinutes: 18,
      caloriesBurned: 160,
      imageUrl:
          'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=800&auto=format&fit=crop&q=80',
      equipment: ['Yoga Mat'],
      targetMuscles: ['Abs', 'Obliques', 'Lower Back', 'Hip Flexors'],
      isFeatured: false,
      rating: 4.7,
      exercises: [
        ExerciseModel(
          id: 'ex_16',
          name: 'Dead Bug Holds',
          description:
              'Opposite arm and leg lower toward floor while pressing lumbar spine flat against mat.',
          reps: 16,
          sets: 3,
          imageUrl: '',
          tips: 'Do not allow your lower back to arch off the floor.',
        ),
        ExerciseModel(
          id: 'ex_17',
          name: 'Bicycle Crunches',
          description:
              'Rotate torso driving opposite elbow to knee in controlled rotational rhythm.',
          reps: 20,
          sets: 3,
          imageUrl: '',
          tips: 'Focus on rotation from the ribs rather than pulling on neck.',
        ),
        ExerciseModel(
          id: 'ex_18',
          name: 'Forearm Plank',
          description:
              'Maintain straight board line from heels to crown of head with glutes squeezed.',
          durationSeconds: 60,
          sets: 3,
          imageUrl: '',
          tips: 'Push forearms into the floor to activate serratus anterior.',
        ),
        ExerciseModel(
          id: 'ex_19',
          name: 'Hanging / Lying Leg Raises',
          description:
              'Slowly raise legs up to 90 degrees and lower under 3-second control.',
          reps: 12,
          sets: 3,
          imageUrl: '',
          tips:
              'Stop just before heels tap the ground to maintain continuous tension.',
        ),
      ],
    ),
    const WorkoutModel(
      id: 'w_05',
      title: 'Cardio Kickboxing Sprint',
      description:
          'High energy striking and footwork workout that melts fat, improves coordination, and relieves daily stress.',
      category: 'Cardio',
      difficulty: WorkoutDifficulty.intermediate,
      durationMinutes: 30,
      caloriesBurned: 350,
      imageUrl:
          'https://images.unsplash.com/photo-1549576490-b0b4831ef60a?w=800&auto=format&fit=crop&q=80',
      equipment: ['None (Bodyweight)'],
      targetMuscles: ['Cardiovascular', 'Shoulders', 'Core', 'Calves'],
      isFeatured: true,
      rating: 4.8,
      exercises: [
        ExerciseModel(
          id: 'ex_20',
          name: 'Jab-Cross-Hook Combos',
          description:
              'Sharp punching combinations utilizing hip rotation for kinetic power transfer.',
          durationSeconds: 60,
          sets: 3,
          imageUrl: '',
          tips: 'Snap punches back to guard quickly after each extension.',
        ),
        ExerciseModel(
          id: 'ex_21',
          name: 'Front Kicks & Bob-and-Weave',
          description:
              'Alternate front push kicks followed by evasive duck and slips.',
          durationSeconds: 60,
          sets: 3,
          imageUrl: '',
          tips: 'Engage abs to chamber knee high before snapping foot.',
        ),
        ExerciseModel(
          id: 'ex_22',
          name: 'Speed Bag Arm Circles',
          description:
              'Rapid overhead circular hand rotations maintaining continuous shoulder activation.',
          durationSeconds: 45,
          sets: 3,
          imageUrl: '',
          tips: 'Stay light on your toes bouncing side to side.',
        ),
      ],
    ),
    const WorkoutModel(
      id: 'w_06',
      title: 'Lower Body Glute & Quad Builder',
      description:
          'Heavy compound lower body session focusing on hypertrophy, squat depth, and posterior chain stabilization.',
      category: 'Strength',
      difficulty: WorkoutDifficulty.advanced,
      durationMinutes: 40,
      caloriesBurned: 360,
      imageUrl:
          'https://images.unsplash.com/photo-1434682881908-b43d0467b798?w=800&auto=format&fit=crop&q=80',
      equipment: ['Dumbbells or Barbell', 'Resistance Band'],
      targetMuscles: ['Glutes', 'Quadriceps', 'Hamstrings', 'Calves'],
      isFeatured: false,
      rating: 4.9,
      exercises: [
        ExerciseModel(
          id: 'ex_23',
          name: 'Goblet Squats',
          description:
              'Hold dumbbell vertically at chest, break at hips and knees into deep below-parallel squat.',
          reps: 12,
          sets: 4,
          restSeconds: 60,
          imageUrl: '',
          tips: 'Drive knees outward tracking over second toe.',
        ),
        ExerciseModel(
          id: 'ex_24',
          name: 'Romanian Deadlifts',
          description:
              'Hinge hips backwards with slight knee bend until deep stretch is felt in hamstrings.',
          reps: 10,
          sets: 4,
          restSeconds: 60,
          imageUrl: '',
          tips: 'Keep weights close to shins and back neutral.',
        ),
        ExerciseModel(
          id: 'ex_25',
          name: 'Bulgarian Split Squats',
          description:
              'Rear foot elevated on bench, lower front thigh parallel to floor, drive through heel.',
          reps: 10,
          sets: 3,
          restSeconds: 45,
          imageUrl: '',
          tips: 'Keep torso upright or slightly leaned forward to bias glutes.',
        ),
      ],
    ),
    const WorkoutModel(
      id: 'w_07',
      title: 'Full Body Mobility & Stretch',
      description:
          'Gentle restorative mobility session targeting desk-worker posture, hip flexor tightness, and thoracic stiffness.',
      category: 'Stretching',
      difficulty: WorkoutDifficulty.beginner,
      durationMinutes: 15,
      caloriesBurned: 80,
      imageUrl:
          'https://images.unsplash.com/photo-1506126613408-eca07ce68773?w=800&auto=format&fit=crop&q=80',
      equipment: ['Yoga Mat'],
      targetMuscles: ['Thoracic Spine', 'Hip Flexors', 'Chest', 'Hamstrings'],
      isFeatured: false,
      rating: 4.8,
      exercises: [
        ExerciseModel(
          id: 'ex_26',
          name: 'World’s Greatest Stretch',
          description:
              'Deep lunge with elbow to inside of ankle, then rotate chest toward ceiling.',
          durationSeconds: 60,
          imageUrl: '',
          tips:
              'Spend extra seconds breathing into stiff corners of the stretch.',
        ),
        ExerciseModel(
          id: 'ex_27',
          name: 'Pigeon Pose',
          description:
              'Shin across front of mat, square hips to floor and slowly fold upper body forward.',
          durationSeconds: 60,
          imageUrl: '',
          tips: 'Never force knee; place block or pillow under hip if needed.',
        ),
        ExerciseModel(
          id: 'ex_28',
          name: 'Doorway Chest Stretch',
          description:
              'Place forearm against doorframe, step through gently opening anterior shoulder and pectorals.',
          durationSeconds: 45,
          imageUrl: '',
          tips: 'Keep shoulders relaxed down away from ears.',
        ),
      ],
    ),
    const WorkoutModel(
      id: 'w_08',
      title: 'Tabata Burn 4-Minute Protocol',
      description:
          'Scientifically validated 20 seconds maximum effort followed by 10 seconds rest across 8 grueling rounds.',
      category: 'HIIT',
      difficulty: WorkoutDifficulty.advanced,
      durationMinutes: 16,
      caloriesBurned: 220,
      imageUrl:
          'https://images.unsplash.com/photo-1517838277536-f5f99be501cd?w=800&auto=format&fit=crop&q=80',
      equipment: ['Timer', 'Mat'],
      targetMuscles: ['Full Body', 'Cardio Engine', 'Lungs'],
      isFeatured: false,
      rating: 4.7,
      exercises: [
        ExerciseModel(
          id: 'ex_29',
          name: 'Tabata High Knees',
          description:
              'Max speed high knee pumping for 20 seconds on, 10 seconds off.',
          durationSeconds: 20,
          restSeconds: 10,
          imageUrl: '',
        ),
        ExerciseModel(
          id: 'ex_30',
          name: 'Tabata Squat Thrusts',
          description:
              'Fast hands down, jump back to plank, jump in, stand tall.',
          durationSeconds: 20,
          restSeconds: 10,
          imageUrl: '',
        ),
      ],
    ),
    const WorkoutModel(
      id: 'w_09',
      title: 'Evening Relax & Unwind Yoga',
      description:
          'Calming bedtime flow to lower cortisol, release lumbar tightness, and prepare body for deep regenerative sleep.',
      category: 'Yoga',
      difficulty: WorkoutDifficulty.beginner,
      durationMinutes: 22,
      caloriesBurned: 95,
      imageUrl:
          'https://images.unsplash.com/photo-1506126613408-eca07ce68773?w=800&auto=format&fit=crop&q=80',
      equipment: ['Yoga Mat', 'Pillow'],
      targetMuscles: ['Nervous System', 'Hips', 'Spine', 'Neck'],
      isFeatured: false,
      rating: 4.9,
      exercises: [
        ExerciseModel(
          id: 'ex_31',
          name: 'Legs Up The Wall',
          description:
              'Lie flat with hips close to wall, extend legs vertically up wall with arms relaxed wide.',
          durationSeconds: 180,
          imageUrl: '',
          tips:
              'Slow down your exhalations to twice the length of inhalations.',
        ),
        ExerciseModel(
          id: 'ex_32',
          name: 'Reclining Butterfly Pose',
          description:
              'Soles of feet together, knees open wide, hands resting on belly and heart.',
          durationSeconds: 120,
          imageUrl: '',
          tips: 'Allow gravity to gently open the inner thighs.',
        ),
      ],
    ),
    const WorkoutModel(
      id: 'w_10',
      title: 'Kettlebell Complex Conditioning',
      description:
          'Explosive ballistic workout using kettlebell swings, cleans, and snatches for relentless total body conditioning.',
      category: 'Strength',
      difficulty: WorkoutDifficulty.advanced,
      durationMinutes: 32,
      caloriesBurned: 380,
      imageUrl:
          'https://images.unsplash.com/photo-1517838277536-f5f99be501cd?w=800&auto=format&fit=crop&q=80',
      equipment: ['Kettlebell (16-24kg)'],
      targetMuscles: ['Glutes', 'Hamstrings', 'Lats', 'Forearms', 'Core'],
      isFeatured: false,
      rating: 4.8,
      exercises: [
        ExerciseModel(
          id: 'ex_33',
          name: 'Two-Hand Russian Swings',
          description:
              'Hinge back deeply with bell between legs, pop hips explosively floating bell to chest height.',
          reps: 20,
          sets: 4,
          restSeconds: 45,
          imageUrl: '',
          tips:
              'Power comes from hips snapping forward, not your arms lifting.',
        ),
        ExerciseModel(
          id: 'ex_34',
          name: 'Kettlebell Clean and Press',
          description:
              'Clean bell to rack position at shoulder, press overhead in one smooth fluid motion.',
          reps: 8,
          sets: 3,
          restSeconds: 45,
          imageUrl: '',
        ),
      ],
    ),
    const WorkoutModel(
      id: 'w_11',
      title: 'Express 10-Minute Desk Break',
      description:
          'Quick standing workout designed to counteract sedentary stiffness, neck ache, and boost focus midday.',
      category: 'Stretching',
      difficulty: WorkoutDifficulty.beginner,
      durationMinutes: 10,
      caloriesBurned: 50,
      imageUrl:
          'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?w=800&auto=format&fit=crop&q=80',
      equipment: ['No Equipment'],
      targetMuscles: ['Neck', 'Upper Traps', 'Wrists', 'Lower Back'],
      isFeatured: false,
      rating: 4.6,
      exercises: [
        ExerciseModel(
          id: 'ex_35',
          name: 'Standing Side Bends & Chest Opener',
          description:
              'Interlace fingers behind back, open collarbones wide, gently lean side to side.',
          durationSeconds: 60,
          imageUrl: '',
        ),
        ExerciseModel(
          id: 'ex_36',
          name: 'Chair Squats & Calf Raises',
          description:
              'Tap chair with hips then stand up tall reaching on toes.',
          reps: 15,
          sets: 2,
          imageUrl: '',
        ),
      ],
    ),
    const WorkoutModel(
      id: 'w_12',
      title: '5K Runner Preparation Drills',
      description:
          'Cadence drills, single leg stability, and plyometrics to improve running economy and prevent runner’s knee.',
      category: 'Cardio',
      difficulty: WorkoutDifficulty.intermediate,
      durationMinutes: 25,
      caloriesBurned: 240,
      imageUrl:
          'https://images.unsplash.com/photo-1502680390469-be75c86b636f?w=800&auto=format&fit=crop&q=80',
      equipment: ['Running Shoes'],
      targetMuscles: ['Calves', 'Achilles', 'Glute Medius', 'Hip Flexors'],
      isFeatured: false,
      rating: 4.7,
      exercises: [
        ExerciseModel(
          id: 'ex_37',
          name: 'A-Skips & B-Skips',
          description:
              'High knee skip rhythm establishing sharp ankle dorsiflexion and foot strike.',
          durationSeconds: 60,
          sets: 3,
          imageUrl: '',
        ),
        ExerciseModel(
          id: 'ex_38',
          name: 'Single Leg Romanian Deadlift Hold',
          description:
              'Balance on one foot, hinge forward keeping hips square to floor.',
          reps: 10,
          sets: 3,
          imageUrl: '',
        ),
      ],
    ),
    const WorkoutModel(
      id: 'w_13',
      title: 'Power Pilates Sculpt',
      description:
          'Low-impact high-burn classical and contemporary mat Pilates sequence focusing on pelvic alignment and deep core tone.',
      category: 'Core',
      difficulty: WorkoutDifficulty.intermediate,
      durationMinutes: 30,
      caloriesBurned: 210,
      imageUrl:
          'https://images.unsplash.com/photo-1518611012118-696072aa579a?w=800&auto=format&fit=crop&q=80',
      equipment: ['Mat'],
      targetMuscles: ['Pelvic Floor', 'Transverse Abdominis', 'Glutes'],
      isFeatured: false,
      rating: 4.8,
      exercises: [
        ExerciseModel(
          id: 'ex_39',
          name: 'The Pilates Hundred',
          description:
              'Curl head and shoulders up, pump arms vigorously up and down inhaling for 5, exhaling for 5.',
          durationSeconds: 100,
          imageUrl: '',
        ),
        ExerciseModel(
          id: 'ex_40',
          name: 'Criss-Cross with Hold',
          description:
              'Slow rotational bicycle holds pausing for 2 seconds at each extension.',
          reps: 16,
          sets: 3,
          imageUrl: '',
        ),
      ],
    ),
    const WorkoutModel(
      id: 'w_14',
      title: 'Chest & Triceps Hypertrophy',
      description:
          'Classic push day routine targeting upper, middle, and lower pectorals along with long and lateral tricep heads.',
      category: 'Strength',
      difficulty: WorkoutDifficulty.intermediate,
      durationMinutes: 38,
      caloriesBurned: 310,
      imageUrl:
          'https://images.unsplash.com/photo-1581009146145-b5ef050c2e1e?w=800&auto=format&fit=crop&q=80',
      equipment: ['Dumbbells', 'Bench'],
      targetMuscles: ['Pectorals', 'Anterior Delts', 'Triceps'],
      isFeatured: false,
      rating: 4.7,
      exercises: [
        ExerciseModel(
          id: 'ex_41',
          name: 'Incline Dumbbell Flyes',
          description:
              'Arc dumbbells wide feeling deep stretch across chest before hugging back together.',
          reps: 12,
          sets: 3,
          imageUrl: '',
        ),
        ExerciseModel(
          id: 'ex_42',
          name: 'Diamond Push-Ups',
          description:
              'Hands together under center of chest forming diamond with thumbs and index fingers.',
          reps: 15,
          sets: 3,
          imageUrl: '',
        ),
      ],
    ),
    const WorkoutModel(
      id: 'w_15',
      title: 'Back & Bicep Pull Mastery',
      description:
          'Build a strong V-taper and powerful grip with compound pulling movements and isolated arm volume.',
      category: 'Strength',
      difficulty: WorkoutDifficulty.intermediate,
      durationMinutes: 36,
      caloriesBurned: 300,
      imageUrl:
          'https://images.unsplash.com/photo-1581009146145-b5ef050c2e1e?w=800&auto=format&fit=crop&q=80',
      equipment: ['Dumbbells', 'Pull-Up Bar or Bands'],
      targetMuscles: ['Latissimus Dorsi', 'Rhomboids', 'Biceps', 'Forearms'],
      isFeatured: false,
      rating: 4.9,
      exercises: [
        ExerciseModel(
          id: 'ex_43',
          name: 'Bent-Over Dumbbell Rows',
          description:
              'Hinge forward at 45 degrees, pull both dumbbells back into pockets with scapular squeeze.',
          reps: 12,
          sets: 4,
          imageUrl: '',
        ),
        ExerciseModel(
          id: 'ex_44',
          name: 'Hammer Curls',
          description:
              'Neutral grip dumbbell curl emphasizing the brachialis and forearm thickness.',
          reps: 12,
          sets: 3,
          imageUrl: '',
        ),
      ],
    ),
    const WorkoutModel(
      id: 'w_16',
      title: 'Low Impact Cardio Sweat',
      description:
          'Joint-friendly heart-rate builder without jumps or hard impacts. Perfect for apartments or knee sensitivity.',
      category: 'Cardio',
      difficulty: WorkoutDifficulty.beginner,
      durationMinutes: 24,
      caloriesBurned: 210,
      imageUrl:
          'https://images.unsplash.com/photo-1518611012118-696072aa579a?w=800&auto=format&fit=crop&q=80',
      equipment: ['No Equipment'],
      targetMuscles: ['Cardio System', 'Legs', 'Arms'],
      isFeatured: false,
      rating: 4.8,
      exercises: [
        ExerciseModel(
          id: 'ex_45',
          name: 'Step Jacks',
          description:
              'Step one foot out to side while sweeping arms overhead, alternating smoothly.',
          durationSeconds: 45,
          imageUrl: '',
        ),
        ExerciseModel(
          id: 'ex_46',
          name: 'Skater Steps without Jump',
          description: 'Diagonal step back and curtsy with wide reaching arms.',
          durationSeconds: 45,
          imageUrl: '',
        ),
      ],
    ),
    const WorkoutModel(
      id: 'w_17',
      title: 'Athletic Agility & Speed',
      description:
          'Fast-twitch neuromuscular workout enhancing multi-directional change of pace, balance, and reflexes.',
      category: 'HIIT',
      difficulty: WorkoutDifficulty.advanced,
      durationMinutes: 30,
      caloriesBurned: 330,
      imageUrl:
          'https://images.unsplash.com/photo-1517838277536-f5f99be501cd?w=800&auto=format&fit=crop&q=80',
      equipment: ['Agility Markers or Cones'],
      targetMuscles: ['Ankles', 'Quads', 'Core', 'Reflexes'],
      isFeatured: false,
      rating: 4.7,
      exercises: [
        ExerciseModel(
          id: 'ex_47',
          name: 'Lateral Shuffles with Floor Tap',
          description:
              'Shuffle three paces left, touch floor with fingertips, shuffle right.',
          durationSeconds: 45,
          imageUrl: '',
        ),
        ExerciseModel(
          id: 'ex_48',
          name: 'Single Leg Hop & Stick',
          description:
              'Hop forward landing on one foot, freezing in stable balance for 2 seconds.',
          reps: 10,
          sets: 3,
          imageUrl: '',
        ),
      ],
    ),
    const WorkoutModel(
      id: 'w_18',
      title: 'Deep Hip Opener & Release',
      description:
          'Long isometric holds targeting pelvic floor, psoas, and piriformis to unstick locked hips.',
      category: 'Stretching',
      difficulty: WorkoutDifficulty.intermediate,
      durationMinutes: 20,
      caloriesBurned: 90,
      imageUrl:
          'https://images.unsplash.com/photo-1506126613408-eca07ce68773?w=800&auto=format&fit=crop&q=80',
      equipment: ['Yoga Mat', 'Yoga Block'],
      targetMuscles: ['Hips', 'Psoas', 'Gluteus Medius', 'Groin'],
      isFeatured: false,
      rating: 4.9,
      exercises: [
        ExerciseModel(
          id: 'ex_49',
          name: 'Lizard Pose with Spinal Twist',
          description:
              'Step foot outside hands, lower back knee, rotate chest toward front thigh.',
          durationSeconds: 90,
          imageUrl: '',
        ),
        ExerciseModel(
          id: 'ex_50',
          name: 'Frog Pose',
          description:
              'Knees wide on mat, feet turned outward, gently sink hips backwards.',
          durationSeconds: 120,
          imageUrl: '',
        ),
      ],
    ),
    const WorkoutModel(
      id: 'w_19',
      title: 'Bodyweight Calisthenics Mastery',
      description:
          'Gymnastic-style progression utilizing only gravity and body leverage for foundational human strength.',
      category: 'Strength',
      difficulty: WorkoutDifficulty.intermediate,
      durationMinutes: 35,
      caloriesBurned: 290,
      imageUrl:
          'https://images.unsplash.com/photo-1581009146145-b5ef050c2e1e?w=800&auto=format&fit=crop&q=80',
      equipment: ['Pull Up Bar', 'Floor Mat'],
      targetMuscles: ['Back', 'Shoulders', 'Core', 'Grip'],
      isFeatured: false,
      rating: 4.8,
      exercises: [
        ExerciseModel(
          id: 'ex_51',
          name: 'Strict Pull-Ups',
          description:
              'Full dead hang to chin over bar with hollow body position.',
          reps: 8,
          sets: 4,
          imageUrl: '',
        ),
        ExerciseModel(
          id: 'ex_52',
          name: 'Parallel Bar / Bench Dips',
          description:
              'Lower until elbows reach 90 degrees, press powerfully through palms.',
          reps: 15,
          sets: 3,
          imageUrl: '',
        ),
      ],
    ),
    const WorkoutModel(
      id: 'w_20',
      title: 'Power Yoga for Athletes',
      description:
          'Challenging physical yoga practice incorporating arm balances, isometric lunges, and active core stability.',
      category: 'Yoga',
      difficulty: WorkoutDifficulty.advanced,
      durationMinutes: 40,
      caloriesBurned: 280,
      imageUrl:
          'https://images.unsplash.com/photo-1544367567-0f2fcb009e0b?w=800&auto=format&fit=crop&q=80',
      equipment: ['Yoga Mat'],
      targetMuscles: ['Full Body', 'Core', 'Shoulders', 'Legs'],
      isFeatured: false,
      rating: 4.9,
      exercises: [
        ExerciseModel(
          id: 'ex_53',
          name: 'Crow Pose (Bakasana)',
          description:
              'Knees tucked onto triceps, shift weight forward into palms and float toes up.',
          durationSeconds: 30,
          sets: 3,
          imageUrl: '',
        ),
        ExerciseModel(
          id: 'ex_54',
          name: 'Warrior III Dynamic Holds',
          description:
              'Balance on one leg forming horizontal T shape from fingertips to back heel.',
          durationSeconds: 45,
          sets: 3,
          imageUrl: '',
        ),
      ],
    ),
  ];
}
