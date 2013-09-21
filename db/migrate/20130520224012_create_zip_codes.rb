class CreateZipCodes < ActiveRecord::Migration
  def change
    create_table :zip_codes do |t|
      t.string :ZipCode
      t.string :City
      t.string :State
      t.string :County
      t.string :AreaCode
      t.string :CityType
      t.string :CityAliasAbbreviation
      t.string :CityAliasName
      t.string :Latitude
      t.string :Longitude
      t.string :TimeZone
      t.integer :Elevation
      t.string :CountyFIPS
      t.string :DayLightSaving
      t.string :PreferredLastLineKey
      t.string :ClassificationCode
      t.string :MultiCounty
      t.string :StateFIPS
      t.string :CityStateKey
      t.string :CityAliasCode
      t.string :PrimaryRecord
      t.string :CityMixedCase
      t.string :CityAliasMixedCase
      t.string :StateANSI
      t.string :CountyANSI
      t.string :FacilityCode
      t.string :CityDeliveryIndicator
      t.string :CarrierRouteRateSortation
      t.string :FinanceNumber
      t.string :UniqueZIPName

      t.timestamps
    end
  end
end
