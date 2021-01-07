*** Settings ***
Library    SeleniumLibrary
Library    BuiltIn
Library    String
Suite Setup        Open Browser    about:blank    chrome
Suite Teardown     Close All Browsers
*** Variable ***
${url_Web}        https://abhigyank.github.io/To-Do-List/
${title_Web}      To-Do List
${input_task}          //*[@id="new-task"]
${btn_add}             //*[@id="add-item"]/button
${btn_additem_tab}     //*[contains(text(),'Add Item')]
${btn_todo_tab}        //*[contains(text(),'To-Do Tasks')]
${btn_completed_tab}   //*[contains(text(),'Completed')]
${txt_test}            test
${txt_test2}           test2
${txt_test3}           test3
${txt_test4}           test4
${txt_test5}           test5
${txt_test6}           test6
${to_do_list}              //*[@id="incomplete-tasks"]/li/label
${complete_list}      //*[@id="completed-tasks"]/li/span
${delete_todo}          //*[@id="incomplete-tasks"]/li/button
${delete_complete}      //*[@id="completed-tasks"]//*[@class="mdl-list"]//*[@id="1"]

*** Test Cases ***
Access Website - success
    [tags]    success
    Go To           ${url_Web}
    Verify Website          ${title_Web}

Verify 3 Menu
    [tags]    success
    Verify Tab  ${btn_additem_tab}
    Verify Tab  ${btn_todo_tab}
    Verify Tab  ${btn_completed_tab}

Verify Add Button -success
    [tags]    success
    Input newText    ${input_task}  ${txt_test}
    Click Button      ${btn_add}
    Verify Textbox  ${input_task}
    Input newText    ${input_task}  ${txt_test2}
    Click Button      ${btn_add}
    Verify Textbox  ${input_task}
    Input newText    ${input_task}  ${txt_test3}
    Click Button      ${btn_add}
    Verify Textbox  ${input_task}
    Input newText    ${input_task}  ${txt_test4}
    Click Button      ${btn_add}
    Verify Textbox  ${input_task}
    Input newText    ${input_task}  ${txt_test5}
    Click Button      ${btn_add}
    Verify Textbox  ${input_task}
    Input newText    ${input_task}  ${txt_test6}
    Click Button      ${btn_add}
    Verify Textbox  ${input_task}

Verify To-Do list page
    [tags]    success
    Click Button    ${btn_todo_tab}
    Verify textList     ${to_do_list}    ${txt_test}

Verify Click List
   [tags]    success
    Click Button    ${to_do_list}
    ${IsElementVisible}=  Run Keyword And Return Status    Verify missing    ${to_do_list}
    Run Keyword IF    ${IsElementVisible}       Should Be Equal     '${IsElementVisible}'     'True'
        Compare Text  ${to_do_list}   ${txt_test2}
    Click Button    ${to_do_list}
    ${IsElementVisible}=  Run Keyword And Return Status    Verify missing    ${to_do_list}
    Run Keyword IF    ${IsElementVisible}       Should Be Equal     '${IsElementVisible}'     'True'
        Compare Text  ${to_do_list}   ${txt_test3}
    Click Button    ${to_do_list}
    ${IsElementVisible}=  Run Keyword And Return Status    Verify missing    ${to_do_list}
    Run Keyword IF    ${IsElementVisible}       Should Be Equal     '${IsElementVisible}'     'True'
        Compare Text  ${to_do_list}   ${txt_test4}

Verify Delete Button on To-do Page
    [tags]    success
    Click Button    ${delete_todo}

Verify Completed Page
    [tags]    success
    Click Button    ${btn_completed_tab}
    Wait Until Page Contains Element     ${delete_complete}
    Validate done list   ${complete_list}    ${txt_test}

Verify Delete Button on Complete Page
    [tags]    success
    Wait Until Page Contains Element     ${delete_complete}
    Click Button    ${delete_complete}
    ${IsElementVisible}=  Run Keyword And Return Status    Verify missing    ${complete_list}
    Run Keyword IF    ${IsElementVisible}       Should Be Equal     '${IsElementVisible}'     'True'
        Validate done list  ${complete_list}   ${txt_test2}
    Click Button    ${delete_complete}
    ${IsElementVisible}=  Run Keyword And Return Status    Verify missing    ${complete_list}
    Run Keyword IF    ${IsElementVisible}       Should Be Equal     '${IsElementVisible}'     'True'
        Validate done list  ${complete_list}   ${txt_test3}
    Click Button    ${delete_complete}
    Verify missing    ${complete_list}



*** Keywords ***
Verify Website
    [Arguments]               ${title}
    Title Should Be            ${title}

Input newText
    [Arguments]      ${xpath_txt}  ${newtxt}
    Element Should Be Visible    ${xpath_txt}
    Input Text       ${xpath_txt}  ${newtxt}

Click Button
    [Arguments]       ${btn}
    Element Should Be Visible    ${btn}
    Click Element        ${btn}

Verify Tab
    [Arguments]        ${testtab}
    Element Should Be Visible   ${testtab}

Verify Textbox
    [Arguments]     ${texttype}
    Element Text Should Be     ${texttype}  ${EMPTY}

Verify textList
    [Arguments]     ${texttype}     ${textlist}
    Element Text Should Be     ${texttype}  ${textlist}

Verify missing
    [Arguments]     ${list}
    Element Should Not Be Visible       ${list}

Compare Text
    [Arguments]     ${list}     ${list2}
    Element Text Should Be     ${list}    ${list2}

Validate done list
    [Arguments]     ${list}     ${list2}
    Element Text Should Be     ${list}    done${list2}