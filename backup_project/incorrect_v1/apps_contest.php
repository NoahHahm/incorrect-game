<?
	$db = new mysqli('localhost', '', '');
	$db->select_db('');
	$db->query("SET NAMES utf8");
	$item = Array();
	
	$main = $_GET['cmd'];
	$username = $_GET['name'];
	$score = $_GET['score'];
	
	
	if ($main == null || is_numeric($main) == false) {
		return;
	}
	       
	        
	// 전체유져 점수 순서
    if ($main == 1)
    {
    	$count = 0;
		$result = $db->query('SELECT * FROM `Apps_Contest` WHERE `score` >= 100 ORDER BY score DESC limit 10');
		while($row=mysqli_fetch_array($result))
		{
			$item[$count]['id'] = $count + 1;
			$item[$count]['name'] = $row[1];
			$item[$count]['score'] = (int)$row[2];
			$count++;
		}	
		json_print($item); 
    }   
    
    
    // 새로운 사용자
    if ($main == 2)
    {
    	//기존 사용자 닉네임 확인
		$result = $db->query("SELECT COUNT(*) FROM `Apps_Contest` WHERE `name` = '".$username."'");
		$row = mysqli_fetch_array($result);
		if ($row[0] > 0) {
			$item['result'] = (bool) false;
			json_print($item);  
			return;
		}
		
		$result = $db->query("INSERT INTO `Apps_Contest` (`id`, `name`, `score`) VALUES (NULL, '".$username."', 0);");
		if ($result == true) {
			$item['result'] = (bool) true;
			json_print($item);
		}
    }
    
    
    // 기존 사용자 점수 업데이트
    if ($main == 3)
    {
		$result = $db->query("UPDATE `Apps_Contest` SET `score` = '".$score."' WHERE `name` = '".$username."'");
		if ($result == true) {
			$item['result'] = (bool) true;
			json_print($item);
		}
    }
    
    
    // 해당 사용자 정보
    if ($main == 4)
    {
		$result = $db->query("SELECT * FROM `Apps_Contest` WHERE `name` = '".$username."'");
		while($row=mysqli_fetch_array($result))
		{
			$item['id'] = $count + 1;
			$item['name'] = $row[1];
			$item['score'] = (int)$row[2];
		}	
		json_print($item);
    }



    function json_print ($result) {
		$output = json_encode($result);
		print($output);
		
		return;
    }
    
?>