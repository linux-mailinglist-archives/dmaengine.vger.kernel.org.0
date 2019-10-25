Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1F6E446F
	for <lists+dmaengine@lfdr.de>; Fri, 25 Oct 2019 09:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436831AbfJYHaH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 25 Oct 2019 03:30:07 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:59396 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436798AbfJYHaH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 25 Oct 2019 03:30:07 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9P7U3ke022692;
        Fri, 25 Oct 2019 02:30:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571988603;
        bh=+YAhSjmgPV3rufoVqLcPsk3D9DaDrrZFgGX+61W6VOQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=A2o0MeOa/wt1D8EwBd7TaC2uvgM24ZyFlOHOTRzuKTDv1mVL5tsTZ5nIRZ+ay7ZyO
         IWrGSKWdETFY1zSdTRGfQa7U+e844KF+JN+XG850Rzsk1BQpsKJpCE2DjcT+HCL/Ne
         7J/T50/G0w+JV8V0u5FIGfOR9EqTOtHctu4nLBUs=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9P7U2Y6070206;
        Fri, 25 Oct 2019 02:30:03 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 25
 Oct 2019 02:29:51 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 25 Oct 2019 02:30:02 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9P7Tr4I103329;
        Fri, 25 Oct 2019 02:30:00 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dan.j.williams@intel.com>, <devicetree@vger.kernel.org>
Subject: [PATCH v5 3/3] dmaengine: ti: edma: Add support for handling reserved channels
Date:   Fri, 25 Oct 2019 10:30:56 +0300
Message-ID: <20191025073056.25450-4-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191025073056.25450-1-peter.ujfalusi@ti.com>
References: <20191025073056.25450-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Like paRAM slots, channels could be used by other cores and in this case
we need to make sure that the driver do not alter these channels.

Handle the generic dma-channel-mask property to mark channels in a bitmap
which can not be used by Linux and convert the legacy rsv_chans if it is
provided by platform_data.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/ti/edma.c | 59 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 53 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
index 54fd981e3db5..0ecfc2e1d798 100644
--- a/drivers/dma/ti/edma.c
+++ b/drivers/dma/ti/edma.c
@@ -260,6 +260,13 @@ struct edma_cc {
 	 */
 	unsigned long *slot_inuse;
 
+	/*
+	 * For tracking reserved channels used by DSP.
+	 * If the bit is cleared, the channel is allocated to be used by DSP
+	 * and Linux must not touch it.
+	 */
+	unsigned long *channels_mask;
+
 	struct dma_device		dma_slave;
 	struct dma_device		*dma_memcpy;
 	struct edma_chan		*slave_chans;
@@ -716,6 +723,12 @@ static int edma_alloc_channel(struct edma_chan *echan,
 	struct edma_cc *ecc = echan->ecc;
 	int channel = EDMA_CHAN_SLOT(echan->ch_num);
 
+	if (!test_bit(echan->ch_num, ecc->channels_mask)) {
+		dev_err(ecc->dev, "Channel%d is reserved, can not be used!\n",
+			echan->ch_num);
+		return -EINVAL;
+	}
+
 	/* ensure access through shadow region 0 */
 	edma_or_array2(ecc, EDMA_DRAE, 0, EDMA_REG_ARRAY_INDEX(channel),
 		       EDMA_CHANNEL_BIT(channel));
@@ -2249,7 +2262,7 @@ static int edma_probe(struct platform_device *pdev)
 {
 	struct edma_soc_info	*info = pdev->dev.platform_data;
 	s8			(*queue_priority_mapping)[2];
-	const s16		(*rsv_slots)[2];
+	const s16		(*reserved)[2];
 	int			i, irq;
 	char			*irq_name;
 	struct resource		*mem;
@@ -2329,15 +2342,32 @@ static int edma_probe(struct platform_device *pdev)
 	if (!ecc->slot_inuse)
 		return -ENOMEM;
 
+	ecc->channels_mask = devm_kcalloc(dev,
+					   BITS_TO_LONGS(ecc->num_channels),
+					   sizeof(unsigned long), GFP_KERNEL);
+	if (!ecc->channels_mask)
+		return -ENOMEM;
+
+	/* Mark all channels available initially */
+	bitmap_fill(ecc->channels_mask, ecc->num_channels);
+
 	ecc->default_queue = info->default_queue;
 
 	if (info->rsv) {
 		/* Set the reserved slots in inuse list */
-		rsv_slots = info->rsv->rsv_slots;
-		if (rsv_slots) {
-			for (i = 0; rsv_slots[i][0] != -1; i++)
-				bitmap_set(ecc->slot_inuse, rsv_slots[i][0],
-					   rsv_slots[i][1]);
+		reserved = info->rsv->rsv_slots;
+		if (reserved) {
+			for (i = 0; reserved[i][0] != -1; i++)
+				bitmap_set(ecc->slot_inuse, reserved[i][0],
+					   reserved[i][1]);
+		}
+
+		/* Clear channels not usable for Linux */
+		reserved = info->rsv->rsv_chans;
+		if (reserved) {
+			for (i = 0; reserved[i][0] != -1; i++)
+				bitmap_clear(ecc->channels_mask, reserved[i][0],
+					     reserved[i][1]);
 		}
 	}
 
@@ -2389,6 +2419,7 @@ static int edma_probe(struct platform_device *pdev)
 
 	if (!ecc->legacy_mode) {
 		int lowest_priority = 0;
+		unsigned int array_max;
 		struct of_phandle_args tc_args;
 
 		ecc->tc_list = devm_kcalloc(dev, ecc->num_tc,
@@ -2410,6 +2441,18 @@ static int edma_probe(struct platform_device *pdev)
 				info->default_queue = i;
 			}
 		}
+
+		/* See if we have optional dma-channel-mask array */
+		array_max = DIV_ROUND_UP(ecc->num_channels, BITS_PER_TYPE(u32));
+		ret = of_property_read_variable_u32_array(node,
+						"dma-channel-mask",
+						(u32 *)ecc->channels_mask,
+						1, array_max);
+		if (ret > 0 && ret != array_max)
+			dev_warn(dev, "dma-channel-mask is not complete.\n");
+		else if (ret == -EOVERFLOW || ret == -ENODATA)
+			dev_warn(dev,
+				 "dma-channel-mask is out of range or empty\n");
 	}
 
 	/* Event queue priority mapping */
@@ -2427,6 +2470,10 @@ static int edma_probe(struct platform_device *pdev)
 	edma_dma_init(ecc, legacy_mode);
 
 	for (i = 0; i < ecc->num_channels; i++) {
+		/* Do not touch reserved channels */
+		if (!test_bit(i, ecc->channels_mask))
+			continue;
+
 		/* Assign all channels to the default queue */
 		edma_assign_channel_eventq(&ecc->slave_chans[i],
 					   info->default_queue);
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

