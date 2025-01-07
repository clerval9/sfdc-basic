public with sharing class DisabledSelectOptionComparator implements Comparator<SelectOption>{
    public DisabledSelectOptionComparator() {

    }

    public Integer compare(SelectOption option1, SelectOption option2) {
        if (option1.getDisabled() == option2.getDisabled()) {
            return 0;
        } else if (!option1.getDisabled()) {
            return -1;
        } else {
            return 1;
        }
    }
}