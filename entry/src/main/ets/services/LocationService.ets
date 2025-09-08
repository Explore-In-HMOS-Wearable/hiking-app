import { geoLocationManager } from '@kit.LocationKit';
import { abilityAccessCtrl, common } from '@kit.AbilityKit';
import { mapCommon } from '@kit.MapKit';

export class LocationService {
  static async requestPermissions(): Promise<boolean> {
    const atManager = abilityAccessCtrl.createAtManager();
    try {
      const result = await atManager.requestPermissionsFromUser(getContext() as common.UIAbilityContext, [
        'ohos.permission.LOCATION',
        'ohos.permission.APPROXIMATELY_LOCATION'
      ]);
      return result.authResults.every((r) => r === 0);
    } catch (err) {
      console.error('Permission request failed:', err);
      return false;
    }
  }

  static async getCurrentLocationSafe(): Promise<mapCommon.LatLng> {
    const fallback: mapCommon.LatLng = {
      latitude: 41.02880769536224,
      longitude: 29.117448142218798
    };

    const granted = LocationService.requestPermissions();
    if (!granted) {
      console.warn('loc permission rejected.');
      return fallback;
    }

    try {
      const location = await geoLocationManager.getCurrentLocation();
      return {
        latitude: location.latitude,
        longitude: location.longitude
      };
    } catch (error) {
      console.error('location error:', error);
      return fallback;
    }
  }
}