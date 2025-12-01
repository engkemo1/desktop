import 'package:carousel_slider/carousel_slider.dart'
    show CarouselSlider, CarouselOptions, CarouselSliderController;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../constants.dart';
import '../cubit/add_invoice_cubit.dart';
import '../data/image_lists.dart';
import 'additions_bottom_buttons.dart';

class AdditionsSection extends StatefulWidget {
  const AdditionsSection({super.key});

  @override
  State<AdditionsSection> createState() => _AdditionsSectionState();
}

class _AdditionsSectionState extends State<AdditionsSection> {
  final lists = ImageLists();

  // Correct controller for carousel_slider 5.1.1
  final CarouselSliderController sadrController = CarouselSliderController();
  final CarouselSliderController yaqaController = CarouselSliderController();
  final CarouselSliderController komController = CarouselSliderController();
  final CarouselSliderController glabController = CarouselSliderController();
  final CarouselSliderController ganbController = CarouselSliderController();
  final CarouselSliderController gybController = CarouselSliderController();
  final CarouselSliderController taqweraController = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AddInvoiceCubit>();
    print(cubit.komPath);
    return Column(
      children: [
        const SizedBox(height: 10),
        const Row(
          children: [
            Expanded(child: Divider(color: Colors.white)),
            Text("     الاضافات    ",
                style: TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                    fontSize: 16)),
            Expanded(child: Divider(color: Colors.white)),
          ],
        ),

        // Expansion
        ExpansionTile(
          shape: InputBorder.none,
          collapsedBackgroundColor: buttonColor,
          backgroundColor: buttonColor,
          title: const Text(
            " اضفط هنا لظهور الاضافات ",
            style: TextStyle(
                color: Colors.black54,
                fontWeight: FontWeight.w500,
                fontSize: 18),
          ),
          children: [
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/login.jpg"), fit: BoxFit.cover),
              ),
              child: Container(
                color: Colors.black.withOpacity(0.8),
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                alignment: Alignment.center,
                child: Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    /// SDR
                    _carouselWithField(
                      carousel: CarouselSlider(
                        items: lists.list6
                            .map((p) => lists.imageWidget(p))
                            .toList(),
                        carouselController: sadrController,
                        options: CarouselOptions(
                          onPageChanged: (i, r) => cubit.selectSadr(i),
                          enlargeCenterPage: true,
                          viewportFraction: 1,
                          aspectRatio: 1.0,
                          autoPlay: false,
                          initialPage: lists.list6.indexOf(cubit.sadrPath ?? ""),
                        ),
                      ),
                      controller: sadrController,
                      textFieldController: cubit.sadrController,
                    ),

                    /// KOM
                    _carouselWithField(
                      carousel: CarouselSlider(
                        items: lists.list7
                            .map((p) => lists.imageWidget(p))
                            .toList(),
                        carouselController: komController,
                        options: CarouselOptions(
                          onPageChanged: (i, r) => cubit.selectKom(i),
                          viewportFraction: 1,
                          enlargeCenterPage: true,
                          autoPlay: false,
                          aspectRatio: 1.0,
                          initialPage: lists.list7.indexOf(cubit.komPath ?? ""),
                        ),
                      ),
                      controller: komController,
                      textFieldController: cubit.komController,
                    ),

                    /// GLAB
                    _carouselWithField(
                      carousel: CarouselSlider(
                        items: lists.list3
                            .map((p) => lists.imageWidget(p))
                            .toList(),
                        carouselController: glabController,
                        options: CarouselOptions(
                          onPageChanged: (i, r) => cubit.selectGlab(i),
                          viewportFraction: 1,
                          enlargeCenterPage: true,
                          aspectRatio: 1.0,
                          initialPage: lists.list3.indexOf(cubit.glabPath ?? ""),
                        ),
                      ),
                      controller: glabController,
                      textFieldController: cubit.glabController,
                    ),

                    /// GANB
                    _carouselWithField(
                      carousel: CarouselSlider(
                        items: lists.list4
                            .map((p) => lists.imageWidget(p))
                            .toList(),
                        carouselController: ganbController,
                        options: CarouselOptions(
                          onPageChanged: (i, r) => cubit.selectGanb(i),
                          viewportFraction: 1,
                          enlargeCenterPage: true,
                          autoPlay: false,
                          aspectRatio: 1.0,
                          initialPage: lists.list4.indexOf(cubit.ganbPath ?? ""),
                        ),
                      ),
                      controller: ganbController,
                      textFieldController: cubit.ganbController,
                    ),

                    /// GYB
                    _carouselWithField(
                      carousel: CarouselSlider(
                        items: lists.list5
                            .map((p) => lists.imageWidget(p))
                            .toList(),
                        carouselController: gybController,
                        options: CarouselOptions(
                          onPageChanged: (i, r) => cubit.selectGyb(i),
                          viewportFraction: 1,
                          enlargeCenterPage: true,
                          autoPlay: false,
                          aspectRatio: 1.0,
                          initialPage: lists.list5.indexOf(cubit.gybPath ?? ""),
                        ),
                      ),
                      controller: gybController,
                      textFieldController: cubit.gybController,
                    ),

                    /// TAQWERA
                    _carouselWithField(
                      carousel: CarouselSlider(
                        items: lists.list1
                            .map((p) => lists.imageWidget(p))
                            .toList(),
                        carouselController: taqweraController,
                        options: CarouselOptions(
                          onPageChanged: (i, r) => cubit.selectTaqwera(i),
                          viewportFraction: 1,
                          enlargeCenterPage: true,
                          autoPlay: false,
                          aspectRatio: 1.0,
                          initialPage: lists.list1.indexOf(cubit.taqweraPath ?? ""),
                        ),
                      ),
                      controller: taqweraController,
                      textFieldController: cubit.taqweraController,
                    ),

                    /// YAQA
                    _carouselWithField(
                      carousel: CarouselSlider(
                        items: lists.list2
                            .map((p) => lists.imageWidget(p))
                            .toList(),
                        carouselController: yaqaController,
                        options: CarouselOptions(
                          onPageChanged: (i, r) => cubit.selectYaqa(i),
                          viewportFraction: 1,
                          enlargeCenterPage: true,
                          autoPlay: false,
                          aspectRatio: 1.0,
                          initialPage: lists.list2.indexOf(cubit.yaqaPath ?? ""),
                        ),
                      ),
                      controller: yaqaController,
                      textFieldController: cubit.ya2aController,
                    ),

                    /// Image with positioned fields
                    _positionedImageWithFields(
                      imagePath: "images/new.png",
                      controllers: [
                        cubit.field1Controller,
                        cubit.field2Controller,
                        cubit.field3Controller,
                        cubit.field4Controller
                      ],
                    ),

                    _positionedImageWithFields(
                      imagePath: "images/كم-بلدي1.png",
                      controllers: [
                        cubit.fieldKom1Controller,
                        cubit.fieldKom2Controller,
                        cubit.fieldKom3Controller,
                        cubit.fieldKom4Controller
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ],
    );
  }

  // ----------------------------
  Widget _carouselWithField({
    required CarouselSlider carousel,
    required CarouselSliderController controller,
    TextEditingController? textFieldController,
  }) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        color: accentCanvasColor.withOpacity(0.8),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          carousel,
          Row(
            children: [
              IconButton(
                onPressed: () => controller.nextPage(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.linear,
                ),
                icon:
                    const Icon(Icons.arrow_back, color: Colors.white, size: 30),
              ),
              Expanded(
                child: TextField(
                  controller: textFieldController,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'ادخل المقاس',
                    prefixIcon: Icon(
                      Icons.format_size,
                      color: Colors.white70,
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () => controller.previousPage(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.linear,
                ),
                icon: const Icon(Icons.arrow_forward,
                    color: Colors.white, size: 30),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ----------------------------
  Widget _positionedImageWithFields({
    required String imagePath,
    required List<TextEditingController> controllers,
  }) {
    print(controllers[0].text);
    return Container(
      width: 300,
      decoration: BoxDecoration(
        color: accentCanvasColor.withOpacity(0.8),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(imagePath),
          ),
          if (controllers.length > 0)
            Positioned(
                top: 60, right: 13, child: _positionedField(controllers[0])),
          if (controllers.length > 1)
            Positioned(
                top: 60, right: 120, child: _positionedField(controllers[1])),
          if (controllers.length > 2)
            Positioned(
                top: 60, left: 17, child: _positionedField(controllers[2])),
          if (controllers.length > 3)
            Positioned(
              top: 165,
              right: 30,
              child: _positionedField(controllers[3]),
            ),
        ],
      ),
    );
  }

  Widget _positionedField(TextEditingController controller) {
    print(controller.text);
    return SizedBox(
      height: 50,
      width: 60,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: TextField(
          controller: controller,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          decoration: const InputDecoration(
            border: InputBorder.none,
          ),
          keyboardType: TextInputType.number,
        ),
      ),
    );
  }
}
