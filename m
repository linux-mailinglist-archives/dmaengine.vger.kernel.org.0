Return-Path: <dmaengine+bounces-4765-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78407A6CC01
	for <lists+dmaengine@lfdr.de>; Sat, 22 Mar 2025 20:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 522237ACEFC
	for <lists+dmaengine@lfdr.de>; Sat, 22 Mar 2025 19:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D1C1F4E5F;
	Sat, 22 Mar 2025 19:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="t32GIkcQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16D019D072;
	Sat, 22 Mar 2025 19:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742672151; cv=none; b=K2adqQdQUigVg8u9ZH/X5lVdGTpoJy6v2NxlPdkuQmcGFKGHVV294TJ5iOGXsaVBlCmuylRWeHSx7YfC4UNrjEMM8NkK7xqFTAAkH9839E0l/GKufCNv0lwvlpgLdppyUNTMclzqzM0yW9tvDxlLgCGE06+0ORuZ4MhtA2RURKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742672151; c=relaxed/simple;
	bh=fe7GfHyp0lF0mRQXTQoRJgPOqptsv4TUeEayHtDgbrc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tGrFbWVULllyaNWI9FUK79FwSAIIMMO5+jVfNPgid423u5t9Don+1IU1cHH+lefwXta10TWF79ksuAirEQUp5AJeCJaQnnWAPptp/YwUCYJ8xfECW+f8CqEvospnHWgC/GkLRqYcnn0xxqLhRb2+hA6HI7JYFrCDxYT1gZ5lOCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=t32GIkcQ; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 2C8B2A02DE;
	Sat, 22 Mar 2025 20:35:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=rlJEbPPbIUzOYO/Yzg2o
	COOmqaFv09aLLXibTWsy+xg=; b=t32GIkcQ7LeV857VWYYWeXH1zP9LRfEexX2q
	1ZGm4TZv67eHxty97zWKjGe98Hl/ti8TcVdvbUYdif08FSTwBWQ83KTfixHRO5sN
	pGqA1pRKvHbPNcJKe37Ko4AyyUghSz1vAhgRX7ZgGXiJSjaJCiu6T6m/9sCM1NVW
	r69cDWPAHUS8yq5q3tnSOeXUHtNPXqsmaPmKWrHqqx7bvKvL2OmWsnM8rtVNdgS7
	JC/9zllFCtNHWROAcGklDqA+vQQM4EtcDAeiP5Uui54APGdl12o+cbbCBPFQq/Fx
	r9NJOFrwGLG1/uKzNbDXZGrz7CnGGujbaAomtOGqow5H58csdzuKQ/UFdQaKZYcS
	VvaTRHS+Rqns02rY6STsl64tB5tJMixAYHva6mPsNPQVSIHob650DShkL/lKxp0K
	ewKGhv4Ol/z7CraEcxw+auco+1YbVFYqcOexA8J5srBAcG02EA/PAu2Q+fWuhgYM
	iKBnQ/WJOXnZRpmTy3D10jYZ9o9NRQ7+xX0s9fUxrcy/YAg9BUwUyBN+lCQuPhs6
	RReluQPb1uFluFZ+XkA3P97jqwdAApw/wbkcCoL2tjDz5QQIJtkyusYj3/LaThx9
	1/ek3yLINhjHFWeD/t3n1jqWar8m3HgluW24LIJdtbQRdvG74dWxaS58hxsySE4Y
	QPWrTu0=
Message-ID: <2da00161-723b-438a-9f70-1729312ec819@prolan.hu>
Date: Sat, 22 Mar 2025 20:35:44 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] dma-engine: sun4i: Use devm functions in probe()
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	<dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-sunxi@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
	Chen-Yu Tsai <wens@csie.org>, Vinod Koul <vkoul@kernel.org>, Samuel Holland
	<samuel@sholland.org>
References: <20250311180254.149484-1-csokas.bence@prolan.hu>
 <e4249f3c-ca05-4fc7-b367-6ce280d0d749@wanadoo.fr>
Content-Language: en-US, hu-HU
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <e4249f3c-ca05-4fc7-b367-6ce280d0d749@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D948526D7266

Hi,

On 2025. 03. 22. 20:13, Christophe JAILLET wrote:
> Le 11/03/2025 à 19:02, Bence Csókás a écrit :
>> Clean up error handling by using devm functions
>> and dev_err_probe(). This should make it easier
>> to add new code, as we can eliminate the "goto
>> ladder" in probe().
>>
>> Suggested-by: Chen-Yu Tsai <wens@kernel.org>
>> Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
>> Acked-by: Chen-Yu Tsai <wens@csie.org>
>> Signed-off-by: Bence Csókás <csokas.bence@prolan.hu>
>> ---
>>
>> Notes:
>>      Changes in v2:
>>      * rebase on current next
>>      Changes in v3:
>>      * rebase on current next
>>      * collect Jernej's tag
>>      Changes in v4:
>>      * rebase on current next
>>      * collect Chen-Yu's tag
>>
>>   drivers/dma/sun4i-dma.c | 31 ++++++-------------------------
>>   1 file changed, 6 insertions(+), 25 deletions(-)
>>
>> diff --git a/drivers/dma/sun4i-dma.c b/drivers/dma/sun4i-dma.c
>> index 24796aaaddfa..b10639720efd 100644
>> --- a/drivers/dma/sun4i-dma.c
>> +++ b/drivers/dma/sun4i-dma.c
>> @@ -1249,10 +1249,9 @@ static int sun4i_dma_probe(struct 
>> platform_device *pdev)
>>       if (priv->irq < 0)
>>           return priv->irq;
>> -    priv->clk = devm_clk_get(&pdev->dev, NULL);
>> +    priv->clk = devm_clk_get_enabled(&pdev->dev, NULL);
>>       if (IS_ERR(priv->clk)) {
>> -        dev_err(&pdev->dev, "No clock specified\n");
>> -        return PTR_ERR(priv->clk);
>> +        return dev_err_probe(&pdev->dev, PTR_ERR(priv->clk), 
>> "Couldn't start the clock");
> 
> Why removing the trailing \n everywhere?
> 
> Any reference esxplaing why it is correct?
> 
> CJ

Well, printk() will add a newline unless LOG_CONT is used. However, 
while looking up this feature, it seems that the consensus is to keep 
the `\n`s, even though they are not strictly needed anymore. I'll update 
this.

Bence


