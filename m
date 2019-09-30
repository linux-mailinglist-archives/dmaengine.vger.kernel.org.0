Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDAA6C200C
	for <lists+dmaengine@lfdr.de>; Mon, 30 Sep 2019 13:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730115AbfI3LkV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 30 Sep 2019 07:40:21 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:34138 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730015AbfI3LkU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 30 Sep 2019 07:40:20 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x8UBeIpw113986;
        Mon, 30 Sep 2019 06:40:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1569843618;
        bh=Xv9IdSYQH2Wyjdje4PEB2rgCyL+w8guQKyTJ3UYqNXA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=LNsrBCSIGQjTmiGn1YxAWYGAO4x8pt/VMot2l7HPA6jKfDywHUKl3Xqpripyfce8k
         GBN1QBwkOexkPAcTR44NEQqdXU9SQpM6sQ2WEoYAnY+dS8RQO0/Su0StA7uJXcBoTQ
         sy9gDIgUVnY8MO0VpNi6JxgwTgkiHVsOiG8vUni4=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x8UBeIxn013608
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 30 Sep 2019 06:40:18 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 30
 Sep 2019 06:40:07 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 30 Sep 2019 06:40:07 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x8UBe8Xr096764;
        Mon, 30 Sep 2019 06:40:15 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dan.j.williams@intel.com>, <devicetree@vger.kernel.org>
Subject: [PATCH v4 3/3] dmaengine: ti: edma: Add support for handling reserved channels
Date:   Mon, 30 Sep 2019 14:40:55 +0300
Message-ID: <20190930114055.29315-4-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190930114055.29315-1-peter.ujfalusi@ti.com>
References: <20190930114055.29315-1-peter.ujfalusi@ti.com>
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
index ba7c4f07fcd6..03c9c6296006 100644
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
@@ -2250,7 +2263,7 @@ static int edma_probe(struct platform_device *pdev)
 	struct edma_soc_info	*info = pdev->dev.platform_data;
 	s8			(*queue_priority_mapping)[2];
 	int			i, off;
-	const s16		(*rsv_slots)[2];
+	const s16		(*reserved)[2];
 	const s16		(*xbar_chans)[2];
 	int			irq;
 	char			*irq_name;
@@ -2331,15 +2344,32 @@ static int edma_probe(struct platform_device *pdev)
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
 
@@ -2399,6 +2429,7 @@ static int edma_probe(struct platform_device *pdev)
 
 	if (!ecc->legacy_mode) {
 		int lowest_priority = 0;
+		unsigned int array_max;
 		struct of_phandle_args tc_args;
 
 		ecc->tc_list = devm_kcalloc(dev, ecc->num_tc,
@@ -2420,6 +2451,18 @@ static int edma_probe(struct platform_device *pdev)
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
@@ -2437,6 +2480,10 @@ static int edma_probe(struct platform_device *pdev)
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

