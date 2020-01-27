Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A55A14A4D0
	for <lists+dmaengine@lfdr.de>; Mon, 27 Jan 2020 14:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbgA0NUp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Jan 2020 08:20:45 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:40024 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbgA0NUo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 27 Jan 2020 08:20:44 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00RDKgT4022253;
        Mon, 27 Jan 2020 07:20:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1580131242;
        bh=9HVWCPU2xE0B3O6Indfhx0OQYVbHUJfuMYDi/jTeREs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=LhuNXPF3obU+4SxGqZ21Q44xisRCsbjVYTstkxh5EBa4gZbHaEp2WyMFeoSW1IG1t
         ydO2kCxEMvvC3dLQoR3cz9bEp+Y4mCtRzOOnr9f+X3t8+g/rK1oN8SxByv1V5ftTMY
         cUrJmmzPBoqGflTNTzpgWCx+FiY++GlM3Axb9cS0=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 00RDKfUa085338
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 Jan 2020 07:20:41 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 27
 Jan 2020 07:20:34 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 27 Jan 2020 07:20:34 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00RDKPa6020427;
        Mon, 27 Jan 2020 07:20:33 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dan.j.williams@intel.com>, <grygorii.strashko@ti.com>,
        <vigneshr@ti.com>
Subject: [PATCH for-next 4/4] dmaengine: ti: k3-udma: Use the TR counter helper for slave_sg and cyclic
Date:   Mon, 27 Jan 2020 15:21:11 +0200
Message-ID: <20200127132111.20464-5-peter.ujfalusi@ti.com>
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

Use the generic TR setup function to get the TR counters for both cyclic
and slave_sg transfers.
This way the period_size for cyclic and sg_dma_len() for slave_sg can be
as large as (SZ_64K - 1) * (SZ_64K - 1) and we can handle cases when the
length is >SZ_64K and a prime number.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/ti/k3-udma.c | 130 ++++++++++++++++++++++++++-------------
 1 file changed, 88 insertions(+), 42 deletions(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 9b00013d6f63..1dba47c662c4 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -2079,31 +2079,31 @@ udma_prep_slave_sg_tr(struct udma_chan *uc, struct scatterlist *sgl,
 		      unsigned int sglen, enum dma_transfer_direction dir,
 		      unsigned long tx_flags, void *context)
 {
-	enum dma_slave_buswidth dev_width;
 	struct scatterlist *sgent;
 	struct udma_desc *d;
-	size_t tr_size;
 	struct cppi5_tr_type1_t *tr_req = NULL;
+	u16 tr0_cnt0, tr0_cnt1, tr1_cnt0;
 	unsigned int i;
-	u32 burst;
+	size_t tr_size;
+	int num_tr = 0;
+	int tr_idx = 0;
 
-	if (dir == DMA_DEV_TO_MEM) {
-		dev_width = uc->cfg.src_addr_width;
-		burst = uc->cfg.src_maxburst;
-	} else if (dir == DMA_MEM_TO_DEV) {
-		dev_width = uc->cfg.dst_addr_width;
-		burst = uc->cfg.dst_maxburst;
-	} else {
-		dev_err(uc->ud->dev, "%s: bad direction?\n", __func__);
+	if (!is_slave_direction(dir)) {
+		dev_err(uc->ud->dev, "Only slave cyclic is supported\n");
 		return NULL;
 	}
 
-	if (!burst)
-		burst = 1;
+	/* estimate the number of TRs we will need */
+	for_each_sg(sgl, sgent, sglen, i) {
+		if (sg_dma_len(sgent) < SZ_64K)
+			num_tr++;
+		else
+			num_tr += 2;
+	}
 
 	/* Now allocate and setup the descriptor. */
 	tr_size = sizeof(struct cppi5_tr_type1_t);
-	d = udma_alloc_tr_desc(uc, tr_size, sglen, dir);
+	d = udma_alloc_tr_desc(uc, tr_size, num_tr, dir);
 	if (!d)
 		return NULL;
 
@@ -2111,19 +2111,46 @@ udma_prep_slave_sg_tr(struct udma_chan *uc, struct scatterlist *sgl,
 
 	tr_req = d->hwdesc[0].tr_req_base;
 	for_each_sg(sgl, sgent, sglen, i) {
-		d->residue += sg_dma_len(sgent);
+		dma_addr_t sg_addr = sg_dma_address(sgent);
+
+		num_tr = udma_get_tr_counters(sg_dma_len(sgent), __ffs(sg_addr),
+					      &tr0_cnt0, &tr0_cnt1, &tr1_cnt0);
+		if (num_tr < 0) {
+			dev_err(uc->ud->dev, "size %u is not supported\n",
+				sg_dma_len(sgent));
+			udma_free_hwdesc(uc, d);
+			kfree(d);
+			return NULL;
+		}
 
 		cppi5_tr_init(&tr_req[i].flags, CPPI5_TR_TYPE1, false, false,
 			      CPPI5_TR_EVENT_SIZE_COMPLETION, 0);
 		cppi5_tr_csf_set(&tr_req[i].flags, CPPI5_TR_CSF_SUPR_EVT);
 
-		tr_req[i].addr = sg_dma_address(sgent);
-		tr_req[i].icnt0 = burst * dev_width;
-		tr_req[i].dim1 = burst * dev_width;
-		tr_req[i].icnt1 = sg_dma_len(sgent) / tr_req[i].icnt0;
+		tr_req[tr_idx].addr = sg_addr;
+		tr_req[tr_idx].icnt0 = tr0_cnt0;
+		tr_req[tr_idx].icnt1 = tr0_cnt1;
+		tr_req[tr_idx].dim1 = tr0_cnt0;
+		tr_idx++;
+
+		if (num_tr == 2) {
+			cppi5_tr_init(&tr_req[tr_idx].flags, CPPI5_TR_TYPE1,
+				      false, false,
+				      CPPI5_TR_EVENT_SIZE_COMPLETION, 0);
+			cppi5_tr_csf_set(&tr_req[tr_idx].flags,
+					 CPPI5_TR_CSF_SUPR_EVT);
+
+			tr_req[tr_idx].addr = sg_addr + tr0_cnt1 * tr0_cnt0;
+			tr_req[tr_idx].icnt0 = tr1_cnt0;
+			tr_req[tr_idx].icnt1 = 1;
+			tr_req[tr_idx].dim1 = tr1_cnt0;
+			tr_idx++;
+		}
+
+		d->residue += sg_dma_len(sgent);
 	}
 
-	cppi5_tr_csf_set(&tr_req[i - 1].flags, CPPI5_TR_CSF_EOP);
+	cppi5_tr_csf_set(&tr_req[tr_idx - 1].flags, CPPI5_TR_CSF_EOP);
 
 	return d;
 }
@@ -2428,47 +2455,66 @@ udma_prep_dma_cyclic_tr(struct udma_chan *uc, dma_addr_t buf_addr,
 			size_t buf_len, size_t period_len,
 			enum dma_transfer_direction dir, unsigned long flags)
 {
-	enum dma_slave_buswidth dev_width;
 	struct udma_desc *d;
-	size_t tr_size;
+	size_t tr_size, period_addr;
 	struct cppi5_tr_type1_t *tr_req;
-	unsigned int i;
 	unsigned int periods = buf_len / period_len;
-	u32 burst;
+	u16 tr0_cnt0, tr0_cnt1, tr1_cnt0;
+	unsigned int i;
+	int num_tr;
 
-	if (dir == DMA_DEV_TO_MEM) {
-		dev_width = uc->cfg.src_addr_width;
-		burst = uc->cfg.src_maxburst;
-	} else if (dir == DMA_MEM_TO_DEV) {
-		dev_width = uc->cfg.dst_addr_width;
-		burst = uc->cfg.dst_maxburst;
-	} else {
-		dev_err(uc->ud->dev, "%s: bad direction?\n", __func__);
+	if (!is_slave_direction(dir)) {
+		dev_err(uc->ud->dev, "Only slave cyclic is supported\n");
 		return NULL;
 	}
 
-	if (!burst)
-		burst = 1;
+	num_tr = udma_get_tr_counters(period_len, __ffs(buf_addr), &tr0_cnt0,
+				      &tr0_cnt1, &tr1_cnt0);
+	if (num_tr < 0) {
+		dev_err(uc->ud->dev, "size %zu is not supported\n",
+			period_len);
+		return NULL;
+	}
 
 	/* Now allocate and setup the descriptor. */
 	tr_size = sizeof(struct cppi5_tr_type1_t);
-	d = udma_alloc_tr_desc(uc, tr_size, periods, dir);
+	d = udma_alloc_tr_desc(uc, tr_size, periods * num_tr, dir);
 	if (!d)
 		return NULL;
 
 	tr_req = d->hwdesc[0].tr_req_base;
+	period_addr = buf_addr;
 	for (i = 0; i < periods; i++) {
-		cppi5_tr_init(&tr_req[i].flags, CPPI5_TR_TYPE1, false, false,
-			      CPPI5_TR_EVENT_SIZE_COMPLETION, 0);
+		int tr_idx = i * num_tr;
 
-		tr_req[i].addr = buf_addr + period_len * i;
-		tr_req[i].icnt0 = dev_width;
-		tr_req[i].icnt1 = period_len / dev_width;
-		tr_req[i].dim1 = dev_width;
+		cppi5_tr_init(&tr_req[tr_idx].flags, CPPI5_TR_TYPE1, false,
+			      false, CPPI5_TR_EVENT_SIZE_COMPLETION, 0);
+
+		tr_req[tr_idx].addr = period_addr;
+		tr_req[tr_idx].icnt0 = tr0_cnt0;
+		tr_req[tr_idx].icnt1 = tr0_cnt1;
+		tr_req[tr_idx].dim1 = tr0_cnt0;
+
+		if (num_tr == 2) {
+			cppi5_tr_csf_set(&tr_req[tr_idx].flags,
+					 CPPI5_TR_CSF_SUPR_EVT);
+			tr_idx++;
+
+			cppi5_tr_init(&tr_req[tr_idx].flags, CPPI5_TR_TYPE1,
+				      false, false,
+				      CPPI5_TR_EVENT_SIZE_COMPLETION, 0);
+
+			tr_req[tr_idx].addr = period_addr + tr0_cnt1 * tr0_cnt0;
+			tr_req[tr_idx].icnt0 = tr1_cnt0;
+			tr_req[tr_idx].icnt1 = 1;
+			tr_req[tr_idx].dim1 = tr1_cnt0;
+		}
 
 		if (!(flags & DMA_PREP_INTERRUPT))
-			cppi5_tr_csf_set(&tr_req[i].flags,
+			cppi5_tr_csf_set(&tr_req[tr_idx].flags,
 					 CPPI5_TR_CSF_SUPR_EVT);
+
+		period_addr += period_len;
 	}
 
 	return d;
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

