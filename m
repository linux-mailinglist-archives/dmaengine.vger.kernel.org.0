Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F212518F6
	for <lists+dmaengine@lfdr.de>; Mon, 24 Jun 2019 18:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbfFXQtJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 24 Jun 2019 12:49:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:44236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727715AbfFXQtJ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 24 Jun 2019 12:49:09 -0400
Received: from localhost (unknown [106.201.35.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D8D1204EC;
        Mon, 24 Jun 2019 16:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561394947;
        bh=/NHJfqWeCqb+Lp1/50yhyIeXAOct+MNKza0IWDRx7mQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rnTD54Rb4s3lVxiO5SzU0ZulEwZcIBpuL1tTEC9wRmVu13q+75fb2w+vR4dIo/U5s
         V0MZwRq0JJrXn2EQr0NG+C7+dEIAQSA67UxQBP2GdwiIEQRLCbrISQsgGu3tbJOniy
         ql3Oen9IgZxiIULiGacGWLru4UV9HKaSrt+1zurI=
Date:   Mon, 24 Jun 2019 22:15:56 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peng Ma <peng.ma@nxp.com>
Cc:     dan.j.williams@intel.com, leoyang.li@nxp.com,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [V4 2/2] dmaengine: fsl-dpaa2-qdma: Add NXP dpaa2 qDMA
 controller driver for Layerscape SoCs
Message-ID: <20190624164556.GD2962@vkoul-mobl>
References: <20190613101341.21169-1-peng.ma@nxp.com>
 <20190613101341.21169-2-peng.ma@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613101341.21169-2-peng.ma@nxp.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 13-06-19, 10:13, Peng Ma wrote:
> DPPA2(Data Path Acceleration Architecture 2) qDMA
> supports channel virtualization by allowing DMA

typo virtualization

> jobs to be enqueued into different frame queues.
> Core can initiate a DMA transaction by preparing a frame
> descriptor(FD) for each DMA job and enqueuing this job to
> a frame queue. through a hardware portal. The qDMA
              ^^^
why this full stop?

> +static struct dpaa2_qdma_comp *
> +dpaa2_qdma_request_desc(struct dpaa2_qdma_chan *dpaa2_chan)
> +{
> +	struct dpaa2_qdma_comp *comp_temp = NULL;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&dpaa2_chan->queue_lock, flags);
> +	if (list_empty(&dpaa2_chan->comp_free)) {
> +		spin_unlock_irqrestore(&dpaa2_chan->queue_lock, flags);
> +		comp_temp = kzalloc(sizeof(*comp_temp), GFP_NOWAIT);
> +		if (!comp_temp)
> +			goto err;
> +		comp_temp->fd_virt_addr =
> +			dma_pool_alloc(dpaa2_chan->fd_pool, GFP_NOWAIT,
> +				       &comp_temp->fd_bus_addr);
> +		if (!comp_temp->fd_virt_addr)
> +			goto err_comp;
> +
> +		comp_temp->fl_virt_addr =
> +			dma_pool_alloc(dpaa2_chan->fl_pool, GFP_NOWAIT,
> +				       &comp_temp->fl_bus_addr);
> +		if (!comp_temp->fl_virt_addr)
> +			goto err_fd_virt;
> +
> +		comp_temp->desc_virt_addr =
> +			dma_pool_alloc(dpaa2_chan->sdd_pool, GFP_NOWAIT,
> +				       &comp_temp->desc_bus_addr);
> +		if (!comp_temp->desc_virt_addr)
> +			goto err_fl_virt;
> +
> +		comp_temp->qchan = dpaa2_chan;
> +		return comp_temp;
> +	}
> +
> +	comp_temp = list_first_entry(&dpaa2_chan->comp_free,
> +				     struct dpaa2_qdma_comp, list);
> +	list_del(&comp_temp->list);
> +	spin_unlock_irqrestore(&dpaa2_chan->queue_lock, flags);
> +
> +	comp_temp->qchan = dpaa2_chan;
> +
> +	return comp_temp;
> +
> +err_fl_virt:

no err logs? how will you know what went wrong?

> +static enum
> +dma_status dpaa2_qdma_tx_status(struct dma_chan *chan,
> +				dma_cookie_t cookie,
> +				struct dma_tx_state *txstate)
> +{
> +	return dma_cookie_status(chan, cookie, txstate);

why not set dma_cookie_status as this callback?

> +static int __cold dpaa2_qdma_setup(struct fsl_mc_device *ls_dev)
> +{
> +	struct dpaa2_qdma_priv_per_prio *ppriv;
> +	struct device *dev = &ls_dev->dev;
> +	struct dpaa2_qdma_priv *priv;
> +	u8 prio_def = DPDMAI_PRIO_NUM;
> +	int err = -EINVAL;
> +	int i;
> +
> +	priv = dev_get_drvdata(dev);
> +
> +	priv->dev = dev;
> +	priv->dpqdma_id = ls_dev->obj_desc.id;
> +
> +	/* Get the handle for the DPDMAI this interface is associate with */
> +	err = dpdmai_open(priv->mc_io, 0, priv->dpqdma_id, &ls_dev->mc_handle);
> +	if (err) {
> +		dev_err(dev, "dpdmai_open() failed\n");
> +		return err;
> +	}
> +	dev_info(dev, "Opened dpdmai object successfully\n");

this is noise in kernel, consider debug level

> +static int __cold dpaa2_dpdmai_bind(struct dpaa2_qdma_priv *priv)
> +{
> +	int err;
> +	int i, num;
> +	struct device *dev = priv->dev;
> +	struct dpaa2_qdma_priv_per_prio *ppriv;
> +	struct dpdmai_rx_queue_cfg rx_queue_cfg;
> +	struct fsl_mc_device *ls_dev = to_fsl_mc_device(dev);

the order is reverse than used in other fn, please stick to one style!
-- 
~Vinod
