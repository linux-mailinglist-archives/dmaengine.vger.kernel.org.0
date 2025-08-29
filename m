Return-Path: <dmaengine+bounces-6287-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E4FB3B917
	for <lists+dmaengine@lfdr.de>; Fri, 29 Aug 2025 12:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78A811898D98
	for <lists+dmaengine@lfdr.de>; Fri, 29 Aug 2025 10:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E5C5308F28;
	Fri, 29 Aug 2025 10:42:20 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A681F1DF256;
	Fri, 29 Aug 2025 10:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756464140; cv=none; b=u3+aR8gZwU2TzJ9H5LdW39gftJAet+2ucZPESSOb/jqMUDae7d7y8Qjf/DjrX6JPU1izCTQV+V1chWVgNqDB4qyIgU4+5T4e1uPNQ7omnck28b5Kn5am6PEIrVIyD/MpVDSAinzcRK4FedeA+Loa3EKVWujJ7fm6iITBh8aEQ0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756464140; c=relaxed/simple;
	bh=aFdcT1yGvukedW5XAGEkcoVpZvRVh3oYvF7vpSbvAOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jiy7hgiNkykhlji6SVCpOfFhy8cOipSc8e2y+22XPjXGSvDdW/DKNGczK1p0ztmZBg2KuLaWpHXB1+b0Xf2xBEs1wSh3MMhtZ1/j0J5F5xR3aK4Ge0bI1KtZGdreJePcx0VDMJDFo23US2sKBmiDl4xhK5OeP6vHRj8nYgLNwjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BAC301758;
	Fri, 29 Aug 2025 03:42:09 -0700 (PDT)
Received: from [10.57.2.173] (unknown [10.57.2.173])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7F63F3F694;
	Fri, 29 Aug 2025 03:42:16 -0700 (PDT)
Message-ID: <57528c01-2a1c-4d70-b70c-ed4b64bd93fc@arm.com>
Date: Fri, 29 Aug 2025 11:42:14 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/14] dmaengine: dma350: Check dma_cookie_status() ret
 code and txstate
To: Jisheng Zhang <jszhang@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250823154009.25992-1-jszhang@kernel.org>
 <20250823154009.25992-5-jszhang@kernel.org>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20250823154009.25992-5-jszhang@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-08-23 4:39 pm, Jisheng Zhang wrote:
> If dma_cookie_status() returns DMA_COMPLETE, we can return immediately.
> 
>  From another side, the txstate is an optional parameter used to get a
> struct with auxilary transfer status information. When not provided
> the call to device_tx_status() should return the status of the dma
> cookie. Return the status of dma cookie when the txstate optional
> parameter is not provided.

Again, the current code was definitely intentional - I think this was 
down to the hardware error case, where for reasons I now can't remember 
I still had to nominally complete the aborted descriptor from the IRQ 
handler to avoid causing some worse problem, and hence we don't return 
early without cross-checking dch->status here, because returning 
DMA_COMPLETE when the descriptor hasn't done its job makes dmatest unhappy.

I did spend a *lot* of time exercising all the error cases, and trying 
to get a sensible result across all of the different reporting APIs was 
fiddly to say the least - there's a huge lack of consistency between 
drivers in this regard, and this was just my attempt to be the 
least-worst one :)

Thanks,
Robin.

> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>   drivers/dma/arm-dma350.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/dma/arm-dma350.c b/drivers/dma/arm-dma350.c
> index 96350d15ed85..17af9bb2a18f 100644
> --- a/drivers/dma/arm-dma350.c
> +++ b/drivers/dma/arm-dma350.c
> @@ -377,6 +377,8 @@ static enum dma_status d350_tx_status(struct dma_chan *chan, dma_cookie_t cookie
>   	u32 residue = 0;
>   
>   	status = dma_cookie_status(chan, cookie, state);
> +	if (status == DMA_COMPLETE || !state)
> +		return status;
>   
>   	spin_lock_irqsave(&dch->vc.lock, flags);
>   	if (cookie == dch->cookie) {


