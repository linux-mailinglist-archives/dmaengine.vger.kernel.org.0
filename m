Return-Path: <dmaengine+bounces-2088-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26AE58CA024
	for <lists+dmaengine@lfdr.de>; Mon, 20 May 2024 17:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8DD61F21C2E
	for <lists+dmaengine@lfdr.de>; Mon, 20 May 2024 15:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3DF13790A;
	Mon, 20 May 2024 15:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="vVc+wvoO"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D3B4C66;
	Mon, 20 May 2024 15:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716220262; cv=none; b=r8uqpr+GWlPhmpI9Umej9KuvupmdtH7PQn1JkdkkAKZkpI4oLKzPOfQ6v3XgUcM9v+z0kHpL9RNenBPfiMEXFHGdc1ksQ/c7g27U8sjdUw34u88YvomHKV30FmAHb9G12bjFJdsOXoh7vwyK/2CRdAxDxcbz1IPbUrEa9WO+1SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716220262; c=relaxed/simple;
	bh=i8hxV05JFB4duZ8FMO6pki84u/gAZBrqpfUbvJ2KXRA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lOPnrNHC9dWAYu1XLtxBLfgxMj4TWpUWbeMXSsQD/P1x1RatxsENVLNbhV9QEDqYJsfJ49h4BeexhJMM5N0hDYCmnWzhEjE6MAw+kFq4H3TSlMz2ouO/KZUWWBLCVMIsEm4geRYqibJ/Y9oXhkla6ExJlqJS+GEXyWNkn0x1L/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=vVc+wvoO; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44KEFpPd001175;
	Mon, 20 May 2024 17:50:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	selector1; bh=ZEKykYB40nby5I/R7KEELp/CMw6HcoAC326EK9ryETA=; b=vV
	c+wvoO/qxYvfFcDiAMgCaKDX85wslWleamwR6G52jDBSzuEusmVAHDofgPAbQd39
	DGyXUzwp0gloxqcOARLC7JJl7znGopXuqZJ+SjiOSvmZS7fB9cdStxGypuzf3bSU
	jv6TqfCay0/9R+tJW/i6zbsUzW5f9R0SYTBeiQqDKDB6+GTPmJRFbfqfPbyLLKoS
	ImwZrcOIffphq8+f7RZfuvBF9tZI6iOnEvmYOwznxiUNFuDFJY64D7sWblJ5ftMJ
	7TmIztCv4W4zWWLZBdelg5pccv3cfTLaFiOoj3hAQCC7bSoSYwf33g68/9CcGy6z
	iQmVFFikB5wmJgLaFpQw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3y75w05yk6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 May 2024 17:50:43 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 05EFF40046;
	Mon, 20 May 2024 17:50:39 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 31DE3226FBD;
	Mon, 20 May 2024 17:49:54 +0200 (CEST)
Received: from localhost (10.252.8.132) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 20 May
 2024 17:49:53 +0200
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
Subject: [PATCH v3 02/12] dmaengine: stm32: New directory for STM32 DMA controllers drivers
Date: Mon, 20 May 2024 17:49:38 +0200
Message-ID: <20240520154948.690697-3-amelie.delaunay@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240520154948.690697-1-amelie.delaunay@foss.st.com>
References: <20240520154948.690697-1-amelie.delaunay@foss.st.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-20_09,2024-05-17_03,2024-05-17_01

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


