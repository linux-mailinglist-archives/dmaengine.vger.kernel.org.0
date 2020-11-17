Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABB32B5D89
	for <lists+dmaengine@lfdr.de>; Tue, 17 Nov 2020 11:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbgKQK5N (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 17 Nov 2020 05:57:13 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:59728 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728251AbgKQK5M (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 17 Nov 2020 05:57:12 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0AHAv35k019782;
        Tue, 17 Nov 2020 04:57:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605610623;
        bh=A5OrLu3ojbYpG4gq/4/5UqViwqExPA+nK9Ht2JX2wy4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=SsCqT6ztKejISY9Qbvn6w5QkK46hXQc4RZgaGnsS6Y8MMioRzMymmM2c3y0QRRk1Q
         u4Wa4A6kHizgsRKewRd+QthpjuWtUV/I+QFigt1Ph/NB0RFgHf/1NXpdZ+qCMr/PwT
         +ySQRsHF89aRyS5Fg1oyAdb+aqLhgEtdgX0BkVYw=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0AHAv2Y6005701
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 Nov 2020 04:57:02 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 17
 Nov 2020 04:57:02 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 17 Nov 2020 04:57:02 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0AHAu6u3087311;
        Tue, 17 Nov 2020 04:56:59 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <nm@ti.com>, <ssantosh@kernel.org>,
        <robh+dt@kernel.org>
CC:     <dan.j.williams@intel.com>, <t-kristo@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <vigneshr@ti.com>,
        <grygorii.strashko@ti.com>
Subject: [PATCH v2 17/19] dmaengine: ti: k3-udma: Add support for BCDMA channel TPL handling
Date:   Tue, 17 Nov 2020 12:56:54 +0200
Message-ID: <20201117105656.5236-18-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201117105656.5236-1-peter.ujfalusi@ti.com>
References: <20201117105656.5236-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Unlike UDMAP the BCDMA defines the channel TPL levels per channel type.
In UDMAP the number of high and ultra-high channels applies to both tchan
and rchan.

BCDMA defines the TPL per channel types: bchan, tchan and rchan can have
different number of high and ultra-high channels.

In order to support BCDMA channel TPL we need to move the tpl information
as per channel type property for the DMAs.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/ti/k3-udma.c | 117 ++++++++++++++++++++++++++-------------
 drivers/dma/ti/k3-udma.h |   6 ++
 2 files changed, 85 insertions(+), 38 deletions(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index f327d436f8ad..0dc3430fea40 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -146,6 +146,11 @@ struct udma_rx_flush {
 	dma_addr_t buffer_paddr;
 };
 
+struct udma_tpl {
+	u8 levels;
+	u32 start_idx[3];
+};
+
 struct udma_dev {
 	struct dma_device ddev;
 	struct device *dev;
@@ -153,8 +158,9 @@ struct udma_dev {
 	const struct udma_match_data *match_data;
 	const struct udma_soc_data *soc_data;
 
-	u8 tpl_levels;
-	u32 tpl_start_idx[3];
+	struct udma_tpl bchan_tpl;
+	struct udma_tpl tchan_tpl;
+	struct udma_tpl rchan_tpl;
 
 	size_t desc_align; /* alignment to use for descriptors */
 
@@ -1276,10 +1282,10 @@ static struct udma_##res *__udma_reserve_##res(struct udma_dev *ud,	\
 	} else {							\
 		int start;						\
 									\
-		if (tpl >= ud->tpl_levels)				\
-			tpl = ud->tpl_levels - 1;			\
+		if (tpl >= ud->res##_tpl.levels)			\
+			tpl = ud->res##_tpl.levels - 1;			\
 									\
-		start = ud->tpl_start_idx[tpl];				\
+		start = ud->res##_tpl.start_idx[tpl];			\
 									\
 		id = find_next_zero_bit(ud->res##_map, ud->res##_cnt,	\
 					start);				\
@@ -1292,29 +1298,14 @@ static struct udma_##res *__udma_reserve_##res(struct udma_dev *ud,	\
 	return &ud->res##s[id];						\
 }
 
+UDMA_RESERVE_RESOURCE(bchan);
 UDMA_RESERVE_RESOURCE(tchan);
 UDMA_RESERVE_RESOURCE(rchan);
 
-static struct udma_bchan *__bcdma_reserve_bchan(struct udma_dev *ud, int id)
-{
-	if (id >= 0) {
-		if (test_bit(id, ud->bchan_map)) {
-			dev_err(ud->dev, "bchan%d is in use\n", id);
-			return ERR_PTR(-ENOENT);
-		}
-	} else {
-		id = find_next_zero_bit(ud->bchan_map, ud->bchan_cnt, 0);
-		if (id == ud->bchan_cnt)
-			return ERR_PTR(-ENOENT);
-	}
-
-	set_bit(id, ud->bchan_map);
-	return &ud->bchans[id];
-}
-
 static int bcdma_get_bchan(struct udma_chan *uc)
 {
 	struct udma_dev *ud = uc->ud;
+	enum udma_tp_level tpl;
 
 	if (uc->bchan) {
 		dev_dbg(ud->dev, "chan%d: already have bchan%d allocated\n",
@@ -1322,7 +1313,16 @@ static int bcdma_get_bchan(struct udma_chan *uc)
 		return 0;
 	}
 
-	uc->bchan = __bcdma_reserve_bchan(ud, -1);
+	/*
+	 * Use normal channels for peripherals, and highest TPL channel for
+	 * mem2mem
+	 */
+	if (uc->config.tr_trigger_type)
+		tpl = 0;
+	else
+		tpl = ud->bchan_tpl.levels - 1;
+
+	uc->bchan = __udma_reserve_bchan(ud, tpl, -1);
 	if (IS_ERR(uc->bchan))
 		return PTR_ERR(uc->bchan);
 
@@ -1384,8 +1384,11 @@ static int udma_get_chan_pair(struct udma_chan *uc)
 
 	/* Can be optimized, but let's have it like this for now */
 	end = min(ud->tchan_cnt, ud->rchan_cnt);
-	/* Try to use the highest TPL channel pair for MEM_TO_MEM channels */
-	chan_id = ud->tpl_start_idx[ud->tpl_levels - 1];
+	/*
+	 * Try to use the highest TPL channel pair for MEM_TO_MEM channels
+	 * Note: in UDMAP the channel TPL is symmetric between tchan and rchan
+	 */
+	chan_id = ud->tchan_tpl.start_idx[ud->tchan_tpl.levels - 1];
 	for (; chan_id < end; chan_id++) {
 		if (!test_bit(chan_id, ud->tchan_map) &&
 		    !test_bit(chan_id, ud->rchan_map))
@@ -4036,23 +4039,27 @@ static int udma_setup_resources(struct udma_dev *ud)
 	cap3 = udma_read(ud->mmrs[MMR_GCFG], 0x2c);
 	if (of_device_is_compatible(dev->of_node,
 				    "ti,am654-navss-main-udmap")) {
-		ud->tpl_levels = 2;
-		ud->tpl_start_idx[0] = 8;
+		ud->tchan_tpl.levels = 2;
+		ud->tchan_tpl.start_idx[0] = 8;
 	} else if (of_device_is_compatible(dev->of_node,
 					   "ti,am654-navss-mcu-udmap")) {
-		ud->tpl_levels = 2;
-		ud->tpl_start_idx[0] = 2;
+		ud->tchan_tpl.levels = 2;
+		ud->tchan_tpl.start_idx[0] = 2;
 	} else if (UDMA_CAP3_UCHAN_CNT(cap3)) {
-		ud->tpl_levels = 3;
-		ud->tpl_start_idx[1] = UDMA_CAP3_UCHAN_CNT(cap3);
-		ud->tpl_start_idx[0] = UDMA_CAP3_HCHAN_CNT(cap3);
+		ud->tchan_tpl.levels = 3;
+		ud->tchan_tpl.start_idx[1] = UDMA_CAP3_UCHAN_CNT(cap3);
+		ud->tchan_tpl.start_idx[0] = UDMA_CAP3_HCHAN_CNT(cap3);
 	} else if (UDMA_CAP3_HCHAN_CNT(cap3)) {
-		ud->tpl_levels = 2;
-		ud->tpl_start_idx[0] = UDMA_CAP3_HCHAN_CNT(cap3);
+		ud->tchan_tpl.levels = 2;
+		ud->tchan_tpl.start_idx[0] = UDMA_CAP3_HCHAN_CNT(cap3);
 	} else {
-		ud->tpl_levels = 1;
+		ud->tchan_tpl.levels = 1;
 	}
 
+	ud->rchan_tpl.levels = ud->tchan_tpl.levels;
+	ud->rchan_tpl.start_idx[0] = ud->tchan_tpl.start_idx[0];
+	ud->rchan_tpl.start_idx[1] = ud->tchan_tpl.start_idx[1];
+
 	ud->tchan_map = devm_kmalloc_array(dev, BITS_TO_LONGS(ud->tchan_cnt),
 					   sizeof(unsigned long), GFP_KERNEL);
 	ud->tchans = devm_kcalloc(dev, ud->tchan_cnt, sizeof(*ud->tchans),
@@ -4174,6 +4181,43 @@ static int bcdma_setup_resources(struct udma_dev *ud)
 	struct ti_sci_resource *rm_res, irq_res;
 	struct udma_tisci_rm *tisci_rm = &ud->tisci_rm;
 	const struct udma_oes_offsets *oes = &ud->soc_data->oes;
+	u32 cap;
+
+	/* Set up the throughput level start indexes */
+	cap = udma_read(ud->mmrs[MMR_GCFG], 0x2c);
+	if (BCDMA_CAP3_UBCHAN_CNT(cap)) {
+		ud->bchan_tpl.levels = 3;
+		ud->bchan_tpl.start_idx[1] = BCDMA_CAP3_UBCHAN_CNT(cap);
+		ud->bchan_tpl.start_idx[0] = BCDMA_CAP3_HBCHAN_CNT(cap);
+	} else if (BCDMA_CAP3_HBCHAN_CNT(cap)) {
+		ud->bchan_tpl.levels = 2;
+		ud->bchan_tpl.start_idx[0] = BCDMA_CAP3_HBCHAN_CNT(cap);
+	} else {
+		ud->bchan_tpl.levels = 1;
+	}
+
+	cap = udma_read(ud->mmrs[MMR_GCFG], 0x30);
+	if (BCDMA_CAP4_URCHAN_CNT(cap)) {
+		ud->rchan_tpl.levels = 3;
+		ud->rchan_tpl.start_idx[1] = BCDMA_CAP4_URCHAN_CNT(cap);
+		ud->rchan_tpl.start_idx[0] = BCDMA_CAP4_HRCHAN_CNT(cap);
+	} else if (BCDMA_CAP4_HRCHAN_CNT(cap)) {
+		ud->rchan_tpl.levels = 2;
+		ud->rchan_tpl.start_idx[0] = BCDMA_CAP4_HRCHAN_CNT(cap);
+	} else {
+		ud->rchan_tpl.levels = 1;
+	}
+
+	if (BCDMA_CAP4_UTCHAN_CNT(cap)) {
+		ud->tchan_tpl.levels = 3;
+		ud->tchan_tpl.start_idx[1] = BCDMA_CAP4_UTCHAN_CNT(cap);
+		ud->tchan_tpl.start_idx[0] = BCDMA_CAP4_HTCHAN_CNT(cap);
+	} else if (BCDMA_CAP4_HTCHAN_CNT(cap)) {
+		ud->tchan_tpl.levels = 2;
+		ud->tchan_tpl.start_idx[0] = BCDMA_CAP4_HTCHAN_CNT(cap);
+	} else {
+		ud->tchan_tpl.levels = 1;
+	}
 
 	ud->bchan_map = devm_kmalloc_array(dev, BITS_TO_LONGS(ud->bchan_cnt),
 					   sizeof(unsigned long), GFP_KERNEL);
@@ -4199,9 +4243,6 @@ static int bcdma_setup_resources(struct udma_dev *ud)
 	    !ud->rflows)
 		return -ENOMEM;
 
-	/* TPL is not yet supported for BCDMA */
-	ud->tpl_levels = 1;
-
 	/* Get resource ranges from tisci */
 	for (i = 0; i < RM_RANGE_LAST; i++) {
 		if (i == RM_RANGE_RFLOW)
diff --git a/drivers/dma/ti/k3-udma.h b/drivers/dma/ti/k3-udma.h
index bf78ad94354a..8cb32681afaf 100644
--- a/drivers/dma/ti/k3-udma.h
+++ b/drivers/dma/ti/k3-udma.h
@@ -48,6 +48,12 @@
 #define BCDMA_CAP2_BCHAN_CNT(val)	((val) & 0x1ff)
 #define BCDMA_CAP2_TCHAN_CNT(val)	(((val) >> 9) & 0x1ff)
 #define BCDMA_CAP2_RCHAN_CNT(val)	(((val) >> 18) & 0x1ff)
+#define BCDMA_CAP3_HBCHAN_CNT(val)	(((val) >> 14) & 0x1ff)
+#define BCDMA_CAP3_UBCHAN_CNT(val)	(((val) >> 23) & 0x1ff)
+#define BCDMA_CAP4_HRCHAN_CNT(val)	((val) & 0xff)
+#define BCDMA_CAP4_URCHAN_CNT(val)	(((val) >> 8) & 0xff)
+#define BCDMA_CAP4_HTCHAN_CNT(val)	(((val) >> 16) & 0xff)
+#define BCDMA_CAP4_UTCHAN_CNT(val)	(((val) >> 24) & 0xff)
 
 /* UDMA_CHAN_RT_CTL_REG */
 #define UDMA_CHAN_RT_CTL_EN		BIT(31)
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

