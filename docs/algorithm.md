  
    Result := empty list that will contain the sorted nodes
    
    while there are unmarked nodes do  
        select an unmarked Node  
        visit(Node)  
    
    function visit(Node)  
        if Node has a temporary mark then stop (not a DAG)  
        if Node is not marked (i.e. has not been visited yet) then  
            mark Node temporarily  
            for each node Ref with an edge from Node to Ref do  
                visit(Ref)             
            mark Node permanently  
            unmark Node temporarily  
            add Node to head of Result