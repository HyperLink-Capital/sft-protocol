pragma solidity ^0.4.24;

import "../STBase.sol";


contract CountryLockModule is STModuleBase {

  mapping (uint16 => uint256) public countryLock;

  function modifyCountryLock(uint16 _country, uint256 _epochTime) public onlyIssuer {
    countryLock[_country] = _epochTime;
  }

  function checkTransfer(address _from, address _to, uint256) external view returns (bool) {
    bytes32 _idFrom = registrar.getId(_from);
    bytes32 _idTo = registrar.getId(_to);
    require (countryLock[registrar.getCountry(_idFrom)] < now);
    require (countryLock[registrar.getCountry(_idTo)] < now);
  }

  function getBindings() external pure returns (bool, bool, bool) {
    return (true, false, false);
  }

}
