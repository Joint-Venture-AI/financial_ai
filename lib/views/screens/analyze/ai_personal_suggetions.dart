import 'package:financial_ai_mobile/core/helper/widget_helper.dart';
import 'package:financial_ai_mobile/core/utils/app_styles.dart';
import 'package:flutter/material.dart';

class AiPersonalSuggetions extends StatelessWidget {
  const AiPersonalSuggetions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.bgColor,
      appBar: WidgetHelper.showAppBar(
        isBack: true,
        title: 'Ai Optimizes',
        isCenter: false,
        showActions: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildTitle('1. Budgeting Strategy'),
          _buildParagraph(
            'You should advise users to track their income and expenses to create a clear budget. Use the 50/30/20 Rule as a starting point:',
          ),
          _buildBulletList([
            '50% Needs: Rent, bills, groceries, essentials',
            '30% Wants: Entertainment, dining out, shopping',
            '20% Savings & Debt Repayment:\n   Emergency fund, investments, paying off loans',
          ]),
          _buildTip(
            'Use budgeting apps (like Mint, YNAB, or PocketGuard) to automate expense tracking.',
          ),

          const SizedBox(height: 16),
          _buildTitle('2. Cutting Unnecessary Expenses'),
          _buildChecklist([
            'Tracking Subscriptions – Cancel unused ones',
            'Eating Out Less – Cook at home, limit takeouts',
            'Smart Shopping – Use cashback offers, buy in bulk',
            'Using Public Transport – Save on gas & maintenance',
            'Energy Efficiency – Reduce electricity bills',
          ]),
          _buildTip(
            'AI-powered finance apps can suggest cost-cutting strategies based on spending habits.',
          ),

          const SizedBox(height: 16),
          _buildTitle('3. Building an Emergency Fund'),
          _buildParagraph(
            'Encourage users to save at least 3–6 months’ worth of expenses in a separate savings account.',
          ),
          _buildLightbulbTitle('Best Way to Do This:'),
          _buildBulletList([
            'Automate savings (set up a fixed amount to transfer monthly)',
            'Start small (even \$50 per month adds up)',
            'Keep it liquid (in an easily accessible bank account)',
          ]),
          _buildTip('High-yield savings accounts help money grow faster.'),

          const SizedBox(height: 16),
          _buildTitle('4. Smart Saving & Investing'),
          _buildParagraph(
            'Once expenses are controlled, guide users to invest their savings instead of just keeping them idle.',
          ),
          _buildMoneyBagTitle('Low-Risk Options:'),
          _buildBulletList([
            'Fixed deposits',
            'Government bonds',
            'High-yield savings accounts',
          ]),
          _buildChartTitle('Long-Term Growth Options:'),
          _buildBulletList([
            'Index funds (S&P 500)',
            'Stocks & ETFs',
            'Real estate',
            'Crypto (for risk-tolerant users)',
          ]),
          _buildTip(
            'AI financial tools (like Robo-advisors) can automate investing based on risk levels.',
          ),
        ],
      ),
    );
  }

  Widget _buildTitle(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildParagraph(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(text, style: const TextStyle(fontSize: 16)),
    );
  }

  Widget _buildBulletList(List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
          items.map((e) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Text('• $e', style: const TextStyle(fontSize: 16)),
            );
          }).toList(),
    );
  }

  Widget _buildChecklist(List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
          items.map((e) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('✅ ', style: TextStyle(fontSize: 16)),
                  Expanded(
                    child: Text(e, style: const TextStyle(fontSize: 16)),
                  ),
                ],
              ),
            );
          }).toList(),
    );
  }

  Widget _buildTip(String tip) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('📌 ', style: TextStyle(fontSize: 16)),
          Expanded(
            child: Text('Tip: $tip', style: const TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }

  Widget _buildLightbulbTitle(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          const Text('💡 ', style: TextStyle(fontSize: 16)),
          Text(
            text,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildMoneyBagTitle(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          const Text('💰 ', style: TextStyle(fontSize: 16)),
          Text(
            text,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildChartTitle(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          const Text('📈 ', style: TextStyle(fontSize: 16)),
          Text(
            text,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
