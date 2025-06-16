Return-Path: <dmaengine+bounces-5489-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4170ADB091
	for <lists+dmaengine@lfdr.de>; Mon, 16 Jun 2025 14:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5773F3A35D2
	for <lists+dmaengine@lfdr.de>; Mon, 16 Jun 2025 12:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3075D292B52;
	Mon, 16 Jun 2025 12:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Voc6QXQj"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D856292B41;
	Mon, 16 Jun 2025 12:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750078193; cv=none; b=jM5V1MM2yTp8eVc++1M6aOINxL1s6mvqcnYNztTfbrWrngvHvNqrcGUNsNBauuK5aeVhPxR0sbC9r6aUDJHhd1H0fz/AEPyDvyLhHUa5f1vMrYg9Bvo+qZtH2scpfc3nlLWCTYqnDLrAhHmb5i5he1AMaqHgkD9gZCv5mePhQeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750078193; c=relaxed/simple;
	bh=Q8hJemdXmGHoFFuY41r1vt0g1y6BjncCn1LRH7GqPsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BUX7NtpiWTDT3tsaG6Ao/gTc3c35uIpsVDjAJzk/cKzDbP4wIY3eCZboLhcqI32OSS6G+cTDLvWhJ2R90cfKjBwoSMb2IGJJSFE7rLcks3LtHXazFqJNFQCOMlMf0rcN/tsVQ8+j4niB+3x0VNSlGNbJrbxRc8Lw3FdLm73jWKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Voc6QXQj; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5534edc6493so4791199e87.1;
        Mon, 16 Jun 2025 05:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750078189; x=1750682989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LCul4Xvo6O7bUYuZWs6HVmgajLM6k5wbxI3sUOitJGg=;
        b=Voc6QXQjdI1o0sXnpcrBnTpDmS1nGUhl9UrnXYlwfhEZVWwCMXSA3PfN7OGsFvA2FZ
         3/6YfZD7t4l5fjADlGCXX8LxRj7fGUBiNa+pTRJOl8W6f4BtNunSH0RZXlw+az5b3W6n
         lC8Vc4fuYBktFXbu1n4t2uv21AkMU2w/HeYkYkmFe/1mI8VfE2B+7zoM4UqANH//jOcq
         Z7wzI8VEGdNFH5URdOrHUj1n4baJ1eAXYhMSiySOHQeEUorTwyDqhAnYok0JTK6zp7jT
         lFjW/5XQA/M9BLdqVgxcRSFnDTCvPKKDGXZ96i3iQicoLk+vnht6QnIOl29RqOF94df4
         PyEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750078189; x=1750682989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LCul4Xvo6O7bUYuZWs6HVmgajLM6k5wbxI3sUOitJGg=;
        b=P5t9IszYt48hNz9dAEHS977wpS2ZFnVbwgIdzio8awFK3zyDqql4ym75YZYUTaa2d9
         WACXHA4hXuG5tmYQbo3WVMOgM0xZuLONLRQeBFhUhW/I9fi5NCRAi8v++fRfkqj67tir
         qKEybCBa8htgLEiKaufYKiNIU0ZRPahDVlcgCJxJD308grinn2eeioeifRYX0wDjuPQU
         Zg1Z4KQZtuvasxCn+3tGG3WwZfxf1XKlXZUeckF88groEmr9RV0JHLTcKPm16gyfqI3F
         IvLau+Q5YQI9geGWZwalrWQKCCZhZkbkf1F+VaRNxWtWCEbKZHv/cLwjqwaNbt1aJ4gN
         BBqA==
X-Forwarded-Encrypted: i=1; AJvYcCUfv3InRbtyR7Eo5X9aruCAAaUOGWge/hcGznEnp2e7N7FV+O+jhse3H3OiaX+NhuVrVpn+IRYGnG+H9E50@vger.kernel.org, AJvYcCXqqS5sUc0r8RS62NvqYt2qVp1vSJLZZm71sRfbqkBaHDkGdmLmMzC5NlUUxFrENMMQdS3QY9Q1rE4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZiBL+SIBNOFDhVbATgc4kEyWE26YSiWPv2zDN/f4zw2BVhUtV
	KHe85ayu35dNsVaS7XeXtjcWIE/xTYk+/8oH9M0dI9IYCzfPsGME5T6Y
X-Gm-Gg: ASbGnctaZwFXpfhHKGgpgG1WKI2KQZGsDH1WrjjU4cjI3BlnWeOz2Vai9ai1uDi01ME
	tEOmnouwQUJCUZNhfCdw+wTCy1Km093u5TM08AXQFBIre0gZVT/0aETzVASoubPTWWBV0yiQDT1
	HCZbjvs7UzJ8ROTqb2LxYAHwWpzjPy7HdX1GIpDGvsZQfelYNHxoueZI9PA2hsLz8hr4zVzORgF
	3fiO3J/7cPx8t1ysqogOMYe7RZHSiMoqvpRK1GTuFDaETs5kaLLPlrmRJtzDWbUCGIG6orWM6Lb
	MREN9lg55Axhg7gNWFCfmkw2wPeryMKACbawmF99Z5/GsQJvgrsXGKNxcyxp2XAkcSp3JPIqS4o
	6nhFsnA==
X-Google-Smtp-Source: AGHT+IH4DNDz5p5AR7aaA4sVQfeNDUHCxA8zQzFeSZOEiDkWUaZVgUqHVdeyuU7RfgKb+hsGvc00BQ==
X-Received: by 2002:a05:6512:3092:b0:553:a5e0:719c with SMTP id 2adb3069b0e04-553b6f5ec6bmr2592714e87.51.1750078188755;
        Mon, 16 Jun 2025 05:49:48 -0700 (PDT)
Received: from ubuntu-2404-1.lintech.local ([80.87.144.137])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553ac116968sm1529733e87.32.2025.06.16.05.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 05:49:48 -0700 (PDT)
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
Subject: [PATCH v2 2/2] !!! TESTING ONLY !!! Allow compile virt-dma users on ARM64 platform
Date: Mon, 16 Jun 2025 12:48:04 +0000
Message-ID: <20250616124934.141782-3-al.kochet@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250616124934.141782-1-al.kochet@gmail.com>
References: <20250616124934.141782-1-al.kochet@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch is for testing only!

Most of DMA drivers are platform specific and their configuration
options can be enabled only then building kernel for specific
platform. In order to simplify compilation check of such drivers
Kconfig files were modified.

Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
---
 drivers/dma/Kconfig      | 22 +++++++++++-----------
 drivers/dma/amd/Kconfig  |  4 ++--
 drivers/dma/hsu/Kconfig  |  4 ++--
 drivers/dma/qcom/Kconfig |  6 +++---
 drivers/dma/ti/Kconfig   |  2 +-
 drivers/mfd/Kconfig      |  2 +-
 6 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index db87dd2a07f7..b1840ae86964 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -103,7 +103,7 @@ config ARM_DMA350
 
 config AT_HDMAC
 	tristate "Atmel AHB DMA support"
-	depends on ARCH_AT91
+	depends on ARCH_AT91 || COMPILE_TEST
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	help
@@ -144,7 +144,7 @@ config BCM_SBA_RAID
 
 config DMA_BCM2835
 	tristate "BCM2835 DMA engine support"
-	depends on ARCH_BCM2835
+	depends on ARCH_BCM2835 || COMPILE_TEST
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 
@@ -170,7 +170,7 @@ config DMA_SA11X0
 
 config DMA_SUN4I
 	tristate "Allwinner A10 DMA SoCs support"
-	depends on MACH_SUN4I || MACH_SUN5I || MACH_SUN7I || MACH_SUNIV
+	depends on MACH_SUN4I || MACH_SUN5I || MACH_SUN7I || MACH_SUNIV || COMPILE_TEST
 	default (MACH_SUN4I || MACH_SUN5I || MACH_SUN7I || MACH_SUNIV)
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
@@ -207,7 +207,7 @@ config EP93XX_DMA
 
 config FSL_DMA
 	tristate "Freescale Elo series DMA support"
-	depends on FSL_SOC
+	depends on FSL_SOC || COMPILE_TEST
 	select DMA_ENGINE
 	select ASYNC_TX_ENABLE_CHANNEL_SWITCH
 	help
@@ -219,7 +219,7 @@ config FSL_DMA
 config FSL_EDMA
 	tristate "Freescale eDMA engine support"
 	depends on OF
-	depends on HAS_IOMEM
+	depends on HAS_IOMEM || COMPILE_TEST
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	help
@@ -280,7 +280,7 @@ config IMX_DMA
 
 config IMX_SDMA
 	tristate "i.MX SDMA support"
-	depends on ARCH_MXC
+	depends on ARCH_MXC || COMPILE_TEST
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	help
@@ -289,7 +289,7 @@ config IMX_SDMA
 
 config INTEL_IDMA64
 	tristate "Intel integrated DMA 64-bit support"
-	depends on HAS_IOMEM
+	depends on HAS_IOMEM || COMPILE_TEST
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	help
@@ -420,7 +420,7 @@ config LPC32XX_DMAMUX
 
 config MCF_EDMA
 	tristate "Freescale eDMA engine support, ColdFire mcf5441x SoCs"
-	depends on M5441x || (COMPILE_TEST && FSL_EDMA=n)
+	depends on M5441x || (COMPILE_TEST)
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	help
@@ -467,7 +467,7 @@ config MMP_TDMA
 
 config MOXART_DMA
 	tristate "MOXART DMA support"
-	depends on ARCH_MOXART
+	depends on ARCH_MOXART || COMPILE_TEST
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	help
@@ -523,7 +523,7 @@ config NBPFAXI_DMA
 
 config OWL_DMA
 	tristate "Actions Semi Owl SoCs DMA support"
-	depends on ARCH_ACTIONS
+	depends on ARCH_ACTIONS || COMPILE_TEST
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	help
@@ -582,7 +582,7 @@ config STE_DMA40
 
 config ST_FDMA
 	tristate "ST FDMA dmaengine support"
-	depends on ARCH_STI
+	depends on ARCH_STI || COMPILE_TEST
 	depends on REMOTEPROC
 	select ST_SLIM_REMOTEPROC
 	select DMA_ENGINE
diff --git a/drivers/dma/amd/Kconfig b/drivers/dma/amd/Kconfig
index 00d874872a8f..8773f3c5c31c 100644
--- a/drivers/dma/amd/Kconfig
+++ b/drivers/dma/amd/Kconfig
@@ -2,7 +2,7 @@
 #
 
 config AMD_AE4DMA
-	tristate  "AMD AE4DMA Engine"
+	bool  "AMD AE4DMA Engine"
 	depends on (X86_64 || COMPILE_TEST) && PCI
 	depends on AMD_PTDMA
 	select DMA_ENGINE
@@ -17,7 +17,7 @@ config AMD_AE4DMA
 
 config AMD_PTDMA
 	tristate  "AMD PassThru DMA Engine"
-	depends on X86_64 && PCI
+	depends on (X86_64 || COMPILE_TEST) && PCI
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	help
diff --git a/drivers/dma/hsu/Kconfig b/drivers/dma/hsu/Kconfig
index af102baec125..80426b74d3a2 100644
--- a/drivers/dma/hsu/Kconfig
+++ b/drivers/dma/hsu/Kconfig
@@ -1,10 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0-only
 # DMA engine configuration for hsu
 config HSU_DMA
-	tristate
+	bool "HSU_DMA"
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 
 config HSU_DMA_PCI
-	tristate
+	bool "HSU_DMA_PCI"
 	depends on HSU_DMA && PCI
diff --git a/drivers/dma/qcom/Kconfig b/drivers/dma/qcom/Kconfig
index ace75d7b835a..224436d3e50a 100644
--- a/drivers/dma/qcom/Kconfig
+++ b/drivers/dma/qcom/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config QCOM_ADM
 	tristate "Qualcomm ADM support"
-	depends on (ARCH_QCOM || COMPILE_TEST) && !PHYS_ADDR_T_64BIT
+	depends on (ARCH_QCOM || COMPILE_TEST)
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	help
@@ -12,7 +12,7 @@ config QCOM_ADM
 
 config QCOM_BAM_DMA
 	tristate "QCOM BAM DMA support"
-	depends on ARCH_QCOM || (COMPILE_TEST && OF && ARM)
+	depends on ARCH_QCOM || (COMPILE_TEST && OF && ARM) || COMPILE_TEST
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	help
@@ -21,7 +21,7 @@ config QCOM_BAM_DMA
 
 config QCOM_GPI_DMA
         tristate "Qualcomm Technologies GPI DMA support"
-        depends on ARCH_QCOM
+        depends on ARCH_QCOM || COMPILE_TEST
         select DMA_ENGINE
         select DMA_VIRTUAL_CHANNELS
         help
diff --git a/drivers/dma/ti/Kconfig b/drivers/dma/ti/Kconfig
index 2adc2cca10e9..8bd0b4739326 100644
--- a/drivers/dma/ti/Kconfig
+++ b/drivers/dma/ti/Kconfig
@@ -36,7 +36,7 @@ config DMA_OMAP
 
 config TI_K3_UDMA
 	tristate "Texas Instruments UDMA support"
-	depends on ARCH_K3
+	depends on ARCH_K3 || COMPILE_TEST
 	depends on TI_SCI_PROTOCOL
 	depends on TI_SCI_INTA_IRQCHIP
 	select DMA_ENGINE
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 6fb3768e3d71..866997123a1c 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -702,7 +702,7 @@ config INTEL_SOC_PMIC_MRFLD
 	  that is found on Intel Merrifield systems.
 
 config MFD_INTEL_LPSS
-	tristate
+	bool "MFD_INTEL_LPSS"
 	select COMMON_CLK
 	select MFD_CORE
 
-- 
2.43.0


