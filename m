Return-Path: <dmaengine+bounces-7662-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 647AACC33D8
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 14:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D472530AF1B3
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 13:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D89387B19;
	Tue, 16 Dec 2025 12:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4Zld+O+"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4871387B02;
	Tue, 16 Dec 2025 12:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765888299; cv=none; b=EmxhDHBplpCZwC6LgBcH92U60+HyvJ9anh3vRqkEuQpUjRFTeOyjMUdSS+CXY19pNxU3a7GRo2/Hg9zunfND7yXFbqWAmlfuodM5o1LoETWlmp8SRedTtTdZtymxJHjA+hX1+WrsrMJos/kG16TbHrp2oyTiy8Lr/xMJZr6CXm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765888299; c=relaxed/simple;
	bh=XP0feOgRpLuibd3rSzZPRlfbENTwYiPsBB68qu7tHf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LL3z8O52bLy97uoUuY4Tn2hdMbBrGOvpJBS5OwdBXZv7CqNNWjnKEKhP0Pg41FXF4DkPGbBHLvgy32CgPzzgu2B2PLbXYY6mAFS5R47PXlw/3C6u5sxQu4Fx3xmuOEf4Bnnei5dzMYm6L0LQjq2uwIeqjVl381hgC+bU1q0B24c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X4Zld+O+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D44B8C4CEF5;
	Tue, 16 Dec 2025 12:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765888299;
	bh=XP0feOgRpLuibd3rSzZPRlfbENTwYiPsBB68qu7tHf4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X4Zld+O+Z25jRIvFa7MfxTZ0lBhpu75h+zR9TcR+Ijbcz2ZP5IWPR+mAFQjz+h88z
	 P0g/7BSRYY4/xSBAgk78PK+ZqIOor5M/zrSazu3vBVvltSn6tYp++63AdhSkMYkLVI
	 vOdpbWPqYRGS8PpFldywnPud2D8FkdZ5pOWfbzakfZngECD+bJoz3DI+41cuVMZ4ae
	 LdDX4ztna3SLZ1XLqfoYJduyGBgz1fbgffDCkqqEGYIwbQatcwG2BM2W49eh54P+Oe
	 vl4BenMAgPxuKIyeVGaeoVwTE+etKj7jKBmC47BBuPTrzR3i9185kw5k/b/sKTxEwj
	 fo7vtIsfXidtQ==
Date: Tue, 16 Dec 2025 18:01:36 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Devendra K Verma <devendra.verma@amd.com>
Cc: bhelgaas@google.com, mani@kernel.org, dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	michal.simek@amd.com
Subject: Re: [PATCH v7 2/2] dmaengine: dw-edma: Add non-LL mode
Message-ID: <aUFRKDCglF3NbNLZ@vaman>
References: <20251212122056.8153-1-devendra.verma@amd.com>
 <20251212122056.8153-3-devendra.verma@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251212122056.8153-3-devendra.verma@amd.com>

On 12-12-25, 17:50, Devendra K Verma wrote:
> AMD MDB IP supports Linked List (LL) mode as well as non-LL mode.
> The current code does not have the mechanisms to enable the
> DMA transactions using the non-LL mode. The following two cases
> are added with this patch:
> - For the AMD (Xilinx) only, when a valid physical base address of
>   the device side DDR is not configured, then the IP can still be
>   used in non-LL mode. For all the channels DMA transactions will
>   be using the non-LL mode only. This, the default non-LL mode,
>   is not applicable for Synopsys IP with the current code addition.
> 
> - If the default mode is LL-mode, for both AMD (Xilinx) and Synosys,
>   and if user wants to use non-LL mode then user can do so via
>   configuring the peripheral_config param of dma_slave_config.
> 
> Signed-off-by: Devendra K Verma <devendra.verma@amd.com>
> ---
> Changes in v7
>   No change
> 
> Changes in v6
>   Gave definition to bits used for channel configuration.
>   Removed the comment related to doorbell.
> 
> Changes in v5
>   Variable name 'nollp' changed to 'non_ll'.
>   In the dw_edma_device_config() WARN_ON replaced with dev_err().
>   Comments follow the 80-column guideline.
> 
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
>  drivers/dma/dw-edma/dw-edma-core.c    | 41 ++++++++++++++++++++---
>  drivers/dma/dw-edma/dw-edma-core.h    |  1 +
>  drivers/dma/dw-edma/dw-edma-pcie.c    | 44 +++++++++++++++++--------
>  drivers/dma/dw-edma/dw-hdma-v0-core.c | 61 ++++++++++++++++++++++++++++++++++-
>  drivers/dma/dw-edma/dw-hdma-v0-regs.h |  1 +
>  include/linux/dma/edma.h              |  1 +
>  6 files changed, 130 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index b43255f..60a3279 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -223,8 +223,31 @@ static int dw_edma_device_config(struct dma_chan *dchan,
>  				 struct dma_slave_config *config)
>  {
>  	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
> +	int non_ll = 0;
> +
> +	if (config->peripheral_config &&
> +	    config->peripheral_size != sizeof(int)) {
> +		dev_err(dchan->device->dev,
> +			"config param peripheral size mismatch\n");
> +		return -EINVAL;
> +	}

Hmm, what is this config param used for. I dont like people using this
in opaque manner. Can you explain why this needs to be passed from
client. What does non ll mean and how would client decide to use this or
not..?

-- 
~Vinod

