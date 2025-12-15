Return-Path: <dmaengine+bounces-7638-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B0ECBF743
	for <lists+dmaengine@lfdr.de>; Mon, 15 Dec 2025 19:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D97D6301691C
	for <lists+dmaengine@lfdr.de>; Mon, 15 Dec 2025 18:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437C5325484;
	Mon, 15 Dec 2025 18:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="NaqEUie1"
X-Original-To: dmaengine@vger.kernel.org
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172FE2E5D32
	for <dmaengine@vger.kernel.org>; Mon, 15 Dec 2025 18:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765824055; cv=none; b=A6JHm7GbgVHYAPt+PiVN6ayW56hoJC13ZUSgLhk23u0Ke7YynfuyphTr5Yc8ILuQ9sRXrpIfQotFKKIRPJG7HWvv3NWd8V9KM9229ojGaimyGhHGU4PsO+XVO6xxf8iTQJau29e/pYsMBOQTHYJf0yq3Z8btDUUAVnd+SRpkn+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765824055; c=relaxed/simple;
	bh=HUgupN1QL/fcT9q62T57ihZRki34ovPLpMa6Yy3fH1A=;
	h=From:To:Cc:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Subject; b=EYVe6xNtBgNMu0wnRWtfnPLtyBNGUvWhkCgzOwYrFXtbuTnwtk/Qfx0Q4WVlt4CFRXo+z0d3GCAGhT0gMfti0xeAV9k5qi0QP8oeuWPbMzc/mFhfTfKPZ0Zn9XwmVlb2gEP1IigOXjfAGhrjE8ISRwHugDkJQo8t33sOFOOT+v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=NaqEUie1; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Cc:To:From:content-disposition;
	bh=mzicnsTLuZFcE+/aYMPwS0EN+MR+vBN2CcPH9xUuI3A=; b=NaqEUie1RZk+nnvBFgMnYwp9Oz
	hMGTf3wgyOzcvEu9nOodgaJtFw1OBQ+pjOCoJgOxkcPGxgxFFFqFI9lj2nEFq9busrXzw8Cxw8ViW
	dsoV2IkVIJf/ieDPH6yKV1EZzLO4sHqZPBWFibLZ0TblhMz3EmC6eG9NpADKuYXYXZmRQvPIXKTuM
	ju72TMI2RzLFrh52MEcoQTY85XTxX6zCFT1ZnfHxw4ce1KR0Z3jkvfnBeGO9FUWVSs0u7FVo2g1DN
	5OpKF1nyxKsCmhEHhqstHLpB6no4KFnSyvNmtLA+9r0jcGP3A/fPWm0/JRdua/eYSZDWfEc/uN+mu
	WuL68jkA==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
	by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1vVD89-00000003Fw3-0rja;
	Mon, 15 Dec 2025 11:17:11 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1vVD7t-000000000gR-18Eu;
	Mon, 15 Dec 2025 11:16:53 -0700
From: Logan Gunthorpe <logang@deltatee.com>
To: dmaengine@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>
Cc: Kelvin Cao <kelvin.cao@microchip.com>,
	George Ge <George.Ge@microchip.com>,
	Christoph Hellwig <hch@infradead.org>,
	Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
	George Ge <george.ge@microchip.com>,
	Christoph Hellwig <hch@lst.de>,
	Logan Gunthorpe <logang@deltatee.com>
Date: Mon, 15 Dec 2025 11:16:48 -0700
Message-ID: <20251215181649.2605-3-logang@deltatee.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251215181649.2605-1-logang@deltatee.com>
References: <20251215181649.2605-1-logang@deltatee.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: dmaengine@vger.kernel.org, vkoul@kernel.org, hch@infradead.org, christophe.jaillet@wanadoo.fr, kelvin.cao@microchip.com, George.Ge@microchip.com, george.ge@microchip.com, hch@lst.de, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Level: 
Subject: [PATCH v11 2/3] dmaengine: switchtec-dma: Implement hardware initialization and cleanup
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)

From: Kelvin Cao <kelvin.cao@microchip.com>

Initialize the hardware and create the dma channel queues.

Signed-off-by: Kelvin Cao <kelvin.cao@microchip.com>
Co-developed-by: George Ge <george.ge@microchip.com>
Signed-off-by: George Ge <george.ge@microchip.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/dma/switchtec_dma.c | 1021 ++++++++++++++++++++++++++++++++++-
 1 file changed, 1019 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
index f3c366936684..648eabc0f5da 100644
--- a/drivers/dma/switchtec_dma.c
+++ b/drivers/dma/switchtec_dma.c
@@ -20,16 +20,990 @@ MODULE_VERSION("0.1");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Kelvin Cao");
 
+#define	SWITCHTEC_DMAC_CHAN_CTRL_OFFSET		0x1000
+#define	SWITCHTEC_DMAC_CHAN_CFG_STS_OFFSET	0x160000
+
+#define SWITCHTEC_DMA_CHAN_HW_REGS_SIZE		0x1000
+#define SWITCHTEC_DMA_CHAN_FW_REGS_SIZE		0x80
+
+#define SWITCHTEC_REG_CAP		0x80
+#define SWITCHTEC_REG_CHAN_CNT		0x84
+#define SWITCHTEC_REG_TAG_LIMIT		0x90
+#define SWITCHTEC_REG_CHAN_STS_VEC	0x94
+#define SWITCHTEC_REG_SE_BUF_CNT	0x98
+#define SWITCHTEC_REG_SE_BUF_BASE	0x9a
+
+#define SWITCHTEC_CHAN_CTRL_PAUSE	BIT(0)
+#define SWITCHTEC_CHAN_CTRL_HALT	BIT(1)
+#define SWITCHTEC_CHAN_CTRL_RESET	BIT(2)
+#define SWITCHTEC_CHAN_CTRL_ERR_PAUSE	BIT(3)
+
+#define SWITCHTEC_CHAN_STS_PAUSED	BIT(9)
+#define SWITCHTEC_CHAN_STS_HALTED	BIT(10)
+#define SWITCHTEC_CHAN_STS_PAUSED_MASK	GENMASK(29, 13)
+
+static const char * const channel_status_str[] = {
+	[13] = "received a VDM with length error status",
+	[14] = "received a VDM or Cpl with Unsupported Request error status",
+	[15] = "received a VDM or Cpl with Completion Abort error status",
+	[16] = "received a VDM with ECRC error status",
+	[17] = "received a VDM with EP error status",
+	[18] = "received a VDM with Reserved Cpl error status",
+	[19] = "received only part of split SE CplD",
+	[20] = "the ISP_DMAC detected a Completion Time Out",
+	[21] = "received a Cpl with Unsupported Request status",
+	[22] = "received a Cpl with Completion Abort status",
+	[23] = "received a Cpl with a reserved status",
+	[24] = "received a TLP with ECRC error status in its metadata",
+	[25] = "received a TLP with the EP bit set in the header",
+	[26] = "the ISP_DMAC tried to process a SE with an invalid Connection ID",
+	[27] = "the ISP_DMAC tried to process a SE with an invalid Remote Host interrupt",
+	[28] = "a reserved opcode was detected in an SE",
+	[29] = "received a SE Cpl with error status",
+};
+
+struct chan_hw_regs {
+	u16 cq_head;
+	u16 rsvd1;
+	u16 sq_tail;
+	u16 rsvd2;
+	u8 ctrl;
+	u8 rsvd3[3];
+	u16 status;
+	u16 rsvd4;
+};
+
+#define PERF_BURST_SCALE_MASK	GENMASK_U32(3,   2)
+#define PERF_MRRS_MASK		GENMASK_U32(6,   4)
+#define PERF_INTERVAL_MASK	GENMASK_U32(10,  8)
+#define PERF_BURST_SIZE_MASK	GENMASK_U32(14, 12)
+#define PERF_ARB_WEIGHT_MASK	GENMASK_U32(31, 24)
+
+#define SE_BUF_BASE_MASK	GENMASK_U32(10,  2)
+#define SE_BUF_LEN_MASK		GENMASK_U32(20, 12)
+#define SE_THRESH_MASK		GENMASK_U32(31, 23)
+
+#define SWITCHTEC_CHAN_ENABLE	BIT(1)
+
+struct chan_fw_regs {
+	u32 valid_en_se;
+	u32 cq_base_lo;
+	u32 cq_base_hi;
+	u16 cq_size;
+	u16 rsvd1;
+	u32 sq_base_lo;
+	u32 sq_base_hi;
+	u16 sq_size;
+	u16 rsvd2;
+	u32 int_vec;
+	u32 perf_cfg;
+	u32 rsvd3;
+	u32 perf_latency_selector;
+	u32 perf_fetched_se_cnt_lo;
+	u32 perf_fetched_se_cnt_hi;
+	u32 perf_byte_cnt_lo;
+	u32 perf_byte_cnt_hi;
+	u32 rsvd4;
+	u16 perf_se_pending;
+	u16 perf_se_buf_empty;
+	u32 perf_chan_idle;
+	u32 perf_lat_max;
+	u32 perf_lat_min;
+	u32 perf_lat_last;
+	u16 sq_current;
+	u16 sq_phase;
+	u16 cq_current;
+	u16 cq_phase;
+};
+
+struct switchtec_dma_chan {
+	struct switchtec_dma_dev *swdma_dev;
+	struct dma_chan dma_chan;
+	struct chan_hw_regs __iomem *mmio_chan_hw;
+	struct chan_fw_regs __iomem *mmio_chan_fw;
+
+	/* Serialize hardware control register access */
+	spinlock_t hw_ctrl_lock;
+
+	struct tasklet_struct desc_task;
+
+	/* Serialize descriptor preparation */
+	spinlock_t submit_lock;
+	bool ring_active;
+	int cid;
+
+	/* Serialize completion processing */
+	spinlock_t complete_lock;
+	bool comp_ring_active;
+
+	/* channel index and irq */
+	int index;
+	int irq;
+
+	/*
+	 * In driver context, head is advanced by producer while
+	 * tail is advanced by consumer.
+	 */
+
+	/* the head and tail for both desc_ring and hw_sq */
+	int head;
+	int tail;
+	int phase_tag;
+	struct switchtec_dma_desc **desc_ring;
+	struct switchtec_dma_hw_se_desc *hw_sq;
+	dma_addr_t dma_addr_sq;
+
+	/* the tail for hw_cq */
+	int cq_tail;
+	struct switchtec_dma_hw_ce *hw_cq;
+	dma_addr_t dma_addr_cq;
+
+	struct list_head list;
+};
+
 struct switchtec_dma_dev {
 	struct dma_device dma_dev;
 	struct pci_dev __rcu *pdev;
 	void __iomem *bar;
+
+	struct switchtec_dma_chan **swdma_chans;
+	int chan_cnt;
+	int chan_status_irq;
+};
+
+enum switchtec_dma_opcode {
+	SWITCHTEC_DMA_OPC_MEMCPY = 0,
+	SWITCHTEC_DMA_OPC_RDIMM = 0x1,
+	SWITCHTEC_DMA_OPC_WRIMM = 0x2,
+	SWITCHTEC_DMA_OPC_RHI = 0x6,
+	SWITCHTEC_DMA_OPC_NOP = 0x7,
+};
+
+struct switchtec_dma_hw_se_desc {
+	u8 opc;
+	u8 ctrl;
+	__le16 tlp_setting;
+	__le16 rsvd1;
+	__le16 cid;
+	__le32 byte_cnt;
+	__le32 addr_lo; /* SADDR_LO/WIADDR_LO */
+	__le32 addr_hi; /* SADDR_HI/WIADDR_HI */
+	__le32 daddr_lo;
+	__le32 daddr_hi;
+	__le16 dfid;
+	__le16 sfid;
+};
+
+#define SWITCHTEC_CE_SC_LEN_ERR		BIT(0)
+#define SWITCHTEC_CE_SC_UR		BIT(1)
+#define SWITCHTEC_CE_SC_CA		BIT(2)
+#define SWITCHTEC_CE_SC_RSVD_CPL	BIT(3)
+#define SWITCHTEC_CE_SC_ECRC_ERR	BIT(4)
+#define SWITCHTEC_CE_SC_EP_SET		BIT(5)
+#define SWITCHTEC_CE_SC_D_RD_CTO	BIT(8)
+#define SWITCHTEC_CE_SC_D_RIMM_UR	BIT(9)
+#define SWITCHTEC_CE_SC_D_RIMM_CA	BIT(10)
+#define SWITCHTEC_CE_SC_D_RIMM_RSVD_CPL	BIT(11)
+#define SWITCHTEC_CE_SC_D_ECRC		BIT(12)
+#define SWITCHTEC_CE_SC_D_EP_SET	BIT(13)
+#define SWITCHTEC_CE_SC_D_BAD_CONNID	BIT(14)
+#define SWITCHTEC_CE_SC_D_BAD_RHI_ADDR	BIT(15)
+#define SWITCHTEC_CE_SC_D_INVD_CMD	BIT(16)
+#define SWITCHTEC_CE_SC_MASK		GENMASK(16, 0)
+
+struct switchtec_dma_hw_ce {
+	__le32 rdimm_cpl_dw0;
+	__le32 rdimm_cpl_dw1;
+	__le32 rsvd1;
+	__le32 cpl_byte_cnt;
+	__le16 sq_head;
+	__le16 rsvd2;
+	__le32 rsvd3;
+	__le32 sts_code;
+	__le16 cid;
+	__le16 phase_tag;
+};
+
+struct switchtec_dma_desc {
+	struct dma_async_tx_descriptor txd;
+	struct switchtec_dma_hw_se_desc *hw;
+	u32 orig_size;
+	bool completed;
+};
+
+#define SWITCHTEC_DMA_SQ_SIZE	SZ_32K
+#define SWITCHTEC_DMA_CQ_SIZE	SZ_32K
+
+#define SWITCHTEC_DMA_RING_SIZE	SWITCHTEC_DMA_SQ_SIZE
+
+static int wait_for_chan_status(struct chan_hw_regs __iomem *chan_hw, u32 mask,
+				bool set)
+{
+	u32 status;
+
+	return readl_poll_timeout_atomic(&chan_hw->status, status,
+					 (set && (status & mask)) ||
+					 (!set && !(status & mask)),
+					 10, 100 * USEC_PER_MSEC);
+}
+
+static int halt_channel(struct switchtec_dma_chan *swdma_chan)
+{
+	struct chan_hw_regs __iomem *chan_hw = swdma_chan->mmio_chan_hw;
+	struct pci_dev *pdev;
+	int ret;
+
+	rcu_read_lock();
+	pdev = rcu_dereference(swdma_chan->swdma_dev->pdev);
+	if (!pdev) {
+		ret = -ENODEV;
+		goto unlock_and_exit;
+	}
+
+	spin_lock(&swdma_chan->hw_ctrl_lock);
+	writeb(SWITCHTEC_CHAN_CTRL_HALT, &chan_hw->ctrl);
+	ret = wait_for_chan_status(chan_hw, SWITCHTEC_CHAN_STS_HALTED, true);
+	spin_unlock(&swdma_chan->hw_ctrl_lock);
+
+unlock_and_exit:
+	rcu_read_unlock();
+	return ret;
+}
+
+static int unhalt_channel(struct switchtec_dma_chan *swdma_chan)
+{
+	struct chan_hw_regs __iomem *chan_hw = swdma_chan->mmio_chan_hw;
+	struct pci_dev *pdev;
+	u8 ctrl;
+	int ret;
+
+	rcu_read_lock();
+	pdev = rcu_dereference(swdma_chan->swdma_dev->pdev);
+	if (!pdev) {
+		ret = -ENODEV;
+		goto unlock_and_exit;
+	}
+
+	spin_lock(&swdma_chan->hw_ctrl_lock);
+	ctrl = readb(&chan_hw->ctrl);
+	ctrl &= ~SWITCHTEC_CHAN_CTRL_HALT;
+	writeb(ctrl, &chan_hw->ctrl);
+	ret = wait_for_chan_status(chan_hw, SWITCHTEC_CHAN_STS_HALTED, false);
+	spin_unlock(&swdma_chan->hw_ctrl_lock);
+
+unlock_and_exit:
+	rcu_read_unlock();
+	return ret;
+}
+
+static void flush_pci_write(struct chan_hw_regs __iomem *chan_hw)
+{
+	readl(&chan_hw->cq_head);
+}
+
+static int reset_channel(struct switchtec_dma_chan *swdma_chan)
+{
+	struct chan_hw_regs __iomem *chan_hw = swdma_chan->mmio_chan_hw;
+	struct pci_dev *pdev;
+
+	rcu_read_lock();
+	pdev = rcu_dereference(swdma_chan->swdma_dev->pdev);
+	if (!pdev) {
+		rcu_read_unlock();
+		return -ENODEV;
+	}
+
+	spin_lock(&swdma_chan->hw_ctrl_lock);
+	writel(SWITCHTEC_CHAN_CTRL_RESET | SWITCHTEC_CHAN_CTRL_ERR_PAUSE,
+	       &chan_hw->ctrl);
+	flush_pci_write(chan_hw);
+
+	udelay(1000);
+
+	writel(SWITCHTEC_CHAN_CTRL_ERR_PAUSE, &chan_hw->ctrl);
+	spin_unlock(&swdma_chan->hw_ctrl_lock);
+	flush_pci_write(chan_hw);
+
+	rcu_read_unlock();
+	return 0;
+}
+
+static int pause_reset_channel(struct switchtec_dma_chan *swdma_chan)
+{
+	struct chan_hw_regs __iomem *chan_hw = swdma_chan->mmio_chan_hw;
+	struct pci_dev *pdev;
+
+	rcu_read_lock();
+	pdev = rcu_dereference(swdma_chan->swdma_dev->pdev);
+	if (!pdev) {
+		rcu_read_unlock();
+		return -ENODEV;
+	}
+
+	spin_lock(&swdma_chan->hw_ctrl_lock);
+	writeb(SWITCHTEC_CHAN_CTRL_PAUSE, &chan_hw->ctrl);
+	spin_unlock(&swdma_chan->hw_ctrl_lock);
+
+	flush_pci_write(chan_hw);
+
+	rcu_read_unlock();
+
+	/* wait 60ms to ensure no pending CEs */
+	mdelay(60);
+
+	return reset_channel(swdma_chan);
+}
+
+enum chan_op {
+	ENABLE_CHAN,
+	DISABLE_CHAN,
 };
 
+static int channel_op(struct switchtec_dma_chan *swdma_chan, int op)
+{
+	struct chan_fw_regs __iomem *chan_fw = swdma_chan->mmio_chan_fw;
+	struct pci_dev *pdev;
+	u32 valid_en_se;
+
+	rcu_read_lock();
+	pdev = rcu_dereference(swdma_chan->swdma_dev->pdev);
+	if (!pdev) {
+		rcu_read_unlock();
+		return -ENODEV;
+	}
+
+	valid_en_se = readl(&chan_fw->valid_en_se);
+	if (op == ENABLE_CHAN)
+		valid_en_se |= SWITCHTEC_CHAN_ENABLE;
+	else
+		valid_en_se &= ~SWITCHTEC_CHAN_ENABLE;
+
+	writel(valid_en_se, &chan_fw->valid_en_se);
+
+	rcu_read_unlock();
+	return 0;
+}
+
+static int enable_channel(struct switchtec_dma_chan *swdma_chan)
+{
+	return channel_op(swdma_chan, ENABLE_CHAN);
+}
+
+static int disable_channel(struct switchtec_dma_chan *swdma_chan)
+{
+	return channel_op(swdma_chan, DISABLE_CHAN);
+}
+
+static void
+switchtec_dma_cleanup_completed(struct switchtec_dma_chan *swdma_chan)
+{
+	struct device *chan_dev = &swdma_chan->dma_chan.dev->device;
+	struct switchtec_dma_desc *desc;
+	struct switchtec_dma_hw_ce *ce;
+	struct dmaengine_result res;
+	int tail, cid, se_idx, i;
+	__le16 phase_tag;
+	u32 sts_code;
+	__le32 *p;
+
+	do {
+		spin_lock_bh(&swdma_chan->complete_lock);
+		if (!swdma_chan->comp_ring_active) {
+			spin_unlock_bh(&swdma_chan->complete_lock);
+			break;
+		}
+
+		ce = &swdma_chan->hw_cq[swdma_chan->cq_tail];
+		/*
+		 * phase_tag is updated by hardware, ensure the value is
+		 * not from the cache
+		 */
+		phase_tag = smp_load_acquire(&ce->phase_tag);
+		if (le16_to_cpu(phase_tag) == swdma_chan->phase_tag) {
+			spin_unlock_bh(&swdma_chan->complete_lock);
+			break;
+		}
+
+		cid = le16_to_cpu(ce->cid);
+		se_idx = cid & (SWITCHTEC_DMA_SQ_SIZE - 1);
+		desc = swdma_chan->desc_ring[se_idx];
+
+		tail = swdma_chan->tail;
+
+		res.residue = desc->orig_size - le32_to_cpu(ce->cpl_byte_cnt);
+
+		sts_code = le32_to_cpu(ce->sts_code);
+
+		if (!(sts_code & SWITCHTEC_CE_SC_MASK)) {
+			res.result = DMA_TRANS_NOERROR;
+		} else {
+			if (sts_code & SWITCHTEC_CE_SC_D_RD_CTO)
+				res.result = DMA_TRANS_READ_FAILED;
+			else
+				res.result = DMA_TRANS_WRITE_FAILED;
+
+			dev_err(chan_dev, "CID 0x%04x failed, SC 0x%08x\n", cid,
+				(u32)(sts_code & SWITCHTEC_CE_SC_MASK));
+
+			p = (__le32 *)ce;
+			for (i = 0; i < sizeof(*ce) / 4; i++) {
+				dev_err(chan_dev, "CE DW%d: 0x%08x\n", i,
+					le32_to_cpu(*p));
+				p++;
+			}
+		}
+
+		desc->completed = true;
+
+		swdma_chan->cq_tail++;
+		swdma_chan->cq_tail &= SWITCHTEC_DMA_CQ_SIZE - 1;
+
+		rcu_read_lock();
+		if (!rcu_dereference(swdma_chan->swdma_dev->pdev)) {
+			rcu_read_unlock();
+			spin_unlock_bh(&swdma_chan->complete_lock);
+			return;
+		}
+		writew(swdma_chan->cq_tail, &swdma_chan->mmio_chan_hw->cq_head);
+		rcu_read_unlock();
+
+		if (swdma_chan->cq_tail == 0)
+			swdma_chan->phase_tag = !swdma_chan->phase_tag;
+
+		/*  Out of order CE */
+		if (se_idx != tail) {
+			spin_unlock_bh(&swdma_chan->complete_lock);
+			continue;
+		}
+
+		do {
+			dma_cookie_complete(&desc->txd);
+			dma_descriptor_unmap(&desc->txd);
+			dmaengine_desc_get_callback_invoke(&desc->txd, &res);
+			desc->txd.callback = NULL;
+			desc->txd.callback_result = NULL;
+			desc->completed = false;
+
+			tail++;
+			tail &= SWITCHTEC_DMA_SQ_SIZE - 1;
+
+			/*
+			 * Ensure the desc updates are visible before updating
+			 * the tail index
+			 */
+			smp_store_release(&swdma_chan->tail, tail);
+			desc = swdma_chan->desc_ring[swdma_chan->tail];
+			if (!desc->completed)
+				break;
+		} while (CIRC_CNT(READ_ONCE(swdma_chan->head), swdma_chan->tail,
+				  SWITCHTEC_DMA_SQ_SIZE));
+
+		spin_unlock_bh(&swdma_chan->complete_lock);
+	} while (1);
+}
+
+static void
+switchtec_dma_abort_desc(struct switchtec_dma_chan *swdma_chan, int force)
+{
+	struct switchtec_dma_desc *desc;
+	struct dmaengine_result res;
+
+	if (!force)
+		switchtec_dma_cleanup_completed(swdma_chan);
+
+	spin_lock_bh(&swdma_chan->complete_lock);
+
+	while (CIRC_CNT(swdma_chan->head, swdma_chan->tail,
+			SWITCHTEC_DMA_SQ_SIZE) >= 1) {
+		desc = swdma_chan->desc_ring[swdma_chan->tail];
+
+		res.residue = desc->orig_size;
+		res.result = DMA_TRANS_ABORTED;
+
+		dma_cookie_complete(&desc->txd);
+		dma_descriptor_unmap(&desc->txd);
+		if (!force)
+			dmaengine_desc_get_callback_invoke(&desc->txd, &res);
+		desc->txd.callback = NULL;
+		desc->txd.callback_result = NULL;
+
+		swdma_chan->tail++;
+		swdma_chan->tail &= SWITCHTEC_DMA_SQ_SIZE - 1;
+	}
+
+	spin_unlock_bh(&swdma_chan->complete_lock);
+}
+
+static void switchtec_dma_chan_stop(struct switchtec_dma_chan *swdma_chan)
+{
+	int rc;
+
+	rc = halt_channel(swdma_chan);
+	if (rc)
+		return;
+
+	rcu_read_lock();
+	if (!rcu_dereference(swdma_chan->swdma_dev->pdev)) {
+		rcu_read_unlock();
+		return;
+	}
+
+	writel(0, &swdma_chan->mmio_chan_fw->sq_base_lo);
+	writel(0, &swdma_chan->mmio_chan_fw->sq_base_hi);
+	writel(0, &swdma_chan->mmio_chan_fw->cq_base_lo);
+	writel(0, &swdma_chan->mmio_chan_fw->cq_base_hi);
+
+	rcu_read_unlock();
+}
+
+static int switchtec_dma_terminate_all(struct dma_chan *chan)
+{
+	struct switchtec_dma_chan *swdma_chan =
+		container_of(chan, struct switchtec_dma_chan, dma_chan);
+
+	spin_lock_bh(&swdma_chan->complete_lock);
+	swdma_chan->comp_ring_active = false;
+	spin_unlock_bh(&swdma_chan->complete_lock);
+
+	return pause_reset_channel(swdma_chan);
+}
+
+static void switchtec_dma_synchronize(struct dma_chan *chan)
+{
+	struct switchtec_dma_chan *swdma_chan =
+		container_of(chan, struct switchtec_dma_chan, dma_chan);
+
+	int rc;
+
+	switchtec_dma_abort_desc(swdma_chan, 1);
+
+	rc = enable_channel(swdma_chan);
+	if (rc)
+		return;
+
+	rc = reset_channel(swdma_chan);
+	if (rc)
+		return;
+
+	rc = unhalt_channel(swdma_chan);
+	if (rc)
+		return;
+
+	spin_lock_bh(&swdma_chan->submit_lock);
+	swdma_chan->head = 0;
+	spin_unlock_bh(&swdma_chan->submit_lock);
+
+	spin_lock_bh(&swdma_chan->complete_lock);
+	swdma_chan->comp_ring_active = true;
+	swdma_chan->phase_tag = 0;
+	swdma_chan->tail = 0;
+	swdma_chan->cq_tail = 0;
+	swdma_chan->cid = 0;
+	dma_cookie_init(chan);
+	spin_unlock_bh(&swdma_chan->complete_lock);
+}
+
+static void switchtec_dma_desc_task(unsigned long data)
+{
+	struct switchtec_dma_chan *swdma_chan = (void *)data;
+
+	switchtec_dma_cleanup_completed(swdma_chan);
+}
+
+static irqreturn_t switchtec_dma_isr(int irq, void *chan)
+{
+	struct switchtec_dma_chan *swdma_chan = chan;
+
+	if (swdma_chan->comp_ring_active)
+		tasklet_schedule(&swdma_chan->desc_task);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t switchtec_dma_chan_status_isr(int irq, void *dma)
+{
+	struct switchtec_dma_dev *swdma_dev = dma;
+	struct dma_device *dma_dev = &swdma_dev->dma_dev;
+	struct switchtec_dma_chan *swdma_chan;
+	struct chan_hw_regs __iomem *chan_hw;
+	struct device *chan_dev;
+	struct dma_chan *chan;
+	u32 chan_status;
+	int bit;
+
+	list_for_each_entry(chan, &dma_dev->channels, device_node) {
+		swdma_chan = container_of(chan, struct switchtec_dma_chan,
+					  dma_chan);
+		chan_dev = &swdma_chan->dma_chan.dev->device;
+		chan_hw = swdma_chan->mmio_chan_hw;
+
+		rcu_read_lock();
+		if (!rcu_dereference(swdma_dev->pdev)) {
+			rcu_read_unlock();
+			goto out;
+		}
+
+		chan_status = readl(&chan_hw->status);
+		chan_status &= SWITCHTEC_CHAN_STS_PAUSED_MASK;
+		rcu_read_unlock();
+
+		bit = ffs(chan_status);
+		if (!bit)
+			dev_dbg(chan_dev, "No pause bit set.\n");
+		else
+			dev_err(chan_dev, "Paused, %s\n",
+				channel_status_str[bit - 1]);
+	}
+
+out:
+	return IRQ_HANDLED;
+}
+
+static void switchtec_dma_free_desc(struct switchtec_dma_chan *swdma_chan)
+{
+	struct switchtec_dma_dev *swdma_dev = swdma_chan->swdma_dev;
+	size_t size;
+	int i;
+
+	size = SWITCHTEC_DMA_SQ_SIZE * sizeof(*swdma_chan->hw_sq);
+	if (swdma_chan->hw_sq)
+		dma_free_coherent(swdma_dev->dma_dev.dev, size,
+				  swdma_chan->hw_sq, swdma_chan->dma_addr_sq);
+
+	size = SWITCHTEC_DMA_CQ_SIZE * sizeof(*swdma_chan->hw_cq);
+	if (swdma_chan->hw_cq)
+		dma_free_coherent(swdma_dev->dma_dev.dev, size,
+				  swdma_chan->hw_cq, swdma_chan->dma_addr_cq);
+
+	if (swdma_chan->desc_ring) {
+		for (i = 0; i < SWITCHTEC_DMA_RING_SIZE; i++)
+			kfree(swdma_chan->desc_ring[i]);
+
+		kfree(swdma_chan->desc_ring);
+	}
+}
+
+static int switchtec_dma_alloc_desc(struct switchtec_dma_chan *swdma_chan)
+{
+	struct switchtec_dma_dev *swdma_dev = swdma_chan->swdma_dev;
+	struct chan_fw_regs __iomem *chan_fw = swdma_chan->mmio_chan_fw;
+	struct switchtec_dma_desc *desc;
+	struct pci_dev *pdev;
+	size_t size;
+	int rc, i;
+
+	swdma_chan->head = 0;
+	swdma_chan->tail = 0;
+	swdma_chan->cq_tail = 0;
+
+	size = SWITCHTEC_DMA_SQ_SIZE * sizeof(*swdma_chan->hw_sq);
+	swdma_chan->hw_sq = dma_alloc_coherent(swdma_dev->dma_dev.dev, size,
+					       &swdma_chan->dma_addr_sq,
+					       GFP_NOWAIT);
+	if (!swdma_chan->hw_sq) {
+		rc = -ENOMEM;
+		goto free_and_exit;
+	}
+
+	size = SWITCHTEC_DMA_CQ_SIZE * sizeof(*swdma_chan->hw_cq);
+	swdma_chan->hw_cq = dma_alloc_coherent(swdma_dev->dma_dev.dev, size,
+					       &swdma_chan->dma_addr_cq,
+					       GFP_NOWAIT);
+	if (!swdma_chan->hw_cq) {
+		rc = -ENOMEM;
+		goto free_and_exit;
+	}
+
+	/* reset host phase tag */
+	swdma_chan->phase_tag = 0;
+
+	size = sizeof(*swdma_chan->desc_ring);
+	swdma_chan->desc_ring = kcalloc(SWITCHTEC_DMA_RING_SIZE, size,
+					GFP_NOWAIT);
+	if (!swdma_chan->desc_ring) {
+		rc = -ENOMEM;
+		goto free_and_exit;
+	}
+
+	for (i = 0; i < SWITCHTEC_DMA_RING_SIZE; i++) {
+		desc = kzalloc(sizeof(*desc), GFP_NOWAIT);
+		if (!desc) {
+			rc = -ENOMEM;
+			goto free_and_exit;
+		}
+
+		dma_async_tx_descriptor_init(&desc->txd, &swdma_chan->dma_chan);
+		desc->hw = &swdma_chan->hw_sq[i];
+		desc->completed = true;
+
+		swdma_chan->desc_ring[i] = desc;
+	}
+
+	rcu_read_lock();
+	pdev = rcu_dereference(swdma_dev->pdev);
+	if (!pdev) {
+		rcu_read_unlock();
+		rc = -ENODEV;
+		goto free_and_exit;
+	}
+
+	/* set sq/cq */
+	writel(lower_32_bits(swdma_chan->dma_addr_sq), &chan_fw->sq_base_lo);
+	writel(upper_32_bits(swdma_chan->dma_addr_sq), &chan_fw->sq_base_hi);
+	writel(lower_32_bits(swdma_chan->dma_addr_cq), &chan_fw->cq_base_lo);
+	writel(upper_32_bits(swdma_chan->dma_addr_cq), &chan_fw->cq_base_hi);
+
+	writew(SWITCHTEC_DMA_SQ_SIZE, &swdma_chan->mmio_chan_fw->sq_size);
+	writew(SWITCHTEC_DMA_CQ_SIZE, &swdma_chan->mmio_chan_fw->cq_size);
+
+	rcu_read_unlock();
+	return 0;
+
+free_and_exit:
+	switchtec_dma_free_desc(swdma_chan);
+	return rc;
+}
+
+static int switchtec_dma_alloc_chan_resources(struct dma_chan *chan)
+{
+	struct switchtec_dma_chan *swdma_chan =
+		container_of(chan, struct switchtec_dma_chan, dma_chan);
+	struct switchtec_dma_dev *swdma_dev = swdma_chan->swdma_dev;
+	u32 perf_cfg;
+	int rc;
+
+	rc = switchtec_dma_alloc_desc(swdma_chan);
+	if (rc)
+		return rc;
+
+	rc = enable_channel(swdma_chan);
+	if (rc)
+		return rc;
+
+	rc = reset_channel(swdma_chan);
+	if (rc)
+		return rc;
+
+	rc = unhalt_channel(swdma_chan);
+	if (rc)
+		return rc;
+
+	swdma_chan->ring_active = true;
+	swdma_chan->comp_ring_active = true;
+	swdma_chan->cid = 0;
+
+	dma_cookie_init(chan);
+
+	rcu_read_lock();
+	if (!rcu_dereference(swdma_dev->pdev)) {
+		rcu_read_unlock();
+		return -ENODEV;
+	}
+
+	perf_cfg = readl(&swdma_chan->mmio_chan_fw->perf_cfg);
+	rcu_read_unlock();
+
+	dev_dbg(&chan->dev->device, "Burst Size:  0x%x\n",
+		FIELD_GET(PERF_BURST_SIZE_MASK, perf_cfg));
+
+	dev_dbg(&chan->dev->device, "Burst Scale: 0x%x\n",
+		FIELD_GET(PERF_BURST_SCALE_MASK, perf_cfg));
+
+	dev_dbg(&chan->dev->device, "Interval:    0x%x\n",
+		FIELD_GET(PERF_INTERVAL_MASK, perf_cfg));
+
+	dev_dbg(&chan->dev->device, "Arb Weight:  0x%x\n",
+		FIELD_GET(PERF_ARB_WEIGHT_MASK, perf_cfg));
+
+	dev_dbg(&chan->dev->device, "MRRS:        0x%x\n",
+		FIELD_GET(PERF_MRRS_MASK, perf_cfg));
+
+	return SWITCHTEC_DMA_SQ_SIZE;
+}
+
+static void switchtec_dma_free_chan_resources(struct dma_chan *chan)
+{
+	struct switchtec_dma_chan *swdma_chan =
+		container_of(chan, struct switchtec_dma_chan, dma_chan);
+
+	spin_lock_bh(&swdma_chan->submit_lock);
+	swdma_chan->ring_active = false;
+	spin_unlock_bh(&swdma_chan->submit_lock);
+
+	spin_lock_bh(&swdma_chan->complete_lock);
+	swdma_chan->comp_ring_active = false;
+	spin_unlock_bh(&swdma_chan->complete_lock);
+
+	switchtec_dma_chan_stop(swdma_chan);
+
+	tasklet_kill(&swdma_chan->desc_task);
+
+	switchtec_dma_abort_desc(swdma_chan, 0);
+
+	switchtec_dma_free_desc(swdma_chan);
+
+	disable_channel(swdma_chan);
+}
+
+static int switchtec_dma_chan_init(struct switchtec_dma_dev *swdma_dev,
+				   struct pci_dev *pdev, int i)
+{
+	struct dma_device *dma = &swdma_dev->dma_dev;
+	struct switchtec_dma_chan *swdma_chan;
+	u32 valid_en_se, thresh;
+	int se_buf_len, irq, rc;
+	struct dma_chan *chan;
+
+	swdma_chan = kzalloc(sizeof(*swdma_chan), GFP_KERNEL);
+	if (!swdma_chan)
+		return -ENOMEM;
+
+	swdma_chan->phase_tag = 0;
+	swdma_chan->index = i;
+	swdma_chan->swdma_dev = swdma_dev;
+
+	spin_lock_init(&swdma_chan->hw_ctrl_lock);
+	spin_lock_init(&swdma_chan->submit_lock);
+	spin_lock_init(&swdma_chan->complete_lock);
+	tasklet_init(&swdma_chan->desc_task, switchtec_dma_desc_task,
+		     (unsigned long)swdma_chan);
+
+	swdma_chan->mmio_chan_fw =
+		swdma_dev->bar + SWITCHTEC_DMAC_CHAN_CFG_STS_OFFSET +
+		i * SWITCHTEC_DMA_CHAN_FW_REGS_SIZE;
+	swdma_chan->mmio_chan_hw =
+		swdma_dev->bar + SWITCHTEC_DMAC_CHAN_CTRL_OFFSET +
+		i * SWITCHTEC_DMA_CHAN_HW_REGS_SIZE;
+
+	swdma_dev->swdma_chans[i] = swdma_chan;
+
+	rc = pause_reset_channel(swdma_chan);
+	if (rc)
+		goto free_and_exit;
+
+	/* init perf tuner */
+	writel(FIELD_PREP(PERF_BURST_SCALE_MASK, 1) |
+	       FIELD_PREP(PERF_MRRS_MASK, 3) |
+	       FIELD_PREP(PERF_BURST_SIZE_MASK, 6) |
+	       FIELD_PREP(PERF_ARB_WEIGHT_MASK, 1),
+	       &swdma_chan->mmio_chan_fw->perf_cfg);
+
+	valid_en_se = readl(&swdma_chan->mmio_chan_fw->valid_en_se);
+
+	dev_dbg(&pdev->dev, "Channel %d: SE buffer base %d\n", i,
+		FIELD_GET(SE_BUF_BASE_MASK, valid_en_se));
+
+	se_buf_len = FIELD_GET(SE_BUF_LEN_MASK, valid_en_se);
+	dev_dbg(&pdev->dev, "Channel %d: SE buffer count %d\n", i, se_buf_len);
+
+	thresh = se_buf_len / 2;
+	valid_en_se |= FIELD_GET(SE_THRESH_MASK, thresh);
+	writel(valid_en_se, &swdma_chan->mmio_chan_fw->valid_en_se);
+
+	/* request irqs */
+	irq = readl(&swdma_chan->mmio_chan_fw->int_vec);
+	dev_dbg(&pdev->dev, "Channel %d: CE irq vector %d\n", i, irq);
+
+	rc = pci_request_irq(pdev, irq, switchtec_dma_isr, NULL, swdma_chan,
+			     KBUILD_MODNAME);
+	if (rc)
+		goto free_and_exit;
+
+	swdma_chan->irq = irq;
+
+	chan = &swdma_chan->dma_chan;
+	chan->device = dma;
+	dma_cookie_init(chan);
+
+	list_add_tail(&chan->device_node, &dma->channels);
+
+	return 0;
+
+free_and_exit:
+	kfree(swdma_chan);
+	return rc;
+}
+
+static int switchtec_dma_chan_free(struct pci_dev *pdev,
+				   struct switchtec_dma_chan *swdma_chan)
+{
+	spin_lock_bh(&swdma_chan->submit_lock);
+	swdma_chan->ring_active = false;
+	spin_unlock_bh(&swdma_chan->submit_lock);
+
+	spin_lock_bh(&swdma_chan->complete_lock);
+	swdma_chan->comp_ring_active = false;
+	spin_unlock_bh(&swdma_chan->complete_lock);
+
+	pci_free_irq(pdev, swdma_chan->irq, swdma_chan);
+
+	switchtec_dma_chan_stop(swdma_chan);
+
+	return 0;
+}
+
+static int switchtec_dma_chans_release(struct pci_dev *pdev,
+				       struct switchtec_dma_dev *swdma_dev)
+{
+	int i;
+
+	for (i = 0; i < swdma_dev->chan_cnt; i++)
+		switchtec_dma_chan_free(pdev, swdma_dev->swdma_chans[i]);
+
+	return 0;
+}
+
+static int switchtec_dma_chans_enumerate(struct switchtec_dma_dev *swdma_dev,
+					 struct pci_dev *pdev, int chan_cnt)
+{
+	struct dma_device *dma = &swdma_dev->dma_dev;
+	int base, cnt, rc, i;
+
+	swdma_dev->swdma_chans = kcalloc(chan_cnt, sizeof(*swdma_dev->swdma_chans),
+					 GFP_KERNEL);
+
+	if (!swdma_dev->swdma_chans)
+		return -ENOMEM;
+
+	base = readw(swdma_dev->bar + SWITCHTEC_REG_SE_BUF_BASE);
+	cnt = readw(swdma_dev->bar + SWITCHTEC_REG_SE_BUF_CNT);
+
+	dev_dbg(&pdev->dev, "EP SE buffer base %d\n", base);
+	dev_dbg(&pdev->dev, "EP SE buffer count %d\n", cnt);
+
+	INIT_LIST_HEAD(&dma->channels);
+
+	for (i = 0; i < chan_cnt; i++) {
+		rc = switchtec_dma_chan_init(swdma_dev, pdev, i);
+		if (rc) {
+			dev_err(&pdev->dev, "Channel %d: init channel failed\n",
+				i);
+			chan_cnt = i;
+			goto err_exit;
+		}
+	}
+
+	return chan_cnt;
+
+err_exit:
+	for (i = 0; i < chan_cnt; i++)
+		switchtec_dma_chan_free(pdev, swdma_dev->swdma_chans[i]);
+
+	kfree(swdma_dev->swdma_chans);
+
+	return rc;
+}
+
 static void switchtec_dma_release(struct dma_device *dma_dev)
 {
 	struct switchtec_dma_dev *swdma_dev =
 		container_of(dma_dev, struct switchtec_dma_dev, dma_dev);
+	int i;
+
+	for (i = 0; i < swdma_dev->chan_cnt; i++)
+		kfree(swdma_dev->swdma_chans[i]);
+
+	kfree(swdma_dev->swdma_chans);
 
 	put_device(dma_dev->dev);
 	kfree(swdma_dev);
@@ -38,9 +1012,9 @@ static void switchtec_dma_release(struct dma_device *dma_dev)
 static int switchtec_dma_create(struct pci_dev *pdev)
 {
 	struct switchtec_dma_dev *swdma_dev;
+	int chan_cnt, nr_vecs, irq, rc;
 	struct dma_device *dma;
 	struct dma_chan *chan;
-	int nr_vecs, rc;
 
 	/*
 	 * Create the switchtec dma device
@@ -61,18 +1035,51 @@ static int switchtec_dma_create(struct pci_dev *pdev)
 	if (rc < 0)
 		goto err_exit;
 
+	irq = readw(swdma_dev->bar + SWITCHTEC_REG_CHAN_STS_VEC);
+	pci_dbg(pdev, "Channel pause irq vector %d\n", irq);
+
+	rc = pci_request_irq(pdev, irq, NULL, switchtec_dma_chan_status_isr,
+			     swdma_dev, KBUILD_MODNAME);
+	if (rc)
+		goto err_exit;
+
+	swdma_dev->chan_status_irq = irq;
+
+	chan_cnt = readl(swdma_dev->bar + SWITCHTEC_REG_CHAN_CNT);
+	if (!chan_cnt) {
+		pci_err(pdev, "No channel configured.\n");
+		rc = -ENXIO;
+		goto err_exit;
+	}
+
+	chan_cnt = switchtec_dma_chans_enumerate(swdma_dev, pdev, chan_cnt);
+	if (chan_cnt < 0) {
+		pci_err(pdev, "Failed to enumerate dma channels: %d\n",
+			chan_cnt);
+		rc = -ENXIO;
+		goto err_exit;
+	}
+
+	swdma_dev->chan_cnt = chan_cnt;
+
 	dma = &swdma_dev->dma_dev;
 	dma->copy_align = DMAENGINE_ALIGN_8_BYTES;
 	dma->dev = get_device(&pdev->dev);
 
+	dma->device_alloc_chan_resources = switchtec_dma_alloc_chan_resources;
+	dma->device_free_chan_resources = switchtec_dma_free_chan_resources;
+	dma->device_terminate_all = switchtec_dma_terminate_all;
+	dma->device_synchronize = switchtec_dma_synchronize;
 	dma->device_release = switchtec_dma_release;
 
 	rc = dma_async_device_register(dma);
 	if (rc) {
 		pci_err(pdev, "Failed to register dma device: %d\n", rc);
-		goto err_exit;
+		goto err_chans_release_exit;
 	}
 
+	pci_info(pdev, "Channel count: %d\n", chan_cnt);
+
 	list_for_each_entry(chan, &dma->channels, device_node)
 		pci_info(pdev, "%s\n", dma_chan_name(chan));
 
@@ -80,7 +1087,13 @@ static int switchtec_dma_create(struct pci_dev *pdev)
 
 	return 0;
 
+err_chans_release_exit:
+	switchtec_dma_chans_release(pdev, swdma_dev);
+
 err_exit:
+	if (swdma_dev->chan_status_irq)
+		free_irq(swdma_dev->chan_status_irq, swdma_dev);
+
 	iounmap(swdma_dev->bar);
 	kfree(swdma_dev);
 	return rc;
@@ -127,9 +1140,13 @@ static void switchtec_dma_remove(struct pci_dev *pdev)
 {
 	struct switchtec_dma_dev *swdma_dev = pci_get_drvdata(pdev);
 
+	switchtec_dma_chans_release(pdev, swdma_dev);
+
 	rcu_assign_pointer(swdma_dev->pdev, NULL);
 	synchronize_rcu();
 
+	pci_free_irq(pdev, swdma_dev->chan_status_irq, swdma_dev);
+
 	pci_free_irq_vectors(pdev);
 
 	dma_async_device_unregister(&swdma_dev->dma_dev);
-- 
2.47.3


