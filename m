Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94EE814A4CD
	for <lists+dmaengine@lfdr.de>; Mon, 27 Jan 2020 14:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgA0NUg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Jan 2020 08:20:36 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:40008 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbgA0NUf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 27 Jan 2020 08:20:35 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00RDKXuF022227;
        Mon, 27 Jan 2020 07:20:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1580131233;
        bh=gXzS2h5LUCwG6H/9ZUQm3pQgqmTnpwsji7vRctJN/RU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=iA63bBkpTehgIDPgSjR5wbkhxiOETsIL1kTiqmLKSZwboedOJXWG/GxUMdcZrThqm
         rMPW7FHG7WVgLp+EpNY9NSnhx3bswOl2s7BZX+wrYWkvZsF62xgZ0AIEDX3+wy3Qn+
         vmg6/s16555V/Wd9f09Gy5O16j5+GYqFfmFDQ7mE=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00RDKX5H118204;
        Mon, 27 Jan 2020 07:20:33 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 27
 Jan 2020 07:20:32 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 27 Jan 2020 07:20:33 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00RDKPa5020427;
        Mon, 27 Jan 2020 07:20:31 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dan.j.williams@intel.com>, <grygorii.strashko@ti.com>,
        <vigneshr@ti.com>
Subject: [PATCH for-next 3/4] dmaengine: ti: k3-udma: Move the TR counter calculation to helper function
Date:   Mon, 27 Jan 2020 15:21:10 +0200
Message-ID: <20200127132111.20464-4-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200127132111.20464-1-peter.ujfalusi@ti.com>
References: <20200127132111.20464-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Move the TR counter parameter configuration code out from the prep_memcpy
callback to a helper function to allow a generic re-usable code for other
TR based transfers.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/ti/k3-udma.c | 74 +++++++++++++++++++++++++++-------------
 1 file changed, 51 insertions(+), 23 deletions(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index cb9259e104b4..9b00013d6f63 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -2029,6 +2029,51 @@ static struct udma_desc *udma_alloc_tr_desc(struct udma_chan *uc,
 	return d;
 }
 
+/**
+ * udma_get_tr_counters - calculate TR counters for a given length
+ * @len: Length of the trasnfer
+ * @align_to: Preferred alignment
+ * @tr0_cnt0: First TR icnt0
+ * @tr0_cnt1: First TR icnt1
+ * @tr1_cnt0: Second (if used) TR icnt0
+ *
+ * For len < SZ_64K only one TR is enough, tr1_cnt0 is not updated
+ * For len >= SZ_64K two TRs are used in a simple way:
+ * First TR: SZ_64K-alignment blocks (tr0_cnt0, tr0_cnt1)
+ * Second TR: the remaining length (tr1_cnt0)
+ *
+ * Returns the number of TRs the length needs (1 or 2)
+ * -EINVAL if the length can not be supported
+ */
+static int udma_get_tr_counters(size_t len, unsigned long align_to,
+				u16 *tr0_cnt0, u16 *tr0_cnt1, u16 *tr1_cnt0)
+{
+	if (len < SZ_64K) {
+		*tr0_cnt0 = len;
+		*tr0_cnt1 = 1;
+
+		return 1;
+	}
+
+	if (align_to > 3)
+		align_to = 3;
+
+realign:
+	*tr0_cnt0 = SZ_64K - BIT(align_to);
+	if (len / *tr0_cnt0 >= SZ_64K) {
+		if (align_to) {
+			align_to--;
+			goto realign;
+		}
+		return -EINVAL;
+	}
+
+	*tr0_cnt1 = len / *tr0_cnt0;
+	*tr1_cnt0 = len % *tr0_cnt0;
+
+	return 2;
+}
+
 static struct udma_desc *
 udma_prep_slave_sg_tr(struct udma_chan *uc, struct scatterlist *sgl,
 		      unsigned int sglen, enum dma_transfer_direction dir,
@@ -2581,29 +2626,12 @@ udma_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
 		return NULL;
 	}
 
-	if (len < SZ_64K) {
-		num_tr = 1;
-		tr0_cnt0 = len;
-		tr0_cnt1 = 1;
-	} else {
-		unsigned long align_to = __ffs(src | dest);
-
-		if (align_to > 3)
-			align_to = 3;
-		/*
-		 * Keep simple: tr0: SZ_64K-alignment blocks,
-		 *		tr1: the remaining
-		 */
-		num_tr = 2;
-		tr0_cnt0 = (SZ_64K - BIT(align_to));
-		if (len / tr0_cnt0 >= SZ_64K) {
-			dev_err(uc->ud->dev, "size %zu is not supported\n",
-				len);
-			return NULL;
-		}
-
-		tr0_cnt1 = len / tr0_cnt0;
-		tr1_cnt0 = len % tr0_cnt0;
+	num_tr = udma_get_tr_counters(len, __ffs(src | dest), &tr0_cnt0,
+				      &tr0_cnt1, &tr1_cnt0);
+	if (num_tr < 0) {
+		dev_err(uc->ud->dev, "size %zu is not supported\n",
+			len);
+		return NULL;
 	}
 
 	d = udma_alloc_tr_desc(uc, tr_size, num_tr, DMA_MEM_TO_MEM);
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

