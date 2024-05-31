Return-Path: <dmaengine+bounces-2226-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1348D653B
	for <lists+dmaengine@lfdr.de>; Fri, 31 May 2024 17:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FF171F24631
	for <lists+dmaengine@lfdr.de>; Fri, 31 May 2024 15:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B199156F4D;
	Fri, 31 May 2024 15:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="AhGB3TIU"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4561F155C8E;
	Fri, 31 May 2024 15:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717168127; cv=none; b=MMQ40BAcTX/Y8X4viYhN/NQhnpFrC6gFK1Pogeb1+RWQ3eIwVzMTfos8R7Dwg4KE1AKFFRfEG54TyDo4uGXtN5RZMW0y61eVZIoJf2B+spl22ZyaNHBuaTewO51NomUa58TBy+ApQz8G6nPluXoRfu25H0O7bXWHY7qT6RA3qTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717168127; c=relaxed/simple;
	bh=i8hxV05JFB4duZ8FMO6pki84u/gAZBrqpfUbvJ2KXRA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KLQ0dh03ZDYoCkX4OOpdSWefh0U7Z6xVIfiTowag2g+8Fotx0dC7kDEbIICu/30o3EP1pBDwrRyF3/iIkJ2mdFApGLWcRiCvWTvJHkw8cJttWMFBUZKxZ7GzGKgQYKkwQYJJB8ggAdUoNQmZXwt13H52ZIBLCdke9Ou0pIrWF2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=AhGB3TIU; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44VC4HOM017545;
	Fri, 31 May 2024 17:08:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	ZEKykYB40nby5I/R7KEELp/CMw6HcoAC326EK9ryETA=; b=AhGB3TIUwJBCUq7D
	rpEAa10vt+3iNEZG7NZVrA+BKAWAGztRSRpk2C6SbRUxu6UfsZdE+OidtAfToIhA
	SxyaB/QWOpXfsX1LWOSlJUO0iyI6bcAM2NQrD5Oil122dG3eAvI+CJWVRr3bR5A0
	xaP1Z0Woi2w2JalLiVaEVfU/7Cjm8gFOMfP5HEVY/8x2iYXQ8WJa5vJLse35Jtv3
	0eHu7iYLsbmkxxETwgdy5aTnvN7bhi34xpT/FpdXbpcR0rDR9kBLo7YQr7I0c2Bk
	5Pieazd4je+di3868mgcMsq/BCKDYPOz0g0tsAD4IjlYMUIQQVgmMhBE8PHcw/lb
	EsVq2g==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ybsj134xf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 17:08:10 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id CF79A40049;
	Fri, 31 May 2024 17:08:05 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id BFF65223650;
	Fri, 31 May 2024 17:07:17 +0200 (CEST)
Received: from localhost (10.252.27.179) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 17:07:17 +0200
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre
 Torgue <alexandre.torgue@foss.st.com>
CC: <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>,
        Amelie Delaunay
	<amelie.delaunay@foss.st.com>
Subject: [PATCH v4 02/12] dmaengine: stm32: New directory for STM32 DMA controllers drivers
Date: Fri, 31 May 2024 17:07:02 +0200
Message-ID: <20240531150712.2503554-3-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240531150712.2503554-1-amelie.delaunay@foss.st.com>
References: <20240531150712.2503554-1-amelie.delaunay@foss.st.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-31_11,2024-05-30_01,2024-05-17_01

Gather the STM32 DMA controllers under drivers/dma/stm32/

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 drivers/dma/Kconfig                    | 34 ++---------------------
 drivers/dma/Makefile                   |  4 +--
 drivers/dma/stm32/Kconfig              | 37 ++++++++++++++++++++++++++
 drivers/dma/stm32/Makefile             |  4 +++
 drivers/dma/{ => stm32}/stm32-dma.c    |  2 +-
 drivers/dma/{ => stm32}/stm32-dmamux.c |  0
 drivers/dma/{ => stm32}/stm32-mdma.c   |  2 +-
 7 files changed, 46 insertions(+), 37 deletions(-)
 create mode 100644 drivers/dma/stm32/Kconfig
 create mode 100644 drivers/dma/stm32/Makefile
 rename drivers/dma/{ => stm32}/stm32-dma.c (99%)
 rename drivers/dma/{ => stm32}/stm32-dmamux.c (100%)
 rename drivers/dma/{ => stm32}/stm32-mdma.c (99%)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 002a5ec80620..32b4256ef874 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -568,38 +568,6 @@ config ST_FDMA
 	  Say Y here if you have such a chipset.
 	  If unsure, say N.
 
-config STM32_DMA
-	bool "STMicroelectronics STM32 DMA support"
-	depends on ARCH_STM32 || COMPILE_TEST
-	select DMA_ENGINE
-	select DMA_VIRTUAL_CHANNELS
-	help
-	  Enable support for the on-chip DMA controller on STMicroelectronics
-	  STM32 MCUs.
-	  If you have a board based on such a MCU and wish to use DMA say Y
-	  here.
-
-config STM32_DMAMUX
-	bool "STMicroelectronics STM32 dma multiplexer support"
-	depends on STM32_DMA || COMPILE_TEST
-	help
-	  Enable support for the on-chip DMA multiplexer on STMicroelectronics
-	  STM32 MCUs.
-	  If you have a board based on such a MCU and wish to use DMAMUX say Y
-	  here.
-
-config STM32_MDMA
-	bool "STMicroelectronics STM32 master dma support"
-	depends on ARCH_STM32 || COMPILE_TEST
-	depends on OF
-	select DMA_ENGINE
-	select DMA_VIRTUAL_CHANNELS
-	help
-	  Enable support for the on-chip MDMA controller on STMicroelectronics
-	  STM32 platforms.
-	  If you have a board based on STM32 SoC and wish to use the master DMA
-	  say Y here.
-
 config SPRD_DMA
 	tristate "Spreadtrum DMA support"
 	depends on ARCH_SPRD || COMPILE_TEST
@@ -772,6 +740,8 @@ source "drivers/dma/fsl-dpaa2-qdma/Kconfig"
 
 source "drivers/dma/lgm/Kconfig"
 
+source "drivers/dma/stm32/Kconfig"
+
 # clients
 comment "DMA Clients"
 	depends on DMA_ENGINE
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index 802ca916f05f..374ea98faf43 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -70,9 +70,6 @@ obj-$(CONFIG_PXA_DMA) += pxa_dma.o
 obj-$(CONFIG_RENESAS_DMA) += sh/
 obj-$(CONFIG_SF_PDMA) += sf-pdma/
 obj-$(CONFIG_STE_DMA40) += ste_dma40.o ste_dma40_ll.o
-obj-$(CONFIG_STM32_DMA) += stm32-dma.o
-obj-$(CONFIG_STM32_DMAMUX) += stm32-dmamux.o
-obj-$(CONFIG_STM32_MDMA) += stm32-mdma.o
 obj-$(CONFIG_SPRD_DMA) += sprd-dma.o
 obj-$(CONFIG_TXX9_DMAC) += txx9dmac.o
 obj-$(CONFIG_TEGRA186_GPC_DMA) += tegra186-gpc-dma.o
@@ -88,5 +85,6 @@ obj-$(CONFIG_INTEL_LDMA) += lgm/
 
 obj-y += mediatek/
 obj-y += qcom/
+obj-y += stm32/
 obj-y += ti/
 obj-y += xilinx/
diff --git a/drivers/dma/stm32/Kconfig b/drivers/dma/stm32/Kconfig
new file mode 100644
index 000000000000..b72ae1a4502f
--- /dev/null
+++ b/drivers/dma/stm32/Kconfig
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# STM32 DMA controllers drivers
+#
+if ARCH_STM32 || COMPILE_TEST
+
+config STM32_DMA
+	bool "STMicroelectronics STM32 DMA support"
+	select DMA_ENGINE
+	select DMA_VIRTUAL_CHANNELS
+	help
+	  Enable support for the on-chip DMA controller on STMicroelectronics
+	  STM32 platforms.
+	  If you have a board based on STM32 SoC with such DMA controller
+	  and want to use DMA say Y here.
+
+config STM32_DMAMUX
+	bool "STMicroelectronics STM32 DMA multiplexer support"
+	depends on STM32_DMA
+	help
+	  Enable support for the on-chip DMA multiplexer on STMicroelectronics
+	  STM32 platforms.
+	  If you have a board based on STM32 SoC with such DMA multiplexer
+	  and want to use DMAMUX say Y here.
+
+config STM32_MDMA
+	bool "STMicroelectronics STM32 master DMA support"
+	depends on OF
+	select DMA_ENGINE
+	select DMA_VIRTUAL_CHANNELS
+	help
+	  Enable support for the on-chip MDMA controller on STMicroelectronics
+	  STM32 platforms.
+	  If you have a board based on STM32 SoC with such DMA controller
+	  and want to use MDMA say Y here.
+
+endif
diff --git a/drivers/dma/stm32/Makefile b/drivers/dma/stm32/Makefile
new file mode 100644
index 000000000000..663a3896a881
--- /dev/null
+++ b/drivers/dma/stm32/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_STM32_DMA) += stm32-dma.o
+obj-$(CONFIG_STM32_DMAMUX) += stm32-dmamux.o
+obj-$(CONFIG_STM32_MDMA) += stm32-mdma.o
diff --git a/drivers/dma/stm32-dma.c b/drivers/dma/stm32/stm32-dma.c
similarity index 99%
rename from drivers/dma/stm32-dma.c
rename to drivers/dma/stm32/stm32-dma.c
index 90857d08a1a7..917f8e922373 100644
--- a/drivers/dma/stm32-dma.c
+++ b/drivers/dma/stm32/stm32-dma.c
@@ -28,7 +28,7 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 
-#include "virt-dma.h"
+#include "../virt-dma.h"
 
 #define STM32_DMA_LISR			0x0000 /* DMA Low Int Status Reg */
 #define STM32_DMA_HISR			0x0004 /* DMA High Int Status Reg */
diff --git a/drivers/dma/stm32-dmamux.c b/drivers/dma/stm32/stm32-dmamux.c
similarity index 100%
rename from drivers/dma/stm32-dmamux.c
rename to drivers/dma/stm32/stm32-dmamux.c
diff --git a/drivers/dma/stm32-mdma.c b/drivers/dma/stm32/stm32-mdma.c
similarity index 99%
rename from drivers/dma/stm32-mdma.c
rename to drivers/dma/stm32/stm32-mdma.c
index 6505081ced44..e6d525901de7 100644
--- a/drivers/dma/stm32-mdma.c
+++ b/drivers/dma/stm32/stm32-mdma.c
@@ -30,7 +30,7 @@
 #include <linux/reset.h>
 #include <linux/slab.h>
 
-#include "virt-dma.h"
+#include "../virt-dma.h"
 
 #define STM32_MDMA_GISR0		0x0000 /* MDMA Int Status Reg 1 */
 
-- 
2.25.1


