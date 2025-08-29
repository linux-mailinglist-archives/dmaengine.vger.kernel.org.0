Return-Path: <dmaengine+bounces-6286-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0F3B3B805
	for <lists+dmaengine@lfdr.de>; Fri, 29 Aug 2025 12:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42ED91BA1ADB
	for <lists+dmaengine@lfdr.de>; Fri, 29 Aug 2025 10:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B78029B228;
	Fri, 29 Aug 2025 10:02:18 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C4B2356B9;
	Fri, 29 Aug 2025 10:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756461738; cv=none; b=R0aBR6/fbAx42QGCXexZDuBGFHvQKOZnaK1vZsOZJ2DRvenJyGOP8RfeiVXjnubkX1WfdHRcvukCPRByAlpGtpuLH974AkSCL1mMtzrFHjCZR/H9AOA1BEusI74iqBpTIZk/RfbXHp7vD+Gmx4r31AU8HZ9bS82gBHmbuvXfr8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756461738; c=relaxed/simple;
	bh=DrQaeHhNiQJS79bx/Swtonuixek3OXzAvPbA8YKO6gk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HGahWHWTU9fwaBvVhTfHM8mQCpBV0rMQ/6BU510AeaGBdKlzOnnIk9sNmkLZfRn/U9BQx5gGZm1g2vmlVoLeVKTWTd9QzE9FXvuX2lCHcPgExNAnN1gH/Q3qEooTky0uaqaKwGcdLgF7ugZk2bETxdJrIwnsdEorr8Xu9RmtIKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 10BF51758;
	Fri, 29 Aug 2025 03:02:07 -0700 (PDT)
Received: from [10.57.2.173] (unknown [10.57.2.173])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ACCDD3F694;
	Fri, 29 Aug 2025 03:02:13 -0700 (PDT)
Message-ID: <82cf913c-f050-4325-ac5b-7efd0634d8ff@arm.com>
Date: Fri, 29 Aug 2025 11:02:06 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/14] dmaengine: dma350: Check vchan_next_desc() return
 value
To: Jisheng Zhang <jszhang@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250823154009.25992-1-jszhang@kernel.org>
 <20250823154009.25992-4-jszhang@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250823154009.25992-4-jszhang@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-08-23 4:39 pm, Jisheng Zhang wrote:
> vchan_next_desc() may return NULL, check its return value.

IIRC it's important that dch->desc gets set to NULL in that case, 
otherwise things can go wonky after a completion interrupt - i.e. the 
current code *is* using the return value both ways, just the sneaky 
thing is that it does actually depend on "vd" being the first member of 
d350_desc to do it concisely, sorry I didn't document that.

Thanks,
Robin.
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>   drivers/dma/arm-dma350.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/arm-dma350.c b/drivers/dma/arm-dma350.c
> index 24cbadc5f076..96350d15ed85 100644
> --- a/drivers/dma/arm-dma350.c
> +++ b/drivers/dma/arm-dma350.c
> @@ -399,11 +399,14 @@ static enum dma_status d350_tx_status(struct dma_chan *chan, dma_cookie_t cookie
>   static void d350_start_next(struct d350_chan *dch)
>   {
>   	u32 hdr, *reg;
> +	struct virt_dma_desc *vd;
>   
> -	dch->desc = to_d350_desc(vchan_next_desc(&dch->vc));
> -	if (!dch->desc)
> +	vd = vchan_next_desc(&dch->vc);
> +	if (!vd)
>   		return;
>   
> +	dch->desc = to_d350_desc(vd);
> +
>   	list_del(&dch->desc->vd.node);
>   	dch->status = DMA_IN_PROGRESS;
>   	dch->cookie = dch->desc->vd.tx.cookie;


