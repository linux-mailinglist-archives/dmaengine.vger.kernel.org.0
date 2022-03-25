Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 674BF4E6F15
	for <lists+dmaengine@lfdr.de>; Fri, 25 Mar 2022 08:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243575AbiCYHnM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 25 Mar 2022 03:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355277AbiCYHnI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 25 Mar 2022 03:43:08 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93CDCA0C7
        for <dmaengine@vger.kernel.org>; Fri, 25 Mar 2022 00:41:34 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id s8so5798845pfk.12
        for <dmaengine@vger.kernel.org>; Fri, 25 Mar 2022 00:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=z6svh2R4vFwE8Zw/glJswc4sMNhq4MHc9rrhwP+u20A=;
        b=HamqelnytmFJzve82M+8uzqIZAM8/ypZ/hSqWrJM2D3H8gYeDJdy8z5rQjruVmCkg4
         o35a4qpR1MvMCJ7dund2tOT5luyG5Bv7oJNntU19A3Z9rXyO0ByTLG8rEdWZXt0ID8s0
         7S+VeDNZwR/Mjudz2xb2EdKfEtM10RWevSf6J1q8xUWm3Af4zGrMPuOuCHG8aVTpKyC1
         /DS7d5Z2zFT4fFxsgASZj9S0Lak4YC9rzbtLad4oBGmqNodJbxSGhg4bR1fWOFGOP5XC
         FiuMMTMu2NcDuTzHxK2SG7vqRKAGIMddPJP6s8hMQlDDKfhbWchzoCVfzMlLtVk4xrjb
         PN3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=z6svh2R4vFwE8Zw/glJswc4sMNhq4MHc9rrhwP+u20A=;
        b=At1L7+XJkgfkopFLeY4IWEDqZidD/CEAgBYfwVCh+knR7/UDPYX8pPH+w5r0f4PUwu
         vPK3Vu16tmmMMUbUnhCg1fj6c/M9DQHr4w2EqYzTJtod0wbPlnvbNA/oQKWQvaRaGxDj
         2wgvmZbG2uCIYHhmf72FQYiZo9kvlURdrZxbY0+ceNWzczm5ozZDWjns0wkCawZqu97v
         21Was0SXc1lxtLH8tt7AY/krowtcLuaR9GaV/UGWsvXvVec9mWsUA1RB8RskQksaGWmq
         tiQlQgdNtIvXVquT1Ftu311qSyJ8uVI9jMlF/hJ11JQyRLBUvQ/E8wdwOmJZLBRfPcde
         pLpQ==
X-Gm-Message-State: AOAM533KQ1IroN1nVYgzFdUyCLCOcADx2+0m9mIykixFOKbLXhw241Ul
        uMNYemI8A6IwwAx2yxVUOZza
X-Google-Smtp-Source: ABdhPJzvYGPL98D0FkGBYcmVjS9mreEr/lPGokYsim9pd8Gtt78QQ3171eeifStmY6CKvGw1/vymyw==
X-Received: by 2002:a63:801:0:b0:382:a089:59d3 with SMTP id 1-20020a630801000000b00382a08959d3mr6990246pgi.350.1648194094355;
        Fri, 25 Mar 2022 00:41:34 -0700 (PDT)
Received: from thinkpad ([27.111.75.218])
        by smtp.gmail.com with ESMTPSA id b1-20020a17090aa58100b001bcb7bad374sm11585015pjq.17.2022.03.25.00.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 00:41:34 -0700 (PDT)
Date:   Fri, 25 Mar 2022 13:11:26 +0530
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
Subject: Re: [PATCH 19/25] dmaengine: dw-edma: Use DMA-engine device DebugFS
 subdirectory
Message-ID: <20220325074126.GG4675@thinkpad>
References: <20220324014836.19149-1-Sergey.Semin@baikalelectronics.ru>
 <20220324014836.19149-20-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324014836.19149-20-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Mar 24, 2022 at 04:48:30AM +0300, Serge Semin wrote:
> Since all DW eDMA read and write channels are now installed in a framework
> of a single DMA-engine device, we can freely move all the DW eDMA-specific
> DebugFS nodes into a ready-to-use DMA-engine DebugFS subdirectory. It's
> created during the DMA-device registration and can be found in the
> dma_device.dbg_dev_root field.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/dma/dw-edma/dw-edma-core.c       |  3 ---
>  drivers/dma/dw-edma/dw-edma-core.h       |  3 ---
>  drivers/dma/dw-edma/dw-edma-v0-core.c    |  5 -----
>  drivers/dma/dw-edma/dw-edma-v0-core.h    |  1 -
>  drivers/dma/dw-edma/dw-edma-v0-debugfs.c | 18 ++++--------------
>  drivers/dma/dw-edma/dw-edma-v0-debugfs.h |  5 -----
>  6 files changed, 4 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index a391e44da039..bc530f0a2468 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -1045,9 +1045,6 @@ int dw_edma_remove(struct dw_edma_chip *chip)
>  		list_del(&chan->vc.chan.device_node);
>  	}
>  
> -	/* Turn debugfs off */
> -	dw_edma_v0_core_debugfs_off(chip);
> -
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(dw_edma_remove);
> diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
> index ec9f84a857d1..980adb079182 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.h
> +++ b/drivers/dma/dw-edma/dw-edma-core.h
> @@ -110,9 +110,6 @@ struct dw_edma {
>  	raw_spinlock_t			lock;		/* Only for legacy */
>  
>  	struct dw_edma_chip             *chip;
> -#ifdef CONFIG_DEBUG_FS
> -	struct dentry			*debugfs;
> -#endif /* CONFIG_DEBUG_FS */
>  };
>  
>  struct dw_edma_sg {
> diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
> index 013d9a9cb991..6b303d5a6b2a 100644
> --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
> @@ -511,8 +511,3 @@ void dw_edma_v0_core_debugfs_on(struct dw_edma_chip *chip)
>  {
>  	dw_edma_v0_debugfs_on(chip);
>  }
> -
> -void dw_edma_v0_core_debugfs_off(struct dw_edma_chip *chip)
> -{
> -	dw_edma_v0_debugfs_off(chip);
> -}
> diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.h b/drivers/dma/dw-edma/dw-edma-v0-core.h
> index 2afa626b8300..43e01844375a 100644
> --- a/drivers/dma/dw-edma/dw-edma-v0-core.h
> +++ b/drivers/dma/dw-edma/dw-edma-v0-core.h
> @@ -23,6 +23,5 @@ void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first);
>  int dw_edma_v0_core_device_config(struct dw_edma_chan *chan);
>  /* eDMA debug fs callbacks */
>  void dw_edma_v0_core_debugfs_on(struct dw_edma_chip *chip);
> -void dw_edma_v0_core_debugfs_off(struct dw_edma_chip *chip);
>  
>  #endif /* _DW_EDMA_V0_CORE_H */
> diff --git a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
> index 353269a3680b..319a3c790dc4 100644
> --- a/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
> +++ b/drivers/dma/dw-edma/dw-edma-v0-debugfs.c
> @@ -268,7 +268,7 @@ static void dw_edma_debugfs_regs(struct dw_edma *dw)
>  	struct dentry *regs_dir;
>  	int nr_entries;
>  
> -	regs_dir = debugfs_create_dir(REGISTERS_STR, dw->debugfs);
> +	regs_dir = debugfs_create_dir(REGISTERS_STR, dw->dma.dbg_dev_root);
>  
>  	nr_entries = ARRAY_SIZE(debugfs_regs);
>  	dw_edma_debugfs_create_x32(dw, debugfs_regs, nr_entries, regs_dir);
> @@ -284,19 +284,9 @@ void dw_edma_v0_debugfs_on(struct dw_edma_chip *chip)
>  	if (!debugfs_initialized())
>  		return;
>  
> -	dw->debugfs = debugfs_create_dir(dw->name, NULL);
> -
> -	debugfs_create_u32("mf", 0444, dw->debugfs, &dw->chip->mf);
> -	debugfs_create_u16("wr_ch_cnt", 0444, dw->debugfs, &dw->wr_ch_cnt);
> -	debugfs_create_u16("rd_ch_cnt", 0444, dw->debugfs, &dw->rd_ch_cnt);
> +	debugfs_create_u32("mf", 0444, dw->dma.dbg_dev_root, &dw->chip->mf);
> +	debugfs_create_u16("wr_ch_cnt", 0444, dw->dma.dbg_dev_root, &dw->wr_ch_cnt);
> +	debugfs_create_u16("rd_ch_cnt", 0444, dw->dma.dbg_dev_root, &dw->rd_ch_cnt);
>  
>  	dw_edma_debugfs_regs(dw);
>  }
> -
> -void dw_edma_v0_debugfs_off(struct dw_edma_chip *chip)
> -{
> -	struct dw_edma *dw = chip->dw;
> -
> -	debugfs_remove_recursive(dw->debugfs);
> -	dw->debugfs = NULL;
> -}
> diff --git a/drivers/dma/dw-edma/dw-edma-v0-debugfs.h b/drivers/dma/dw-edma/dw-edma-v0-debugfs.h
> index d0ff25a9ea5c..eb11802c2b76 100644
> --- a/drivers/dma/dw-edma/dw-edma-v0-debugfs.h
> +++ b/drivers/dma/dw-edma/dw-edma-v0-debugfs.h
> @@ -13,15 +13,10 @@
>  
>  #ifdef CONFIG_DEBUG_FS
>  void dw_edma_v0_debugfs_on(struct dw_edma_chip *chip);
> -void dw_edma_v0_debugfs_off(struct dw_edma_chip *chip);
>  #else
>  static inline void dw_edma_v0_debugfs_on(struct dw_edma_chip *chip)
>  {
>  }
> -
> -static inline void dw_edma_v0_debugfs_off(struct dw_edma_chip *chip)
> -{
> -}
>  #endif /* CONFIG_DEBUG_FS */
>  
>  #endif /* _DW_EDMA_V0_DEBUG_FS_H */
> -- 
> 2.35.1
> 
