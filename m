Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11E593E4963
	for <lists+dmaengine@lfdr.de>; Mon,  9 Aug 2021 18:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbhHIQF1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 9 Aug 2021 12:05:27 -0400
Received: from mga04.intel.com ([192.55.52.120]:14829 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229456AbhHIQF1 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 9 Aug 2021 12:05:27 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10070"; a="212865332"
X-IronPort-AV: E=Sophos;i="5.84,307,1620716400"; 
   d="scan'208";a="212865332"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2021 09:02:38 -0700
X-IronPort-AV: E=Sophos;i="5.84,307,1620716400"; 
   d="scan'208";a="421501122"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.209.157.130]) ([10.209.157.130])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2021 09:02:37 -0700
Subject: Re: [PATCH] dmaengine: ioat: depends on !UML
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
References: <20210809112409.a3a0974874d2.I2ffe3d11ed37f735da2f39884a74c953b258b995@changeid>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <6b32521e-5878-8ae7-f27d-331f82466b75@intel.com>
Date:   Mon, 9 Aug 2021 09:02:36 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210809112409.a3a0974874d2.I2ffe3d11ed37f735da2f39884a74c953b258b995@changeid>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 8/9/2021 2:24 AM, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
>
> Now that UML has PCI support, this driver must depend also on
> !UML since it pokes at X86_64 architecture internals that don't
> exist on ARCH=um.
>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Acked-by: Dave Jiang <dave.jiang@intel.com>
> ---
>   drivers/dma/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index 39b5b46e880f..dc155f75926d 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -315,7 +315,7 @@ config INTEL_IDXD_PERFMON
>   
>   config INTEL_IOATDMA
>   	tristate "Intel I/OAT DMA support"
> -	depends on PCI && X86_64
> +	depends on PCI && X86_64 && !UML
>   	select DMA_ENGINE
>   	select DMA_ENGINE_RAID
>   	select DCA
