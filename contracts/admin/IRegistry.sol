pragma solidity ^0.5.0;

/**
 * @title IRegistry
 * @dev This contract represents the interface of a registry contract
 */
interface IRegistry {
  /**
  * @dev This event will be emitted every time a new proxy is created
  * @param proxy representing the address of the proxy created
  */
  event ProxyCreated(address proxy);

  /**
  * @dev This event will be emitted every time a new implementation of a function is registered
  * @param version representing the version name of the registered implementation
  * @param func representing the signature of the function implementation registered
  * @param implementation representing the address of the registered implementation
  */
  event VersionAdded(string version, bytes4 func, address implementation);

  /**
  * @dev This event will be emitted every time a new implementation of a fallback function is registered
  * @param version representing the version name of the registered implementation
  * @param implementation representing the address of the registered implementation
  */
  event FallbackAdded(string version, address implementation);

  /**
  * @dev Registers a new version of a function with its implementation address
  * @param version representing the version name of the new function implementation to be registered
  * @param func representing the name of the function to be registered
  * @param implementation representing the address of the new function implementation to be registered
  */
  function addVersionFromName(string calldata  version, string calldata  func, address implementation) external;

  /**
  * @dev Registers a new version of a function with its implementation address
  * @param version representing the version name of the new function implementation to be registered
  * @param func representing the signature of the function to be registered
  * @param implementation representing the address of the new function implementation to be registered
  */
  function addVersion(string calldata  version, bytes4 func, address implementation) external;

  /**
  * @dev Tells the address of the function implementation for a given version
  * @param version representing the version of the function implementation to be queried
  * @param func representing the signature of the function to be queried
  * @return address of the function implementation registered for the given version
  */
  function getFunction(string calldata  version, bytes4 func) external view returns (address);

  /**
   * @dev Returns a function name and implementation for a given version, given its index
   */
  function getFunctionByIndex(string calldata  version, uint256 index) external view returns (bytes4, address);

  /**
   * @dev Returns the number of functions (excluding the fallback function) registered for a specific version
   */
  function getFunctionCount(string calldata  version) external view returns (uint256);

  /**
   * @dev Returns the the fallback function for a specific version, if registered
   */
  function getFallback(string calldata  version) external view returns (address);
}
