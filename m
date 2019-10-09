Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA452D0E76
	for <lists+dmaengine@lfdr.de>; Wed,  9 Oct 2019 14:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729686AbfJIMPC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 9 Oct 2019 08:15:02 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:49810 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727219AbfJIMPC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 9 Oct 2019 08:15:02 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x99CEs2O157804;
        Wed, 9 Oct 2019 12:14:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=PXd60YKs7kAG4XA6izzvMmQTYWhGLjm33STurm9s11M=;
 b=R/zIQBKe0XhqGnLTrmbAO3cSQbI6ACL4VbXSze9qJ1szRP0hNjb9DD6mA72qWI8ZphPT
 wFoZ0gpv38LZb75O+u9zMv29Kc6ZV4K2KeQxvG437KOWjV6Zx09uSp30MeXeC3vooD/2
 lEqmnr9tOVrUBZrdyyKnVPdNsHCSqVst44zn4v/aVeiyi8Qnl1NuERv0BHXWARL6s7nO
 dd0KnfK1mJ3G5EZ9h8iIMoJv9i7Vs9BLgHTEU6kvc9ePf2GFykyFm+6LqJZyJHrOqUZT
 WmA6Pe1CW9GX5FvSiG6eG1LzB93HkBAd+eB2Fhw10OiTh6BYYP1ng/5ZhdimD2A59KjN mQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2vejkukv9b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Oct 2019 12:14:54 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x99C80PZ173095;
        Wed, 9 Oct 2019 12:14:53 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2vh5caf999-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Oct 2019 12:14:52 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x99CEof8022158;
        Wed, 9 Oct 2019 12:14:51 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 09 Oct 2019 05:14:49 -0700
Date:   Wed, 9 Oct 2019 15:14:41 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Alexander Gordeev <a.gordeev.box@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        Michael Chen <micchen@altera.com>, dmaengine@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dmaengine: avalon: Intel Avalon-MM DMA Interface
 for PCIe
Message-ID: <20191009121441.GM25098@kadam>
References: <cover.1570558807.git.a.gordeev.box@gmail.com>
 <3ed3c016b7fbe69e36023e7ee09c53acac8a064c.1570558807.git.a.gordeev.box@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ed3c016b7fbe69e36023e7ee09c53acac8a064c.1570558807.git.a.gordeev.box@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9404 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910090115
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9404 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910090116
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Oct 09, 2019 at 12:12:30PM +0200, Alexander Gordeev wrote:
> Support Avalon-MM DMA Interface for PCIe used in hard IPs for
> Intel Arria, Cyclone or Stratix FPGAs.
> 
> CC: Michael Chen <micchen@altera.com>
> CC: devel@driverdev.osuosl.org
> CC: dmaengine@vger.kernel.org
> 
> Signed-off-by: Alexander Gordeev <a.gordeev.box@gmail.com>
> ---
>  drivers/dma/Kconfig              |   2 +
>  drivers/dma/Makefile             |   1 +
>  drivers/dma/avalon/Kconfig       |  88 +++++++
>  drivers/dma/avalon/Makefile      |   6 +
>  drivers/dma/avalon/avalon-core.c | 432 +++++++++++++++++++++++++++++++
>  drivers/dma/avalon/avalon-core.h |  90 +++++++
>  drivers/dma/avalon/avalon-hw.c   | 212 +++++++++++++++
>  drivers/dma/avalon/avalon-hw.h   |  86 ++++++
>  drivers/dma/avalon/avalon-pci.c  | 150 +++++++++++
>  9 files changed, 1067 insertions(+)
>  create mode 100644 drivers/dma/avalon/Kconfig
>  create mode 100644 drivers/dma/avalon/Makefile
>  create mode 100644 drivers/dma/avalon/avalon-core.c
>  create mode 100644 drivers/dma/avalon/avalon-core.h
>  create mode 100644 drivers/dma/avalon/avalon-hw.c
>  create mode 100644 drivers/dma/avalon/avalon-hw.h
>  create mode 100644 drivers/dma/avalon/avalon-pci.c
> 
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index 7af874b69ffb..f6f43480a4a4 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -669,6 +669,8 @@ source "drivers/dma/sh/Kconfig"
>  
>  source "drivers/dma/ti/Kconfig"
>  
> +source "drivers/dma/avalon/Kconfig"
> +
>  # clients
>  comment "DMA Clients"
>  	depends on DMA_ENGINE
> diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
> index f5ce8665e944..fd7e11417b73 100644
> --- a/drivers/dma/Makefile
> +++ b/drivers/dma/Makefile
> @@ -75,6 +75,7 @@ obj-$(CONFIG_UNIPHIER_MDMAC) += uniphier-mdmac.o
>  obj-$(CONFIG_XGENE_DMA) += xgene-dma.o
>  obj-$(CONFIG_ZX_DMA) += zx_dma.o
>  obj-$(CONFIG_ST_FDMA) += st_fdma.o
> +obj-$(CONFIG_AVALON_DMA) += avalon/
>  
>  obj-y += mediatek/
>  obj-y += qcom/
> diff --git a/drivers/dma/avalon/Kconfig b/drivers/dma/avalon/Kconfig
> new file mode 100644
> index 000000000000..09e0773fcdb2
> --- /dev/null
> +++ b/drivers/dma/avalon/Kconfig
> @@ -0,0 +1,88 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Avalon DMA engine
> +#
> +# Author: Alexander Gordeev <a.gordeev.box@gmail.com>
> +#
> +config AVALON_DMA
> +	tristate "Intel Avalon-MM DMA Interface for PCIe"
> +	depends on PCI
> +	select DMA_ENGINE
> +	select DMA_VIRTUAL_CHANNELS
> +	help
> +	  This selects a driver for Avalon-MM DMA Interface for PCIe
> +	  hard IP block used in Intel Arria, Cyclone or Stratix FPGAs.
> +
> +if AVALON_DMA
> +
> +config AVALON_DMA_MASK_WIDTH
> +	int "Avalon DMA streaming and coherent bitmask width"
> +	range 0 64
> +	default 64
> +	help
> +	  Width of bitmask for streaming and coherent DMA operations
> +
> +config AVALON_DMA_CTRL_BASE
> +	hex "Avalon DMA controllers base"
> +	default "0x00000000"
> +
> +config AVALON_DMA_RD_EP_DST_LO
> +	hex "Avalon DMA read controller base low"
> +	default "0x80000000"
> +	help
> +	  Specifies the lower 32-bits of the base address of the read
> +	  status and descriptor table in the Root Complex memory.
> +
> +config AVALON_DMA_RD_EP_DST_HI
> +	hex "Avalon DMA read controller base high"
> +	default "0x00000000"
> +	help
> +	  Specifies the upper 32-bits of the base address of the read
> +	  status and descriptor table in the Root Complex memory.
> +
> +config AVALON_DMA_WR_EP_DST_LO
> +	hex "Avalon DMA write controller base low"
> +	default "0x80002000"
> +	help
> +	  Specifies the lower 32-bits of the base address of the write
> +	  status and descriptor table in the Root Complex memory.
> +
> +config AVALON_DMA_WR_EP_DST_HI
> +	hex "Avalon DMA write controller base high"
> +	default "0x00000000"
> +	help
> +	  Specifies the upper 32-bits of the base address of the write
> +	  status and descriptor table in the Root Complex memory.
> +
> +config AVALON_DMA_PCI_VENDOR_ID
> +	hex "PCI vendor ID"
> +	default "0x1172"
> +
> +config AVALON_DMA_PCI_DEVICE_ID
> +	hex "PCI device ID"
> +	default "0xe003"

This feels wrong.  Why isn't it known in advance.

> +
> +config AVALON_DMA_PCI_BAR
> +	int "PCI device BAR the Avalon DMA controller is mapped to"
> +	range 0 5
> +	default 0
> +	help
> +	  Number of PCI BAR the DMA controller is mapped to
> +
> +config AVALON_DMA_PCI_MSI_COUNT_ORDER
> +	int "Count of MSIs the PCI device provides (order)"
> +	range 0 5
> +	default 5
> +	help
> +	  Number of vectors the PCI device uses in multiple MSI mode.
> +	  This number is provided as the power of two.
> +
> +config AVALON_DMA_PCI_MSI_VECTOR
> +	int "Vector number the DMA controller is mapped to"
> +	range 0 31
> +	default 0
> +	help
> +	  Number of MSI vector the DMA controller is mapped to in
> +	  multiple MSI mode.
> +
> +endif
> diff --git a/drivers/dma/avalon/Makefile b/drivers/dma/avalon/Makefile
> new file mode 100644
> index 000000000000..4b5278d12f86
> --- /dev/null
> +++ b/drivers/dma/avalon/Makefile
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0
> +obj-$(CONFIG_AVALON_DMA)	+= avalon-dma.o
> +
> +avalon-dma-objs			:= avalon-hw.o \
> +				   avalon-core.o \
> +				   avalon-pci.o
> diff --git a/drivers/dma/avalon/avalon-core.c b/drivers/dma/avalon/avalon-core.c
> new file mode 100644
> index 000000000000..c8357596b58f
> --- /dev/null
> +++ b/drivers/dma/avalon/avalon-core.c
> @@ -0,0 +1,432 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Avalon DMA engine
> + *
> + * Author: Alexander Gordeev <a.gordeev.box@gmail.com>
> + */
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/delay.h>
> +#include <linux/dma-mapping.h>
> +
> +#include "avalon-hw.h"
> +#include "avalon-core.h"
> +
> +#define INTERRUPT_NAME		"avalon_dma"
> +#define DMA_MASK_WIDTH		CONFIG_AVALON_DMA_MASK_WIDTH
> +
> +static int setup_dma_descs(struct dma_desc *dma_descs,
> +			   struct avalon_dma_desc *desc)
> +{
> +	struct scatterlist *sg_stop;
> +	unsigned int sg_set;
> +	int ret;
> +
> +	ret = setup_descs_sg(dma_descs, 0,
> +			     desc->direction,
> +			     desc->dev_addr,
> +			     desc->sg, desc->sg_len,
> +			     desc->sg_curr, desc->sg_offset,
> +			     &sg_stop, &sg_set);
> +	BUG_ON(!ret);
> +	if (ret > 0) {
> +		if (sg_stop == desc->sg_curr) {
> +			desc->sg_offset += sg_set;
> +		} else {
> +			desc->sg_curr = sg_stop;
> +			desc->sg_offset = sg_set;
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static int start_dma_xfer(struct avalon_dma_hw *hw,
> +			  struct avalon_dma_desc *desc)
> +{
> +	size_t ctrl_off;
> +	struct __dma_desc_table *__table;
> +	struct dma_desc_table *table;
> +	u32 rc_src_hi, rc_src_lo;
> +	u32 ep_dst_lo, ep_dst_hi;
> +	int last_id, *__last_id;
> +	int nr_descs;
> +
> +	if (desc->direction == DMA_TO_DEVICE) {
> +		__table = &hw->dma_desc_table_rd;
> +
> +		ctrl_off = AVALON_DMA_RD_CTRL_OFFSET;
> +
> +		ep_dst_hi = AVALON_DMA_RD_EP_DST_HI;
> +		ep_dst_lo = AVALON_DMA_RD_EP_DST_LO;
> +
> +		__last_id = &hw->h2d_last_id;
> +	} else if (desc->direction == DMA_FROM_DEVICE) {
> +		__table = &hw->dma_desc_table_wr;
> +
> +		ctrl_off = AVALON_DMA_WR_CTRL_OFFSET;
> +
> +		ep_dst_hi = AVALON_DMA_WR_EP_DST_HI;
> +		ep_dst_lo = AVALON_DMA_WR_EP_DST_LO;
> +
> +		__last_id = &hw->d2h_last_id;
> +	} else {
> +		BUG();
> +	}
> +
> +	table = __table->cpu_addr;
> +	memset(&table->flags, 0, sizeof(table->flags));
> +
> +	nr_descs = setup_dma_descs(table->descs, desc);
> +	if (WARN_ON(nr_descs < 1))
> +		return nr_descs;
> +
> +	last_id = nr_descs - 1;
> +	*__last_id = last_id;
> +
> +	rc_src_hi = __table->dma_addr >> 32;
> +	rc_src_lo = (u32)__table->dma_addr;
> +
> +	start_xfer(hw->regs, ctrl_off,
> +		   rc_src_hi, rc_src_lo,
> +		   ep_dst_hi, ep_dst_lo,
> +		   last_id);
> +
> +	return 0;
> +}
> +
> +static bool is_desc_complete(struct avalon_dma_desc *desc)
> +{
> +	struct scatterlist *sg_curr = desc->sg_curr;
> +	unsigned int sg_len = sg_dma_len(sg_curr);
> +
> +	if (!sg_is_last(sg_curr))
> +		return false;
> +
> +	BUG_ON(desc->sg_offset > sg_len);
> +	if (desc->sg_offset < sg_len)
> +		return false;
> +
> +	return true;
> +}
> +
> +static irqreturn_t avalon_dma_interrupt(int irq, void *dev_id)
> +{
> +	struct avalon_dma *adma = (struct avalon_dma *)dev_id;
> +	struct avalon_dma_chan *chan = &adma->chan;
> +	struct avalon_dma_hw *hw = &chan->hw;
> +	spinlock_t *lock = &chan->vchan.lock;

Just use "&chan->vchan.lock" directly.

> +	u32 *rd_flags = hw->dma_desc_table_rd.cpu_addr->flags;
> +	u32 *wr_flags = hw->dma_desc_table_wr.cpu_addr->flags;
> +	struct avalon_dma_desc *desc;
> +	struct virt_dma_desc *vdesc;
> +	bool rd_done;
> +	bool wr_done;
> +
> +	spin_lock(lock);
> +
> +	rd_done = (hw->h2d_last_id < 0);
> +	wr_done = (hw->d2h_last_id < 0);
> +
> +	if (rd_done && wr_done) {
> +		spin_unlock(lock);
> +		return IRQ_NONE;
> +	}
> +
> +	do {
> +		if (!rd_done && rd_flags[hw->h2d_last_id])
> +			rd_done = true;
> +
> +		if (!wr_done && wr_flags[hw->d2h_last_id])
> +			wr_done = true;
> +	} while (!rd_done || !wr_done);

This loop is very strange.  It feels like the last_id indexes needs
to atomic or protected from racing somehow so we don't do an out of
bounds read.

> +
> +	hw->h2d_last_id = -1;
> +	hw->d2h_last_id = -1;
> +
> +	BUG_ON(!chan->active_desc);
> +	desc = chan->active_desc;
> +
> +	if (is_desc_complete(desc)) {
> +		list_del(&desc->vdesc.node);
> +		vchan_cookie_complete(&desc->vdesc);
> +
> +		desc->direction = DMA_NONE;
> +
> +		vdesc = vchan_next_desc(&chan->vchan);
> +		if (vdesc) {
> +			desc = to_avalon_dma_desc(vdesc);
> +			chan->active_desc = desc;
> +		} else {
> +			chan->active_desc = NULL;
> +		}
> +	}
> +
> +	if (chan->active_desc) {
> +		BUG_ON(desc != chan->active_desc);
> +		start_dma_xfer(hw, desc);
> +	}
> +
> +	spin_unlock(lock);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int avalon_dma_terminate_all(struct dma_chan *dma_chan)
> +{
> +	struct virt_dma_chan *vchan = to_virt_chan(dma_chan);
> +
> +	vchan_free_chan_resources(vchan);
> +
> +	return 0;
> +}
> +
> +static void avalon_dma_synchronize(struct dma_chan *dma_chan)
> +{
> +	struct virt_dma_chan *vchan = to_virt_chan(dma_chan);
> +
> +	vchan_synchronize(vchan);
> +}
> +
> +static int avalon_dma_init(struct avalon_dma *adma,
> +			   struct device *dev,
> +			   void __iomem *regs,
> +			   unsigned int irq)
> +{
> +	struct avalon_dma_chan *chan = &adma->chan;
> +	struct avalon_dma_hw *hw = &chan->hw;
> +	int ret;
> +
> +	adma->dev		= dev;
> +	adma->irq		= irq;
> +
> +	chan->active_desc	= NULL;
> +
> +	hw->regs		= regs;
> +	hw->h2d_last_id		= -1;
> +	hw->d2h_last_id		= -1;
> +
> +	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(DMA_MASK_WIDTH));
> +	if (ret)
> +		goto dma_set_mask_err;
> +
> +	hw->dma_desc_table_rd.cpu_addr = dma_alloc_coherent(
> +		dev,
> +		sizeof(struct dma_desc_table),
> +		&hw->dma_desc_table_rd.dma_addr,
> +		GFP_KERNEL);
> +	if (!hw->dma_desc_table_rd.cpu_addr) {
> +		ret = -ENOMEM;
> +		goto alloc_rd_dma_table_err;
> +	}
> +
> +	hw->dma_desc_table_wr.cpu_addr = dma_alloc_coherent(
> +		dev,
> +		sizeof(struct dma_desc_table),
> +		&hw->dma_desc_table_wr.dma_addr,
> +		GFP_KERNEL);
> +	if (!hw->dma_desc_table_wr.cpu_addr) {
> +		ret = -ENOMEM;
> +		goto alloc_wr_dma_table_err;
> +	}
> +
> +	ret = request_irq(irq, avalon_dma_interrupt, IRQF_SHARED,
> +			  INTERRUPT_NAME, adma);
> +	if (ret)
> +		goto req_irq_err;
> +
> +	return 0;
> +
> +req_irq_err:
> +	dma_free_coherent(
> +		dev,
> +		sizeof(struct dma_desc_table),
> +		hw->dma_desc_table_wr.cpu_addr,
> +		hw->dma_desc_table_wr.dma_addr);
> +
> +alloc_wr_dma_table_err:
> +	dma_free_coherent(
> +		dev,
> +		sizeof(struct dma_desc_table),
> +		hw->dmadesc_table_rd.cpu_addr,
> +		hw->dma_desc_table_rd.dma_addr);
> +
> +alloc_rd_dma_table_err:
> +dma_set_mask_err:
> +	return ret;
> +}
> +
> +static void avalon_dma_term(struct avalon_dma *adma)
> +{
> +	struct avalon_dma_chan *chan = &adma->chan;
> +	struct avalon_dma_hw *hw = &chan->hw;
> +	struct device *dev = adma->dev;
> +
> +	free_irq(adma->irq, (void *)adma);

No need for this cast.

> +
> +	dma_free_coherent(
> +		dev,
> +		sizeof(struct dma_desc_table),
> +		hw->dma_desc_table_rd.cpu_addr,
> +		hw->dma_desc_table_rd.dma_addr);
> +
> +	dma_free_coherent(
> +		dev,
> +		sizeof(struct dma_desc_table),
> +		hw->dma_desc_table_wr.cpu_addr,
> +		hw->dma_desc_table_wr.dma_addr);
> +}
> +
> +static int avalon_dma_device_config(struct dma_chan *dma_chan,
> +				    struct dma_slave_config *config)
> +{
> +	struct avalon_dma_chan *chan = to_avalon_dma_chan(dma_chan);
> +
> +	chan->src_addr = config->src_addr;
> +	chan->dst_addr = config->dst_addr;
> +
> +	return 0;
> +}
> +
> +static struct dma_async_tx_descriptor *
> +avalon_dma_prep_slave_sg(struct dma_chan *dma_chan,
> +			 struct scatterlist *sg, unsigned int sg_len,
> +			 enum dma_transfer_direction direction,
> +			 unsigned long flags, void *context)
> +{
> +	struct avalon_dma_chan *chan = to_avalon_dma_chan(dma_chan);
> +	struct avalon_dma_desc *desc;
> +	gfp_t gfp_flags = in_interrupt() ? GFP_NOWAIT : GFP_KERNEL;
> +	dma_addr_t dev_addr;
> +
> +	if (direction == DMA_MEM_TO_DEV)
> +		dev_addr = chan->dst_addr;
> +	else if (direction == DMA_DEV_TO_MEM)
> +		dev_addr = chan->src_addr;
> +	else
> +		return NULL;
> +
> +	desc = kzalloc(sizeof(*desc), gfp_flags);

Everyone else does GFP_WAIT or GFP_ATOMIC.  Is GFP_KERNEL really okay?


> +	if (!desc)
> +		return NULL;
> +
> +	desc->direction = direction;
> +	desc->dev_addr	= dev_addr;
> +	desc->sg	= sg;
> +	desc->sg_len	= sg_len;
> +	desc->sg_curr	= sg;
> +	desc->sg_offset	= 0;
> +
> +	return vchan_tx_prep(&chan->vchan, &desc->vdesc, flags);
> +}
> +
> +static void avalon_dma_issue_pending(struct dma_chan *dma_chan)
> +{
> +	struct avalon_dma_chan *chan = to_avalon_dma_chan(dma_chan);
> +	struct avalon_dma_hw *hw = &chan->hw;
> +	spinlock_t *lock = &chan->vchan.lock;

Just use the "&chan->vchan.lock".

> +	struct avalon_dma_desc *desc;
> +	struct virt_dma_desc *vdesc;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(lock, flags);
> +
> +	if (!vchan_issue_pending(&chan->vchan))
> +		goto out;
> +
> +	/*
> +	 * Do nothing if a DMA transmission is currently active.
> +	 * BOTH read and write status must be checked here!
> +	 */
> +	if (hw->d2h_last_id < 0 && hw->h2d_last_id < 0) {
> +		BUG_ON(chan->active_desc);
> +
> +		vdesc = vchan_next_desc(&chan->vchan);
> +		BUG_ON(!vdesc);
> +		desc = to_avalon_dma_desc(vdesc);
> +
> +		if (start_dma_xfer(hw, desc))
> +			goto out;
> +
> +		chan->active_desc = desc;
> +	} else {
> +		BUG_ON(!chan->active_desc);
> +	}
> +
> +out:
> +	spin_unlock_irqrestore(lock, flags);
> +}
> +
> +static void avalon_dma_desc_free(struct virt_dma_desc *vdesc)
> +{
> +	struct avalon_dma_desc *desc = to_avalon_dma_desc(vdesc);
> +
> +	kfree(desc);
> +}
> +
> +struct avalon_dma *avalon_dma_register(struct device *dev,
> +				       void __iomem *regs,
> +				       unsigned int irq)
> +{
> +	struct avalon_dma *adma;
> +	struct avalon_dma_chan *chan;
> +	struct dma_device *dma_dev;
> +	int ret;
> +
> +	adma = kzalloc(sizeof(*adma), GFP_KERNEL);
> +	if (!adma)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ret = avalon_dma_init(adma, dev, regs, irq);
> +	if (ret)
> +		goto avalon_init_err;
> +
> +	dev->dma_parms = &adma->dma_parms;
> +	dma_set_max_seg_size(dev, UINT_MAX);
> +
> +	dma_dev = &adma->dma_dev;
> +	dma_cap_set(DMA_SLAVE, dma_dev->cap_mask);
> +
> +	dma_dev->device_tx_status = dma_cookie_status;
> +	dma_dev->device_prep_slave_sg = avalon_dma_prep_slave_sg;
> +	dma_dev->device_issue_pending = avalon_dma_issue_pending;
> +	dma_dev->device_terminate_all = avalon_dma_terminate_all;
> +	dma_dev->device_synchronize = avalon_dma_synchronize;
> +	dma_dev->device_config = avalon_dma_device_config;
> +
> +	dma_dev->dev = dev;
> +	dma_dev->chancnt = 1;
> +
> +	dma_dev->src_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
> +	dma_dev->dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
> +	dma_dev->directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
> +	dma_dev->residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
> +
> +	INIT_LIST_HEAD(&dma_dev->channels);
> +
> +	chan = &adma->chan;
> +	chan->vchan.desc_free = avalon_dma_desc_free;
> +	vchan_init(&chan->vchan, dma_dev);
> +
> +	ret = dma_async_device_register(dma_dev);
> +	if (ret)
> +		goto dma_dev_reg;
> +
> +	return adma;
> +
> +dma_dev_reg:
> +avalon_init_err:
> +	kfree(adma);
> +
> +	return NULL;

This will cause an oops.

	return ERR_PTR(ret);

> +}
> +
> +void avalon_dma_unregister(struct avalon_dma *adma)
> +{
> +	dmaengine_terminate_sync(&adma->chan.vchan.chan);
> +	dma_async_device_unregister(&adma->dma_dev);
> +
> +	avalon_dma_term(adma);
> +
> +	kfree(adma);
> +}
> diff --git a/drivers/dma/avalon/avalon-core.h b/drivers/dma/avalon/avalon-core.h
> new file mode 100644
> index 000000000000..07a68c4d228f
> --- /dev/null
> +++ b/drivers/dma/avalon/avalon-core.h
> @@ -0,0 +1,90 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Avalon DMA engine
> + *
> + * Author: Alexander Gordeev <a.gordeev.box@gmail.com>
> + */
> +#ifndef __AVALON_CORE_H__
> +#define __AVALON_CORE_H__
> +
> +#include <linux/interrupt.h>
> +#include <linux/dma-direction.h>
> +
> +#include "../virt-dma.h"
> +
> +struct avalon_dma_desc {
> +	struct virt_dma_desc	vdesc;
> +
> +	enum dma_data_direction	direction;
> +
> +	dma_addr_t		dev_addr;
> +
> +	struct scatterlist	*sg;
> +	unsigned int		sg_len;
> +
> +	struct scatterlist	*sg_curr;
> +	unsigned int		sg_offset;
> +};
> +
> +struct avalon_dma_hw {
> +	struct __dma_desc_table {
> +		struct dma_desc_table *cpu_addr;
> +		dma_addr_t dma_addr;
> +	} dma_desc_table_rd, dma_desc_table_wr;
> +
> +	int			h2d_last_id;
> +	int			d2h_last_id;
> +
> +	void __iomem		*regs;
> +};
> +
> +struct avalon_dma_chan {
> +	struct virt_dma_chan	vchan;
> +
> +	dma_addr_t		src_addr;
> +	dma_addr_t		dst_addr;
> +
> +	struct avalon_dma_hw	hw;
> +
> +	struct avalon_dma_desc	*active_desc;
> +};
> +
> +struct avalon_dma {
> +	struct device		*dev;
> +	unsigned int		irq;
> +
> +	struct avalon_dma_chan	chan;
> +	struct dma_device	dma_dev;
> +	struct device_dma_parameters dma_parms;
> +};
> +
> +static inline
> +struct avalon_dma_chan *to_avalon_dma_chan(struct dma_chan *dma_chan)
> +{
> +	return container_of(dma_chan, struct avalon_dma_chan, vchan.chan);
> +}
> +
> +static inline
> +struct avalon_dma_desc *to_avalon_dma_desc(struct virt_dma_desc *vdesc)
> +{
> +	return container_of(vdesc, struct avalon_dma_desc, vdesc);
> +}
> +
> +static inline
> +struct avalon_dma *chan_to_avalon_dma(struct avalon_dma_chan *chan)
> +{
> +	return container_of(chan, struct avalon_dma, chan);
> +}
> +
> +static inline
> +__iomem void *__iomem avalon_dma_mmio(struct avalon_dma *adma)
> +{
> +	return adma->chan.hw.regs;
> +}
> +
> +struct avalon_dma *avalon_dma_register(struct device *dev,
> +				       void __iomem *regs,
> +				       unsigned int irq);
> +void avalon_dma_unregister(struct avalon_dma *adma);
> +
> +#endif
> diff --git a/drivers/dma/avalon/avalon-hw.c b/drivers/dma/avalon/avalon-hw.c
> new file mode 100644
> index 000000000000..1210b0791a97
> --- /dev/null
> +++ b/drivers/dma/avalon/avalon-hw.c
> @@ -0,0 +1,212 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Avalon DMA engine
> + *
> + * Author: Alexander Gordeev <a.gordeev.box@gmail.com>
> + */
> +#include <linux/kernel.h>
> +#include <linux/delay.h>
> +
> +#include "avalon-hw.h"
> +
> +#define DMA_DESC_MAX	AVALON_DMA_DESC_NUM
> +
> +static void setup_desc(struct dma_desc *desc, u32 desc_id,
> +		       u64 dest, u64 src, u32 size)
> +{
> +	BUG_ON(!size);
> +	WARN_ON(!IS_ALIGNED(size, sizeof(u32)));
> +	BUG_ON(desc_id > (DMA_DESC_MAX - 1));
> +
> +	desc->src_lo = cpu_to_le32(src & 0xfffffffful);
> +	desc->src_hi = cpu_to_le32((src >> 32));
> +	desc->dst_lo = cpu_to_le32(dest & 0xfffffffful);
> +	desc->dst_hi = cpu_to_le32((dest >> 32));
> +	desc->ctl_dma_len = cpu_to_le32((size >> 2) | (desc_id << 18));
> +	desc->reserved[0] = cpu_to_le32(0x0);
> +	desc->reserved[1] = cpu_to_le32(0x0);
> +	desc->reserved[2] = cpu_to_le32(0x0);
> +}
> +
> +static
> +int setup_descs(struct dma_desc *descs, unsigned int desc_id,
> +		enum dma_data_direction direction,
> +		dma_addr_t dev_addr, dma_addr_t host_addr, unsigned int len,
> +		unsigned int *_set)
> +{
> +	int nr_descs = 0;
> +	unsigned int set = 0;
> +	dma_addr_t src;
> +	dma_addr_t dest;
> +
> +	if (direction == DMA_TO_DEVICE) {
> +		src = host_addr;
> +		dest = dev_addr;
> +	} else if (direction == DMA_FROM_DEVICE) {
> +		src = dev_addr;
> +		dest = host_addr;
> +	} else {
> +		BUG();
> +		return -EINVAL;
> +	}
> +
> +	if (unlikely(desc_id > DMA_DESC_MAX - 1)) {

if (desc_id >= DMA_DESC_MAX) {

> +		BUG();
> +		return -EINVAL;
> +	}
> +
> +	if (WARN_ON(!len))
> +		return -EINVAL;
> +
> +	while (len) {
> +		unsigned int xfer_len = min_t(unsigned int, len, AVALON_DMA_MAX_TANSFER_SIZE);
> +
> +		setup_desc(descs, desc_id, dest, src, xfer_len);
> +
> +		set += xfer_len;
> +
> +		nr_descs++;
> +		if (nr_descs >= DMA_DESC_MAX)
> +			break;
> +
> +		desc_id++;
> +		if (desc_id >= DMA_DESC_MAX)
> +			break;
> +
> +		descs++;
> +
> +		dest += xfer_len;
> +		src += xfer_len;
> +
> +		len -= xfer_len;
> +	}
> +
> +	*_set = set;
> +
> +	return nr_descs;
> +}
> +
> +int setup_descs_sg(struct dma_desc *descs, unsigned int desc_id,
> +		   enum dma_data_direction direction,
> +		   dma_addr_t dev_addr,
> +		   struct scatterlist *__sg, unsigned int __sg_len,
> +		   struct scatterlist *sg_start, unsigned int sg_offset,
> +		   struct scatterlist **_sg_stop, unsigned int *_sg_set)
> +{
> +	struct scatterlist *sg;
> +	dma_addr_t sg_addr;
> +	unsigned int sg_len;
> +	unsigned int sg_set;
> +	int nr_descs = 0;
> +	int ret;
> +	int i;
> +
> +	/*
> +	 * Find the SGE that the previous xfer has stopped on -
> +	 * it should exist.
> +	 */
> +	for_each_sg(__sg, sg, __sg_len, i) {
> +		if (sg == sg_start)
> +			break;
> +
> +		dev_addr += sg_dma_len(sg);
> +	}
> +
> +	if (WARN_ON(i >= __sg_len))
> +		return -EINVAL;
> +
> +	/*
> +	 * The offset can not be longer than the SGE length.
> +	 */
> +	sg_len = sg_dma_len(sg);
> +	if (WARN_ON(sg_len < sg_offset))
> +		return -EINVAL;
> +
> +	/*
> +	 * Skip the starting SGE if it has been fully transmitted.
> +	 */
> +	if (sg_offset == sg_len) {
> +		if (WARN_ON(sg_is_last(sg)))
> +			return -EINVAL;
> +
> +		dev_addr += sg_len;
> +		sg_offset = 0;
> +
> +		i++;
> +		sg = sg_next(sg);
> +	}
> +
> +	/*
> +	 * Setup as many SGEs as the controller is able to transmit.
> +	 */
> +	BUG_ON(i >= __sg_len);
> +	for (; i < __sg_len; i++) {
> +		sg_addr = sg_dma_address(sg);
> +		sg_len = sg_dma_len(sg);
> +
> +		if (sg_offset) {
> +			if (unlikely(sg_len <= sg_offset)) {
> +				BUG();
> +				return -EINVAL;
> +			}
> +
> +			dev_addr += sg_offset;
> +			sg_addr += sg_offset;
> +			sg_len -= sg_offset;
> +
> +			sg_offset = 0;
> +		}
> +
> +		ret = setup_descs(descs, desc_id, direction,
> +				  dev_addr, sg_addr, sg_len, &sg_set);
> +		if (ret < 0)
> +			return ret;
> +
> +		if (unlikely((desc_id + ret > DMA_DESC_MAX) ||
> +			     (nr_descs + ret > DMA_DESC_MAX))) {
> +			BUG();
> +			return -ENOMEM;
> +		}
> +
> +		nr_descs += ret;
> +		desc_id += ret;
> +
> +		if (desc_id >= DMA_DESC_MAX)
> +			break;

We already checked for this.

> +
> +		if (unlikely(sg_len != sg_set)) {
> +			BUG();
> +			return -EINVAL;
> +		}
> +
> +		if (sg_is_last(sg))
> +			break;
> +
> +		descs += ret;
> +		dev_addr += sg_len;
> +
> +		sg = sg_next(sg);
> +	}
> +

regards,
dan carpenter

