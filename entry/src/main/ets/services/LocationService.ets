import { geoLocationManager } from '@kit.LocationKit';
import { abilityAccessCtrl, common } from '@kit.AbilityKit';
import { mapCommon } from '@kit.MapKit';
import { UIContext } from '@kit.ArkUI';

export class LocationService {
  static async requestPermissions(uiContext: UIContext): Promise<boolean> {
    const hostContext = uiContext.getHostContext() as common.UIAbilityContext;
    const atManager = abilityAccessCtrl.createAtManager();
    try {
      const result = await atManager.requestPermissionsFromUser(hostContext, [
        'ohos.permission.LOCATION',
        'ohos.permission.APPROXIMATELY_LOCATION'
      ]);
      return result.authResults.every((r) => r === 0);
    } catch (err) {
      console.error('Permission request failed:', err);
      return false;
    }
  }

  static async getCurrentLocationSafe(uiContext: UIContext): Promise<mapCommon.LatLng> {
    const fallback: mapCommon.LatLng = {
      latitude: 41.02880769536224,
      longitude: 29.117448142218798
    };

    const granted = await LocationService.requestPermissions(uiContext);
    if (!granted) {
      console.warn('Location permission rejected.');
      return fallback;
    }

    try {
      const location = await geoLocationManager.getCurrentLocation();
      return {
        latitude: location.latitude,
        longitude: location.longitude
      };
    } catch (error) {
      console.error('Location error:', error);
      return fallback;
    }
  }
}