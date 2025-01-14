Return-Path: <dmaengine+bounces-4112-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 767CDA10B3A
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jan 2025 16:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E3E87A4F4D
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jan 2025 15:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354331C331E;
	Tue, 14 Jan 2025 15:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="C7iuGi9h"
X-Original-To: dmaengine@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173FF1A8408;
	Tue, 14 Jan 2025 15:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736869172; cv=none; b=KDBZxrS7s5taPS2/sanv5GjOjMPRxoY58KanPUErSDzX+hWv0cSoJALKzke2wikc37OdaJDfBRzx8kIQ9Mc/hdJOZeAIASwM/EZgXDvw4Kpa0QlqFx3hwUgJNtQalANFa0Bo+QBmjWzDWF5oUQt8zX9Ogr8v6i26avJvxJoziD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736869172; c=relaxed/simple;
	bh=MGoLXi7iDqiTZ7Un3KKjqNLgi/21OCKUtPkgTo75oAI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=TA6vLmBuZ1GesQubCa2iawuYAd1pkjBhxB8G/Ns0aItHdJi09Cm/TMw96s58wYdYT19hGUP13VwCnaClWO1AGb5xfchFlirffA7RVUpmG+YuLI2FNlEvNKnfR9ro5rzYjQ1jiwC/46N6MMu8ePm0Eb7pIv4WIcumxDFxZtp24+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=C7iuGi9h; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 92FD4A0B6F;
	Tue, 14 Jan 2025 16:39:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=GC0ts1YxPVSmYhdqyT3T
	oWQWpyfhCuhCD2/HTFBC0e0=; b=C7iuGi9hysnuVkfzrHjaU/Zr3f0stZkQ/2gJ
	+b3EiMIXZ2kiIXegRg+mBxJVoh/vUaJBqeTJK9uPotzKclUx9tW6vfOAxebOZwHH
	WHufnj0I9dEE5riEM4S90dOif+lRnFB6+fr6Dfoh55vTTAnSyRB+5iG/HAj4L4hL
	vK7aeccMH/fbuW4CtykU+Ozz09MIwdA7NLDg2x4rEdFcVTetg7kFlsxzn85rfcUw
	gIY/L+A2rm2ko1aCRFgYEpvyv5zdu1ocDetKuFMPzOqNQHBfuK9yPXT14n3a/sAa
	RuRu3HXk1nOh945Xqk7ITRdA9qfDhVx7BnT8MgejvaNfQir4zEZ2M4AcsU512u4T
	nDYseQAYBNZBYV2mL1Fg6eTr+cwRHsqZSF0HmgyuaiivQ4q3JA04mIrfK6/7DuwZ
	B6cS9pv6y8WiUOWzZLI9lUrYNTNZqnGt8BVn/n9dJTGFtPTpecfKhzWvNNn/jCpe
	wzpI9giN/Z+NxQos8P7TvP9dTs3Lyp04GnoZ3TaMfYqjK4ZpVMb995ZTsb5CttSe
	0R3xH5iapR4Sk4G+1dLElvhHvdLpryC4CmsVnAWFn6F0LdtlhLMT6hkr/uKmZSCz
	xHQ/EVZz4l1HRQcxE6UAUH0Yc2YyN3YGlpP10IvqpM1mJvNRUUs0+jRs5gZ2tLzM
	xJz3SQs=
Message-ID: <1e858844-39f5-48a6-9128-d34122e47a62@prolan.hu>
Date: Tue, 14 Jan 2025 16:39:23 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dma: Add devm_dma_request_chan()
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
To: Vinod Koul <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20241222141427.819222-1-csokas.bence@prolan.hu>
 <Z2p86Z8B/qVSFwn8@vaman> <0d77f2cc-53e2-4aad-97f5-5dd449691944@prolan.hu>
Content-Language: en-US
In-Reply-To: <0d77f2cc-53e2-4aad-97f5-5dd449691944@prolan.hu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94852647163

Hi,

On 2024. 12. 26. 15:46, Csókás Bence wrote:
> Hi,
> 
> On 2024. 12. 24. 10:20, Vinod Koul wrote:
>> On 22-12-24, 15:14, Bence Csókás wrote:
>>> Expand the arsenal of devm functions for DMA
>>> devices, this time for requesting channels.
>>
>> Looks good, users for this?
> 
> I plan to use it in drivers/spi/atmel-quadspi.c. I already have that 
> patch ready, I'll submit it once it has been tested, and after my 
> outstanding patches have been merged (linux-spi ML has been quiet during 
> the holidays, understandably), but for now I wanted to get it into 
> dmaengine, so it will be ready for the SPI guys to use.

Can this be merged or is there something I should improve upon? I want 
to submit the SPI parts to give them time before the upcoming merge window.

Bence


