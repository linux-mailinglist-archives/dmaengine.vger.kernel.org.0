Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D20310C771
	for <lists+dmaengine@lfdr.de>; Thu, 28 Nov 2019 12:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbfK1LAg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 Nov 2019 06:00:36 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:34488 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727240AbfK1LAf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 28 Nov 2019 06:00:35 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xASB0R6m022872;
        Thu, 28 Nov 2019 05:00:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1574938827;
        bh=ZXivKUgJOKcIo/wkS6se6UfPlbG89d/zwDP/S+jN/TA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=oBeQnpqxPVXWlRb/Um8Qc1Z+B0iRwZ05E9n2GeznbUQs9HvVsw1oMoggJ1yAo07Tp
         ykCZ73vZGQujYJbuP863aqP63ijEqaHAMjoIVvnG4p7HbEzMpv0ivzgcEjWB1B4dP1
         tTa3gXbRksxyFCe8z/J1AjcB4/6uUYXCR4va3FMY=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xASB0RKT015248
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 28 Nov 2019 05:00:27 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 28
 Nov 2019 05:00:26 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 28 Nov 2019 05:00:26 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xASAxgJQ073287;
        Thu, 28 Nov 2019 05:00:23 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>, <nm@ti.com>,
        <ssantosh@kernel.org>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <lokeshvutla@ti.com>,
        <t-kristo@ti.com>, <tony@atomide.com>, <j-keerthy@ti.com>
Subject: [PATCH v6 12/17] dmaengine: ti: New driver for K3 UDMA - split#4: dma_device callbacks 1
Date:   Thu, 28 Nov 2019 12:59:40 +0200
Message-ID: <20191128105945.13071-13-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191128105945.13071-1-peter.ujfalusi@ti.com>
References: <20191128105945.13071-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Split patch for review containing:
device_config, device_issue_pending, device_tx_status, device_pause,
device_resume, device_terminate_all and device_synchronize callback
implementation and the custom udma_vchan_complete.

DMA driver for
Texas Instruments K3 NAVSS Unified DMA – Peripheral Root Complex (UDMA-P)

The UDMA-P is intended to perform similar (but significantly upgraded) functions
as the packet-oriented DMA used on previous SoC devices. The UDMA-P module
supports the transmission and reception of various packet types. The UDMA-P is
architected to facilitate the segmentation and reassembly of SoC DMA data
structure compliant packets to/from smaller data blocks that are natively
compatible with the specific requirements of each connected peripheral. Multiple
Tx and Rx channels are provided within the DMA which allow multiple segmentation
or reassembly operations to be ongoing. The DMA controller maintains state
information for each of the channels which allows packet segmentation and
reassembly operations to be time division multiplexed between channels in order
to share the underlying DMA hardware. An external DMA scheduler is used to
control the ordering and rate at which this multiplexing occurs for Transmit
operations. The ordering and rate of Receive operations is indirectly controlled
by the order in which blocks are pushed into the DMA on the Rx PSI-L interface.

The UDMA-P also supports acting as both a UTC and UDMA-C for its internal
channels. Channels in the UDMA-P can be configured to be either Packet-Based or
Third-Party channels on a channel by channel basis.

The initial driver supports:
- MEM_TO_MEM (TR mode)
- DEV_TO_MEM (Packet / TR mode)
- MEM_TO_DEV (Packet / TR mode)
- Cyclic (Packet / TR mode)
- Metadata for descriptors

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/ti/k3-udma.c | 293 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 293 insertions(+)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 0b5d709f6dad..9118db431438 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -1782,6 +1782,299 @@ static int udma_alloc_chan_resources(struct dma_chan *chan)
 	return ret;
 }
 
+static int udma_slave_config(struct dma_chan *chan,
+			     struct dma_slave_config *cfg)
+{
+	struct udma_chan *uc = to_udma_chan(chan);
+
+	memcpy(&uc->cfg, cfg, sizeof(uc->cfg));
+
+	return 0;
+}
+
+static void udma_issue_pending(struct dma_chan *chan)
+{
+	struct udma_chan *uc = to_udma_chan(chan);
+	unsigned long flags;
+
+	spin_lock_irqsave(&uc->vc.lock, flags);
+
+	/* If we have something pending and no active descriptor, then */
+	if (vchan_issue_pending(&uc->vc) && !uc->desc) {
+		/*
+		 * start a descriptor if the channel is NOT [marked as
+		 * terminating _and_ it is still running (teardown has not
+		 * completed yet)].
+		 */
+		if (!(uc->state == UDMA_CHAN_IS_TERMINATING &&
+		      udma_is_chan_running(uc)))
+			udma_start(uc);
+	}
+
+	spin_unlock_irqrestore(&uc->vc.lock, flags);
+}
+
+static enum dma_status udma_tx_status(struct dma_chan *chan,
+				      dma_cookie_t cookie,
+				      struct dma_tx_state *txstate)
+{
+	struct udma_chan *uc = to_udma_chan(chan);
+	enum dma_status ret;
+	unsigned long flags;
+
+	spin_lock_irqsave(&uc->vc.lock, flags);
+
+	ret = dma_cookie_status(chan, cookie, txstate);
+
+	if (!udma_is_chan_running(uc))
+		ret = DMA_COMPLETE;
+
+	if (ret == DMA_COMPLETE || !txstate)
+		goto out;
+
+	if (uc->desc && uc->desc->vd.tx.cookie == cookie) {
+		u32 peer_bcnt = 0;
+		u32 bcnt = 0;
+		u32 residue = uc->desc->residue;
+		u32 delay = 0;
+
+		if (uc->desc->dir == DMA_MEM_TO_DEV) {
+			bcnt = udma_tchanrt_read(uc->tchan,
+						 UDMA_TCHAN_RT_SBCNT_REG);
+
+			if (uc->ep_type != PSIL_EP_NATIVE) {
+				peer_bcnt = udma_tchanrt_read(uc->tchan,
+						UDMA_TCHAN_RT_PEER_BCNT_REG);
+
+				if (bcnt > peer_bcnt)
+					delay = bcnt - peer_bcnt;
+			}
+		} else if (uc->desc->dir == DMA_DEV_TO_MEM) {
+			bcnt = udma_rchanrt_read(uc->rchan,
+						 UDMA_RCHAN_RT_BCNT_REG);
+
+			if (uc->ep_type != PSIL_EP_NATIVE) {
+				peer_bcnt = udma_rchanrt_read(uc->rchan,
+						UDMA_RCHAN_RT_PEER_BCNT_REG);
+
+				if (peer_bcnt > bcnt)
+					delay = peer_bcnt - bcnt;
+			}
+		} else {
+			bcnt = udma_tchanrt_read(uc->tchan,
+						 UDMA_TCHAN_RT_BCNT_REG);
+		}
+
+		bcnt -= uc->bcnt;
+		if (bcnt && !(bcnt % uc->desc->residue))
+			residue = 0;
+		else
+			residue -= bcnt % uc->desc->residue;
+
+		if (!residue && (uc->dir == DMA_DEV_TO_MEM || !delay)) {
+			ret = DMA_COMPLETE;
+			delay = 0;
+		}
+
+		dma_set_residue(txstate, residue);
+		dma_set_in_flight_bytes(txstate, delay);
+
+	} else {
+		ret = DMA_COMPLETE;
+	}
+
+out:
+	spin_unlock_irqrestore(&uc->vc.lock, flags);
+	return ret;
+}
+
+static int udma_pause(struct dma_chan *chan)
+{
+	struct udma_chan *uc = to_udma_chan(chan);
+
+	if (!uc->desc)
+		return -EINVAL;
+
+	/* pause the channel */
+	switch (uc->desc->dir) {
+	case DMA_DEV_TO_MEM:
+		udma_rchanrt_update_bits(uc->rchan,
+					 UDMA_RCHAN_RT_PEER_RT_EN_REG,
+					 UDMA_PEER_RT_EN_PAUSE,
+					 UDMA_PEER_RT_EN_PAUSE);
+		break;
+	case DMA_MEM_TO_DEV:
+		udma_tchanrt_update_bits(uc->tchan,
+					 UDMA_TCHAN_RT_PEER_RT_EN_REG,
+					 UDMA_PEER_RT_EN_PAUSE,
+					 UDMA_PEER_RT_EN_PAUSE);
+		break;
+	case DMA_MEM_TO_MEM:
+		udma_tchanrt_update_bits(uc->tchan, UDMA_TCHAN_RT_CTL_REG,
+					 UDMA_CHAN_RT_CTL_PAUSE,
+					 UDMA_CHAN_RT_CTL_PAUSE);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int udma_resume(struct dma_chan *chan)
+{
+	struct udma_chan *uc = to_udma_chan(chan);
+
+	if (!uc->desc)
+		return -EINVAL;
+
+	/* resume the channel */
+	switch (uc->desc->dir) {
+	case DMA_DEV_TO_MEM:
+		udma_rchanrt_update_bits(uc->rchan,
+					 UDMA_RCHAN_RT_PEER_RT_EN_REG,
+					 UDMA_PEER_RT_EN_PAUSE, 0);
+
+		break;
+	case DMA_MEM_TO_DEV:
+		udma_tchanrt_update_bits(uc->tchan,
+					 UDMA_TCHAN_RT_PEER_RT_EN_REG,
+					 UDMA_PEER_RT_EN_PAUSE, 0);
+		break;
+	case DMA_MEM_TO_MEM:
+		udma_tchanrt_update_bits(uc->tchan, UDMA_TCHAN_RT_CTL_REG,
+					 UDMA_CHAN_RT_CTL_PAUSE, 0);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int udma_terminate_all(struct dma_chan *chan)
+{
+	struct udma_chan *uc = to_udma_chan(chan);
+	unsigned long flags;
+	LIST_HEAD(head);
+
+	spin_lock_irqsave(&uc->vc.lock, flags);
+
+	if (udma_is_chan_running(uc))
+		udma_stop(uc);
+
+	if (uc->desc) {
+		uc->terminated_desc = uc->desc;
+		uc->desc = NULL;
+		uc->terminated_desc->terminated = true;
+	}
+
+	uc->paused = false;
+
+	vchan_get_all_descriptors(&uc->vc, &head);
+	spin_unlock_irqrestore(&uc->vc.lock, flags);
+	vchan_dma_desc_free_list(&uc->vc, &head);
+
+	return 0;
+}
+
+static void udma_synchronize(struct dma_chan *chan)
+{
+	struct udma_chan *uc = to_udma_chan(chan);
+	unsigned long timeout = msecs_to_jiffies(1000);
+
+	vchan_synchronize(&uc->vc);
+
+	if (uc->state == UDMA_CHAN_IS_TERMINATING) {
+		timeout = wait_for_completion_timeout(&uc->teardown_completed,
+						      timeout);
+		if (!timeout) {
+			dev_warn(uc->ud->dev, "chan%d teardown timeout!\n",
+				 uc->id);
+			udma_dump_chan_stdata(uc);
+			udma_reset_chan(uc, true);
+		}
+	}
+
+	udma_reset_chan(uc, false);
+	if (udma_is_chan_running(uc))
+		dev_warn(uc->ud->dev, "chan%d refused to stop!\n", uc->id);
+
+	udma_reset_rings(uc);
+}
+
+static void udma_desc_pre_callback(struct virt_dma_chan *vc,
+				   struct virt_dma_desc *vd,
+				   struct dmaengine_result *result)
+{
+	struct udma_chan *uc = to_udma_chan(&vc->chan);
+	struct udma_desc *d;
+
+	if (!vd)
+		return;
+
+	d = to_udma_desc(&vd->tx);
+
+	if (d->metadata_size)
+		udma_fetch_epib(uc, d);
+
+	/* Provide residue information for the client */
+	if (result) {
+		void *desc_vaddr = udma_curr_cppi5_desc_vaddr(d, d->desc_idx);
+
+		if (cppi5_desc_get_type(desc_vaddr) ==
+		    CPPI5_INFO0_DESC_TYPE_VAL_HOST) {
+			result->residue = cppi5_hdesc_get_pktlen(desc_vaddr);
+			if (result->residue == d->residue)
+				result->result = DMA_TRANS_NOERROR;
+			else
+				result->result = DMA_TRANS_ABORTED;
+		} else {
+			result->residue = d->residue;
+			result->result = DMA_TRANS_NOERROR;
+		}
+	}
+}
+
+/*
+ * This tasklet handles the completion of a DMA descriptor by
+ * calling its callback and freeing it.
+ */
+static void udma_vchan_complete(unsigned long arg)
+{
+	struct virt_dma_chan *vc = (struct virt_dma_chan *)arg;
+	struct virt_dma_desc *vd, *_vd;
+	struct dmaengine_desc_callback cb;
+	LIST_HEAD(head);
+
+	spin_lock_irq(&vc->lock);
+	list_splice_tail_init(&vc->desc_completed, &head);
+	vd = vc->cyclic;
+	if (vd) {
+		vc->cyclic = NULL;
+		dmaengine_desc_get_callback(&vd->tx, &cb);
+	} else {
+		memset(&cb, 0, sizeof(cb));
+	}
+	spin_unlock_irq(&vc->lock);
+
+	udma_desc_pre_callback(vc, vd, NULL);
+	dmaengine_desc_callback_invoke(&cb, NULL);
+
+	list_for_each_entry_safe(vd, _vd, &head, node) {
+		struct dmaengine_result result;
+
+		dmaengine_desc_get_callback(&vd->tx, &cb);
+
+		list_del(&vd->node);
+
+		udma_desc_pre_callback(vc, vd, &result);
+		dmaengine_desc_callback_invoke(&cb, &result);
+
+		vchan_vdesc_fini(vd);
+	}
+}
+
 static void udma_free_chan_resources(struct dma_chan *chan)
 {
 	struct udma_chan *uc = to_udma_chan(chan);
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

