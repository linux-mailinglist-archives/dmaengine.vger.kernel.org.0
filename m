Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B55403B45AC
	for <lists+dmaengine@lfdr.de>; Fri, 25 Jun 2021 16:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbhFYOge (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 25 Jun 2021 10:36:34 -0400
Received: from mga17.intel.com ([192.55.52.151]:36024 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231524AbhFYOge (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 25 Jun 2021 10:36:34 -0400
IronPort-SDR: oCDD0CXC38tQiTSBo3GMh4iFkT6f6dRhzPhsuCYn8TgzeeZJSDF6KsU/McxikTVuXW3+NboqzO
 rxte/W4h/jCg==
X-IronPort-AV: E=McAfee;i="6200,9189,10026"; a="188061314"
X-IronPort-AV: E=Sophos;i="5.83,299,1616482800"; 
   d="scan'208";a="188061314"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2021 07:34:13 -0700
IronPort-SDR: Ae3+thq2MttqleIkICUDkop7W4oHpwE7MDRXOYVPsVXz5ie9PG9QUYvCyThEUxqPDjZ1qwRjlm
 TyZfv5X11RTg==
X-IronPort-AV: E=Sophos;i="5.83,299,1616482800"; 
   d="scan'208";a="481871849"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.255.81.86]) ([10.255.81.86])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2021 07:34:13 -0700
Subject: Re: [PATCH] dmaengine: idxd: depends on !UML
To:     Johannes Berg <johannes@sipsolutions.net>,
        dmaengine@vger.kernel.org
Cc:     linux-um@lists.infradead.org,
        Johannes Berg <johannes.berg@intel.com>,
        kernel test robot <lkp@intel.com>
References: <20210625103810.fe877ae0aef4.If240438e3f50ae226f3f755fc46ea498c6858393@changeid>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <ff85e229-9605-7a25-08fa-4013df49b49c@intel.com>
Date:   Fri, 25 Jun 2021 07:34:12 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210625103810.fe877ae0aef4.If240438e3f50ae226f3f755fc46ea498c6858393@changeid>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 6/25/2021 1:38 AM, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
>
> Now that UML has PCI support, this driver must depend also on
> !UML since it pokes at X86_64 architecture internals that don't
> exist on ARCH=um.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Acked-by: Dave Jiang <dave.jiang@intel.com>


> ---
>   drivers/dma/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index 6ab9d9a488a6..1f3c0e2ea4d9 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -278,7 +278,7 @@ config INTEL_IDMA64
>   
>   config INTEL_IDXD
>   	tristate "Intel Data Accelerators support"
> -	depends on PCI && X86_64
> +	depends on PCI && X86_64 && !UML
>   	depends on PCI_MSI
>   	depends on SBITMAP
>   	select DMA_ENGINE
