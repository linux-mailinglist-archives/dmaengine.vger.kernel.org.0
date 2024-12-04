Return-Path: <dmaengine+bounces-3898-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4839E4A30
	for <lists+dmaengine@lfdr.de>; Thu,  5 Dec 2024 00:55:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0908C282123
	for <lists+dmaengine@lfdr.de>; Wed,  4 Dec 2024 23:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F83119F49E;
	Wed,  4 Dec 2024 23:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="oTge788a"
X-Original-To: dmaengine@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C782B9B7;
	Wed,  4 Dec 2024 23:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733356516; cv=none; b=F08InoRe5JniQbCkA9mhpuzlXyRxMOQVBKz1j/2ClRTGfF/vx/g+H6AzblAT5WJvwiMk6o8FQxT41UDzjup9jP/ZGPpBT8pYb8HBjyoBg40OtF6mcGtp+DfDulf9XZPq18x6ocaDj0ER3rsJ56+HFsqSHT7DDzDrKOse37VFLyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733356516; c=relaxed/simple;
	bh=w4DwnwQZe9iqhYjIa7v7pAsGS4bSwBMahJaNaZywnvs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GGp2D7aAd34uaeKGqzFOB/tYijAA32bNHp9SCfuAdT2OQ+oBkSEltajKELnhMJjHshg/piwwTChefyJm7wxeikvv0gm4XPDJ/JX50CZuYGJMLsmC5cyep5C+/loyPT5HlR9FWQqrbsW3ZyKZG6nTGfxalqH31YZGsorjq98KI9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=oTge788a; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id A3306A073D;
	Thu,  5 Dec 2024 00:55:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=RV+fzjkuUAXvunQLcKjp
	BbQhkQYXpBIz4gwClKxSjmo=; b=oTge788a+OuVgJY0sV2M8WcxdjJ6F2IvlAd1
	vdMrVNePMOVQ/Y8sTk1alPYuiRaQOLBGgVVsMWHYyaZ/JNswfSO9iwv74HB8hrhR
	5KzFAyqb2rrXr9Wk5JsS48ojEY0EyJ+emz7+zvXcu26IqzW2devn+fAcT8WLoGf+
	DI+05sneW3Sw/WnQ8V9yAMzIP+VIQQdKDUuhGpmG7ZGYIscUKwze3TEkTtO9HZ5f
	VFnYbo5oNa2y8kgTjLj+HYuyTyjSvSYMQVxuyOkkCxP2QByzEJslY1bjRFjj6uKE
	P1M3Z9fr8f/Sv11uls8QYDquYfUH6qHd9Y8d5ZicTjfPS9Surahbc/JZoksBgAg6
	FSbu2dHZcjdHgXBw/eEUPHstfyylrSDVj/HCn/EKhX6cF1sdo0u+c0DOOuSR1VbC
	dCt//H35zQpUzHY4c+MSDmrZioSmMraRVwyVlUliTZrzyc2b5D1FNLjIrdXYVANw
	l8L2dc1GiI+p/IdcX0y3u0kJbyk2sioSrTemWrXBPfuR/B3RxxeThiOQIJKpa4T2
	a2s5wCfpDIj79gkYr7KMRbMUm0GH15wFL2y+ASXL7PyXnLYwU1stH0ZsdDpPtbyR
	4F6XdKUjohYMayzyNu81mXg0jwUMikaCaRPgreXLoQ1mbGIi4xCjgHN3ijMbwCjL
	x9oDtQ0=
Message-ID: <932d4f7a-c9cf-4e48-afd3-476b6c0fbc86@prolan.hu>
Date: Thu, 5 Dec 2024 00:55:02 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [PATCH v5 0/5] Add support for DMA of F1C100s
To: Vinod Koul <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-sunxi@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: Mark Brown <broonie@kernel.org>, Mesih Kilinc <mesihkilinc@gmail.com>,
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>, Philipp Zabel
	<p.zabel@pengutronix.de>, Conor Dooley <conor.dooley@microchip.com>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, Amit Singh Tomar <amitsinght@marvell.com>
References: <20241122161128.2619172-1-csokas.bence@prolan.hu>
 <173331833897.673424.223627111827356616.b4-ty@kernel.org>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <173331833897.673424.223627111827356616.b4-ty@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94855627561

Hi,

On 2024. 12. 04. 14:18, Vinod Koul wrote:
> 
> On Fri, 22 Nov 2024 17:11:23 +0100, Csókás, Bence wrote:
>> Support for Allwinner F1C100s/200s series audio was
>> submitted in 2018 as an RFC series, but was not merged,
>> despite having only minor errors. However, this is
>> essential for having audio on these SoCs.
>> This series was forward-ported/rebased to the best of
>> my abilities, on top of Linus' tree as of now:
>> commit 28eb75e178d3 ("Merge tag 'drm-next-2024-11-21' of https://gitlab.freedesktop.org/drm/kernel")
>>
>> [...]
> 
> Applied, thanks!
> 
> [1/5] dma-engine: sun4i: Add a quirk to support different chips
>        commit: eeca1b60138189ef1b9636709e578d0c9e0de517
> [2/5] dma-engine: sun4i: Add has_reset option to quirk
>        commit: 1f738d0c2f67ae3551e4543e8dddbfb44cdd9f53
> [3/5] dt-bindings: dmaengine: Add Allwinner suniv F1C100s DMA
>        commit: 1ad2ebf3be836e62792788f4cd105b30ca9178b6
> [4/5] dma-engine: sun4i: Add support for Allwinner suniv F1C100s
>        commit: 61785259d1eb4e4c4acef8551a2524441683dbf3

Thanks! Though unfortunately, b4 has once again mangled my sign-off, 
leaving it empty :/

Bence


