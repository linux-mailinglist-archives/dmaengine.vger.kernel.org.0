Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6D6525129
	for <lists+dmaengine@lfdr.de>; Thu, 12 May 2022 17:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355881AbiELPVi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 12 May 2022 11:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355892AbiELPVh (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 12 May 2022 11:21:37 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A847B60AA7
        for <dmaengine@vger.kernel.org>; Thu, 12 May 2022 08:21:35 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d17so5227320plg.0
        for <dmaengine@vger.kernel.org>; Thu, 12 May 2022 08:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=wugDBnbRuzKC0a1hq4EsLQPeGzgo7aOGzXHl13nvmfI=;
        b=A6B5cU0EoxHHjTBuMkaPorCTZmQLBffuruO0nBgCr0DJK/lILHBgLDdMEpbIP0fOeS
         SPhWECtqSL2uEpAz/GVSKPUzRbXazuLNcXg+MLVYHjSiv6TD5aBFvT8xRITjCnH9ZyIZ
         S6ucuQ9psa4R3brDYi8zNYnGdaWPbE6ExzbFM8ZYBE/uRSfjY4dcB3WAcwn+jaA9n3Gq
         +yzglzjUDQUuXgdSrPuYEPGw3cEASInbgVCgljEplyWz/1bztPDXO6ac/aL71+zY87fu
         /0ic7djWzMAfe+2RP73UM83BCKrjAs9xFJBTD6la44aMfIIB9AQqGROjb8iSTkjIDGGr
         2msA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=wugDBnbRuzKC0a1hq4EsLQPeGzgo7aOGzXHl13nvmfI=;
        b=t4Z42j1vCAuWwUPECVeCLa6gV7ZrKJFBc+zsUvX9RJc47G0LEEC7jh77IRWZ1vEup7
         WyOef4QE17sLgksiyi0p1QE31cSaeugpSyOyNmpuym0vMxSAqbBsYZZhyt54aRp1Htbk
         RctHwU5KNUwwYBn8EZZW2zzYm13Ex0xLjqk1grkF/uulbghNNLpE8D0pse9Pp8606F67
         2Mf8+8K2eOiFIX1DtJ/f3ZJi9CPz2TQ2ZZM12NsCgNCSMtEVeRdQWJob102s/PTOfd+z
         mPakMnq5nUgNmMeWXmtuPz4+vMG1xRj7RsWlyoNhtQi4OtH3ZUj4jL8EvjEzrV6XVoQq
         aTlQ==
X-Gm-Message-State: AOAM532nz3fZBfolA+zuNv3p6vosDGwDyzc0aU8SVadgyHACOmOHmCxq
        p7qKO8z5MfToAlLy90G5ozCA
X-Google-Smtp-Source: ABdhPJzw0y2WFtvLkozOWI5jxhMgxCBrUabYE06pz5qwCzs/Hsjg8yz6Ypie/Ll8NxECq5GqB3gf/A==
X-Received: by 2002:a17:90b:1809:b0:1dc:1597:20c with SMTP id lw9-20020a17090b180900b001dc1597020cmr137698pjb.36.1652368895143;
        Thu, 12 May 2022 08:21:35 -0700 (PDT)
Received: from thinkpad ([117.202.184.202])
        by smtp.gmail.com with ESMTPSA id w2-20020a1709026f0200b0015eaa9aee50sm14713plk.202.2022.05.12.08.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 08:21:34 -0700 (PDT)
Date:   Thu, 12 May 2022 20:51:26 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Frank Li <Frank.Li@nxp.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 20/26] dmaengine: dw-edma: Use non-atomic io-64 methods
Message-ID: <20220512152126.GN35848@thinkpad>
References: <20220503225104.12108-1-Sergey.Semin@baikalelectronics.ru>
 <20220503225104.12108-21-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220503225104.12108-21-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, May 04, 2022 at 01:50:58AM +0300, Serge Semin wrote:
> Instead of splitting the 64-bits IOs up into two 32-bits ones it's
> possible to use an available set of the non-atomic readq/writeq methods
> implemented exactly for such cases. They are defined in the dedicated
> header files io-64-nonatomic-lo-hi.h/io-64-nonatomic-hi-lo.h. So in case
> if the 64-bits readq/writeq methods are unavailable on some platforms at
> consideration, the corresponding drivers can have any of these headers
> included and stop locally re-implementing the 64-bits IO accessors taking
> into account the non-atomic nature of the included methods. Let's do that
> in the DW eDMA driver too. Note by doing so we can discard the
> CONFIG_64BIT config ifdefs from the code. Also note that if a platform
> doesn't support 64-bit DBI IOs then the corresponding accessors will just
> directly call the lo_hi_readq()/lo_hi_writeq() methods.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/dma/dw-edma/dw-edma-v0-core.c | 71 +++++++++------------------
>  1 file changed, 24 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
> index e6d611176891..4348d2323125 100644
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
> -
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
> @@ -181,22 +178,25 @@ static inline void writeq_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
>  
>  		writel(viewport_sel,
>  		       &(__dw_regs(dw)->type.legacy.viewport_sel));
> +	}
> +
> +	if (dw->chip->flags & DW_EDMA_CHIP_32BIT_DBI)
> +		lo_hi_writeq(value, addr);
> +	else
>  		writeq(value, addr);
>  
> +	if (dw->chip->mf == EDMA_MF_EDMA_LEGACY)
>  		raw_spin_unlock_irqrestore(&dw->lock, flags);
> -	} else {
> -		writeq(value, addr);
> -	}
>  }
>  
>  static inline u64 readq_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
>  			   const void __iomem *addr)
>  {
> -	u32 value;
> +	unsigned long flags;
> +	u64 value;
>  
>  	if (dw->chip->mf == EDMA_MF_EDMA_LEGACY) {
>  		u32 viewport_sel;
> -		unsigned long flags;
>  
>  		raw_spin_lock_irqsave(&dw->lock, flags);
>  
> @@ -206,12 +206,15 @@ static inline u64 readq_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
>  
>  		writel(viewport_sel,
>  		       &(__dw_regs(dw)->type.legacy.viewport_sel));
> +	}
> +
> +	if (dw->chip->flags & DW_EDMA_CHIP_32BIT_DBI)
> +		value = lo_hi_readq(addr);
> +	else
>  		value = readq(addr);
>  
> +	if (dw->chip->mf == EDMA_MF_EDMA_LEGACY)
>  		raw_spin_unlock_irqrestore(&dw->lock, flags);
> -	} else {
> -		value = readq(addr);
> -	}
>  
>  	return value;
>  }
> @@ -225,8 +228,6 @@ static inline u64 readq_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
>  #define SET_LL_64(ll, value) \
>  	writeq(value, ll)
>  
> -#endif /* CONFIG_64BIT */
> -
>  /* eDMA management callbacks */
>  void dw_edma_v0_core_off(struct dw_edma *dw)
>  {
> @@ -325,19 +326,10 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
>  		/* Transfer size */
>  		SET_LL_32(&lli[i].transfer_size, child->sz);
>  		/* SAR */
> -		#ifdef CONFIG_64BIT
> -			SET_LL_64(&lli[i].sar.reg, child->sar);
> -		#else /* CONFIG_64BIT */
> -			SET_LL_32(&lli[i].sar.lsb, lower_32_bits(child->sar));
> -			SET_LL_32(&lli[i].sar.msb, upper_32_bits(child->sar));
> -		#endif /* CONFIG_64BIT */
> +		SET_LL_64(&lli[i].sar.reg, child->sar);
>  		/* DAR */
> -		#ifdef CONFIG_64BIT
> -			SET_LL_64(&lli[i].dar.reg, child->dar);
> -		#else /* CONFIG_64BIT */
> -			SET_LL_32(&lli[i].dar.lsb, lower_32_bits(child->dar));
> -			SET_LL_32(&lli[i].dar.msb, upper_32_bits(child->dar));
> -		#endif /* CONFIG_64BIT */
> +		SET_LL_64(&lli[i].dar.reg, child->dar);
> +
>  		i++;
>  	}
>  
> @@ -349,12 +341,7 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
>  	/* Channel control */
>  	SET_LL_32(&llp->control, control);
>  	/* Linked list */
> -	#ifdef CONFIG_64BIT
> -		SET_LL_64(&llp->llp.reg, chunk->ll_region.paddr);
> -	#else /* CONFIG_64BIT */
> -		SET_LL_32(&llp->llp.lsb, lower_32_bits(chunk->ll_region.paddr));
> -		SET_LL_32(&llp->llp.msb, upper_32_bits(chunk->ll_region.paddr));
> -	#endif /* CONFIG_64BIT */
> +	SET_LL_64(&llp->llp.reg, chunk->ll_region.paddr);
>  }
>  
>  void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
> @@ -417,18 +404,8 @@ void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
>  		SET_CH_32(dw, chan->dir, chan->id, ch_control1,
>  			  (DW_EDMA_V0_CCS | DW_EDMA_V0_LLE));
>  		/* Linked list */
> -		if ((chan->dw->chip->flags & DW_EDMA_CHIP_32BIT_DBI) ||
> -		    !IS_ENABLED(CONFIG_64BIT)) {
> -			SET_CH_32(dw, chan->dir, chan->id, llp.lsb,
> -				  lower_32_bits(chunk->ll_region.paddr));
> -			SET_CH_32(dw, chan->dir, chan->id, llp.msb,
> -				  upper_32_bits(chunk->ll_region.paddr));
> -		} else {
> -		#ifdef CONFIG_64BIT
> -			SET_CH_64(dw, chan->dir, chan->id, llp.reg,
> -				  chunk->ll_region.paddr);
> -		#endif
> -		}
> +		SET_CH_64(dw, chan->dir, chan->id, llp.reg,
> +			  chunk->ll_region.paddr);
>  	}
>  	/* Doorbell */
>  	SET_RW_32(dw, chan->dir, doorbell,
> -- 
> 2.35.1
> 

-- 
மணிவண்ணன் சதாசிவம்
