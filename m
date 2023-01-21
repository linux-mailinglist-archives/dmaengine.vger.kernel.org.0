Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 679C5676A44
	for <lists+dmaengine@lfdr.de>; Sun, 22 Jan 2023 00:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjAUXEI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 21 Jan 2023 18:04:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjAUXEH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 21 Jan 2023 18:04:07 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04AAF10A86;
        Sat, 21 Jan 2023 15:04:05 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id e16so9463317ljn.3;
        Sat, 21 Jan 2023 15:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=trJ6EtXGVxeJ2E2dBSh9BGipsejRJqHcnNYTifbPX1s=;
        b=neOi+5+rK+YfvT9LUNVhtid9C6K+7Xg0ZP2CtSeVCv/DOGjZ7LCxuPtI+g8zkjJTuE
         qwFFmZf5VF8G3tRF6ggLWY587haE3n9sPkPsuaey+Eu8vEVAVLDAX7HOAVb6x4IDAqTF
         fj4DbFYpvsGNrd0dDiqr7UXTGO9WNQoL3YagIa02v6TqmF/j/ejnVGlVqNG01s8OrswF
         iatB3dT9AtcUe8jWlZsekYHnmVBlZOMjZd+1ApyXl2LVSLvsHi3mhqnXbPPdj8TvRsyc
         AqhN6yivRI360IywyGTbsiC+J4OdOeX2SuPZgDUTsXBVD9mHuIPBEF5ZiHP9HKeIKuTw
         vHeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=trJ6EtXGVxeJ2E2dBSh9BGipsejRJqHcnNYTifbPX1s=;
        b=u8Gt0r4RX7Inx4bZAJyAa0T+g1WUSlnxuqNthFVUVLh7+V27phUrQqSSpbOqv4Jleo
         EiImwnnPQeqe5xwv7vTlXkoLfTpRjJe3NhZt6WfALfg6ihQfDxCt71BBNMHn74cDWchI
         7A0XteZUJU/O1SI4Fbh3eTbhx4tONbzoU+dvLmKtALWHP8b4TFtdKe+5SXANDZGa895s
         iL6WO/k7c7JDdlM/fGQG5/+p0awPXzGJrWvI4LBLkhYRVaCtQmx90NAQXwh1BUJy0USw
         xjAMx5kCV1gGGTleKy2IHRKvl7BY051T7ldaaY1QKjKIHMTojaY01DUHwTsakFLCBfkJ
         gYEA==
X-Gm-Message-State: AFqh2kp3mMM71kQaUHR3KYnQowXCShZAVtwP9YGbgUm2Z9zNGdbtPKHr
        ihuFTrWtbTBppQhG6k3nSsqcB2wN4jF+4w==
X-Google-Smtp-Source: AMrXdXvevUITLkb6J0CtuQ+a1v5p48svpJMuSV/nlJ/+2CtLSO8L4mKGqfoduvMpV6ND2goyNRYFtQ==
X-Received: by 2002:a2e:9152:0:b0:281:1111:7f18 with SMTP id q18-20020a2e9152000000b0028111117f18mr6036462ljg.16.1674342243203;
        Sat, 21 Jan 2023 15:04:03 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id bj11-20020a2eaa8b000000b0028b959262d4sm1550667ljb.108.2023.01.21.15.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 15:04:02 -0800 (PST)
Date:   Sun, 22 Jan 2023 02:03:59 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
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
Message-ID: <20230121230359.kqfm4kvwys2jdan6@mobilestation>
References: <20230113171409.30470-20-Sergey.Semin@baikalelectronics.ru>
 <20230121005401.GA686892@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230121005401.GA686892@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Jan 20, 2023 at 06:54:01PM -0600, Bjorn Helgaas wrote:
> On Fri, Jan 13, 2023 at 08:14:01PM +0300, Serge Semin wrote:
> > Instead of splitting the 64-bits IOs up into two 32-bits ones it's
> > possible to use the already available non-atomic readq/writeq methods
> > implemented exactly for such cases. They are defined in the dedicated
> > header files io-64-nonatomic-lo-hi.h/io-64-nonatomic-hi-lo.h. So in case
> > if the 64-bits readq/writeq methods are unavailable on some platforms at
> > consideration, the corresponding drivers can have any of these headers
> > included and stop locally re-implementing the 64-bits IO accessors taking
> > into account the non-atomic nature of the included methods. Let's do that
> > in the DW eDMA driver too. Note by doing so we can discard the
> > CONFIG_64BIT config ifdefs from the code.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Acked-by: Vinod Koul <vkoul@kernel.org>
> > ---
> >  drivers/dma/dw-edma/dw-edma-v0-core.c | 55 +++++++++------------------
> >  1 file changed, 18 insertions(+), 37 deletions(-)
> > 
> > diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
> > index 66f296daac5a..51a34b43434c 100644
> > --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> > +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
> > @@ -8,6 +8,8 @@
> >  
> >  #include <linux/bitfield.h>
> >  
> > +#include <linux/io-64-nonatomic-lo-hi.h>
> > +
> >  #include "dw-edma-core.h"
> >  #include "dw-edma-v0-core.h"
> >  #include "dw-edma-v0-regs.h"
> > @@ -53,8 +55,6 @@ static inline struct dw_edma_v0_regs __iomem *__dw_regs(struct dw_edma *dw)
> >  		SET_32(dw, rd_##name, value);		\
> >  	} while (0)
> >  
> > -#ifdef CONFIG_64BIT
> > -
> >  #define SET_64(dw, name, value)				\
> >  	writeq(value, &(__dw_regs(dw)->name))
> >  
> > @@ -80,8 +80,6 @@ static inline struct dw_edma_v0_regs __iomem *__dw_regs(struct dw_edma *dw)
> >  		SET_64(dw, rd_##name, value);		\
> >  	} while (0)
> >  
> > -#endif /* CONFIG_64BIT */
> 

> Great to get rid of these #ifdefs!
> 
> Am I missing something?  It looks like SET_64 is used only by
> SET_RW_64 and SET_BOTH_64, and neither of *them is used at all.
> 
> Similarly for GET_64 and GET_RW_64.
> 
> So maybe we could get rid of everything inside the #ifdefs as well?

Even though these macros are indeed unused in the driver they are
still a part of the DW eDMA CSRs access interface. In particular they
are supposed to be used to access the 64-bit registers declared in the
dw_edma_v0_regs, dw_edma_v0_unroll and dw_edma_v0_ch_regs structures.
So until the interface is converted to a more preferable direct MMIO
usage without any packed-structures I'd rather leave these macros
be.

> 
> >  #define SET_COMPAT(dw, name, value)			\
> >  	writel(value, &(__dw_regs(dw)->type.unroll.name))
> >  
> > @@ -164,14 +162,13 @@ static inline u32 readl_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
> >  #define SET_LL_32(ll, value) \
> >  	writel(value, ll)
> >  
> > -#ifdef CONFIG_64BIT
> > -
> >  static inline void writeq_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
> >  			     u64 value, void __iomem *addr)
> >  {
> > +	unsigned long flags;
> > +
> >  	if (dw->chip->mf == EDMA_MF_EDMA_LEGACY) {
> >  		u32 viewport_sel;
> > -		unsigned long flags;
> >  
> >  		raw_spin_lock_irqsave(&dw->lock, flags);
> >  
> > @@ -181,22 +178,22 @@ static inline void writeq_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
> >  
> >  		writel(viewport_sel,
> >  		       &(__dw_regs(dw)->type.legacy.viewport_sel));
> > -		writeq(value, addr);
> > +	}
> > +
> > +	writeq(value, addr);
> >  
> > +	if (dw->chip->mf == EDMA_MF_EDMA_LEGACY)
> >  		raw_spin_unlock_irqrestore(&dw->lock, flags);
> > -	} else {
> > -		writeq(value, addr);
> > -	}
> 

> This is basically a cosmetic change unrelated to the commit log.  I
> don't really object to the change, although I think it's of dubious
> value to remove the repetition of the writeq() at the cost of adding
> another "if" and unlock.
> 

The denoted change is basically a leftover of the originally more
complex modification:
https://lore.kernel.org/linux-pci/20220503225104.12108-21-Sergey.Semin@baikalelectronics.ru
for which the update made more sense. But then the corresponding flag
was dropped from the Frank' patchset and I had to reduce the patch
to the code above.

Though I agree with you in both aspects. Indeed the value of the
change is questionable and it isn't related to the commit log.

> Lorenzo already applied this, so it's OK as-is unless you think it's
> worth reworking to drop the unused stuff mentioned above, in which
> case this rearrangement could be moved to a separate patch to make
> both of them more focused.

As I said above I'd rather leave the 64-bit accessors be until the
packed structure-based interface is removed from the driver.

Regarding the QWORD accessors update. If @Lorenzo agrees to replace
the already applied v9 patchset with a new one I can resubmit the
series with no rearrangement above.

-Serge(y)

> 
> Bjorn
