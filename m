Return-Path: <dmaengine+bounces-6289-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD97B3B93F
	for <lists+dmaengine@lfdr.de>; Fri, 29 Aug 2025 12:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63E3F581BBB
	for <lists+dmaengine@lfdr.de>; Fri, 29 Aug 2025 10:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B666C30FC1F;
	Fri, 29 Aug 2025 10:52:58 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4351230FC00;
	Fri, 29 Aug 2025 10:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756464778; cv=none; b=NuAQ5xQxEpvnFRAOZBgMb2mQNFw44a/pE9pS4ceHSyVVFZB4XLonjNGwNlyV6rPuaUOllrjrzINkP6KLJ2xQc26CrRHjGjUOQs59JEZ9hHbHZ22VVUUPfyz+2Vmprx3sdK764PgGka9NxRAWSbLlN3Xrd76QhX9z7fm2k20zumM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756464778; c=relaxed/simple;
	bh=2l67HPkV8juKuiJ0waqffOy2czHKCxwzQB9FinAHhAI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D39M2Hw0QBdlZ9d4/g/US2Ebf+L9rgPPFG3CsgUk7XDGZfeJcIJwEWF79kf74lg7PJcPNZlt8w5i5ZwxXqjKX1Yreg9vaTw+D1kPamjSky5HeHdnUIHkYzmMPrnOT0rWRAzPjNzKK6SgwpYoLpvknN73sq3wctdxB+PKSq8ERbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6DE9719F0;
	Fri, 29 Aug 2025 03:52:48 -0700 (PDT)
Received: from [10.57.2.173] (unknown [10.57.2.173])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 374673F738;
	Fri, 29 Aug 2025 03:52:55 -0700 (PDT)
Message-ID: <857fd009-bfef-4da9-b6a8-832f0c8b3154@arm.com>
Date: Fri, 29 Aug 2025 11:52:51 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/14] dmaengine: dma350: Add missing dch->coherent
 setting
To: Jisheng Zhang <jszhang@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250823154009.25992-1-jszhang@kernel.org>
 <20250823154009.25992-3-jszhang@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250823154009.25992-3-jszhang@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-08-23 4:39 pm, Jisheng Zhang wrote:
> The dch->coherent setting is missing.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>   drivers/dma/arm-dma350.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/dma/arm-dma350.c b/drivers/dma/arm-dma350.c
> index bf3962f00650..24cbadc5f076 100644
> --- a/drivers/dma/arm-dma350.c
> +++ b/drivers/dma/arm-dma350.c
> @@ -587,6 +587,7 @@ static int d350_probe(struct platform_device *pdev)
>   	for (int i = 0; i < nchan; i++) {
>   		struct d350_chan *dch = &dmac->channels[i];
>   
> +		dch->coherent = coherent;

Nit: I'd put this a bit further down with the CH_LINKATTR setup, but 
otherwise,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

>   		dch->base = base + DMACH(i);
>   		writel_relaxed(CH_CMD_CLEAR, dch->base + CH_CMD);
>   


