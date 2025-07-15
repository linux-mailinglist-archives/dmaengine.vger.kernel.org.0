Return-Path: <dmaengine+bounces-5826-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF15B06291
	for <lists+dmaengine@lfdr.de>; Tue, 15 Jul 2025 17:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8920B18975DB
	for <lists+dmaengine@lfdr.de>; Tue, 15 Jul 2025 15:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D39F21421E;
	Tue, 15 Jul 2025 15:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cMFR2ESa"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433CA212B0A;
	Tue, 15 Jul 2025 15:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752592275; cv=none; b=Bq5O/jNDgeXIIaSI+oIUmsRXUljsOdJCLvSUg4aQGrz2Y/0/2k0oVj57MkKwufWS66T5o+Yjjga8DvtbtlwC+JgQXq3RCA87jO6bcO8vKKG8SB/XzPZxWHeqE6iUnUoMvsoy2qo2e1YP1CkqEqFT32FXx0Bq67SWDS2H96AFVbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752592275; c=relaxed/simple;
	bh=xZ7HUEdlujqe8L2cH/lceRSD0/mLPz28HfkvjHjeJNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=joqDMG20qrYh8C09FNYoDWSfaOBpCv4IW4m8hl3fXDAkGYnPUsOgdxXMgDejvheuEx63pj2Qjj13yI46pv8cC09abYFucrQKqVcFZkcNQdGa+56MN3RXkamhG4BiROa/S5moWg0NyapNT1H9QxsgxshmOIcXGglmT063n345/qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cMFR2ESa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5055C4CEE3;
	Tue, 15 Jul 2025 15:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752592275;
	bh=xZ7HUEdlujqe8L2cH/lceRSD0/mLPz28HfkvjHjeJNs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cMFR2ESaT0s7UI+tXZbGBwXjdsJZOiTEo1nXXz0sBlDOh4MDzw+JdZMFGHu8i4NHo
	 /SnT4cCVR5gagJjmfo4DurWGx6Yrq4Dywif5x5qI+DSFlO4GJBtCL6u4NBORs5U4Pl
	 SV0oZv3Dm1SHDHWg/RQz8R7RW72ByyXb4WDRt8qzw/152cPgG04S7rKu2I5misbkfc
	 es4PaDfL3IfPcvZmBz7B1gguPbhg0twpvhWcKTo9maN2NAdrW4XOG7MzOagoXjj5K3
	 gfJwSlCAcBoLcU5+y3AuAgBx4QHEDPT9JEwGZFITgRhYFo6KropW6I0mgVCWdKz2oL
	 cYtsqLLc7yh6g==
Date: Tue, 15 Jul 2025 20:41:11 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: nbpfaxi: Fix possible array access out of
 bounds of nbpf->chan
Message-ID: <aHZvjxx6Mn7_roLt@vaman>
References: <20250707082353.40402-2-fourier.thomas@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707082353.40402-2-fourier.thomas@gmail.com>

On 07-07-25, 10:23, Thomas Fourier wrote:
> The nbpf is alloc'd at line 1324 with a size of num_channels so it seems
> like the maximum index of nbpf->chan should be num_channels - 1.

I have already applied a patch from Dan sent earlier for this

> 
> Fixes: b45b262cefd5 ("dmaengine: add a driver for AMBA AXI NBPF DMAC IP cores")
> Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
> ---
>  drivers/dma/nbpfaxi.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/nbpfaxi.c b/drivers/dma/nbpfaxi.c
> index 0b75bb122898..dd1b5e2a603c 100644
> --- a/drivers/dma/nbpfaxi.c
> +++ b/drivers/dma/nbpfaxi.c
> @@ -1364,7 +1364,7 @@ static int nbpf_probe(struct platform_device *pdev)
>  	if (irqs == 1) {
>  		eirq = irqbuf[0];
>  
> -		for (i = 0; i <= num_channels; i++)
> +		for (i = 0; i < num_channels; i++)
>  			nbpf->chan[i].irq = irqbuf[0];
>  	} else {
>  		eirq = platform_get_irq_byname(pdev, "error");
> @@ -1374,7 +1374,7 @@ static int nbpf_probe(struct platform_device *pdev)
>  		if (irqs == num_channels + 1) {
>  			struct nbpf_channel *chan;
>  
> -			for (i = 0, chan = nbpf->chan; i <= num_channels;
> +			for (i = 0, chan = nbpf->chan; i < num_channels;
>  			     i++, chan++) {
>  				/* Skip the error IRQ */
>  				if (irqbuf[i] == eirq)
> @@ -1391,7 +1391,7 @@ static int nbpf_probe(struct platform_device *pdev)
>  			else
>  				irq = irqbuf[0];
>  
> -			for (i = 0; i <= num_channels; i++)
> +			for (i = 0; i < num_channels; i++)
>  				nbpf->chan[i].irq = irq;
>  		}
>  	}
> -- 
> 2.43.0

-- 
~Vinod

