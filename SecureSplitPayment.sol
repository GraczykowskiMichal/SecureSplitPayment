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
    
    function SecureSplitPayment(address[] _receivers) {
        receivers = _receivers;
    }
    
    function receivePayment() noReentrancy payable {
        if (receivers.length == 0 || msg.value == 0) {
            return;
        } else {
            uint weiForEachReceiver = msg.value/receivers.length;
            for (uint i = 0; i < receivers.length; i++) {
                receivers[i].transfer(weiForEachReceiver);
            }
            //transfer what is left to the first receiver
            receivers[0].transfer(msg.value - (weiForEachReceiver * receivers.length));
        }
    }
}
