Return-Path: <dmaengine+bounces-12157-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VMcgHZQKT2p8ZgIAu9opvQ
	(envelope-from <dmaengine+bounces-12157-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 04:42:28 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D25BF72C165
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 04:42:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=126.com header.s=s110527 header.b=W04D3AYD;
	dmarc=pass (policy=none) header.from=126.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12157-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12157-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3B86730309DE
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2026 02:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D1D343895;
	Thu,  9 Jul 2026 02:40:51 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D11344030;
	Thu,  9 Jul 2026 02:40:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783564850; cv=none; b=Agrvet2X+fgyoV8z0QHEB9Jkb7jIWk/E8lPv0Uhgkvr+FypFpZKjCWBQSHsdu6NzJh65dVm8RcLnOHsYIeritnzrLt+L/D3B/B4rRQE7by/lnjYTMVKEGhtPtWh7DHwKJhgWIs0K/RuIhk4k6okWLXSo4RqXYnqvHniwupE9O3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783564850; c=relaxed/simple;
	bh=Skmf/zDz1zq2Niv5wCxgCKxzeoR+qq+iPrCOJJKqjjQ=;
	h=Message-ID:Date:From:MIME-Version:To:CC:Subject:References:
	 In-Reply-To:Content-Type; b=PsP+v5z1oloqRDspacM15C5aPdg2BQI6uXjwV00e8qsW3Vro7GIgjxR+1pRYBrPOdro+aCa+tDRD2ecizv94kv3nT5JmbTQfY3ip3blYKj2XsqVLDEkljF078YUYGjCLl3sW4Gy3NEOUJSfutVuD5ZM3KBRbCjibHBEREfxXZYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=W04D3AYD; arc=none smtp.client-ip=220.197.31.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:From:MIME-Version:To:Subject:
	Content-Type; bh=zPzUjVYeTGVy0p5nTu0E1LwAP36Ua88/dAXmfMtmXgg=;
	b=W04D3AYDk7sFoPiHa+PV8e+zfacdmjnjWg/9sWyINApP/QihEQVfqN8dojbKek
	YDuJ9uy9B3Mt+g4MGrNgcyTQDEcx+uyE6Jcs3ocbpYsNao+Hy7UAVxbD2gXs2vaw
	w4SpFujtnuCBegGhgXSEC5kWCm+oL5aUTgXbaUkZ+fl3k=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDnL0z5CU9qxiduDA--.8579S2;
	Thu, 09 Jul 2026 10:39:54 +0800 (CST)
Message-ID: <6A4F09E8.8040807@126.com>
Date: Thu, 09 Jul 2026 10:39:36 +0800
From: Hongling Zeng <zhongling0719@126.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: Frank Li <Frank.li@oss.nxp.com>, 
 Hongling Zeng <zenghongling@kylinos.cn>
CC: ludovic.desroches@microchip.com, vkoul@kernel.org, 
 Frank.Li@kernel.org, tudor.ambarus@linaro.org, 
 nicolas.ferre@microchip.com, linux-arm-kernel@lists.infradead.org, 
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 sashiko-bot@kernel.org
Subject: Re: [PATCH v4] dma: at_hdmac: Fix use-after-free by proper tasklet
 cleanup
References: <20260708025959.40283-1-zenghongling@kylinos.cn> <ak7B5gxc9LrMmxO4@SMW015318>
In-Reply-To: <ak7B5gxc9LrMmxO4@SMW015318>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnL0z5CU9qxiduDA--.8579S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuF47ZFy3KrWUJF13ur4fAFb_yoWrZr4fpr
	WUJFWYkrW0qrn09Fnruw4kua4Fva1Sqw4SgrW7Kw13A34YvrnYyFW8Cw1UWFZxAFykXr1S
	gFZ8tFyrur1rJr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j4Hq7UUUUU=
X-CM-SenderInfo: x2kr0wpolqwiqxrzqiyswou0bp/xtbBrhruv2pPCfq6pQAA3s
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[126.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[126.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:Frank.li@oss.nxp.com,m:zenghongling@kylinos.cn,m:ludovic.desroches@microchip.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:tudor.ambarus@linaro.org,m:nicolas.ferre@microchip.com,m:linux-arm-kernel@lists.infradead.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:sashiko-bot@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[zhongling0719@126.com,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-12157-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhongling0719@126.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[126.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[126.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,kylinos.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D25BF72C165


在 2026年07月09日 05:32, Frank Li 写道:
> On Wed, Jul 08, 2026 at 10:59:59AM +0800, Hongling Zeng wrote:
>> Current cleanup paths have a use-after-free vulnerability:
>> - vchan_init() creates tasklets that access at_dma_chan memory
>> - free_irq() only waits for IRQ handler, NOT tasklets
>> - atdma is devm-managed and freed after probe/remove
>> - Running tasklets accessing freed memory → Use-After-Free!
>>
>> The fix requires careful ordering:
>> - free_irq() FIRST to synchronize with running IRQ handlers and prevent
>>    them from scheduling new tasklets
>> - Then kill tasklets to wait for already-scheduled ones to complete
>> - Only then free other resources
>>
>> Fixes: ac803b56860f ("dmaengine: at_hdmac: Convert driver to use virt-dma")
>> Reported-by: sashiko-bot@kernel.org
>> Closes: https://lore.kernel.org/all/20260604073945.54B311F00898@smtp.kernel.org/
>> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
>>
>> ---
>> Change in v4:
>>    - Fix error path fallthrough causing double-free_irq()
>>    - Use channel iteration index (chan_id not initialized before registration)
>>    - Remove unnecessary defensive checks
>> ---
>>   drivers/dma/at_hdmac.c | 31 ++++++++++++++++++++++---------
>>   1 file changed, 22 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
>> index e5b30a57c477..044a0fb38b7a 100644
>> --- a/drivers/dma/at_hdmac.c
>> +++ b/drivers/dma/at_hdmac.c
>> @@ -1940,6 +1940,20 @@ static void at_dma_off(struct at_dma *atdma)
>>   		cpu_relax();
>>   }
>>
>> +static void at_dma_cleanup_channels(struct at_dma *atdma)
>> +{
>> +	struct dma_chan *chan, *_chan;
>> +	int i = 0;
>> +
>> +	list_for_each_entry_safe(chan, _chan, &atdma->dma_device.channels,
>> +			device_node) {
>> +		/* Disable interrupts */
>> +		atc_disable_chan_irq(atdma, i++);
>> +		tasklet_kill(&to_at_dma_chan(chan)->vc.task);
>> +		list_del(&chan->device_node);
>> +	}
>> +}
>> +
>>   static int __init at_dma_probe(struct platform_device *pdev)
>>   {
>>   	struct at_dma		*atdma;
>> @@ -2105,12 +2119,17 @@ static int __init at_dma_probe(struct platform_device *pdev)
>>   err_of_dma_controller_register:
>>   	dma_async_device_unregister(&atdma->dma_device);
>>   err_dma_async_device_register:
>> +	free_irq(platform_get_irq(pdev, 0), atdma);
>> +	at_dma_cleanup_channels(atdma);
>>   	dma_pool_destroy(atdma->memset_pool);
>> +	dma_pool_destroy(atdma->lli_pool);
>> +	goto err_clk;
> I forget the reason why need goto here. Can you call disable_irq() or
> disable hardware irq and call synchronize_irq() at free_irq() place. then
> goto can fallback to below clean up code
>
> Frank
   Thank you for the suggestion. I've updated to v6 following your advice:
   - Replaced free_irq() with disable_irq() to allow fallthrough without 
goto
   - free_irq() is now called only once at err_desc_pool_create label
   The new approach ensures IRQ handler cannot schedule tasklets before 
tasklet_kill(), then free_irq() handles the actual release.

    Please help to review again.
Thanks!

>
>>   err_memset_pool_create:
>>   	dma_pool_destroy(atdma->lli_pool);
>>   err_desc_pool_create:
>>   	free_irq(platform_get_irq(pdev, 0), atdma);
>>   err_irq:
>> +err_clk:
>>   	clk_disable_unprepare(atdma->clk);
>>   	return err;
>>   }
>> @@ -2118,23 +2137,17 @@ static int __init at_dma_probe(struct platform_device *pdev)
>>   static void at_dma_remove(struct platform_device *pdev)
>>   {
>>   	struct at_dma		*atdma = platform_get_drvdata(pdev);
>> -	struct dma_chan		*chan, *_chan;
>>
>>   	at_dma_off(atdma);
>>   	if (pdev->dev.of_node)
>>   		of_dma_controller_free(pdev->dev.of_node);
>>   	dma_async_device_unregister(&atdma->dma_device);
>>
>> -	dma_pool_destroy(atdma->memset_pool);
>> -	dma_pool_destroy(atdma->lli_pool);
>>   	free_irq(platform_get_irq(pdev, 0), atdma);
>>
>> -	list_for_each_entry_safe(chan, _chan, &atdma->dma_device.channels,
>> -			device_node) {
>> -		/* Disable interrupts */
>> -		atc_disable_chan_irq(atdma, chan->chan_id);
>> -		list_del(&chan->device_node);
>> -	}
>> +	at_dma_cleanup_channels(atdma);
>> +	dma_pool_destroy(atdma->memset_pool);
>> +	dma_pool_destroy(atdma->lli_pool);
>>
>>   	clk_disable_unprepare(atdma->clk);
>>   }
>> --
>> 2.25.1
>>


