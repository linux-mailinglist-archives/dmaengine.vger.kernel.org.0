Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C374D3ADFDB
	for <lists+dmaengine@lfdr.de>; Sun, 20 Jun 2021 21:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbhFTTNX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 20 Jun 2021 15:13:23 -0400
Received: from mleia.com ([178.79.152.223]:39012 "EHLO mail.mleia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229875AbhFTTNX (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sun, 20 Jun 2021 15:13:23 -0400
Received: from mail.mleia.com (localhost [127.0.0.1])
        by mail.mleia.com (Postfix) with ESMTP id 7D868C58A;
        Sun, 20 Jun 2021 19:11:09 +0000 (UTC)
From:   Vladimir Zapolskiy <vz@mleia.com>
To:     Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] dmaengine: imx-sdma: Remove platform data header
Date:   Sun, 20 Jun 2021 22:11:03 +0300
Message-Id: <20210620191103.156626-1-vz@mleia.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20210620_191109_538142_ABD56746 
X-CRM114-Status: GOOD (  16.14  )
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Since commit 6c5f05a6cd88 ("ARM: imx3: Remove imx3 soc_init()")
there are no more users of struct sdma_script_start_addrs outside
of the driver itself, thus let's move the struct declaration just
to the driver source code and remove the header file as unused one.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 drivers/dma/imx-sdma.c                     | 56 +++++++++++++++++++-
 include/linux/platform_data/dma-imx-sdma.h | 60 ----------------------
 2 files changed, 55 insertions(+), 61 deletions(-)
 delete mode 100644 include/linux/platform_data/dma-imx-sdma.h

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index d5590c08db51..48390ea3c91f 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -35,7 +35,6 @@
 #include <linux/workqueue.h>
 
 #include <asm/irq.h>
-#include <linux/platform_data/dma-imx-sdma.h>
 #include <linux/platform_data/dma-imx.h>
 #include <linux/regmap.h>
 #include <linux/mfd/syscon.h>
@@ -181,6 +180,61 @@
 				 BIT(DMA_MEM_TO_DEV) | \
 				 BIT(DMA_DEV_TO_DEV))
 
+/**
+ * struct sdma_script_start_addrs - SDMA script start pointers
+ *
+ * start addresses of the different functions in the physical
+ * address space of the SDMA engine.
+ */
+struct sdma_script_start_addrs {
+	s32 ap_2_ap_addr;
+	s32 ap_2_bp_addr;
+	s32 ap_2_ap_fixed_addr;
+	s32 bp_2_ap_addr;
+	s32 loopback_on_dsp_side_addr;
+	s32 mcu_interrupt_only_addr;
+	s32 firi_2_per_addr;
+	s32 firi_2_mcu_addr;
+	s32 per_2_firi_addr;
+	s32 mcu_2_firi_addr;
+	s32 uart_2_per_addr;
+	s32 uart_2_mcu_addr;
+	s32 per_2_app_addr;
+	s32 mcu_2_app_addr;
+	s32 per_2_per_addr;
+	s32 uartsh_2_per_addr;
+	s32 uartsh_2_mcu_addr;
+	s32 per_2_shp_addr;
+	s32 mcu_2_shp_addr;
+	s32 ata_2_mcu_addr;
+	s32 mcu_2_ata_addr;
+	s32 app_2_per_addr;
+	s32 app_2_mcu_addr;
+	s32 shp_2_per_addr;
+	s32 shp_2_mcu_addr;
+	s32 mshc_2_mcu_addr;
+	s32 mcu_2_mshc_addr;
+	s32 spdif_2_mcu_addr;
+	s32 mcu_2_spdif_addr;
+	s32 asrc_2_mcu_addr;
+	s32 ext_mem_2_ipu_addr;
+	s32 descrambler_addr;
+	s32 dptc_dvfs_addr;
+	s32 utra_addr;
+	s32 ram_code_start_addr;
+	/* End of v1 array */
+	s32 mcu_2_ssish_addr;
+	s32 ssish_2_mcu_addr;
+	s32 hdmi_dma_addr;
+	/* End of v2 array */
+	s32 zcanfd_2_mcu_addr;
+	s32 zqspi_2_mcu_addr;
+	s32 mcu_2_ecspi_addr;
+	/* End of v3 array */
+	s32 mcu_2_zqspi_addr;
+	/* End of v4 array */
+};
+
 /*
  * Mode/Count of data node descriptors - IPCv2
  */
diff --git a/include/linux/platform_data/dma-imx-sdma.h b/include/linux/platform_data/dma-imx-sdma.h
deleted file mode 100644
index 725602d9df91..000000000000
--- a/include/linux/platform_data/dma-imx-sdma.h
+++ /dev/null
@@ -1,60 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __MACH_MXC_SDMA_H__
-#define __MACH_MXC_SDMA_H__
-
-/**
- * struct sdma_script_start_addrs - SDMA script start pointers
- *
- * start addresses of the different functions in the physical
- * address space of the SDMA engine.
- */
-struct sdma_script_start_addrs {
-	s32 ap_2_ap_addr;
-	s32 ap_2_bp_addr;
-	s32 ap_2_ap_fixed_addr;
-	s32 bp_2_ap_addr;
-	s32 loopback_on_dsp_side_addr;
-	s32 mcu_interrupt_only_addr;
-	s32 firi_2_per_addr;
-	s32 firi_2_mcu_addr;
-	s32 per_2_firi_addr;
-	s32 mcu_2_firi_addr;
-	s32 uart_2_per_addr;
-	s32 uart_2_mcu_addr;
-	s32 per_2_app_addr;
-	s32 mcu_2_app_addr;
-	s32 per_2_per_addr;
-	s32 uartsh_2_per_addr;
-	s32 uartsh_2_mcu_addr;
-	s32 per_2_shp_addr;
-	s32 mcu_2_shp_addr;
-	s32 ata_2_mcu_addr;
-	s32 mcu_2_ata_addr;
-	s32 app_2_per_addr;
-	s32 app_2_mcu_addr;
-	s32 shp_2_per_addr;
-	s32 shp_2_mcu_addr;
-	s32 mshc_2_mcu_addr;
-	s32 mcu_2_mshc_addr;
-	s32 spdif_2_mcu_addr;
-	s32 mcu_2_spdif_addr;
-	s32 asrc_2_mcu_addr;
-	s32 ext_mem_2_ipu_addr;
-	s32 descrambler_addr;
-	s32 dptc_dvfs_addr;
-	s32 utra_addr;
-	s32 ram_code_start_addr;
-	/* End of v1 array */
-	s32 mcu_2_ssish_addr;
-	s32 ssish_2_mcu_addr;
-	s32 hdmi_dma_addr;
-	/* End of v2 array */
-	s32 zcanfd_2_mcu_addr;
-	s32 zqspi_2_mcu_addr;
-	s32 mcu_2_ecspi_addr;
-	/* End of v3 array */
-	s32 mcu_2_zqspi_addr;
-	/* End of v4 array */
-};
-
-#endif /* __MACH_MXC_SDMA_H__ */
-- 
2.24.0

