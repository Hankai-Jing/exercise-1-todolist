$(document).ready(function() {
    $('#userInput').keydown(save)

    todolist = new Todolist()
    $.get(
        'todolist_items',
        {},
        function(response) {
            for(var i = 0; i < response.length; i++) {
                new TodolistItem(response[i])
            }
        },
        "json"
    )
})            
function save (click) {
    if (click.keyCode == 13){
        $.post(
            'todolist_items',
            {
                todolist_item: {
                    content: $('#userInput').val(),
                    completed: false
                }
            },
            function(response) {
                new TodolistItem(response)
                $('#userInput').val('')
            },
            "json"
        )
    }
}

function TodolistItem(newItem){
    this.id = newItem.id
    this.newTr = this.createNewTr(newItem)
    this.newTr.find('#checkBox').change(this.toggleDelete.bind(this))
    this.newTr.find('#delete').click(this.newTrDelete.bind(this))
    todolist.items.push(this)
    if(newItem.completed) {
            $(this.newTr).find('#checkBox').prop('checked', true)
            this.toggleDelete()
    }
}
TodolistItem.prototype = {
    createNewTr: function(newItem) {
        var newTr = $('#template').clone()
        var tbody = $('#tableBody')
        tbody.append(newTr)
        newTr.find('div').html(newItem.content)
        newTr.show()
        newTr.attr('id', "newTr" + newItem.id)

        return newTr
    },
    toggleDelete: function (event) {
        var td_checkbox = $(this.newTr).find('#checkBox')  
        var td_div = $(this.newTr).find('div')
        if (td_checkbox.prop('checked')) {
            var del = $('<del></del>')
            del.html(td_div.html())
            td_div.empty().append(del)
            this.newTr.removeClass('active').addClass('completed')
            var completed = true                  
        }
        else {
            var getback = td_div.children(0).html()
            td_div.html(getback) 
            this.newTr.removeClass('completed').addClass('active')
            var completed = false
        }
        $.ajax({
            url: 'todolist_items/' + this.id,
            type: 'PUT',
            data: {
                todolist_item: {
                    completed: completed
                }
            },
            success: function(response) {},
            dataType: "json"
        })
    },

    newTrDelete: function (event) {
        $(this.newTr).remove()
        $.ajax({
            url: 'todolist_items/' + this.id,
            type: 'DELETE',
            success: function(response) {
                alert('Task deleted!')
            },
            dataType: "json"
        })
    }            
}
function Todolist() {
    this.items = []
    this.body = $('#tableBody')
    $("#active_button").click(this.displayActive.bind(this))
    $("#completed_button").click(this.displayCompleted.bind(this))
    $("#all_button").click(this.displayAll.bind(this))
}
Todolist.prototype = {
    displayActive: function(event) {
        this.body.children().each(function() {
            if($(this).prop('id') != "template") {
                if($(this).hasClass("completed")) {
                    $(this).hide()
                }else {
                    $(this).show()
                }
            }
        })
    },
    displayCompleted: function(event) {
        this.body.children().each(function() {
            if($(this).hasClass("active")) {
                $(this).hide()
            }else {
                $(this).show()
            }

        })
    },
    displayAll: function(event) {            
        this.body.children().each(function() {
            if($(this).prop('id') != "template") {
                $(this).show()
            }
        })
    }
}
