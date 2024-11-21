#ifndef aqlib_indexes_i
#define aqlib_indexes_i


%include ../indexes.i


// extend

%{
using QuantLib::BondIndex;
%}

%shared_ptr(BondIndex)

class BondIndex : public InterestRateIndex {
  public:
    BondIndex(const std::string& familyName,
              const Period& tenor,
              Integer settlementDays,
              const Currency& currency,
              const Calendar& calendar,
              const Period& fixedLegTenor,
              BusinessDayConvention fixedLegConvention,
              const DayCounter& fixedLegDayCounter,
              Real couponRate);
    BondIndex(const std::string& familyName,
              const Period& tenor,
              Integer settlementDays,
              const Currency& currency,
              const Calendar& calendar,
              const Period& fixedLegTenor,
              BusinessDayConvention fixedLegConvention,
              const DayCounter& fixedLegDayCounter,
              Real couponRate,
              const Handle<YieldTermStructure>& discountCurve);
    Period fixedLegTenor() const;
    BusinessDayConvention fixedLegConvention() const;
    Real Real couponRate() const;
    // ext::shared_ptr<IborIndex> iborIndex() const;
    Handle<YieldTermStructure> forwardingTermStructure() const;
    Handle<YieldTermStructure> discountingTermStructure() const;
    ext::shared_ptr<BondIndex> clone(const Handle<YieldTermStructure>& h) const;
    ext::shared_ptr<BondIndex> clone(const Handle<YieldTermStructure>& forwarding,
                                       const Handle<YieldTermStructure>& discounting) const;
    ext::shared_ptr<BondIndex> clone(const Period& tenor) const;
};

#if defined(SWIGCSHARP)
SWIG_STD_VECTOR_ENHANCED( ext::shared_ptr<BondIndex> )
#endif
namespace std {
    %template(BondIndexVector)
        vector<ext::shared_ptr<BondIndex> >;
}

%define export_swap_instance(Name)
%{
using QuantLib::Name;
%}
%shared_ptr(Name)
class Name : public BondIndex {
  public:
    Name(const Period &tenor,
         const Handle<YieldTermStructure>& h =
                                    Handle<YieldTermStructure>());
    Name(const Period &tenor,
         const Handle<YieldTermStructure>& h1,
         const Handle<YieldTermStructure>& h2);
};
%enddef

%define export_quoted_swap_instance(Name,Base)
%{
using QuantLib::Name;
%}
%shared_ptr(Name)
class Name : public Base {
  public:
    Name(const Handle<YieldTermStructure>& h =
                                    Handle<YieldTermStructure>());
    Name(const Handle<YieldTermStructure>& h1,
         const Handle<YieldTermStructure>& h2);
};
%enddef

%inline %{
    ext::shared_ptr<BondIndex> as_swap_index(
                          const ext::shared_ptr<InterestRateIndex>& index) {
        return ext::dynamic_pointer_cast<BondIndex>(index);
    }
%}

#endif
