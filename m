Return-Path: <dmaengine+bounces-6427-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1917AB4997B
	for <lists+dmaengine@lfdr.de>; Mon,  8 Sep 2025 21:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27E461B27C09
	for <lists+dmaengine@lfdr.de>; Mon,  8 Sep 2025 19:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44D528399;
	Mon,  8 Sep 2025 19:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="IW2jLAAo"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-25.smtpout.orange.fr [80.12.242.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7610238145;
	Mon,  8 Sep 2025 19:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757358662; cv=none; b=P15OPTPrA7XoC/RGLgMdFEupw38W3ygn0niaIG9QNTQS/RuRnO/jpgkWQdWKNyAWcew+eFGoR6HAHFArltGdDDZpPlfUohzi5lxhKi6e1t3LmUrpYdkz7pw1jPdL2ZT9ce0BTcxW10q1rL+8r+TQgurEZnY5JcHo8bjfEwtxjgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757358662; c=relaxed/simple;
	bh=tTBO3ID1sSLMqsaIgfCHRdhJIAbh9CxxbXuceyAkEeA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EDcKRdXg7Ck3geVUP5CDb6SdW1oo48wHPPPC2YDix0vss+/7DSeFnQ2aIhJe6AcP5KJfmg8h/DDacjAXBczbgXCSHZvMPpQM10W/HAWi/l2qo9jG7f7P7HeWw0KocAXFLcrRK6Zbswj4NUq0P4OQkxR2JgwFiB6fi4nE+bmUvcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=IW2jLAAo; arc=none smtp.client-ip=80.12.242.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
 ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id vh7euvs8y7bJuvh7euwvlT; Mon, 08 Sep 2025 21:01:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1757358112;
	bh=SbDQh+dq477IG9GnwF+qupUP95OW5dWCgqdgVseqW7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=IW2jLAAojlH8bcSUDIauQOCw9WZ5y1bfEoM7tzkd8h/ViBbPnBCmc/2SalNsr/vuU
	 c6Xp2sHgFmPoN4CZue4uwI9laSf5AsmISLr8gguJwpIL0U1pdLHBuj9nFYs5nZZ58v
	 McVOqwlubSypGuM1d0AP1PnLFDt3y0F84/8rtbmER4nfs9D05JnwRR1OsTRy4KzKxt
	 z9uviNaAtnM1A9UMRuvIa0rdDgZVACBtDqo2lNIIpUQNJqbJth7GqASeHbYaSJWNJ9
	 eAhwYohlA+BdnSI8WuSghSldt3pLSnleEc8V8oWiKumbomI+kf+u0rKcnlFMuiiiKY
	 YNfjKsASSfxUA==
X-ME-Helo: [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Mon, 08 Sep 2025 21:01:52 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
Message-ID: <762f7869-3c8b-44c3-a4f9-bf0d443673de@wanadoo.fr>
Date: Mon, 8 Sep 2025 21:01:50 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] dmaengine: ti: edma: Fix memory allocation size for
 queue_priority_map
To: Anders Roxell <anders.roxell@linaro.org>, peter.ujfalusi@gmail.com,
 vkoul@kernel.org, nathan@kernel.org
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev, dan.carpenter@linaro.org, arnd@arndb.de,
 benjamin.copeland@linaro.org
References: <20250829232132.GA1983886@ax162>
 <20250830094953.3038012-1-anders.roxell@linaro.org>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Content-Language: en-US, fr-FR
In-Reply-To: <20250830094953.3038012-1-anders.roxell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 30/08/2025 à 11:49, Anders Roxell a écrit :
> Fix a critical memory allocation bug in edma_setup_from_hw() where
> queue_priority_map was allocated with insufficient memory. The code
> declared queue_priority_map as s8 (*)[2] (pointer to array of 2 s8),
> but allocated memory using sizeof(s8) instead of the correct size.
> 
> This caused out-of-bounds memory writes when accessing:
>    queue_priority_map[i][0] = i;
>    queue_priority_map[i][1] = i;
> 
> The bug manifested as kernel crashes with "Oops - undefined instruction"
> on ARM platforms (BeagleBoard-X15) during EDMA driver probe, as the
> memory corruption triggered kernel hardening features on Clang.
> 
> Change the allocation to use sizeof(*queue_priority_map) which
> automatically gets the correct size for the 2D array structure.
> 
> Fixes: 2b6b3b742019 ("ARM/dmaengine: edma: Merge the two drivers under drivers/dma/")
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>   drivers/dma/ti/edma.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
> index 3ed406f08c44..552be71db6c4 100644
> --- a/drivers/dma/ti/edma.c
> +++ b/drivers/dma/ti/edma.c
> @@ -2064,8 +2064,8 @@ static int edma_setup_from_hw(struct device *dev, struct edma_soc_info *pdata,
>   	 * priority. So Q0 is the highest priority queue and the last queue has
>   	 * the lowest priority.
>   	 */
> -	queue_priority_map = devm_kcalloc(dev, ecc->num_tc + 1, sizeof(s8),
> -					  GFP_KERNEL);
> +	queue_priority_map = devm_kcalloc(dev, ecc->num_tc + 1,
> +					  sizeof(*queue_priority_map), GFP_KERNEL);
>   	if (!queue_priority_map)
>   		return -ENOMEM;
>   

Hi,

for what it worth:
Acked-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

and for the records:
  
https://lore.kernel.org/all/8c95c485be294e64457606089a2a56e68e2ebd1a.1653153959.git.christophe.jaillet@wanadoo.fr/

;-)

IMHO, the applied solution is cleaner than mine.

Only the Fixes tag could be more relevant (because, the issue is older 
than 2b6b3b742019), but I don't think it will make any difference.

CJ


