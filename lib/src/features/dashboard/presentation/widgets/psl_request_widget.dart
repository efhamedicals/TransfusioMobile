import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:transfusio/src/core/routers/app_routers.dart';
import 'package:transfusio/src/core/utils/helpers/date_helper.dart';
import 'package:transfusio/src/core/utils/helpers/match_helper.dart';
import 'package:transfusio/src/shared/data/models/psl_request_model.dart';

class PslRequestWidget extends StatelessWidget {
  final PslRequestModel pslRequest;
  final Function? onBack;
  final bool isShowAction;

  const PslRequestWidget({
    super.key,
    required this.pslRequest,
    this.onBack,
    this.isShowAction = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppRouter.router.push(AppRouter.detailsPSLRequest, extra: pslRequest);
      },
      child: Card(
        child: ListTile(
          leading: const FaIcon(FontAwesomeIcons.file, size: 30),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  "Patient ${pslRequest.firstName!} ${pslRequest.lastName!}",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
          subtitle: Text(
            DateHelper.convertToDateTimeString(pslRequest.createdAt!),
          ),
          trailing: Container(
            width: 100,
            height: 40,
            padding: const EdgeInsets.all(5),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: MatchHelper.getColor(pslRequest),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              MatchHelper.getText(pslRequest),
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 11),
            ),
          ),
          titleAlignment: ListTileTitleAlignment.center,
        ),
      ),
    );
  }
}
