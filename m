Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D883E6C6787
	for <lists+dmaengine@lfdr.de>; Thu, 23 Mar 2023 13:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbjCWMDO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 23 Mar 2023 08:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjCWMCz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 23 Mar 2023 08:02:55 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CFC4367FD;
        Thu, 23 Mar 2023 05:01:17 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32NC194a099471;
        Thu, 23 Mar 2023 07:01:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1679572869;
        bh=FUB77A/dWJI4L/JUMtJNi/1d+ynfoPHVkgEDX79znkw=;
        h=From:To:CC:Subject:Date;
        b=VkLsNCAaPmIREYLqqYsHFh5loOponyT0rPjHoZH5/fnllcoBGlX+hyqOKhjh+YiqT
         8zMRXcL6jRiSgfHtLfIIjkeppeQMXUHDJXyqogRKPLN/LMOb+YuYTYhAYLhn+yKkgY
         RR6cpgs5XADvLQavOO2qeWAgpo2HPyBCW9sHNkm4=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32NC19Le025154
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Mar 2023 07:01:09 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 23
 Mar 2023 07:01:08 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 23 Mar 2023 07:01:08 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32NC17gh021970;
        Thu, 23 Mar 2023 07:01:08 -0500
From:   Jayesh Choudhary <j-choudhary@ti.com>
To:     <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>
CC:     <vigneshr@ti.com>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <j-choudhary@ti.com>
Subject: [PATCH v2] dmaengine: ti: k3-udma: Workaround errata i2234
Date:   Thu, 23 Mar 2023 17:31:07 +0530
Message-ID: <20230323120107.27638-1-j-choudhary@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Vignesh Raghavendra <vigneshr@ti.com>

Per [1], UDMA TR15 transactions may hang if ICNT0 is less than 64B
Work around is to set EOL flag is to 1 for ICNT0.

Since, there is no performance penalty / side effects of setting EOL
flag event ICNTO > 64B, just set the flag for all UDMAP TR15
descriptors.

[1] https://www.ti.com/lit/er/sprz455a/sprz455a.pdf
Errata doc for J721E DRA829/TDA4VM Processors Silicon Revision 1.1/1.0
(Rev. A)

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
[j-choudhary@ti.com: minor cleanups]
Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
---

Changelog v1->v2:
- Correct the commit subject
- Update functions that uses only tr_type15_t, and not tr_type_1_t
  as PDMAs and CSI uses tr_type_1_t (to address Peter's comment in v1)

v1 patch link:
<https://lore.kernel.org/all/20211209180715.27998-1-vigneshr@ti.com/>

 drivers/dma/ti/k3-udma.c     | 20 +++++++++++---------
 include/linux/dma/ti-cppi5.h |  1 +
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 7e23a6fdef95..e33a7fec2c0f 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -2964,6 +2964,7 @@ udma_prep_slave_sg_triggered_tr(struct udma_chan *uc, struct scatterlist *sgl,
 	struct scatterlist *sgent;
 	struct cppi5_tr_type15_t *tr_req = NULL;
 	enum dma_slave_buswidth dev_width;
+	u32 csf = CPPI5_TR_CSF_SUPR_EVT;
 	u16 tr_cnt0, tr_cnt1;
 	dma_addr_t dev_addr;
 	struct udma_desc *d;
@@ -3034,6 +3035,7 @@ udma_prep_slave_sg_triggered_tr(struct udma_chan *uc, struct scatterlist *sgl,
 
 	if (uc->ud->match_data->type == DMA_TYPE_UDMA) {
 		asel = 0;
+		csf |= CPPI5_TR_CSF_EOL_ICNT0;
 	} else {
 		asel = (u64)uc->config.asel << K3_ADDRESS_ASEL_SHIFT;
 		dev_addr |= asel;
@@ -3057,7 +3059,7 @@ udma_prep_slave_sg_triggered_tr(struct udma_chan *uc, struct scatterlist *sgl,
 
 		cppi5_tr_init(&tr_req[tr_idx].flags, CPPI5_TR_TYPE15, false,
 			      true, CPPI5_TR_EVENT_SIZE_COMPLETION, 0);
-		cppi5_tr_csf_set(&tr_req[tr_idx].flags, CPPI5_TR_CSF_SUPR_EVT);
+		cppi5_tr_csf_set(&tr_req[tr_idx].flags, csf);
 		cppi5_tr_set_trigger(&tr_req[tr_idx].flags,
 				     uc->config.tr_trigger_type,
 				     CPPI5_TR_TRIGGER_TYPE_ICNT2_DEC, 0, 0);
@@ -3103,8 +3105,7 @@ udma_prep_slave_sg_triggered_tr(struct udma_chan *uc, struct scatterlist *sgl,
 			cppi5_tr_init(&tr_req[tr_idx].flags, CPPI5_TR_TYPE15,
 				      false, true,
 				      CPPI5_TR_EVENT_SIZE_COMPLETION, 0);
-			cppi5_tr_csf_set(&tr_req[tr_idx].flags,
-					 CPPI5_TR_CSF_SUPR_EVT);
+			cppi5_tr_csf_set(&tr_req[tr_idx].flags, csf);
 			cppi5_tr_set_trigger(&tr_req[tr_idx].flags,
 					     uc->config.tr_trigger_type,
 					     CPPI5_TR_TRIGGER_TYPE_ICNT2_DEC,
@@ -3148,8 +3149,7 @@ udma_prep_slave_sg_triggered_tr(struct udma_chan *uc, struct scatterlist *sgl,
 		d->residue += sg_len;
 	}
 
-	cppi5_tr_csf_set(&tr_req[tr_idx - 1].flags,
-			 CPPI5_TR_CSF_SUPR_EVT | CPPI5_TR_CSF_EOP);
+	cppi5_tr_csf_set(&tr_req[tr_idx - 1].flags, csf | CPPI5_TR_CSF_EOP);
 
 	return d;
 }
@@ -3678,6 +3678,7 @@ udma_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
 	int num_tr;
 	size_t tr_size = sizeof(struct cppi5_tr_type15_t);
 	u16 tr0_cnt0, tr0_cnt1, tr1_cnt0;
+	u32 csf = CPPI5_TR_CSF_SUPR_EVT;
 
 	if (uc->config.dir != DMA_MEM_TO_MEM) {
 		dev_err(chan->device->dev,
@@ -3708,13 +3709,15 @@ udma_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
 	if (uc->ud->match_data->type != DMA_TYPE_UDMA) {
 		src |= (u64)uc->ud->asel << K3_ADDRESS_ASEL_SHIFT;
 		dest |= (u64)uc->ud->asel << K3_ADDRESS_ASEL_SHIFT;
+	} else {
+		csf |= CPPI5_TR_CSF_EOL_ICNT0;
 	}
 
 	tr_req = d->hwdesc[0].tr_req_base;
 
 	cppi5_tr_init(&tr_req[0].flags, CPPI5_TR_TYPE15, false, true,
 		      CPPI5_TR_EVENT_SIZE_COMPLETION, 0);
-	cppi5_tr_csf_set(&tr_req[0].flags, CPPI5_TR_CSF_SUPR_EVT);
+	cppi5_tr_csf_set(&tr_req[0].flags, csf);
 
 	tr_req[0].addr = src;
 	tr_req[0].icnt0 = tr0_cnt0;
@@ -3733,7 +3736,7 @@ udma_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
 	if (num_tr == 2) {
 		cppi5_tr_init(&tr_req[1].flags, CPPI5_TR_TYPE15, false, true,
 			      CPPI5_TR_EVENT_SIZE_COMPLETION, 0);
-		cppi5_tr_csf_set(&tr_req[1].flags, CPPI5_TR_CSF_SUPR_EVT);
+		cppi5_tr_csf_set(&tr_req[1].flags, csf);
 
 		tr_req[1].addr = src + tr0_cnt1 * tr0_cnt0;
 		tr_req[1].icnt0 = tr1_cnt0;
@@ -3748,8 +3751,7 @@ udma_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
 		tr_req[1].dicnt3 = 1;
 	}
 
-	cppi5_tr_csf_set(&tr_req[num_tr - 1].flags,
-			 CPPI5_TR_CSF_SUPR_EVT | CPPI5_TR_CSF_EOP);
+	cppi5_tr_csf_set(&tr_req[num_tr - 1].flags, csf | CPPI5_TR_CSF_EOP);
 
 	if (uc->config.metadata_size)
 		d->vd.tx.metadata_ops = &metadata_ops;
diff --git a/include/linux/dma/ti-cppi5.h b/include/linux/dma/ti-cppi5.h
index efa2f0309f00..c53c0f6e3b1a 100644
--- a/include/linux/dma/ti-cppi5.h
+++ b/include/linux/dma/ti-cppi5.h
@@ -616,6 +616,7 @@ static inline void *cppi5_hdesc_get_swdata(struct cppi5_host_desc_t *desc)
 #define   CPPI5_TR_CSF_SUPR_EVT			BIT(2)
 #define   CPPI5_TR_CSF_EOL_ADV_SHIFT		(4U)
 #define   CPPI5_TR_CSF_EOL_ADV_MASK		GENMASK(6, 4)
+#define   CPPI5_TR_CSF_EOL_ICNT0		BIT(4)
 #define   CPPI5_TR_CSF_EOP			BIT(7)
 
 /**
-- 
2.25.1

