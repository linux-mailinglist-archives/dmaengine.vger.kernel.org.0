Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55725223B21
	for <lists+dmaengine@lfdr.de>; Fri, 17 Jul 2020 14:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgGQMIF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Jul 2020 08:08:05 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:49382 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbgGQMIE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 17 Jul 2020 08:08:04 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06HC80M5091212;
        Fri, 17 Jul 2020 07:08:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1594987680;
        bh=vx0I9HtZhwY/uU0ejTh9MR36PqE14Scc3wFhUPNqLQs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=hT4CaL3/URZUyy8Mn62QWuMa+Lsn9jSZ2iIxVkf2h8BoiYopxqVPPV7XbDDGdn6Q5
         krye3ppHftO4QN25lFAwmkOglg4L47prDx3d+BmzrjOZP/RvEnHxG/5VrdAyphvS4a
         1zLkMJye4yhd0ZdSyoWzjTLxKKbqNLY/kXBcLHos=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06HC80mU108073
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 17 Jul 2020 07:08:00 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 17
 Jul 2020 07:07:59 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 17 Jul 2020 07:07:59 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06HC7t1Y043751;
        Fri, 17 Jul 2020 07:07:58 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <dan.j.williams@intel.com>
Subject: [PATCH 2/2] dmaengine: ti: k3-udma: Query throughput level information from hardware
Date:   Fri, 17 Jul 2020 15:09:03 +0300
Message-ID: <20200717120903.8774-3-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200717120903.8774-1-peter.ujfalusi@ti.com>
References: <20200717120903.8774-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The CAP3 register contains information about the number of
HCHAN (High Capacity) and UCHAN (Ultra High Capacity) channels in UDMAP.

Based on this information the start indexes of the levels can be calculated
without a need of a table in the match data.

On am654 the CAP3 does not contain information about the number different
channels. Set up the tpl information based on the available documentation.

This change will allow to use the same compatible for different SoCs where
the only difference is the number of channel types.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/ti/k3-udma.c | 57 ++++++++++++++++++++--------------------
 drivers/dma/ti/k3-udma.h |  2 ++
 2 files changed, 30 insertions(+), 29 deletions(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 0ac6c440f536..d159c793d625 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -92,9 +92,6 @@ struct udma_match_data {
 	u32 flags;
 	u32 statictr_z_mask;
 	u32 rchan_oes_offset;
-
-	u8 tpl_levels;
-	u32 level_start_idx[];
 };
 
 struct udma_hwdesc {
@@ -121,6 +118,9 @@ struct udma_dev {
 	void __iomem *mmrs[MMR_LAST];
 	const struct udma_match_data *match_data;
 
+	u8 tpl_levels;
+	u32 tpl_start_idx[3];
+
 	size_t desc_align; /* alignment to use for descriptors */
 
 	struct udma_tisci_rm tisci_rm;
@@ -1210,10 +1210,10 @@ static struct udma_##res *__udma_reserve_##res(struct udma_dev *ud,	\
 	} else {							\
 		int start;						\
 									\
-		if (tpl >= ud->match_data->tpl_levels)			\
-			tpl = ud->match_data->tpl_levels - 1;		\
+		if (tpl >= ud->tpl_levels)				\
+			tpl = ud->tpl_levels - 1;			\
 									\
-		start = ud->match_data->level_start_idx[tpl];		\
+		start = ud->tpl_start_idx[tpl];				\
 									\
 		id = find_next_zero_bit(ud->res##_map, ud->res##_cnt,	\
 					start);				\
@@ -1262,7 +1262,6 @@ static int udma_get_rchan(struct udma_chan *uc)
 static int udma_get_chan_pair(struct udma_chan *uc)
 {
 	struct udma_dev *ud = uc->ud;
-	const struct udma_match_data *match_data = ud->match_data;
 	int chan_id, end;
 
 	if ((uc->tchan && uc->rchan) && uc->tchan->id == uc->rchan->id) {
@@ -1284,7 +1283,7 @@ static int udma_get_chan_pair(struct udma_chan *uc)
 	/* Can be optimized, but let's have it like this for now */
 	end = min(ud->tchan_cnt, ud->rchan_cnt);
 	/* Try to use the highest TPL channel pair for MEM_TO_MEM channels */
-	chan_id = match_data->level_start_idx[match_data->tpl_levels - 1];
+	chan_id = ud->tpl_start_idx[ud->tpl_levels - 1];
 	for (; chan_id < end; chan_id++) {
 		if (!test_bit(chan_id, ud->tchan_map) &&
 		    !test_bit(chan_id, ud->rchan_map))
@@ -3115,11 +3114,6 @@ static struct udma_match_data am654_main_data = {
 	.enable_memcpy_support = true,
 	.statictr_z_mask = GENMASK(11, 0),
 	.rchan_oes_offset = 0x2000,
-	.tpl_levels = 2,
-	.level_start_idx = {
-		[0] = 8, /* Normal channels */
-		[1] = 0, /* High Throughput channels */
-	},
 };
 
 static struct udma_match_data am654_mcu_data = {
@@ -3127,11 +3121,6 @@ static struct udma_match_data am654_mcu_data = {
 	.enable_memcpy_support = false,
 	.statictr_z_mask = GENMASK(11, 0),
 	.rchan_oes_offset = 0x2000,
-	.tpl_levels = 2,
-	.level_start_idx = {
-		[0] = 2, /* Normal channels */
-		[1] = 0, /* High Throughput channels */
-	},
 };
 
 static struct udma_match_data j721e_main_data = {
@@ -3140,12 +3129,6 @@ static struct udma_match_data j721e_main_data = {
 	.flags = UDMA_FLAG_PDMA_ACC32 | UDMA_FLAG_PDMA_BURST,
 	.statictr_z_mask = GENMASK(23, 0),
 	.rchan_oes_offset = 0x400,
-	.tpl_levels = 3,
-	.level_start_idx = {
-		[0] = 16, /* Normal channels */
-		[1] = 4, /* High Throughput channels */
-		[2] = 0, /* Ultra High Throughput channels */
-	},
 };
 
 static struct udma_match_data j721e_mcu_data = {
@@ -3154,11 +3137,6 @@ static struct udma_match_data j721e_mcu_data = {
 	.flags = UDMA_FLAG_PDMA_ACC32 | UDMA_FLAG_PDMA_BURST,
 	.statictr_z_mask = GENMASK(23, 0),
 	.rchan_oes_offset = 0x400,
-	.tpl_levels = 2,
-	.level_start_idx = {
-		[0] = 2, /* Normal channels */
-		[1] = 0, /* High Throughput channels */
-	},
 };
 
 static const struct of_device_id udma_of_match[] = {
@@ -3216,6 +3194,27 @@ static int udma_setup_resources(struct udma_dev *ud)
 	ud->rchan_cnt = UDMA_CAP2_RCHAN_CNT(cap2);
 	ch_count  = ud->tchan_cnt + ud->rchan_cnt;
 
+	/* Set up the throughput level start indexes */
+	if (of_device_is_compatible(dev->of_node,
+				    "ti,am654-navss-main-udmap")) {
+		ud->tpl_levels = 2;
+		ud->tpl_start_idx[0] = 8;
+	} else if (of_device_is_compatible(dev->of_node,
+					   "ti,am654-navss-mcu-udmap")) {
+		ud->tpl_levels = 2;
+		ud->tpl_start_idx[0] = 2;
+	} else if (UDMA_CAP3_UCHAN_CNT(cap3)) {
+		ud->tpl_levels = 3;
+		ud->tpl_start_idx[1] = UDMA_CAP3_UCHAN_CNT(cap3);
+		ud->tpl_start_idx[0] = ud->tpl_start_idx[1] +
+				       UDMA_CAP3_HCHAN_CNT(cap3);
+	} else if (UDMA_CAP3_HCHAN_CNT(cap3)) {
+		ud->tpl_levels = 2;
+		ud->tpl_start_idx[0] = UDMA_CAP3_HCHAN_CNT(cap3);
+	} else {
+		ud->tpl_levels = 1;
+	}
+
 	ud->tchan_map = devm_kmalloc_array(dev, BITS_TO_LONGS(ud->tchan_cnt),
 					   sizeof(unsigned long), GFP_KERNEL);
 	ud->tchans = devm_kcalloc(dev, ud->tchan_cnt, sizeof(*ud->tchans),
diff --git a/drivers/dma/ti/k3-udma.h b/drivers/dma/ti/k3-udma.h
index 9534f0ca29f4..09c4529e013d 100644
--- a/drivers/dma/ti/k3-udma.h
+++ b/drivers/dma/ti/k3-udma.h
@@ -42,6 +42,8 @@
 #define UDMA_CAP2_ECHAN_CNT(val)	(((val) >> 9) & 0x1ff)
 #define UDMA_CAP2_RCHAN_CNT(val)	(((val) >> 18) & 0x1ff)
 #define UDMA_CAP3_RFLOW_CNT(val)	((val) & 0x3fff)
+#define UDMA_CAP3_HCHAN_CNT(val)	(((val) >> 14) & 0x1ff)
+#define UDMA_CAP3_UCHAN_CNT(val)	(((val) >> 23) & 0x1ff)
 
 /* UDMA_CHAN_RT_CTL_REG */
 #define UDMA_CHAN_RT_CTL_EN		BIT(31)
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

