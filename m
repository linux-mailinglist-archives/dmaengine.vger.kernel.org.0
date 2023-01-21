Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77F65676292
	for <lists+dmaengine@lfdr.de>; Sat, 21 Jan 2023 01:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjAUAyH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 20 Jan 2023 19:54:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjAUAyH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 20 Jan 2023 19:54:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48AEE5B595;
        Fri, 20 Jan 2023 16:54:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 00025B829E7;
        Sat, 21 Jan 2023 00:54:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66671C433EF;
        Sat, 21 Jan 2023 00:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674262443;
        bh=vljIIVvvzMtlYSzt6a6DW1k+oWO9BkaIoO7pt3gn6EA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=PkFTwLN4JLJgJVusl5GYFnZCMFw9SPrMAGvks/AWdp0rwpldUIwSK84wwdw+e/aoi
         aYOdPczoJtOT3kBJ+MbUVxGkng0JBBvQ3TMJYMc/tiWfP52ng2sLumzwU8ra6la5rx
         k2v7BaSTj7RhT5C0F15DlGQW4qZV83KAWM7U0lnlgnficozn721cE6+nOpNKE0TgQK
         iIhad/wILlppx3cZUhH2/zbvZwZ4zhpQzJrEdBz3CuXLC5n+zlZ17Ncbc7PU+y4HOh
         Yt8zXYrwpMdN6FqnhIUKrIcLgJ9b1T/eFQ3wNTLtM/PrVbrq9mWKQbi8KpmK/nzftB
         igqzGzx5/hpBQ==
Date:   Fri, 20 Jan 2023 18:54:01 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Robin Murphy <robin.murphy@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>, Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        caihuoqing <caihuoqing@baidu.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 19/27] dmaengine: dw-edma: Use non-atomic io-64 methods
Message-ID: <20230121005401.GA686892@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113171409.30470-20-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Jan 13, 2023 at 08:14:01PM +0300, Serge Semin wrote:
> Instead of splitting the 64-bits IOs up into two 32-bits ones it's
> possible to use the already available non-atomic readq/writeq methods
> implemented exactly for such cases. They are defined in the dedicated
> header files io-64-nonatomic-lo-hi.h/io-64-nonatomic-hi-lo.h. So in case
> if the 64-bits readq/writeq methods are unavailable on some platforms at
> consideration, the corresponding drivers can have any of these headers
> included and stop locally re-implementing the 64-bits IO accessors taking
> into account the non-atomic nature of the included methods. Let's do that
> in the DW eDMA driver too. Note by doing so we can discard the
> CONFIG_64BIT config ifdefs from the code.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Acked-by: Vinod Koul <vkoul@kernel.org>
> ---
>  drivers/dma/dw-edma/dw-edma-v0-core.c | 55 +++++++++------------------
>  1 file changed, 18 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
> index 66f296daac5a..51a34b43434c 100644
> --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
> @@ -8,6 +8,8 @@
>  
>  #include <linux/bitfield.h>
>  
> +#include <linux/io-64-nonatomic-lo-hi.h>
> +
>  #include "dw-edma-core.h"
>  #include "dw-edma-v0-core.h"
>  #include "dw-edma-v0-regs.h"
> @@ -53,8 +55,6 @@ static inline struct dw_edma_v0_regs __iomem *__dw_regs(struct dw_edma *dw)
>  		SET_32(dw, rd_##name, value);		\
>  	} while (0)
>  
> -#ifdef CONFIG_64BIT
> -
>  #define SET_64(dw, name, value)				\
>  	writeq(value, &(__dw_regs(dw)->name))
>  
> @@ -80,8 +80,6 @@ static inline struct dw_edma_v0_regs __iomem *__dw_regs(struct dw_edma *dw)
>  		SET_64(dw, rd_##name, value);		\
>  	} while (0)
>  
> -#endif /* CONFIG_64BIT */

Great to get rid of these #ifdefs!

Am I missing something?  It looks like SET_64 is used only by
SET_RW_64 and SET_BOTH_64, and neither of *them is used at all.

Similarly for GET_64 and GET_RW_64.

So maybe we could get rid of everything inside the #ifdefs as well?

>  #define SET_COMPAT(dw, name, value)			\
>  	writel(value, &(__dw_regs(dw)->type.unroll.name))
>  
> @@ -164,14 +162,13 @@ static inline u32 readl_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
>  #define SET_LL_32(ll, value) \
>  	writel(value, ll)
>  
> -#ifdef CONFIG_64BIT
> -
>  static inline void writeq_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
>  			     u64 value, void __iomem *addr)
>  {
> +	unsigned long flags;
> +
>  	if (dw->chip->mf == EDMA_MF_EDMA_LEGACY) {
>  		u32 viewport_sel;
> -		unsigned long flags;
>  
>  		raw_spin_lock_irqsave(&dw->lock, flags);
>  
> @@ -181,22 +178,22 @@ static inline void writeq_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
>  
>  		writel(viewport_sel,
>  		       &(__dw_regs(dw)->type.legacy.viewport_sel));
> -		writeq(value, addr);
> +	}
> +
> +	writeq(value, addr);
>  
> +	if (dw->chip->mf == EDMA_MF_EDMA_LEGACY)
>  		raw_spin_unlock_irqrestore(&dw->lock, flags);
> -	} else {
> -		writeq(value, addr);
> -	}

This is basically a cosmetic change unrelated to the commit log.  I
don't really object to the change, although I think it's of dubious
value to remove the repetition of the writeq() at the cost of adding
another "if" and unlock.

Lorenzo already applied this, so it's OK as-is unless you think it's
worth reworking to drop the unused stuff mentioned above, in which
case this rearrangement could be moved to a separate patch to make
both of them more focused.

Bjorn
