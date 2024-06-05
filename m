Return-Path: <dmaengine+bounces-2292-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD158FD783
	for <lists+dmaengine@lfdr.de>; Wed,  5 Jun 2024 22:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36A1D1F2387F
	for <lists+dmaengine@lfdr.de>; Wed,  5 Jun 2024 20:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD9015ECCE;
	Wed,  5 Jun 2024 20:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QtYMxgle"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A369C13C3F2;
	Wed,  5 Jun 2024 20:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717619354; cv=none; b=N9YgGEkQfWcR+QwFyGLttoUPZYUFo8DK8+SV3aEx1BxbvjJPC2Am76PTXFSz3Gc4E9I+1rD7uBNoI+BTH3G0vvWen8br6nrlZNCBYb7/Dmy12uC0n2RiluD50rLk0K+u6+L1e38CGR6Qfq7K6r2/1v1349G7oUoE5bn7YKrObnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717619354; c=relaxed/simple;
	bh=XV6VLCEWWdCpqWVQr//KanNGW4Bc9TlQGkeYEMBAxrQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ax/o5mn18otGzYqfi2NXqRqY4VB+NknEkDn7jTYtsW/sMroGExwSx/CHl5D2l0TZos8NyiPU7hQBnh3qte4Ba6ARVZVEgfCdEw6EwNl+2lwdTtZj7TnRwoWiQRPsq6HKmBfm8IZGj7vJ9RpRq2quUepWCMnExfCOSrX+B8xxH3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QtYMxgle; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717619353; x=1749155353;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XV6VLCEWWdCpqWVQr//KanNGW4Bc9TlQGkeYEMBAxrQ=;
  b=QtYMxglefNEXiOUrUsaah2S7mydC3YyIVy0LVcwYJ+Y9M0Id/lk0E89Y
   gUWkg0Em5v4q76BR4T0te+lc6f+O5tBussfJkgHYGKTnau05Z1pzLGI8i
   v2yAU9YLazYAaf4Moz3q24a4Td4JuUWMZEkY8oKnIScMZW7jIykZrXjkl
   Re/U1CaAfxr72w0H7PQXd1UHq4ZKf6srBH3H6DpvNgPk3t3JHSF4wuSPK
   uhgdRILcz9Bit4U02s1yRlE5MnRU5Ab23Mifne/6ST24wrQ1jQP3MrriO
   uFRNdN1ZcdLeiihNxbWBzeI9VXdb0oFPq2f+NtAhU53v+6WHfd2dNtZyb
   w==;
X-CSE-ConnectionGUID: OGOfrq5HT4iRk7iCS/86OQ==
X-CSE-MsgGUID: +fOagOYwRDaa+MQrwDYcNw==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="18101752"
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="18101752"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 13:29:12 -0700
X-CSE-ConnectionGUID: EKwvxkJFTuagKlLTciEOQg==
X-CSE-MsgGUID: tA8ITf9QQoSX1b28HGJUww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="37821310"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.125.109.83]) ([10.125.109.83])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 13:29:11 -0700
Message-ID: <d0b56247-9b6c-4b62-aad0-1ff5925d9f9e@intel.com>
Date: Wed, 5 Jun 2024 13:29:10 -0700
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: add missing MODULE_DESCRIPTION() macros
To: Jeff Johnson <quic_jjohnson@quicinc.com>, Vinod Koul <vkoul@kernel.org>,
 Fenghua Yu <fenghua.yu@intel.com>, Peter Ujfalusi <peter.ujfalusi@gmail.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <20240605-md-drivers-dma-v1-1-bcbcfd9ce706@quicinc.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240605-md-drivers-dma-v1-1-bcbcfd9ce706@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/5/24 12:28 PM, Jeff Johnson wrote:
> make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/dma/idxd/idxd.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/dma/ti/omap-dma.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/dma/dmatest.o
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/dma/ioat/ioatdma.o
> 
> Add the missing invocations of the MODULE_DESCRIPTION() macro.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> ---
>  drivers/dma/dmatest.c     | 1 +
>  drivers/dma/idxd/init.c   | 1 +
>  drivers/dma/ioat/init.c   | 1 +
>  drivers/dma/ti/omap-dma.c | 1 +
>  4 files changed, 4 insertions(+)
> 
> diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
> index a4f608837849..1f201a542b37 100644
> --- a/drivers/dma/dmatest.c
> +++ b/drivers/dma/dmatest.c
> @@ -1372,4 +1372,5 @@ static void __exit dmatest_exit(void)
>  module_exit(dmatest_exit);
>  
>  MODULE_AUTHOR("Haavard Skinnemoen (Atmel)");
> +MODULE_DESCRIPTION("DMA Engine test module");
>  MODULE_LICENSE("GPL v2");
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index a7295943fa22..cb5f9748f54a 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -22,6 +22,7 @@
>  #include "perfmon.h"
>  
>  MODULE_VERSION(IDXD_DRIVER_VERSION);
> +MODULE_DESCRIPTION("Intel Data Accelerators support");

"Intel Data Streaming Accelerator and In-Memory Analytics Accelerator common driver"
>  MODULE_LICENSE("GPL v2");
>  MODULE_AUTHOR("Intel Corporation");
>  MODULE_IMPORT_NS(IDXD);
> diff --git a/drivers/dma/ioat/init.c b/drivers/dma/ioat/init.c
> index 9c364e92cb82..d84d95321f43 100644
> --- a/drivers/dma/ioat/init.c
> +++ b/drivers/dma/ioat/init.c
> @@ -23,6 +23,7 @@
>  #include "../dmaengine.h"
>  
>  MODULE_VERSION(IOAT_DMA_VERSION);
> +MODULE_DESCRIPTION("Intel I/OAT DMA Linux driver");

Acked-by: Dave Jiang <dave.jiang@intel.com>

>  MODULE_LICENSE("Dual BSD/GPL");
>  MODULE_AUTHOR("Intel Corporation");
>  
> diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
> index b9e0e22383b7..5b994c325b41 100644
> --- a/drivers/dma/ti/omap-dma.c
> +++ b/drivers/dma/ti/omap-dma.c
> @@ -1950,4 +1950,5 @@ static void __exit omap_dma_exit(void)
>  module_exit(omap_dma_exit);
>  
>  MODULE_AUTHOR("Russell King");
> +MODULE_DESCRIPTION("OMAP DMAengine support");
>  MODULE_LICENSE("GPL");
> 
> ---
> base-commit: a693b9c95abd4947c2d06e05733de5d470ab6586
> change-id: 20240605-md-drivers-dma-2105b7b6f243
> 

