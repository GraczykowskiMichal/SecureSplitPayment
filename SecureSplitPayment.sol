pragma solidity ^0.4.11;

contract SecureSplitPayment {
    address[] receivers;
    bool locked;
    
    modifier noReentrancy() {
        require(!locked);
        locked = true;
        _;
        locked = false;
    }
    
    modifier atLeastOneReceiver() {
        require(receivers.length != 0);
        _;
    }
    
    modifier nonZeroValue(uint value) {
        require(value != 0);
        _;
    }
    
    function SecureSplitPayment(address[] _receivers) {
        receivers = _receivers;
    }
    
    function receivePayment() noReentrancy atLeastOneReceiver nonZeroValue(msg.value) payable {
        uint weiForEachReceiver = msg.value/receivers.length;
        for (uint i = 0; i < receivers.length; i++) {
            receivers[i].transfer(weiForEachReceiver);
        }
        //return what is left to the sender
        msg.sender.transfer(msg.value - (weiForEachReceiver * receivers.length));
    }
}
