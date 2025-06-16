Return-Path: <dmaengine+bounces-5487-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E47BAADB08C
	for <lists+dmaengine@lfdr.de>; Mon, 16 Jun 2025 14:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 091B518815B2
	for <lists+dmaengine@lfdr.de>; Mon, 16 Jun 2025 12:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8D8285C93;
	Mon, 16 Jun 2025 12:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5lK0oM0"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066CB1ABEC5;
	Mon, 16 Jun 2025 12:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750078187; cv=none; b=hEDXeTs9QP9RZu9KHSmYcVtt/cbuCVHkP0YD37xyYx6m3d/dkOpnMVBbvTg64Fxtc0cM64Nd2B/2XF+kLSl/tDj0yFb3iEM/B3lH5gp5qhbh/zx1aYw51vHWCOJZi+mqaGUqQ9z9ZvgQNz6SaMCkVr8PxIn1B6GXu4jbNd4ISV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750078187; c=relaxed/simple;
	bh=qkqlhKjdJO8J5GB9CvX4foOoObaUYDwVcup5l10hhWs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t21GIgl+5qtfASX5/NEEPszgBCvOb615DSMZzRul39ku2tDyrQytWa6Pz5sZGgE+FvY3v9jhreLaOXZx7Ew9x0B6Y39qUoxP/3IDS5Z5cyJTJylHKaknVtplKKEBAXlXIoT3/3WKSR0M1CfOege+E7eRYenBP+eGicX4Glw1MOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d5lK0oM0; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-54e98f73850so4283578e87.1;
        Mon, 16 Jun 2025 05:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750078183; x=1750682983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CZ4WRavB5zFwjZHJzhP+H8upINz+844Em+7kb5ozr5E=;
        b=d5lK0oM0KO5GlfYZYiLEwO3Zeu5cZxsUs7582rSUr4YviaCie+99yK2cCqhS3+CNnt
         9wxXoen6846r9M0ScUa7qnbquR+J7g9Lyex5vdnKWSIHc6L7mRUpx7Nc0SBpJ+1yq5VV
         ilaRmcabo069TyEmxsZrCVX5OoMsTw0hOJXo/a9SM3cTSves170onHmMxwPvq6xOij1g
         fywVXOYkVL44RFmqV15Hu0osNUOkaXBCtAQladMktbq/HaKcd7+WEYeTeK7MkIEl61Za
         FZ3cox+f8XWPU9HMCkux3HubBB8uc3bdxHNjb3+9rLwDrMEwHvDjb37DRSi2Jm8N2wLM
         meEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750078183; x=1750682983;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CZ4WRavB5zFwjZHJzhP+H8upINz+844Em+7kb5ozr5E=;
        b=P7ItA+/hakiePWcOeA7s/Q2OohQidrLE87YomcjnRo1tbHfRRXUr2Z1NbcEtC/RJF/
         h+kBgXlR1pMZjAdg5JhxFMx2nb6JatwH6cDLQf6Wx3CcgUpaNGJE4Xjb0TvuN9LY2Byy
         gEaelHqkpLfZJa4TctEpnz+kn+Q+aSsEo1NI+7XjuO7rw0PA6BQ1vzy+2ARHArqWrGr4
         8nJS0/NQen3dLXlmGy7EIAMUpoXuYAgsr8tDsFBZf4uGucM1rVl6uWauP55nI1BEAF+i
         VZ4rIH+9zbAJ6cuEWrDWs1rnW+Ll+TE8JTzKAn+dgaMuiBlqKDwx/k4XgWLM24MnQ+D7
         ck7g==
X-Forwarded-Encrypted: i=1; AJvYcCWkm8ZBotG/moGj1cSPA9LxAV4Mkt4Pq0RkhoUHF1hVrc9qaKr5CNUXZdJZL8zYdSEvZ/gYYM1JhE4=@vger.kernel.org, AJvYcCXC1UBk3g3D6so+Up3oEiWWQSiFduWEwoSIj3cEy6v/pxCRl2VQOCVxUGaiByAHfL4DuDLCthjq5AQDyjnS@vger.kernel.org
X-Gm-Message-State: AOJu0YzOpblDVbXtD1Kgk7mRrrNsykPsufxLLuDLKGPSeRZyAwJVXv72
	6WQJMIIQbPcFvcu73xi2XNK4Uj27HbmzGROs+qhPw85tgjn0cTlQ4n2R
X-Gm-Gg: ASbGnctLTX6Vq+qsxRf4AYRpc56gRDnlEpP1ojWzFajtKZAzAGCNwfDs9xjzTyPz7s+
	1ySR/IH3rvm/M0kqmH2e6rm5Nk3cl++Gf2kttCE7xWC8fb7cDHT2YCZrlR0BTfCjdW62pjh6eci
	Tsl0haqWk56+g91ZAds/TXoqvnaSt9LybvMEnN5nlzVtl8oVf0Et0AtDjoe+ocBq/Q73z75rKdG
	oLOhpScQWKrPgFlISJ6ZuTvrgmO+zYoiRjGWK7q1yHQgx5196qJjoFlXVNGn/BTgvz2PHU7bdm5
	llNgc1lEDp8HTwxRBBmOXRg22zYOcFqOGU9kif0IexW2vxht+sB5pGaeSctV2gSxpxG0JyLzVaU
	4h4zNxA==
X-Google-Smtp-Source: AGHT+IFW+0OWL85Apksy9XTkUqA17Ln55STCkHZhbPZPX+GSiUhqua72av+0g7J4+NDr55EqZogylw==
X-Received: by 2002:a05:6512:2345:b0:553:ae17:556 with SMTP id 2adb3069b0e04-553b6f0fcf1mr2132681e87.27.1750078182638;
        Mon, 16 Jun 2025 05:49:42 -0700 (PDT)
Received: from ubuntu-2404-1.lintech.local ([80.87.144.137])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553ac116968sm1529733e87.32.2025.06.16.05.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 05:49:41 -0700 (PDT)
From: Alexander Kochetkov <al.kochet@gmail.com>
To: Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nishad Saraf <nishads@amd.com>,
	Lizhi Hou <lizhi.hou@amd.com>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Paul Cercueil <paul@crapouillou.net>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Zhou Wang <wangzhou1@hisilicon.com>,
	Longfang Liu <liulongfang@huawei.com>,
	Andy Shevchenko <andy@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Keguang Zhang <keguang.zhang@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	=?UTF-8?q?Am=C3=A9lie=20Delaunay?= <amelie.delaunay@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Amit Vadhavana <av2082000@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Md Sadre Alam <quic_mdalam@quicinc.com>,
	Alexander Kochetkov <al.kochet@gmail.com>,
	Casey Connolly <casey.connolly@linaro.org>,
	Kees Cook <kees@kernel.org>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
Subject: [PATCH v2 0/2] dmaengine: virt-dma: convert tasklet to BH workqueue for callback invocation
Date: Mon, 16 Jun 2025 12:48:02 +0000
Message-ID: <20250616124934.141782-1-al.kochet@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello!

Here is v2.

I've updated patch accoding to recomendations from Andy Shevchenko:
- where possible I placed #include <linux/interrupt.h> in correct position
  to keep include list ordered.

Also I provide patch file for Kconfig files. It allows to compile most of
virt-dma users on unsupported architecture. I've used ARM64 configuration
to compile kernel.

One driver (qcom_adm.o) is impossible to compile on ARM64, and that intended
behaviour. It has condition 'depends on (ARCH_QCOM || COMPILE_TEST) &&
!PHYS_ADDR_T_64BIT' preventing from building it on 64-bit architectures.
I've checked it doesn't touch virt-dma fields directly and contains
#include <linux/interrupt.h> already. It looks that it doesn't need any
changes. Anyway, I tried to compile it and only get the following errors:

/kernel-source/drivers/dma/qcom/qcom_adm.c: In function 'adm_process_fc_descriptors':
/kernel-source/drivers/dma/qcom/qcom_adm.c:245:21: error: assignment to 'u32 *' 
{aka 'unsigned int *'} from incompatible pointer type 'phys_addr_t *' 
{aka 'long long unsigned int *'} [-Werror=incompatible-pointer-types]
  245 |                 src = &achan->slave.src_addr;
      |                     ^
/kernel-source/drivers/dma/qcom/qcom_adm.c:251:21: error: assignment to 'u32 *' 
{aka 'unsigned int *'} from incompatible pointer type 'phys_addr_t *' 
{aka 'long long unsigned int *'} [-Werror=incompatible-pointer-types]
  251 |                 dst = &achan->slave.dst_addr;
      |                     ^
/kernel-source/drivers/dma/qcom/qcom_adm.c: In function 'adm_process_non_fc_descriptors':
/kernel-source/drivers/dma/qcom/qcom_adm.c:309:21: error: assignment to 'u32 *' 
{aka 'unsigned int *'} from incompatible pointer type 'phys_addr_t *' 
{aka 'long long unsigned int *'} [-Werror=incompatible-pointer-types]
  309 |                 src = &achan->slave.src_addr;
      |                     ^
/kernel-source/drivers/dma/qcom/qcom_adm.c:313:21: error: assignment to 'u32 *' 
{aka 'unsigned int *'} from incompatible pointer type 'phys_addr_t *' 
{aka 'long long unsigned int *'} [-Werror=incompatible-pointer-types]
  313 |                 dst = &achan->slave.dst_addr;
      |                     ^
/kernel-source/drivers/dma/qcom/qcom_adm.c: In function 'adm_dma_probe':
/kernel-source/drivers/dma/qcom/qcom_adm.c:77:41: warning: conversion from 
'long unsigned int' to 'u32' {aka 'unsigned int'} changes value from 
'18446744072371568648' to '2956984328' [-Woverflow]
   77 | #define ADM_CI_RANGE_START(x)           ((x) << 16)
/kernel-source/drivers/dma/qcom/qcom_adm.c:848:16: note: in expansion of 
macro 'ADM_CI_RANGE_START'
  848 |         writel(ADM_CI_RANGE_START(0x40) | ADM_CI_RANGE_END(0xb0) |


In order to detect all users of virt-dma, I did following.

I got all include files containing 'virt-dma.h' or 'struct virt_dma_chan'.

$ git grep -l -e virt-dma.h -e 'struct virt_dma_chan' -- '*.h'
drivers/dma/amd/ae4dma/ae4dma.h
drivers/dma/amd/ptdma/ptdma.h
drivers/dma/amd/qdma/qdma.h
drivers/dma/dw-axi-dmac/dw-axi-dmac.h
drivers/dma/dw-edma/dw-edma-core.h
drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.h
drivers/dma/fsl-edma-common.h
drivers/dma/hsu/hsu.h
drivers/dma/idma64.h
drivers/dma/sf-pdma/sf-pdma.h
drivers/dma/st_fdma.h
drivers/dma/virt-dma.h

I got all include files containing all include files found in step 1:

$ git grep -l -e ae4dma.h -e ptdma.h -e qdma.h -e dw-axi-dmac.h \
              -e dw-edma-core.h -e dpaa2-qdma.h -e fsl-edma-common.h \
              -e hsu.h -e idma64.h -e sf-pdma.h -e st_fdma.h -e virt-dma.h \
              -e 'struct virt_dma_chan' -- '*.h'
drivers/dma/amd/ae4dma/ae4dma.h
drivers/dma/amd/ptdma/ptdma.h
drivers/dma/amd/qdma/qdma.h
drivers/dma/dw-axi-dmac/dw-axi-dmac.h
drivers/dma/dw-edma/dw-edma-core.h
drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.h
drivers/dma/fsl-edma-common.h
drivers/dma/hsu/hsu.h
drivers/dma/idma64.h
drivers/dma/sf-pdma/sf-pdma.h
drivers/dma/st_fdma.h
drivers/dma/virt-dma.h
drivers/net/ethernet/mediatek/mtk_eth_soc.h
include/linux/dma/hsu.h

After that I got all users of virt dma:
$ git grep -l -e ae4dma.h -e ptdma.h -e qdma.h -e dw-axi-dmac.h \
              -e dw-edma-core.h -e dpaa2-qdma.h -e fsl-edma-common.h \
              -e hsu.h -e idma64.h -e sf-pdma.h -e st_fdma.h -e virt-dma.h \
              -e mtk_eth_soc.h -e 'struct virt_dma_chan' -- '*.c'

drivers/dma/amba-pl08x.c
drivers/dma/amd/ae4dma/ae4dma-dev.c
drivers/dma/amd/ae4dma/ae4dma-pci.c
drivers/dma/amd/ptdma/ptdma-debugfs.c
drivers/dma/amd/ptdma/ptdma-dev.c
drivers/dma/amd/ptdma/ptdma-dmaengine.c
drivers/dma/amd/ptdma/ptdma-pci.c
drivers/dma/amd/qdma/qdma-comm-regs.c
drivers/dma/amd/qdma/qdma.c
drivers/dma/arm-dma350.c
drivers/dma/at_hdmac.c
drivers/dma/bcm2835-dma.c
drivers/dma/dma-axi-dmac.c
drivers/dma/dma-jz4780.c
drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
drivers/dma/dw-edma/dw-edma-core.c
drivers/dma/dw-edma/dw-edma-pcie.c
drivers/dma/dw-edma/dw-edma-v0-core.c
drivers/dma/dw-edma/dw-edma-v0-debugfs.c
drivers/dma/dw-edma/dw-hdma-v0-core.c
drivers/dma/dw-edma/dw-hdma-v0-debugfs.c
drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c
drivers/dma/fsl-edma-common.c
drivers/dma/fsl-edma-main.c
drivers/dma/fsl-edma-trace.c
drivers/dma/fsl-qdma.c
drivers/dma/hisi_dma.c
drivers/dma/hsu/hsu.c
drivers/dma/hsu/pci.c
drivers/dma/idma64.c
drivers/dma/img-mdc-dma.c
drivers/dma/imx-sdma.c
drivers/dma/k3dma.c
drivers/dma/lgm/lgm-dma.c
drivers/dma/loongson1-apb-dma.c
drivers/dma/loongson2-apb-dma.c
drivers/dma/mcf-edma-main.c
drivers/dma/mediatek/mtk-cqdma.c
drivers/dma/mediatek/mtk-hsdma.c
drivers/dma/mediatek/mtk-uart-apdma.c
drivers/dma/milbeaut-hdmac.c
drivers/dma/milbeaut-xdmac.c
drivers/dma/moxart-dma.c
drivers/dma/owl-dma.c
drivers/dma/pxa_dma.c
drivers/dma/qcom/bam_dma.c
drivers/dma/qcom/gpi.c
drivers/dma/qcom/qcom_adm.c
drivers/dma/sa11x0-dma.c
drivers/dma/sf-pdma/sf-pdma.c
drivers/dma/sh/rz-dmac.c
drivers/dma/sh/usb-dmac.c
drivers/dma/sprd-dma.c
drivers/dma/st_fdma.c
drivers/dma/stm32/stm32-dma.c
drivers/dma/stm32/stm32-dma3.c
drivers/dma/stm32/stm32-mdma.c
drivers/dma/sun4i-dma.c
drivers/dma/sun6i-dma.c
drivers/dma/tegra186-gpc-dma.c
drivers/dma/tegra210-adma.c
drivers/dma/ti/edma.c
drivers/dma/ti/k3-udma.c
drivers/dma/ti/omap-dma.c
drivers/dma/uniphier-mdmac.c
drivers/dma/uniphier-xdmac.c
drivers/dma/virt-dma.c
drivers/dma/xilinx/xdma.c
drivers/dma/xilinx/xilinx_dpdma.c
drivers/mfd/intel-lpss.c
drivers/net/ethernet/airoha/airoha_eth.c
drivers/net/ethernet/mediatek/mtk_eth_path.c
drivers/net/ethernet/mediatek/mtk_eth_soc.c
drivers/net/ethernet/mediatek/mtk_ppe.c
drivers/net/ethernet/mediatek/mtk_ppe_debugfs.c
drivers/net/ethernet/mediatek/mtk_ppe_offload.c
drivers/net/ethernet/mediatek/mtk_wed.c
drivers/pci/controller/pcie-xilinx-dma-pl.c
drivers/tty/serial/8250/8250_mid.c

After that I compiled kernel with following options:
CONFIG_COMPILE_TEST=y
CONFIG_FORCE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_MSI=y
CONFIG_AMD_QDMA=y
CONFIG_AMD_PTDMA=y
CONFIG_DW_AXI_DMAC=y
CONFIG_DW_EDMA=y
CONFIG_DW_EDMA_PCIE=y
CONFIG_INTEL_LDMA=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_MT6577=y
CONFIG_MTK_HSDMA=y
CONFIG_MTK_CQDMA=y
CONFIG_MTK_UART_APDMA=y
# CONFIG_QCOM_ADM=y - error: assignment to 'u32 *' {aka 'unsigned int *'} from incompatible pointer type 'phys_addr_t *'
CONFIG_QCOM_GPI_DMA=y
CONFIG_QCOM_BAM_DMA=y
CONFIG_SF_PDMA=y
CONFIG_STM32_DMA=y
CONFIG_STM32_MDMA=y
CONFIG_STM32_DMA3=y
CONFIG_DMA_OMAP=y
CONFIG_TI_EDMA=y
CONFIG_TI_MESSAGE_MANAGER=y
CONFIG_TI_SCI_PROTOCOL=y
CONFIG_TI_SCI_INTA_IRQCHIP=y
CONFIG_TI_K3_UDMA=y
CONFIG_XILINX_ZYNQMP_DPDMA=y
CONFIG_XILINX_XDMA=y
CONFIG_AMBA_PL08X=y
CONFIG_ARM_DMA350=y
CONFIG_FSL_EDMA=y
CONFIG_FSL_QDMA=y
CONFIG_MCF_EDMA=y
CONFIG_INTEL_IDMA64=y
CONFIG_DMA_SUN6I=y
CONFIG_DMA_SUN4I=y
CONFIG_AT_HDMAC=y
CONFIG_REMOTEPROC=y
CONFIG_ST_FDMA=y
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
CONFIG_FSL_MC_BUS=y
CONFIG_FSL_MC_DPIO=y
CONFIG_FSL_DPAA2_QDMA=y
CONFIG_RZ_DMAC=y
CONFIG_RENESAS_USB_DMAC=y
CONFIG_PXA_DMA=y
CONFIG_HSU_DMA=y
CONFIG_HSU_DMA_PCI=y
CONFIG_MFD_INTEL_LPSS=y
CONFIG_NET_AIROHA=y
CONFIG_NET_VENDOR_MEDIATEK=y
CONFIG_NET_MEDIATEK_SOC=y
CONFIG_NET_MEDIATEK_SOC_WED=y
CONFIG_PCIE_XILINX_DMA_PL=y
CONFIG_SERIAL_8250_MID=y
CONFIG_AMD_AE4DMA=y

After that I've used following script to check compilation (it used file
list obtained in previous step):
#!/bin/bash

for f in `cat files`; do
    f=`echo $f | sed 's/.c$/.o/'`
    test -f $f && echo $f: ok || echo $f: No such file or directory
done

It produced following output:
$ ./check
drivers/dma/amba-pl08x.o: ok
drivers/dma/amd/ae4dma/ae4dma-dev.o: ok
drivers/dma/amd/ae4dma/ae4dma-pci.o: ok
drivers/dma/amd/ptdma/ptdma-debugfs.o: ok
drivers/dma/amd/ptdma/ptdma-dev.o: ok
drivers/dma/amd/ptdma/ptdma-dmaengine.o: ok
drivers/dma/amd/ptdma/ptdma-pci.o: ok
drivers/dma/amd/qdma/qdma-comm-regs.o: ok
drivers/dma/amd/qdma/qdma.o: ok
drivers/dma/arm-dma350.o: ok
drivers/dma/at_hdmac.o: ok
drivers/dma/bcm2835-dma.o: ok
drivers/dma/dma-axi-dmac.o: ok
drivers/dma/dma-jz4780.o: ok
drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.o: ok
drivers/dma/dw-edma/dw-edma-core.o: ok
drivers/dma/dw-edma/dw-edma-pcie.o: ok
drivers/dma/dw-edma/dw-edma-v0-core.o: ok
drivers/dma/dw-edma/dw-edma-v0-debugfs.o: ok
drivers/dma/dw-edma/dw-hdma-v0-core.o: ok
drivers/dma/dw-edma/dw-hdma-v0-debugfs.o: ok
drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.o: ok
drivers/dma/fsl-edma-common.o: ok
drivers/dma/fsl-edma-main.o: ok
drivers/dma/fsl-edma-trace.o: ok
drivers/dma/fsl-qdma.o: ok
drivers/dma/hisi_dma.o: ok
drivers/dma/hsu/hsu.o: ok
drivers/dma/hsu/pci.o: ok
drivers/dma/idma64.o: ok
drivers/dma/img-mdc-dma.o: ok
drivers/dma/imx-sdma.o: ok
drivers/dma/k3dma.o: ok
drivers/dma/lgm/lgm-dma.o: ok
drivers/dma/loongson1-apb-dma.o: ok
drivers/dma/loongson2-apb-dma.o: ok
drivers/dma/mcf-edma-main.o: ok
drivers/dma/mediatek/mtk-cqdma.o: ok
drivers/dma/mediatek/mtk-hsdma.o: ok
drivers/dma/mediatek/mtk-uart-apdma.o: ok
drivers/dma/milbeaut-hdmac.o: ok
drivers/dma/milbeaut-xdmac.o: ok
drivers/dma/moxart-dma.o: ok
drivers/dma/owl-dma.o: ok
drivers/dma/pxa_dma.o: ok
drivers/dma/qcom/bam_dma.o: ok
drivers/dma/qcom/gpi.o: ok
drivers/dma/qcom/qcom_adm.o: No such file or directory
drivers/dma/sa11x0-dma.o: ok
drivers/dma/sf-pdma/sf-pdma.o: ok
drivers/dma/sh/rz-dmac.o: ok
drivers/dma/sh/usb-dmac.o: ok
drivers/dma/sprd-dma.o: ok
drivers/dma/st_fdma.o: ok
drivers/dma/stm32/stm32-dma.o: ok
drivers/dma/stm32/stm32-dma3.o: ok
drivers/dma/stm32/stm32-mdma.o: ok
drivers/dma/sun4i-dma.o: ok
drivers/dma/sun6i-dma.o: ok
drivers/dma/tegra186-gpc-dma.o: ok
drivers/dma/tegra210-adma.o: ok
drivers/dma/ti/edma.o: ok
drivers/dma/ti/k3-udma.o: ok
drivers/dma/ti/omap-dma.o: ok
drivers/dma/uniphier-mdmac.o: ok
drivers/dma/uniphier-xdmac.o: ok
drivers/dma/virt-dma.o: ok
drivers/dma/xilinx/xdma.o: ok
drivers/dma/xilinx/xilinx_dpdma.o: ok
drivers/mfd/intel-lpss.o: ok
drivers/net/ethernet/airoha/airoha_eth.o: ok
drivers/net/ethernet/mediatek/mtk_eth_path.o: ok
drivers/net/ethernet/mediatek/mtk_eth_soc.o: ok
drivers/net/ethernet/mediatek/mtk_ppe.o: ok
drivers/net/ethernet/mediatek/mtk_ppe_debugfs.o: ok
drivers/net/ethernet/mediatek/mtk_ppe_offload.o: ok
drivers/net/ethernet/mediatek/mtk_wed.o: ok
drivers/pci/controller/pcie-xilinx-dma-pl.o: ok
drivers/tty/serial/8250/8250_mid.o: ok


Alexander Kochetkov (2):
  dmaengine: virt-dma: convert tasklet to BH workqueue for callback
    invocation
  Allow compile virt-dma users on ARM64 platform

 drivers/dma/Kconfig                           | 22 +++++++++----------
 drivers/dma/amd/Kconfig                       |  4 ++--
 drivers/dma/amd/qdma/qdma.c                   |  1 +
 drivers/dma/arm-dma350.c                      |  1 +
 drivers/dma/bcm2835-dma.c                     |  2 +-
 drivers/dma/dma-axi-dmac.c                    |  8 +++----
 drivers/dma/dma-jz4780.c                      |  2 +-
 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    |  2 +-
 drivers/dma/dw-edma/dw-edma-core.c            |  2 +-
 drivers/dma/fsl-edma-common.c                 |  2 +-
 drivers/dma/fsl-edma-common.h                 |  1 +
 drivers/dma/fsl-qdma.c                        |  3 ++-
 drivers/dma/hisi_dma.c                        |  2 +-
 drivers/dma/hsu/Kconfig                       |  4 ++--
 drivers/dma/hsu/hsu.c                         |  2 +-
 drivers/dma/idma64.c                          |  3 ++-
 drivers/dma/img-mdc-dma.c                     |  2 +-
 drivers/dma/imx-sdma.c                        |  2 +-
 drivers/dma/k3dma.c                           |  2 +-
 drivers/dma/loongson1-apb-dma.c               |  2 +-
 drivers/dma/mediatek/mtk-cqdma.c              |  2 +-
 drivers/dma/mediatek/mtk-hsdma.c              |  3 ++-
 drivers/dma/mediatek/mtk-uart-apdma.c         |  4 ++--
 drivers/dma/owl-dma.c                         |  2 +-
 drivers/dma/pxa_dma.c                         |  2 +-
 drivers/dma/qcom/Kconfig                      |  6 ++---
 drivers/dma/qcom/bam_dma.c                    |  4 ++--
 drivers/dma/qcom/gpi.c                        |  1 +
 drivers/dma/qcom/qcom_adm.c                   |  2 +-
 drivers/dma/sa11x0-dma.c                      |  2 +-
 drivers/dma/sf-pdma/sf-pdma.c                 |  3 ++-
 drivers/dma/sprd-dma.c                        |  2 +-
 drivers/dma/st_fdma.c                         |  2 +-
 drivers/dma/stm32/stm32-dma.c                 |  1 +
 drivers/dma/stm32/stm32-dma3.c                |  1 +
 drivers/dma/stm32/stm32-mdma.c                |  1 +
 drivers/dma/sun6i-dma.c                       |  2 +-
 drivers/dma/tegra186-gpc-dma.c                |  2 +-
 drivers/dma/tegra210-adma.c                   |  3 ++-
 drivers/dma/ti/Kconfig                        |  2 +-
 drivers/dma/ti/edma.c                         |  2 +-
 drivers/dma/ti/k3-udma.c                      | 10 ++++-----
 drivers/dma/ti/omap-dma.c                     |  2 +-
 drivers/dma/uniphier-xdmac.c                  |  1 +
 drivers/dma/virt-dma.c                        |  8 +++----
 drivers/dma/virt-dma.h                        | 10 ++++-----
 drivers/mfd/Kconfig                           |  2 +-
 47 files changed, 82 insertions(+), 69 deletions(-)

-- 
2.43.0


