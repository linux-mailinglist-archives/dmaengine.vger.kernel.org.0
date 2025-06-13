Return-Path: <dmaengine+bounces-5457-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB16AD94CA
	for <lists+dmaengine@lfdr.de>; Fri, 13 Jun 2025 20:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1010E1E49FA
	for <lists+dmaengine@lfdr.de>; Fri, 13 Jun 2025 18:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9267C22F74E;
	Fri, 13 Jun 2025 18:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WhGe6Fxi"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9853D1A254C;
	Fri, 13 Jun 2025 18:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749840689; cv=none; b=CDL50gYAa/pKdqo8+2/LOSYxPpFOcobZcqVx2PXGGvVT624rQiYsZGHeJKEtn98cwq+oO6xbIcdMa+ooQ7OwhJW3tFvQHCrPU/8OqFWHO+Tp+4J60kvRS8htODuo6vpDQRa2hcubrxIOW9OUKn9y3T0hxFcT/OtHAEsjpfQC5cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749840689; c=relaxed/simple;
	bh=z33FYu9xpQR91mz28Ot9Lsn4vMCPOY75basP6xozkFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Th5+pBwjbPqwhrx4djWmZkfKMQ/ygsSnkPGyyUXl1Rax5YFphVIdPU9spp5fkPflT2kpT1X2AGlzTYyC+IutxrQsz20ML3zYOxJ4n2IFuSXvzNOnYrY+jk2fmICIA/LhlI5kPOo3CMAgQcTVzIeh5rOrYO2bk8v8gb/IkaSkhpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WhGe6Fxi; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ade48b24c97so364872066b.2;
        Fri, 13 Jun 2025 11:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749840686; x=1750445486; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JSRxValwcmkk+jvT8gtFqyK3rDsLmQ1dL3e3fNgDB+I=;
        b=WhGe6Fximn/UE8km1XTkPLRUgi8LoTphUMyQtL9GeeFJnuPlg1kLFgk7Ncp66jcqu3
         jCl5YGTzZ2ocX1LZM/32o6jrkXRoXYjrwuntaH55P2thX2K6fQeG88fO8fDA3vfh/aCz
         YywN391ZNPRzv8WxhUmrFtsBFrHxMz6BZr0cuq2YP7jF1DAj7sq8G0x/SRDKbgN9xW2d
         8Gvyj7s2Y7upJS3rfvKetSIeo3Hpk/lf9LnhD7rQZp01gDHtcHDepM5FVLqPJORCpsMd
         +kybLqp464svnKtHbP4XCpctmCb9uEqGNc0T0BRggN+penec3U1zH/9gN2N8Guu2Punp
         7DOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749840686; x=1750445486;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JSRxValwcmkk+jvT8gtFqyK3rDsLmQ1dL3e3fNgDB+I=;
        b=X+FVB3YwsYy66xzLS2xc9m5iLdtNB75T7F5uWJ8EaALgFsrYY3KkoKVUTfvrvyOyIs
         3lr6D8J46KRhLNCCGG8IvHzSCGHQ4iYjHvXKCnMk9umE7Z/jlHsv8cwLgtawbZks+rSO
         TmmLwuafZ8Zjsue5ZLj7igLI4Yss90+xYvz29AOd96B+4yAMu79gaReYGPHaeBxGk2IQ
         4hGkFlMfvFQaSVHMtLIhQeFGp+3xWVQzrghVtseTyITjrz9jWLWfOku8YSJ710RGXyNQ
         0uYyR20nAaFYljSLqFrvUz0HNowWNzq+Kxwb2MHkN2mXyBJV2++mZp+DGwZACxE2FmNd
         7Krw==
X-Forwarded-Encrypted: i=1; AJvYcCUtLqB6sjPs2Wqdv6AlZ7Cs29Mklz1FXsXDEe+YcPkpI8Psy+u89yVWFwu47J5YM34aTttorl739EGrBoaG@vger.kernel.org, AJvYcCXJ2XeS1u+DPhaAHZKMrh2EKBtLK1ah0/THQpbF1vzl3g01fyXVO61v3LFcQXmYhPQ+gqdd/XsjRE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzttraOtDLkDpD0qL3Xxm4b638KdnQjthdG5v1J/lENrcr0+sPc
	m2o96eJ27kDVBqBNzTBHPupPZcOkptdkHlRdRVnNPpIQRheUfrJA0ltP44yMe7wFbrtDetndvuT
	gEzXOslvI5+tG4/4sZtuAJOkeUeEzJVA=
X-Gm-Gg: ASbGncviEtYMO8CtR4MZp/xUiDK9tfQewxOONNnFdXv65QwAU1weKJ8kJQUL72f5CLM
	mlvWOwcJneULv2LFrmLsjfZI6O/29uXXPI7hAdjcRHU4U//yG99XWeCxxfFrJND/ti1vZGpnf76
	bZBQag3Qp2RYUABIZfOViUj2ujxxHxVOSILIpPwzoUaQ==
X-Google-Smtp-Source: AGHT+IEnTw18i3vfnI0CJk3MDKIj5ydGBKKQQghUhrAvgODgZu02EiwLas1fNGjBXvj9+G9KC9JQEosJjVG83PcvjNw=
X-Received: by 2002:a17:907:97ce:b0:ade:9b52:4cc2 with SMTP id
 a640c23a62f3a-adfad4b7e61mr24182966b.59.1749840685299; Fri, 13 Jun 2025
 11:51:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250613143605.5748-1-al.kochet@gmail.com> <20250613143605.5748-2-al.kochet@gmail.com>
 <aExS9WB0Ussl4Lec@smile.fi.intel.com>
In-Reply-To: <aExS9WB0Ussl4Lec@smile.fi.intel.com>
From: Alexander Kochetkov <al.kochet@gmail.com>
Date: Fri, 13 Jun 2025 21:51:14 +0300
X-Gm-Features: AX0GCFtCk7v9OD9f3sQF1fL8ctIXm0GIREAbZAwkzKzRDhdNPbUrzKoQgjba-ko
Message-ID: <CAPUzuU1r2xmJyG_Ke8pAvoZjJdvFwnxUqv1XQH7PrW3e3PTZoQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] dmaengine: virt-dma: convert tasklet to BH workqueue
 for callback invocation
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Nishad Saraf <nishads@amd.com>, 
	Lizhi Hou <lizhi.hou@amd.com>, Jacky Huang <ychuang3@nuvoton.com>, 
	Shan-Chun Hung <schung@nuvoton.com>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Paul Cercueil <paul@crapouillou.net>, 
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Manivannan Sadhasivam <mani@kernel.org>, 
	Frank Li <Frank.Li@nxp.com>, Zhou Wang <wangzhou1@hisilicon.com>, 
	Longfang Liu <liulongfang@huawei.com>, Andy Shevchenko <andy@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Keguang Zhang <keguang.zhang@gmail.com>, Sean Wang <sean.wang@mediatek.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	=?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, 
	Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, 
	Robert Jarzmik <robert.jarzmik@free.fr>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Samuel Holland <samuel.holland@sifive.com>, Orson Zhai <orsonzhai@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>, 
	Patrice Chotard <patrice.chotard@foss.st.com>, 
	=?UTF-8?Q?Am=C3=A9lie_Delaunay?= <amelie.delaunay@foss.st.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Laxman Dewangan <ldewangan@nvidia.com>, Jon Hunter <jonathanh@nvidia.com>, 
	Thierry Reding <thierry.reding@gmail.com>, Peter Ujfalusi <peter.ujfalusi@gmail.com>, 
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Dave Jiang <dave.jiang@intel.com>, Amit Vadhavana <av2082000@gmail.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Md Sadre Alam <quic_mdalam@quicinc.com>, 
	Casey Connolly <casey.connolly@linaro.org>, Kees Cook <kees@kernel.org>, 
	Fenghua Yu <fenghua.yu@intel.com>, Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

>
> It seems it was ordered. Please, preserve the order.
> It not, try to squeeze to have longest possible ordered chain
> (it can be interleaved with something unordered, just look at
>  the big picture).
>
> (Same applies to other similar cases)

I'll this that in v2. Thanks!

> ...
>
> What about the driver(s) that use threaded IRQ instead?
> Do you plan to convert them as well?
>
> I am talking about current users of virt-dma that do not use tasklets.
>
> --
> With Best Regards,
> Andy Shevchenko
>

I think, I've found all the users of virt-dma. Could you, please,
provide example of such driver?
Here is what I did to locate current users of virt-dma.

I got list of drivers using following command:
grep -r -e 'struct virt_dma_chan' -e 'virt-dma.h' . | sort | cut -f 1
-d : | uniq

./drivers/dma/amba-pl08x.c
./drivers/dma/amd/ae4dma/ae4dma.h
./drivers/dma/amd/ptdma/ptdma.h
./drivers/dma/amd/qdma/qdma.c
./drivers/dma/amd/qdma/qdma.h
./drivers/dma/arm-dma350.c
./drivers/dma/at_hdmac.c
./drivers/dma/bcm2835-dma.c
./drivers/dma/dma-axi-dmac.c
./drivers/dma/dma-jz4780.c
./drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
./drivers/dma/dw-axi-dmac/dw-axi-dmac.h
./drivers/dma/dw-edma/dw-edma-core.c
./drivers/dma/dw-edma/dw-edma-core.h
./drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c
./drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.h
./drivers/dma/fsl-edma-common.h
./drivers/dma/fsl-qdma.c
./drivers/dma/hisi_dma.c
./drivers/dma/hsu/hsu.h
./drivers/dma/idma64.h
./drivers/dma/img-mdc-dma.c
./drivers/dma/imx-sdma.c
./drivers/dma/k3dma.c
./drivers/dma/lgm/lgm-dma.c
./drivers/dma/loongson1-apb-dma.c
./drivers/dma/loongson2-apb-dma.c
./drivers/dma/mediatek/mtk-cqdma.c
./drivers/dma/mediatek/mtk-hsdma.c
./drivers/dma/mediatek/mtk-uart-apdma.c
./drivers/dma/milbeaut-hdmac.c
./drivers/dma/milbeaut-xdmac.c
./drivers/dma/moxart-dma.c
./drivers/dma/owl-dma.c
./drivers/dma/pxa_dma.c
./drivers/dma/qcom/bam_dma.c
./drivers/dma/qcom/gpi.c
./drivers/dma/qcom/qcom_adm.c
./drivers/dma/sa11x0-dma.c
./drivers/dma/sf-pdma/sf-pdma.c
./drivers/dma/sf-pdma/sf-pdma.h
./drivers/dma/sh/rz-dmac.c
./drivers/dma/sh/usb-dmac.c
./drivers/dma/sprd-dma.c
./drivers/dma/st_fdma.h
./drivers/dma/stm32/stm32-dma.c
./drivers/dma/stm32/stm32-dma3.c
./drivers/dma/stm32/stm32-mdma.c
./drivers/dma/sun4i-dma.c
./drivers/dma/sun6i-dma.c
./drivers/dma/tegra186-gpc-dma.c
./drivers/dma/tegra210-adma.c
./drivers/dma/ti/edma.c
./drivers/dma/ti/k3-udma.c
./drivers/dma/ti/omap-dma.c
./drivers/dma/uniphier-mdmac.c
./drivers/dma/uniphier-xdmac.c
./drivers/dma/virt-dma.c
./drivers/dma/virt-dma.h
./drivers/dma/xilinx/xdma.c
./drivers/dma/xilinx/xilinx_dpdma.c

After that I did following to find additional drivers, and found them
inside misc.
grep -r -e ae4dma.h -e ptdma.h -e qdma.h -e dw-axi-dmac.h -e
dw-edma-core.h -e dpaa2-qdma.h -e fsl-edma-common.h -e hsu.h -e
idma64.h -e sf-pdma.h -e st_fdma.h  . | sort | cut -f 1 -d : | uniq

./drivers/dma/amd/ae4dma/ae4dma-dev.c
./drivers/dma/amd/ae4dma/ae4dma-pci.c
./drivers/dma/amd/ae4dma/ae4dma.h
./drivers/dma/amd/ptdma/ptdma-debugfs.c
./drivers/dma/amd/ptdma/ptdma-dev.c
./drivers/dma/amd/ptdma/ptdma-dmaengine.c
./drivers/dma/amd/ptdma/ptdma-pci.c
./drivers/dma/amd/qdma/qdma-comm-regs.c
./drivers/dma/amd/qdma/qdma.c
./drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
./drivers/dma/dw-edma/dw-edma-core.c
./drivers/dma/dw-edma/dw-edma-pcie.c
./drivers/dma/dw-edma/dw-edma-v0-core.c
./drivers/dma/dw-edma/dw-edma-v0-debugfs.c
./drivers/dma/dw-edma/dw-hdma-v0-core.c
./drivers/dma/dw-edma/dw-hdma-v0-debugfs.c
./drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c
./drivers/dma/fsl-edma-common.c
./drivers/dma/fsl-edma-main.c
./drivers/dma/fsl-edma-trace.c
./drivers/dma/fsl-qdma.c
./drivers/dma/hsu/hsu.c
./drivers/dma/hsu/hsu.h
./drivers/dma/hsu/pci.c
./drivers/dma/idma64.c
./drivers/dma/idma64.h
./drivers/dma/mcf-edma-main.c
./drivers/dma/mediatek/mtk-cqdma.c
./drivers/dma/sf-pdma/sf-pdma.c
./drivers/dma/st_fdma.c
./drivers/dma/st_fdma.h
./drivers/mfd/intel-lpss.c
./drivers/net/ethernet/airoha/airoha_eth.c
./drivers/net/ethernet/mediatek/mtk_eth_soc.c
./drivers/net/ethernet/mediatek/mtk_eth_soc.h
./drivers/pci/controller/pcie-xilinx-dma-pl.c
./drivers/tty/serial/8250/8250_mid.c
./include/linux/dma/hsu.h

Just realized, that I missed to check this drivers:
./drivers/net/ethernet/airoha/airoha_eth.c
./drivers/net/ethernet/mediatek/mtk_eth_soc.c
./drivers/net/ethernet/mediatek/mtk_eth_soc.h
./drivers/pci/controller/pcie-xilinx-dma-pl.c
./drivers/tty/serial/8250/8250_mid.c

I've applied the following config to the kernel, to build all the
drivers. I've modified some Kconfig files in order all options apply.
And checked that every file in the above list builds successfully.
Some drivers have compile errors, unrelated to virt-dma. Some drivers
produce link errors, but compile success. I checked that each .o-file
has a reasonable size.

CONFIG_FORCE_PCI=y
CONFIG_PCI=y
CONFIG_AMD_QDMA=y
CONFIG_AMD_PTDMA=y
CONFIG_DW_AXI_DMAC=y
CONFIG_DW_EDMA=y
CONFIG_DW_EDMA_PCIE=y
CONFIG_INTEL_LDMA=y
CONFIG_MTK_HSDMA=y
CONFIG_MTK_CQDMA=y
CONFIG_MTK_UART_APDMA=y
# CONFIG_QCOM_ADM=y - error: assignment to 'u32 *' {aka 'unsigned int
*'} from incompatible pointer type 'phys_addr_t *'
CONFIG_QCOM_GPI_DMA=y
CONFIG_QCOM_BAM_DMA=y
CONFIG_SF_PDMA=y
CONFIG_STM32_DMA=y
CONFIG_STM32_MDMA=y
CONFIG_STM32_DMA3=y
CONFIG_DMA_OMAP=y
CONFIG_TI_EDMA=y
CONFIG_TI_K3_UDMA=y
CONFIG_XILINX_ZYNQMP_DPDMA=y
CONFIG_XILINX_XDMA=y
CONFIG_AMBA_PL08X=y
CONFIG_ARM_DMA350=y
# CONFIG_FSL_DMA=y - error: implicit declaration of function '__ilog2
CONFIG_FSL_EDMA=y
CONFIG_FSL_QDMA=y
CONFIG_MCF_EDMA=y
CONFIG_INTEL_IDMA64=y
CONFIG_DMA_SUN6I=y
CONFIG_DMA_SUN4I=y
CONFIG_AT_HDMAC=y
# CONFIG_ST_FDMA=y - link errors
CONFIG_K3_DMA=y
CONFIG_DMA_SA11X0=y
CONFIG_AXI_DMAC=y
CONFIG_IMG_MDC_DMA=y
CONFIG_UNIPHIER_XDMAC=y
CONFIG_UNIPHIER_MDMAC=y
CONFIG_LOONGSON1_APB_DMA=y
CONFIG_LOONGSON2_APB_DMA=y
CONFIG_DMA_BCM2835=y
CONFIG_TEGRA210_ADMA=y
CONFIG_TEGRA186_GPC_DMA=y
CONFIG_MOXART_DMA=y
CONFIG_DMA_JZ4780=y
CONFIG_IMX_SDMA=y
CONFIG_OWL_DMA=y
CONFIG_SPRD_DMA=y
CONFIG_MILBEAUT_XDMAC=y
CONFIG_MILBEAUT_HDMAC=y
CONFIG_HISI_DMA=y
# CONFIG_FSL_DPAA2_QDMA=y - link errors
CONFIG_RZ_DMAC=y
CONFIG_RENESAS_USB_DMAC=y
CONFIG_PXA_DMA=y
CONFIG_HSU_DMA=y
CONFIG_HSU_DMA_PCI=y
CONFIG_MFD_INTEL_LPSS=y

