function reconnect_colab_mgh()
{
	while(true)
	{
		try{
			setTimeout(document.getElementById('ok').click(),50000)
		}
		catch (err) {
			console.log(err);
		}
	}
}
reconnect_colab_mgh()