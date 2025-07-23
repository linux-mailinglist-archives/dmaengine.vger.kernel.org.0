Return-Path: <dmaengine+bounces-5843-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F563B0EBEA
	for <lists+dmaengine@lfdr.de>; Wed, 23 Jul 2025 09:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 738AB4E4F4E
	for <lists+dmaengine@lfdr.de>; Wed, 23 Jul 2025 07:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489E4276056;
	Wed, 23 Jul 2025 07:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZipQC3l8"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1465527603B;
	Wed, 23 Jul 2025 07:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753255822; cv=none; b=FQgCWwZsuu3/L6iIooICiZiUVz165JokLJMW/t3QETB8S+S1gZYfJIgqEoTJ42DZZZCHE1aJUafsE1JwrjZIQnBwa1dBniyLvtWzFbhFR8mXAwd4kLCOoXJ4htCRrtxHfST0oPnHMyeyjhmi6rK6lLFF3b7GP7M/Otd+IhQafY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753255822; c=relaxed/simple;
	bh=FbNwzN2/uLaiFpmgiq5NTNUhWFAl35zHY3pxae52iF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YPYQzppdM+QLannA8pfd1Mz6EmKbfuUc9a8MVYrP8ojcqa3SUpWnUSLuoR9gy5LJnEQNw7mNKDW3txUAQid4/LG3LVJzQNEUjkCSyA/ivzd5zdsfUp4eKzdqJ1LWxNMv05kZEAFfHbVj91P0i6R7qHluCgxcbdCKmmyLRoZHiws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZipQC3l8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 231B4C4CEE7;
	Wed, 23 Jul 2025 07:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753255820;
	bh=FbNwzN2/uLaiFpmgiq5NTNUhWFAl35zHY3pxae52iF4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZipQC3l8bjWiKOeN/wsGZxVfgEynMvry7829OsbLSLMuy01exL6T1I9wTyaAeOtkq
	 AfU+IyxQnQBVRe9QdbEE80XA2OEGrNSHiT5m56i8WvMZAy9Krujyivync1hQrAtM0l
	 zPylPI5OaadYRbT2eGhaDFCDQ1CzpzzE3hsYcbrjjP9i9ONGuQbHB4qRkqtfxQFuAG
	 eljUuLd2DBjjIDn0nal2UC9Un5+KsSEviK7p9sSvncAFEdFhCkg5zaexeEqDaqmKBC
	 VuKhBUPXa/DKeUNSyaZv6vkGl4KvDDRqLMKwlxe+UkTqYxJx2qkF3CaLpdj1R7g4da
	 YLidie6IXC9RQ==
Date: Wed, 23 Jul 2025 13:00:17 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Suraj Gupta <suraj.gupta2@amd.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, michal.simek@amd.com,
	radhey.shyam.pandey@amd.com, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org, harini.katakam@amd.com
Subject: Re: [PATCH V2 1/4] dmaengine: Add support to configure and read IRQ
 coalescing parameters
Message-ID: <aICPiS1_ITwELrxq@vaman>
References: <20250710101229.804183-1-suraj.gupta2@amd.com>
 <20250710101229.804183-2-suraj.gupta2@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710101229.804183-2-suraj.gupta2@amd.com>

On 10-07-25, 15:42, Suraj Gupta wrote:
> Interrupt coalescing is a mechanism to reduce the number of hardware
> interrupts triggered ether until a certain amount of work is pending,
> or a timeout timer triggers. Tuning the interrupt coalesce settings
> involves adjusting the amount of work and timeout delay.
> Many DMA controllers support to configure coalesce count and delay.
> Add support to configure them via dma_slave_config and read
> using dma_slave_caps.
> 
> Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
> ---
>  include/linux/dmaengine.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index bb146c5ac3e4..c7c1adb8e571 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -431,6 +431,9 @@ enum dma_slave_buswidth {
>   * @peripheral_config: peripheral configuration for programming peripheral
>   * for dmaengine transfer
>   * @peripheral_size: peripheral configuration buffer size
> + * @coalesce_cnt: Maximum number of transfers before receiving an interrupt.
> + * @coalesce_usecs: How many usecs to delay an interrupt after a transfer
> + * is completed.
>   *
>   * This struct is passed in as configuration data to a DMA engine
>   * in order to set up a certain channel for DMA transport at runtime.
> @@ -457,6 +460,8 @@ struct dma_slave_config {
>  	bool device_fc;
>  	void *peripheral_config;
>  	size_t peripheral_size;
> +	u32 coalesce_cnt;
> +	u32 coalesce_usecs;
>  };
>  
>  /**
> @@ -507,6 +512,9 @@ enum dma_residue_granularity {
>   * @residue_granularity: granularity of the reported transfer residue
>   * @descriptor_reuse: if a descriptor can be reused by client and
>   * resubmitted multiple times
> + * @coalesce_cnt: Maximum number of transfers before receiving an interrupt.
> + * @coalesce_usecs: How many usecs to delay an interrupt after a transfer
> + * is completed.
>   */
>  struct dma_slave_caps {
>  	u32 src_addr_widths;
> @@ -520,6 +528,8 @@ struct dma_slave_caps {
>  	bool cmd_terminate;
>  	enum dma_residue_granularity residue_granularity;
>  	bool descriptor_reuse;
> +	u32 coalesce_cnt;
> +	u32 coalesce_usecs;

Why not selectively set interrupts for the descriptor. The dma
descriptors are in order, so one a descriptor is notified and complete,
you can also complete the descriptors before that. I would suggest to
use that rather than define a new interface for this

-- 
~Vinod

