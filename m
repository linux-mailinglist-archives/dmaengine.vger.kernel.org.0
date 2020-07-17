Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02D7D223C3E
	for <lists+dmaengine@lfdr.de>; Fri, 17 Jul 2020 15:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbgGQNUj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Jul 2020 09:20:39 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:59538 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbgGQNUh (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 17 Jul 2020 09:20:37 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06HDKVnt112010;
        Fri, 17 Jul 2020 08:20:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1594992031;
        bh=g2E9/OtG5pDmr71jvOCfQ5BfNj0uQlsil5jQ6Wu6vv4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=uCCfxM31RGjYGPUtXo+o1TAGIbIN2nV4OEHv2GBlXGSGAd+SW5qOFudWjKkI0+++d
         nYTH57RhvlieYTv8XGb1b6q7yugfgmPWViKiq364v+jBO4TDzcJYGeWWJfV15WLsC7
         ki6L4LeK9Q3MQxuVft59PlXNPuxeLZyqAH7cQ7hE=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06HDKVaU060314;
        Fri, 17 Jul 2020 08:20:31 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 17
 Jul 2020 08:20:31 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 17 Jul 2020 08:20:31 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06HDKU1t130401;
        Fri, 17 Jul 2020 08:20:30 -0500
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <dmaengine@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH next v2 2/6] soc: ti: k3-ringacc: Move state tracking variables under a struct
Date:   Fri, 17 Jul 2020 16:20:15 +0300
Message-ID: <20200717132019.20427-3-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200717132019.20427-1-grygorii.strashko@ti.com>
References: <20200717132019.20427-1-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Peter Ujfalusi <peter.ujfalusi@ti.com>

Move the free, occ, windex and rindex under a struct. We can use memset to
zero them and it will allow a cleaner way to extend driver functionality in
the future,

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/soc/ti/k3-ringacc.c | 99 +++++++++++++++++++------------------
 1 file changed, 51 insertions(+), 48 deletions(-)

diff --git a/drivers/soc/ti/k3-ringacc.c b/drivers/soc/ti/k3-ringacc.c
index 19156f15af0a..d2dc9c144a89 100644
--- a/drivers/soc/ti/k3-ringacc.c
+++ b/drivers/soc/ti/k3-ringacc.c
@@ -108,6 +108,21 @@ struct k3_ring_ops {
 	int (*pop_head)(struct k3_ring *ring, void *elm);
 };
 
+/**
+ * struct k3_ring_state - Internal state tracking structure
+ *
+ * @free: Number of free entries
+ * @occ: Occupancy
+ * @windex: Write index
+ * @rindex: Read index
+ */
+struct k3_ring_state {
+	u32 free;
+	u32 occ;
+	u32 windex;
+	u32 rindex;
+};
+
 /**
  * struct k3_ring - RA Ring descriptor
  *
@@ -121,10 +136,6 @@ struct k3_ring_ops {
  * @elm_size: Size of the ring element
  * @mode: Ring mode
  * @flags: flags
- * @free: Number of free elements
- * @occ: Ring occupancy
- * @windex: Write index (only for @K3_RINGACC_RING_MODE_RING)
- * @rindex: Read index (only for @K3_RINGACC_RING_MODE_RING)
  * @ring_id: Ring Id
  * @parent: Pointer on struct @k3_ringacc
  * @use_count: Use count for shared rings
@@ -143,10 +154,7 @@ struct k3_ring {
 	u32		flags;
 #define K3_RING_FLAG_BUSY	BIT(1)
 #define K3_RING_FLAG_SHARED	BIT(2)
-	u32		free;
-	u32		occ;
-	u32		windex;
-	u32		rindex;
+	struct k3_ring_state state;
 	u32		ring_id;
 	struct k3_ringacc	*parent;
 	u32		use_count;
@@ -339,10 +347,7 @@ void k3_ringacc_ring_reset(struct k3_ring *ring)
 	if (!ring || !(ring->flags & K3_RING_FLAG_BUSY))
 		return;
 
-	ring->occ = 0;
-	ring->free = 0;
-	ring->rindex = 0;
-	ring->windex = 0;
+	memset(&ring->state, 0, sizeof(ring->state));
 
 	k3_ringacc_ring_reset_sci(ring);
 }
@@ -592,10 +597,7 @@ int k3_ringacc_ring_cfg(struct k3_ring *ring, struct k3_ring_cfg *cfg)
 	ring->size = cfg->size;
 	ring->elm_size = cfg->elm_size;
 	ring->mode = cfg->mode;
-	ring->occ = 0;
-	ring->free = 0;
-	ring->rindex = 0;
-	ring->windex = 0;
+	memset(&ring->state, 0, sizeof(ring->state));
 
 	if (ring->proxy_id != K3_RINGACC_PROXY_NOT_USED)
 		ring->proxy = ringacc->proxy_target_base +
@@ -666,10 +668,10 @@ u32 k3_ringacc_ring_get_free(struct k3_ring *ring)
 	if (!ring || !(ring->flags & K3_RING_FLAG_BUSY))
 		return -EINVAL;
 
-	if (!ring->free)
-		ring->free = ring->size - readl(&ring->rt->occ);
+	if (!ring->state.free)
+		ring->state.free = ring->size - readl(&ring->rt->occ);
 
-	return ring->free;
+	return ring->state.free;
 }
 EXPORT_SYMBOL_GPL(k3_ringacc_ring_get_free);
 
@@ -740,7 +742,7 @@ static int k3_ringacc_ring_access_proxy(struct k3_ring *ring, void *elem,
 			"proxy:memcpy_fromio(x): --> ptr(%p), mode:%d\n", ptr,
 			access_mode);
 		memcpy_fromio(elem, ptr, (4 << ring->elm_size));
-		ring->occ--;
+		ring->state.occ--;
 		break;
 	case K3_RINGACC_ACCESS_MODE_PUSH_TAIL:
 	case K3_RINGACC_ACCESS_MODE_PUSH_HEAD:
@@ -748,14 +750,14 @@ static int k3_ringacc_ring_access_proxy(struct k3_ring *ring, void *elem,
 			"proxy:memcpy_toio(x): --> ptr(%p), mode:%d\n", ptr,
 			access_mode);
 		memcpy_toio(ptr, elem, (4 << ring->elm_size));
-		ring->free--;
+		ring->state.free--;
 		break;
 	default:
 		return -EINVAL;
 	}
 
-	dev_dbg(ring->parent->dev, "proxy: free%d occ%d\n", ring->free,
-		ring->occ);
+	dev_dbg(ring->parent->dev, "proxy: free%d occ%d\n", ring->state.free,
+		ring->state.occ);
 	return 0;
 }
 
@@ -810,7 +812,7 @@ static int k3_ringacc_ring_access_io(struct k3_ring *ring, void *elem,
 			"memcpy_fromio(x): --> ptr(%p), mode:%d\n", ptr,
 			access_mode);
 		memcpy_fromio(elem, ptr, (4 << ring->elm_size));
-		ring->occ--;
+		ring->state.occ--;
 		break;
 	case K3_RINGACC_ACCESS_MODE_PUSH_TAIL:
 	case K3_RINGACC_ACCESS_MODE_PUSH_HEAD:
@@ -818,14 +820,15 @@ static int k3_ringacc_ring_access_io(struct k3_ring *ring, void *elem,
 			"memcpy_toio(x): --> ptr(%p), mode:%d\n", ptr,
 			access_mode);
 		memcpy_toio(ptr, elem, (4 << ring->elm_size));
-		ring->free--;
+		ring->state.free--;
 		break;
 	default:
 		return -EINVAL;
 	}
 
-	dev_dbg(ring->parent->dev, "free%d index%d occ%d index%d\n", ring->free,
-		ring->windex, ring->occ, ring->rindex);
+	dev_dbg(ring->parent->dev, "free%d index%d occ%d index%d\n",
+		ring->state.free, ring->state.windex, ring->state.occ,
+		ring->state.rindex);
 	return 0;
 }
 
@@ -857,16 +860,16 @@ static int k3_ringacc_ring_push_mem(struct k3_ring *ring, void *elem)
 {
 	void *elem_ptr;
 
-	elem_ptr = k3_ringacc_get_elm_addr(ring, ring->windex);
+	elem_ptr = k3_ringacc_get_elm_addr(ring, ring->state.windex);
 
 	memcpy(elem_ptr, elem, (4 << ring->elm_size));
 
-	ring->windex = (ring->windex + 1) % ring->size;
-	ring->free--;
+	ring->state.windex = (ring->state.windex + 1) % ring->size;
+	ring->state.free--;
 	writel(1, &ring->rt->db);
 
 	dev_dbg(ring->parent->dev, "ring_push_mem: free%d index%d\n",
-		ring->free, ring->windex);
+		ring->state.free, ring->state.windex);
 
 	return 0;
 }
@@ -875,16 +878,16 @@ static int k3_ringacc_ring_pop_mem(struct k3_ring *ring, void *elem)
 {
 	void *elem_ptr;
 
-	elem_ptr = k3_ringacc_get_elm_addr(ring, ring->rindex);
+	elem_ptr = k3_ringacc_get_elm_addr(ring, ring->state.rindex);
 
 	memcpy(elem, elem_ptr, (4 << ring->elm_size));
 
-	ring->rindex = (ring->rindex + 1) % ring->size;
-	ring->occ--;
+	ring->state.rindex = (ring->state.rindex + 1) % ring->size;
+	ring->state.occ--;
 	writel(-1, &ring->rt->db);
 
 	dev_dbg(ring->parent->dev, "ring_pop_mem: occ%d index%d pos_ptr%p\n",
-		ring->occ, ring->rindex, elem_ptr);
+		ring->state.occ, ring->state.rindex, elem_ptr);
 	return 0;
 }
 
@@ -895,8 +898,8 @@ int k3_ringacc_ring_push(struct k3_ring *ring, void *elem)
 	if (!ring || !(ring->flags & K3_RING_FLAG_BUSY))
 		return -EINVAL;
 
-	dev_dbg(ring->parent->dev, "ring_push: free%d index%d\n", ring->free,
-		ring->windex);
+	dev_dbg(ring->parent->dev, "ring_push: free%d index%d\n",
+		ring->state.free, ring->state.windex);
 
 	if (k3_ringacc_ring_is_full(ring))
 		return -ENOMEM;
@@ -916,7 +919,7 @@ int k3_ringacc_ring_push_head(struct k3_ring *ring, void *elem)
 		return -EINVAL;
 
 	dev_dbg(ring->parent->dev, "ring_push_head: free%d index%d\n",
-		ring->free, ring->windex);
+		ring->state.free, ring->state.windex);
 
 	if (k3_ringacc_ring_is_full(ring))
 		return -ENOMEM;
@@ -935,13 +938,13 @@ int k3_ringacc_ring_pop(struct k3_ring *ring, void *elem)
 	if (!ring || !(ring->flags & K3_RING_FLAG_BUSY))
 		return -EINVAL;
 
-	if (!ring->occ)
-		ring->occ = k3_ringacc_ring_get_occ(ring);
+	if (!ring->state.occ)
+		ring->state.occ = k3_ringacc_ring_get_occ(ring);
 
-	dev_dbg(ring->parent->dev, "ring_pop: occ%d index%d\n", ring->occ,
-		ring->rindex);
+	dev_dbg(ring->parent->dev, "ring_pop: occ%d index%d\n", ring->state.occ,
+		ring->state.rindex);
 
-	if (!ring->occ)
+	if (!ring->state.occ)
 		return -ENODATA;
 
 	if (ring->ops && ring->ops->pop_head)
@@ -958,13 +961,13 @@ int k3_ringacc_ring_pop_tail(struct k3_ring *ring, void *elem)
 	if (!ring || !(ring->flags & K3_RING_FLAG_BUSY))
 		return -EINVAL;
 
-	if (!ring->occ)
-		ring->occ = k3_ringacc_ring_get_occ(ring);
+	if (!ring->state.occ)
+		ring->state.occ = k3_ringacc_ring_get_occ(ring);
 
-	dev_dbg(ring->parent->dev, "ring_pop_tail: occ%d index%d\n", ring->occ,
-		ring->rindex);
+	dev_dbg(ring->parent->dev, "ring_pop_tail: occ%d index%d\n",
+		ring->state.occ, ring->state.rindex);
 
-	if (!ring->occ)
+	if (!ring->state.occ)
 		return -ENODATA;
 
 	if (ring->ops && ring->ops->pop_tail)
-- 
2.17.1

