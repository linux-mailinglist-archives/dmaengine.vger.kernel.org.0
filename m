Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0BA6E13FF
	for <lists+dmaengine@lfdr.de>; Thu, 13 Apr 2023 20:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjDMSXE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 13 Apr 2023 14:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjDMSXD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 13 Apr 2023 14:23:03 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61BB9CA
        for <dmaengine@vger.kernel.org>; Thu, 13 Apr 2023 11:23:02 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id d22-20020a17090a111600b0023d1b009f52so19080640pja.2
        for <dmaengine@vger.kernel.org>; Thu, 13 Apr 2023 11:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681410182; x=1684002182;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OZj7tX+onZ/w5nFTENrEQRRNbI5goS/EOTtR1AnrQuk=;
        b=IvpeFWDPyAYXw5U9oh9b5vu7vcniXgjJddv7WuZKVPBhIU/UmNtY0Pcp0PAU6cHhlT
         W+F4P0pEgsiO9HO13LoBEThwGSODTeJaIcBlztIzFjcGG2dgeGd3wg1E8RmdYCqqjWGu
         0bMTQNX8zsGvGSMtcEiJ7YVwHumxFQJsfSPwdJOOgTVbkQp6RvFoMUZSnBL/Af+q0mcm
         WWc58j/b0kHk3pwxzFpQUwopFHi2sYCvSyHpWeweHDCAzX7J5rQ2rHiAsUeFDfCgkUWY
         pPGnNcqAe56trAnIbfXY/cBcgl1ICBViGAHNvQFATNmeuJk76uv7UyLty9L7uwkiCjMD
         objw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681410182; x=1684002182;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OZj7tX+onZ/w5nFTENrEQRRNbI5goS/EOTtR1AnrQuk=;
        b=bLz4ODbZDE4zVpuG6qRWpyT+73lVL2y99gAkqa6EcLhyuOVzZJ7e2PpqL6m5frmvdp
         cY3toqRx5xko6pUg71R5J2DxKnPIHHMgOrl5HlmSiW3ETcg7a5Ydy8BtrMz5NEwEbfiG
         OX8Yn+k3e7nHpwo/4CJUgKLEwwT7IRzBmrmD0B1Ujfi66uBMpf/kLorItOT1IrTc8VYl
         rIcoTFIDP3SF+DsDg/4v8NQW74oFUz992hzJ+BDO4xIKD3Bi7wNFJTb01AK7KYSF88N2
         WTZ5nJa8UMhN4vYuQQjfSXa4FBfSDI/74+uBFj2enccqaaDVBJ+MvUoaZeTtGdRAK81L
         L9IA==
X-Gm-Message-State: AAQBX9ctsPts5tTyEGHg3PjC4zF5SIx/kZNIaCNM/PAF9RUszH2CKMR+
        JVoviq/SNozT9zQ+5OlnXNX5
X-Google-Smtp-Source: AKy350bDgqFxFtDm/UYrBjWPXPFIoSejizDZ+SCphLAKf+eInascLk6MVjodPl8Pk7sr9Mn/UIWw6Q==
X-Received: by 2002:a17:903:22d0:b0:19e:b2ed:6fff with SMTP id y16-20020a17090322d000b0019eb2ed6fffmr3195821plg.31.1681410181764;
        Thu, 13 Apr 2023 11:23:01 -0700 (PDT)
Received: from thinkpad ([59.97.52.67])
        by smtp.gmail.com with ESMTPSA id 20-20020a170902ee5400b001a19bac463fsm1783106plo.42.2023.04.13.11.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 11:23:01 -0700 (PDT)
Date:   Thu, 13 Apr 2023 23:52:54 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Cai Huoqing <cai.huoqing@linux.dev>
Cc:     fancer.lancer@gmail.com,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH RESEND v9 1/4] dmaengine: dw-edma: Rename
 dw_edma_core_ops structure to dw_edma_plat_ops
Message-ID: <20230413182254.GC13020@thinkpad>
References: <20230413033156.93751-1-cai.huoqing@linux.dev>
 <20230413033156.93751-2-cai.huoqing@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230413033156.93751-2-cai.huoqing@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Apr 13, 2023 at 11:31:52AM +0800, Cai Huoqing wrote:
> From: Cai huoqing <cai.huoqing@linux.dev>
> 
> The dw_edma_core_ops structure contains a set of the operations:
> device IRQ numbers getter, CPU/PCI address translation. Based on the
> functions semantics the structure name "dw_edma_plat_ops" looks more
> descriptive since indeed the operations are platform-specific. The
> "dw_edma_core_ops" name shall be used for a structure with the IP-core
> specific set of callbacks in order to abstract out DW eDMA and DW HDMA
> setups. Such structure will be added in one of the next commit in the
> framework of the set of changes adding the DW HDMA device support.
> 
> Anyway the renaming was necessary to distinguish two types of
> the implementation callbacks:
> 1. DW eDMA/hDMA IP-core specific operations: device-specific CSR
> setups in one or another aspect of the DMA-engine initialization.
> 2. DW eDMA/hDMA platform specific operations: the DMA device
> environment configs like IRQs, address translation, etc.
> 
> Signed-off-by: Cai huoqing <cai.huoqing@linux.dev>
> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
> v8->v9: No change
> 
> v8 link:
>   https://lore.kernel.org/lkml/20230323034944.78357-2-cai.huoqing@linux.dev/
> 
>  drivers/dma/dw-edma/dw-edma-pcie.c           | 4 ++--
>  drivers/pci/controller/dwc/pcie-designware.c | 2 +-
>  include/linux/dma/edma.h                     | 4 ++--
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> index 2b40f2b44f5e..1c6043751dc9 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> @@ -109,7 +109,7 @@ static u64 dw_edma_pcie_address(struct device *dev, phys_addr_t cpu_addr)
>  	return region.start;
>  }
>  
> -static const struct dw_edma_core_ops dw_edma_pcie_core_ops = {
> +static const struct dw_edma_plat_ops dw_edma_pcie_plat_ops = {
>  	.irq_vector = dw_edma_pcie_irq_vector,
>  	.pci_address = dw_edma_pcie_address,
>  };
> @@ -225,7 +225,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  
>  	chip->mf = vsec_data.mf;
>  	chip->nr_irqs = nr_irqs;
> -	chip->ops = &dw_edma_pcie_core_ops;
> +	chip->ops = &dw_edma_pcie_plat_ops;
>  
>  	chip->ll_wr_cnt = vsec_data.wr_ch_cnt;
>  	chip->ll_rd_cnt = vsec_data.rd_ch_cnt;
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 8e33e6e59e68..1f2ee71da4da 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -828,7 +828,7 @@ static int dw_pcie_edma_irq_vector(struct device *dev, unsigned int nr)
>  	return platform_get_irq_byname_optional(pdev, name);
>  }
>  
> -static struct dw_edma_core_ops dw_pcie_edma_ops = {
> +static struct dw_edma_plat_ops dw_pcie_edma_ops = {
>  	.irq_vector = dw_pcie_edma_irq_vector,
>  };
>  
> diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> index d2638d9259dc..ed401c965a87 100644
> --- a/include/linux/dma/edma.h
> +++ b/include/linux/dma/edma.h
> @@ -40,7 +40,7 @@ struct dw_edma_region {
>   *			iATU windows. That will be done by the controller
>   *			automatically.
>   */
> -struct dw_edma_core_ops {
> +struct dw_edma_plat_ops {
>  	int (*irq_vector)(struct device *dev, unsigned int nr);
>  	u64 (*pci_address)(struct device *dev, phys_addr_t cpu_addr);
>  };
> @@ -80,7 +80,7 @@ enum dw_edma_chip_flags {
>  struct dw_edma_chip {
>  	struct device		*dev;
>  	int			nr_irqs;
> -	const struct dw_edma_core_ops   *ops;
> +	const struct dw_edma_plat_ops	*ops;
>  	u32			flags;
>  
>  	void __iomem		*reg_base;
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்
