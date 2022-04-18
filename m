Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B587504F67
	for <lists+dmaengine@lfdr.de>; Mon, 18 Apr 2022 13:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234599AbiDRLkA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 18 Apr 2022 07:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbiDRLj7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 18 Apr 2022 07:39:59 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB991901B;
        Mon, 18 Apr 2022 04:37:20 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id x17so23720127lfa.10;
        Mon, 18 Apr 2022 04:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GwbdUJvNA5J7T0TOO8uErKoo51uQpGpYKXikXOcSBy0=;
        b=CmNbCck93oWdcKbsUSIBh9gXujj7jzuAujEmbcF4gHmy4NIsybxLCSNaVi+aIsG6LC
         c/GnGvHT0b+3iiXYk+uZ3yAxGCvHSnnS6HyMJHb+M9tKKfniaP6SuejhLg25Gmo1GsWP
         F+9+eYFthxbc5baIdKeHT75cyOF0iFxYjX2JjJgh05CEx0xWT1Up378X9Ql6Hh41n92j
         cBzNOOkDmilWtMfgUJP2LIX1U5cXVw0oHFmUnb00+uZ4T7Y5QPERivwRLOCHc95clOsA
         /GaKlZAHl4kxPxa6YsORUAOx45pO8cOZK0eaWlzwV0QT+/IsfcgTWNn31WsGSmCI4VmH
         RMAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GwbdUJvNA5J7T0TOO8uErKoo51uQpGpYKXikXOcSBy0=;
        b=tLz6I/LGBzsFV2c+UQaYDgNVMcDAGzpGmp6e0v3RTm3pu+78a21sgBN07RET03j66q
         xyCJssCJnyztyh0uKlmnSGzM7JCLVQirLlwmBmrGJD74hYNWddPluQuVEe9+641J4kcc
         gDjQNtcQSDo4Yc3REo8jVRW7htGdJQFqWy5uPqjPCAb7XC1x2Y1DzhCAjTsQs9lBjwto
         0GAVMqVXLmC22XlLNCTygGR/GrSHnFtRBFw9YmhZtldehCF9bcnh8p9up0+ZHPExtc7n
         oDW4JMyg5ncgMEsm611CyNMViT2AwfCzmJN0gRNrTxiQWDxZFZ4b7fca0ZdIs0fEhmji
         PyBA==
X-Gm-Message-State: AOAM530tpuMrQbzOQ5+N+WFLlZgvj5dcgjtpN2cGw0x5lH9Ef9A3eQbo
        oQnpCJK9+N5qr/zVzALXuqY=
X-Google-Smtp-Source: ABdhPJzcIspXqFwXv7tiyq3z/I8gZv/qLIzdZ91WDuXd3Gc6kgY4Xu0ABR+dv6IvOpBJUQRPyQ/GbA==
X-Received: by 2002:a05:6512:15a6:b0:471:a0e1:7430 with SMTP id bp38-20020a05651215a600b00471a0e17430mr994017lfb.183.1650281838353;
        Mon, 18 Apr 2022 04:37:18 -0700 (PDT)
Received: from mobilestation ([95.79.134.149])
        by smtp.gmail.com with ESMTPSA id x14-20020a056512046e00b0046d0d9bb454sm1190963lfd.41.2022.04.18.04.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 04:37:15 -0700 (PDT)
Date:   Mon, 18 Apr 2022 14:37:13 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Frank Li <Frank.Li@nxp.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 20/25] dmaengine: dw-edma: Use non-atomic io-64 methods
Message-ID: <20220418113713.65xtr4ed2c4gjddl@mobilestation>
References: <20220324014836.19149-1-Sergey.Semin@baikalelectronics.ru>
 <20220324014836.19149-21-Sergey.Semin@baikalelectronics.ru>
 <20220325082840.GH4675@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220325082840.GH4675@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Mar 25, 2022 at 01:58:40PM +0530, Manivannan Sadhasivam wrote:
> On Thu, Mar 24, 2022 at 04:48:31AM +0300, Serge Semin wrote:
> > Instead of splitting the 64-bits IOs up into two 32-bits ones it's
> > possible to use an available set of the non-atomic readq/writeq methods
> > implemented exactly for such cases. They are defined in the dedicated
> > header files io-64-nonatomic-lo-hi.h/io-64-nonatomic-hi-lo.h. So in case
> > if the 64-bits readq/writeq methods are unavailable on some platforms at
> > consideration, the corresponding drivers can have any of these headers
> > included and stop locally re-implementing the 64-bits IO accessors taking
> > into account the non-atomic nature of the included methods. Let's do that
> > in the DW eDMA driver too. Note by doing so we can discard the
> > CONFIG_64BIT config ifdefs from the code. Also note that if a platform
> > doesn't support 64-bit DBI IOs then the corresponding accessors will just
> > directly call the lo_hi_readq()/lo_hi_writeq() methods.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > ---
> >  drivers/dma/dw-edma/dw-edma-v0-core.c | 71 +++++++++------------------
> >  1 file changed, 24 insertions(+), 47 deletions(-)
> > 
> > diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
> > index 6b303d5a6b2a..ebb860e19c75 100644
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
> > -
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
> > @@ -181,22 +178,25 @@ static inline void writeq_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
> >  
> >  		writel(viewport_sel,
> >  		       &(__dw_regs(dw)->type.legacy.viewport_sel));
> > +	}
> > +
> > +	if (dw->chip->flags & DW_EDMA_CHIP_32BIT_DBI)
> > +		lo_hi_writeq(value, addr);
> > +	else
> >  		writeq(value, addr);
> >  
> > +	if (dw->chip->mf == EDMA_MF_EDMA_LEGACY)
> >  		raw_spin_unlock_irqrestore(&dw->lock, flags);
> > -	} else {
> > -		writeq(value, addr);
> > -	}
> >  }
> >  
> >  static inline u64 readq_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
> >  			   const void __iomem *addr)
> >  {
> > -	u32 value;
> > +	unsigned long flags;
> > +	u64 value;
> >  
> >  	if (dw->chip->mf == EDMA_MF_EDMA_LEGACY) {
> >  		u32 viewport_sel;
> > -		unsigned long flags;
> >  
> >  		raw_spin_lock_irqsave(&dw->lock, flags);
> >  
> > @@ -206,12 +206,15 @@ static inline u64 readq_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
> >  
> >  		writel(viewport_sel,
> >  		       &(__dw_regs(dw)->type.legacy.viewport_sel));
> > +	}
> > +
> > +	if (dw->chip->flags & DW_EDMA_CHIP_32BIT_DBI)
> > +		value = lo_hi_readq(addr);
> > +	else
> >  		value = readq(addr);
> >  
> > +	if (dw->chip->mf == EDMA_MF_EDMA_LEGACY)
> >  		raw_spin_unlock_irqrestore(&dw->lock, flags);
> > -	} else {
> > -		value = readq(addr);
> > -	}
> >  
> >  	return value;
> >  }
> > @@ -225,8 +228,6 @@ static inline u64 readq_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
> >  #define SET_LL_64(ll, value) \
> >  	writeq(value, ll)
> >  
> > -#endif /* CONFIG_64BIT */
> > -
> >  /* eDMA management callbacks */
> >  void dw_edma_v0_core_off(struct dw_edma *dw)
> >  {
> > @@ -325,19 +326,10 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
> >  		/* Transfer size */
> >  		SET_LL_32(&lli[i].transfer_size, child->sz);
> >  		/* SAR */
> > -		#ifdef CONFIG_64BIT
> > -			SET_LL_64(&lli[i].sar.reg, child->sar);
> > -		#else /* CONFIG_64BIT */
> > -			SET_LL_32(&lli[i].sar.lsb, lower_32_bits(child->sar));
> > -			SET_LL_32(&lli[i].sar.msb, upper_32_bits(child->sar));
> > -		#endif /* CONFIG_64BIT */
> > +		SET_LL_64(&lli[i].sar.reg, child->sar);
> 

> This macro still uses writeq(), that's not available on 32bit platforms.
> Am I missing anything?

Yes, the writeq/readq macro are defined in the
include/linux/{io-64-nonatomic-lo-hi.h,io-64-nonatomic-hi-lo.h} files.
If the platform doesn't provide its own 64-bit IOs implementation
these macro are used and are unwrapped with the two writel/readl
methods.

-Sergey

> 
> Thanks,
> Mani
> 
> >  		/* DAR */
> > -		#ifdef CONFIG_64BIT
> > -			SET_LL_64(&lli[i].dar.reg, child->dar);
> > -		#else /* CONFIG_64BIT */
> > -			SET_LL_32(&lli[i].dar.lsb, lower_32_bits(child->dar));
> > -			SET_LL_32(&lli[i].dar.msb, upper_32_bits(child->dar));
> > -		#endif /* CONFIG_64BIT */
> > +		SET_LL_64(&lli[i].dar.reg, child->dar);
> > +
> >  		i++;
> >  	}
> >  
> > @@ -349,12 +341,7 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
> >  	/* Channel control */
> >  	SET_LL_32(&llp->control, control);
> >  	/* Linked list */
> > -	#ifdef CONFIG_64BIT
> > -		SET_LL_64(&llp->llp.reg, chunk->ll_region.paddr);
> > -	#else /* CONFIG_64BIT */
> > -		SET_LL_32(&llp->llp.lsb, lower_32_bits(chunk->ll_region.paddr));
> > -		SET_LL_32(&llp->llp.msb, upper_32_bits(chunk->ll_region.paddr));
> > -	#endif /* CONFIG_64BIT */
> > +	SET_LL_64(&llp->llp.reg, chunk->ll_region.paddr);
> >  }
> >  
> >  void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
> > @@ -417,18 +404,8 @@ void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
> >  		SET_CH_32(dw, chan->dir, chan->id, ch_control1,
> >  			  (DW_EDMA_V0_CCS | DW_EDMA_V0_LLE));
> >  		/* Linked list */
> > -		if ((chan->dw->chip->flags & DW_EDMA_CHIP_32BIT_DBI) ||
> > -		    !IS_ENABLED(CONFIG_64BIT)) {
> > -			SET_CH_32(dw, chan->dir, chan->id, llp.lsb,
> > -				  lower_32_bits(chunk->ll_region.paddr));
> > -			SET_CH_32(dw, chan->dir, chan->id, llp.msb,
> > -				  upper_32_bits(chunk->ll_region.paddr));
> > -		} else {
> > -		#ifdef CONFIG_64BIT
> > -			SET_CH_64(dw, chan->dir, chan->id, llp.reg,
> > -				  chunk->ll_region.paddr);
> > -		#endif
> > -		}
> > +		SET_CH_64(dw, chan->dir, chan->id, llp.reg,
> > +			  chunk->ll_region.paddr);
> >  	}
> >  	/* Doorbell */
> >  	SET_RW_32(dw, chan->dir, doorbell,
> > -- 
> > 2.35.1
> > 
