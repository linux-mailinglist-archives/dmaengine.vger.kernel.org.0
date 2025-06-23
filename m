Return-Path: <dmaengine+bounces-5589-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A91AE34E1
	for <lists+dmaengine@lfdr.de>; Mon, 23 Jun 2025 07:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01D7B188A411
	for <lists+dmaengine@lfdr.de>; Mon, 23 Jun 2025 05:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6BEA1E5B8A;
	Mon, 23 Jun 2025 05:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QGDm0gU2"
X-Original-To: dmaengine@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46841E5B7A;
	Mon, 23 Jun 2025 05:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750657093; cv=none; b=E5c9MdJYNFQcAAiP5cQm7jvS950ZEmLxTZJqIgIbIrLwMz3W1lTvkf8RAzDg3VGx9lH/YW4JLPQAxNYVovRXuSmN3uT069190QYm2dM7ZoZM3rbIqTiZ+jmVmmHBFfxkWqI4kI9I9yrM2zGnP8HYXQ9IDBKnjzP19Wpz+4QeEEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750657093; c=relaxed/simple;
	bh=lyH0a0ksiZID0JhvKcaKKwzeGhiuQlzN9ToNYhRHEps=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j+B7rJ5c6cAVoxtuFPx0eBg7leXMQSXtvitcAoqX1ryqwU1H4Eg7jNBAvesKl4jz3j7HNWC6jLVkGbRhq5BjCJEl0XQbonSDEd70xURAaH1aq/PfFQhGv7yNHJPRceQZmaI1ysjN4tJuD6DzdiL8idT/yJh7kWbJqHqstjchuAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=QGDm0gU2; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 55N5c6j21393193;
	Mon, 23 Jun 2025 00:38:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1750657086;
	bh=pw2ER6SBG/IISjyjxgmZAlUHQV2vo4+rOyme5Sovtjo=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=QGDm0gU23+t9Y5XekNOtz7gnqQevvU5AI32gIbMFGM0avkyBULC3jO+okLWRcFstB
	 xrwnt8ZA6BevXMWeL8/k35nvvMVOsVj0KmkrGrK8BuNqBH+TkFQWyRoZmqqbb1CtsU
	 z6BDYI9T284bpfVDJUhxsXXmRjWp9XVKV7y/yGGE=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 55N5c62p183890
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Mon, 23 Jun 2025 00:38:06 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 23
 Jun 2025 00:38:05 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 23 Jun 2025 00:38:05 -0500
Received: from uda0498651.dhcp.ti.com (uda0498651.dhcp.ti.com [172.24.227.7])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 55N5bSqV3428603;
	Mon, 23 Jun 2025 00:38:00 -0500
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
Subject: [PATCH v3 06/17] dmaengine: ti: k3-udma: Add variant-specific function pointers to udma_dev
Date: Mon, 23 Jun 2025 11:07:05 +0530
Message-ID: <20250623053716.1493974-7-s-adivi@ti.com>
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

Introduce function pointers in the udma_dev structure to allow
variant-specific implementations for certain operations.
This prepares the driver for supporting multiple K3 UDMA variants,
such as UDMA v2, with minimal code duplication.

No functional changes intended in this commit.

Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
---
 drivers/dma/ti/k3-udma.c | 38 ++++++++++++++++++++++----------------
 drivers/dma/ti/k3-udma.h |  5 +++++
 2 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 214a1ca1e1776..740ccc6c675c3 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -329,7 +329,7 @@ static int udma_start(struct udma_chan *uc)
 	}
 
 	/* Make sure that we clear the teardown bit, if it is set */
-	udma_reset_chan(uc, false);
+	uc->ud->reset_chan(uc, false);
 
 	/* Push descriptors before we start the channel */
 	udma_start_desc(uc);
@@ -521,8 +521,8 @@ static void udma_check_tx_completion(struct work_struct *work)
 		if (uc->desc) {
 			struct udma_desc *d = uc->desc;
 
-			udma_decrement_byte_counters(uc, d->residue);
-			udma_start(uc);
+			uc->ud->decrement_byte_counters(uc, d->residue);
+			uc->ud->start(uc);
 			vchan_cookie_complete(&d->vd);
 			break;
 		}
@@ -554,7 +554,7 @@ static irqreturn_t udma_ring_irq_handler(int irq, void *data)
 		}
 
 		if (!uc->desc)
-			udma_start(uc);
+			uc->ud->start(uc);
 
 		goto out;
 	}
@@ -576,8 +576,8 @@ static irqreturn_t udma_ring_irq_handler(int irq, void *data)
 				vchan_cyclic_callback(&d->vd);
 			} else {
 				if (udma_is_desc_really_done(uc, d)) {
-					udma_decrement_byte_counters(uc, d->residue);
-					udma_start(uc);
+					uc->ud->decrement_byte_counters(uc, d->residue);
+					uc->ud->start(uc);
 					vchan_cookie_complete(&d->vd);
 				} else {
 					schedule_delayed_work(&uc->tx_drain.work,
@@ -612,8 +612,8 @@ static irqreturn_t udma_udma_irq_handler(int irq, void *data)
 			vchan_cyclic_callback(&d->vd);
 		} else {
 			/* TODO: figure out the real amount of data */
-			udma_decrement_byte_counters(uc, d->residue);
-			udma_start(uc);
+			uc->ud->decrement_byte_counters(uc, d->residue);
+			uc->ud->start(uc);
 			vchan_cookie_complete(&d->vd);
 		}
 	}
@@ -1654,7 +1654,7 @@ static int udma_alloc_chan_resources(struct dma_chan *chan)
 
 	if (udma_is_chan_running(uc)) {
 		dev_warn(ud->dev, "chan%d: is running!\n", uc->id);
-		udma_reset_chan(uc, false);
+		ud->reset_chan(uc, false);
 		if (udma_is_chan_running(uc)) {
 			dev_err(ud->dev, "chan%d: won't stop!\n", uc->id);
 			ret = -EBUSY;
@@ -1821,7 +1821,7 @@ static int bcdma_alloc_chan_resources(struct dma_chan *chan)
 
 	if (udma_is_chan_running(uc)) {
 		dev_warn(ud->dev, "chan%d: is running!\n", uc->id);
-		udma_reset_chan(uc, false);
+		ud->reset_chan(uc, false);
 		if (udma_is_chan_running(uc)) {
 			dev_err(ud->dev, "chan%d: won't stop!\n", uc->id);
 			ret = -EBUSY;
@@ -2014,7 +2014,7 @@ static int pktdma_alloc_chan_resources(struct dma_chan *chan)
 
 	if (udma_is_chan_running(uc)) {
 		dev_warn(ud->dev, "chan%d: is running!\n", uc->id);
-		udma_reset_chan(uc, false);
+		ud->reset_chan(uc, false);
 		if (udma_is_chan_running(uc)) {
 			dev_err(ud->dev, "chan%d: won't stop!\n", uc->id);
 			ret = -EBUSY;
@@ -2123,7 +2123,7 @@ static void udma_issue_pending(struct dma_chan *chan)
 		 */
 		if (!(uc->state == UDMA_CHAN_IS_TERMINATING &&
 		      udma_is_chan_running(uc)))
-			udma_start(uc);
+			uc->ud->start(uc);
 	}
 
 	spin_unlock_irqrestore(&uc->vc.lock, flags);
@@ -2265,7 +2265,7 @@ static int udma_terminate_all(struct dma_chan *chan)
 	spin_lock_irqsave(&uc->vc.lock, flags);
 
 	if (udma_is_chan_running(uc))
-		udma_stop(uc);
+		uc->ud->stop(uc);
 
 	if (uc->desc) {
 		uc->terminated_desc = uc->desc;
@@ -2297,11 +2297,11 @@ static void udma_synchronize(struct dma_chan *chan)
 			dev_warn(uc->ud->dev, "chan%d teardown timeout!\n",
 				 uc->id);
 			udma_dump_chan_stdata(uc);
-			udma_reset_chan(uc, true);
+			uc->ud->reset_chan(uc, true);
 		}
 	}
 
-	udma_reset_chan(uc, false);
+	uc->ud->reset_chan(uc, false);
 	if (udma_is_chan_running(uc))
 		dev_warn(uc->ud->dev, "chan%d refused to stop!\n", uc->id);
 
@@ -2355,7 +2355,7 @@ static void udma_free_chan_resources(struct dma_chan *chan)
 
 	udma_terminate_all(chan);
 	if (uc->terminated_desc) {
-		udma_reset_chan(uc, false);
+		ud->reset_chan(uc, false);
 		udma_reset_rings(uc);
 	}
 
@@ -3694,6 +3694,12 @@ static int udma_probe(struct platform_device *pdev)
 		ud->soc_data = soc->data;
 	}
 
+	// Setup function pointers
+	ud->start = udma_start;
+	ud->stop = udma_stop;
+	ud->reset_chan = udma_reset_chan;
+	ud->decrement_byte_counters = udma_decrement_byte_counters;
+
 	ret = udma_get_mmrs(pdev, ud);
 	if (ret)
 		return ret;
diff --git a/drivers/dma/ti/k3-udma.h b/drivers/dma/ti/k3-udma.h
index 4c6e5b946d5cf..8ab28f5ec0561 100644
--- a/drivers/dma/ti/k3-udma.h
+++ b/drivers/dma/ti/k3-udma.h
@@ -344,6 +344,11 @@ struct udma_dev {
 	u32 psil_base;
 	u32 atype;
 	u32 asel;
+
+	int (*start)(struct udma_chan *uc);
+	int (*stop)(struct udma_chan *uc);
+	int (*reset_chan)(struct udma_chan *uc, bool hard);
+	void (*decrement_byte_counters)(struct udma_chan *uc, u32 val);
 };
 
 struct udma_desc {
-- 
2.34.1


