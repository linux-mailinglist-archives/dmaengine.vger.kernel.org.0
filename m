Return-Path: <dmaengine+bounces-3622-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3DD19B2969
	for <lists+dmaengine@lfdr.de>; Mon, 28 Oct 2024 09:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B1931F256DC
	for <lists+dmaengine@lfdr.de>; Mon, 28 Oct 2024 08:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE121922D5;
	Mon, 28 Oct 2024 07:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="khpG7v+0"
X-Original-To: dmaengine@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E78E191489;
	Mon, 28 Oct 2024 07:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730101046; cv=none; b=ao4Fxw3/lZz9ydcLmi2p/lVCu58CdDzJfjdMUytpsF3hxUFlNbZp8DMId9t2q7ck0xazjgoi+c+i4vJEMZ5IHfxEk+FvLHh6yDXG3eAHiyzWiVzgd5YrM24x3cz+ifnNUY0bTY8ZIXEUCgZSUtXwtS/g8fOb5k1y+W2cp+O+ayc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730101046; c=relaxed/simple;
	bh=NkwvqH4Xf+9+y0Ay+cUcFtSSHuR92AA+JZuj8Z6LZXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FEpfgFpM1eEXX9XspYdmTdtSnLPdBioKPLve4SR09NDS6cE8/IyM+jRaVJQ/eX6mswZsGW7uLYCmDCxlQFrUNMjVJlG+nwTal7ViXW2vQ4LOSqHqHCA4qWKWO1o8VHj4FJQ+q7b6qR4b8yNLn2aSKi1/OjoxGkrqJ3YaR/ihvvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=khpG7v+0; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id CFC6EA0767;
	Mon, 28 Oct 2024 08:37:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=8qIqfkzVktUqGL4TZCqG
	/TtE6T+nDkJffSarBT3k/9Y=; b=khpG7v+0iIyiW18Bod+0hVtkZ/dm8REBF7OQ
	+2mnCyibYzfdDRLIkPajNd7AysCLbBVjwatGc30KDxZR7fRgX2Acg0anP5P2vj6t
	QgGYO7adaVb0mrDVM+2o7tMEaD8g2llZMXNDTvoUTG/l/2xs507g0kgRP773cLD8
	lzHMY6xmOG3hm4l1SsA7gNtIPIfJ+xp23jm2NyNwhjIi5pI9fZU1a9j3ygJmiui6
	Oqgb71KTX5ftpELGpvXM2ptUZft7Hteu7YhLX6h0vLZvVzDmLzWbk8dGdJIJRKud
	c4eQoyYinGD0HNal5Elo7lC7rhyTa53hFNgZpUgntoICWmkda6qsvcOdwr6FgmI+
	TPzA9vgn5sZPF7mWQVUnN8WigmjochcWrGvWZ+IDp6IrF4m28pOMac48AJZbAe22
	Ow33c4lfr8Pa5msQ8928EKifDDBeetGWZ4iHnTOsRbjWIKzapehXrwpXMTrXLhnf
	oPF5F8dS11aUcTFHiH0ktmoa52RX689jyIbkLAHQWzxonAWR1Wwy+qdyCQ0pan2V
	ynqWbSoGl/vUYxdn+pFByMNTiPh5BSebicb3QNJL1uyjpoe48KulEiFnUEnm5Y1P
	2AD8SBkrnwqmdZCm4N5G060wf9htlJgOqPLnS1lXMj9V1xlctwN61qnoT2qdmrzc
	Ch5qujk=
Message-ID: <b74dafed-197a-4644-a546-54c7a1639484@prolan.hu>
Date: Mon, 28 Oct 2024 08:37:21 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/10] dma-engine: sun4i: Add has_reset option to quirk
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-sunxi@lists.linux.dev>, <linux-kernel@vger.kernel.org>, Mesih Kilinc
	<mesihkilinc@gmail.com>, Vinod Koul <vkoul@kernel.org>, Chen-Yu Tsai
	<wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland
	<samuel@sholland.org>, Philipp Zabel <p.zabel@pengutronix.de>
References: <20241027091440.1913863-1-csokas.bence@prolan.hu>
 <20241027091440.1913863-2-csokas.bence@prolan.hu>
 <nlhsxigg3rbfvua76ekmub4p6df2asps2ihueouuk6zkbn56zl@xdj6jzzt4gfb>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <nlhsxigg3rbfvua76ekmub4p6df2asps2ihueouuk6zkbn56zl@xdj6jzzt4gfb>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94855677C65

Hi,

On 2024. 10. 27. 21:42, Krzysztof Kozlowski wrote:
> On Sun, Oct 27, 2024 at 10:14:32AM +0100, Csókás, Bence wrote:
>> From: Mesih Kilinc <mesihkilinc@gmail.com>
>>
>> Allwinner suniv F1C100s has a reset bit for DMA in CCU. Sun4i do not
>> has this bit but in order to support suniv we need to add it. So add
>> support for reset bit.
>>   
>>   static struct sun4i_dma_dev *to_sun4i_dma_dev(struct dma_device *dev)
>> @@ -1215,6 +1218,15 @@ static int sun4i_dma_probe(struct platform_device *pdev)
>>   		return PTR_ERR(priv->clk);
>>   	}
>>   
>> +	if (priv->cfg->has_reset) {
>> +		priv->rst = devm_reset_control_get_exclusive(&pdev->dev,
>> +							     NULL);
>> +		if (IS_ERR(priv->rst)) {
>> +			dev_err_probe(&pdev->dev, "Failed to get reset control\n");
> 
> syntax is: return dev_err_probe()
> 
> Best regards,
> Krzysztof

Thanks! And regarding v3 of this patch, I have `clk_disable_unprepare()` 
after `dev_err_probe()`, I assume I have to let that be i.e. not return 
immediately?


