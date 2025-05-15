Return-Path: <dmaengine+bounces-5179-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8811AB8285
	for <lists+dmaengine@lfdr.de>; Thu, 15 May 2025 11:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 714E07B698C
	for <lists+dmaengine@lfdr.de>; Thu, 15 May 2025 09:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D927229712E;
	Thu, 15 May 2025 09:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="pLkczEHj"
X-Original-To: dmaengine@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9536F29672F;
	Thu, 15 May 2025 09:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747301222; cv=none; b=fWzXWIWHU02EBmh9b26xDbfCce6WnxZpdDe9ttmV77hmAQ1ozCkcGoB/AaNIPs6JZWxiHKeyc2TNKl4IVB+7zhCQkCb/Q6q3HD+niJru0WxsBAjMLVdKGya5m0EQu9Sn2YGBlb5iNjNb+RQC56sLiiuwBQhKZkREXkGjdUmVqV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747301222; c=relaxed/simple;
	bh=S6zEEqZ7XzVr8Ft6SXafxnt9X1JbkToWYQSIGNNYSq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TJ9vcCBGgGa4wQHj6e2GN/F9XpyPXVsf7xvXYseGam5WkkgeztN166/tZvVvdAAAhhukePaDLiKNStsckL8DJdt1MGrLZj3XV/MfRJyAX2w2B2Gshxdb3kPhigsb9s3Xe1mHJ5E7iyrDkH+yu1xowCUWDtzwWAeg7nz2Uaub9Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=pLkczEHj; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 780BCA0149;
	Thu, 15 May 2025 11:26:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=ubCfZqnUCO4PP/bK7tVa
	PooeXZwMddulOK5iV2CA9+w=; b=pLkczEHjHfzoDsoFPgNwkuAKJL+9PunTHLhx
	tgUiuREirMWir6ZXaPHUPerKZST1XdJLonM2kdiuvzyaREXhUSl+whgNGA7C6crB
	S6F5iFaPVvnU+2TEfYpgbXYmh38WdDpKb7JxweaJusQ35Mi2dIwU7ibb3uI0J+KR
	k4mfqfl4q18OzECYimwK9zWgRTWQYruap8fcRYnhyO7aUKtiCPIUrD+oRyenU8+K
	n/CcICixGzzaz9Gdfejusx/JrcjyIEYvd1HVCoHUpvrRSDa5mJsadMWogpO3Zlbk
	2f8ZrDGnz8riHlG86Prpd/Um0+xe+eS+i2R1xYNsUAwHuEoWSi9Y2LlJfJ5I6nZ3
	a7b0helHriLNUldNahETbvZCgCfLNJJMSsHaLRleW8n2yK7WrUHD3LEXsMkKDA/N
	bmGq/Pr1XRDQSUI/sVlex1QhfLsbMLqJ3RFNjq28WbELXB7isS9RgLVgxrY83Ks+
	vEK4cUYgOKK59B4jNHN5dzzOrePbCjGp+APfAl6TVBk4SEj+qYJWuAqtSG0Vo6vI
	Gs9XmmzC2sae83NjO8VwEsjfimmavGYdZkmChEfwYSCGVxaQEyRNO1ZFXFW2qlo0
	hNbvndPXTXVflP4bsDVXcaLuz5pnWkIYLPSuR9NFgBx3cU/sPOJQv6wtOL7UROuK
	U6YQat8=
Message-ID: <9d384301-3f73-4120-a82b-580eb5f1a4ed@prolan.hu>
Date: Thu, 15 May 2025 11:26:57 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/2] Add `devm_dma_request_chan()` to simplify probe
 path in atmel-quadspi.c
To: Mark Brown <broonie@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-spi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>, "Vinod
 Koul" <vkoul@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>, "Rafael J. Wysocki" <rafael@kernel.org>, "Tudor
 Ambarus" <tudor.ambarus@linaro.org>
References: <20250515083132.255410-1-csokas.bence@prolan.hu>
 <aCWpjplhAXUvr9fj@finisterre.sirena.org.uk>
 <e4e6c7a9-9b7a-4012-8bda-75804229ec95@prolan.hu>
 <aCWyXsJ2iRXRUmOi@finisterre.sirena.org.uk>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <aCWyXsJ2iRXRUmOi@finisterre.sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: sinope.intranet.prolan.hu (10.254.0.237) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A296767155D617062

Hi,

On 2025. 05. 15. 11:22, Mark Brown wrote:
> On Thu, May 15, 2025 at 11:14:22AM +0200, Csókás Bence wrote:
>> On 2025. 05. 15. 10:45, Mark Brown wrote:
> 
>>> I can't tell what the plan is here, or what the status is for the first
>>> patch (since I'm not CCed).  The second patch depends on a new API
>>> introduced in the first patch so it can't be merged independently.
> 
>> Yes, the situation is a bit convoluted. Obviously 2/2 will be applied after
>> 1/2, in a similar vein than the former PM series.
> 
>> So what I was trying to say: Vinod should be able to apply 1/2 to his branch
>> (dma/next) right now, which can then be merged to spi/for-next. This merged
>> branch should be able to then cleanly apply 2/2.
> 
> I wouldn't expect to pull the whole DMA tree in, that'll have a huge
> amount of extra stuff in it - if I was going to pull something I'd
> expect a topic branch. 

Fair point.

> Wouldn't it be simpler for me to just apply both
> patches at this point if there's no conflicts with the DMA tree?  We're
> at -rc6 now...

That also works for me. I should send 1/2 to you as well, correct?

Bence


