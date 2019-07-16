Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6116A3CA
	for <lists+dmaengine@lfdr.de>; Tue, 16 Jul 2019 10:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbfGPI0N (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 16 Jul 2019 04:26:13 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37938 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727862AbfGPI0M (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 16 Jul 2019 04:26:12 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x6G8Q0of074214;
        Tue, 16 Jul 2019 03:26:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1563265560;
        bh=t+Qlr1SoRNQmbucrnseL/C40XiGOQTaRa+VSXOPP/Fo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=TnOWfb0krGedRaVZXpsyZneBtXoPv8RPUIu7bGn/Ac19/A1PrHGcwjfgyZqeLo3Y8
         cbHf7M9W3oguw7q6b3zDJ2zgnI9zHBojzI+wCKZBkg5faxOsGRBecS4eB0vdOZE+Xv
         nOs0A46WqXeXf/IK/pwHDy03bDk3ZogQjG08HcVM=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x6G8Q0oF053474
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 16 Jul 2019 03:26:00 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 16
 Jul 2019 03:25:59 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 16 Jul 2019 03:25:59 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x6G8PuBo103858;
        Tue, 16 Jul 2019 03:25:58 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-omap@vger.kernel.org>
Subject: [PATCH v5 1/3] dmaengine: ti: edma: Clean up the 2x32bit array register accesses
Date:   Tue, 16 Jul 2019 11:26:53 +0300
Message-ID: <20190716082655.1620-2-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190716082655.1620-1-peter.ujfalusi@ti.com>
References: <20190716082655.1620-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Introduce defines for getting the array index and the bit number within the
64bit array register pairs.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/ti/edma.c | 106 ++++++++++++++++++++++++------------------
 1 file changed, 61 insertions(+), 45 deletions(-)

diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
index ceabdea40ae0..a39f817b3888 100644
--- a/drivers/dma/ti/edma.c
+++ b/drivers/dma/ti/edma.c
@@ -133,6 +133,17 @@
 #define EDMA_CONT_PARAMS_FIXED_EXACT	 1002
 #define EDMA_CONT_PARAMS_FIXED_NOT_EXACT 1003
 
+/*
+ * 64bit array registers are split into two 32bit registers:
+ * reg0: channel/event 0-31
+ * reg1: channel/event 32-63
+ *
+ * bit 5 in the channel number tells the array index (0/1)
+ * bit 0-4 (0x1f) is the bit offset within the register
+ */
+#define EDMA_REG_ARRAY_INDEX(channel)	((channel) >> 5)
+#define EDMA_CHANNEL_BIT(channel)	(BIT((channel) & 0x1f))
+
 /* PaRAM slots are laid out like this */
 struct edmacc_param {
 	u32 opt;
@@ -441,15 +452,14 @@ static void edma_setup_interrupt(struct edma_chan *echan, bool enable)
 {
 	struct edma_cc *ecc = echan->ecc;
 	int channel = EDMA_CHAN_SLOT(echan->ch_num);
+	int idx = EDMA_REG_ARRAY_INDEX(channel);
+	int ch_bit = EDMA_CHANNEL_BIT(channel);
 
 	if (enable) {
-		edma_shadow0_write_array(ecc, SH_ICR, channel >> 5,
-					 BIT(channel & 0x1f));
-		edma_shadow0_write_array(ecc, SH_IESR, channel >> 5,
-					 BIT(channel & 0x1f));
+		edma_shadow0_write_array(ecc, SH_ICR, idx, ch_bit);
+		edma_shadow0_write_array(ecc, SH_IESR, idx, ch_bit);
 	} else {
-		edma_shadow0_write_array(ecc, SH_IECR, channel >> 5,
-					 BIT(channel & 0x1f));
+		edma_shadow0_write_array(ecc, SH_IECR, idx, ch_bit);
 	}
 }
 
@@ -587,26 +597,26 @@ static void edma_start(struct edma_chan *echan)
 {
 	struct edma_cc *ecc = echan->ecc;
 	int channel = EDMA_CHAN_SLOT(echan->ch_num);
-	int j = (channel >> 5);
-	unsigned int mask = BIT(channel & 0x1f);
+	int idx = EDMA_REG_ARRAY_INDEX(channel);
+	int ch_bit = EDMA_CHANNEL_BIT(channel);
 
 	if (!echan->hw_triggered) {
 		/* EDMA channels without event association */
-		dev_dbg(ecc->dev, "ESR%d %08x\n", j,
-			edma_shadow0_read_array(ecc, SH_ESR, j));
-		edma_shadow0_write_array(ecc, SH_ESR, j, mask);
+		dev_dbg(ecc->dev, "ESR%d %08x\n", idx,
+			edma_shadow0_read_array(ecc, SH_ESR, idx));
+		edma_shadow0_write_array(ecc, SH_ESR, idx, ch_bit);
 	} else {
 		/* EDMA channel with event association */
-		dev_dbg(ecc->dev, "ER%d %08x\n", j,
-			edma_shadow0_read_array(ecc, SH_ER, j));
+		dev_dbg(ecc->dev, "ER%d %08x\n", idx,
+			edma_shadow0_read_array(ecc, SH_ER, idx));
 		/* Clear any pending event or error */
-		edma_write_array(ecc, EDMA_ECR, j, mask);
-		edma_write_array(ecc, EDMA_EMCR, j, mask);
+		edma_write_array(ecc, EDMA_ECR, idx, ch_bit);
+		edma_write_array(ecc, EDMA_EMCR, idx, ch_bit);
 		/* Clear any SER */
-		edma_shadow0_write_array(ecc, SH_SECR, j, mask);
-		edma_shadow0_write_array(ecc, SH_EESR, j, mask);
-		dev_dbg(ecc->dev, "EER%d %08x\n", j,
-			edma_shadow0_read_array(ecc, SH_EER, j));
+		edma_shadow0_write_array(ecc, SH_SECR, idx, ch_bit);
+		edma_shadow0_write_array(ecc, SH_EESR, idx, ch_bit);
+		dev_dbg(ecc->dev, "EER%d %08x\n", idx,
+			edma_shadow0_read_array(ecc, SH_EER, idx));
 	}
 }
 
@@ -614,19 +624,19 @@ static void edma_stop(struct edma_chan *echan)
 {
 	struct edma_cc *ecc = echan->ecc;
 	int channel = EDMA_CHAN_SLOT(echan->ch_num);
-	int j = (channel >> 5);
-	unsigned int mask = BIT(channel & 0x1f);
+	int idx = EDMA_REG_ARRAY_INDEX(channel);
+	int ch_bit = EDMA_CHANNEL_BIT(channel);
 
-	edma_shadow0_write_array(ecc, SH_EECR, j, mask);
-	edma_shadow0_write_array(ecc, SH_ECR, j, mask);
-	edma_shadow0_write_array(ecc, SH_SECR, j, mask);
-	edma_write_array(ecc, EDMA_EMCR, j, mask);
+	edma_shadow0_write_array(ecc, SH_EECR, idx, ch_bit);
+	edma_shadow0_write_array(ecc, SH_ECR, idx, ch_bit);
+	edma_shadow0_write_array(ecc, SH_SECR, idx, ch_bit);
+	edma_write_array(ecc, EDMA_EMCR, idx, ch_bit);
 
 	/* clear possibly pending completion interrupt */
-	edma_shadow0_write_array(ecc, SH_ICR, j, mask);
+	edma_shadow0_write_array(ecc, SH_ICR, idx, ch_bit);
 
-	dev_dbg(ecc->dev, "EER%d %08x\n", j,
-		edma_shadow0_read_array(ecc, SH_EER, j));
+	dev_dbg(ecc->dev, "EER%d %08x\n", idx,
+		edma_shadow0_read_array(ecc, SH_EER, idx));
 
 	/* REVISIT:  consider guarding against inappropriate event
 	 * chaining by overwriting with dummy_paramset.
@@ -640,45 +650,49 @@ static void edma_stop(struct edma_chan *echan)
 static void edma_pause(struct edma_chan *echan)
 {
 	int channel = EDMA_CHAN_SLOT(echan->ch_num);
-	unsigned int mask = BIT(channel & 0x1f);
 
-	edma_shadow0_write_array(echan->ecc, SH_EECR, channel >> 5, mask);
+	edma_shadow0_write_array(echan->ecc, SH_EECR,
+				 EDMA_REG_ARRAY_INDEX(channel),
+				 EDMA_CHANNEL_BIT(channel));
 }
 
 /* Re-enable EDMA hardware events on the specified channel.  */
 static void edma_resume(struct edma_chan *echan)
 {
 	int channel = EDMA_CHAN_SLOT(echan->ch_num);
-	unsigned int mask = BIT(channel & 0x1f);
 
-	edma_shadow0_write_array(echan->ecc, SH_EESR, channel >> 5, mask);
+	edma_shadow0_write_array(echan->ecc, SH_EESR,
+				 EDMA_REG_ARRAY_INDEX(channel),
+				 EDMA_CHANNEL_BIT(channel));
 }
 
 static void edma_trigger_channel(struct edma_chan *echan)
 {
 	struct edma_cc *ecc = echan->ecc;
 	int channel = EDMA_CHAN_SLOT(echan->ch_num);
-	unsigned int mask = BIT(channel & 0x1f);
+	int idx = EDMA_REG_ARRAY_INDEX(channel);
+	int ch_bit = EDMA_CHANNEL_BIT(channel);
 
-	edma_shadow0_write_array(ecc, SH_ESR, (channel >> 5), mask);
+	edma_shadow0_write_array(ecc, SH_ESR, idx, ch_bit);
 
-	dev_dbg(ecc->dev, "ESR%d %08x\n", (channel >> 5),
-		edma_shadow0_read_array(ecc, SH_ESR, (channel >> 5)));
+	dev_dbg(ecc->dev, "ESR%d %08x\n", idx,
+		edma_shadow0_read_array(ecc, SH_ESR, idx));
 }
 
 static void edma_clean_channel(struct edma_chan *echan)
 {
 	struct edma_cc *ecc = echan->ecc;
 	int channel = EDMA_CHAN_SLOT(echan->ch_num);
-	int j = (channel >> 5);
-	unsigned int mask = BIT(channel & 0x1f);
+	int idx = EDMA_REG_ARRAY_INDEX(channel);
+	int ch_bit = EDMA_CHANNEL_BIT(channel);
 
-	dev_dbg(ecc->dev, "EMR%d %08x\n", j, edma_read_array(ecc, EDMA_EMR, j));
-	edma_shadow0_write_array(ecc, SH_ECR, j, mask);
+	dev_dbg(ecc->dev, "EMR%d %08x\n", idx,
+		edma_read_array(ecc, EDMA_EMR, idx));
+	edma_shadow0_write_array(ecc, SH_ECR, idx, ch_bit);
 	/* Clear the corresponding EMR bits */
-	edma_write_array(ecc, EDMA_EMCR, j, mask);
+	edma_write_array(ecc, EDMA_EMCR, idx, ch_bit);
 	/* Clear any SER */
-	edma_shadow0_write_array(ecc, SH_SECR, j, mask);
+	edma_shadow0_write_array(ecc, SH_SECR, idx, ch_bit);
 	edma_write(ecc, EDMA_CCERRCLR, BIT(16) | BIT(1) | BIT(0));
 }
 
@@ -708,7 +722,8 @@ static int edma_alloc_channel(struct edma_chan *echan,
 	int channel = EDMA_CHAN_SLOT(echan->ch_num);
 
 	/* ensure access through shadow region 0 */
-	edma_or_array2(ecc, EDMA_DRAE, 0, channel >> 5, BIT(channel & 0x1f));
+	edma_or_array2(ecc, EDMA_DRAE, 0, EDMA_REG_ARRAY_INDEX(channel),
+		       EDMA_CHANNEL_BIT(channel));
 
 	/* ensure no events are pending */
 	edma_stop(echan);
@@ -2482,8 +2497,9 @@ static int edma_pm_resume(struct device *dev)
 	for (i = 0; i < ecc->num_channels; i++) {
 		if (echan[i].alloced) {
 			/* ensure access through shadow region 0 */
-			edma_or_array2(ecc, EDMA_DRAE, 0, i >> 5,
-				       BIT(i & 0x1f));
+			edma_or_array2(ecc, EDMA_DRAE, 0,
+				       EDMA_REG_ARRAY_INDEX(i),
+				       EDMA_CHANNEL_BIT(i));
 
 			edma_setup_interrupt(&echan[i], true);
 
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

