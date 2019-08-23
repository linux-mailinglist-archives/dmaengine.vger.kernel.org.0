Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A90ED9B00D
	for <lists+dmaengine@lfdr.de>; Fri, 23 Aug 2019 14:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbfHWM4P (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 23 Aug 2019 08:56:15 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:46416 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394996AbfHWM4O (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 23 Aug 2019 08:56:14 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x7NCu8hU073766;
        Fri, 23 Aug 2019 07:56:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1566564968;
        bh=4p8x7v8EaQ++SIjoJmr4MK1Cg7JXqSOfe+y4BO9Mvv8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ma39mbRlT65De5gN1ZfuqkKvk3VI5qahfCk9z+mz41wwyAKyaEIXAwShQhP/YTkxO
         cSVx5vr5PFc4cSizYXixue33OmXD7hPyD2QqY44YC4hTjM9+12UhG9eVETFAX+hO44
         SzPJ0SoUoGucEYxknHIDKx8JqmApUJ4OVeWPCtf8=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x7NCu8uG080903
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 23 Aug 2019 07:56:08 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 23
 Aug 2019 07:56:08 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 23 Aug 2019 07:56:07 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x7NCtwkh092319;
        Fri, 23 Aug 2019 07:56:06 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>
Subject: [PATCH 3/5] dmaengine: ti: edma: Use bitmap_set() instead of open coded edma_set_bits()
Date:   Fri, 23 Aug 2019 15:56:16 +0300
Message-ID: <20190823125618.8133-4-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190823125618.8133-1-peter.ujfalusi@ti.com>
References: <20190823125618.8133-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

bitmap_set() is the standard way of setting an area in the bitfield.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/ti/edma.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
index 87450431f336..ba7c4f07fcd6 100644
--- a/drivers/dma/ti/edma.c
+++ b/drivers/dma/ti/edma.c
@@ -15,6 +15,7 @@
 
 #include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
+#include <linux/bitmap.h>
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
@@ -423,12 +424,6 @@ static inline void edma_param_or(struct edma_cc *ecc, int offset, int param_no,
 	edma_or(ecc, EDMA_PARM + offset + (param_no << 5), or);
 }
 
-static inline void edma_set_bits(int offset, int len, unsigned long *p)
-{
-	for (; len > 0; len--)
-		set_bit(offset + (len - 1), p);
-}
-
 static void edma_assign_priority_to_queue(struct edma_cc *ecc, int queue_no,
 					  int priority)
 {
@@ -2254,7 +2249,7 @@ static int edma_probe(struct platform_device *pdev)
 {
 	struct edma_soc_info	*info = pdev->dev.platform_data;
 	s8			(*queue_priority_mapping)[2];
-	int			i, off, ln;
+	int			i, off;
 	const s16		(*rsv_slots)[2];
 	const s16		(*xbar_chans)[2];
 	int			irq;
@@ -2342,11 +2337,9 @@ static int edma_probe(struct platform_device *pdev)
 		/* Set the reserved slots in inuse list */
 		rsv_slots = info->rsv->rsv_slots;
 		if (rsv_slots) {
-			for (i = 0; rsv_slots[i][0] != -1; i++) {
-				off = rsv_slots[i][0];
-				ln = rsv_slots[i][1];
-				edma_set_bits(off, ln, ecc->slot_inuse);
-			}
+			for (i = 0; rsv_slots[i][0] != -1; i++)
+				bitmap_set(ecc->slot_inuse, rsv_slots[i][0],
+					   rsv_slots[i][1]);
 		}
 	}
 
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

