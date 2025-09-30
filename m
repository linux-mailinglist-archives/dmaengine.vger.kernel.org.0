Return-Path: <dmaengine+bounces-6734-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55616BAEA9D
	for <lists+dmaengine@lfdr.de>; Wed, 01 Oct 2025 00:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72ABF165423
	for <lists+dmaengine@lfdr.de>; Tue, 30 Sep 2025 22:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185C01D5AC6;
	Tue, 30 Sep 2025 22:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TPNh/vzO"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CB619C540;
	Tue, 30 Sep 2025 22:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759270208; cv=none; b=KURdkUqdMMXfrzH9WRBghTiYDzwtL2uByEMnqFHh4mPlmWV2iCjW/2vlaeIc+XQ7gdL1PuihqM5u7RpWVviQohYP9XWr6JNpY4qQGZmFiX+aEN6gQK29/ofQZezeMXw9MP1m6apcYki3mUzbI/chApHrjzQ/TYMGFEiU6tL/hys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759270208; c=relaxed/simple;
	bh=hMd/AM3ewIb0jj5ghCyFKoP7KwuS14FKJyK/ph0ODyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R76PwpEvwWzpp2VLsNTLJ+XlGoDg2FYzLCHC2IxSKQ+zvZsQJd+lgmPCRTKC2z8GnT6ndm7kBubewDwzsUlm+DE436STZbR0xISszSDEkQTH1MSX+l1uc2sdTQBskdjOxe/8LhCWgskbRUpN1Pv+jaaGHBqA2mMS2lUOPblK+ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TPNh/vzO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6719BC4CEF7;
	Tue, 30 Sep 2025 22:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759270207;
	bh=hMd/AM3ewIb0jj5ghCyFKoP7KwuS14FKJyK/ph0ODyM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TPNh/vzOa3u/0div8i87Dy9LaaSnw20oVgnYVKRcud+Zud4VcP9sdUT86mvKLNaSX
	 4hAApTJERCXEwxyMUHksxymNDRP4jpQlEa1yLP9f1nLujyT+hadzblmndZVvy4p/rN
	 kOvmUxDy/rtBUz2UkbWzN91Jesm1MVMAi+AKlbwZDWllnPORuKW0YFM6lCesag4T+R
	 ktUTXq0voYdslGUv0vH5HEgr967cRvQ7H6pJ+xvbq+nzn+hE5n4JxEQ6kyutWDpaKH
	 yYySGG4kJxBv0Sgb1y64k4KJ/MGp+Ijc6HtSg8ejVMd3/U/YpesfI3fgqa4fwUEJCP
	 TEoo88EOFh0mw==
Date: Tue, 30 Sep 2025 15:10:01 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Guodong Xu <guodong@riscstar.com>, Vinod Koul <vkoul@kernel.org>
Cc: Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, Yixun Lan <dlan@gentoo.org>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, elder@riscstar.com,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] dmaengine: mmp_pdma: fix DMA mask handling
Message-ID: <20250930221001.GA66006@ax162>
References: <20250918-mmp-pdma-simplify-dma-addressing-v1-1-5c2be2b85696@riscstar.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918-mmp-pdma-simplify-dma-addressing-v1-1-5c2be2b85696@riscstar.com>

On Thu, Sep 18, 2025 at 10:27:27PM +0800, Guodong Xu wrote:
> The driver's existing logic for setting the DMA mask for "marvell,pdma-1.0"
> was flawed. It incorrectly relied on pdev->dev->coherent_dma_mask instead
> of declaring the hardware's fixed addressing capability. A cleaner and
> more correct approach is to define the mask directly based on the hardware
> limitations.
> 
> The MMP/PXA PDMA controller is a 32-bit DMA engine. This is supported by
> datasheets and various dtsi files for PXA25x, PXA27x, PXA3xx, and MMP2,
> all of which are 32-bit systems.
> 
> This patch simplifies the driver's logic by replacing the 'u64 dma_mask'
> field with a simpler 'u32 dma_width' to store the addressing capability
> in bits. The complex if/else block in probe() is then replaced with a
> single, clear call to dma_set_mask_and_coherent(). This sets a fixed
> 32-bit DMA mask for "marvell,pdma-1.0" and a 64-bit mask for
> "spacemit,k1-pdma," matching each device's hardware capabilities.
> 
> Finally, this change also works around a specific build error encountered
> with clang-20 on x86_64 allyesconfig. The shift-count-overflow error is
> caused by a known clang compiler issue where the DMA_BIT_MASK(n) macro's
> ternary operator is not correctly evaluated in static initializers. By
> moving the macro's evaluation into the probe() function, the driver avoids
> this compiler bug.
> 
> Fixes: 5cfe585d8624 ("dmaengine: mmp_pdma: Add SpacemiT K1 PDMA support with 64-bit addressing")
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Closes: https://lore.kernel.org/lkml/CA+G9fYsPcMfW-e_0_TRqu4cnwqOqYF3aJOeKUYk6Z4qRStdFvg@mail.gmail.com
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Guodong Xu <guodong@riscstar.com>

Tested-by: Nathan Chancellor <nathan@kernel.org> # build

It would be great if this could be picked up before the 6.18 DMA pull
request so that I do not have to patch our CI to avoid this issue.

>  drivers/dma/mmp_pdma.c | 20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c
> index d07229a748868b8115892c63c54c16130d88e326..86661eb3cde1ff6d6d8f02b6f0d4142878b5a890 100644
> --- a/drivers/dma/mmp_pdma.c
> +++ b/drivers/dma/mmp_pdma.c
> @@ -152,8 +152,8 @@ struct mmp_pdma_phy {
>   *
>   * Controller Configuration:
>   * @run_bits:   Control bits in DCSR register for channel start/stop
> - * @dma_mask:   DMA addressing capability of controller. 0 to use OF/platform
> - *              settings, or explicit mask like DMA_BIT_MASK(32/64)
> + * @dma_width:  DMA addressing width in bits (32 or 64). Determines the
> + *              DMA mask capability of the controller hardware.
>   */
>  struct mmp_pdma_ops {
>  	/* Hardware Register Operations */
> @@ -173,7 +173,7 @@ struct mmp_pdma_ops {
>  
>  	/* Controller Configuration */
>  	u32 run_bits;
> -	u64 dma_mask;
> +	u32 dma_width;
>  };
>  
>  struct mmp_pdma_device {
> @@ -1172,7 +1172,7 @@ static const struct mmp_pdma_ops marvell_pdma_v1_ops = {
>  	.get_desc_src_addr = get_desc_src_addr_32,
>  	.get_desc_dst_addr = get_desc_dst_addr_32,
>  	.run_bits = (DCSR_RUN),
> -	.dma_mask = 0,			/* let OF/platform set DMA mask */
> +	.dma_width = 32,
>  };
>  
>  static const struct mmp_pdma_ops spacemit_k1_pdma_ops = {
> @@ -1185,7 +1185,7 @@ static const struct mmp_pdma_ops spacemit_k1_pdma_ops = {
>  	.get_desc_src_addr = get_desc_src_addr_64,
>  	.get_desc_dst_addr = get_desc_dst_addr_64,
>  	.run_bits = (DCSR_RUN | DCSR_LPAEEN),
> -	.dma_mask = DMA_BIT_MASK(64),	/* force 64-bit DMA addr capability */
> +	.dma_width = 64,
>  };
>  
>  static const struct of_device_id mmp_pdma_dt_ids[] = {
> @@ -1314,13 +1314,9 @@ static int mmp_pdma_probe(struct platform_device *op)
>  	pdev->device.directions = BIT(DMA_MEM_TO_DEV) | BIT(DMA_DEV_TO_MEM);
>  	pdev->device.residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
>  
> -	/* Set DMA mask based on ops->dma_mask, or OF/platform */
> -	if (pdev->ops->dma_mask)
> -		dma_set_mask(pdev->dev, pdev->ops->dma_mask);
> -	else if (pdev->dev->coherent_dma_mask)
> -		dma_set_mask(pdev->dev, pdev->dev->coherent_dma_mask);
> -	else
> -		dma_set_mask(pdev->dev, DMA_BIT_MASK(64));
> +	/* Set DMA mask based on controller hardware capabilities */
> +	dma_set_mask_and_coherent(pdev->dev,
> +				  DMA_BIT_MASK(pdev->ops->dma_width));
>  
>  	ret = dma_async_device_register(&pdev->device);
>  	if (ret) {
> 
> ---
> base-commit: cc0bacac6de7763a038550cf43cb94634d8be9cd
> change-id: 20250904-mmp-pdma-simplify-dma-addressing-f6aef03e07c3
> 
> Best regards,
> -- 
> Guodong Xu <guodong@riscstar.com>
> 

