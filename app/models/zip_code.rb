class ZipCode < ActiveRecord::Base
  attr_accessible :AreaCode, :CarrierRouteRateSortation, :City, :CityAliasAbbreviation, :CityAliasCode, :CityAliasMixedCase, :CityAliasName, :CityDeliveryIndicator, :CityMixedCase, :CityStateKey, :CityType, :ClassificationCode, :County, :CountyANSI, :CountyFIPS, :DayLightSaving, :Elevation, :FacilityCode, :FinanceNumber, :Latitude, :Longitude, :MultiCounty, :PreferredLastLineKey, :PrimaryRecord, :State, :StateANSI, :StateFIPS, :TimeZone, :UniqueZIPName, :ZipCode


def zipcode_zipcode
  zipcode.try(:zipcode)
end

def zipcode_zipcode=(zipcode)
  self.category = Category.find_or_create_by_zipcode(zipcode) if zipcode.present?
end
end
