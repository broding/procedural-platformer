package pcg
{
	public class WeaponStats
	{
		private var _damage:Number;
		private var _accuracy:Number;
		private var _headshotDamage:Number;
		private var _bulletSpeed:Number;
		private var _fireRate:Number;
		private var _magazineSize:uint;
		private var _reloadSpeed:Number;
		private var _weight:Number;
		
		public function WeaponStats(damage:Number = 10, accuracy:Number = 30, headshotDamage:Number = 40, bulletSpeed:Number = 500, fireRate:Number = 6, _magazineSize:uint = 30, _reloadSpeed:Number = 1.1, weigth:Number = 5.5)
		{
			_damage = damage;
			_accuracy = accuracy;
			_headshotDamage = headshotDamage;
			_bulletSpeed = bulletSpeed;
			_fireRate = fireRate;
			_magazineSize = magazineSize;
			_reloadSpeed = reloadSpeed;
			_weight = weight;
		}
		
		public function add(stats:WeaponStats):void
		{
			_damage += stats.damage;
			_accuracy += stats.accuracy;
			_bulletSpeed += stats.bulletSpeed;
			_fireRate += stats.fireRate;
			_magazineSize += stats.magazineSize;
			_reloadSpeed += stats.magazineSize;
			_weight += stats.weight;
		}
		
		public function copy():WeaponStats
		{
			return new WeaponStats(_damage, _accuracy, _headshotDamage, _bulletSpeed, _fireRate, _magazineSize, _reloadSpeed, _weight);
		}

		public function get damage():Number
		{
			return _damage;
		}

		public function get accuracy():Number
		{
			return _accuracy;
		}

		public function get bulletSpeed():Number
		{
			return _bulletSpeed;
		}

		public function get fireRate():Number
		{
			return _fireRate;
		}

		public function get magazineSize():uint
		{
			return _magazineSize;
		}

		public function get reloadSpeed():Number
		{
			return _reloadSpeed;
		}

		public function get weight():Number
		{
			return _weight;
		}

		public function get headshotDamage():Number
		{
			return _headshotDamage;
		}


	}
}