<?php
$errRequestFunction = "Error as a function call requests"; //����Ĺ��ܵ�������
$errRequestFile = "Request the wrong file called"; //"������ļ���������"
$errFileType = "The wrong file type"; //"������ļ����ͣ�"
$errUpfile = "File upload failed, please check the upload directory and directory read and write permissions set"; //"�ļ��ϴ�ʧ�ܣ������ϴ�Ŀ¼���ú�Ŀ¼��дȨ��"
$uploadExceed = "The uploaded file can not exceed"; //"�ϴ����ļ����ܳ���"
$config = array ();
$config ['type'] = array ("flash", "img" ); //�ϴ�����typeֵ
$config ['img'] = array ("jpg", "bmp", "gif" ); //img�����׺
$config ['flash'] = array ("flv", "swf" ); //flash�����׺
$config ['flash_size'] = 2000; //�ϴ�flash��С���� ��λ��KB
$config ['img_size'] = 5000; //�ϴ�img��С���� ��λ��KB
$config ['message'] = "�ϴ��ɹ�!"; //�ϴ��ɹ�����ʾ����Ϣ����Ϊ������ʾ�ϴ��ɹ�
$config ['name'] = mktime (); //�ϴ�����ļ��������� ������unixʱ���������
$config ['flash_dir'] = $_SERVER['DOCUMENT_ROOT']."/HNUST/upload"; //�ϴ�flash�ļ���ַ ���þ��Ե�ַ ����upload.php�ļ�����վ�ڵ��κ�λ�ú��治��"/",�ϴ����ļ���������վ��Ŀ¼�µ�upload�ļ�����
$config ['img_dir'] = $_SERVER['DOCUMENT_ROOT']."/HNUST/upload"; //�ϴ�img�ļ���ַ ���þ��Ե�ַ ���þ��Ե�ַ ����upload.php�ļ�����վ�ڵ��κ�λ�ú��治��"/"���ϴ����ļ���������վ��Ŀ¼�µ�upload�ļ�����
$config ['site_url'] = "http://localhost:8080/HNUST"; //��վ����ַ����ͼƬ�ϴ���ĵ�ַ�й� ��󲻼�"/" ������
//û���ļ���ʱ�򴴽�
isDirAll($config ['flash_dir']);
isDirAll($config ['img_dir']);
//�ļ��ϴ�
uploadfile ();
function uploadfile() {
    global $config;
    //�ж��Ƿ��ǷǷ�����
    if (empty ( $_GET ['CKEditorFuncNum'] ))
        mkhtml ( 1, "", $errRequestFunction );
    $fn = $_GET ['CKEditorFuncNum'];
    if (! in_array ( $_GET ['type'], $config ['type'] ))
        mkhtml ( 1, "", $errRequestFile );
    $type = $_GET ['type'];
    if (is_uploaded_file ( $_FILES ['upload'] ['tmp_name'] )) {
        //�ж��ϴ��ļ��Ƿ�����
        $filearr = pathinfo ( $_FILES ['upload'] ['name'] );
        $filetype = $filearr ["extension"];
        if (! in_array ( $filetype, $config [$type] ))
            mkhtml ( $fn, "", $errFileType );
            //�ж��ļ���С�Ƿ����Ҫ��
        if ($_FILES ['upload'] ['size'] > $config [$type . "_size"] * 1024)
            mkhtml ( $fn, "", $uploadExceed . $config [$type . "_size"] . "KB��" );
        $file_abso = $config [$type . "_dir"] . "/" . $config ['name'] . "." . $filetype;
        $file_host = $file_abso;
        $file_path = "/upload/" . $config ['name'] . "." . $filetype;//�����/upload/�������ϴ��ļ���Ŀ¼���е���
        if (move_uploaded_file ( $_FILES ['upload'] ['tmp_name'], $file_host )) {
            mkhtml ( $fn, $config ['site_url'] . $file_path, $config ['message'] );
        } else {
            mkhtml ( $fn, "", $errUpfile . $file_host );
        }
    }
}
//���js����
function mkhtml($fn, $fileurl, $message) {
    $str = '<script type="text/javascript">window.parent.CKEDITOR.tools.callFunction(' . $fn . ', '' . $fileurl . '', '' . $message . '');</script>';
    exit ( $str );
}
 
function isDirAll($dir) {
    if (! is_dir ( $dir )) {
        $dirArr = explode ( "/", $dir );
        $mkDir = "";
        for($i = 0; $i < count ( $dirArr ); $i ++) {
            if ($dirArr [$i] != "") {
                $mkDir .= '/' . $dirArr [$i];
                isMkDir ( $mkDir );
            }
        }
    }
}
 
function isMkDir($dir = "") {
    if (! is_dir ( $dir )) {
        @mkdir ( $dir, 0777 );
    }
}
?>