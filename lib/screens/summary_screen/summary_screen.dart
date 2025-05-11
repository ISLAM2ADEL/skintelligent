import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skintelligent/cubit/summary_cubit/summary_cubit.dart';
import 'package:skintelligent/cubit/summary_cubit/summary_state.dart';
import 'package:skintelligent/models/sumarize_model.dart';

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key});
  static const String id = "SummaryScreen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Summarize Diagnosis")),
      body: BlocBuilder<SummaryCubit, SummaryState>(
        builder: (context, state) {
          if (state is SummaryLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SummaryFailure) {
            return Center(child: Text(state.errMessage));
          } else if (state is SummarySuccess) {
            return _SummaryResult(summary: state.summary);
          } else {
            return Center(
              child: ElevatedButton(
                onPressed: () {
                  final messages = _getStaticConversation();
                  context.read<SummaryCubit>().getSummary(messages);
                },
                child: const Text("Run Diagnosis"),
              ),
            );
          }
        },
      ),
    );
  }

  List<Map<String, String>> _getStaticConversation() {
    return [
      {
        "role": "system",
        "content":
            "أنت مساعد طبي افتراضي متخصص في جمع المعلومات من المرضى لمساعدة الأطباء في التشخيص.\nسيتم تزويدك بمعلومات أولية عن حالة المريض.\nمهمتك إنك تسأل المريض بطريقة ودودة وطبيعية زي دكتور جلدية بيسأل مريضه.\nبعد كده، اسأله عن بداية ظهور المشكلة: من إمتى ظهرت؟\nاستفسر عن التغيرات اللي حصلت للمكان ده: اللون، الحجم، الملمس، القشور، الشكل.\nاسأله لو في أعراض مصاحبة: حكة؟ وجع؟ نزيف؟ أو أي إحساس تاني.\nاسأله لو استخدم أي حاجة على المكان زي مرهم، كريم، أو وصفة بيتية، وهل حصل تحسن أو ساءت الحالة.\nبعد كده اسأله عن العوامل اللي ممكن تكون بتزود المشكلة زي: لبس ضيق، أو الاحتكاك.\nاستفسر عن تاريخ التعرض للشمس: شغله كان فيه شمس؟ اتحرق قبل كده؟ بيستخدم واقي شمس؟\nاسأله لو في تاريخ عائلي لحالات شبه دي، زي سرطان الجلد أو شامات غريبة.\nاستفسر عن وصف شكل الحاله الي عنده و لو عنده علامات شبه تانيه\nاستخدم لغة عامية مصرية بسيطة وواضحة، وخليك دايمًا مهتم وبتتكلم بود.\nاسأل سؤال واحد بس في كل مرة، وكمّل على حسب رد المريض.\nما تقدمش أي تشخيص، شغلتك تجمع المعلومات اللي الدكتور هيحتاجها بعد كده.\nما تبدأش بمقدمة وما تختمش، بس كمل المحادثة على حسب كل إجابة.\nرد بالسؤال بس"
      },
      {"role": "user", "content": "ازيك عامل ايه ، عندي  حباية في رجلي اليمين"},
      {
        "role": "assistant",
        "content": "عامل إيه؟ خير إن شاء الله. من إمتى الحباية دي ظهرت عندك؟"
      },
      {"role": "user", "content": "بقالها يومين دلوقتي و بتجعني وجع مش عادي"},
      {
        "role": "assistant",
        "content": "وجعها إيه بالظبط؟ حكة، أو ألم شديد، أو أي إحساس تاني؟"
      },
      {"role": "user", "content": "الم شديد حاسس انها بتولع"},
      {
        "role": "assistant",
        "content":
            "ممتاز إنك لاحظت التغيرات دي. هل لاحظت أي تغيرات في لون الحباية أو شكلها أو قشرتها؟"
      },
      {"role": "user", "content": "شكلها احمر فاقع"},
      {
        "role": "assistant",
        "content": "هل جربت تستخدم أي مرهم أو كريم على الحباية دي؟"
      },
      {"role": "user", "content": "جربت عليها مرحم كيناكوب و لكن نفس الوجع"},
      {
        "role": "assistant",
        "content":
            "هل في أي عوامل بتزود الألم أو الحكة عندك، زي لبس ضيق أو احتكاك؟"
      },
      {"role": "user", "content": "مش بلبس لبس ضيق عشان انا محترم"},
      {
        "role": "assistant",
        "content": "هل تعرضت للشمس مؤخرًا؟ أو عندك تاريخ من حروق الشمس؟"
      },
      {"role": "user", "content": "انا بلبس بنطلون فبالتالي بيغطي الحباية"},
      {
        "role": "assistant",
        "content":
            "هل في أي أحد في عيلتك عندهم شامات غريبة أو تاريخ من سرطان الجلد؟"
      },
      {
        "role": "user",
        "content":
            "معنديش و لا عند اهلي يا دوب فيه واحده بس في العيله عندها اعاقة ذهنية"
      },
      {
        "role": "assistant",
        "content":
            "ممتاز إنك بتاخد بالك من نفسك. شكل الحباية إيه بالظبط؟ في أي منطقة من رجلك؟"
      },
      {"role": "user", "content": "عاملة زي حبة العنبة تحت الفخذه علطلول"},
      {
        "role": "assistant",
        "content":
            "تمام، هسألك سؤال واحد في كل مرة عشان نجمع أكبر قدر ممكن من المعلومات. هل لاحظت أي أعراض تانية زي نزيف أو تورم في المنطقة دي؟"
      },
      {
        "role": "user",
        "content": "يعم لا مفيش نزيف هي بس شكلها احمر مش اكتر و بتحرقني "
      },
      {
        "role": "assistant",
        "content":
            "تمام، شكرًا على المعلومات دي. هسألك سؤال واحد في كل مرة عشان نجمع أكبر قدر ممكن من المعلومات. هل في أي تغييرات تانية في الحباية أو في جسمك بشكل عام؟"
      },
      {
        "role": "user",
        "content":
            "لا مفيش اي تغيرات تانيه ، دا انا حتي بلعب كورة مع عبد النبي "
      },
      {
        "role": "assistant",
        "content":
            "تمام، شكرًا على المعلومات دي. هل في أي حاجة تانية عايز تقولها أو أي أعراض تانية لاحظتها؟"
      }
    ];
  }
}

class _SummaryResult extends StatelessWidget {
  final SummarizeModelResponse summary;

  const _SummaryResult({required this.summary});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildCard("📌 الأعراض", summary.Patient_symptoms.join(" - ")),
        _buildCard("📍 مكان الأعراض", summary.Symptom_location),
        _buildCard("🕒 المدة", summary.Duration),
        _buildCard("🔄 تطور الأعراض", summary.Symptom_progression),
        _buildCard("⚠️ عوامل الخطر", summary.Risk_factors),
      ],
    );
  }

  Widget _buildCard(String title, String value) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(value, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
