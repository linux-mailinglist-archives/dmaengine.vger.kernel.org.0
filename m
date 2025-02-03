Return-Path: <dmaengine+bounces-4252-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1796A25A62
	for <lists+dmaengine@lfdr.de>; Mon,  3 Feb 2025 14:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 941DB188840A
	for <lists+dmaengine@lfdr.de>; Mon,  3 Feb 2025 13:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD39204C31;
	Mon,  3 Feb 2025 13:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="YlFNyO7Y"
X-Original-To: dmaengine@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD85C139;
	Mon,  3 Feb 2025 13:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738588206; cv=none; b=DNmFL+Szl1Y0zzAT9anFINlKXzXOM0Lj7xPMF+W8Sokoncrt9GDRdNeYR1iNk6+AEUUc72EB0BW15oLemOwDzE8BH7nnvgZqcx6szCFvwkEOKZdMzNhAVdZdYmL42xHUP7moRHlNWvGted1xosPrS4rY5YSrFwvcUP9DeIcwAwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738588206; c=relaxed/simple;
	bh=0dZmUsmVdpc0nFZ6x5rfDtAfZ8L5Hy85g2JGgxodjiU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hT2CXIQMgFtSPLry2oiiwun2lWupcwuMIHHMb9gkKrzzKh58myMJVtBP+63vy2ik3PF0wju+R8EQM1MWUvh8mtKikgd6VPqQyGXj7lbDP1SJtPOIkg5ZO8+bTFTafCMqnpAhRX+fsC2p4/OkADrSDyEe2jvZFnKBctPQUIVT/F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=YlFNyO7Y; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 622D3A0A06;
	Mon,  3 Feb 2025 14:09:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:content-transfer-encoding:content-type:content-type:date:from
	:from:in-reply-to:message-id:mime-version:references:reply-to
	:subject:subject:to:to; s=mail; bh=Z4oFHXHx29Qg7053vOUzsNdaD5NZq
	jXMjU19+Z9WIxw=; b=YlFNyO7YaQTlGuytcsi2Rwplw4nDKUNoBAx6JMxM3KfW6
	ABjHntaHoehXkdW+A9Ey155y1ZgHcy8ic1ur5PFI+BdxlX8OX00FQJokEWOspEWE
	RtsOVUm1tgayB3N44JZti4wAF3xyBpJQEHpF7El4SPQR+frJ/KhyHguBtbaj8jR8
	3lkeDy2QkBeW0O9JMR5biv8H09tPoIa1bH+E8wqBvc6K6/2OrGqKmJoyH4BAYOC+
	I2134J9ZTJ0Rc4kIQ/MPZhGlCEfrBRtwlMyVQGbKGTlPCBEgOPwOuNhEqX0paHl8
	gngerSOUZrhCcR0M2L0QOPyDyat4cz2tfZB5DB/9cycUEw/XnE42xoj5rdlFI5e8
	KRbmgzCxE2dqa+VIENJ3rhpmhgaNG1AJGtSPGxI7MyxLJVre+YSHUk/Vauoo+ji3
	eaereyKyLr70MZbektMbmGZLK4l44AB/y0hYfJOh+krWuGpPGkdqTBUWZDVK/Jgq
	REbJJZnkqNoCUljd3IqcBqDj6lKAJhVowMsaRLtSfY+j0y7Ek4nLJiO1NVu4frtL
	lBpiqYal7w6OhCqjPvzcv5bDPdUL0++phhhxD5P0w7JOChGml/Ep+oMcfLGGDEA1
	AJJ77bcpYN7CA8ZXLRNGMQzNtMkKs/nU3BdjvmoHQIBbCa7oTX/+9fQbyRlLo0=
Message-ID: <9354a990-b4ef-4ca1-8666-6c5905eaf86d@prolan.hu>
Date: Mon, 3 Feb 2025 14:09:54 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] dma: Add devm_dma_request_chan()
To: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Mark Brown
	<broonie@kernel.org>, Vinod Koul <vkoul@kernel.org>, "Rafael J . Wysocki"
	<rafael@kernel.org>, <linux-spi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>
References: <20250124085221.766303-4-csokas.bence@prolan.hu>
 <20250124085221.766303-8-csokas.bence@prolan.hu>
 <20250203-chalice-ninth-8235590e29d2@thorsis.com>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <20250203-chalice-ninth-8235590e29d2@thorsis.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94852667066

Hi,

On 2025. 02. 03. 13:27, Alexander Dahl wrote:
>> +	if (!IS_ERR(chan))
>> +		ret = devm_add_action_or_reset(dev, dmaenginem_release_channel, chan);
> 
> Why not using dma_release_channel() directly here?  What's the point
> of introducing dmaenginem_release_channel() further above?

I followed the existing practice, used by 
`dmaenginem_async_device_unregister()`. I suspect it was done like this 
because the devm callback function's signature takes a `void *` and not 
`struct dma_chan *`.

Bence


