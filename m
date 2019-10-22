Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A37A8E0DEB
	for <lists+dmaengine@lfdr.de>; Tue, 22 Oct 2019 23:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733279AbfJVVqa (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 22 Oct 2019 17:46:30 -0400
Received: from ale.deltatee.com ([207.54.116.67]:33088 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733228AbfJVVqY (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 22 Oct 2019 17:46:24 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1iN1ys-00049Q-Re; Tue, 22 Oct 2019 15:46:23 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1iN1ys-000256-Cd; Tue, 22 Oct 2019 15:46:18 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Tue, 22 Oct 2019 15:46:15 -0600
Message-Id: <20191022214616.7943-5-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191022214616.7943-1-logang@deltatee.com>
References: <20191022214616.7943-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org, dan.j.williams@intel.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_FREE,MYRULES_NO_TEXT autolearn=ham
        autolearn_force=no version=3.4.2
Subject: [PATCH 4/5] dmaengine: plx-dma: Implement hardware initialization and cleanup
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Allocate DMA coherent memory for the ring of DMA descriptors and
program the appropriate hardware registers.

A tasklet is created which is triggered on an interrupt to process
all the finished requests. Additionally, any remaining descriptors
are aborted when the hardware is removed or the resources freed.

Use an RCU pointer to synchronize PCI device unbind.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/dma/plx_dma.c | 332 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 331 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/plx_dma.c b/drivers/dma/plx_dma.c
index 8668dad790b6..d3c2319e2fad 100644
--- a/drivers/dma/plx_dma.c
+++ b/drivers/dma/plx_dma.c
@@ -18,13 +18,103 @@ MODULE_VERSION("0.1");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Logan Gunthorpe");
 
+#define PLX_REG_DESC_RING_ADDR			0x214
+#define PLX_REG_DESC_RING_ADDR_HI		0x218
+#define PLX_REG_DESC_RING_NEXT_ADDR		0x21C
+#define PLX_REG_DESC_RING_COUNT			0x220
+#define PLX_REG_DESC_RING_LAST_ADDR		0x224
+#define PLX_REG_DESC_RING_LAST_SIZE		0x228
+#define PLX_REG_PREF_LIMIT			0x234
+#define PLX_REG_CTRL				0x238
+#define PLX_REG_CTRL2				0x23A
+#define PLX_REG_INTR_CTRL			0x23C
+#define PLX_REG_INTR_STATUS			0x23E
+
+#define PLX_REG_PREF_LIMIT_PREF_FOUR		8
+
+#define PLX_REG_CTRL_GRACEFUL_PAUSE		BIT(0)
+#define PLX_REG_CTRL_ABORT			BIT(1)
+#define PLX_REG_CTRL_WRITE_BACK_EN		BIT(2)
+#define PLX_REG_CTRL_START			BIT(3)
+#define PLX_REG_CTRL_RING_STOP_MODE		BIT(4)
+#define PLX_REG_CTRL_DESC_MODE_BLOCK		(0 << 5)
+#define PLX_REG_CTRL_DESC_MODE_ON_CHIP		(1 << 5)
+#define PLX_REG_CTRL_DESC_MODE_OFF_CHIP		(2 << 5)
+#define PLX_REG_CTRL_DESC_INVALID		BIT(8)
+#define PLX_REG_CTRL_GRACEFUL_PAUSE_DONE	BIT(9)
+#define PLX_REG_CTRL_ABORT_DONE			BIT(10)
+#define PLX_REG_CTRL_IMM_PAUSE_DONE		BIT(12)
+#define PLX_REG_CTRL_IN_PROGRESS		BIT(30)
+
+#define PLX_REG_CTRL_RESET_VAL	(PLX_REG_CTRL_DESC_INVALID | \
+				 PLX_REG_CTRL_GRACEFUL_PAUSE_DONE | \
+				 PLX_REG_CTRL_ABORT_DONE | \
+				 PLX_REG_CTRL_IMM_PAUSE_DONE)
+
+#define PLX_REG_CTRL_START_VAL	(PLX_REG_CTRL_WRITE_BACK_EN | \
+				 PLX_REG_CTRL_DESC_MODE_OFF_CHIP | \
+				 PLX_REG_CTRL_START | \
+				 PLX_REG_CTRL_RESET_VAL)
+
+#define PLX_REG_CTRL2_MAX_TXFR_SIZE_64B		0
+#define PLX_REG_CTRL2_MAX_TXFR_SIZE_128B	1
+#define PLX_REG_CTRL2_MAX_TXFR_SIZE_256B	2
+#define PLX_REG_CTRL2_MAX_TXFR_SIZE_512B	3
+#define PLX_REG_CTRL2_MAX_TXFR_SIZE_1KB		4
+#define PLX_REG_CTRL2_MAX_TXFR_SIZE_2KB		5
+#define PLX_REG_CTRL2_MAX_TXFR_SIZE_4B		7
+
+#define PLX_REG_INTR_CRTL_ERROR_EN		BIT(0)
+#define PLX_REG_INTR_CRTL_INV_DESC_EN		BIT(1)
+#define PLX_REG_INTR_CRTL_ABORT_DONE_EN		BIT(3)
+#define PLX_REG_INTR_CRTL_PAUSE_DONE_EN		BIT(4)
+#define PLX_REG_INTR_CRTL_IMM_PAUSE_DONE_EN	BIT(5)
+
+#define PLX_REG_INTR_STATUS_ERROR		BIT(0)
+#define PLX_REG_INTR_STATUS_INV_DESC		BIT(1)
+#define PLX_REG_INTR_STATUS_DESC_DONE		BIT(2)
+#define PLX_REG_INTR_CRTL_ABORT_DONE		BIT(3)
+
+struct plx_dma_hw_std_desc {
+	__le32 flags_and_size;
+	__le16 dst_addr_hi;
+	__le16 src_addr_hi;
+	__le32 dst_addr_lo;
+	__le32 src_addr_lo;
+};
+
+#define PLX_DESC_SIZE_MASK		0x7ffffff
+#define PLX_DESC_FLAG_VALID		BIT(31)
+#define PLX_DESC_FLAG_INT_WHEN_DONE	BIT(30)
+
+#define PLX_DESC_WB_SUCCESS		BIT(30)
+#define PLX_DESC_WB_RD_FAIL		BIT(29)
+#define PLX_DESC_WB_WR_FAIL		BIT(28)
+
+#define PLX_DMA_RING_COUNT		2048
+
+struct plx_dma_desc {
+	struct dma_async_tx_descriptor txd;
+	struct plx_dma_hw_std_desc *hw;
+	u32 orig_size;
+};
+
 struct plx_dma_dev {
 	struct dma_device dma_dev;
 	struct dma_chan dma_chan;
+	struct pci_dev __rcu *pdev;
 	void __iomem *bar;
 
 	struct kref ref;
 	struct work_struct release_work;
+	struct tasklet_struct desc_task;
+
+	spinlock_t ring_lock;
+	bool ring_active;
+	int head;
+	int tail;
+	struct plx_dma_hw_std_desc *hw_ring;
+	struct plx_dma_desc **desc_ring;
 };
 
 static struct plx_dma_dev *chan_to_plx_dma_dev(struct dma_chan *c)
@@ -32,8 +122,143 @@ static struct plx_dma_dev *chan_to_plx_dma_dev(struct dma_chan *c)
 	return container_of(c, struct plx_dma_dev, dma_chan);
 }
 
+static struct plx_dma_desc *plx_dma_get_desc(struct plx_dma_dev *plxdev, int i)
+{
+	return plxdev->desc_ring[i & (PLX_DMA_RING_COUNT - 1)];
+}
+
+static void plx_dma_process_desc(struct plx_dma_dev *plxdev)
+{
+	struct dmaengine_result res;
+	struct plx_dma_desc *desc;
+	u32 flags;
+
+	spin_lock_bh(&plxdev->ring_lock);
+
+	while (plxdev->tail != plxdev->head) {
+		desc = plx_dma_get_desc(plxdev, plxdev->tail);
+
+		flags = le32_to_cpu(READ_ONCE(desc->hw->flags_and_size));
+
+		if (flags & PLX_DESC_FLAG_VALID)
+			break;
+
+		res.residue = desc->orig_size - (flags & PLX_DESC_SIZE_MASK);
+
+		if (flags & PLX_DESC_WB_SUCCESS)
+			res.result = DMA_TRANS_NOERROR;
+		else if (flags & PLX_DESC_WB_WR_FAIL)
+			res.result = DMA_TRANS_WRITE_FAILED;
+		else
+			res.result = DMA_TRANS_READ_FAILED;
+
+		dma_cookie_complete(&desc->txd);
+		dma_descriptor_unmap(&desc->txd);
+		dmaengine_desc_get_callback_invoke(&desc->txd, &res);
+		desc->txd.callback = NULL;
+		desc->txd.callback_result = NULL;
+
+		plxdev->tail++;
+	}
+
+	spin_unlock_bh(&plxdev->ring_lock);
+}
+
+static void plx_dma_abort_desc(struct plx_dma_dev *plxdev)
+{
+	struct dmaengine_result res;
+	struct plx_dma_desc *desc;
+
+	plx_dma_process_desc(plxdev);
+
+	spin_lock_bh(&plxdev->ring_lock);
+
+	while (plxdev->tail != plxdev->head) {
+		desc = plx_dma_get_desc(plxdev, plxdev->tail);
+
+		res.residue = desc->orig_size;
+		res.result = DMA_TRANS_ABORTED;
+
+		dma_cookie_complete(&desc->txd);
+		dma_descriptor_unmap(&desc->txd);
+		dmaengine_desc_get_callback_invoke(&desc->txd, &res);
+		desc->txd.callback = NULL;
+		desc->txd.callback_result = NULL;
+
+		plxdev->tail++;
+	}
+
+	spin_unlock_bh(&plxdev->ring_lock);
+}
+
+static void __plx_dma_stop(struct plx_dma_dev *plxdev)
+{
+	unsigned long timeout = jiffies + msecs_to_jiffies(1000);
+	u32 val;
+
+	val = readl(plxdev->bar + PLX_REG_CTRL);
+	if (!(val & ~PLX_REG_CTRL_GRACEFUL_PAUSE))
+		return;
+
+	writel(PLX_REG_CTRL_RESET_VAL | PLX_REG_CTRL_GRACEFUL_PAUSE,
+	       plxdev->bar + PLX_REG_CTRL);
+
+	while (!time_after(jiffies, timeout)) {
+		val = readl(plxdev->bar + PLX_REG_CTRL);
+		if (val & PLX_REG_CTRL_GRACEFUL_PAUSE_DONE)
+			break;
+
+		cpu_relax();
+	}
+
+	if (!(val & PLX_REG_CTRL_GRACEFUL_PAUSE_DONE))
+		dev_err(plxdev->dma_dev.dev,
+			"Timeout waiting for graceful pause!\n");
+
+	writel(PLX_REG_CTRL_RESET_VAL | PLX_REG_CTRL_GRACEFUL_PAUSE,
+	       plxdev->bar + PLX_REG_CTRL);
+
+	writel(0, plxdev->bar + PLX_REG_DESC_RING_COUNT);
+	writel(0, plxdev->bar + PLX_REG_DESC_RING_ADDR);
+	writel(0, plxdev->bar + PLX_REG_DESC_RING_ADDR_HI);
+	writel(0, plxdev->bar + PLX_REG_DESC_RING_NEXT_ADDR);
+}
+
+static void plx_dma_stop(struct plx_dma_dev *plxdev)
+{
+	rcu_read_lock();
+	if (!rcu_dereference(plxdev->pdev)) {
+		rcu_read_unlock();
+		return;
+	}
+
+	__plx_dma_stop(plxdev);
+
+	rcu_read_unlock();
+}
+
+static void plx_dma_desc_task(unsigned long data)
+{
+	struct plx_dma_dev *plxdev = (void *)data;
+
+	plx_dma_process_desc(plxdev);
+}
+
 static irqreturn_t plx_dma_isr(int irq, void *devid)
 {
+	struct plx_dma_dev *plxdev = devid;
+	u32 status;
+
+	status = readw(plxdev->bar + PLX_REG_INTR_STATUS);
+
+	if (!status)
+		return IRQ_NONE;
+
+	if (status & PLX_REG_INTR_STATUS_DESC_DONE && plxdev->ring_active)
+		tasklet_schedule(&plxdev->desc_task);
+
+	writew(status, plxdev->bar + PLX_REG_INTR_STATUS);
+
 	return IRQ_HANDLED;
 }
 
@@ -66,18 +291,109 @@ static void plx_dma_put(struct plx_dma_dev *plxdev)
 	kref_put(&plxdev->ref, plx_dma_release);
 }
 
+static int plx_dma_alloc_desc(struct plx_dma_dev *plxdev)
+{
+	struct plx_dma_desc *desc;
+	int i;
+
+	plxdev->desc_ring = kcalloc(PLX_DMA_RING_COUNT,
+				    sizeof(*plxdev->desc_ring), GFP_KERNEL);
+	if (!plxdev->desc_ring)
+		return -ENOMEM;
+
+	for (i = 0; i < PLX_DMA_RING_COUNT; i++) {
+		desc = kzalloc(sizeof(*desc), GFP_KERNEL);
+		if (!desc)
+			goto free_and_exit;
+
+		dma_async_tx_descriptor_init(&desc->txd, &plxdev->dma_chan);
+		desc->hw = &plxdev->hw_ring[i];
+		plxdev->desc_ring[i] = desc;
+	}
+
+	return 0;
+
+free_and_exit:
+	for (i = 0; i < PLX_DMA_RING_COUNT; i++)
+		kfree(plxdev->desc_ring[i]);
+	kfree(plxdev->desc_ring);
+	return -ENOMEM;
+}
+
 static int plx_dma_alloc_chan_resources(struct dma_chan *chan)
 {
 	struct plx_dma_dev *plxdev = chan_to_plx_dma_dev(chan);
+	size_t ring_sz = PLX_DMA_RING_COUNT * sizeof(*plxdev->hw_ring);
+	dma_addr_t dma_addr;
+	int rc;
+
+	rcu_read_lock();
+	if (!rcu_dereference(plxdev->pdev)) {
+		rcu_read_unlock();
+		return -ENODEV;
+	}
 
 	kref_get(&plxdev->ref);
 
-	return 0;
+	writel(PLX_REG_CTRL_RESET_VAL, plxdev->bar + PLX_REG_CTRL);
+
+	plxdev->hw_ring = dmam_alloc_coherent(plxdev->dma_dev.dev, ring_sz,
+					      &dma_addr, GFP_KERNEL);
+	if (!plxdev->hw_ring) {
+		rcu_read_unlock();
+		return -ENOMEM;
+	}
+
+	plxdev->head = plxdev->tail = 0;
+
+	rc = plx_dma_alloc_desc(plxdev);
+	if (rc) {
+		plx_dma_put(plxdev);
+		rcu_read_unlock();
+		return rc;
+	}
+
+	writel(lower_32_bits(dma_addr), plxdev->bar + PLX_REG_DESC_RING_ADDR);
+	writel(upper_32_bits(dma_addr),
+	       plxdev->bar + PLX_REG_DESC_RING_ADDR_HI);
+	writel(lower_32_bits(dma_addr),
+	       plxdev->bar + PLX_REG_DESC_RING_NEXT_ADDR);
+	writel(PLX_DMA_RING_COUNT, plxdev->bar + PLX_REG_DESC_RING_COUNT);
+	writel(PLX_REG_PREF_LIMIT_PREF_FOUR, plxdev->bar + PLX_REG_PREF_LIMIT);
+
+	plxdev->ring_active = true;
+
+	rcu_read_unlock();
+
+	return PLX_DMA_RING_COUNT;
 }
 
 static void plx_dma_free_chan_resources(struct dma_chan *chan)
 {
 	struct plx_dma_dev *plxdev = chan_to_plx_dma_dev(chan);
+	struct pci_dev *pdev;
+	int i;
+
+	spin_lock_bh(&plxdev->ring_lock);
+	plxdev->ring_active = false;
+	spin_unlock_bh(&plxdev->ring_lock);
+
+	plx_dma_stop(plxdev);
+
+	rcu_read_lock();
+	pdev = rcu_dereference(plxdev->pdev);
+	if (pdev)
+		synchronize_irq(pci_irq_vector(pdev, 0));
+	rcu_read_unlock();
+
+	tasklet_kill(&plxdev->desc_task);
+
+	plx_dma_abort_desc(plxdev);
+
+	for (i = 0; i < PLX_DMA_RING_COUNT; i++)
+		kfree(plxdev->desc_ring[i]);
+
+	kfree(plxdev->desc_ring);
 
 	plx_dma_put(plxdev);
 }
@@ -102,7 +418,11 @@ static int plx_dma_create(struct pci_dev *pdev)
 
 	kref_init(&plxdev->ref);
 	INIT_WORK(&plxdev->release_work, plx_dma_release_work);
+	spin_lock_init(&plxdev->ring_lock);
+	tasklet_init(&plxdev->desc_task, plx_dma_desc_task,
+		     (unsigned long)plxdev);
 
+	RCU_INIT_POINTER(plxdev->pdev, pdev);
 	plxdev->bar = pcim_iomap_table(pdev)[0];
 
 	dma = &plxdev->dma_dev;
@@ -181,6 +501,16 @@ static void plx_dma_remove(struct pci_dev *pdev)
 
 	free_irq(pci_irq_vector(pdev, 0),  plxdev);
 
+	rcu_assign_pointer(plxdev->pdev, NULL);
+	synchronize_rcu();
+
+	spin_lock_bh(&plxdev->ring_lock);
+	plxdev->ring_active = false;
+	spin_unlock_bh(&plxdev->ring_lock);
+
+	__plx_dma_stop(plxdev);
+	plx_dma_abort_desc(plxdev);
+
 	plxdev->bar = NULL;
 	plx_dma_put(plxdev);
 
-- 
2.20.1

