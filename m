Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C51DE27E4DC
	for <lists+dmaengine@lfdr.de>; Wed, 30 Sep 2020 11:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729243AbgI3JP3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 30 Sep 2020 05:15:29 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:35064 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728957AbgI3JOW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 30 Sep 2020 05:14:22 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08U9EHkW034980;
        Wed, 30 Sep 2020 04:14:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601457257;
        bh=DYA/H5vm9+3x5eXfOQH9d6aiZorGnTpzvLz7q7IKrrs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=GJ28ZA3YSfzd2/aCM26LPUHAU80Psi634thOumnDBIpN0+LQ+xUG5ch9DeLiwTE68
         gpDaNLuFwk516Z4XAIf8w/uoTM7NxofrXynUONkOqiK+4ZF1F32eDefKxp/d0f5Y/9
         7fljVlwovugOPqv1nIy6G1K1jilJQ4JB/0q+x2g4=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08U9EHVj111747
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 30 Sep 2020 04:14:17 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 30
 Sep 2020 04:14:17 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 30 Sep 2020 04:14:16 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08U9DuJd116385;
        Wed, 30 Sep 2020 04:14:14 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <nm@ti.com>, <ssantosh@kernel.org>,
        <robh+dt@kernel.org>, <vigneshr@ti.com>
CC:     <dan.j.williams@intel.com>, <t-kristo@ti.com>,
        <lokeshvutla@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <dmaengine@vger.kernel.org>
Subject: [PATCH 06/18] dmaengine: ti: k3-udma: Add support for second resource range from sysfw
Date:   Wed, 30 Sep 2020 12:14:00 +0300
Message-ID: <20200930091412.8020-7-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930091412.8020-1-peter.ujfalusi@ti.com>
References: <20200930091412.8020-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Resource allocation via sysfw can use up to two ranges per resource subtype
to support more complex resource assignment, mainly for DMA channels.

Take the second range also into consideration when setting up the maps for
available resources.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/ti/k3-udma.c | 55 ++++++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 24 deletions(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 3f798993a8b1..1ae5d09e2059 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -3179,12 +3179,22 @@ static int udma_get_mmrs(struct platform_device *pdev, struct udma_dev *ud)
 	return 0;
 }
 
+static void udma_mark_resource_ranges(struct udma_dev *ud, unsigned long *map,
+				      struct ti_sci_resource_desc *rm_desc,
+				      char *name)
+{
+	bitmap_clear(map, rm_desc->start, rm_desc->num);
+	bitmap_clear(map, rm_desc->start_sec, rm_desc->num_sec);
+	dev_dbg(ud->dev, "ti_sci resource range for %s: %d:%d | %d:%d\n", name,
+		rm_desc->start, rm_desc->num, rm_desc->start_sec,
+		rm_desc->num_sec);
+}
+
 static int udma_setup_resources(struct udma_dev *ud)
 {
 	struct device *dev = ud->dev;
 	int ch_count, ret, i, j;
 	u32 cap2, cap3;
-	struct ti_sci_resource_desc *rm_desc;
 	struct ti_sci_resource *rm_res, irq_res;
 	struct udma_tisci_rm *tisci_rm = &ud->tisci_rm;
 	static const char * const range_names[] = { "ti,sci-rm-range-tchan",
@@ -3270,13 +3280,9 @@ static int udma_setup_resources(struct udma_dev *ud)
 		bitmap_zero(ud->tchan_map, ud->tchan_cnt);
 	} else {
 		bitmap_fill(ud->tchan_map, ud->tchan_cnt);
-		for (i = 0; i < rm_res->sets; i++) {
-			rm_desc = &rm_res->desc[i];
-			bitmap_clear(ud->tchan_map, rm_desc->start,
-				     rm_desc->num);
-			dev_dbg(dev, "ti-sci-res: tchan: %d:%d\n",
-				rm_desc->start, rm_desc->num);
-		}
+		for (i = 0; i < rm_res->sets; i++)
+			udma_mark_resource_ranges(ud, ud->tchan_map,
+						  &rm_res->desc[i], "tchan");
 	}
 	irq_res.sets = rm_res->sets;
 
@@ -3286,13 +3292,9 @@ static int udma_setup_resources(struct udma_dev *ud)
 		bitmap_zero(ud->rchan_map, ud->rchan_cnt);
 	} else {
 		bitmap_fill(ud->rchan_map, ud->rchan_cnt);
-		for (i = 0; i < rm_res->sets; i++) {
-			rm_desc = &rm_res->desc[i];
-			bitmap_clear(ud->rchan_map, rm_desc->start,
-				     rm_desc->num);
-			dev_dbg(dev, "ti-sci-res: rchan: %d:%d\n",
-				rm_desc->start, rm_desc->num);
-		}
+		for (i = 0; i < rm_res->sets; i++)
+			udma_mark_resource_ranges(ud, ud->rchan_map,
+						  &rm_res->desc[i], "rchan");
 	}
 
 	irq_res.sets += rm_res->sets;
@@ -3301,12 +3303,21 @@ static int udma_setup_resources(struct udma_dev *ud)
 	for (i = 0; i < rm_res->sets; i++) {
 		irq_res.desc[i].start = rm_res->desc[i].start;
 		irq_res.desc[i].num = rm_res->desc[i].num;
+		irq_res.desc[i].start_sec = rm_res->desc[i].start_sec;
+		irq_res.desc[i].num_sec = rm_res->desc[i].num_sec;
 	}
 	rm_res = tisci_rm->rm_ranges[RM_RANGE_RCHAN];
 	for (j = 0; j < rm_res->sets; j++, i++) {
-		irq_res.desc[i].start = rm_res->desc[j].start +
+		if (rm_res->desc[j].num) {
+			irq_res.desc[i].start = rm_res->desc[j].start +
 					ud->soc_data->rchan_oes_offset;
-		irq_res.desc[i].num = rm_res->desc[j].num;
+			irq_res.desc[i].num = rm_res->desc[j].num;
+		}
+		if (rm_res->desc[j].num_sec) {
+			irq_res.desc[i].start_sec = rm_res->desc[j].start_sec +
+					ud->soc_data->rchan_oes_offset;
+			irq_res.desc[i].num_sec = rm_res->desc[j].num_sec;
+		}
 	}
 	ret = ti_sci_inta_msi_domain_alloc_irqs(ud->dev, &irq_res);
 	kfree(irq_res.desc);
@@ -3322,13 +3333,9 @@ static int udma_setup_resources(struct udma_dev *ud)
 		bitmap_clear(ud->rflow_gp_map, ud->rchan_cnt,
 			     ud->rflow_cnt - ud->rchan_cnt);
 	} else {
-		for (i = 0; i < rm_res->sets; i++) {
-			rm_desc = &rm_res->desc[i];
-			bitmap_clear(ud->rflow_gp_map, rm_desc->start,
-				     rm_desc->num);
-			dev_dbg(dev, "ti-sci-res: rflow: %d:%d\n",
-				rm_desc->start, rm_desc->num);
-		}
+		for (i = 0; i < rm_res->sets; i++)
+			udma_mark_resource_ranges(ud, ud->rflow_gp_map,
+						  &rm_res->desc[i], "gp-rflow");
 	}
 
 	ch_count -= bitmap_weight(ud->tchan_map, ud->tchan_cnt);
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

