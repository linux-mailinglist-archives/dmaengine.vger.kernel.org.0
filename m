Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5153268D24
	for <lists+dmaengine@lfdr.de>; Mon, 14 Sep 2020 16:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgINOMx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 14 Sep 2020 10:12:53 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:6871 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbgINOKg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 14 Sep 2020 10:10:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1600092636; x=1631628636;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GDtWNy+1+8dO3cpS3XKMQB+I0oBFyD9met/Amvo/jek=;
  b=O3LaUZYn3Ikjafa4j0fmyvIo8CGW6tB1EQgaAzVU4sNGSknLfRCxM8K1
   eqzl66Pxzb+OJ+2edbBt/RHA8Y87b80InFKveFjj5/MD5RU9UDuhGIbRV
   6SIoKesITFBpMtbY7PsLCoA6pbwUzbkA7nJ8AZjyX5vj5GMQIyIRkEPkF
   b4W6dBU36AtwD2/8Q0e0xA1xYlpjd9Y67YrkTt/NIVVsHXNdFfyVifJ5c
   obQfqgbe1vL/ozDTPC0PRBtXos0LkAwHkDGb1Yu52tzLW5UkGlgSRb+sA
   2Ph+NYBIK0+oD44DwPQfXezCbepoImB8iPJFkRIDpyjMnP04KRK1GhnEd
   A==;
IronPort-SDR: /7xip98nvSlOkhfbD+4LyobSyZjGN7uGnpeahPrDwiaUNX0ZUnzqlvQHsoI/ASFDsPFIrJLtkt
 gjkiTvVrCmAQiuGrHyMR4DwPHYkuywQ7aIvnVx38IWCCM7rcf5CTPeLhfFwstTLSRvCmQ9sKwE
 msdeQ10obqzBmCUp25zB+NYpIGHNEhPaL+mvvlvGVuBdnFND8oWppk77OEB7rKDbjQPPm56Weu
 YFH2YOt5UWkJri+/egPpVLFRAZFP+FdHjIR7wSH0hywg6TrKqCCO7r7cJXx6UNn/xenwXy0lc7
 fQ8=
X-IronPort-AV: E=Sophos;i="5.76,426,1592895600"; 
   d="scan'208";a="88993972"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Sep 2020 07:10:35 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 14 Sep 2020 07:10:32 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Mon, 14 Sep 2020 07:10:28 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>,
        <tudor.ambarus@microchip.com>, <ludovic.desroches@microchip.com>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <nicolas.ferre@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH 7/7] dmaengine: at_xdmac: add AXI priority support and recommended settings
Date:   Mon, 14 Sep 2020 17:09:56 +0300
Message-ID: <20200914140956.221432-8-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200914140956.221432-1-eugen.hristev@microchip.com>
References: <20200914140956.221432-1-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The sama7g5 version of the XDMAC supports priority configuration and
outstanding capabilities.
Add defines for the specific registers for this configuration, together
with recommended settings.
However the settings are very different if the XDMAC is a mem2mem or a
per2mem controller.
Thus, we need to differentiate according to device tree property.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 drivers/dma/at_xdmac.c      | 25 +++++++++++++++++++++++++
 drivers/dma/at_xdmac_regs.h | 16 ++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index 874484a4e79f..8ea5558e127d 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -57,6 +57,8 @@ struct at_xdmac_layout {
 	u8				chan_cc_reg_base;
 	/* Source/Destination Interface must be specified or not */
 	bool				sdif;
+	/* AXI queue priority configuration supported */
+	bool				axi_config;
 };
 
 /* ----- Channels ----- */
@@ -135,6 +137,7 @@ static struct at_xdmac_layout at_xdmac_sama5d4_layout = {
 	.gswf = 0x40,
 	.chan_cc_reg_base = 0x50,
 	.sdif = true,
+	.axi_config = false,
 };
 
 static struct at_xdmac_layout at_xdmac_sama7g5_layout = {
@@ -147,6 +150,7 @@ static struct at_xdmac_layout at_xdmac_sama7g5_layout = {
 	.gswf = 0x50,
 	.chan_cc_reg_base = 0x60,
 	.sdif = false,
+	.axi_config = true,
 };
 
 static inline void __iomem *at_xdmac_chan_reg_base(struct at_xdmac *atxdmac, unsigned int chan_nb)
@@ -1863,6 +1867,25 @@ static int atmel_xdmac_resume(struct device *dev)
 }
 #endif /* CONFIG_PM_SLEEP */
 
+static void at_xdmac_axi_config(struct platform_device *pdev)
+{
+	struct at_xdmac	*atxdmac = (struct at_xdmac *)platform_get_drvdata(pdev);
+	bool dev_m2m;
+
+	if (!atxdmac->layout->axi_config)
+		return; /* Not supported */
+
+	dev_m2m = of_property_read_bool(pdev->dev.of_node, "microchip,m2m");
+
+	if (dev_m2m) {
+		at_xdmac_write(atxdmac, AT_XDMAC_GCFG, AT_XDMAC_GCFG_M2M);
+		at_xdmac_write(atxdmac, AT_XDMAC_GWAC, AT_XDMAC_GWAC_M2M);
+	} else {
+		at_xdmac_write(atxdmac, AT_XDMAC_GCFG, AT_XDMAC_GCFG_P2M);
+		at_xdmac_write(atxdmac, AT_XDMAC_GWAC, AT_XDMAC_GWAC_P2M);
+	}
+}
+
 static int at_xdmac_probe(struct platform_device *pdev)
 {
 	struct at_xdmac	*atxdmac;
@@ -2008,6 +2031,8 @@ static int at_xdmac_probe(struct platform_device *pdev)
 	dev_info(&pdev->dev, "%d channels, mapped at 0x%p\n",
 		 nr_channels, atxdmac->regs);
 
+	at_xdmac_axi_config(pdev);
+
 	return 0;
 
 err_dma_unregister:
diff --git a/drivers/dma/at_xdmac_regs.h b/drivers/dma/at_xdmac_regs.h
index 7b4b4e24de70..e5a58f6194aa 100644
--- a/drivers/dma/at_xdmac_regs.h
+++ b/drivers/dma/at_xdmac_regs.h
@@ -14,7 +14,23 @@
 #define		AT_XDMAC_FIFO_SZ(i)	(((i) >> 5) & 0x7FF)		/* Number of Bytes */
 #define		AT_XDMAC_NB_REQ(i)	((((i) >> 16) & 0x3F) + 1)	/* Number of Peripheral Requests Minus One */
 #define AT_XDMAC_GCFG		0x04	/* Global Configuration Register */
+#define		AT_XDMAC_WRHP(i)	(((i) & 0xF) << 4)
+#define		AT_XDMAC_WRMP(i)	(((i) & 0xF) << 8)
+#define		AT_XDMAC_WRLP(i)	(((i) & 0xF) << 12)
+#define		AT_XDMAC_RDHP(i)	(((i) & 0xF) << 16)
+#define		AT_XDMAC_RDMP(i)	(((i) & 0xF) << 20)
+#define		AT_XDMAC_RDLP(i)	(((i) & 0xF) << 24)
+#define		AT_XDMAC_RDSG(i)	(((i) & 0xF) << 28)
+#define AT_XDMAC_GCFG_M2M	(AT_XDMAC_RDLP(0xF) | AT_XDMAC_WRLP(0xF))
+#define AT_XDMAC_GCFG_P2M	(AT_XDMAC_RDSG(0x1) | AT_XDMAC_RDHP(0x3) | \
+				AT_XDMAC_WRHP(0x5))
 #define AT_XDMAC_GWAC		0x08	/* Global Weighted Arbiter Configuration Register */
+#define		AT_XDMAC_PW0(i)		(((i) & 0xF) << 0)
+#define		AT_XDMAC_PW1(i)		(((i) & 0xF) << 4)
+#define		AT_XDMAC_PW2(i)		(((i) & 0xF) << 8)
+#define		AT_XDMAC_PW3(i)		(((i) & 0xF) << 12)
+#define AT_XDMAC_GWAC_M2M	0
+#define AT_XDMAC_GWAC_P2M	(AT_XDMAC_PW0(0xF) | AT_XDMAC_PW2(0xF))
 #define AT_XDMAC_GIE		0x0C	/* Global Interrupt Enable Register */
 #define AT_XDMAC_GID		0x10	/* Global Interrupt Disable Register */
 #define AT_XDMAC_GIM		0x14	/* Global Interrupt Mask Register */
-- 
2.25.1

