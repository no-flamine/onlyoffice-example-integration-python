<script type="text/javascript" src="{{editor_url}}/web-apps/apps/api/documents/api.js"></script>
<script>
    var editor;
    function view(filename) {
        if (editor) {
            editor.destroyEditor()
        }
        var filepath = 'files/' + filename;
        editor = new DocsAPI.DocEditor("editor",
            {
                documentType: get_file_type(filepath),
                document: {
                    url: "{{app_url}}" + '/' + filepath,
                    title: filename

                },
                editorConfig: {mode: 'view'}
            });
    }

    function edit(filename) {
        const filepath = 'files/' + filename;
        if (editor) {
            editor.destroyEditor()
        }
        console.log({
                documentType: get_file_type(filepath),
                document: {
                    url: "{{app_url}}" + '/' + filepath,
                    title: filename
                },
                editorConfig: {
                    mode: 'edit',
                    callbackUrl: "{{app_url}}" + '/callback' + '?filename=' + filename
                }
            })
        editor = new DocsAPI.DocEditor("editor",
            {
                documentType: get_file_type(filepath),
                document: {
                    url: "{{app_url}}" + '/' + filepath,
                    title: filename
                },
                editorConfig: {
                    mode: 'edit',
                    callbackUrl: "{{app_url}}" + '/callback' + '?filename=' + filename
                }
            });
    }

    function get_file_type(filename) {

        if (/docx$/.exec(filename)) {
            return "text"
        }
        if (/xlsx$/.exec(filename)) {
            return "spreadsheet"
        }
        if (/pptx$/.exec(filename)) {
            return "presentation"
        }
    }
</script>


%for file in sample_files:
<div>
    <span>{{file}}</span>
    <button onclick="view('{{file}}')">view</button>
    <button onclick="edit('{{file}}')">edit</button>
</div>
% end
<div id="editor"></div>
