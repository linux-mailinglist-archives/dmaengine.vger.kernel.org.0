Return-Path: <dmaengine+bounces-7010-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF528C0DF7A
	for <lists+dmaengine@lfdr.de>; Mon, 27 Oct 2025 14:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 795103BF0CC
	for <lists+dmaengine@lfdr.de>; Mon, 27 Oct 2025 13:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4DAC278E5D;
	Mon, 27 Oct 2025 13:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="drrchgbP"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0C0277013;
	Mon, 27 Oct 2025 13:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761570889; cv=none; b=gUfpYbzEczxG10e8tZgu3Wt7kMu2mNw0lq7Y0oZdGsmin0CXElC59OMYKSFrjeU5hRtjcbj5CTNmkKK6PLkc7aAUM5dPmVeJIU66c7RsK+Ha86Xt9ILQKqjYIecb7Ye96tu+51u3HwtCJzplwbS/M0rLxfIBQ/5Q7/kP8H/MKxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761570889; c=relaxed/simple;
	bh=XuN3krT3VrB+Dun/3yc/k+0qdjnIcRXAYhDM84Mny+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RlcpIstYMScxwmTcZd3qUR6c1MdxyS2bCcO+854IcC+cA/mmHe7L8GCtoGlhx7b5/4dgnazfirepm0hSpTIyHEmasHjw18gEx5HUestngPBHsOoUBwm6OFq39xGpTybZ+/UiGDk+VMFaJ9Rlhe6JpiQfLdeG9TMrc1rt13FM8gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=drrchgbP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5BACC4CEF1;
	Mon, 27 Oct 2025 13:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761570888;
	bh=XuN3krT3VrB+Dun/3yc/k+0qdjnIcRXAYhDM84Mny+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=drrchgbPRwY7oQumnMjLGZOM6Rh0ki+cX156YrWkf4iFYcxJWm6TFCF2Zmuw65obA
	 jrhZigPralblTl4s8KOTZFdgSMFDSydxbVvVcUVyUkAeuGnyUkMuGwgaYhCiJ5i3I7
	 puj9nkUs2j02igv945LuTeWo4r3FtVerhOWVT1Tqj9GY9x3PWfN9f3m77cywWdHhIC
	 42s3OzxCrh+jxffqYJmQlC54CHr7tL1cb6NHRDTCTuYFuWiUI5pM6ts/gKob+gZ85f
	 2RxVLGDuoBjVp0u/z5oVTSlcr8BICb9H2THWEGN79LhenOzX6HOkbhJxkUHgK/7zvF
	 6SQsAmNzes38A==
Date: Mon, 27 Oct 2025 18:44:38 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Devendra K Verma <devendra.verma@amd.com>
Cc: bhelgaas@google.com, vkoul@kernel.org, dmaengine@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, michal.simek@amd.com
Subject: Re: [PATCH RESEND v4 2/2] dmaengine: dw-edma: Add non-LL mode
Message-ID: <4rmlsvc4zffwlv6iye4sotpe3ezhblhlps6qglokrztno3wxte@tqiuci6fvcmn>
References: <20251014121635.47914-1-devendra.verma@amd.com>
 <20251014121635.47914-3-devendra.verma@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251014121635.47914-3-devendra.verma@amd.com>

On Tue, Oct 14, 2025 at 05:46:34PM +0530, Devendra K Verma wrote:
> AMD MDB IP supports Linked List (LL) mode as well as non-LL mode.

Isn't the patch adding non-LL mode for all platforms, not just for AMD?

> The current code does not have the mechanisms to enable the
> DMA transactions using the non-LL mode. The following two cases
> are added with this patch:
> - When a valid physical base address is not configured via the
>   Xilinx VSEC capability then the IP can still be used in non-LL
>   mode. The default mode for all the DMA transactions and for all
>   the DMA channels then is non-LL mode.
> - When a valid physical base address is configured but the client
>   wants to use the non-LL mode for DMA transactions then also the
>   flexibility is provided via the peripheral_config struct member of
>   dma_slave_config. In this case the channels can be individually
>   configured in non-LL mode. This use case is desirable for single
>   DMA transfer of a chunk, this saves the effort of preparing the
>   Link List.
> 
> Signed-off-by: Devendra K Verma <devendra.verma@amd.com>
> ---
> Changes in v4
>   No change
> 
> Changes in v3
>   No change
> 
> Changes in v2
>   Reverted the function return type to u64 for
>   dw_edma_get_phys_addr().
> 
> Changes in v1
>   Changed the function return type for dw_edma_get_phys_addr().
>   Corrected the typo raised in review.
> ---
>  drivers/dma/dw-edma/dw-edma-core.c    | 38 ++++++++++++++++++---
>  drivers/dma/dw-edma/dw-edma-core.h    |  1 +
>  drivers/dma/dw-edma/dw-edma-pcie.c    | 44 +++++++++++++++++--------
>  drivers/dma/dw-edma/dw-hdma-v0-core.c | 62 ++++++++++++++++++++++++++++++++++-
>  include/linux/dma/edma.h              |  1 +
>  5 files changed, 127 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index b43255f..3283ac5 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -223,8 +223,28 @@ static int dw_edma_device_config(struct dma_chan *dchan,
>  				 struct dma_slave_config *config)
>  {
>  	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
> +	int nollp = 0;

s/nollp/non_ll

> +
> +	if (WARN_ON(config->peripheral_config &&
> +		    config->peripheral_size != sizeof(int)))

Use proper dev_err(), not WARN_ON.

> +		return -EINVAL;
>  
>  	memcpy(&chan->config, config, sizeof(*config));
> +
> +	/*
> +	 * When there is no valid LLP base address available
> +	 * then the default DMA ops will use the non-LL mode.
> +	 * Cases where LL mode is enabled and client wants
> +	 * to use the non-LL mode then also client can do
> +	 * so via providing the peripheral_config param.

Make use of 80 columns for comments throughout this patch.

Rest LGTM!

- Mani

-- 
மணிவண்ணன் சதாசிவம்

