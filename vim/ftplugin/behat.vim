if match(expand('%:p:h'), 'jirafe\/platform-testing/') != -1
    if match(expand('%:h'), 'magento-plugin') != -1
        let b:behat_cmd_args = '-c magento-plugin/behat.yml'
    elseif match(expand('%:h'), 'prestashop-plugin') != -1
        let b:behat_cmd_args = '-c prestashop-plugin/behat.yml'
    endif
endif
