// Money management strategy v1.1

#include <IMoneyManagementStrategy.mq4>
#include <IStopLossStrategy.mq4>
#include <ILotsProvider.mq4>
#include <ITakeProfitStrategy.mq4>

#ifndef MoneyManagementStrategy_IMP
#define MoneyManagementStrategy_IMP

class MoneyManagementStrategy : public IMoneyManagementStrategy
{
public:
   ILotsProvider* _lots;
   ITakeProfitStrategy* _takeProfit;
   IStopLossStrategy* _stopLoss;

   MoneyManagementStrategy(ILotsProvider* lots, IStopLossStrategy* stopLoss, ITakeProfitStrategy* takeProfit)
   {
      _lots = lots;
      _stopLoss = stopLoss;
      _takeProfit = takeProfit;
   }

   ~MoneyManagementStrategy()
   {
      delete _lots;
      delete _stopLoss;
      delete _takeProfit;
   }

   void Get(const int period, const double entryPrice, double &amount, double &stopLoss, double &takeProfit)
   {
      amount = _lots.GetValue(period, entryPrice);
      stopLoss = _stopLoss.GetValue(period, entryPrice);
      _takeProfit.GetTakeProfit(period, entryPrice, stopLoss, amount, takeProfit);
   }
};

#endif