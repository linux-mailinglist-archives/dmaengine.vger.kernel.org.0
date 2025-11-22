Return-Path: <dmaengine+bounces-7297-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DAFDC7CB49
	for <lists+dmaengine@lfdr.de>; Sat, 22 Nov 2025 10:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8D5E3A8614
	for <lists+dmaengine@lfdr.de>; Sat, 22 Nov 2025 09:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4AFB23AB88;
	Sat, 22 Nov 2025 09:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DisgpbN3"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E0C1A38F9;
	Sat, 22 Nov 2025 09:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763803691; cv=none; b=b0FBfa1cpYHim3Q4hUz51ycYHbYyNqBSA60NqIIRsNLbIvKh5BKume/uT14SHc/t1O4fIMYjCXAINqKVYjVca0Sp8DFe4cFaH708rmpNCqTmV3pr7aJqalDBat9QkckangxyAAwiTWa4z+JForAI6vJEQHG4PMw3KdGrZzyJeAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763803691; c=relaxed/simple;
	bh=fCIbXX1DxW/p/enlcdbuN2TWu+7bm/aQ64q3BvK3u18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KhjapSFb+PE+rXMLo3786i8QV+kyy2AYQq1N97P1yLniw0509OHwfAaWCRiwWAEofApqHIIDTKgDaZyO+LiQklS4oDRPksymhe6TnD37TMh507koAGVVZRUN74xLM2yMWAWqKinqYowbXNaHsaxi0H4vVAjPetOIgv9z/8iS/gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DisgpbN3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C475C4CEF5;
	Sat, 22 Nov 2025 09:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763803689;
	bh=fCIbXX1DxW/p/enlcdbuN2TWu+7bm/aQ64q3BvK3u18=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DisgpbN3ZfdHjexeiluYB2gdCO4W8W/Yna3K8wMg3GxXQUCGIr3NDCdE9MmA+IdaH
	 J2T+CeJpRsyxmJK3JzP47v5eJw6Mh7zz2+X+XjlIkZUJkkSTUYvrNBxt8TANeorEzU
	 PuxfeVwakWGXE1NdvP+cWodKsPNu0/Jmo0OLYch4z2nrVBTqtJhP7SUtGiIsEpmeIX
	 RI0xQRejV5zAsp8sEMFgkSqB04mZ7iDCRQrJKozNUtw080FJHRxH8GaJCwszr6YkKa
	 O63PxslQM/ZZBDnko/tYirovuzqmK0HHGKBK0HvytNqtw4kiPsCoTvWPTcR8DSULew
	 wxgBWlioyUmTQ==
Date: Sat, 22 Nov 2025 14:58:05 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Stefan Wahren <wahrenst@gmx.net>,
	Thomas Andreatta <thomasandreatta2000@gmail.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	Olivier Dautricourt <olivierdautricourt@gmail.com>,
	Stefan Roese <sr@denx.de>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Lizhi Hou <lizhi.hou@amd.com>, Brian Xu <brian.xu@amd.com>,
	Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>,
	Michal Simek <michal.simek@amd.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 07/13] dmaengine: lgm: use sg_nents_for_dma() helper
Message-ID: <aSGCJQc152Y9V10E@vaman>
References: <20251110103805.3562136-1-andriy.shevchenko@linux.intel.com>
 <20251110103805.3562136-8-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251110103805.3562136-8-andriy.shevchenko@linux.intel.com>

On 10-11-25, 11:23, Andy Shevchenko wrote:
> Instead of open coded variant let's use recently introduced helper.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/dma/lgm/lgm-dma.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/dma/lgm/lgm-dma.c b/drivers/dma/lgm/lgm-dma.c
> index 8173c3f1075a..7d4d3dde6d88 100644
> --- a/drivers/dma/lgm/lgm-dma.c
> +++ b/drivers/dma/lgm/lgm-dma.c
> @@ -1164,8 +1164,8 @@ ldma_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
>  	struct dw2_desc *hw_ds;
>  	struct dw2_desc_sw *ds;
>  	struct scatterlist *sg;
> -	int num = sglen, i;
>  	dma_addr_t addr;
> +	int num, i;
>  
>  	if (!sgl)
>  		return NULL;
> @@ -1173,12 +1173,7 @@ ldma_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
>  	if (d->ver > DMA_VER22)
>  		return ldma_chan_desc_cfg(chan, sgl->dma_address, sglen);
>  
> -	for_each_sg(sgl, sg, sglen, i) {
> -		avail = sg_dma_len(sg);
> -		if (avail > DMA_MAX_SIZE)
> -			num += DIV_ROUND_UP(avail, DMA_MAX_SIZE) - 1;
> -	}
> -
> +	num = sg_nents_for_dma(sgl, sg_len, DMA_MAX_SIZE);

drivers/dma/lgm/lgm-dma.c:1176:37: error: ‘sg_len’ undeclared (first use in this function); did you mean ‘sglen’?
         num = sg_nents_for_dma(sgl, sg_len, DMA_MAX_SIZE);

I am getting the build failure, as well as few unused warning with this,
pls fix

-- 
~Vinod

