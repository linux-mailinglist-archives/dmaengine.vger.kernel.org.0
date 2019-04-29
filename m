Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB647DB86
	for <lists+dmaengine@lfdr.de>; Mon, 29 Apr 2019 07:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfD2FcL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 29 Apr 2019 01:32:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:44776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbfD2FcL (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 29 Apr 2019 01:32:11 -0400
Received: from localhost (unknown [171.76.113.243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DCB821473;
        Mon, 29 Apr 2019 05:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556515929;
        bh=R7yH6SCc2CdS819L2jITRdSb1HXfUxdjdXlqVBUtlGk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TEi4Q2ZS8heyrnZg0UuRD9dV4snqtWJyavXuT15OE0+SwGz4fgEKthIH71p/GTEa9
         uAhU6T3i4Ikp7OrnZ6uK5vE0/jo7t3zttmW4YYaPWoBcIlmxFcLzo4JplqFQA19gHt
         TmprPVEUAr+tp94oEAkGORX/SjenW7CbaG3F4FSA=
Date:   Mon, 29 Apr 2019 11:02:03 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peng Ma <peng.ma@nxp.com>
Cc:     dan.j.williams@intel.com, leoyang.li@nxp.com,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [V3 2/2] dmaengine: fsl-dpaa2-qdma: Add NXP dpaa2 qDMA
 controller driver for Layerscape SoCs
Message-ID: <20190429053203.GF3845@vkoul-mobl.Dlink>
References: <20190409072212.15860-1-peng.ma@nxp.com>
 <20190409072212.15860-2-peng.ma@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190409072212.15860-2-peng.ma@nxp.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 09-04-19, 15:22, Peng Ma wrote:
> DPPA2(Data Path Acceleration Architecture 2) qDMA
> The qDMA supports channel virtualization by allowing DMA jobs to be enqueued
> into different frame queues. Core can initiate a DMA transaction by preparing
> a frame descriptor(FD) for each DMA job and enqueuing this job to a frame queue.
> through a hardware portal. The qDMA prefetches DMA jobs from the frame queues.
> It then schedules and dispatches to internal DMA hardware engines, which
> generate read and write requests. Both qDMA source data and destination data can
> be either contiguous or non-contiguous using one or more scatter/gather tables.
> The qDMA supports global bandwidth flow control where all DMA transactions are
> stalled if the bandwidth threshold has been reached. Also supported are
> transaction based read throttling.
> 
> Add NXP dppa2 qDMA to support some of Layerscape SoCs.
> such as: LS1088A, LS208xA, LX2, etc.
> 
> Signed-off-by: Peng Ma <peng.ma@nxp.com>
> ---
> changed for v3:
> 	- Add depends on arm64 for dpaa2 qdma driver 
> 	- The dpaa2_io_service_[de]register functions have a new parameter
> 	So update all calls to some functions
> 
>  drivers/dma/Kconfig                     |    2 +
>  drivers/dma/Makefile                    |    1 +
>  drivers/dma/fsl-dpaa2-qdma/Kconfig      |    9 +
>  drivers/dma/fsl-dpaa2-qdma/Makefile     |    3 +
>  drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c |  782 +++++++++++++++++++++++++++++++
>  drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.h |  152 ++++++
>  6 files changed, 949 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/dma/fsl-dpaa2-qdma/Kconfig
>  create mode 100644 drivers/dma/fsl-dpaa2-qdma/Makefile
>  create mode 100644 drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c
>  create mode 100644 drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.h
> 
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index eaf78f4..08aae01 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -671,6 +671,8 @@ source "drivers/dma/sh/Kconfig"
>  
>  source "drivers/dma/ti/Kconfig"
>  
> +source "drivers/dma/fsl-dpaa2-qdma/Kconfig"
> +
>  # clients
>  comment "DMA Clients"
>  	depends on DMA_ENGINE
> diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
> index 6126e1c..2499ed8 100644
> --- a/drivers/dma/Makefile
> +++ b/drivers/dma/Makefile
> @@ -75,6 +75,7 @@ obj-$(CONFIG_UNIPHIER_MDMAC) += uniphier-mdmac.o
>  obj-$(CONFIG_XGENE_DMA) += xgene-dma.o
>  obj-$(CONFIG_ZX_DMA) += zx_dma.o
>  obj-$(CONFIG_ST_FDMA) += st_fdma.o
> +obj-$(CONFIG_FSL_DPAA2_QDMA) += fsl-dpaa2-qdma/
>  
>  obj-y += mediatek/
>  obj-y += qcom/
> diff --git a/drivers/dma/fsl-dpaa2-qdma/Kconfig b/drivers/dma/fsl-dpaa2-qdma/Kconfig
> new file mode 100644
> index 0000000..258ed6b
> --- /dev/null
> +++ b/drivers/dma/fsl-dpaa2-qdma/Kconfig
> @@ -0,0 +1,9 @@
> +menuconfig FSL_DPAA2_QDMA
> +	tristate "NXP DPAA2 QDMA"
> +	depends on ARM64
> +	depends on FSL_MC_BUS && FSL_MC_DPIO
> +	select DMA_ENGINE
> +	select DMA_VIRTUAL_CHANNELS
> +	help
> +	  NXP Data Path Acceleration Architecture 2 QDMA driver,
> +	  using the NXP MC bus driver.
> diff --git a/drivers/dma/fsl-dpaa2-qdma/Makefile b/drivers/dma/fsl-dpaa2-qdma/Makefile
> new file mode 100644
> index 0000000..c1d0226
> --- /dev/null
> +++ b/drivers/dma/fsl-dpaa2-qdma/Makefile
> @@ -0,0 +1,3 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Makefile for the NXP DPAA2 qDMA controllers
> +obj-$(CONFIG_FSL_DPAA2_QDMA) += dpaa2-qdma.o dpdmai.o
> diff --git a/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c b/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c
> new file mode 100644
> index 0000000..0cdde0f
> --- /dev/null
> +++ b/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c
> @@ -0,0 +1,782 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright 2014-2018 NXP
> +
> +/*
> + * Author: Changming Huang <jerry.huang@nxp.com>
> + *
> + * Driver for the NXP QDMA engine with QMan mode.
> + * Channel virtualization is supported through enqueuing of DMA jobs to,
> + * or dequeuing DMA jobs from different work queues with QMan portal.
> + * This module can be found on NXP LS2 SoCs.
> + *
> + */
> +
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/dmapool.h>
> +#include <linux/of_irq.h>
> +#include <linux/iommu.h>
> +#include <linux/sys_soc.h>
> +#include <linux/fsl/mc.h>
> +#include <soc/fsl/dpaa2-io.h>
> +
> +#include "../virt-dma.h"
> +#include "dpdmai_cmd.h"
> +#include "dpdmai.h"
> +#include "dpaa2-qdma.h"
> +
> +static bool smmu_disable = true;
> +
> +static struct dpaa2_qdma_chan *to_dpaa2_qdma_chan(struct dma_chan *chan)
> +{
> +	return container_of(chan, struct dpaa2_qdma_chan, vchan.chan);
> +}
> +
> +static struct dpaa2_qdma_comp *to_fsl_qdma_comp(struct virt_dma_desc *vd)
> +{
> +	return container_of(vd, struct dpaa2_qdma_comp, vdesc);
> +}
> +
> +static int dpaa2_qdma_alloc_chan_resources(struct dma_chan *chan)
> +{
> +	struct dpaa2_qdma_chan *dpaa2_chan = to_dpaa2_qdma_chan(chan);
> +	struct dpaa2_qdma_engine *dpaa2_qdma = dpaa2_chan->qdma;
> +	struct device *dev = &dpaa2_qdma->priv->dpdmai_dev->dev;
> +
> +	dpaa2_chan->fd_pool = dma_pool_create("fd_pool", dev,
> +					      FD_POOL_SIZE, 32, 0);
> +	if (!dpaa2_chan->fd_pool)
> +		return -ENOMEM;
> +
> +	return dpaa2_qdma->desc_allocated++;
> +}
> +
> +static void dpaa2_qdma_free_chan_resources(struct dma_chan *chan)
> +{
> +	struct dpaa2_qdma_chan *dpaa2_chan = to_dpaa2_qdma_chan(chan);
> +	struct dpaa2_qdma_engine *dpaa2_qdma = dpaa2_chan->qdma;
> +	unsigned long flags;
> +
> +	LIST_HEAD(head);
> +
> +	spin_lock_irqsave(&dpaa2_chan->vchan.lock, flags);
> +	vchan_get_all_descriptors(&dpaa2_chan->vchan, &head);
> +	spin_unlock_irqrestore(&dpaa2_chan->vchan.lock, flags);
> +
> +	vchan_dma_desc_free_list(&dpaa2_chan->vchan, &head);
> +
> +	dpaa2_dpdmai_free_comp(dpaa2_chan, &dpaa2_chan->comp_used);
> +	dpaa2_dpdmai_free_comp(dpaa2_chan, &dpaa2_chan->comp_free);
> +
> +	dma_pool_destroy(dpaa2_chan->fd_pool);
> +	dpaa2_qdma->desc_allocated--;
> +}
> +
> +/*
> + * Request a command descriptor for enqueue.
> + */
> +static struct dpaa2_qdma_comp *
> +dpaa2_qdma_request_desc(struct dpaa2_qdma_chan *dpaa2_chan)
> +{
> +	struct dpaa2_qdma_comp *comp_temp = NULL;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&dpaa2_chan->queue_lock, flags);
> +	if (list_empty(&dpaa2_chan->comp_free)) {
> +		spin_unlock_irqrestore(&dpaa2_chan->queue_lock, flags);
> +		comp_temp = kzalloc(sizeof(*comp_temp), GFP_KERNEL);

GFP_NOWAIT?

> +		if (!comp_temp)
> +			goto err;
> +		comp_temp->fd_virt_addr =
> +			dma_pool_alloc(dpaa2_chan->fd_pool, GFP_NOWAIT,
> +				       &comp_temp->fd_bus_addr);
> +		if (!comp_temp->fd_virt_addr)

err handling seems incorrect, you dont clean up, caller doesnt check
return!

> +			goto err;
> +
> +		comp_temp->fl_virt_addr =
> +			(void *)((struct dpaa2_fd *)
> +				comp_temp->fd_virt_addr + 1);

casts and pointer math, what could go wrong!! This doesnt smell right!

> +		comp_temp->fl_bus_addr = comp_temp->fd_bus_addr +
> +					sizeof(struct dpaa2_fd);

why not use fl_virt_addr and get the bus_address?

> +		comp_temp->desc_virt_addr =
> +			(void *)((struct dpaa2_fl_entry *)
> +				comp_temp->fl_virt_addr + 3);
> +		comp_temp->desc_bus_addr = comp_temp->fl_bus_addr +
> +				sizeof(struct dpaa2_fl_entry) * 3;

pointer math in the two calls doesnt match and as I said doesnt look
good...

> +
> +		comp_temp->qchan = dpaa2_chan;
> +		return comp_temp;
> +	}
> +	comp_temp = list_first_entry(&dpaa2_chan->comp_free,
> +				     struct dpaa2_qdma_comp, list);
> +	list_del(&comp_temp->list);
> +	spin_unlock_irqrestore(&dpaa2_chan->queue_lock, flags);
> +
> +	comp_temp->qchan = dpaa2_chan;
> +err:
> +	return comp_temp;
> +}
> +
> +static void
> +dpaa2_qdma_populate_fd(u32 format, struct dpaa2_qdma_comp *dpaa2_comp)
> +{
> +	struct dpaa2_fd *fd;
> +
> +	fd = (struct dpaa2_fd *)dpaa2_comp->fd_virt_addr;

whats with the casts! you seem to like them! You are casting away from
void!

> +	memset(fd, 0, sizeof(struct dpaa2_fd));
> +
> +	/* fd populated */
> +	dpaa2_fd_set_addr(fd, dpaa2_comp->fl_bus_addr);
> +	/* Bypass memory translation, Frame list format, short length disable */
> +	/* we need to disable BMT if fsl-mc use iova addr */
> +	if (smmu_disable)
> +		dpaa2_fd_set_bpid(fd, QMAN_FD_BMT_ENABLE);
> +	dpaa2_fd_set_format(fd, QMAN_FD_FMT_ENABLE | QMAN_FD_SL_DISABLE);
> +
> +	dpaa2_fd_set_frc(fd, format | QDMA_SER_CTX);
> +}
> +
> +/* first frame list for descriptor buffer */
> +static void
> +dpaa2_qdma_populate_first_framel(struct dpaa2_fl_entry *f_list,
> +				 struct dpaa2_qdma_comp *dpaa2_comp,
> +				 bool wrt_changed)
> +{
> +	struct dpaa2_qdma_sd_d *sdd;
> +
> +	sdd = (struct dpaa2_qdma_sd_d *)dpaa2_comp->desc_virt_addr;

again

> +	memset(sdd, 0, 2 * (sizeof(*sdd)));
> +
> +	/* source descriptor CMD */
> +	sdd->cmd = cpu_to_le32(QDMA_SD_CMD_RDTTYPE_COHERENT);
> +	sdd++;
> +
> +	/* dest descriptor CMD */
> +	if (wrt_changed)
> +		sdd->cmd = cpu_to_le32(LX2160_QDMA_DD_CMD_WRTTYPE_COHERENT);
> +	else
> +		sdd->cmd = cpu_to_le32(QDMA_DD_CMD_WRTTYPE_COHERENT);
> +
> +	memset(f_list, 0, sizeof(struct dpaa2_fl_entry));
> +
> +	/* first frame list to source descriptor */
> +	dpaa2_fl_set_addr(f_list, dpaa2_comp->desc_bus_addr);
> +	dpaa2_fl_set_len(f_list, 0x20);
> +	dpaa2_fl_set_format(f_list, QDMA_FL_FMT_SBF | QDMA_FL_SL_LONG);
> +
> +	/* bypass memory translation */
> +	if (smmu_disable)
> +		f_list->bpid = cpu_to_le16(QDMA_FL_BMT_ENABLE);
> +}
> +
> +/* source and destination frame list */
> +static void
> +dpaa2_qdma_populate_frames(struct dpaa2_fl_entry *f_list,
> +			   dma_addr_t dst, dma_addr_t src,
> +			   size_t len, uint8_t fmt)
> +{
> +	/* source frame list to source buffer */
> +	memset(f_list, 0, sizeof(struct dpaa2_fl_entry));
> +
> +	dpaa2_fl_set_addr(f_list, src);
> +	dpaa2_fl_set_len(f_list, len);
> +
> +	/* single buffer frame or scatter gather frame */
> +	dpaa2_fl_set_format(f_list, (fmt | QDMA_FL_SL_LONG));
> +
> +	/* bypass memory translation */
> +	if (smmu_disable)
> +		f_list->bpid = cpu_to_le16(QDMA_FL_BMT_ENABLE);
> +
> +	f_list++;
> +
> +	/* destination frame list to destination buffer */
> +	memset(f_list, 0, sizeof(struct dpaa2_fl_entry));
> +
> +	dpaa2_fl_set_addr(f_list, dst);
> +	dpaa2_fl_set_len(f_list, len);
> +	dpaa2_fl_set_format(f_list, (fmt | QDMA_FL_SL_LONG));
> +	/* single buffer frame or scatter gather frame */
> +	dpaa2_fl_set_final(f_list, QDMA_FL_F);
> +	/* bypass memory translation */
> +	if (smmu_disable)
> +		f_list->bpid = cpu_to_le16(QDMA_FL_BMT_ENABLE);
> +}
> +
> +static struct dma_async_tx_descriptor
> +*dpaa2_qdma_prep_memcpy(struct dma_chan *chan, dma_addr_t dst,
> +			dma_addr_t src, size_t len, ulong flags)
> +{
> +	struct dpaa2_qdma_chan *dpaa2_chan = to_dpaa2_qdma_chan(chan);
> +	struct dpaa2_qdma_engine *dpaa2_qdma;
> +	struct dpaa2_qdma_comp *dpaa2_comp;
> +	struct dpaa2_fl_entry *f_list;
> +	bool wrt_changed;
> +	u32 format;
> +
> +	dpaa2_qdma = dpaa2_chan->qdma;
> +	dpaa2_comp = dpaa2_qdma_request_desc(dpaa2_chan);
> +	wrt_changed = (bool)dpaa2_qdma->qdma_wrtype_fixup;
> +
> +#ifdef LONG_FORMAT

 compile flag and define, so else part is dead code??

> +	format = QDMA_FD_LONG_FORMAT;
> +#else
> +	format = QDMA_FD_SHORT_FORMAT;
> +#endif
> +	/* populate Frame descriptor */
> +	dpaa2_qdma_populate_fd(format, dpaa2_comp);
> +
> +	f_list = (struct dpaa2_fl_entry *)dpaa2_comp->fl_virt_addr;
> +
> +#ifdef LONG_FORMAT
> +	/* first frame list for descriptor buffer (logn format) */
> +	dpaa2_qdma_populate_first_framel(f_list, dpaa2_comp, wrt_changed);
> +
> +	f_list++;
> +#endif
> +
> +	dpaa2_qdma_populate_frames(f_list, dst, src, len, QDMA_FL_FMT_SBF);
> +
> +	return vchan_tx_prep(&dpaa2_chan->vchan, &dpaa2_comp->vdesc, flags);
> +}
> +
> +static enum
> +dma_status dpaa2_qdma_tx_status(struct dma_chan *chan,
> +				dma_cookie_t cookie,
> +				struct dma_tx_state *txstate)
> +{
> +	return dma_cookie_status(chan, cookie, txstate);
> +}
> +
> +static void dpaa2_qdma_issue_pending(struct dma_chan *chan)
> +{
> +	struct dpaa2_qdma_chan *dpaa2_chan = to_dpaa2_qdma_chan(chan);
> +	struct dpaa2_qdma_engine *dpaa2_qdma = dpaa2_chan->qdma;
> +	struct dpaa2_qdma_priv *priv = dpaa2_qdma->priv;
> +	struct dpaa2_qdma_comp *dpaa2_comp;
> +	struct virt_dma_desc *vdesc;
> +	struct dpaa2_fd *fd;
> +	unsigned long flags;
> +	int err;
> +
> +	spin_lock_irqsave(&dpaa2_chan->queue_lock, flags);
> +	spin_lock(&dpaa2_chan->vchan.lock);
> +	if (vchan_issue_pending(&dpaa2_chan->vchan)) {
> +		vdesc = vchan_next_desc(&dpaa2_chan->vchan);
> +		if (!vdesc)
> +			goto err_enqueue;
> +		dpaa2_comp = to_fsl_qdma_comp(vdesc);
> +
> +		fd = (struct dpaa2_fd *)dpaa2_comp->fd_virt_addr;
> +
> +		list_del(&vdesc->node);
> +		list_add_tail(&dpaa2_comp->list, &dpaa2_chan->comp_used);

what does this list do?

> +
> +		/* TOBO: priority hard-coded to zero */

You mean TODO?

> +		err = dpaa2_io_service_enqueue_fq(NULL,
> +				priv->tx_queue_attr[0].fqid, fd);
> +		if (err) {
> +			list_del(&dpaa2_comp->list);
> +			list_add_tail(&dpaa2_comp->list,
> +				      &dpaa2_chan->comp_free);
> +		}
> +	}
> +err_enqueue:
> +	spin_unlock(&dpaa2_chan->vchan.lock);
> +	spin_unlock_irqrestore(&dpaa2_chan->queue_lock, flags);
> +}
> +
> +static int __cold dpaa2_qdma_setup(struct fsl_mc_device *ls_dev)
> +{
> +	struct dpaa2_qdma_priv_per_prio *ppriv;
> +	struct device *dev = &ls_dev->dev;
> +	struct dpaa2_qdma_priv *priv;
> +	u8 prio_def = DPDMAI_PRIO_NUM;
> +	int err;
> +	int i;
> +
> +	priv = dev_get_drvdata(dev);
> +
> +	priv->dev = dev;
> +	priv->dpqdma_id = ls_dev->obj_desc.id;
> +
> +	/*Get the handle for the DPDMAI this interface is associate with */

Please run checkpatch, it should have told you that you need space after
comment marker /* foo...

> +	err = dpdmai_open(priv->mc_io, 0, priv->dpqdma_id, &ls_dev->mc_handle);
> +	if (err) {
> +		dev_err(dev, "dpdmai_open() failed\n");
> +		return err;
> +	}
> +	dev_info(dev, "Opened dpdmai object successfully\n");
> +
> +	err = dpdmai_get_attributes(priv->mc_io, 0, ls_dev->mc_handle,
> +				    &priv->dpdmai_attr);
> +	if (err) {
> +		dev_err(dev, "dpdmai_get_attributes() failed\n");
> +		return err;

so you dont close what you opened in dpdmai_open() Please give a serious
thought and testing to this driver

> +	}
> +
> +	if (priv->dpdmai_attr.version.major > DPDMAI_VER_MAJOR) {
> +		dev_err(dev, "DPDMAI major version mismatch\n"
> +			     "Found %u.%u, supported version is %u.%u\n",
> +				priv->dpdmai_attr.version.major,
> +				priv->dpdmai_attr.version.minor,
> +				DPDMAI_VER_MAJOR, DPDMAI_VER_MINOR);
> +	}
> +
> +	if (priv->dpdmai_attr.version.minor > DPDMAI_VER_MINOR) {
> +		dev_err(dev, "DPDMAI minor version mismatch\n"
> +			     "Found %u.%u, supported version is %u.%u\n",
> +				priv->dpdmai_attr.version.major,
> +				priv->dpdmai_attr.version.minor,
> +				DPDMAI_VER_MAJOR, DPDMAI_VER_MINOR);

what is the implication of these error, why not bail out on these?

> +	}
> +
> +	priv->num_pairs = min(priv->dpdmai_attr.num_of_priorities, prio_def);
> +	ppriv = kcalloc(priv->num_pairs, sizeof(*ppriv), GFP_KERNEL);

what is the context of the fn, sleepy, atomic?

> +	if (!ppriv) {
> +		dev_err(dev, "kzalloc for ppriv failed\n");

this need not be logged, core will do so

> +		return -1;

really -1??

I think this driver needs more work, please fix these issues in the
comments above and also see in rest of the code

-- 
~Vinod
