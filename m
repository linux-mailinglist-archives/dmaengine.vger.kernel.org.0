Return-Path: <dmaengine+bounces-3672-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6785F9B9E15
	for <lists+dmaengine@lfdr.de>; Sat,  2 Nov 2024 10:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02AB41F22656
	for <lists+dmaengine@lfdr.de>; Sat,  2 Nov 2024 09:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95FFD156F5E;
	Sat,  2 Nov 2024 09:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="gTdkGl0H"
X-Original-To: dmaengine@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC668614E;
	Sat,  2 Nov 2024 09:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730538426; cv=none; b=fhj2aavrAJWG0IDUI1D8/DmXTFjf6+MtZky6w78dyBpJIA7x2DUm1uRr2Rp0ND6txi7VyEApibc0rItLcGQaCrSNQpTR/e4qGk8dt2CaEY9EGkr/pS09HmS9F+WDgw4uQTB5h1jbkliLwsp5TJSFEUuowh/65X2acwDEfVDA9OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730538426; c=relaxed/simple;
	bh=h8vQHQdFn19/Ub89hj0xH6l3eow0nV9M8TGGwlJcoGY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iAm97QRabJC8srQfWLpt7TtSZsACDXIpt2YTGuaFMbzYOwvSWvH7Zl2ohci1//zIhaWuvWJF08CK08e9JowabO67yWhvzAvEs2+lVm2pMu1Gkw7DAko1orvcvScTSSkd5dIDf8EADkWT//7oI6X2TishYppwZtNx3Nhx91BFYS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=gTdkGl0H; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 34713A0B13;
	Sat,  2 Nov 2024 10:07:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=QrThYgcr0Uc0e/MvEh2q
	+4g7sMwdZgq7+vE/+PGa9is=; b=gTdkGl0H3jGDoSnwSbNOV3/fk/4oLSkeT7pG
	1NidGSwe6iJPmPnLMiALUGP+qnaN7qjWgI1jDz7JCrUXKuHzi2XHR90OVI41EOn9
	eUzLCcey/dwNQUnFCA6ExGI4NWXVbQl04AcnjplHdqUg7aohMUc42MfquRESmK9I
	hOhJnjK4qSgxa1JMjQ3eGIOEft1ZDX/evjLLyPy4A9aUto3o7m60V+9N7sgmQ3wV
	yEhyl2ZPy24txQyPKL+MDQGGgiNQ8zecvcM2JofggpigutC0z1BkOrv8KXGAUfVS
	La3UqMLEgCT2Pp5WHFup6IHQ5WStMMU5oTHCI+zdV6uZoHci+Y14UnHx2HzW62Hq
	oGaabzy+Yjd+wADGMn3wsRcjtcd8jBDUelmn+J2B6RTcCBkue+OLMOjwY6ak7FTF
	oXCKaVO/Xr4uycnYItQY1U65dngfx8PE1iwJxaBXcUWWgZkmwqlsPrfT+T/K3sx/
	b0H/Tp5Az0tfn20c+sb7rDJXr5HlyBrvGxpNYXBzpIatAYd4f6jOsbxB1qPpzMvi
	qMSQLaaon9Ko1UxqHdo77JG+uPsEeqnEwQNhOSfAZAbWpiGytJ52UVFy+JkbzVa5
	uQH0ZFgLg0VNAUDh0l3hTq3gQvyOhxDZRGyTxrE27xAoKswNvUzFl+SaD0TH/mAQ
	NoMxf/s=
Message-ID: <4a52cf8b-dd55-4bf8-8c37-29c07749bee0@prolan.hu>
Date: Sat, 2 Nov 2024 10:06:49 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/10] dma-engine: sun4i: Add support for Allwinner
 suniv F1C100s
To: Amit Singh Tomar <amitsinght@marvell.com>, <dmaengine@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-sunxi@lists.linux.dev>
CC: Mesih Kilinc <mesihkilinc@gmail.com>, Vinod Koul <vkoul@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
References: <20241031123538.2582675-1-csokas.bence@prolan.hu>
 <20241031123538.2582675-4-csokas.bence@prolan.hu>
 <53df7ebb-d6bf-4b34-98b6-442fdbd5d348@marvell.com>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <53df7ebb-d6bf-4b34-98b6-442fdbd5d348@marvell.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94855667067

On 2024. 10. 31. 20:05, Amit Singh Tomar wrote:
>>    #define SUN4I_DMA_CFG_SRC_ADDR_MODE(mode)    ((mode) << 5)
>>    #define SUN4I_DMA_CFG_SRC_DRQ_TYPE(type)    (type)
>> +#define SUNIV_DMA_CFG_DST_DATA_WIDTH(width)    ((width) << 24)
>> +#define SUNIV_DMA_CFG_SRC_DATA_WIDTH(width)    ((width) << 8)
> 
> nit: Are the extra parentheses around width truly necessary? They seem 
> to be used throughout the file.

It's macro safety. So for instance if someone writes 
~SUNIV_DMA_CFG_DST_DATA_WIDTH(1 + 2), which would expand to ~1 + 2 << 24 
it doesn't get mis-interpreted as (~1) + (2 << 24) for instance. So 
yeah, I sure hope that _all code_ that has macros with parameters did 
not forget to wrap everything in parentheses, and not just "throughout 
[this] file".

Bence


