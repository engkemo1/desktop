// lib/screens/add_screen/widgets/measurements_section.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../constants.dart';
import '../cubit/add_invoice_cubit.dart';

class MeasurementsSection extends StatelessWidget {
  const MeasurementsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddInvoiceCubit>();

    return Container(
      padding: const EdgeInsets.all(14),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.8),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(children: const [
            Expanded(child: Divider(color: Colors.white70)),
            SizedBox(width: 8),
            Text("المقاسات", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
            SizedBox(width: 8),
            Expanded(child: Divider(color: Colors.white70)),
          ]),
          const SizedBox(height: 10),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _smallField("عدد الاثواب", cubit.numDressesController),
              _smallField("الطول", cubit.lengthController),
              _smallField("الكتف", cubit.ketfLengthController),
              _smallField("طول الكم", cubit.komLengthController),
              _smallField("وسع الصدر", cubit.chestLengthController),
              _smallField("الرقبة", cubit.neckController),
            ],
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _wideField("وسع اليد", cubit.hand1LengthController, second: cubit.hand2LengthController),

              _groupedField("طول الكبك", cubit.k1LengthController, extra: cubit.k2LengthController),
              _groupedField("سقوط التقويرة", cubit.taqwera1LengthController, extra2: cubit.taqwera2LengthController, extra3: cubit.taqwera3LengthController),
              _groupedField("مقاس البدن", cubit.badnLengthController1, extra2: cubit.badnLengthController2, extra3: cubit.badnLengthController3),
            ],
          )
        ],
      ),
    );
  }

  Widget _smallField(String label, TextEditingController ctrl) {
    return SizedBox(
      width: 160,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label, style: const TextStyle(color: Colors.white70)),
        const SizedBox(height: 6),
        TextFormField(
          controller: ctrl,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            filled: true,
            fillColor: buttonColor,
            hintText: 'ادخل',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
            contentPadding: const EdgeInsets.symmetric(vertical: 12),
          ),
        )
      ]),
    );
  }

  Widget _wideField(
      String label,
      TextEditingController first, {
        TextEditingController? second,
      }) {
    return SizedBox(
      width: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.white70)),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 6),
            decoration: BoxDecoration(
              color: buttonColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                _centeredTextField(first),
                if (second != null) ...[
                  Divider(color: Colors.black38,),
                  const SizedBox(height: 8),
                  _centeredTextField(second),
                ]
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _centeredTextField(TextEditingController ctrl) {
    return TextFormField(
      controller: ctrl,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      decoration: const InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.symmetric(vertical: 12)),
      style: const TextStyle(fontWeight: FontWeight.bold),
    );
  }

  Widget _groupedField(String label, TextEditingController main, {TextEditingController? extra, TextEditingController? extra2, TextEditingController? extra3}) {
    return SizedBox(
      width: 150,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label, style: const TextStyle(color: Colors.white70)),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(color: buttonColor, borderRadius: BorderRadius.circular(8)),
          child: Column(
            children: [
              _centeredTextField(main),

              if (extra != null)...[
                Divider(color: Colors.black38,),

                _centeredTextField(extra),
              ] ,
              if (extra2 != null)...[
                Divider(color: Colors.black38,),

                _centeredTextField(extra2),
              ] ,
              if (extra3 != null)...[
                Divider(color: Colors.black38,),

                _centeredTextField(extra3),
              ] ,

            ],
          ),
        )
      ]),
    );
  }
}
