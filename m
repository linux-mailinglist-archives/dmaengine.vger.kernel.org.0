Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3C138DC89
	for <lists+dmaengine@lfdr.de>; Sun, 23 May 2021 21:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbhEWTJy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 23 May 2021 15:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbhEWTJx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 23 May 2021 15:09:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5CDC061574;
        Sun, 23 May 2021 12:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=8NGYLBlDOGsWIrhJUgnxsEikIDKkWEL5Boe61bDYQYA=; b=XryCjJRgSq0j6VoBhYDhGXgCuG
        QETXkQm6JJ5bNxB0P2nqkZlPTl2SI20G9S/zFq5QLSa0MbgY8GpsuZx+YXtD+o8jp841T5myO8Wxw
        NysIGVIUk179R7dLUqQYRd1XywsByJmXmlFCZTnXx5dsPwr16C91XVAhgS90AWOrKED+hWptb3KHg
        zsCtdzc2yQYoq4T2ddfMZwwoPka/zMh/+uSj9MzvtqxDumg3JoiaHcrtuWA9sQpzxQHJHLAKAglTQ
        v3RLucw2NsQRE5vByDGemntlkEyMydNyCACqGGzKZYYYtM8MnJNX7pVAuP9I9MV/Q2O/Numneq0JF
        TTyVydgw==;
Received: from [2601:1c0:6280:3f0::7376]
        by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lktSV-000Xny-S9; Sun, 23 May 2021 19:08:19 +0000
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
 <5cb3b313-cd96-d687-2916-0d4af8e5e675@infradead.org>
 <YKqkmbZHPdbH2XtS@pendragon.ideasonboard.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <93da0e86-dbef-432d-20db-c2eda03f0071@infradead.org>
Date:   Sun, 23 May 2021 12:08:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YKqkmbZHPdbH2XtS@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 5/23/21 11:53 AM, Laurent Pinchart wrote:
> Hi Randy,
> 
> On Sat, May 22, 2021 at 06:07:01PM -0700, Randy Dunlap wrote:
>> On 5/22/21 5:20 PM, Laurent Pinchart wrote:
>>> On Fri, May 21, 2021 at 07:13:13PM -0700, Randy Dunlap wrote:
>>>> When CONFIG_HAS_IOMEM is not set/enabled, most iomap() family
>>>> functions [including ioremap(), devm_ioremap(), etc.] are not
>>>> available.
>>>> Drivers that use these functions should depend on HAS_IOMEM so that
>>>> they do not cause build errors.
>>>>
>>>> Cures this build error:
>>>> s390-linux-ld: drivers/dma/xilinx/xilinx_dpdma.o: in function `xilinx_dpdma_probe':
>>>> xilinx_dpdma.c:(.text+0x336a): undefined reference to `devm_platform_ioremap_resource'
>>>
>>> I've previously posted
>>> https://lore.kernel.org/dmaengine/20210520152420.23986-2-laurent.pinchart@ideasonboard.com/T/#u
>>> which fixes the same issue (plus an additional one).
>>
>> Hi Laurent,
>>
>> I didn't add a dependency on OF because OF header files _mostly_
>> have stubs so that they work when  OF is enabled or disabled.
>>
>> I did find a problem in <linux/of_address.h> where it could end up
>> without having a stub. I will post a patch for that soon.
>> I'm currently doing lots of randconfig builds on it.
> 
> I'm fine with eithe approach, but the patch you've posted to address the
> of_address.h issue has an issue itself.

I'm also fine with either patch.
I'm reworking the of_address.h patch now.

Thanks.

> If Vinod would prefer merging this patch instead of mine,
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
>>>> Fixes: 7cbb0c63de3fc ("dmaengine: xilinx: dpdma: Add the Xilinx DisplayPort DMA engine driver")
>>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>> Cc: Vinod Koul <vkoul@kernel.org>
>>>> CC: dmaengine@vger.kernel.org
>>>> Cc: Hyun Kwon <hyun.kwon@xilinx.com>
>>>> Cc: Tejas Upadhyay <tejasu@xilinx.com>
>>>> Cc: Michal Simek <michal.simek@xilinx.com>
>>>> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>>>> ---
>>>>  drivers/dma/Kconfig |    1 +
>>>>  1 file changed, 1 insertion(+)
>>>>
>>>> --- linux-next-20210521.orig/drivers/dma/Kconfig
>>>> +++ linux-next-20210521/drivers/dma/Kconfig
>>>> @@ -702,6 +702,7 @@ config XILINX_ZYNQMP_DMA
>>>>  
>>>>  config XILINX_ZYNQMP_DPDMA
>>>>  	tristate "Xilinx DPDMA Engine"
>>>> +	depends on HAS_IOMEM
>>>>  	select DMA_ENGINE
>>>>  	select DMA_VIRTUAL_CHANNELS
>>>>  	help
> 


-- 
~Randy

