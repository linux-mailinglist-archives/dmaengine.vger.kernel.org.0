Return-Path: <dmaengine+bounces-5593-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E11AE34ED
	for <lists+dmaengine@lfdr.de>; Mon, 23 Jun 2025 07:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9487716B18C
	for <lists+dmaengine@lfdr.de>; Mon, 23 Jun 2025 05:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02BF31F2BAE;
	Mon, 23 Jun 2025 05:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qRTMp6vo"
X-Original-To: dmaengine@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C275D1F1522;
	Mon, 23 Jun 2025 05:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750657121; cv=none; b=n5L67owLT6/U6Mr/AwY/3kTS7XfVvAQ/RcDBUe1cPNNtM6dCYTqHgCExUc6X/wj+cCXuhOXq1L26kaGZAf8M8TdMsTrgjoAMFuHvRNYYMCruEYYi4UcNN63z1cpI9irw9ARd4Js+mG4m7jY+9J6N6TrOti7vun9kdXpDA+S5YBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750657121; c=relaxed/simple;
	bh=246owMAwanS+hTAztOCYFFl+/UFaLISw1WF/8oq/wVo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tOIuILmZwuXRw4DuQyS3iGLSobyJiPTW7G9uEIhOdd8MOh762b16DFnDDqvSNFXMckywISzmVVdLXJ8LTqs9JHGL1V+HSy7QaezKU5ZpkIvmlyHE0TwjkHfjRcesENQ/HLBNfi29tEGYjBwD2e05Kglo0OxDrSSYFKhoVobAAUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=qRTMp6vo; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55N5cMCQ794959;
	Mon, 23 Jun 2025 00:38:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1750657102;
	bh=R4f8Z5vjyvmWtuM0Yoxi1G8FPeAeFrTOrr4Y0dTOHQg=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=qRTMp6voel6D3UWpv5YxAm0c0Gcr0tLh9hpL3VQT3iuuxvccOBDgK6A5rsFPR8B7b
	 36MvRLhS4J0RA/q9d4MqPYsgycEKCHDqrWLarrs5IRMYJdfw8v8KaaRIZfbZHNZXSi
	 F3s8GInMSUCTvI78hfemJMzBunWFjQU/YS9TtEAU=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55N5cMom2931529
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 23 Jun 2025 00:38:22 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 23
 Jun 2025 00:38:21 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 23 Jun 2025 00:38:21 -0500
Received: from uda0498651.dhcp.ti.com (uda0498651.dhcp.ti.com [172.24.227.7])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55N5bSqY3428603;
	Mon, 23 Jun 2025 00:38:16 -0500
From: Sai Sree Kartheek Adivi <s-adivi@ti.com>
To: Peter Ujfalusi <peter.ujfalusi@gmail.com>, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Santosh
 Shilimkar <ssantosh@kernel.org>,
        Sai Sree Kartheek Adivi <s-adivi@ti.com>, <dmaengine@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <praneeth@ti.com>,
        <vigneshr@ti.com>, <u-kumar1@ti.com>, <a-chavda@ti.com>,
        <p-mantena@ti.com>
Subject: [PATCH v3 09/17] dmaengine: ti: k3-udma: refactor resource setup functions
Date: Mon, 23 Jun 2025 11:07:08 +0530
Message-ID: <20250623053716.1493974-10-s-adivi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250623053716.1493974-1-s-adivi@ti.com>
References: <20250623053716.1493974-1-s-adivi@ti.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

The implementation of setup_resources, bcdma_setup_resources and
pktdma_setup_resources is largely shared between all K3 UDMA variants
with the only major difference being SCI resources setup. So,
- Move the functions to k3-udma-common.c.
- Split SCI resource setup for bcdma and pktdma into separate functions
  in variant specific driver (k3-udma.c).
- Add function pointers for setup_sci_resources in udma_dev and call
  them as part of the actual resource setup implementations in
  k3-udma-common.c to retain the existing functionality.

This refactor improves code reuse and maintainability across multiple
variants.

No functional changes intended.

Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
---
 drivers/dma/ti/k3-udma-common.c | 203 ++++++++++++++++++++++++++++++++
 drivers/dma/ti/k3-udma.c        | 181 +---------------------------
 drivers/dma/ti/k3-udma.h        |   7 ++
 3 files changed, 215 insertions(+), 176 deletions(-)

diff --git a/drivers/dma/ti/k3-udma-common.c b/drivers/dma/ti/k3-udma-common.c
index c1e8d47db2b2e..05ded8479923c 100644
--- a/drivers/dma/ti/k3-udma-common.c
+++ b/drivers/dma/ti/k3-udma-common.c
@@ -8,7 +8,9 @@
 #include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmapool.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/soc/ti/ti_sci_inta_msi.h>
 #include <linux/soc/ti/k3-ringacc.h>
 
 #include "k3-udma.h"
@@ -2284,3 +2286,204 @@ void bcdma_free_bchan_resources(struct udma_chan *uc)
 
 	bcdma_put_bchan(uc);
 }
+
+int bcdma_setup_resources(struct udma_dev *ud)
+{
+	int ret;
+	struct device *dev = ud->dev;
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
+
+	ud->bchan_map = devm_kmalloc_array(dev, BITS_TO_LONGS(ud->bchan_cnt),
+					   sizeof(unsigned long), GFP_KERNEL);
+	ud->bchans = devm_kcalloc(dev, ud->bchan_cnt, sizeof(*ud->bchans),
+				  GFP_KERNEL);
+	ud->tchan_map = devm_kmalloc_array(dev, BITS_TO_LONGS(ud->tchan_cnt),
+					   sizeof(unsigned long), GFP_KERNEL);
+	ud->tchans = devm_kcalloc(dev, ud->tchan_cnt, sizeof(*ud->tchans),
+				  GFP_KERNEL);
+	ud->rchan_map = devm_kmalloc_array(dev, BITS_TO_LONGS(ud->rchan_cnt),
+					   sizeof(unsigned long), GFP_KERNEL);
+	ud->rchans = devm_kcalloc(dev, ud->rchan_cnt, sizeof(*ud->rchans),
+				  GFP_KERNEL);
+	/* BCDMA do not really have flows, but the driver expect it */
+	ud->rflow_in_use = devm_kcalloc(dev, BITS_TO_LONGS(ud->rchan_cnt),
+					sizeof(unsigned long),
+					GFP_KERNEL);
+	ud->rflows = devm_kcalloc(dev, ud->rchan_cnt, sizeof(*ud->rflows),
+				  GFP_KERNEL);
+
+	if (!ud->bchan_map || !ud->tchan_map || !ud->rchan_map ||
+	    !ud->rflow_in_use || !ud->bchans || !ud->tchans || !ud->rchans ||
+	    !ud->rflows)
+		return -ENOMEM;
+
+	if (ud->bcdma_setup_sci_resources) {
+		ret = ud->bcdma_setup_sci_resources(ud);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+int pktdma_setup_resources(struct udma_dev *ud)
+{
+	int ret;
+	struct device *dev = ud->dev;
+	u32 cap3;
+
+	/* Set up the throughput level start indexes */
+	cap3 = udma_read(ud->mmrs[MMR_GCFG], 0x2c);
+	if (UDMA_CAP3_UCHAN_CNT(cap3)) {
+		ud->tchan_tpl.levels = 3;
+		ud->tchan_tpl.start_idx[1] = UDMA_CAP3_UCHAN_CNT(cap3);
+		ud->tchan_tpl.start_idx[0] = UDMA_CAP3_HCHAN_CNT(cap3);
+	} else if (UDMA_CAP3_HCHAN_CNT(cap3)) {
+		ud->tchan_tpl.levels = 2;
+		ud->tchan_tpl.start_idx[0] = UDMA_CAP3_HCHAN_CNT(cap3);
+	} else {
+		ud->tchan_tpl.levels = 1;
+	}
+
+	ud->rchan_tpl.levels = ud->tchan_tpl.levels;
+	ud->rchan_tpl.start_idx[0] = ud->tchan_tpl.start_idx[0];
+	ud->rchan_tpl.start_idx[1] = ud->tchan_tpl.start_idx[1];
+
+	ud->tchan_map = devm_kmalloc_array(dev, BITS_TO_LONGS(ud->tchan_cnt),
+					   sizeof(unsigned long), GFP_KERNEL);
+	ud->tchans = devm_kcalloc(dev, ud->tchan_cnt, sizeof(*ud->tchans),
+				  GFP_KERNEL);
+	ud->rchan_map = devm_kmalloc_array(dev, BITS_TO_LONGS(ud->rchan_cnt),
+					   sizeof(unsigned long), GFP_KERNEL);
+	ud->rchans = devm_kcalloc(dev, ud->rchan_cnt, sizeof(*ud->rchans),
+				  GFP_KERNEL);
+	ud->rflow_in_use = devm_kcalloc(dev, BITS_TO_LONGS(ud->rflow_cnt),
+					sizeof(unsigned long),
+					GFP_KERNEL);
+	ud->rflows = devm_kcalloc(dev, ud->rflow_cnt, sizeof(*ud->rflows),
+				  GFP_KERNEL);
+	ud->tflow_map = devm_kmalloc_array(dev, BITS_TO_LONGS(ud->tflow_cnt),
+					   sizeof(unsigned long), GFP_KERNEL);
+
+	if (!ud->tchan_map || !ud->rchan_map || !ud->tflow_map || !ud->tchans ||
+	    !ud->rchans || !ud->rflows || !ud->rflow_in_use)
+		return -ENOMEM;
+
+	if (ud->pktdma_setup_sci_resources) {
+		ret = ud->pktdma_setup_sci_resources(ud);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+int setup_resources(struct udma_dev *ud)
+{
+	struct device *dev = ud->dev;
+	int ch_count, ret;
+
+	switch (ud->match_data->type) {
+	case DMA_TYPE_UDMA:
+		ret = udma_setup_resources(ud);
+		break;
+	case DMA_TYPE_BCDMA:
+		ret = bcdma_setup_resources(ud);
+		break;
+	case DMA_TYPE_PKTDMA:
+		ret = pktdma_setup_resources(ud);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (ret)
+		return ret;
+
+	ch_count  = ud->bchan_cnt + ud->tchan_cnt + ud->rchan_cnt;
+	if (ud->bchan_cnt)
+		ch_count -= bitmap_weight(ud->bchan_map, ud->bchan_cnt);
+	ch_count -= bitmap_weight(ud->tchan_map, ud->tchan_cnt);
+	ch_count -= bitmap_weight(ud->rchan_map, ud->rchan_cnt);
+	if (!ch_count)
+		return -ENODEV;
+
+	ud->channels = devm_kcalloc(dev, ch_count, sizeof(*ud->channels),
+				    GFP_KERNEL);
+	if (!ud->channels)
+		return -ENOMEM;
+
+	switch (ud->match_data->type) {
+	case DMA_TYPE_UDMA:
+		dev_info(dev,
+			 "Channels: %d (tchan: %u, rchan: %u, gp-rflow: %u)\n",
+			 ch_count,
+			 ud->tchan_cnt - bitmap_weight(ud->tchan_map,
+						       ud->tchan_cnt),
+			 ud->rchan_cnt - bitmap_weight(ud->rchan_map,
+						       ud->rchan_cnt),
+			 ud->rflow_cnt - bitmap_weight(ud->rflow_gp_map,
+						       ud->rflow_cnt));
+		break;
+	case DMA_TYPE_BCDMA:
+		dev_info(dev,
+			 "Channels: %d (bchan: %u, tchan: %u, rchan: %u)\n",
+			 ch_count,
+			 ud->bchan_cnt - bitmap_weight(ud->bchan_map,
+						       ud->bchan_cnt),
+			 ud->tchan_cnt - bitmap_weight(ud->tchan_map,
+						       ud->tchan_cnt),
+			 ud->rchan_cnt - bitmap_weight(ud->rchan_map,
+						       ud->rchan_cnt));
+		break;
+	case DMA_TYPE_PKTDMA:
+		dev_info(dev,
+			 "Channels: %d (tchan: %u, rchan: %u)\n",
+			 ch_count,
+			 ud->tchan_cnt - bitmap_weight(ud->tchan_map,
+						       ud->tchan_cnt),
+			 ud->rchan_cnt - bitmap_weight(ud->rchan_map,
+						       ud->rchan_cnt));
+		break;
+	default:
+		break;
+	}
+
+	return ch_count;
+}
diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 3b4d33f197ed4..32a56e61fb833 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -2083,7 +2083,7 @@ static const char * const range_names[] = {
 	[RM_RANGE_TFLOW] = "ti,sci-rm-range-tflow",
 };
 
-static int udma_setup_resources(struct udma_dev *ud)
+int udma_setup_resources(struct udma_dev *ud)
 {
 	int ret, i, j;
 	struct device *dev = ud->dev;
@@ -2245,74 +2245,13 @@ static int udma_setup_resources(struct udma_dev *ud)
 	return 0;
 }
 
-static int bcdma_setup_resources(struct udma_dev *ud)
+static int bcdma_setup_sci_resources(struct udma_dev *ud)
 {
 	int ret, i, j;
 	struct device *dev = ud->dev;
 	struct ti_sci_resource *rm_res, irq_res;
 	struct udma_tisci_rm *tisci_rm = &ud->tisci_rm;
 	const struct udma_oes_offsets *oes = &ud->soc_data->oes;
-	u32 cap;
-
-	/* Set up the throughput level start indexes */
-	cap = udma_read(ud->mmrs[MMR_GCFG], 0x2c);
-	if (BCDMA_CAP3_UBCHAN_CNT(cap)) {
-		ud->bchan_tpl.levels = 3;
-		ud->bchan_tpl.start_idx[1] = BCDMA_CAP3_UBCHAN_CNT(cap);
-		ud->bchan_tpl.start_idx[0] = BCDMA_CAP3_HBCHAN_CNT(cap);
-	} else if (BCDMA_CAP3_HBCHAN_CNT(cap)) {
-		ud->bchan_tpl.levels = 2;
-		ud->bchan_tpl.start_idx[0] = BCDMA_CAP3_HBCHAN_CNT(cap);
-	} else {
-		ud->bchan_tpl.levels = 1;
-	}
-
-	cap = udma_read(ud->mmrs[MMR_GCFG], 0x30);
-	if (BCDMA_CAP4_URCHAN_CNT(cap)) {
-		ud->rchan_tpl.levels = 3;
-		ud->rchan_tpl.start_idx[1] = BCDMA_CAP4_URCHAN_CNT(cap);
-		ud->rchan_tpl.start_idx[0] = BCDMA_CAP4_HRCHAN_CNT(cap);
-	} else if (BCDMA_CAP4_HRCHAN_CNT(cap)) {
-		ud->rchan_tpl.levels = 2;
-		ud->rchan_tpl.start_idx[0] = BCDMA_CAP4_HRCHAN_CNT(cap);
-	} else {
-		ud->rchan_tpl.levels = 1;
-	}
-
-	if (BCDMA_CAP4_UTCHAN_CNT(cap)) {
-		ud->tchan_tpl.levels = 3;
-		ud->tchan_tpl.start_idx[1] = BCDMA_CAP4_UTCHAN_CNT(cap);
-		ud->tchan_tpl.start_idx[0] = BCDMA_CAP4_HTCHAN_CNT(cap);
-	} else if (BCDMA_CAP4_HTCHAN_CNT(cap)) {
-		ud->tchan_tpl.levels = 2;
-		ud->tchan_tpl.start_idx[0] = BCDMA_CAP4_HTCHAN_CNT(cap);
-	} else {
-		ud->tchan_tpl.levels = 1;
-	}
-
-	ud->bchan_map = devm_kmalloc_array(dev, BITS_TO_LONGS(ud->bchan_cnt),
-					   sizeof(unsigned long), GFP_KERNEL);
-	ud->bchans = devm_kcalloc(dev, ud->bchan_cnt, sizeof(*ud->bchans),
-				  GFP_KERNEL);
-	ud->tchan_map = devm_kmalloc_array(dev, BITS_TO_LONGS(ud->tchan_cnt),
-					   sizeof(unsigned long), GFP_KERNEL);
-	ud->tchans = devm_kcalloc(dev, ud->tchan_cnt, sizeof(*ud->tchans),
-				  GFP_KERNEL);
-	ud->rchan_map = devm_kmalloc_array(dev, BITS_TO_LONGS(ud->rchan_cnt),
-					   sizeof(unsigned long), GFP_KERNEL);
-	ud->rchans = devm_kcalloc(dev, ud->rchan_cnt, sizeof(*ud->rchans),
-				  GFP_KERNEL);
-	/* BCDMA do not really have flows, but the driver expect it */
-	ud->rflow_in_use = devm_kcalloc(dev, BITS_TO_LONGS(ud->rchan_cnt),
-					sizeof(unsigned long),
-					GFP_KERNEL);
-	ud->rflows = devm_kcalloc(dev, ud->rchan_cnt, sizeof(*ud->rflows),
-				  GFP_KERNEL);
-
-	if (!ud->bchan_map || !ud->tchan_map || !ud->rchan_map ||
-	    !ud->rflow_in_use || !ud->bchans || !ud->tchans || !ud->rchans ||
-	    !ud->rflows)
-		return -ENOMEM;
 
 	/* Get resource ranges from tisci */
 	for (i = 0; i < RM_RANGE_LAST; i++) {
@@ -2476,51 +2415,13 @@ static int bcdma_setup_resources(struct udma_dev *ud)
 	return 0;
 }
 
-static int pktdma_setup_resources(struct udma_dev *ud)
+static int pktdma_setup_sci_resources(struct udma_dev *ud)
 {
 	int ret, i, j;
 	struct device *dev = ud->dev;
 	struct ti_sci_resource *rm_res, irq_res;
 	struct udma_tisci_rm *tisci_rm = &ud->tisci_rm;
 	const struct udma_oes_offsets *oes = &ud->soc_data->oes;
-	u32 cap3;
-
-	/* Set up the throughput level start indexes */
-	cap3 = udma_read(ud->mmrs[MMR_GCFG], 0x2c);
-	if (UDMA_CAP3_UCHAN_CNT(cap3)) {
-		ud->tchan_tpl.levels = 3;
-		ud->tchan_tpl.start_idx[1] = UDMA_CAP3_UCHAN_CNT(cap3);
-		ud->tchan_tpl.start_idx[0] = UDMA_CAP3_HCHAN_CNT(cap3);
-	} else if (UDMA_CAP3_HCHAN_CNT(cap3)) {
-		ud->tchan_tpl.levels = 2;
-		ud->tchan_tpl.start_idx[0] = UDMA_CAP3_HCHAN_CNT(cap3);
-	} else {
-		ud->tchan_tpl.levels = 1;
-	}
-
-	ud->rchan_tpl.levels = ud->tchan_tpl.levels;
-	ud->rchan_tpl.start_idx[0] = ud->tchan_tpl.start_idx[0];
-	ud->rchan_tpl.start_idx[1] = ud->tchan_tpl.start_idx[1];
-
-	ud->tchan_map = devm_kmalloc_array(dev, BITS_TO_LONGS(ud->tchan_cnt),
-					   sizeof(unsigned long), GFP_KERNEL);
-	ud->tchans = devm_kcalloc(dev, ud->tchan_cnt, sizeof(*ud->tchans),
-				  GFP_KERNEL);
-	ud->rchan_map = devm_kmalloc_array(dev, BITS_TO_LONGS(ud->rchan_cnt),
-					   sizeof(unsigned long), GFP_KERNEL);
-	ud->rchans = devm_kcalloc(dev, ud->rchan_cnt, sizeof(*ud->rchans),
-				  GFP_KERNEL);
-	ud->rflow_in_use = devm_kcalloc(dev, BITS_TO_LONGS(ud->rflow_cnt),
-					sizeof(unsigned long),
-					GFP_KERNEL);
-	ud->rflows = devm_kcalloc(dev, ud->rflow_cnt, sizeof(*ud->rflows),
-				  GFP_KERNEL);
-	ud->tflow_map = devm_kmalloc_array(dev, BITS_TO_LONGS(ud->tflow_cnt),
-					   sizeof(unsigned long), GFP_KERNEL);
-
-	if (!ud->tchan_map || !ud->rchan_map || !ud->tflow_map || !ud->tchans ||
-	    !ud->rchans || !ud->rflows || !ud->rflow_in_use)
-		return -ENOMEM;
 
 	/* Get resource ranges from tisci */
 	for (i = 0; i < RM_RANGE_LAST; i++) {
@@ -2631,80 +2532,6 @@ static int pktdma_setup_resources(struct udma_dev *ud)
 	return 0;
 }
 
-static int setup_resources(struct udma_dev *ud)
-{
-	struct device *dev = ud->dev;
-	int ch_count, ret;
-
-	switch (ud->match_data->type) {
-	case DMA_TYPE_UDMA:
-		ret = udma_setup_resources(ud);
-		break;
-	case DMA_TYPE_BCDMA:
-		ret = bcdma_setup_resources(ud);
-		break;
-	case DMA_TYPE_PKTDMA:
-		ret = pktdma_setup_resources(ud);
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	if (ret)
-		return ret;
-
-	ch_count  = ud->bchan_cnt + ud->tchan_cnt + ud->rchan_cnt;
-	if (ud->bchan_cnt)
-		ch_count -= bitmap_weight(ud->bchan_map, ud->bchan_cnt);
-	ch_count -= bitmap_weight(ud->tchan_map, ud->tchan_cnt);
-	ch_count -= bitmap_weight(ud->rchan_map, ud->rchan_cnt);
-	if (!ch_count)
-		return -ENODEV;
-
-	ud->channels = devm_kcalloc(dev, ch_count, sizeof(*ud->channels),
-				    GFP_KERNEL);
-	if (!ud->channels)
-		return -ENOMEM;
-
-	switch (ud->match_data->type) {
-	case DMA_TYPE_UDMA:
-		dev_info(dev,
-			 "Channels: %d (tchan: %u, rchan: %u, gp-rflow: %u)\n",
-			 ch_count,
-			 ud->tchan_cnt - bitmap_weight(ud->tchan_map,
-						       ud->tchan_cnt),
-			 ud->rchan_cnt - bitmap_weight(ud->rchan_map,
-						       ud->rchan_cnt),
-			 ud->rflow_cnt - bitmap_weight(ud->rflow_gp_map,
-						       ud->rflow_cnt));
-		break;
-	case DMA_TYPE_BCDMA:
-		dev_info(dev,
-			 "Channels: %d (bchan: %u, tchan: %u, rchan: %u)\n",
-			 ch_count,
-			 ud->bchan_cnt - bitmap_weight(ud->bchan_map,
-						       ud->bchan_cnt),
-			 ud->tchan_cnt - bitmap_weight(ud->tchan_map,
-						       ud->tchan_cnt),
-			 ud->rchan_cnt - bitmap_weight(ud->rchan_map,
-						       ud->rchan_cnt));
-		break;
-	case DMA_TYPE_PKTDMA:
-		dev_info(dev,
-			 "Channels: %d (tchan: %u, rchan: %u)\n",
-			 ch_count,
-			 ud->tchan_cnt - bitmap_weight(ud->tchan_map,
-						       ud->tchan_cnt),
-			 ud->rchan_cnt - bitmap_weight(ud->rchan_map,
-						       ud->rchan_cnt));
-		break;
-	default:
-		break;
-	}
-
-	return ch_count;
-}
-
 static int udma_probe(struct platform_device *pdev)
 {
 	struct device_node *navss_node = pdev->dev.parent->of_node;
@@ -2745,6 +2572,8 @@ static int udma_probe(struct platform_device *pdev)
 	ud->stop = udma_stop;
 	ud->reset_chan = udma_reset_chan;
 	ud->decrement_byte_counters = udma_decrement_byte_counters;
+	ud->bcdma_setup_sci_resources = bcdma_setup_sci_resources;
+	ud->pktdma_setup_sci_resources = pktdma_setup_sci_resources;
 
 	ret = udma_get_mmrs(pdev, ud);
 	if (ret)
diff --git a/drivers/dma/ti/k3-udma.h b/drivers/dma/ti/k3-udma.h
index df17f01f06a56..f1983025e108f 100644
--- a/drivers/dma/ti/k3-udma.h
+++ b/drivers/dma/ti/k3-udma.h
@@ -349,6 +349,8 @@ struct udma_dev {
 	int (*stop)(struct udma_chan *uc);
 	int (*reset_chan)(struct udma_chan *uc, bool hard);
 	void (*decrement_byte_counters)(struct udma_chan *uc, u32 val);
+	int (*bcdma_setup_sci_resources)(struct udma_dev *ud);
+	int (*pktdma_setup_sci_resources)(struct udma_dev *ud);
 };
 
 struct udma_desc {
@@ -671,6 +673,11 @@ struct udma_bchan *__udma_reserve_bchan(struct udma_dev *ud, enum udma_tp_level
 struct udma_tchan *__udma_reserve_tchan(struct udma_dev *ud, enum udma_tp_level tpl, int id);
 struct udma_rchan *__udma_reserve_rchan(struct udma_dev *ud, enum udma_tp_level tpl, int id);
 
+int udma_setup_resources(struct udma_dev *ud);
+int bcdma_setup_resources(struct udma_dev *ud);
+int pktdma_setup_resources(struct udma_dev *ud);
+int setup_resources(struct udma_dev *ud);
+
 /* Direct access to UDMA low lever resources for the glue layer */
 int xudma_navss_psil_pair(struct udma_dev *ud, u32 src_thread, u32 dst_thread);
 int xudma_navss_psil_unpair(struct udma_dev *ud, u32 src_thread,
-- 
2.34.1


