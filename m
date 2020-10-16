Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E207D290237
	for <lists+dmaengine@lfdr.de>; Fri, 16 Oct 2020 11:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394309AbgJPJuO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 16 Oct 2020 05:50:14 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:51750 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389928AbgJPJuO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 16 Oct 2020 05:50:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1602841813; x=1634377813;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cwuFRVPEgnDmB/74qh87kydQpX0yxhSulI7Bq85/FhI=;
  b=RGWaMi1NIM+2NcKrGTCoy+9mnPdGYrOxrZAMeo2A1VrQd64PSlnN6emL
   PVlyT9BLL/XmIoQyIoD0kj/LY6/XULdqy9aeu777773Zx7d5zpsFPZbmP
   Qg5maB1OX+Ur01QDWpKn61tqQtpl4WKff0tMbsbI1GguScjf2LYvYe04v
   kac3F+lmbgrG3xjOgIwUfbvAEmCU/RUmFTGdqVjTnodgt+DLpJYL0vLW8
   DvdLTMZ1ijm0QM5Mcn1Fyg9nE5R0xMLkCjAe5U4KZ5nrfQvjTLj/lNyK5
   BUuY2m8mS35pbzv5CF9BaFZaZa9eg4npO8anyqlkwyfLcXfqRBzDUbgMO
   w==;
IronPort-SDR: LcxvTX4osntWQZD9fR+pvVnHwjbZzuuYv5udmw/9J9BfEZNCIXFdUotag2uLIjcF9Np+EsiwR1
 dzy6vGzwRA/f40iKGiKmvxxYTmzHf2GK/OXJ41KEDwTpzdyCC6Gnwvvi/+0sWKa10HAM+GPcNU
 moURTzvUWSL8fVSitY/5JRUn91xYrXYzaiGygWI5FaOu84qohJKHX5P3YmGgOzhyynhGZ39AA+
 WG5ui5z+WAF1xDWGO5OtPxcyyx28u6d6W7vJvoFyl1InktQsVJn4UVmk6eyKNvXGqolZN8vosb
 jbA=
X-IronPort-AV: E=Sophos;i="5.77,382,1596524400"; 
   d="scan'208";a="94860492"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Oct 2020 02:50:13 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 16 Oct 2020 02:39:24 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Fri, 16 Oct 2020 02:39:20 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>
CC:     <nicolas.ferre@microchip.com>, <tudor.ambarus@microchip.com>,
        <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Eugen Hristev" <eugen.hristev@microchip.com>
Subject: [PATCH v2 4/4] dmaengine: at_xdmac: add AXI priority support and recommended settings
Date:   Fri, 16 Oct 2020 12:39:18 +0300
Message-ID: <20201016093918.290137-1-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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
Changes in v2:
- changed from specific binding to use of dma-request binding as suggested


 drivers/dma/at_xdmac.c | 47 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index bfbf6375c293..cdc795a9c576 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -30,7 +30,24 @@
 #define		AT_XDMAC_FIFO_SZ(i)	(((i) >> 5) & 0x7FF)		/* Number of Bytes */
 #define		AT_XDMAC_NB_REQ(i)	((((i) >> 16) & 0x3F) + 1)	/* Number of Peripheral Requests Minus One */
 #define AT_XDMAC_GCFG		0x04	/* Global Configuration Register */
+#define		AT_XDMAC_WRHP(i)		(((i) & 0xF) << 4)
+#define		AT_XDMAC_WRMP(i)		(((i) & 0xF) << 8)
+#define		AT_XDMAC_WRLP(i)		(((i) & 0xF) << 12)
+#define		AT_XDMAC_RDHP(i)		(((i) & 0xF) << 16)
+#define		AT_XDMAC_RDMP(i)		(((i) & 0xF) << 20)
+#define		AT_XDMAC_RDLP(i)		(((i) & 0xF) << 24)
+#define		AT_XDMAC_RDSG(i)		(((i) & 0xF) << 28)
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
+
 #define AT_XDMAC_GIE		0x0C	/* Global Interrupt Enable Register */
 #define AT_XDMAC_GID		0x10	/* Global Interrupt Disable Register */
 #define AT_XDMAC_GIM		0x14	/* Global Interrupt Mask Register */
@@ -189,6 +206,8 @@ struct at_xdmac_layout {
 	u8				chan_cc_reg_base;
 	/* Source/Destination Interface must be specified or not */
 	bool				sdif;
+	/* AXI queue priority configuration supported */
+	bool				axi_config;
 };
 
 /* ----- Channels ----- */
@@ -267,6 +286,7 @@ static const struct at_xdmac_layout at_xdmac_sama5d4_layout = {
 	.gswf = 0x40,
 	.chan_cc_reg_base = 0x50,
 	.sdif = true,
+	.axi_config = false,
 };
 
 static const struct at_xdmac_layout at_xdmac_sama7g5_layout = {
@@ -279,6 +299,7 @@ static const struct at_xdmac_layout at_xdmac_sama7g5_layout = {
 	.gswf = 0x50,
 	.chan_cc_reg_base = 0x60,
 	.sdif = false,
+	.axi_config = true,
 };
 
 static inline void __iomem *at_xdmac_chan_reg_base(struct at_xdmac *atxdmac, unsigned int chan_nb)
@@ -1997,6 +2018,30 @@ static int atmel_xdmac_resume(struct device *dev)
 }
 #endif /* CONFIG_PM_SLEEP */
 
+static void at_xdmac_axi_config(struct platform_device *pdev)
+{
+	struct at_xdmac	*atxdmac = (struct at_xdmac *)platform_get_drvdata(pdev);
+	bool dev_m2m = false;
+	u32 dma_requests;
+
+	if (!atxdmac->layout->axi_config)
+		return; /* Not supported */
+
+	if (!of_property_read_u32(pdev->dev.of_node, "dma-requests",
+				  &dma_requests)) {
+		dev_info(&pdev->dev, "controller in mem2mem mode.\n");
+		dev_m2m = true;
+	}
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
@@ -2142,6 +2187,8 @@ static int at_xdmac_probe(struct platform_device *pdev)
 	dev_info(&pdev->dev, "%d channels, mapped at 0x%p\n",
 		 nr_channels, atxdmac->regs);
 
+	at_xdmac_axi_config(pdev);
+
 	return 0;
 
 err_dma_unregister:
-- 
2.25.1

