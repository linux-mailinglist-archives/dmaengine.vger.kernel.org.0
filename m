Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7156F38D427
	for <lists+dmaengine@lfdr.de>; Sat, 22 May 2021 09:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbhEVHW7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 22 May 2021 03:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbhEVHW6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 22 May 2021 03:22:58 -0400
Received: from mout-u-107.mailbox.org (mout-u-107.mailbox.org [IPv6:2001:67c:2050:1::465:107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A86BC061574;
        Sat, 22 May 2021 00:21:31 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-u-107.mailbox.org (Postfix) with ESMTPS id 4FnFJn12krzQk1P;
        Sat, 22 May 2021 09:21:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter01.heinlein-hosting.de (spamfilter01.heinlein-hosting.de [80.241.56.115]) (amavisd-new, port 10030)
        with ESMTP id ZH0Aaqzj-JRA; Sat, 22 May 2021 09:21:26 +0200 (CEST)
Subject: Re: [PATCH 1/4] DMA: ALTERA_MSGDMA depends on HAS_IOMEM
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Sinan Kaya <okaya@codeaurora.org>,
        Green Wan <green.wan@sifive.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        kernel test robot <lkp@intel.com>
References: <20210522021313.16405-1-rdunlap@infradead.org>
 <20210522021313.16405-2-rdunlap@infradead.org>
From:   Stefan Roese <sr@denx.de>
Message-ID: <4fde705b-6d57-ba73-e7d6-63beb690117e@denx.de>
Date:   Sat, 22 May 2021 09:21:24 +0200
MIME-Version: 1.0
In-Reply-To: <20210522021313.16405-2-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -6.42 / 15.00 / 15.00
X-Rspamd-Queue-Id: 0573E17FF
X-Rspamd-UID: f6adc0
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 22.05.21 04:13, Randy Dunlap wrote:
> When CONFIG_HAS_IOMEM is not set/enabled, certain iomap() family
> functions [including ioremap(), devm_ioremap(), etc.] are not
> available.
> Drivers that use these functions should depend on HAS_IOMEM so that
> they do not cause build errors.
> 
> Repairs this build error:
> s390-linux-ld: drivers/dma/altera-msgdma.o: in function `request_and_map':
> altera-msgdma.c:(.text+0x14b0): undefined reference to `devm_ioremap'
> 
> Fixes: a85c6f1b2921 ("dmaengine: Add driver for Altera / Intel mSGDMA IP core")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Stefan Roese <sr@denx.de>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: dmaengine@vger.kernel.org

Reviewed-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

> ---
>   drivers/dma/Kconfig |    1 +
>   1 file changed, 1 insertion(+)
> 
> --- linux-next-20210521.orig/drivers/dma/Kconfig
> +++ linux-next-20210521/drivers/dma/Kconfig
> @@ -59,6 +59,7 @@ config DMA_OF
>   #devices
>   config ALTERA_MSGDMA
>   	tristate "Altera / Intel mSGDMA Engine"
> +	depends on HAS_IOMEM
>   	select DMA_ENGINE
>   	help
>   	  Enable support for Altera / Intel mSGDMA controller.
> 


Viele Grüße,
Stefan

-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
