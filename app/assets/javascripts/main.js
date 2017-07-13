$(document).on("turbolinks:load", function () {

    url = "http://localhost:3000";

    $(document).delegate("a.reply-comment", "click", function (e) {
        e.preventDefault();

        var id = $(this).attr("id-delete");

        if ($("div#reply-comment-"+id).hasClass('hide')) {
            $(this).html("Hide");
            $("div#reply-comment-"+id).removeClass('hide');
        } else {
            $(this).html("Reply");
            $("div#reply-comment-"+id).addClass('hide');
        }

    });

    $(document).delegate("form.form-reply-comment", "submit", function (e) {
        e.preventDefault();

        var id = $(this).attr('parent-id');
        var post_id = $(this).attr("post-id");
        var content = $(this).find("input[name='reply-content']").val();

        var that = this;

        $.ajax({
            url: url + "/posts/" + post_id + "/child/" + id,
            type: 'PUT',
            dataType: "script",
            data: {
                content: content
            },
            success: function (data) {
                $(that).find("input[name='reply-content']").val("")
                $(that).find("input[name='reply-content']").focus();
            },
            error: function (err) {
                $(that).find("input[name='reply-content']").val("")
                $(that).find("input[name='reply-content']").focus();
            }
        });
    });

    $(document).delegate("a.show-comment", "click", function (e) {
        e.preventDefault();

        var name = $(this).parent().parent().parent().next();

        if (name.hasClass("hide")) {
            $(this).html("Hide");
            name.removeClass("hide");
        } else {
            $(this).html("Show");
            name.addClass("hide");
        }

    });

    $(document).delegate("a.remove-post", "click", function (e) {
        e.preventDefault();

        swal({
          title: 'Error!',
          text: 'Do you want to continue',
          type: 'error',
          confirmButtonText: 'Cool'
        });
    });

    $(document).delegate("a.remove-comment", "click", function (e) {
        var that = this;

        swal({
          title: "Are you sure?",
          text: "You will not be able to recover this comment",
          type: "warning",
          showCancelButton: true,
          confirmButtonColor: "#DD6B55",
          confirmButtonText: "Yes, delete it!",
          closeOnConfirm: true
        },
        function () {
            var id_post = $(that).attr("id-post");
            var id_comment = $(that).attr("id-delete");

            $.ajax({
                url: '/posts/' + id_post + '/comments/' + id_comment,
                type: "DELETE",
                dataType: "script",
                success: function () {
                    console.log("Success");
                },
                error: function () {
                    console.log("ERror");
                }
            });
        });
    });

});
