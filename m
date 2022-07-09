Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B9956C81B
	for <lists+dmaengine@lfdr.de>; Sat,  9 Jul 2022 10:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbiGIIg4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 9 Jul 2022 04:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiGIIgz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 9 Jul 2022 04:36:55 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07FA66BB2
        for <dmaengine@vger.kernel.org>; Sat,  9 Jul 2022 01:36:52 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id i8-20020a17090a4b8800b001ef8a65bfbdso675331pjh.1
        for <dmaengine@vger.kernel.org>; Sat, 09 Jul 2022 01:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=e0T4MJLh47jhAG2CBCn92vzuo5cDFqWdwPEwdraHZnw=;
        b=uomeHa0k+7xdHE+l4zkpmTAQbXVtTHb94HGMUoztYbTnheLVbTVzqOF1K0jbnUCosF
         ZVQRPml9tYIGqjp/hratH/dpSstSASeI7Kr4+F53BOuyMY3eH9fpQ7oMz5k0lFL6UUvU
         TSWKnme5YqojN9lsFdRfguDRifNhCRLnSOhxcMTlXCmhpt2FxfuWgF+vdGSJa/YPiErT
         E+LX3f7In6DOtPTbt4Y2Sv1nrOMgN30jq7j4F40z6ARKbxySyqR+33QNyO9dgR2xdM+R
         sZgvhkDKJLt9/Ixj3VzRWAMdTDTVFbCYa1acKEFJPMk3hG9iF8JKY5MuODfyV6qE/m/w
         VEcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=e0T4MJLh47jhAG2CBCn92vzuo5cDFqWdwPEwdraHZnw=;
        b=f8dCW+AkX4ONStBZb+7OmYtSQLWyTQYCUkHxvXQkxQvNqdLqf6/0LNTo8SU0PtmvcA
         KqCmZlgcSEP++LnwHooATrUDOdht/XIPBwznQWoH0yOuROuj5tXePMAlzDI2Ly0Mc2ly
         c+lCgD34jdlwIjLGMk/32l3KEEYQYHraSRik3BytqaFsKMwAMw8AZ8I2SGGLdB4LCcS/
         H4prw9XfLUyIHyT1JgqNc0ETs9TdG92mgyqngcDlKJu5ggGDsnA3CHdAnDbV7xM7TXCj
         Wo+INBEPIxMQnk/K/ueJ52ZfkEsFGyW229CbTjjoB/hoCW3v2v6IMglBrYQR6m0K1IsW
         TXyg==
X-Gm-Message-State: AJIora/8DL1gLXcGnMvNrnA567jOTlMuPJFSLjqk3GhVuj7k4Hnz6Mwi
        nB7dakFNw3f+nevIxG0R0DwE
X-Google-Smtp-Source: AGRyM1t+69aJUd+6vugsHPrd5ObmWdFnMtkTBMNwZuXd1lC/n0XuptUfH9HxD8hgz2ejbHAFeAsqdw==
X-Received: by 2002:a17:902:ecc8:b0:16b:96b0:40b3 with SMTP id a8-20020a170902ecc800b0016b96b040b3mr7633304plh.65.1657355812090;
        Sat, 09 Jul 2022 01:36:52 -0700 (PDT)
Received: from thinkpad ([117.207.26.140])
        by smtp.gmail.com with ESMTPSA id q8-20020a170902eb8800b0016a7d9e6548sm790458plg.262.2022.07.09.01.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jul 2022 01:36:51 -0700 (PDT)
Date:   Sat, 9 Jul 2022 14:06:42 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>, Frank Li <Frank.Li@nxp.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 24/24] PCI: dwc: Add DW eDMA engine support
Message-ID: <20220709083642.GR5063@thinkpad>
References: <20220610091459.17612-1-Sergey.Semin@baikalelectronics.ru>
 <20220610091459.17612-25-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220610091459.17612-25-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Jun 10, 2022 at 12:14:59PM +0300, Serge Semin wrote:
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

Eventhough I didn't test this patch, it looks good to me as my previous
comments were addressed.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

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
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index dd7ec1eb7520..2a6f8382bc1b 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -604,8 +604,11 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
>  
>  void dw_pcie_ep_exit(struct dw_pcie_ep *ep)
>  {
> +	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  	struct pci_epc *epc = ep->epc;
>  
> +	dw_pcie_edma_remove(pci);
> +
>  	pci_epc_mem_free_addr(epc, ep->msi_mem_phys, ep->msi_mem,
>  			      epc->mem->window.page_size);
>  
> @@ -763,6 +766,10 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  		goto err_exit_epc_mem;
>  	}
>  
> +	ret = dw_pcie_edma_detect(pci);
> +	if (ret)
> +		goto err_free_epc_mem;
> +
>  	if (ep->ops->get_features) {
>  		epc_features = ep->ops->get_features(ep);
>  		if (epc_features->core_init_notifier)
> @@ -771,10 +778,13 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  
>  	ret = dw_pcie_ep_init_complete(ep);
>  	if (ret)
> -		goto err_free_epc_mem;
> +		goto err_remove_edma;
>  
>  	return 0;
>  
> +err_remove_edma:
> +	dw_pcie_edma_remove(pci);
> +
>  err_free_epc_mem:
>  	pci_epc_mem_free_addr(epc, ep->msi_mem_phys, ep->msi_mem,
>  			      epc->mem->window.page_size);
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index c941ea95badf..d46d303084ec 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -404,14 +404,18 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  
>  	dw_pcie_iatu_detect(pci);
>  
> -	ret = dw_pcie_setup_rc(pp);
> +	ret = dw_pcie_edma_detect(pci);
>  	if (ret)
>  		goto err_free_msi;
>  
> +	ret = dw_pcie_setup_rc(pp);
> +	if (ret)
> +		goto err_remove_edma;
> +
>  	if (!dw_pcie_link_up(pci)) {
>  		ret = dw_pcie_start_link(pci);
>  		if (ret)
> -			goto err_free_msi;
> +			goto err_remove_edma;
>  	}
>  
>  	/* Ignore errors, the link may come up later */
> @@ -428,6 +432,9 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  err_stop_link:
>  	dw_pcie_stop_link(pci);
>  
> +err_remove_edma:
> +	dw_pcie_edma_remove(pci);
> +
>  err_free_msi:
>  	if (pp->has_msi_ctrl)
>  		dw_pcie_free_msi(pp);
> @@ -449,6 +456,8 @@ void dw_pcie_host_deinit(struct dw_pcie_rp *pp)
>  
>  	dw_pcie_stop_link(pci);
>  
> +	dw_pcie_edma_remove(pci);
> +
>  	if (pp->has_msi_ctrl)
>  		dw_pcie_free_msi(pp);
>  
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index fd43514a00bb..e04128a22bbe 100644
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
> @@ -142,6 +143,18 @@ int dw_pcie_get_res(struct dw_pcie *pci)
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
> @@ -785,6 +798,179 @@ void dw_pcie_iatu_detect(struct dw_pcie *pci)
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
> index 779fbf147d9b..442bba41cd8a 100644
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
> @@ -160,6 +161,18 @@
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
> @@ -176,6 +189,7 @@
>   * this offset, if atu_base not set.
>   */
>  #define DEFAULT_DBI_ATU_OFFSET (0x3 << 20)
> +#define DEFAULT_DBI_DMA_OFFSET PCIE_DMA_UNROLL_BASE
>  
>  #define MAX_MSI_IRQS			256
>  #define MAX_MSI_IRQS_PER_CTRL		32
> @@ -187,6 +201,9 @@
>  #define MAX_IATU_IN			256
>  #define MAX_IATU_OUT			256
>  
> +/* Default eDMA LLP memory size */
> +#define DMA_LLP_MEM_SIZE		PAGE_SIZE
> +
>  struct dw_pcie;
>  struct dw_pcie_rp;
>  struct dw_pcie_ep;
> @@ -331,6 +348,7 @@ struct dw_pcie {
>  	int			num_lanes;
>  	int			link_gen;
>  	u8			n_fts[2];
> +	struct dw_edma_chip	edma;
>  	struct clk_bulk_data	app_clks[DW_PCIE_NUM_APP_CLKS];
>  	struct clk_bulk_data	core_clks[DW_PCIE_NUM_CORE_CLKS];
>  	struct reset_control_bulk_data	app_rsts[DW_PCIE_NUM_APP_RSTS];
> @@ -370,6 +388,8 @@ int dw_pcie_prog_ep_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
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
