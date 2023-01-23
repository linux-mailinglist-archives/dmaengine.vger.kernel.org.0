Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B59267819A
	for <lists+dmaengine@lfdr.de>; Mon, 23 Jan 2023 17:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233214AbjAWQhO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 23 Jan 2023 11:37:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbjAWQhN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 23 Jan 2023 11:37:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A4228874;
        Mon, 23 Jan 2023 08:37:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB20760FA8;
        Mon, 23 Jan 2023 16:37:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBEDDC4339E;
        Mon, 23 Jan 2023 16:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674491831;
        bh=ygXrCk7lDXCPU5TBq4c9PYUWWb7/Dwti3oEPNHVlqjw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=n0/vgn+MbdfyrYca+Yykeer/Kv9KF0bqvzPYNixmggG9j1ZoqwuU7+Bf3OCL+nmgf
         gbFUkhlZrsRudPEaqd0Q4/BpnHri3kmTZV3nXiKHoao2OQqeYRRYDsf9JkD+rz1eG/
         6jjytERYhnhYslVn4dYCZc0D8XhHeTr1NvEJ9bBVHbuCMNk7Gj4QArcxJS/Bf+RV14
         gAYDVDiC7auZKlDpNcCjhzrtAdYHzNDvKC6IceHYxw1vdm/JFtx7hXmCQLaI0hC4VU
         yUhGJIBVwyycjVhiOJh48njecnHzKU3e95Q32LN2qgaay4o7N4cgMREXCDh7T+Obmh
         +NOmWE5OMvodw==
Date:   Mon, 23 Jan 2023 10:37:09 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Robin Murphy <robin.murphy@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>, Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        caihuoqing <caihuoqing@baidu.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 19/27] dmaengine: dw-edma: Use non-atomic io-64 methods
Message-ID: <20230123163709.GA891421@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230121230359.kqfm4kvwys2jdan6@mobilestation>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sun, Jan 22, 2023 at 02:03:59AM +0300, Serge Semin wrote:
> On Fri, Jan 20, 2023 at 06:54:01PM -0600, Bjorn Helgaas wrote:
> > On Fri, Jan 13, 2023 at 08:14:01PM +0300, Serge Semin wrote:
> > > Instead of splitting the 64-bits IOs up into two 32-bits ones it's
> > > possible to use the already available non-atomic readq/writeq methods
> > > implemented exactly for such cases. They are defined in the dedicated
> > > header files io-64-nonatomic-lo-hi.h/io-64-nonatomic-hi-lo.h. So in case
> > > if the 64-bits readq/writeq methods are unavailable on some platforms at
> > > consideration, the corresponding drivers can have any of these headers
> > > included and stop locally re-implementing the 64-bits IO accessors taking
> > > into account the non-atomic nature of the included methods. Let's do that
> > > in the DW eDMA driver too. Note by doing so we can discard the
> > > CONFIG_64BIT config ifdefs from the code.
> > > 
> > > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > Acked-by: Vinod Koul <vkoul@kernel.org>
> > > ---
> > >  drivers/dma/dw-edma/dw-edma-v0-core.c | 55 +++++++++------------------
> > >  1 file changed, 18 insertions(+), 37 deletions(-)
> > > 
> > > diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
> > > index 66f296daac5a..51a34b43434c 100644
> > > --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> > > +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
> > > @@ -8,6 +8,8 @@
> > >  
> > >  #include <linux/bitfield.h>
> > >  
> > > +#include <linux/io-64-nonatomic-lo-hi.h>
> > > +
> > >  #include "dw-edma-core.h"
> > >  #include "dw-edma-v0-core.h"
> > >  #include "dw-edma-v0-regs.h"
> > > @@ -53,8 +55,6 @@ static inline struct dw_edma_v0_regs __iomem *__dw_regs(struct dw_edma *dw)
> > >  		SET_32(dw, rd_##name, value);		\
> > >  	} while (0)
> > >  
> > > -#ifdef CONFIG_64BIT
> > > -
> > >  #define SET_64(dw, name, value)				\
> > >  	writeq(value, &(__dw_regs(dw)->name))
> > >  
> > > @@ -80,8 +80,6 @@ static inline struct dw_edma_v0_regs __iomem *__dw_regs(struct dw_edma *dw)
> > >  		SET_64(dw, rd_##name, value);		\
> > >  	} while (0)
> > >  
> > > -#endif /* CONFIG_64BIT */
> > 
> 
> > Great to get rid of these #ifdefs!
> > 
> > Am I missing something?  It looks like SET_64 is used only by
> > SET_RW_64 and SET_BOTH_64, and neither of *them is used at all.
> > 
> > Similarly for GET_64 and GET_RW_64.
> > 
> > So maybe we could get rid of everything inside the #ifdefs as well?
> 
> Even though these macros are indeed unused in the driver they are
> still a part of the DW eDMA CSRs access interface. In particular they
> are supposed to be used to access the 64-bit registers declared in the
> dw_edma_v0_regs, dw_edma_v0_unroll and dw_edma_v0_ch_regs structures.
> So until the interface is converted to a more preferable direct MMIO
> usage without any packed-structures I'd rather leave these macros
> be.
> ...

> As I said above I'd rather leave the 64-bit accessors be until the
> packed structure-based interface is removed from the driver.

I wouldn't bother polishing something that's unused since it can't be
tested, it's easy to resurrect from the history if/when it becomes
necessary, and it makes it much harder to connect the commit log with
the code change.  But this isn't a drivers/pci change, so I'm fine
with it since Vinod acked it.

I guess the point is that when !CONFIG_64BIT, there was no writeq() so
we used SET_LL_32 twice.  linux/io-64-nonatomic-lo-hi.h provides that
writeq() implementation, so we can define and use SET_LL_64 for that
case.

Bjorn
