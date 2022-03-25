Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5064E6F6A
	for <lists+dmaengine@lfdr.de>; Fri, 25 Mar 2022 09:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354443AbiCYIaX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 25 Mar 2022 04:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354356AbiCYIaW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 25 Mar 2022 04:30:22 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5EC315A38
        for <dmaengine@vger.kernel.org>; Fri, 25 Mar 2022 01:28:47 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id c11so5853995pgu.11
        for <dmaengine@vger.kernel.org>; Fri, 25 Mar 2022 01:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QnCTPLNWY2CE85GSrCxeXZhpb0Hof6FDkcRGjoXPIbg=;
        b=XJc7cg2F9E8+S/WMSrBMsV5kJJbpF2AdbacOusAT/GVUEZnlqv2vCWMowPbrX/pFGZ
         4ylxb+3ynQUkR9qKF2qrulcImYyJaB9pYJWU67ouX3ldU++NvyhoaZB5whYF8M/BXrSX
         GNTZUWTYc55W+2Bh0Uls4HhNpz6uwrLhLxSh4n1hwYNmEpgSVbhj8Reg0Nu80ReI2IBU
         iwALEkWjTHAB2wfcZ9yzUr2BIEohukCjkMYFKI4BfzJrFdUNgln5rNJQVEwIeSy1dSD/
         z10/hebnmAP4ha5vxOMtXyoJAhtpXFUw+7CwXTe9uY+QkOK+dqTLNN2cJUFcq++GR0mg
         wnwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QnCTPLNWY2CE85GSrCxeXZhpb0Hof6FDkcRGjoXPIbg=;
        b=0JbmtvBCWVoyQI5S9ZfWFLyAIjAOJ3uaivaCsCubA4pwds9eGQNqWPJ8RR/UsFZdk2
         zvsxPsIQvhY+z+fHWKUKOuApxCEaaKQnf5Fv8HAMrwdFPsFgLQLBt33HwgVo1a5+DM7+
         YpTq0QRGbPgqAdTRwUUvZxemq6AUaOuaPIc/zSb4GppDKHriSXWghFY0hW0UNZiEK/jv
         I2fUpQgJrfZFxzPHEC1kS3QPfctMJEs5S0aNQ/zOww5p2tPfN+YkLxt4Zy9EJm6Puekd
         hgLOMOFY7/N8795rbchO290seWMjJnCwU1KJii1tgkoxj/yizRJPovARyWES3aXHU6rN
         WjFQ==
X-Gm-Message-State: AOAM531PuxyEsQfxr7PtEQbip7DpeP2Pyd6Y0lp9Pd1/YM3EqRwMRjzE
        jdlCEmECxuj00aKztFURPP0Q
X-Google-Smtp-Source: ABdhPJw6/aHo2KgPyGlIO4oys1ILiHW2aeWOmTwIIsB7j25OdjYT49hvBYfAiL4SjbE33qCCbAwliw==
X-Received: by 2002:aa7:9110:0:b0:4fa:e388:af57 with SMTP id 16-20020aa79110000000b004fae388af57mr8776301pfh.1.1648196927297;
        Fri, 25 Mar 2022 01:28:47 -0700 (PDT)
Received: from thinkpad ([27.111.75.218])
        by smtp.gmail.com with ESMTPSA id o14-20020a056a0015ce00b004fab49cd65csm6398165pfu.205.2022.03.25.01.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 01:28:46 -0700 (PDT)
Date:   Fri, 25 Mar 2022 13:58:40 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Frank Li <Frank.Li@nxp.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 20/25] dmaengine: dw-edma: Use non-atomic io-64 methods
Message-ID: <20220325082840.GH4675@thinkpad>
References: <20220324014836.19149-1-Sergey.Semin@baikalelectronics.ru>
 <20220324014836.19149-21-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324014836.19149-21-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Mar 24, 2022 at 04:48:31AM +0300, Serge Semin wrote:
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
> ---
>  drivers/dma/dw-edma/dw-edma-v0-core.c | 71 +++++++++------------------
>  1 file changed, 24 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
> index 6b303d5a6b2a..ebb860e19c75 100644
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

This macro still uses writeq(), that's not available on 32bit platforms.
Am I missing anything?

Thanks,
Mani

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
