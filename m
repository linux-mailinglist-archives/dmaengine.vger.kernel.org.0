Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 753261351BA
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jan 2020 04:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbgAIDIz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 8 Jan 2020 22:08:55 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:39394 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726913AbgAIDIz (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 8 Jan 2020 22:08:55 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 01AC3890D606A404F2FF;
        Thu,  9 Jan 2020 11:08:52 +0800 (CST)
Received: from [127.0.0.1] (10.63.139.185) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Thu, 9 Jan 2020
 11:08:41 +0800
Subject: Re: [PATCH v4] dmaengine: hisilicon: Add Kunpeng DMA engine support
To:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
References: <1577932428-217801-1-git-send-email-wangzhou1@hisilicon.com>
CC:     <dmaengine@vger.kernel.org>, <linuxarm@huawei.com>,
        Zhenfa Qiu <qiuzhenfa@hisilicon.com>
From:   Zhou Wang <wangzhou1@hisilicon.com>
Message-ID: <5E169938.40600@hisilicon.com>
Date:   Thu, 9 Jan 2020 11:08:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <1577932428-217801-1-git-send-email-wangzhou1@hisilicon.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.63.139.185]
X-CFilter-Loop: Reflected
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2020/1/2 10:33, Zhou Wang wrote:
> This patch adds a driver for HiSilicon Kunpeng DMA engine. This DMA engine
> which is an PCIe iEP offers 30 channels, each channel has a send queue, a
> complete queue and an interrupt to help to do tasks. This DMA engine can do
> memory copy between memory blocks or between memory and device buffer.
> 
> Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
> Signed-off-by: Zhenfa Qiu <qiuzhenfa@hisilicon.com>
> ---
> 
> Changes v3 -> v4:
> - Add PCI_MSI compile dependency to avoid compile error.
> 
> Changes v2 -> v3:
> - Add basic description in commit message.
> - Add missing tasklet_kill and pci_free_irq_vectors.
> - Add BUG_ON when reset fails.
> - Add update_bit function to remove some common codes.
> - Misc fixes about coding style.
> 
>  drivers/dma/Kconfig    |   8 +
>  drivers/dma/Makefile   |   1 +
>  drivers/dma/hisi_dma.c | 599 +++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 608 insertions(+)
>  create mode 100644 drivers/dma/hisi_dma.c
> 
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index 6fa1eba..a8d9704 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -239,6 +239,14 @@ config FSL_RAID
>  	  the capability to offload memcpy, xor and pq computation
>  	  for raid5/6.
>  
> +config HISI_DMA
> +	tristate "HiSilicon DMA Engine support"
> +	depends on ARM64 || (COMPILE_TEST && PCI_MSI)
> +	select DMA_ENGINE
> +	select DMA_VIRTUAL_CHANNELS
> +	help
> +	  Support HiSilicon Kunpeng DMA engine.
> +
>  config IMG_MDC_DMA
>  	tristate "IMG MDC support"
>  	depends on MIPS || COMPILE_TEST
> diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
> index 42d7e2f..dc2f2a4 100644
> --- a/drivers/dma/Makefile
> +++ b/drivers/dma/Makefile
> @@ -35,6 +35,7 @@ obj-$(CONFIG_FSL_EDMA) += fsl-edma.o fsl-edma-common.o
>  obj-$(CONFIG_MCF_EDMA) += mcf-edma.o fsl-edma-common.o
>  obj-$(CONFIG_FSL_QDMA) += fsl-qdma.o
>  obj-$(CONFIG_FSL_RAID) += fsl_raid.o
> +obj-$(CONFIG_HISI_DMA) += hisi_dma.o
>  obj-$(CONFIG_HSU_DMA) += hsu/
>  obj-$(CONFIG_IMG_MDC_DMA) += img-mdc-dma.o
>  obj-$(CONFIG_IMX_DMA) += imx-dma.o
> diff --git a/drivers/dma/hisi_dma.c b/drivers/dma/hisi_dma.c
> new file mode 100644
> index 0000000..922ea9e
> --- /dev/null
> +++ b/drivers/dma/hisi_dma.c
> @@ -0,0 +1,599 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(c) 2019 HiSilicon Limited. */
> +#include <linux/bitfield.h>
> +#include <linux/dmaengine.h>
> +#include <linux/init.h>
> +#include <linux/iopoll.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/spinlock.h>
> +#include "virt-dma.h"
> +
> +#define HISI_DMA_SQ_BASE_L(i)		(0x0 + (i) * 0x100)
> +#define HISI_DMA_SQ_BASE_H(i)		(0x4 + (i) * 0x100)
> +#define HISI_DMA_SQ_DEPTH(i)		(0x8 + (i) * 0x100)
> +#define HISI_DMA_SQ_TAIL_PTR(i)		(0xc + (i) * 0x100)
> +#define HISI_DMA_CQ_BASE_L(i)		(0x10 + (i) * 0x100)
> +#define HISI_DMA_CQ_BASE_H(i)		(0x14 + (i) * 0x100)
> +#define HISI_DMA_CQ_DEPTH(i)		(0x18 + (i) * 0x100)
> +#define HISI_DMA_CQ_HEAD_PTR(i)		(0x1c + (i) * 0x100)
> +#define HISI_DMA_CTRL0(i)		(0x20 + (i) * 0x100)
> +#define HISI_DMA_CTRL0_QUEUE_EN_S	0
> +#define HISI_DMA_CTRL0_QUEUE_PAUSE_S	4
> +#define HISI_DMA_CTRL1(i)		(0x24 + (i) * 0x100)
> +#define HISI_DMA_CTRL1_QUEUE_RESET_S	0
> +#define HISI_DMA_Q_FSM_STS(i)		(0x30 + (i) * 0x100)
> +#define HISI_DMA_FSM_STS_MASK		GENMASK(3, 0)
> +#define HISI_DMA_INT_STS(i)		(0x40 + (i) * 0x100)
> +#define HISI_DMA_INT_STS_MASK		GENMASK(12, 0)
> +#define HISI_DMA_INT_MSK(i)		(0x44 + (i) * 0x100)
> +#define HISI_DMA_MODE			0x217c
> +
> +#define HISI_DMA_MSI_NUM		30
> +#define HISI_DMA_CHAN_NUM		30
> +#define HISI_DMA_Q_DEPTH_VAL		1024
> +
> +#define PCI_DEVICE_ID_HISI_DMA		0xa122
> +#define PCI_BAR_2			2
> +
> +enum hisi_dma_mode {
> +	EP = 0,
> +	RC,
> +};
> +
> +enum hisi_dma_chan_status {
> +	DISABLE = -1,
> +	IDLE = 0,
> +	RUN,
> +	CPL,
> +	PAUSE,
> +	HALT,
> +	ABORT,
> +	WAIT,
> +	BUFFCLR,
> +};
> +
> +struct hisi_dma_sqe {
> +	__le32 dw0;
> +#define OPCODE_MASK			GENMASK(3, 0)
> +#define OPCODE_SMALL_PACKAGE		0x1
> +#define OPCODE_M2M			0x4
> +#define LOCAL_IRQ_EN			BIT(8)
> +#define ATTR_SRC_MASK			GENMASK(14, 12)
> +	__le32 dw1;
> +	__le32 dw2;
> +#define ATTR_DST_MASK			GENMASK(26, 24)
> +	__le32 length;
> +	__le64 src_addr;
> +	__le64 dst_addr;
> +};
> +
> +struct hisi_dma_cqe {
> +	__le32 rsv0;
> +	__le32 rsv1;
> +	__le16 sq_head;
> +	__le16 rsv2;
> +	__le16 rsv3;
> +	__le16 w0;
> +#define STATUS_MASK			GENMASK(15, 1)
> +#define STATUS_SUCC			0x0
> +#define VALID_BIT			BIT(0)
> +};
> +
> +struct hisi_dma_desc {
> +	struct virt_dma_desc vd;
> +	struct hisi_dma_sqe sqe;
> +};
> +
> +struct hisi_dma_chan {
> +	struct virt_dma_chan vc;
> +	struct hisi_dma_dev *hdma_dev;
> +	struct hisi_dma_sqe *sq;
> +	struct hisi_dma_cqe *cq;
> +	dma_addr_t sq_dma;
> +	dma_addr_t cq_dma;
> +	u32 sq_tail;
> +	u32 cq_head;
> +	u32 qp_num;
> +	enum hisi_dma_chan_status status;
> +	struct hisi_dma_desc *desc;
> +};
> +
> +struct hisi_dma_dev {
> +	struct pci_dev *pdev;
> +	void __iomem *base;
> +	struct dma_device dma_dev;
> +	u32 chan_num;
> +	u32 chan_depth;
> +	struct hisi_dma_chan chan[];
> +};
> +
> +static inline struct hisi_dma_chan *to_hisi_dma_chan(struct dma_chan *c)
> +{
> +	return container_of(c, struct hisi_dma_chan, vc.chan);
> +}
> +
> +static inline struct hisi_dma_desc *to_hisi_dma_desc(struct virt_dma_desc *vd)
> +{
> +	return container_of(vd, struct hisi_dma_desc, vd);
> +}
> +
> +static inline void hisi_dma_update_bit(void __iomem *addr, u32 pos, bool val)
> +{
> +	u32 tmp;
> +
> +	tmp = readl_relaxed(addr);
> +	tmp = val ? tmp | BIT(pos) : tmp & ~BIT(pos);
> +	writel_relaxed(tmp, addr);
> +}
> +
> +static void hisi_dma_free_irq_vectors(void *data)
> +{
> +	pci_free_irq_vectors(data);
> +}
> +
> +static void hisi_dma_pause_dma(struct hisi_dma_dev *hdma_dev, u32 index,
> +			       bool pause)
> +{
> +	void __iomem *addr = hdma_dev->base + HISI_DMA_CTRL0(index);
> +
> +	hisi_dma_update_bit(addr, HISI_DMA_CTRL0_QUEUE_PAUSE_S, pause);
> +}
> +
> +static void hisi_dma_enable_dma(struct hisi_dma_dev *hdma_dev, u32 index,
> +				bool enable)
> +{
> +	void __iomem *addr = hdma_dev->base + HISI_DMA_CTRL0(index);
> +
> +	hisi_dma_update_bit(addr, HISI_DMA_CTRL0_QUEUE_EN_S, enable);
> +}
> +
> +static void hisi_dma_mask_irq(struct hisi_dma_dev *hdma_dev, u32 qp_index)
> +{
> +	writel_relaxed(HISI_DMA_INT_STS_MASK, hdma_dev->base +
> +		       HISI_DMA_INT_MSK(qp_index));
> +}
> +
> +static void hisi_dma_unmask_irq(struct hisi_dma_dev *hdma_dev, u32 qp_index)
> +{
> +	void __iomem *base = hdma_dev->base;
> +
> +	writel_relaxed(HISI_DMA_INT_STS_MASK, base +
> +		       HISI_DMA_INT_STS(qp_index));
> +	writel_relaxed(0, base + HISI_DMA_INT_MSK(qp_index));
> +}
> +
> +static void hisi_dma_do_reset(struct hisi_dma_dev *hdma_dev, u32 index)
> +{
> +	void __iomem *addr = hdma_dev->base + HISI_DMA_CTRL1(index);
> +
> +	hisi_dma_update_bit(addr, HISI_DMA_CTRL1_QUEUE_RESET_S, 1);
> +}
> +
> +static void hisi_dma_reset_qp_point(struct hisi_dma_dev *hdma_dev, u32 index)
> +{
> +	writel_relaxed(0, hdma_dev->base + HISI_DMA_SQ_TAIL_PTR(index));
> +	writel_relaxed(0, hdma_dev->base + HISI_DMA_CQ_HEAD_PTR(index));
> +}
> +
> +static void hisi_dma_reset_hw_chan(struct hisi_dma_chan *chan)
> +{
> +	struct hisi_dma_dev *hdma_dev = chan->hdma_dev;
> +	u32 index = chan->qp_num, tmp;
> +	int ret;
> +
> +	hisi_dma_pause_dma(hdma_dev, index, true);
> +	hisi_dma_enable_dma(hdma_dev, index, false);
> +	hisi_dma_mask_irq(hdma_dev, index);
> +
> +	ret = readl_relaxed_poll_timeout(hdma_dev->base +
> +		HISI_DMA_Q_FSM_STS(index), tmp,
> +		FIELD_GET(HISI_DMA_FSM_STS_MASK, tmp) != RUN, 10, 1000);
> +	if (ret) {
> +		dev_err(&hdma_dev->pdev->dev, "disable channel timeout!\n");
> +		BUG_ON(1);
> +	}
> +
> +	hisi_dma_do_reset(hdma_dev, index);
> +	hisi_dma_reset_qp_point(hdma_dev, index);
> +	hisi_dma_pause_dma(hdma_dev, index, false);
> +	hisi_dma_enable_dma(hdma_dev, index, true);
> +	hisi_dma_unmask_irq(hdma_dev, index);
> +
> +	ret = readl_relaxed_poll_timeout(hdma_dev->base +
> +		HISI_DMA_Q_FSM_STS(index), tmp,
> +		FIELD_GET(HISI_DMA_FSM_STS_MASK, tmp) == IDLE, 10, 1000);
> +	if (ret) {
> +		dev_err(&hdma_dev->pdev->dev, "reset channel timeout!\n");
> +		BUG_ON(1);
> +	}
> +}
> +
> +static void hisi_dma_free_chan_resources(struct dma_chan *c)
> +{
> +	struct hisi_dma_chan *chan = to_hisi_dma_chan(c);
> +	struct hisi_dma_dev *hdma_dev = chan->hdma_dev;
> +
> +	hisi_dma_reset_hw_chan(chan);
> +	vchan_free_chan_resources(&chan->vc);
> +
> +	memset(chan->sq, 0, sizeof(struct hisi_dma_sqe) * hdma_dev->chan_depth);
> +	memset(chan->cq, 0, sizeof(struct hisi_dma_cqe) * hdma_dev->chan_depth);
> +	chan->sq_tail = 0;
> +	chan->cq_head = 0;
> +	chan->status = DISABLE;
> +}
> +
> +static void hisi_dma_desc_free(struct virt_dma_desc *vd)
> +{
> +	kfree(to_hisi_dma_desc(vd));
> +}
> +
> +static struct dma_async_tx_descriptor *
> +hisi_dma_prep_dma_memcpy(struct dma_chan *c, dma_addr_t dst, dma_addr_t src,
> +			 size_t len, unsigned long flags)
> +{
> +	struct hisi_dma_chan *chan = to_hisi_dma_chan(c);
> +	struct hisi_dma_desc *desc;
> +
> +	desc = kzalloc(sizeof(*desc), GFP_NOWAIT);
> +	if (!desc)
> +		return NULL;
> +
> +	desc->sqe.length = cpu_to_le32(len);
> +	desc->sqe.src_addr = cpu_to_le64(src);
> +	desc->sqe.dst_addr = cpu_to_le64(dst);
> +
> +	return vchan_tx_prep(&chan->vc, &desc->vd, flags);
> +}
> +
> +static enum dma_status
> +hisi_dma_tx_status(struct dma_chan *c, dma_cookie_t cookie,
> +		   struct dma_tx_state *txstate)
> +{
> +	return dma_cookie_status(c, cookie, txstate);
> +}
> +
> +static void hisi_dma_start_transfer(struct hisi_dma_chan *chan)
> +{
> +	struct hisi_dma_sqe *sqe = chan->sq + chan->sq_tail;
> +	struct hisi_dma_dev *hdma_dev = chan->hdma_dev;
> +	struct hisi_dma_desc *desc;
> +	struct virt_dma_desc *vd;
> +
> +	vd = vchan_next_desc(&chan->vc);
> +	if (!vd) {
> +		dev_err(&hdma_dev->pdev->dev, "no issued task!\n");
> +		chan->desc = NULL;
> +		return;
> +	}
> +	list_del(&vd->node);
> +	desc = to_hisi_dma_desc(vd);
> +	chan->desc = desc;
> +
> +	memcpy(sqe, &desc->sqe, sizeof(struct hisi_dma_sqe));
> +
> +	/* update other field in sqe */
> +	sqe->dw0 = cpu_to_le32(FIELD_PREP(OPCODE_MASK, OPCODE_M2M));
> +	sqe->dw0 |= cpu_to_le32(LOCAL_IRQ_EN);
> +
> +	/* make sure data has been updated in sqe */
> +	wmb();
> +
> +	/* update sq tail, point to new sqe position */
> +	chan->sq_tail = (chan->sq_tail + 1) % hdma_dev->chan_depth;
> +
> +	/* update sq_tail to trigger a new task */
> +	writel_relaxed(chan->sq_tail, hdma_dev->base +
> +		       HISI_DMA_SQ_TAIL_PTR(chan->qp_num));
> +}
> +
> +static void hisi_dma_issue_pending(struct dma_chan *c)
> +{
> +	struct hisi_dma_chan *chan = to_hisi_dma_chan(c);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&chan->vc.lock, flags);
> +
> +	if (vchan_issue_pending(&chan->vc))
> +		hisi_dma_start_transfer(chan);
> +
> +	spin_unlock_irqrestore(&chan->vc.lock, flags);
> +}
> +
> +static int hisi_dma_terminate_all(struct dma_chan *c)
> +{
> +	struct hisi_dma_chan *chan = to_hisi_dma_chan(c);
> +	unsigned long flags;
> +	LIST_HEAD(head);
> +
> +	spin_lock_irqsave(&chan->vc.lock, flags);
> +
> +	hisi_dma_pause_dma(chan->hdma_dev, chan->qp_num, true);
> +	if (chan->desc) {
> +		vchan_terminate_vdesc(&chan->desc->vd);
> +		chan->desc = NULL;
> +	}
> +
> +	vchan_get_all_descriptors(&chan->vc, &head);
> +
> +	spin_unlock_irqrestore(&chan->vc.lock, flags);
> +
> +	vchan_dma_desc_free_list(&chan->vc, &head);
> +	hisi_dma_pause_dma(chan->hdma_dev, chan->qp_num, false);
> +
> +	return 0;
> +}
> +
> +static void hisi_dma_synchronize(struct dma_chan *c)
> +{
> +	struct hisi_dma_chan *chan = to_hisi_dma_chan(c);
> +
> +	vchan_synchronize(&chan->vc);
> +}
> +
> +static int hisi_dma_alloc_qps_mem(struct hisi_dma_dev *hdma_dev)
> +{
> +	size_t sq_size = sizeof(struct hisi_dma_sqe) * hdma_dev->chan_depth;
> +	size_t cq_size = sizeof(struct hisi_dma_cqe) * hdma_dev->chan_depth;
> +	struct device *dev = &hdma_dev->pdev->dev;
> +	struct hisi_dma_chan *chan;
> +	int i;
> +
> +	for (i = 0; i < hdma_dev->chan_num; i++) {
> +		chan = &hdma_dev->chan[i];
> +		chan->sq = dmam_alloc_coherent(dev, sq_size, &chan->sq_dma,
> +					       GFP_KERNEL);
> +		if (!chan->sq)
> +			return -ENOMEM;
> +
> +		chan->cq = dmam_alloc_coherent(dev, cq_size, &chan->cq_dma,
> +					       GFP_KERNEL);
> +		if (!chan->cq)
> +			return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +
> +static void hisi_dma_init_hw_qp(struct hisi_dma_dev *hdma_dev, u32 index)
> +{
> +	struct hisi_dma_chan *chan = &hdma_dev->chan[index];
> +	u32 hw_depth = hdma_dev->chan_depth - 1;
> +	void __iomem *base = hdma_dev->base;
> +
> +	/* set sq, cq base */
> +	writel_relaxed(lower_32_bits(chan->sq_dma),
> +		       base + HISI_DMA_SQ_BASE_L(index));
> +	writel_relaxed(upper_32_bits(chan->sq_dma),
> +		       base + HISI_DMA_SQ_BASE_H(index));
> +	writel_relaxed(lower_32_bits(chan->cq_dma),
> +		       base + HISI_DMA_CQ_BASE_L(index));
> +	writel_relaxed(upper_32_bits(chan->cq_dma),
> +		       base + HISI_DMA_CQ_BASE_H(index));
> +	/* set sq, cq depth */
> +	writel_relaxed(hw_depth, base + HISI_DMA_SQ_DEPTH(index));
> +	writel_relaxed(hw_depth, base + HISI_DMA_CQ_DEPTH(index));
> +	/* init sq tail and cq head */
> +	writel_relaxed(0, base + HISI_DMA_SQ_TAIL_PTR(index));
> +	writel_relaxed(0, base + HISI_DMA_CQ_HEAD_PTR(index));
> +}
> +
> +static void hisi_dma_enable_qp(struct hisi_dma_dev *hdma_dev, u32 qp_index)
> +{
> +	hisi_dma_init_hw_qp(hdma_dev, qp_index);
> +	hisi_dma_unmask_irq(hdma_dev, qp_index);
> +	hisi_dma_enable_dma(hdma_dev, qp_index, true);
> +}
> +
> +static void hisi_dma_disable_qp(struct hisi_dma_dev *hdma_dev, u32 qp_index)
> +{
> +	hisi_dma_reset_hw_chan(&hdma_dev->chan[qp_index]);
> +}
> +
> +static void hisi_dma_enable_qps(struct hisi_dma_dev *hdma_dev)
> +{
> +	int i;
> +
> +	for (i = 0; i < hdma_dev->chan_num; i++) {
> +		hdma_dev->chan[i].qp_num = i;
> +		hdma_dev->chan[i].hdma_dev = hdma_dev;
> +		hdma_dev->chan[i].vc.desc_free = hisi_dma_desc_free;
> +		vchan_init(&hdma_dev->chan[i].vc, &hdma_dev->dma_dev);
> +		hisi_dma_enable_qp(hdma_dev, i);
> +	}
> +}
> +
> +static void hisi_dma_disable_qps(struct hisi_dma_dev *hdma_dev)
> +{
> +	int i;
> +
> +	for (i = 0; i < hdma_dev->chan_num; i++) {
> +		hisi_dma_disable_qp(hdma_dev, i);
> +		tasklet_kill(&hdma_dev->chan[i].vc.task);
> +	}
> +}
> +
> +static irqreturn_t hisi_dma_irq(int irq, void *data)
> +{
> +	struct hisi_dma_chan *chan = data;
> +	struct hisi_dma_dev *hdma_dev = chan->hdma_dev;
> +	struct hisi_dma_desc *desc;
> +	struct hisi_dma_cqe *cqe;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&chan->vc.lock, flags);
> +
> +	desc = chan->desc;
> +	cqe = chan->cq + chan->cq_head;
> +	if (desc) {
> +		if (FIELD_GET(STATUS_MASK, cqe->w0) == STATUS_SUCC) {
> +			chan->cq_head = (chan->cq_head + 1) %
> +					hdma_dev->chan_depth;
> +			writel_relaxed(chan->cq_head, hdma_dev->base +
> +				       HISI_DMA_CQ_HEAD_PTR(chan->qp_num));
> +			vchan_cookie_complete(&desc->vd);
> +		} else {
> +			dev_err(&hdma_dev->pdev->dev, "task error!\n");
> +		}
> +
> +		chan->desc = NULL;
> +	}
> +
> +	spin_unlock_irqrestore(&chan->vc.lock, flags);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int hisi_dma_request_qps_irq(struct hisi_dma_dev *hdma_dev)
> +{
> +	struct pci_dev *pdev = hdma_dev->pdev;
> +	int i, ret;
> +
> +	for (i = 0; i < hdma_dev->chan_num; i++) {
> +		ret = devm_request_irq(&pdev->dev, pci_irq_vector(pdev, i),
> +				       hisi_dma_irq, IRQF_SHARED, "hisi_dma",
> +				       &hdma_dev->chan[i]);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +/* This function enables all hw channels in a device */
> +static int hisi_dma_enable_hw_channels(struct hisi_dma_dev *hdma_dev)
> +{
> +	int ret;
> +
> +	ret = hisi_dma_alloc_qps_mem(hdma_dev);
> +	if (ret) {
> +		dev_err(&hdma_dev->pdev->dev, "fail to allocate qp memory!\n");
> +		return ret;
> +	}
> +
> +	ret = hisi_dma_request_qps_irq(hdma_dev);
> +	if (ret) {
> +		dev_err(&hdma_dev->pdev->dev, "fail to request qp irq!\n");
> +		return ret;
> +	}
> +
> +	hisi_dma_enable_qps(hdma_dev);
> +
> +	return 0;
> +}
> +
> +static void hisi_dma_disable_hw_channels(void *data)
> +{
> +	hisi_dma_disable_qps(data);
> +}
> +
> +static void hisi_dma_set_mode(struct hisi_dma_dev *hdma_dev,
> +			      enum hisi_dma_mode mode)
> +{
> +	writel_relaxed(mode == RC ? 1 : 0, hdma_dev->base + HISI_DMA_MODE);
> +}
> +
> +static int hisi_dma_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct hisi_dma_dev *hdma_dev;
> +	struct dma_device *dma_dev;
> +	size_t dev_size;
> +	int ret;
> +
> +	ret = pcim_enable_device(pdev);
> +	if (ret) {
> +		dev_err(dev, "failed to enable device mem!\n");
> +		return ret;
> +	}
> +
> +	ret = pcim_iomap_regions(pdev, 1 << PCI_BAR_2, pci_name(pdev));
> +	if (ret) {
> +		dev_err(dev, "failed to remap I/O region!\n");
> +		return ret;
> +	}
> +
> +	ret = pci_set_dma_mask(pdev, DMA_BIT_MASK(64));
> +	if (ret)
> +		return ret;
> +
> +	ret = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64));
> +	if (ret)
> +		return ret;
> +
> +	dev_size = sizeof(struct hisi_dma_chan) * HISI_DMA_CHAN_NUM +
> +		   sizeof(*hdma_dev);
> +	hdma_dev = devm_kzalloc(dev, dev_size, GFP_KERNEL);
> +	if (!hdma_dev)
> +		return -EINVAL;
> +
> +	hdma_dev->base = pcim_iomap_table(pdev)[PCI_BAR_2];
> +	hdma_dev->pdev = pdev;
> +	hdma_dev->chan_num = HISI_DMA_CHAN_NUM;
> +	hdma_dev->chan_depth = HISI_DMA_Q_DEPTH_VAL;
> +
> +	pci_set_drvdata(pdev, hdma_dev);
> +	pci_set_master(pdev);
> +
> +	ret = pci_alloc_irq_vectors(pdev, HISI_DMA_MSI_NUM, HISI_DMA_MSI_NUM,
> +				    PCI_IRQ_MSI);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to allocate MSI vectors!\n");
> +		return ret;
> +	}
> +
> +	ret = devm_add_action_or_reset(dev, hisi_dma_free_irq_vectors, pdev);
> +	if (ret)
> +		return ret;
> +
> +	dma_dev = &hdma_dev->dma_dev;
> +	dma_cap_set(DMA_MEMCPY, dma_dev->cap_mask);
> +	dma_dev->device_free_chan_resources = hisi_dma_free_chan_resources;
> +	dma_dev->device_prep_dma_memcpy = hisi_dma_prep_dma_memcpy;
> +	dma_dev->device_tx_status = hisi_dma_tx_status;
> +	dma_dev->device_issue_pending = hisi_dma_issue_pending;
> +	dma_dev->device_terminate_all = hisi_dma_terminate_all;
> +	dma_dev->device_synchronize = hisi_dma_synchronize;
> +	dma_dev->directions = BIT(DMA_MEM_TO_MEM);
> +	dma_dev->dev = dev;
> +	INIT_LIST_HEAD(&dma_dev->channels);
> +
> +	hisi_dma_set_mode(hdma_dev, RC);
> +
> +	ret = hisi_dma_enable_hw_channels(hdma_dev);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to enable hw channel!\n");
> +		return ret;
> +	}
> +
> +	ret = devm_add_action_or_reset(dev, hisi_dma_disable_hw_channels,
> +				       hdma_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = dmaenginem_async_device_register(dma_dev);
> +	if (ret < 0)
> +		dev_err(dev, "failed to register device!\n");
> +
> +	return ret;
> +}
> +
> +static const struct pci_device_id hisi_dma_pci_tbl[] = {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_HUAWEI, PCI_DEVICE_ID_HISI_DMA) },
> +	{ 0, }
> +};
> +
> +static struct pci_driver hisi_dma_pci_driver = {
> +	.name		= "hisi_dma",
> +	.id_table	= hisi_dma_pci_tbl,
> +	.probe		= hisi_dma_probe,
> +};
> +
> +module_pci_driver(hisi_dma_pci_driver);
> +
> +MODULE_AUTHOR("Zhou Wang <wangzhou1@hisilicon.com>");
> +MODULE_AUTHOR("Zhenfa Qiu <qiuzhenfa@hisilicon.com>");
> +MODULE_DESCRIPTION("HiSilicon Kunpeng DMA controller driver");
> +MODULE_LICENSE("GPL v2");
> +MODULE_DEVICE_TABLE(pci, hisi_dma_pci_tbl);
> 

Any comments for this driver? Looking forward to being applied in this loop :)

Thanks,
Zhou


