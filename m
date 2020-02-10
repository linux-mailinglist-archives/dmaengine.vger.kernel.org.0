Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA8E1571F8
	for <lists+dmaengine@lfdr.de>; Mon, 10 Feb 2020 10:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbgBJJo7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 10 Feb 2020 04:44:59 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:51382 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbgBJJo7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 10 Feb 2020 04:44:59 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01A9it1U115612;
        Mon, 10 Feb 2020 03:44:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1581327895;
        bh=WHA5f9aeIK94W7O4raqyi6TRpxmBTofuV51Iz7NuefM=;
        h=From:To:CC:Subject:Date;
        b=wZ7K49XDF6AaTNOmbFo6PdeM3f9n5AAeaZ4xLlD8tcdGycAx5Bo+U7uiWsg42rlEm
         zi636AxUq6yOHh8yA9kOyn6lPfe2mhOrgwsPQJHiQwrg9nXZdWFYe2DN8BSCnzCZM6
         awdnbVTd8+CEaXVRgV4RxRJydsG/tUMEG2FobrKM=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01A9itT3116199
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 10 Feb 2020 03:44:55 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 10
 Feb 2020 03:44:53 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 10 Feb 2020 03:44:53 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01A9ipdK126723;
        Mon, 10 Feb 2020 03:44:52 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dan.j.williams@intel.com>
Subject: [PATCH v2] dmaengine: ti: edma: Support for interleaved mem to mem transfer
Date:   Mon, 10 Feb 2020 11:44:55 +0200
Message-ID: <20200210094455.3615-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add basic interleaved support via EDMA.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
Hi,

Changes since v1:
- No need to configure link_bcntrld as the link is set in edma_execute

Regards,
Peter

 drivers/dma/ti/edma.c | 79 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
index 03a7f647f7b2..2b1fdd438e7f 100644
--- a/drivers/dma/ti/edma.c
+++ b/drivers/dma/ti/edma.c
@@ -1275,6 +1275,81 @@ static struct dma_async_tx_descriptor *edma_prep_dma_memcpy(
 	return vchan_tx_prep(&echan->vchan, &edesc->vdesc, tx_flags);
 }
 
+static struct dma_async_tx_descriptor *
+edma_prep_dma_interleaved(struct dma_chan *chan,
+			  struct dma_interleaved_template *xt,
+			  unsigned long tx_flags)
+{
+	struct device *dev = chan->device->dev;
+	struct edma_chan *echan = to_edma_chan(chan);
+	struct edmacc_param *param;
+	struct edma_desc *edesc;
+	size_t src_icg, dst_icg;
+	int src_bidx, dst_bidx;
+
+	/* Slave mode is not supported */
+	if (is_slave_direction(xt->dir))
+		return NULL;
+
+	if (xt->frame_size != 1 || xt->numf == 0)
+		return NULL;
+
+	if (xt->sgl[0].size > SZ_64K || xt->numf > SZ_64K)
+		return NULL;
+
+	src_icg = dmaengine_get_src_icg(xt, &xt->sgl[0]);
+	if (src_icg) {
+		src_bidx = src_icg + xt->sgl[0].size;
+	} else if (xt->src_inc) {
+		src_bidx = xt->sgl[0].size;
+	} else {
+		dev_err(dev, "%s: SRC constant addressing is not supported\n",
+			__func__);
+		return NULL;
+	}
+
+	dst_icg = dmaengine_get_dst_icg(xt, &xt->sgl[0]);
+	if (dst_icg) {
+		dst_bidx = dst_icg + xt->sgl[0].size;
+	} else if (xt->dst_inc) {
+		dst_bidx = xt->sgl[0].size;
+	} else {
+		dev_err(dev, "%s: DST constant addressing is not supported\n",
+			__func__);
+		return NULL;
+	}
+
+	if (src_bidx > SZ_64K || dst_bidx > SZ_64K)
+		return NULL;
+
+	edesc = kzalloc(struct_size(edesc, pset, 1), GFP_ATOMIC);
+	if (!edesc)
+		return NULL;
+
+	edesc->direction = DMA_MEM_TO_MEM;
+	edesc->echan = echan;
+	edesc->pset_nr = 1;
+
+	param = &edesc->pset[0].param;
+
+	param->src = xt->src_start;
+	param->dst = xt->dst_start;
+	param->a_b_cnt = xt->numf << 16 | xt->sgl[0].size;
+	param->ccnt = 1;
+	param->src_dst_bidx = (dst_bidx << 16) | src_bidx;
+	param->src_dst_cidx = 0;
+
+	param->opt = EDMA_TCC(EDMA_CHAN_SLOT(echan->ch_num));
+	param->opt |= ITCCHEN;
+	/* Enable transfer complete interrupt if requested */
+	if (tx_flags & DMA_PREP_INTERRUPT)
+		param->opt |= TCINTEN;
+	else
+		edesc->polled = true;
+
+	return vchan_tx_prep(&echan->vchan, &edesc->vdesc, tx_flags);
+}
+
 static struct dma_async_tx_descriptor *edma_prep_dma_cyclic(
 	struct dma_chan *chan, dma_addr_t buf_addr, size_t buf_len,
 	size_t period_len, enum dma_transfer_direction direction,
@@ -1917,7 +1992,9 @@ static void edma_dma_init(struct edma_cc *ecc, bool legacy_mode)
 			 "Legacy memcpy is enabled, things might not work\n");
 
 		dma_cap_set(DMA_MEMCPY, s_ddev->cap_mask);
+		dma_cap_set(DMA_INTERLEAVE, m_ddev->cap_mask);
 		s_ddev->device_prep_dma_memcpy = edma_prep_dma_memcpy;
+		s_ddev->device_prep_interleaved_dma = edma_prep_dma_interleaved;
 		s_ddev->directions = BIT(DMA_MEM_TO_MEM);
 	}
 
@@ -1953,8 +2030,10 @@ static void edma_dma_init(struct edma_cc *ecc, bool legacy_mode)
 
 		dma_cap_zero(m_ddev->cap_mask);
 		dma_cap_set(DMA_MEMCPY, m_ddev->cap_mask);
+		dma_cap_set(DMA_INTERLEAVE, m_ddev->cap_mask);
 
 		m_ddev->device_prep_dma_memcpy = edma_prep_dma_memcpy;
+		m_ddev->device_prep_interleaved_dma = edma_prep_dma_interleaved;
 		m_ddev->device_alloc_chan_resources = edma_alloc_chan_resources;
 		m_ddev->device_free_chan_resources = edma_free_chan_resources;
 		m_ddev->device_issue_pending = edma_issue_pending;
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

