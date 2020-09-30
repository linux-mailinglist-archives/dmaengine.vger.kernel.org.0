Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E457A27E4AE
	for <lists+dmaengine@lfdr.de>; Wed, 30 Sep 2020 11:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729241AbgI3JOu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 30 Sep 2020 05:14:50 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:35226 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgI3JOt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 30 Sep 2020 05:14:49 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08U9Eghw035140;
        Wed, 30 Sep 2020 04:14:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601457282;
        bh=Zm2StBppKUJioCl8cgX2HsiR4MlDKduJUSfCgbeNBRk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Ew6dFxplIX6dJB9U4SMK9gYg5b9SzPPbZH/NKs39riFBd9mDfiCBhiFuSM+Tbgibd
         g+L+K322+OcmMiXtYhgWwFq4/nS2kcpDBWJEAL7hj/KKDctkjk7qvjGfqkdxakjhaO
         yEk5SwerOskDkNkK78aw+ed7nU0ZqQEPNbdpDho8=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08U9Egm9112070
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 30 Sep 2020 04:14:42 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 30
 Sep 2020 04:14:40 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 30 Sep 2020 04:14:40 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08U9DuJl116385;
        Wed, 30 Sep 2020 04:14:38 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <nm@ti.com>, <ssantosh@kernel.org>,
        <robh+dt@kernel.org>, <vigneshr@ti.com>
CC:     <dan.j.williams@intel.com>, <t-kristo@ti.com>,
        <lokeshvutla@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <dmaengine@vger.kernel.org>
Subject: [PATCH 14/18] soc: ti: k3-ringacc: add AM64 DMA rings support.
Date:   Wed, 30 Sep 2020 12:14:08 +0300
Message-ID: <20200930091412.8020-15-peter.ujfalusi@ti.com>
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

From: Grygorii Strashko <grygorii.strashko@ti.com>

The DMAs in AM64 have built in rings compared to AM654/J721e/J7200 where a
separate and generic ringacc is used.

The ring SW interface is similar to ringacc with some major architectural
differences, like

They are part of the DMA (BCDMA or PKTDMA).

They are dual mode rings are modeled as pair of Rings objects which has
common configuration and memory buffer, but separate real-time control
register sets for each direction mem2dev (forward) and dev2mem (reverse).

The ringacc driver must be initialized for DMA rings use with
k3_ringacc_dmarings_init() as it is not an independent device as ringacc
is.

AM64 rings must be requested only using k3_ringacc_request_rings_pair(),
and forward ring must always be initialized/configured. After this any
other Ringacc APIs can be used without any callers changes.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/soc/ti/k3-ringacc.c       | 325 +++++++++++++++++++++++++++++-
 include/linux/soc/ti/k3-ringacc.h |  17 ++
 2 files changed, 335 insertions(+), 7 deletions(-)

diff --git a/drivers/soc/ti/k3-ringacc.c b/drivers/soc/ti/k3-ringacc.c
index 7d0b4092fce8..25eca75b859a 100644
--- a/drivers/soc/ti/k3-ringacc.c
+++ b/drivers/soc/ti/k3-ringacc.c
@@ -11,6 +11,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/sys_soc.h>
+#include <linux/dma/ti-cppi5.h>
 #include <linux/soc/ti/k3-ringacc.h>
 #include <linux/soc/ti/ti_sci_protocol.h>
 #include <linux/soc/ti/ti_sci_inta_msi.h>
@@ -21,6 +22,7 @@ static LIST_HEAD(k3_ringacc_list);
 static DEFINE_MUTEX(k3_ringacc_list_lock);
 
 #define K3_RINGACC_CFG_RING_SIZE_ELCNT_MASK		GENMASK(19, 0)
+#define K3_DMARING_CFG_RING_SIZE_ELCNT_MASK		GENMASK(15, 0)
 
 /**
  * struct k3_ring_rt_regs - The RA realtime Control/Status Registers region
@@ -43,7 +45,13 @@ struct k3_ring_rt_regs {
 	u32	hwindx;
 };
 
-#define K3_RINGACC_RT_REGS_STEP	0x1000
+#define K3_RINGACC_RT_REGS_STEP			0x1000
+#define K3_DMARING_RT_REGS_STEP			0x2000
+#define K3_DMARING_RT_REGS_REVERSE_OFS		0x1000
+#define K3_RINGACC_RT_OCC_MASK			GENMASK(20, 0)
+#define K3_DMARING_RT_OCC_TDOWN_COMPLETE	BIT(31)
+#define K3_DMARING_RT_DB_ENTRY_MASK		GENMASK(7, 0)
+#define K3_DMARING_RT_DB_TDOWN_ACK		BIT(31)
 
 /**
  * struct k3_ring_fifo_regs - The Ring Accelerator Queues Registers region
@@ -122,6 +130,7 @@ struct k3_ring_state {
 	u32 occ;
 	u32 windex;
 	u32 rindex;
+	u32 tdown_complete:1;
 };
 
 /**
@@ -142,6 +151,7 @@ struct k3_ring_state {
  * @use_count: Use count for shared rings
  * @proxy_id: RA Ring Proxy Id (only if @K3_RINGACC_RING_USE_PROXY)
  * @dma_dev: device to be used for DMA API (allocation, mapping)
+ * @asel: Address Space Select value for physical addresses
  */
 struct k3_ring {
 	struct k3_ring_rt_regs __iomem *rt;
@@ -156,12 +166,15 @@ struct k3_ring {
 	u32		flags;
 #define K3_RING_FLAG_BUSY	BIT(1)
 #define K3_RING_FLAG_SHARED	BIT(2)
+#define K3_RING_FLAG_REVERSE	BIT(3)
 	struct k3_ring_state state;
 	u32		ring_id;
 	struct k3_ringacc	*parent;
 	u32		use_count;
 	int		proxy_id;
 	struct device	*dma_dev;
+	u32		asel;
+#define K3_ADDRESS_ASEL_SHIFT	48
 };
 
 struct k3_ringacc_ops {
@@ -187,6 +200,7 @@ struct k3_ringacc_ops {
  * @tisci_ring_ops: ti-sci rings ops
  * @tisci_dev_id: ti-sci device id
  * @ops: SoC specific ringacc operation
+ * @dma_rings: indicate DMA ring (dual ring within BCDMA/PKTDMA)
  */
 struct k3_ringacc {
 	struct device *dev;
@@ -209,6 +223,7 @@ struct k3_ringacc {
 	u32 tisci_dev_id;
 
 	const struct k3_ringacc_ops *ops;
+	bool dma_rings;
 };
 
 /**
@@ -220,6 +235,21 @@ struct k3_ringacc_soc_data {
 	unsigned dma_ring_reset_quirk:1;
 };
 
+static int k3_ringacc_ring_read_occ(struct k3_ring *ring)
+{
+	return readl(&ring->rt->occ) & K3_RINGACC_RT_OCC_MASK;
+}
+
+static void k3_ringacc_ring_update_occ(struct k3_ring *ring)
+{
+	u32 val;
+
+	val = readl(&ring->rt->occ);
+
+	ring->state.occ = val & K3_RINGACC_RT_OCC_MASK;
+	ring->state.tdown_complete = !!(val & K3_DMARING_RT_OCC_TDOWN_COMPLETE);
+}
+
 static long k3_ringacc_ring_get_fifo_pos(struct k3_ring *ring)
 {
 	return K3_RINGACC_FIFO_WINDOW_SIZE_BYTES -
@@ -233,12 +263,24 @@ static void *k3_ringacc_get_elm_addr(struct k3_ring *ring, u32 idx)
 
 static int k3_ringacc_ring_push_mem(struct k3_ring *ring, void *elem);
 static int k3_ringacc_ring_pop_mem(struct k3_ring *ring, void *elem);
+static int k3_dmaring_fwd_pop(struct k3_ring *ring, void *elem);
+static int k3_dmaring_reverse_pop(struct k3_ring *ring, void *elem);
 
 static struct k3_ring_ops k3_ring_mode_ring_ops = {
 		.push_tail = k3_ringacc_ring_push_mem,
 		.pop_head = k3_ringacc_ring_pop_mem,
 };
 
+static struct k3_ring_ops k3_dmaring_fwd_ops = {
+		.push_tail = k3_ringacc_ring_push_mem,
+		.pop_head = k3_dmaring_fwd_pop,
+};
+
+static struct k3_ring_ops k3_dmaring_reverse_ops = {
+		/* Reverse side of the DMA ring can only be popped by SW */
+		.pop_head = k3_dmaring_reverse_pop,
+};
+
 static int k3_ringacc_ring_push_io(struct k3_ring *ring, void *elem);
 static int k3_ringacc_ring_pop_io(struct k3_ring *ring, void *elem);
 static int k3_ringacc_ring_push_head_io(struct k3_ring *ring, void *elem);
@@ -341,6 +383,40 @@ struct k3_ring *k3_ringacc_request_ring(struct k3_ringacc *ringacc,
 }
 EXPORT_SYMBOL_GPL(k3_ringacc_request_ring);
 
+static int k3_dmaring_request_dual_ring(struct k3_ringacc *ringacc, int fwd_id,
+					struct k3_ring **fwd_ring,
+					struct k3_ring **compl_ring)
+{
+	int ret = 0;
+
+	/*
+	 * DMA rings must be requested by ID, completion ring is the reverse
+	 * side of the forward ring
+	 */
+	if (fwd_id < 0)
+		return -EINVAL;
+
+	mutex_lock(&ringacc->req_lock);
+
+	if (test_bit(fwd_id, ringacc->rings_inuse)) {
+		ret = -EBUSY;
+		goto error;
+	}
+
+	*fwd_ring = &ringacc->rings[fwd_id];
+	*compl_ring = &ringacc->rings[fwd_id + ringacc->num_rings];
+	set_bit(fwd_id, ringacc->rings_inuse);
+	ringacc->rings[fwd_id].use_count++;
+	dev_dbg(ringacc->dev, "Giving ring#%d\n", fwd_id);
+
+	mutex_unlock(&ringacc->req_lock);
+	return 0;
+
+error:
+	mutex_unlock(&ringacc->req_lock);
+	return ret;
+}
+
 int k3_ringacc_request_rings_pair(struct k3_ringacc *ringacc,
 				  int fwd_id, int compl_id,
 				  struct k3_ring **fwd_ring,
@@ -351,6 +427,10 @@ int k3_ringacc_request_rings_pair(struct k3_ringacc *ringacc,
 	if (!fwd_ring || !compl_ring)
 		return -EINVAL;
 
+	if (ringacc->dma_rings)
+		return k3_dmaring_request_dual_ring(ringacc, fwd_id,
+						    fwd_ring, compl_ring);
+
 	*fwd_ring = k3_ringacc_request_ring(ringacc, fwd_id, 0);
 	if (!(*fwd_ring))
 		return -ENODEV;
@@ -420,7 +500,7 @@ void k3_ringacc_ring_reset_dma(struct k3_ring *ring, u32 occ)
 		goto reset;
 
 	if (!occ)
-		occ = readl(&ring->rt->occ);
+		occ = k3_ringacc_ring_read_occ(ring);
 
 	if (occ) {
 		u32 db_ring_cnt, db_ring_cnt_cur;
@@ -495,6 +575,13 @@ int k3_ringacc_ring_free(struct k3_ring *ring)
 
 	ringacc = ring->parent;
 
+	/*
+	 * DMA rings: rings shared memory and configuration, only forward ring
+	 * is configured and reverse ring considered as slave.
+	 */
+	if (ringacc->dma_rings && (ring->flags & K3_RING_FLAG_REVERSE))
+		return 0;
+
 	dev_dbg(ring->parent->dev, "flags: 0x%08x\n", ring->flags);
 
 	if (!test_bit(ring->ring_id, ringacc->rings_inuse))
@@ -516,6 +603,8 @@ int k3_ringacc_ring_free(struct k3_ring *ring)
 	ring->flags = 0;
 	ring->ops = NULL;
 	ring->dma_dev = NULL;
+	ring->asel = 0;
+
 	if (ring->proxy_id != K3_RINGACC_PROXY_NOT_USED) {
 		clear_bit(ring->proxy_id, ringacc->proxy_inuse);
 		ring->proxy = NULL;
@@ -580,6 +669,7 @@ static int k3_ringacc_ring_cfg_sci(struct k3_ring *ring)
 	ring_cfg.count = ring->size;
 	ring_cfg.mode = ring->mode;
 	ring_cfg.size = ring->elm_size;
+	ring_cfg.asel = ring->asel;
 
 	ret = ringacc->tisci_ring_ops->set_cfg(ringacc->tisci, &ring_cfg);
 	if (ret)
@@ -589,6 +679,90 @@ static int k3_ringacc_ring_cfg_sci(struct k3_ring *ring)
 	return ret;
 }
 
+static int k3_dmaring_cfg(struct k3_ring *ring, struct k3_ring_cfg *cfg)
+{
+	struct k3_ringacc *ringacc;
+	struct k3_ring *reverse_ring;
+	int ret = 0;
+
+	if (cfg->elm_size != K3_RINGACC_RING_ELSIZE_8 ||
+	    cfg->mode != K3_RINGACC_RING_MODE_RING ||
+	    cfg->size & ~K3_DMARING_CFG_RING_SIZE_ELCNT_MASK)
+		return -EINVAL;
+
+	ringacc = ring->parent;
+
+	/*
+	 * DMA rings: rings shared memory and configuration, only forward ring
+	 * is configured and reverse ring considered as slave.
+	 */
+	if (ringacc->dma_rings && (ring->flags & K3_RING_FLAG_REVERSE))
+		return 0;
+
+	if (!test_bit(ring->ring_id, ringacc->rings_inuse))
+		return -EINVAL;
+
+	ring->size = cfg->size;
+	ring->elm_size = cfg->elm_size;
+	ring->mode = cfg->mode;
+	ring->asel = cfg->asel;
+	ring->dma_dev = cfg->dma_dev;
+	if (!ring->dma_dev) {
+		dev_warn(ringacc->dev, "dma_dev is not provided for ring%d\n",
+			 ring->ring_id);
+		ring->dma_dev = ringacc->dev;
+	}
+
+	memset(&ring->state, 0, sizeof(ring->state));
+
+	ring->ops = &k3_dmaring_fwd_ops;
+
+	ring->ring_mem_virt = dma_alloc_coherent(ring->dma_dev,
+					ring->size * (4 << ring->elm_size),
+					&ring->ring_mem_dma, GFP_KERNEL);
+	if (!ring->ring_mem_virt) {
+		dev_err(ringacc->dev, "Failed to alloc ring mem\n");
+		ret = -ENOMEM;
+		goto err_free_ops;
+	}
+
+	ret = k3_ringacc_ring_cfg_sci(ring);
+	if (ret)
+		goto err_free_mem;
+
+	ring->flags |= K3_RING_FLAG_BUSY;
+
+	k3_ringacc_ring_dump(ring);
+
+	/* DMA rings: configure reverse ring */
+	reverse_ring = &ringacc->rings[ring->ring_id + ringacc->num_rings];
+	reverse_ring->size = cfg->size;
+	reverse_ring->elm_size = cfg->elm_size;
+	reverse_ring->mode = cfg->mode;
+	reverse_ring->asel = cfg->asel;
+	memset(&reverse_ring->state, 0, sizeof(reverse_ring->state));
+	reverse_ring->ops = &k3_dmaring_reverse_ops;
+
+	reverse_ring->ring_mem_virt = ring->ring_mem_virt;
+	reverse_ring->ring_mem_dma = ring->ring_mem_dma;
+	reverse_ring->flags |= K3_RING_FLAG_BUSY;
+	k3_ringacc_ring_dump(reverse_ring);
+
+	return 0;
+
+err_free_mem:
+	dma_free_coherent(ring->dma_dev,
+			  ring->size * (4 << ring->elm_size),
+			  ring->ring_mem_virt,
+			  ring->ring_mem_dma);
+err_free_ops:
+	ring->ops = NULL;
+	ring->proxy = NULL;
+	ring->dma_dev = NULL;
+	ring->asel = 0;
+	return ret;
+}
+
 int k3_ringacc_ring_cfg(struct k3_ring *ring, struct k3_ring_cfg *cfg)
 {
 	struct k3_ringacc *ringacc;
@@ -596,8 +770,12 @@ int k3_ringacc_ring_cfg(struct k3_ring *ring, struct k3_ring_cfg *cfg)
 
 	if (!ring || !cfg)
 		return -EINVAL;
+
 	ringacc = ring->parent;
 
+	if (ringacc->dma_rings)
+		return k3_dmaring_cfg(ring, cfg);
+
 	if (cfg->elm_size > K3_RINGACC_RING_ELSIZE_256 ||
 	    cfg->mode >= K3_RINGACC_RING_MODE_INVALID ||
 	    cfg->size & ~K3_RINGACC_CFG_RING_SIZE_ELCNT_MASK ||
@@ -704,7 +882,7 @@ u32 k3_ringacc_ring_get_free(struct k3_ring *ring)
 		return -EINVAL;
 
 	if (!ring->state.free)
-		ring->state.free = ring->size - readl(&ring->rt->occ);
+		ring->state.free = ring->size - k3_ringacc_ring_read_occ(ring);
 
 	return ring->state.free;
 }
@@ -715,7 +893,7 @@ u32 k3_ringacc_ring_get_occ(struct k3_ring *ring)
 	if (!ring || !(ring->flags & K3_RING_FLAG_BUSY))
 		return -EINVAL;
 
-	return readl(&ring->rt->occ);
+	return k3_ringacc_ring_read_occ(ring);
 }
 EXPORT_SYMBOL_GPL(k3_ringacc_ring_get_occ);
 
@@ -891,6 +1069,72 @@ static int k3_ringacc_ring_pop_tail_io(struct k3_ring *ring, void *elem)
 					 K3_RINGACC_ACCESS_MODE_POP_HEAD);
 }
 
+/*
+ * The element is 48 bits of address + ASEL bits in the ring.
+ * ASEL is used by the DMAs and should be removed for the kernel as it is not
+ * part of the physical memory address.
+ */
+static void k3_dmaring_remove_asel_from_elem(u64 *elem)
+{
+	*elem &= GENMASK_ULL(K3_ADDRESS_ASEL_SHIFT - 1, 0);
+}
+
+static int k3_dmaring_fwd_pop(struct k3_ring *ring, void *elem)
+{
+	void *elem_ptr;
+	u32 elem_idx;
+
+	/*
+	 * DMA rings: forward ring is always tied DMA channel and HW does not
+	 * maintain any state data required for POP operation and its unknown
+	 * how much elements were consumed by HW. So, to actually
+	 * do POP, the read pointer has to be recalculated every time.
+	 */
+	ring->state.occ = k3_ringacc_ring_read_occ(ring);
+	if (ring->state.windex >= ring->state.occ)
+		elem_idx = ring->state.windex - ring->state.occ;
+	else
+		elem_idx = ring->size - (ring->state.occ - ring->state.windex);
+
+	elem_ptr = k3_ringacc_get_elm_addr(ring, elem_idx);
+	memcpy(elem, elem_ptr, (4 << ring->elm_size));
+	k3_dmaring_remove_asel_from_elem(elem);
+
+	ring->state.occ--;
+	writel(-1, &ring->rt->db);
+
+	dev_dbg(ring->parent->dev, "%s: occ%d Windex%d Rindex%d pos_ptr%px\n",
+		__func__, ring->state.occ, ring->state.windex, elem_idx,
+		elem_ptr);
+	return 0;
+}
+
+static int k3_dmaring_reverse_pop(struct k3_ring *ring, void *elem)
+{
+	void *elem_ptr;
+
+	elem_ptr = k3_ringacc_get_elm_addr(ring, ring->state.rindex);
+
+	if (ring->state.occ) {
+		memcpy(elem, elem_ptr, (4 << ring->elm_size));
+		k3_dmaring_remove_asel_from_elem(elem);
+
+		ring->state.rindex = (ring->state.rindex + 1) % ring->size;
+		ring->state.occ--;
+		writel(-1 & K3_DMARING_RT_DB_ENTRY_MASK, &ring->rt->db);
+	} else if (ring->state.tdown_complete) {
+		dma_addr_t *value = elem;
+
+		*value = CPPI5_TDCM_MARKER;
+		writel(K3_DMARING_RT_DB_TDOWN_ACK, &ring->rt->db);
+		ring->state.tdown_complete = false;
+	}
+
+	dev_dbg(ring->parent->dev, "%s: occ%d index%d pos_ptr%px\n",
+		__func__, ring->state.occ, ring->state.rindex, elem_ptr);
+	return 0;
+}
+
 static int k3_ringacc_ring_push_mem(struct k3_ring *ring, void *elem)
 {
 	void *elem_ptr;
@@ -898,6 +1142,11 @@ static int k3_ringacc_ring_push_mem(struct k3_ring *ring, void *elem)
 	elem_ptr = k3_ringacc_get_elm_addr(ring, ring->state.windex);
 
 	memcpy(elem_ptr, elem, (4 << ring->elm_size));
+	if (ring->parent->dma_rings) {
+		u64 *addr = elem_ptr;
+
+		*addr |= ((u64)ring->asel << K3_ADDRESS_ASEL_SHIFT);
+	}
 
 	ring->state.windex = (ring->state.windex + 1) % ring->size;
 	ring->state.free--;
@@ -974,12 +1223,12 @@ int k3_ringacc_ring_pop(struct k3_ring *ring, void *elem)
 		return -EINVAL;
 
 	if (!ring->state.occ)
-		ring->state.occ = k3_ringacc_ring_get_occ(ring);
+		k3_ringacc_ring_update_occ(ring);
 
 	dev_dbg(ring->parent->dev, "ring_pop: occ%d index%d\n", ring->state.occ,
 		ring->state.rindex);
 
-	if (!ring->state.occ)
+	if (!ring->state.occ && !ring->state.tdown_complete)
 		return -ENODATA;
 
 	if (ring->ops && ring->ops->pop_head)
@@ -997,7 +1246,7 @@ int k3_ringacc_ring_pop_tail(struct k3_ring *ring, void *elem)
 		return -EINVAL;
 
 	if (!ring->state.occ)
-		ring->state.occ = k3_ringacc_ring_get_occ(ring);
+		k3_ringacc_ring_update_occ(ring);
 
 	dev_dbg(ring->parent->dev, "ring_pop_tail: occ%d index%d\n",
 		ring->state.occ, ring->state.rindex);
@@ -1202,6 +1451,68 @@ static const struct of_device_id k3_ringacc_of_match[] = {
 	{},
 };
 
+struct k3_ringacc *k3_ringacc_dmarings_init(struct platform_device *pdev,
+					    struct k3_ringacc_init_data *data)
+{
+	struct device *dev = &pdev->dev;
+	struct k3_ringacc *ringacc;
+	void __iomem *base_rt;
+	struct resource *res;
+	int i;
+
+	ringacc = devm_kzalloc(dev, sizeof(*ringacc), GFP_KERNEL);
+	if (!ringacc)
+		return ERR_PTR(-ENOMEM);
+
+	ringacc->dev = dev;
+	ringacc->dma_rings = true;
+	ringacc->num_rings = data->num_rings;
+	ringacc->tisci = data->tisci;
+	ringacc->tisci_dev_id = data->tisci_dev_id;
+
+	mutex_init(&ringacc->req_lock);
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ringrt");
+	base_rt = devm_ioremap_resource(dev, res);
+	if (IS_ERR(base_rt))
+		return base_rt;
+
+	ringacc->rings = devm_kzalloc(dev,
+				      sizeof(*ringacc->rings) *
+				      ringacc->num_rings * 2,
+				      GFP_KERNEL);
+	ringacc->rings_inuse = devm_kcalloc(dev,
+					    BITS_TO_LONGS(ringacc->num_rings),
+					    sizeof(unsigned long), GFP_KERNEL);
+
+	if (!ringacc->rings || !ringacc->rings_inuse)
+		return ERR_PTR(-ENOMEM);
+
+	for (i = 0; i < ringacc->num_rings; i++) {
+		struct k3_ring *ring = &ringacc->rings[i];
+
+		ring->rt = base_rt + K3_DMARING_RT_REGS_STEP * i;
+		ring->parent = ringacc;
+		ring->ring_id = i;
+		ring->proxy_id = K3_RINGACC_PROXY_NOT_USED;
+
+		ring = &ringacc->rings[ringacc->num_rings + i];
+		ring->rt = base_rt + K3_DMARING_RT_REGS_STEP * i +
+			   K3_DMARING_RT_REGS_REVERSE_OFS;
+		ring->parent = ringacc;
+		ring->ring_id = i;
+		ring->proxy_id = K3_RINGACC_PROXY_NOT_USED;
+		ring->flags = K3_RING_FLAG_REVERSE;
+	}
+
+	ringacc->tisci_ring_ops = &ringacc->tisci->ops.rm_ring_ops;
+
+	dev_info(dev, "Number of rings: %u\n", ringacc->num_rings);
+
+	return ringacc;
+}
+EXPORT_SYMBOL_GPL(k3_ringacc_dmarings_init);
+
 static int k3_ringacc_probe(struct platform_device *pdev)
 {
 	const struct ringacc_match_data *match_data;
diff --git a/include/linux/soc/ti/k3-ringacc.h b/include/linux/soc/ti/k3-ringacc.h
index 658dc71d2901..39b022b92598 100644
--- a/include/linux/soc/ti/k3-ringacc.h
+++ b/include/linux/soc/ti/k3-ringacc.h
@@ -70,6 +70,7 @@ struct k3_ring;
  * @dma_dev: Master device which is using and accessing to the ring
  *	memory when the mode is K3_RINGACC_RING_MODE_RING. Memory allocations
  *	should be done using this device.
+ * @asel: Address Space Select value for physical addresses
  */
 struct k3_ring_cfg {
 	u32 size;
@@ -79,6 +80,7 @@ struct k3_ring_cfg {
 	u32 flags;
 
 	struct device *dma_dev;
+	u32 asel;
 };
 
 #define K3_RINGACC_RING_ID_ANY (-1)
@@ -250,4 +252,19 @@ int k3_ringacc_ring_pop_tail(struct k3_ring *ring, void *elem);
 
 u32 k3_ringacc_get_tisci_dev_id(struct k3_ring *ring);
 
+/* DMA ring support */
+struct ti_sci_handle;
+
+/**
+ * struct struct k3_ringacc_init_data - Initialization data for DMA rings
+ */
+struct k3_ringacc_init_data {
+	const struct ti_sci_handle *tisci;
+	u32 tisci_dev_id;
+	u32 num_rings;
+};
+
+struct k3_ringacc *k3_ringacc_dmarings_init(struct platform_device *pdev,
+					    struct k3_ringacc_init_data *data);
+
 #endif /* __SOC_TI_K3_RINGACC_API_H_ */
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

