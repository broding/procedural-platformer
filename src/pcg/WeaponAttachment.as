package pcg
{
	public class WeaponAttachment extends WeaponStats
	{
		public function WeaponAttachment(damage:Number = 0, accuracy:Number = 0, headshotDamage:Number = 0, bulletSpeed:Number = 0, fireRate:Number = 0, magazineSize:uint = 0, reloadSpeed:Number = 0, weigth:Number = 0)
		{
			super(damage, accuracy, headshotDamage, bulletSpeed, fireRate, magazineSize, reloadSpeed, weight);
		}
	}
}