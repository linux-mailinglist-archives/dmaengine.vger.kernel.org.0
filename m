Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE5A73B401B
	for <lists+dmaengine@lfdr.de>; Fri, 25 Jun 2021 11:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbhFYJQh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 25 Jun 2021 05:16:37 -0400
Received: from ivanoab7.miniserver.com ([37.128.132.42]:59464 "EHLO
        www.kot-begemot.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbhFYJQg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 25 Jun 2021 05:16:36 -0400
Received: from tun252.jain.kot-begemot.co.uk ([192.168.18.6] helo=jain.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1lwhua-0006I2-2s; Fri, 25 Jun 2021 09:14:08 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
        by jain.kot-begemot.co.uk with esmtp (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1lwhuX-0000Le-TU; Fri, 25 Jun 2021 10:14:07 +0100
Subject: Re: [PATCH] dmaengine: idxd: depends on !UML
To:     Johannes Berg <johannes@sipsolutions.net>,
        dmaengine@vger.kernel.org
Cc:     Dave Jiang <dave.jiang@intel.com>, linux-um@lists.infradead.org,
        Johannes Berg <johannes.berg@intel.com>,
        kernel test robot <lkp@intel.com>
References: <20210625103810.fe877ae0aef4.If240438e3f50ae226f3f755fc46ea498c6858393@changeid>
From:   Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <4de7c73b-a064-2adc-b7ee-ce2df6b72e1b@cambridgegreys.com>
Date:   Fri, 25 Jun 2021 10:14:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210625103810.fe877ae0aef4.If240438e3f50ae226f3f755fc46ea498c6858393@changeid>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0
X-Spam-Score: -1.0
X-Clacks-Overhead: GNU Terry Pratchett
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 25/06/2021 09:38, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> Now that UML has PCI support, this driver must depend also on
> !UML since it pokes at X86_64 architecture internals that don't
> exist on ARCH=um.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
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
> 

Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/
