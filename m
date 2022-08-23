Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBFC59EA35
	for <lists+dmaengine@lfdr.de>; Tue, 23 Aug 2022 19:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbiHWRu4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 23 Aug 2022 13:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233020AbiHWRuW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 23 Aug 2022 13:50:22 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837DD8B9A2
        for <dmaengine@vger.kernel.org>; Tue, 23 Aug 2022 08:49:46 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 12so12633026pga.1
        for <dmaengine@vger.kernel.org>; Tue, 23 Aug 2022 08:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=FcfsgvbBsmH9TUBOdi8gI17L8X1FCriBL3m5xsMTOQI=;
        b=hZm3MbQZ25x4gyRnOBios4Vaili8ctas1HMsN6VYObN3KdqpPhJwTcmNSkN1S383dl
         QAE+lsWaX6+AwxrF6+f301zTibUCbQasMMs/UTBANMwWIWM4P4asUxUFQIgJ/X+IxRMm
         1ccxIjdKjgD3gWoagAutYJ57W8dzXhZeHTIwIYfEuJfuctbnE31Mz/trKwlPzeWQVC5j
         v8xWqZDA8JavKFxyPfyhvCT7NxFLt7K66WNsSdQe4GX92pO57jW9ESw8egisIjnRgvM0
         ULzumkXhsXL154kQrt4+HRlojRcLztolNMoRq4PAMKHlUCy0BUxF+0wRuu2TrY2eGzyS
         huDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=FcfsgvbBsmH9TUBOdi8gI17L8X1FCriBL3m5xsMTOQI=;
        b=fhEBJmyAlYvscS1va49Thnv72QgkcLZ21x13NPNGStE2o/lo6XPmAFsjblJXIz12M9
         cmYKhkmVlzTcUNmvTvuuNIeB2JRrd12MMyl5dLgY/Bdyaoxpp7m7N32hJ2JfbyA8+mTk
         7iboHW90pIxcTg8lMVVKRtxZl74gkznbU3vZIWMBapD0aDAlobN6k9UuGbBVqJgglqAS
         b5v+qlEeR4kCs/clakckvsDSpkTZHheb1CxGLf5FDTmoE98rt+0CIPj+cfplQALXQ8I8
         ERII3MFveBGs+SwniCPWSiGyXxiUrj/c/iQpTOLJk5VOIaSCPSbZ5dMGvwH0Ikgi6N+g
         PbRg==
X-Gm-Message-State: ACgBeo17gyuEBACF6IPtjIyUilKq8BbwbX6bK/BYoZj36Aiyn8smkvmY
        P9AoM9EbFWMxfRzAhv5hKB9B
X-Google-Smtp-Source: AA6agR6m6hKnC3K9kVAwg4TKgdoGu+fbE2po7J2tq/53lE85s6KAL6DbSDInUzNMr0eMOGY0E5cGJQ==
X-Received: by 2002:a62:e50a:0:b0:537:1eae:1268 with SMTP id n10-20020a62e50a000000b005371eae1268mr1071599pff.16.1661269785908;
        Tue, 23 Aug 2022 08:49:45 -0700 (PDT)
Received: from thinkpad ([220.158.159.146])
        by smtp.gmail.com with ESMTPSA id 128-20020a620686000000b0052e6c073a3csm11298599pfg.142.2022.08.23.08.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 08:49:45 -0700 (PDT)
Date:   Tue, 23 Aug 2022 21:19:37 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>, Frank Li <Frank.Li@nxp.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v5 24/24] PCI: dwc: Add DW eDMA engine support
Message-ID: <20220823154937.GC6371@thinkpad>
References: <20220822185332.26149-1-Sergey.Semin@baikalelectronics.ru>
 <20220822185332.26149-25-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220822185332.26149-25-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Aug 22, 2022 at 09:53:32PM +0300, Serge Semin wrote:
> Since the DW eDMA driver now supports eDMA controllers embedded into the
> locally accessible DW PCIe Root Ports and Endpoints, we can use the
> updated interface to register DW eDMA as DMA engine device if it's
> available. In order to successfully do that the DW PCIe core driver need
> to perform some preparations first. First of all it needs to find out the
> eDMA controller CSRs base address, whether they are accessible over the
> Port Logic or iATU unrolled space. Afterwards it can try to auto-detect
> the eDMA controller availability and number of it's read/write channels.
> If none was found the procedure will just silently halt with no error
> returned. Secondly the platform is supposed to provide either combined or
> per-channel IRQ signals. If no valid IRQs set is found the procedure will
> also halt with no error returned so to be backward compatible with the
> platforms where DW PCIe controllers have eDMA embedded but lack of the
> IRQs defined for them. Finally before actually probing the eDMA device we
> need to allocate LLP items buffers. After that the DW eDMA can be
> registered. If registration is successful the info-message regarding the
> number of detected Read/Write eDMA channels will be printed to the system
> log in the similar way as it's done for the iATU settings.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Acked-By: Vinod Koul <vkoul@kernel.org>
> 
> ---
> 
> Changelog v2:
> - Don't fail eDMA detection procedure if the DW eDMA driver couldn't probe
>   device. That happens if the driver is disabled. (@Manivannan)
> - Add "dma" registers resource mapping procedure. (@Manivannan)
> - Move the eDMA CSRs space detection into the dw_pcie_map_detect() method.
> - Remove eDMA on the dw_pcie_ep_init() internal errors. (@Manivannan)
> - Remove eDMA in the dw_pcie_ep_exit() method.
> - Move the dw_pcie_edma_detect() method execution to the tail of the
>   dw_pcie_ep_init() function.
> 
> Changelog v3:
> - Add more comprehensive and less regression prune eDMA block detection
>   procedure.
> - Remove Manivannan tb tag since the patch content has been changed.
> ---
>  .../pci/controller/dwc/pcie-designware-ep.c   |  12 +-
>  .../pci/controller/dwc/pcie-designware-host.c |  13 +-
>  drivers/pci/controller/dwc/pcie-designware.c  | 186 ++++++++++++++++++
>  drivers/pci/controller/dwc/pcie-designware.h  |  20 ++
>  4 files changed, 228 insertions(+), 3 deletions(-)
> 

[...]

> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 1e06ccf2dc9e..3dcbdaf980e4 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -12,6 +12,7 @@
>  #include <linux/bitops.h>
>  #include <linux/clk.h>
>  #include <linux/delay.h>
> +#include <linux/dma/edma.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/ioport.h>
>  #include <linux/of.h>
> @@ -142,6 +143,18 @@ int dw_pcie_get_resources(struct dw_pcie *pci)
>  	if (!pci->atu_size)
>  		pci->atu_size = SZ_4K;
>  
> +	/* eDMA region can be mapped to a custom base address */
> +	if (!pci->edma.reg_base) {
> +		res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dma");
> +		if (res) {
> +			pci->edma.reg_base = devm_ioremap_resource(pci->dev, res);
> +			if (IS_ERR(pci->edma.reg_base))
> +				return PTR_ERR(pci->edma.reg_base);
> +		} else if (pci->atu_size >= 2 * DEFAULT_DBI_DMA_OFFSET) {
> +			pci->edma.reg_base = pci->atu_base + DEFAULT_DBI_DMA_OFFSET;
> +		}
> +	}
> +
>  	/* LLDD is supposed to manually switch the clocks and resets state */
>  	if (dw_pcie_cap_is(pci, REQ_RES)) {
>  		ret = dw_pcie_get_clocks(pci);
> @@ -782,6 +795,179 @@ void dw_pcie_iatu_detect(struct dw_pcie *pci)
>  		 pci->region_align / SZ_1K, (pci->region_limit + 1) / SZ_1G);
>  }
>  
> +static u32 dw_pcie_readl_dma(struct dw_pcie *pci, u32 reg)
> +{
> +	u32 val = 0;
> +	int ret;
> +
> +	if (pci->ops && pci->ops->read_dbi)
> +		return pci->ops->read_dbi(pci, pci->edma.reg_base, reg, 4);
> +
> +	ret = dw_pcie_read(pci->edma.reg_base + reg, 4, &val);
> +	if (ret)
> +		dev_err(pci->dev, "Read DMA address failed\n");
> +
> +	return val;
> +}
> +
> +static int dw_pcie_edma_irq_vector(struct device *dev, unsigned int nr)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	char name[6];
> +	int ret;
> +
> +	if (nr >= EDMA_MAX_WR_CH + EDMA_MAX_RD_CH)
> +		return -EINVAL;
> +
> +	ret = platform_get_irq_byname_optional(pdev, "dma");
> +	if (ret > 0)
> +		return ret;
> +
> +	snprintf(name, sizeof(name), "dma%u", nr);
> +
> +	return platform_get_irq_byname_optional(pdev, name);
> +}
> +
> +static struct dw_edma_core_ops dw_pcie_edma_ops = {
> +	.irq_vector = dw_pcie_edma_irq_vector,
> +};
> +
> +static int dw_pcie_edma_find_chip(struct dw_pcie *pci)
> +{
> +	u32 val;
> +
> +	val = dw_pcie_readl_dbi(pci, PCIE_DMA_VIEWPORT_BASE + PCIE_DMA_CTRL);
> +	if (val == 0xFFFFFFFF && pci->edma.reg_base) {

Nit: Lower case for hex here and below?

Thanks,
Mani

> +		pci->edma.mf = EDMA_MF_EDMA_UNROLL;
> +
> +		val = dw_pcie_readl_dma(pci, PCIE_DMA_CTRL);
> +	} else if (val != 0xFFFFFFFF) {
> +		pci->edma.mf = EDMA_MF_EDMA_LEGACY;
> +
> +		pci->edma.reg_base = pci->dbi_base + PCIE_DMA_VIEWPORT_BASE;
> +	} else {
> +		return -ENODEV;
> +	}
> +
> +	pci->edma.dev = pci->dev;
> +
> +	if (!pci->edma.ops)
> +		pci->edma.ops = &dw_pcie_edma_ops;
> +
> +	pci->edma.flags |= DW_EDMA_CHIP_LOCAL;
> +
> +	pci->edma.ll_wr_cnt = FIELD_GET(PCIE_DMA_NUM_WR_CHAN, val);
> +	pci->edma.ll_rd_cnt = FIELD_GET(PCIE_DMA_NUM_RD_CHAN, val);
> +
> +	/* Sanity check the channels count if the mapping was incorrect */
> +	if (!pci->edma.ll_wr_cnt || pci->edma.ll_wr_cnt > EDMA_MAX_WR_CH ||
> +	    !pci->edma.ll_rd_cnt || pci->edma.ll_rd_cnt > EDMA_MAX_RD_CH)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static int dw_pcie_edma_irq_verify(struct dw_pcie *pci)
> +{
> +	struct platform_device *pdev = to_platform_device(pci->dev);
> +	u16 ch_cnt = pci->edma.ll_wr_cnt + pci->edma.ll_rd_cnt;
> +	char name[6];
> +	int ret;
> +
> +	if (pci->edma.nr_irqs == 1)
> +		return 0;
> +	else if (pci->edma.nr_irqs > 1)
> +		return pci->edma.nr_irqs != ch_cnt ? -EINVAL : 0;
> +
> +	ret = platform_get_irq_byname_optional(pdev, "dma");
> +	if (ret > 0) {
> +		pci->edma.nr_irqs = 1;
> +		return 0;
> +	}
> +
> +	for (; pci->edma.nr_irqs < ch_cnt; pci->edma.nr_irqs++) {
> +		snprintf(name, sizeof(name), "dma%d", pci->edma.nr_irqs);
> +
> +		ret = platform_get_irq_byname_optional(pdev, name);
> +		if (ret <= 0)
> +			return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int dw_pcie_edma_ll_alloc(struct dw_pcie *pci)
> +{
> +	struct dw_edma_region *ll;
> +	dma_addr_t paddr;
> +	int i;
> +
> +	for (i = 0; i < pci->edma.ll_wr_cnt; i++) {
> +		ll = &pci->edma.ll_region_wr[i];
> +		ll->sz = DMA_LLP_MEM_SIZE;
> +		ll->vaddr = dmam_alloc_coherent(pci->dev, ll->sz,
> +						&paddr, GFP_KERNEL);
> +		if (!ll->vaddr)
> +			return -ENOMEM;
> +
> +		ll->paddr = paddr;
> +	}
> +
> +	for (i = 0; i < pci->edma.ll_rd_cnt; i++) {
> +		ll = &pci->edma.ll_region_rd[i];
> +		ll->sz = DMA_LLP_MEM_SIZE;
> +		ll->vaddr = dmam_alloc_coherent(pci->dev, ll->sz,
> +						&paddr, GFP_KERNEL);
> +		if (!ll->vaddr)
> +			return -ENOMEM;
> +
> +		ll->paddr = paddr;
> +	}
> +
> +	return 0;
> +}
> +
> +int dw_pcie_edma_detect(struct dw_pcie *pci)
> +{
> +	int ret;
> +
> +	/* Don't fail if no eDMA was found (for the backward compatibility) */
> +	ret = dw_pcie_edma_find_chip(pci);
> +	if (ret)
> +		return 0;
> +
> +	/* Don't fail on the IRQs verification (for the backward compatibility) */
> +	ret = dw_pcie_edma_irq_verify(pci);
> +	if (ret) {
> +		dev_err(pci->dev, "Invalid eDMA IRQs found\n");
> +		return 0;
> +	}
> +
> +	ret = dw_pcie_edma_ll_alloc(pci);
> +	if (ret) {
> +		dev_err(pci->dev, "Couldn't allocate LLP memory\n");
> +		return ret;
> +	}
> +
> +	/* Don't fail if the DW eDMA driver can't find the device */
> +	ret = dw_edma_probe(&pci->edma);
> +	if (ret && ret != -ENODEV) {
> +		dev_err(pci->dev, "Couldn't register eDMA device\n");
> +		return ret;
> +	}
> +
> +	dev_info(pci->dev, "eDMA: unroll %s, %hu wr, %hu rd\n",
> +		 pci->edma.mf == EDMA_MF_EDMA_UNROLL ? "T" : "F",
> +		 pci->edma.ll_wr_cnt, pci->edma.ll_rd_cnt);
> +
> +	return 0;
> +}
> +
> +void dw_pcie_edma_remove(struct dw_pcie *pci)
> +{
> +	dw_edma_remove(&pci->edma);
> +}
> +
>  void dw_pcie_setup(struct dw_pcie *pci)
>  {
>  	u32 val;
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index f5530069a204..d11c246b9bc1 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -15,6 +15,7 @@
>  #include <linux/bitops.h>
>  #include <linux/clk.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/dma/edma.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/irq.h>
>  #include <linux/msi.h>
> @@ -167,6 +168,18 @@
>  #define PCIE_MSIX_DOORBELL		0x948
>  #define PCIE_MSIX_DOORBELL_PF_SHIFT	24
>  
> +/*
> + * eDMA CSRs. DW PCIe IP-core v4.70a and older had the eDMA registers accessible
> + * over the Port Logic registers space. Afterwords the unrolled mapping was
> + * introduced so eDMA and iATU could be accessed via a dedicated registers
> + * space.
> + */
> +#define PCIE_DMA_VIEWPORT_BASE		0x970
> +#define PCIE_DMA_UNROLL_BASE		0x80000
> +#define PCIE_DMA_CTRL			0x008
> +#define PCIE_DMA_NUM_WR_CHAN		GENMASK(3, 0)
> +#define PCIE_DMA_NUM_RD_CHAN		GENMASK(19, 16)
> +
>  #define PCIE_PL_CHK_REG_CONTROL_STATUS			0xB20
>  #define PCIE_PL_CHK_REG_CHK_REG_START			BIT(0)
>  #define PCIE_PL_CHK_REG_CHK_REG_CONTINUOUS		BIT(1)
> @@ -215,6 +228,7 @@
>   * this offset, if atu_base not set.
>   */
>  #define DEFAULT_DBI_ATU_OFFSET (0x3 << 20)
> +#define DEFAULT_DBI_DMA_OFFSET PCIE_DMA_UNROLL_BASE
>  
>  #define MAX_MSI_IRQS			256
>  #define MAX_MSI_IRQS_PER_CTRL		32
> @@ -226,6 +240,9 @@
>  #define MAX_IATU_IN			256
>  #define MAX_IATU_OUT			256
>  
> +/* Default eDMA LLP memory size */
> +#define DMA_LLP_MEM_SIZE		PAGE_SIZE
> +
>  struct dw_pcie;
>  struct dw_pcie_rp;
>  struct dw_pcie_ep;
> @@ -370,6 +387,7 @@ struct dw_pcie {
>  	int			num_lanes;
>  	int			link_gen;
>  	u8			n_fts[2];
> +	struct dw_edma_chip	edma;
>  	struct clk_bulk_data	app_clks[DW_PCIE_NUM_APP_CLKS];
>  	struct clk_bulk_data	core_clks[DW_PCIE_NUM_CORE_CLKS];
>  	struct reset_control_bulk_data	app_rsts[DW_PCIE_NUM_APP_RSTS];
> @@ -409,6 +427,8 @@ int dw_pcie_prog_ep_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
>  void dw_pcie_disable_atu(struct dw_pcie *pci, u32 dir, int index);
>  void dw_pcie_setup(struct dw_pcie *pci);
>  void dw_pcie_iatu_detect(struct dw_pcie *pci);
> +int dw_pcie_edma_detect(struct dw_pcie *pci);
> +void dw_pcie_edma_remove(struct dw_pcie *pci);
>  
>  static inline void dw_pcie_writel_dbi(struct dw_pcie *pci, u32 reg, u32 val)
>  {
> -- 
> 2.35.1
> 

-- 
மணிவண்ணன் சதாசிவம்
