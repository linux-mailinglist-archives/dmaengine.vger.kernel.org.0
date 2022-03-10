Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1FEA4D50D8
	for <lists+dmaengine@lfdr.de>; Thu, 10 Mar 2022 18:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241578AbiCJRsU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 10 Mar 2022 12:48:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233573AbiCJRsT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 10 Mar 2022 12:48:19 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507B618E3C1;
        Thu, 10 Mar 2022 09:47:18 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id bn33so8811115ljb.6;
        Thu, 10 Mar 2022 09:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=f3HKbg0VDOkKVDHSl+2ED0O00xGdt6bRjRwDkKNYAk4=;
        b=P6hD4FyosbTlX5ruEa2TYeKEX2mEfjanZZttoiONGkeQZ/Yj0Mwax0JRutequR3XvG
         aLaf5NjdDCix5qfiR+yKAQWRxEyc7HPisTbvwfjZ66fI/2qwER1H8SHXGu3czAAE0o+i
         80eNKi3Ieb39YSmn4ekEhEGrjfqmH32n5riblLEYF2VswIQnMFi7kcTQ6JM9TO21iYrD
         uChIe2mzch3RU+3tCfaEiLhjS3WQfbDnUhcpfmf72IRbldNQuQgp/grsIGpMcoVl7347
         Jvi9KrHDd+iRlmYkdbkPTYi9clBiYXwp9FwWs4a4GOPVe1iiHehHRGDhw74N6U4bjlZQ
         aVBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f3HKbg0VDOkKVDHSl+2ED0O00xGdt6bRjRwDkKNYAk4=;
        b=rQar0IfClAdJ0lfN8DzdmEnXYfYycB0FJba/Ho07nEL776+79FUqunyquJT/J8dQ2t
         BVcjr0jRhXysu94beiS4K0urr9R/NmYUf5Td1XZxV2SeIo6YBIHjP17o1uWS0sa0naq3
         ZjnOuRdD4rRHKqVVR2FwXSnn1my2g0B97TDQvkC7WtcVKDAotcOsCy9G0e2cQqochpEW
         WG43XWQo2AZacbCzSZCNJq6RCoVmsDVCY2Tzm5PArbtCZ4ml/KJtsefl4iJbC55xmIA4
         5G1WCEjuQVTLUOahw5/BWe3MV2H2T/1XIJGcRK56vEm3KBZq9sGuw/621b7E/qZxNlrW
         fs7Q==
X-Gm-Message-State: AOAM532LS4KSis5OJvBzY/Jd5i8NcHMxRBJNPEMz6N1hPGYWdHIRfqih
        cduXM8wk98vZML3Ujh4yUdA=
X-Google-Smtp-Source: ABdhPJzp4XMb9HibhNAJ74OYYRQiVE1g6nh4mjphKyzCkrmNYXX4G9Gvaq6Ql6OzGXe+WGya8Q5oag==
X-Received: by 2002:a05:651c:54e:b0:247:e3a6:1e33 with SMTP id q14-20020a05651c054e00b00247e3a61e33mr3746273ljp.126.1646934436492;
        Thu, 10 Mar 2022 09:47:16 -0800 (PST)
Received: from mobilestation ([95.79.188.22])
        by smtp.gmail.com with ESMTPSA id 194-20020a2e05cb000000b00247eb0e1b15sm1196841ljf.97.2022.03.10.09.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 09:47:03 -0800 (PST)
Date:   Thu, 10 Mar 2022 20:46:43 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        lznuaa@gmail.com, vkoul@kernel.org, lorenzo.pieralisi@arm.com,
        robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        shawnguo@kernel.org, manivannan.sadhasivam@linaro.org
Subject: Re: [PATCH v4 7/8] dmaengine: dw-edma: add flags at struct
 dw_edma_chip
Message-ID: <20220310174643.gxtmg373dgqqocpk@mobilestation>
References: <20220309211204.26050-1-Frank.Li@nxp.com>
 <20220309211204.26050-8-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309211204.26050-8-Frank.Li@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Mar 09, 2022 at 03:12:03PM -0600, Frank Li wrote:
> Allow PCI EP probe DMA locally and prevent use of remote MSI
> to remote PCI host.
> 
> Add option to force 32bit DBI register access even on
> 64-bit systems. i.MX8 hardware only allowed 32bit register
> access.

Could you please split this patch up into two? These flags are
unrelated thus adding them is two unrelated changes. That can be
implicitly inferred from your commit log and the patch title.

-Sergey

> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change from v3 to v4
>  - None
> Change from v2 to v3
>  - rework commit message
>  - Change to DW_EDMA_CHIP_32BIT_DBI
>  - using DW_EDMA_CHIP_LOCAL control msi
>  - Apply Bjorn's comments,
>         if (!j) {
>                control |= DW_EDMA_V0_LIE;
>                if (!(chan->chip->flags & DW_EDMA_CHIP_LOCAL))
>                                control |= DW_EDMA_V0_RIE;
>         }
> 
>         if ((chan->chip->flags & DW_EDMA_CHIP_REG32BIT) ||
>               !IS_ENABLED(CONFIG_64BIT)) {
>           SET_CH_32(...);
>           SET_CH_32(...);
>        } else {
>           SET_CH_64(...);
>        }
> 
> 
> Change from v1 to v2
> - none
>  drivers/dma/dw-edma/dw-edma-v0-core.c | 20 ++++++++++++--------
>  include/linux/dma/edma.h              |  9 +++++++++
>  2 files changed, 21 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
> index 35f2adac93e46..00a00d68d44e7 100644
> --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
> @@ -301,6 +301,7 @@ u32 dw_edma_v0_core_status_abort_int(struct dw_edma *dw, enum dw_edma_dir dir)
>  static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
>  {
>  	struct dw_edma_burst *child;
> +	struct dw_edma_chan *chan = chunk->chan;
>  	struct dw_edma_v0_lli __iomem *lli;
>  	struct dw_edma_v0_llp __iomem *llp;
>  	u32 control = 0, i = 0;
> @@ -314,9 +315,11 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
>  	j = chunk->bursts_alloc;
>  	list_for_each_entry(child, &chunk->burst->list, list) {
>  		j--;
> -		if (!j)
> -			control |= (DW_EDMA_V0_LIE | DW_EDMA_V0_RIE);
> -
> +		if (!j) {
> +			control |= DW_EDMA_V0_LIE;
> +			if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
> +				control |= DW_EDMA_V0_RIE;
> +		}
>  		/* Channel control */
>  		SET_LL_32(&lli[i].control, control);
>  		/* Transfer size */
> @@ -414,15 +417,16 @@ void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
>  		SET_CH_32(dw, chan->dir, chan->id, ch_control1,
>  			  (DW_EDMA_V0_CCS | DW_EDMA_V0_LLE));
>  		/* Linked list */
> -		#ifdef CONFIG_64BIT
> -			SET_CH_64(dw, chan->dir, chan->id, llp.reg,
> -				  chunk->ll_region.paddr);
> -		#else /* CONFIG_64BIT */
> +		if ((chan->dw->chip->flags & DW_EDMA_CHIP_32BIT_DBI) ||
> +		    !IS_ENABLED(CONFIG_64BIT)) {
>  			SET_CH_32(dw, chan->dir, chan->id, llp.lsb,
>  				  lower_32_bits(chunk->ll_region.paddr));
>  			SET_CH_32(dw, chan->dir, chan->id, llp.msb,
>  				  upper_32_bits(chunk->ll_region.paddr));
> -		#endif /* CONFIG_64BIT */
> +		} else {
> +			SET_CH_64(dw, chan->dir, chan->id, llp.reg,
> +				  chunk->ll_region.paddr);
> +		}
>  	}
>  	/* Doorbell */
>  	SET_RW_32(dw, chan->dir, doorbell,
> diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> index c2039246fc08c..eea11b1d9e688 100644
> --- a/include/linux/dma/edma.h
> +++ b/include/linux/dma/edma.h
> @@ -33,6 +33,12 @@ enum dw_edma_map_format {
>  	EDMA_MF_HDMA_COMPAT = 0x5
>  };
>  
> +/* Probe EDMA engine locally and prevent generate MSI to host side*/
> +#define DW_EDMA_CHIP_LOCAL	BIT(0)
> +
> +/* Only support 32bit DBI register access */
> +#define DW_EDMA_CHIP_32BIT_DBI	BIT(1)
> +
>  /**
>   * struct dw_edma_chip - representation of DesignWare eDMA controller hardware
>   * @dev:		 struct device of the eDMA controller
> @@ -40,6 +46,8 @@ enum dw_edma_map_format {
>   * @nr_irqs:		 total dma irq number
>   * @ops			 DMA channel to IRQ number mapping
>   * @reg_base		 DMA register base address
> + * @flags		   - DW_EDMA_CHIP_LOCAL
> + *			   - DW_EDMA_CHIP_32BIT_DBI
>   * @ll_wr_cnt		 DMA write link list number
>   * @ll_rd_cnt		 DMA read link list number
>   * @rg_region		 DMA register region
> @@ -53,6 +61,7 @@ struct dw_edma_chip {
>  	int			id;
>  	int			nr_irqs;
>  	const struct dw_edma_core_ops   *ops;
> +	u32			flags;
>  
>  	void __iomem		*reg_base;
>  
> -- 
> 2.24.0.rc1
> 
