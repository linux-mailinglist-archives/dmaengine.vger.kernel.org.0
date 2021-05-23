Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6887838D80E
	for <lists+dmaengine@lfdr.de>; Sun, 23 May 2021 03:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbhEWBIj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 22 May 2021 21:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbhEWBIi (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 22 May 2021 21:08:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24ACBC061574;
        Sat, 22 May 2021 18:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=ilM34qfUz2vQmuXBBVwssZe+GdU0lUmRnl36+0yudIo=; b=b9V0en77M+ntkZpqXDGfQ7DU9c
        oWUepXQp/kKNLoChZEjzK1AAq28n88HqYp/yvUC1DvujWwjVpE0bDNbyIncLoZ/uHAwQyEcevDHk+
        a5vfCIXzayH6AUCrD7R3cq0LxXfPxs/S16s4hpKnuS4ZCKEklkc1xZHOix4nRdk6dbX9bcVTrzqKG
        86dhKE32CXS9YZVhIl9TNhUJDmATMCRMvEqvxxV/rZMuP9U9LCvsFAKkQjuID8rG512dxv4iJIsZ7
        3DSdf/63dzq7OY59ZvfDudEL5tg5zbLl4ZhzJS8bJAN86uRB94xQWvH3apJDiKqzIwoDrR3oI+o4p
        H5G51+ug==;
Received: from [2601:1c0:6280:3f0::7376]
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lkca7-000GYn-Gs; Sun, 23 May 2021 01:07:03 +0000
Subject: Re: [PATCH 4/4] DMA: XILINX_ZYNQMP_DPDMA depends on HAS_IOMEM
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-kernel@vger.kernel.org, Stefan Roese <sr@denx.de>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Sinan Kaya <okaya@codeaurora.org>,
        Green Wan <green.wan@sifive.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        kernel test robot <lkp@intel.com>
References: <20210522021313.16405-1-rdunlap@infradead.org>
 <20210522021313.16405-5-rdunlap@infradead.org>
 <YKmfs68Cq4osBaQ0@pendragon.ideasonboard.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5cb3b313-cd96-d687-2916-0d4af8e5e675@infradead.org>
Date:   Sat, 22 May 2021 18:07:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YKmfs68Cq4osBaQ0@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 5/22/21 5:20 PM, Laurent Pinchart wrote:
> Hi Randy,
> 
> Thank you for the patch.
> 
> On Fri, May 21, 2021 at 07:13:13PM -0700, Randy Dunlap wrote:
>> When CONFIG_HAS_IOMEM is not set/enabled, most iomap() family
>> functions [including ioremap(), devm_ioremap(), etc.] are not
>> available.
>> Drivers that use these functions should depend on HAS_IOMEM so that
>> they do not cause build errors.
>>
>> Cures this build error:
>> s390-linux-ld: drivers/dma/xilinx/xilinx_dpdma.o: in function `xilinx_dpdma_probe':
>> xilinx_dpdma.c:(.text+0x336a): undefined reference to `devm_platform_ioremap_resource'
> 
> I've previously posted
> https://lore.kernel.org/dmaengine/20210520152420.23986-2-laurent.pinchart@ideasonboard.com/T/#u
> which fixes the same issue (plus an additional one).

Hi Laurent,

I didn't add a dependency on OF because OF header files _mostly_
have stubs so that they work when  OF is enabled or disabled.

I did find a problem in <linux/of_address.h> where it could end up
without having a stub. I will post a patch for that soon.
I'm currently doing lots of randconfig builds on it.

Thanks.

>> Fixes: 7cbb0c63de3fc ("dmaengine: xilinx: dpdma: Add the Xilinx DisplayPort DMA engine driver")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Cc: Vinod Koul <vkoul@kernel.org>
>> CC: dmaengine@vger.kernel.org
>> Cc: Hyun Kwon <hyun.kwon@xilinx.com>
>> Cc: Tejas Upadhyay <tejasu@xilinx.com>
>> Cc: Michal Simek <michal.simek@xilinx.com>
>> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>> ---
>>  drivers/dma/Kconfig |    1 +
>>  1 file changed, 1 insertion(+)
>>
>> --- linux-next-20210521.orig/drivers/dma/Kconfig
>> +++ linux-next-20210521/drivers/dma/Kconfig
>> @@ -702,6 +702,7 @@ config XILINX_ZYNQMP_DMA
>>  
>>  config XILINX_ZYNQMP_DPDMA
>>  	tristate "Xilinx DPDMA Engine"
>> +	depends on HAS_IOMEM
>>  	select DMA_ENGINE
>>  	select DMA_VIRTUAL_CHANNELS
>>  	help
> 


-- 
~Randy

