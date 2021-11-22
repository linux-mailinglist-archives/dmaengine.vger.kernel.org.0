Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5C054591B9
	for <lists+dmaengine@lfdr.de>; Mon, 22 Nov 2021 16:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240092AbhKVP5Q (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 22 Nov 2021 10:57:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240073AbhKVP5N (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 22 Nov 2021 10:57:13 -0500
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7854AC06174A
        for <dmaengine@vger.kernel.org>; Mon, 22 Nov 2021 07:54:06 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:e4da:38c:79e9:48bf])
        by baptiste.telenet-ops.be with bizsmtp
        id MTu6260024yPVd601Tu6vX; Mon, 22 Nov 2021 16:54:06 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mpBdt-00EL28-Nt; Mon, 22 Nov 2021 16:54:05 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mpBdt-00HGon-3o; Mon, 22 Nov 2021 16:54:05 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Vinod Koul <vkoul@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     dmaengine@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] dmaengine: stm32-mdma: Use bitfield helpers
Date:   Mon, 22 Nov 2021 16:54:04 +0100
Message-Id: <36ceab242a594233dc7dc6f1dddb4ac32d1e846f.1637593297.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <a1445d3abb45cfc95cb1b03180fd53caf122035b.1637593297.git.geert+renesas@glider.be>
References: <a1445d3abb45cfc95cb1b03180fd53caf122035b.1637593297.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Use the FIELD_{GET,PREP}() helpers, instead of defining custom macros
implementing the same operations.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Compile-tested only.

See "[PATCH 00/17] Non-const bitfield helper conversions"
(https://lore.kernel.org/r/cover.1637592133.git.geert+renesas@glider.be)
for background and more conversions.
---
 drivers/dma/stm32-mdma.c | 74 +++++++++++++---------------------------
 1 file changed, 23 insertions(+), 51 deletions(-)

diff --git a/drivers/dma/stm32-mdma.c b/drivers/dma/stm32-mdma.c
index d30a4a28d3bfd585..03ff64ff34bf594e 100644
--- a/drivers/dma/stm32-mdma.c
+++ b/drivers/dma/stm32-mdma.c
@@ -10,6 +10,7 @@
  * Inspired by stm32-dma.c and dma-jz4780.c
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/dmaengine.h>
@@ -32,13 +33,6 @@
 
 #include "virt-dma.h"
 
-/*  MDMA Generic getter/setter */
-#define STM32_MDMA_SHIFT(n)		(ffs(n) - 1)
-#define STM32_MDMA_SET(n, mask)		(((n) << STM32_MDMA_SHIFT(mask)) & \
-					 (mask))
-#define STM32_MDMA_GET(n, mask)		(((n) & (mask)) >> \
-					 STM32_MDMA_SHIFT(mask))
-
 #define STM32_MDMA_GISR0		0x0000 /* MDMA Int Status Reg 1 */
 #define STM32_MDMA_GISR1		0x0004 /* MDMA Int Status Reg 2 */
 
@@ -80,8 +74,7 @@
 #define STM32_MDMA_CCR_HEX		BIT(13)
 #define STM32_MDMA_CCR_BEX		BIT(12)
 #define STM32_MDMA_CCR_PL_MASK		GENMASK(7, 6)
-#define STM32_MDMA_CCR_PL(n)		STM32_MDMA_SET(n, \
-						       STM32_MDMA_CCR_PL_MASK)
+#define STM32_MDMA_CCR_PL(n)		FIELD_PREP(STM32_MDMA_CCR_PL_MASK, (n))
 #define STM32_MDMA_CCR_TCIE		BIT(5)
 #define STM32_MDMA_CCR_BTIE		BIT(4)
 #define STM32_MDMA_CCR_BRTIE		BIT(3)
@@ -99,48 +92,33 @@
 #define STM32_MDMA_CTCR_BWM		BIT(31)
 #define STM32_MDMA_CTCR_SWRM		BIT(30)
 #define STM32_MDMA_CTCR_TRGM_MSK	GENMASK(29, 28)
-#define STM32_MDMA_CTCR_TRGM(n)		STM32_MDMA_SET((n), \
-						       STM32_MDMA_CTCR_TRGM_MSK)
-#define STM32_MDMA_CTCR_TRGM_GET(n)	STM32_MDMA_GET((n), \
-						       STM32_MDMA_CTCR_TRGM_MSK)
+#define STM32_MDMA_CTCR_TRGM(n)		FIELD_PREP(STM32_MDMA_CTCR_TRGM_MSK, (n))
+#define STM32_MDMA_CTCR_TRGM_GET(n)	FIELD_GET(STM32_MDMA_CTCR_TRGM_MSK, (n))
 #define STM32_MDMA_CTCR_PAM_MASK	GENMASK(27, 26)
-#define STM32_MDMA_CTCR_PAM(n)		STM32_MDMA_SET(n, \
-						       STM32_MDMA_CTCR_PAM_MASK)
+#define STM32_MDMA_CTCR_PAM(n)		FIELD_PREP(STM32_MDMA_CTCR_PAM_MASK, (n))
 #define STM32_MDMA_CTCR_PKE		BIT(25)
 #define STM32_MDMA_CTCR_TLEN_MSK	GENMASK(24, 18)
-#define STM32_MDMA_CTCR_TLEN(n)		STM32_MDMA_SET((n), \
-						       STM32_MDMA_CTCR_TLEN_MSK)
-#define STM32_MDMA_CTCR_TLEN_GET(n)	STM32_MDMA_GET((n), \
-						       STM32_MDMA_CTCR_TLEN_MSK)
+#define STM32_MDMA_CTCR_TLEN(n)		FIELD_PREP(STM32_MDMA_CTCR_TLEN_MSK, (n))
+#define STM32_MDMA_CTCR_TLEN_GET(n)	FIELD_GET(STM32_MDMA_CTCR_TLEN_MSK, (n))
 #define STM32_MDMA_CTCR_LEN2_MSK	GENMASK(25, 18)
-#define STM32_MDMA_CTCR_LEN2(n)		STM32_MDMA_SET((n), \
-						       STM32_MDMA_CTCR_LEN2_MSK)
-#define STM32_MDMA_CTCR_LEN2_GET(n)	STM32_MDMA_GET((n), \
-						       STM32_MDMA_CTCR_LEN2_MSK)
+#define STM32_MDMA_CTCR_LEN2(n)		FIELD_PREP(STM32_MDMA_CTCR_LEN2_MSK, (n))
+#define STM32_MDMA_CTCR_LEN2_GET(n)	FIELD_GET(STM32_MDMA_CTCR_LEN2_MSK, (n))
 #define STM32_MDMA_CTCR_DBURST_MASK	GENMASK(17, 15)
-#define STM32_MDMA_CTCR_DBURST(n)	STM32_MDMA_SET(n, \
-						    STM32_MDMA_CTCR_DBURST_MASK)
+#define STM32_MDMA_CTCR_DBURST(n)	FIELD_PREP(STM32_MDMA_CTCR_DBURST_MASK, (n))
 #define STM32_MDMA_CTCR_SBURST_MASK	GENMASK(14, 12)
-#define STM32_MDMA_CTCR_SBURST(n)	STM32_MDMA_SET(n, \
-						    STM32_MDMA_CTCR_SBURST_MASK)
+#define STM32_MDMA_CTCR_SBURST(n)	FIELD_PREP(STM32_MDMA_CTCR_SBURST_MASK, (n))
 #define STM32_MDMA_CTCR_DINCOS_MASK	GENMASK(11, 10)
-#define STM32_MDMA_CTCR_DINCOS(n)	STM32_MDMA_SET((n), \
-						    STM32_MDMA_CTCR_DINCOS_MASK)
+#define STM32_MDMA_CTCR_DINCOS(n)	FIELD_PREP(STM32_MDMA_CTCR_DINCOS_MASK, (n))
 #define STM32_MDMA_CTCR_SINCOS_MASK	GENMASK(9, 8)
-#define STM32_MDMA_CTCR_SINCOS(n)	STM32_MDMA_SET((n), \
-						    STM32_MDMA_CTCR_SINCOS_MASK)
+#define STM32_MDMA_CTCR_SINCOS(n)	FIELD_PREP(STM32_MDMA_CTCR_SINCOS_MASK, (n))
 #define STM32_MDMA_CTCR_DSIZE_MASK	GENMASK(7, 6)
-#define STM32_MDMA_CTCR_DSIZE(n)	STM32_MDMA_SET(n, \
-						     STM32_MDMA_CTCR_DSIZE_MASK)
+#define STM32_MDMA_CTCR_DSIZE(n)	FIELD_PREP(STM32_MDMA_CTCR_DSIZE_MASK, (n))
 #define STM32_MDMA_CTCR_SSIZE_MASK	GENMASK(5, 4)
-#define STM32_MDMA_CTCR_SSIZE(n)	STM32_MDMA_SET(n, \
-						     STM32_MDMA_CTCR_SSIZE_MASK)
+#define STM32_MDMA_CTCR_SSIZE(n)	FIELD_PREP(STM32_MDMA_CTCR_SSIZE_MASK, (n))
 #define STM32_MDMA_CTCR_DINC_MASK	GENMASK(3, 2)
-#define STM32_MDMA_CTCR_DINC(n)		STM32_MDMA_SET((n), \
-						      STM32_MDMA_CTCR_DINC_MASK)
+#define STM32_MDMA_CTCR_DINC(n)		FIELD_PREP(STM32_MDMA_CTCR_DINC_MASK, (n))
 #define STM32_MDMA_CTCR_SINC_MASK	GENMASK(1, 0)
-#define STM32_MDMA_CTCR_SINC(n)		STM32_MDMA_SET((n), \
-						      STM32_MDMA_CTCR_SINC_MASK)
+#define STM32_MDMA_CTCR_SINC(n)		FIELD_PREP(STM32_MDMA_CTCR_SINC_MASK, (n))
 #define STM32_MDMA_CTCR_CFG_MASK	(STM32_MDMA_CTCR_SINC_MASK \
 					| STM32_MDMA_CTCR_DINC_MASK \
 					| STM32_MDMA_CTCR_SINCOS_MASK \
@@ -151,16 +129,13 @@
 /* MDMA Channel x block number of data register */
 #define STM32_MDMA_CBNDTR(x)		(0x54 + 0x40 * (x))
 #define STM32_MDMA_CBNDTR_BRC_MK	GENMASK(31, 20)
-#define STM32_MDMA_CBNDTR_BRC(n)	STM32_MDMA_SET(n, \
-						       STM32_MDMA_CBNDTR_BRC_MK)
-#define STM32_MDMA_CBNDTR_BRC_GET(n)	STM32_MDMA_GET((n), \
-						       STM32_MDMA_CBNDTR_BRC_MK)
+#define STM32_MDMA_CBNDTR_BRC(n)	FIELD_PREP(STM32_MDMA_CBNDTR_BRC_MK, (n))
+#define STM32_MDMA_CBNDTR_BRC_GET(n)	FIELD_GET(STM32_MDMA_CBNDTR_BRC_MK, (n))
 
 #define STM32_MDMA_CBNDTR_BRDUM		BIT(19)
 #define STM32_MDMA_CBNDTR_BRSUM		BIT(18)
 #define STM32_MDMA_CBNDTR_BNDT_MASK	GENMASK(16, 0)
-#define STM32_MDMA_CBNDTR_BNDT(n)	STM32_MDMA_SET(n, \
-						    STM32_MDMA_CBNDTR_BNDT_MASK)
+#define STM32_MDMA_CBNDTR_BNDT(n)	FIELD_PREP(STM32_MDMA_CBNDTR_BNDT_MASK, (n))
 
 /* MDMA Channel x source address register */
 #define STM32_MDMA_CSAR(x)		(0x58 + 0x40 * (x))
@@ -171,11 +146,9 @@
 /* MDMA Channel x block repeat address update register */
 #define STM32_MDMA_CBRUR(x)		(0x60 + 0x40 * (x))
 #define STM32_MDMA_CBRUR_DUV_MASK	GENMASK(31, 16)
-#define STM32_MDMA_CBRUR_DUV(n)		STM32_MDMA_SET(n, \
-						      STM32_MDMA_CBRUR_DUV_MASK)
+#define STM32_MDMA_CBRUR_DUV(n)		FIELD_PREP(STM32_MDMA_CBRUR_DUV_MASK, (n))
 #define STM32_MDMA_CBRUR_SUV_MASK	GENMASK(15, 0)
-#define STM32_MDMA_CBRUR_SUV(n)		STM32_MDMA_SET(n, \
-						      STM32_MDMA_CBRUR_SUV_MASK)
+#define STM32_MDMA_CBRUR_SUV(n)		FIELD_PREP(STM32_MDMA_CBRUR_SUV_MASK, (n))
 
 /* MDMA Channel x link address register */
 #define STM32_MDMA_CLAR(x)		(0x64 + 0x40 * (x))
@@ -185,8 +158,7 @@
 #define STM32_MDMA_CTBR_DBUS		BIT(17)
 #define STM32_MDMA_CTBR_SBUS		BIT(16)
 #define STM32_MDMA_CTBR_TSEL_MASK	GENMASK(7, 0)
-#define STM32_MDMA_CTBR_TSEL(n)		STM32_MDMA_SET(n, \
-						      STM32_MDMA_CTBR_TSEL_MASK)
+#define STM32_MDMA_CTBR_TSEL(n)		FIELD_PREP(STM32_MDMA_CTBR_TSEL_MASK, (n))
 
 /* MDMA Channel x mask address register */
 #define STM32_MDMA_CMAR(x)		(0x70 + 0x40 * (x))
-- 
2.25.1

