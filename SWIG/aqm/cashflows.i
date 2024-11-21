#ifndef aqm_cashflows_i
#define aqm_cashflows_i


%include ../cashflows.i
%include indexes.i


// extend

%{
using QuantLib::CmtCoupon;
using QuantLib::BondIndex;
%}

%shared_ptr(CmtCoupon)
class CmtCoupon : public FloatingRateCoupon {
    #if !defined(SWIGJAVA) && !defined(SWIGCSHARP)
    %feature("kwargs") CmtCoupon;
    #endif
  public:
    CmtCoupon(const Date& paymentDate, 
              Real nominal,
              const Date& startDate, const Date& endDate,
              const Date& fixingDate, 
              const ext::shared_ptr<BondIndex>& index,
              Real gearing = 1.0, Spread spread = 0.0,
              const Date& refPeriodStart = Date(),
              const Date& refPeriodEnd = Date(),
              const DayCounter& dayCounter = DayCounter(),
              bool isInArrears = false,
              const Date& exCouponDate = Date());

};

#endif
