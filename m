Return-Path: <dmaengine+bounces-1980-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7498BBB32
	for <lists+dmaengine@lfdr.de>; Sat,  4 May 2024 14:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3982E2823E6
	for <lists+dmaengine@lfdr.de>; Sat,  4 May 2024 12:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2D71C695;
	Sat,  4 May 2024 12:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l3cT+n4S"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C5D2901
	for <dmaengine@vger.kernel.org>; Sat,  4 May 2024 12:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714825585; cv=none; b=WZMVTrlq64TKauOA4OPQyUIEurIiL1jDyI2gZC078mxFER3H3nnEcKYQUoWHHadnJsYiaLmf+mY/wtzr1IiiFbp6u6Q4OmRa/swRbahWaN72aBph35LmzHerUe6CPyIzw49iJz/5CrGQi2AvcrKmFeANTsfo4jD3xHrw3eGTf6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714825585; c=relaxed/simple;
	bh=1do5iTwXvSARbinFhCA2qoCHUkZi8v3j4KFYSrgnL0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YNGKe87dgnTluGJ9iSSWDD03Yis3+fx5+heFN5y1gVCxfT7EpmGnYHaMsocwc3da/scJPLA5zZutU8ha7br97JUR673dabflj4Pbzl5yT/GHQqWhA8i066OUXSFZR0FU5qzEP8/D3ZQVqIgwCN2/FY7Z1Ii93UHJHIH6IpjieAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l3cT+n4S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA4D4C072AA;
	Sat,  4 May 2024 12:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714825584;
	bh=1do5iTwXvSARbinFhCA2qoCHUkZi8v3j4KFYSrgnL0k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l3cT+n4SIAostzyoWDMLHJwakKa8FcooZXdq3qME7T1sAcqWhxy4PSf8tbLK/9o2+
	 TfLV7QdFn2u9gYPeabHQu8B1enUdeukVRhy2k2YvHaEqh1c2VaZ3LCZHguRPD/JjB/
	 6LvOMqQUSmlcowJKi/uP/ew5N3Aj81xZWuhBaI0iZk2niqMZQuHg9pU0pUtXw3tCX1
	 zQrU4WkUi3iwnJPylAAdd6mFZIIvmkmOUe2Z1FxhGMRTCc5ROPOWmZiOMwp6zRXnqy
	 9HhlUYJ1wVHmRIt0dcjzQ6wh+tGvbHWe1UclcL29f6h3p8651XOXjqrpe/cKNswpBv
	 njyYYfmacAoCw==
Date: Sat, 4 May 2024 17:56:19 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Eric Debief <debief@digigram.com>
Cc: dmaengine@vger.kernel.org, Lizhi Hou <lizhi.hou@amd.com>,
	Brian Xu <brian.xu@amd.com>,
	Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>
Subject: Re: [PATCH] IRQ Pending signal's state leaved true once stopped
Message-ID: <ZjYpa9OQDsNL6Xlx@matsya>
References: <CALYqZ9mqnT7pP6PsZUFvp5XpmrhHXjo+0pQt7mOX2AD0noUjAQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALYqZ9mqnT7pP6PsZUFvp5XpmrhHXjo+0pQt7mOX2AD0noUjAQ@mail.gmail.com>

Hello Eric,

On 29-04-24, 16:21, Eric Debief wrote:
> Hi,
> 
> We've observed that the IRQ Pending signal's state stays TRUE once the
> XDMA channel is stopped. This is due to the missg acknowledgement
> (stats register read) on the last interrupt.
> We simply move up the status register read.
> 
> Below my patch.

Thanks for the patch, you should cc the driver authors as well for the
comments on the patch.

checkpatch would tell you that these are:
Lizhi Hou <lizhi.hou@amd.com> (supporter:XILINX XDMA DRIVER)
Brian Xu <brian.xu@amd.com> (supporter:XILINX XDMA DRIVER)
Raj Kumar Rampelli <raj.kumar.rampelli@amd.com> (supporter:XILINX XDMA DRIVER)
Michal Simek <michal.simek@amd.com> (supporter:ARM/ZYNQ ARCHITECTURE)
Vinod Koul <vkoul@kernel.org> (maintainer:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM)


> 
> Hope this helps.
> Eric.
> 
> =============================================
> >From 1f49f5e2537741949b6af90d09c8c22764333ff6 Mon Sep 17 00:00:00 2001
> From: Eric DEBIEF <debief@digigram.com>
> Date: Mon, 29 Apr 2024 16:16:45 +0200
> Subject: FIX: IRQ Pending TRUE once stopped.

subject should have tags: dmaengine: xilinx: 

> 
> The last interrupt is not acknowledged so the IRQ Pending signal's
> state is leaved TRUE. Move up the read of the status register to
> acknowledge the IRQ lowering the IRQ Pending signal's state.
> ---
>  drivers/dma/xilinx/xdma.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
> index 306099c920bb..de23f75bc76f 100644
> --- a/drivers/dma/xilinx/xdma.c
> +++ b/drivers/dma/xilinx/xdma.c
> @@ -923,16 +923,16 @@ static irqreturn_t xdma_channel_isr(int irq, void *dev_id)
> 
>      spin_lock(&xchan->vchan.lock);
> 
> -    /* get submitted request */
> -    vd = vchan_next_desc(&xchan->vchan);
> -    if (!vd)
> -        goto out;
> -
>      /* Clear-on-read the status register */
>      ret = regmap_read(xdev->rmap, xchan->base + XDMA_CHAN_STATUS_RC, &st);
>      if (ret)
>          goto out;
> 
> +    /* get submitted request */
> +    vd = vchan_next_desc(&xchan->vchan);
> +    if (!vd)
> +        goto out;
> +
>      desc = to_xdma_desc(vd);
> 
>      st &= XDMA_CHAN_STATUS_MASK;
> -- 
> 2.34.1
> 
> -- 
>  
> <https://www.digigram.com/digigram-critical-audio-at-critical-communications-world/>

-- 
~Vinod

