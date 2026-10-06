import 'package:flutter/material.dart';
import 'package:mesmari_shared/core/core.dart';

/// Teacher payments and earnings.
class EarningsScreen extends StatelessWidget {
  const EarningsScreen({super.key});

  List<(String, String, String, bool)> get _transactions => [
    (tr('c_tx_enrol_basics'), tr('c_date_sep_2'), '+ 25,000', true),
    (tr('c_tx_enrol_web'), tr('c_date_aug_31'), '+ 25,000', true),
    (tr('c_tx_withdraw'), tr('c_date_aug_28'), '- 150,000', false),
    (tr('c_tx_enrol_basics'), tr('c_date_aug_26'), '+ 25,000', true),
  ];

  Future<void> _withdraw(BuildContext context) async {
    final method = await showOptionsSheet(
      context,
      title: tr('withdraw'),
      options: [
        SheetOption(Icons.account_balance_wallet_outlined, tr('zain_cash')),
        SheetOption(Icons.phone_iphone, tr('asia_hawala')),
        SheetOption(Icons.account_balance_outlined, tr('bank_account')),
      ],
    );
    if (method != null && context.mounted) {
      showSnack(context, '${tr('withdraw_requested')} $method');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      title: tr('payments'),
      content: [
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: const LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Color(0xFF164A4A), Color(0xFF277870)],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                tr('current_balance'),
                style: almarai(12, color: const Color(0xFFDADADA)),
              ),
              const SizedBox(height: 6),
              Text(
                tr('c_balance'),
                style: almarai(24, weight: extraBold, color: Colors.white),
              ),
              const SizedBox(height: 14),
              GestureDetector(
                onTap: () => _withdraw(context),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 11),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    tr('withdraw'),
                    style: tajawal(
                      13,
                      weight: extraBold,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: StatBox(
                value: '120,000',
                label: tr('month_earnings'),
                height: 70,
                useCairo: false,
              ),
            ),
            SizedBox(width: 6),
            Expanded(
              child: StatBox(
                value: '58',
                label: tr('enrolled_students'),
                height: 70,
                useCairo: false,
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        SectionTitle(tr('recent_transactions')),
        for (final (title, date, amount, incoming) in _transactions)
          AppCard(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(
              children: [
                Container(
                  width: 34,
                  height: 34,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: incoming ? AppColors.mint : AppColors.dangerBg,
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Icon(
                    incoming ? Icons.south_west : Icons.north_east,
                    size: 16,
                    color: incoming ? AppColors.primary : AppColors.danger,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: almarai(12, weight: bold, color: AppColors.text),
                      ),
                      Text(date, style: almarai(10, color: AppColors.muted)),
                    ],
                  ),
                ),
                Text(
                  amount,
                  textDirection: TextDirection.ltr,
                  style: almarai(
                    12,
                    weight: bold,
                    color: incoming ? AppColors.teal : AppColors.danger,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
