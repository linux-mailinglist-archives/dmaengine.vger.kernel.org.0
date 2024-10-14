Return-Path: <dmaengine+bounces-3343-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6757999D646
	for <lists+dmaengine@lfdr.de>; Mon, 14 Oct 2024 20:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BC282838B3
	for <lists+dmaengine@lfdr.de>; Mon, 14 Oct 2024 18:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0965C1C830B;
	Mon, 14 Oct 2024 18:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hnQMm361"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40561C3054;
	Mon, 14 Oct 2024 18:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728929843; cv=none; b=nBz68GOyGL9YmRpS4oTBAm5Tg19Q8oPUEdpuwMbppTU8MW/FX1X/hTYNVSmrF5gv3RP+ioEDZJvIM/Ho/cGmmbrOHl8DDUTrhNh27bHjvZHZ5A/e92EAjPYqU/bbY8SOQQgjy8nix8+D6Kb1qc/p+BAabVG3XAIeOiXn6WNiP9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728929843; c=relaxed/simple;
	bh=QWiRryJ/QG6fnd6dxHqKiW+T+tf+bGfWNopSJcn6c1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H5VQ4VPKX0ydQ8n80Ra9RYtT/7q7a4DYqedPX9wRvdy8DjSKVREu34eTo8g8ae0GEzPjPOSDrgAWNCf1sMrhxyG/vEn+QwiUfIUCaM1UVq8rLKZT1y00vezFBM3ACT7jRqN8bMt+rEg6GTcZ31CdnsMqCPT+8OLP1iIz+DS4YrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hnQMm361; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A36FFC4CEC3;
	Mon, 14 Oct 2024 18:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728929843;
	bh=QWiRryJ/QG6fnd6dxHqKiW+T+tf+bGfWNopSJcn6c1A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hnQMm361amkyUEEOYwQ3KBXQ/JiSGM8R0reD0By9pOeYWHivhDYUw1wrLmrT+CeW2
	 qdY32gi0iHbmeyU8iicKw2F1M+RlydJRVos2DYpkBRuifK6JHmPOr59kXeUPnQQa9x
	 F/yMNSi2o2+sxq+Vk0CwuzW+0XwQzDuFjdKQi+TBaoz+xPM7cXIBjCyU42xoflnEqe
	 Y7BSVLGjIoaL1Pm0JIOQpMWTAzslHP6JxQENKRPKbfkCgadIphb4vr+yQKwutXn9sc
	 Wg65PITqOYVJCWpfyWXgQaIsfRIkkXmf72Ow1NwfoXGL9IfE1OldXHHIiVa3Z4K8uH
	 UHTjVHshZ6Maw==
Date: Mon, 14 Oct 2024 23:47:19 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Fenghua Yu <fenghua.yu@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>, dmaengine@vger.kernel.org,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dmaengine: idxd: Move DSA/IAA device IDs to IDXD driver
Message-ID: <Zw1gL22McDhFfgnk@vaman>
References: <20241004195200.3398664-1-fenghua.yu@intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004195200.3398664-1-fenghua.yu@intel.com>

On 04-10-24, 12:52, Fenghua Yu wrote:
> Since the DSA/IAA device IDs are only used by the IDXD driver, there is
> no need to define them as public IDs. Move their definitions to the IDXD
> driver to limit their scope. This change helps reduce unnecessary
> exposure of the device IDs in the global space, making the codebase
> cleaner and better encapsulated.

That is good

> 
> There is no functional change.

Ok

> 
> Fixes: 4fecf944c051 ("dmaengine: idxd: Add new DSA and IAA device IDs for Diamond Rapids platform")
> Fixes: f91f2a9879cc ("dmaengine: idxd: Add a new DSA device ID for Granite Rapids-D platform")

How is this a fix?

> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> ---
>  drivers/dma/idxd/registers.h | 4 ++++
>  include/linux/pci_ids.h      | 3 ---
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/idxd/registers.h b/drivers/dma/idxd/registers.h
> index e16dbf9ab324..c426511f2104 100644
> --- a/drivers/dma/idxd/registers.h
> +++ b/drivers/dma/idxd/registers.h
> @@ -6,6 +6,10 @@
>  #include <uapi/linux/idxd.h>
>  
>  /* PCI Config */
> +#define PCI_DEVICE_ID_INTEL_DSA_GNRD	0x11fb
> +#define PCI_DEVICE_ID_INTEL_DSA_DMR	0x1212
> +#define PCI_DEVICE_ID_INTEL_IAA_DMR	0x1216
> +
>  #define DEVICE_VERSION_1		0x100
>  #define DEVICE_VERSION_2		0x200
>  
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 4cf6aaed5f35..e4bddb927795 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2709,9 +2709,6 @@
>  #define PCI_DEVICE_ID_INTEL_82815_MC	0x1130
>  #define PCI_DEVICE_ID_INTEL_82815_CGC	0x1132
>  #define PCI_DEVICE_ID_INTEL_SST_TNG	0x119a
> -#define PCI_DEVICE_ID_INTEL_DSA_GNRD	0x11fb
> -#define PCI_DEVICE_ID_INTEL_DSA_DMR	0x1212
> -#define PCI_DEVICE_ID_INTEL_IAA_DMR	0x1216
>  #define PCI_DEVICE_ID_INTEL_82092AA_0	0x1221
>  #define PCI_DEVICE_ID_INTEL_82437	0x122d
>  #define PCI_DEVICE_ID_INTEL_82371FB_0	0x122e
> -- 
> 2.37.1

-- 
~Vinod

