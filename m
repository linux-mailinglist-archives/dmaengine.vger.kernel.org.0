Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 012A22E6BA6
	for <lists+dmaengine@lfdr.de>; Tue, 29 Dec 2020 00:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730768AbgL1Wzy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 28 Dec 2020 17:55:54 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:41407 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729423AbgL1UbG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 28 Dec 2020 15:31:06 -0500
X-Originating-IP: 86.202.109.140
Received: from localhost (lfbn-lyo-1-13-140.w86-202.abo.wanadoo.fr [86.202.109.140])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id B82C6E0005;
        Mon, 28 Dec 2020 20:30:23 +0000 (UTC)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dmaengine@vger.kernel.org
Subject: [PATCH] dmaengine: at_hdmac: remove platform data header
Date:   Mon, 28 Dec 2020 21:30:21 +0100
Message-Id: <20201228203022.2674133-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

linux/platform_data/dma-atmel.h is only used by the at_hdmac driver. Move
the CFG bits definitions back in at_hdmac_regs.h and the remaining
definitions in the driver.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 MAINTAINERS                             |  1 -
 drivers/dma/at_hdmac.c                  | 19 ++++++++
 drivers/dma/at_hdmac_regs.h             | 28 ++++++++++--
 include/linux/platform_data/dma-atmel.h | 61 -------------------------
 4 files changed, 44 insertions(+), 65 deletions(-)
 delete mode 100644 include/linux/platform_data/dma-atmel.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 546aa66428c9..0d62310a31f8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11604,7 +11604,6 @@ F:	drivers/dma/at_hdmac.c
 F:	drivers/dma/at_hdmac_regs.h
 F:	drivers/dma/at_xdmac.c
 F:	include/dt-bindings/dma/at91.h
-F:	include/linux/platform_data/dma-atmel.h
 
 MICROCHIP AT91 SERIAL DRIVER
 M:	Richard Genoud <richard.genoud@gmail.com>
diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index 7eaee5b705b1..30ae36124b1d 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -54,6 +54,25 @@ module_param(init_nr_desc_per_channel, uint, 0644);
 MODULE_PARM_DESC(init_nr_desc_per_channel,
 		 "initial descriptors per channel (default: 64)");
 
+/**
+ * struct at_dma_platform_data - Controller configuration parameters
+ * @nr_channels: Number of channels supported by hardware (max 8)
+ * @cap_mask: dma_capability flags supported by the platform
+ */
+struct at_dma_platform_data {
+	unsigned int	nr_channels;
+	dma_cap_mask_t  cap_mask;
+};
+
+/**
+ * struct at_dma_slave - Controller-specific information about a slave
+ * @dma_dev: required DMA master device
+ * @cfg: Platform-specific initializer for the CFG register
+ */
+struct at_dma_slave {
+	struct device		*dma_dev;
+	u32			cfg;
+};
 
 /* prototypes */
 static dma_cookie_t atc_tx_submit(struct dma_async_tx_descriptor *tx);
diff --git a/drivers/dma/at_hdmac_regs.h b/drivers/dma/at_hdmac_regs.h
index 80fc2fe8c77e..4d1ebc040031 100644
--- a/drivers/dma/at_hdmac_regs.h
+++ b/drivers/dma/at_hdmac_regs.h
@@ -7,8 +7,6 @@
 #ifndef AT_HDMAC_REGS_H
 #define	AT_HDMAC_REGS_H
 
-#include <linux/platform_data/dma-atmel.h>
-
 #define	AT_DMA_MAX_NR_CHANNELS	8
 
 
@@ -148,7 +146,31 @@
 #define	ATC_AUTO		(0x1 << 31)	/* Auto multiple buffer tx enable */
 
 /* Bitfields in CFG */
-/* are in at_hdmac.h */
+#define ATC_PER_MSB(h)	((0x30U & (h)) >> 4)	/* Extract most significant bits of a handshaking identifier */
+
+#define	ATC_SRC_PER(h)		(0xFU & (h))	/* Channel src rq associated with periph handshaking ifc h */
+#define	ATC_DST_PER(h)		((0xFU & (h)) <<  4)	/* Channel dst rq associated with periph handshaking ifc h */
+#define	ATC_SRC_REP		(0x1 <<  8)	/* Source Replay Mod */
+#define	ATC_SRC_H2SEL		(0x1 <<  9)	/* Source Handshaking Mod */
+#define		ATC_SRC_H2SEL_SW	(0x0 <<  9)
+#define		ATC_SRC_H2SEL_HW	(0x1 <<  9)
+#define	ATC_SRC_PER_MSB(h)	(ATC_PER_MSB(h) << 10)	/* Channel src rq (most significant bits) */
+#define	ATC_DST_REP		(0x1 << 12)	/* Destination Replay Mod */
+#define	ATC_DST_H2SEL		(0x1 << 13)	/* Destination Handshaking Mod */
+#define		ATC_DST_H2SEL_SW	(0x0 << 13)
+#define		ATC_DST_H2SEL_HW	(0x1 << 13)
+#define	ATC_DST_PER_MSB(h)	(ATC_PER_MSB(h) << 14)	/* Channel dst rq (most significant bits) */
+#define	ATC_SOD			(0x1 << 16)	/* Stop On Done */
+#define	ATC_LOCK_IF		(0x1 << 20)	/* Interface Lock */
+#define	ATC_LOCK_B		(0x1 << 21)	/* AHB Bus Lock */
+#define	ATC_LOCK_IF_L		(0x1 << 22)	/* Master Interface Arbiter Lock */
+#define		ATC_LOCK_IF_L_CHUNK	(0x0 << 22)
+#define		ATC_LOCK_IF_L_BUFFER	(0x1 << 22)
+#define	ATC_AHB_PROT_MASK	(0x7 << 24)	/* AHB Protection */
+#define	ATC_FIFOCFG_MASK	(0x3 << 28)	/* FIFO Request Configuration */
+#define		ATC_FIFOCFG_LARGESTBURST	(0x0 << 28)
+#define		ATC_FIFOCFG_HALFFIFO		(0x1 << 28)
+#define		ATC_FIFOCFG_ENOUGHSPACE		(0x2 << 28)
 
 /* Bitfields in SPIP */
 #define	ATC_SPIP_HOLE(x)	(0xFFFFU & (x))
diff --git a/include/linux/platform_data/dma-atmel.h b/include/linux/platform_data/dma-atmel.h
deleted file mode 100644
index 069637e6004f..000000000000
--- a/include/linux/platform_data/dma-atmel.h
+++ /dev/null
@@ -1,61 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Header file for the Atmel AHB DMA Controller driver
- *
- * Copyright (C) 2008 Atmel Corporation
- */
-#ifndef AT_HDMAC_H
-#define AT_HDMAC_H
-
-#include <linux/dmaengine.h>
-
-/**
- * struct at_dma_platform_data - Controller configuration parameters
- * @nr_channels: Number of channels supported by hardware (max 8)
- * @cap_mask: dma_capability flags supported by the platform
- */
-struct at_dma_platform_data {
-	unsigned int	nr_channels;
-	dma_cap_mask_t  cap_mask;
-};
-
-/**
- * struct at_dma_slave - Controller-specific information about a slave
- * @dma_dev: required DMA master device
- * @cfg: Platform-specific initializer for the CFG register
- */
-struct at_dma_slave {
-	struct device		*dma_dev;
-	u32			cfg;
-};
-
-
-/* Platform-configurable bits in CFG */
-#define ATC_PER_MSB(h)	((0x30U & (h)) >> 4)	/* Extract most significant bits of a handshaking identifier */
-
-#define	ATC_SRC_PER(h)		(0xFU & (h))	/* Channel src rq associated with periph handshaking ifc h */
-#define	ATC_DST_PER(h)		((0xFU & (h)) <<  4)	/* Channel dst rq associated with periph handshaking ifc h */
-#define	ATC_SRC_REP		(0x1 <<  8)	/* Source Replay Mod */
-#define	ATC_SRC_H2SEL		(0x1 <<  9)	/* Source Handshaking Mod */
-#define		ATC_SRC_H2SEL_SW	(0x0 <<  9)
-#define		ATC_SRC_H2SEL_HW	(0x1 <<  9)
-#define	ATC_SRC_PER_MSB(h)	(ATC_PER_MSB(h) << 10)	/* Channel src rq (most significant bits) */
-#define	ATC_DST_REP		(0x1 << 12)	/* Destination Replay Mod */
-#define	ATC_DST_H2SEL		(0x1 << 13)	/* Destination Handshaking Mod */
-#define		ATC_DST_H2SEL_SW	(0x0 << 13)
-#define		ATC_DST_H2SEL_HW	(0x1 << 13)
-#define	ATC_DST_PER_MSB(h)	(ATC_PER_MSB(h) << 14)	/* Channel dst rq (most significant bits) */
-#define	ATC_SOD			(0x1 << 16)	/* Stop On Done */
-#define	ATC_LOCK_IF		(0x1 << 20)	/* Interface Lock */
-#define	ATC_LOCK_B		(0x1 << 21)	/* AHB Bus Lock */
-#define	ATC_LOCK_IF_L		(0x1 << 22)	/* Master Interface Arbiter Lock */
-#define		ATC_LOCK_IF_L_CHUNK	(0x0 << 22)
-#define		ATC_LOCK_IF_L_BUFFER	(0x1 << 22)
-#define	ATC_AHB_PROT_MASK	(0x7 << 24)	/* AHB Protection */
-#define	ATC_FIFOCFG_MASK	(0x3 << 28)	/* FIFO Request Configuration */
-#define		ATC_FIFOCFG_LARGESTBURST	(0x0 << 28)
-#define		ATC_FIFOCFG_HALFFIFO		(0x1 << 28)
-#define		ATC_FIFOCFG_ENOUGHSPACE		(0x2 << 28)
-
-
-#endif /* AT_HDMAC_H */
-- 
2.29.2

