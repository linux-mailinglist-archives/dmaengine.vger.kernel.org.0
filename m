Return-Path: <dmaengine+bounces-6517-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B1FB58035
	for <lists+dmaengine@lfdr.de>; Mon, 15 Sep 2025 17:17:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94B6B3B6C7F
	for <lists+dmaengine@lfdr.de>; Mon, 15 Sep 2025 15:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068FB3375CD;
	Mon, 15 Sep 2025 15:16:48 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10B232F764;
	Mon, 15 Sep 2025 15:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757949407; cv=none; b=maoH1boLXXACd5oN217hi3hcC1gXidYvvop8lXGxJfifIllrUVjY2nrA21Ap3YaUMkuakj6AD3yZKLmoxxML1KDTDW+9o8i2RZuUEExaN6Eufj4kfYPUk7lGgFpl/e9MFg+h3YEpZoSUE0pl8GkmegYtXmRwAlHq3/M7rvhW4xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757949407; c=relaxed/simple;
	bh=WwkW0cyMSQJ1lBzx5s1Kc6O0ElVVRXfH01+70O8ofc0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BcLguv4ih0QBkU8lby8E9UVBtLaWFy0JeWM7iFgFi7g1fDyKg2jyCY/sjjCTbsYzY0wkEUlLdppEujoxTpnTgjiS5AoSuYNp4dBHaA0CDjFh8PK3UT8Dcn5UthKVo4oe8gqqi6WfvqD4lQVXrivklUd+CWbGgsJn3HiOtPph+Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cQT846ZDWz6M5B3;
	Mon, 15 Sep 2025 23:13:56 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id A450D1402EA;
	Mon, 15 Sep 2025 23:16:42 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 15 Sep
 2025 17:16:42 +0200
Date: Mon, 15 Sep 2025 16:16:40 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
CC: <nathan.lynch@amd.com>, Vinod Koul <vkoul@kernel.org>, Wei Huang
	<wei.huang2@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>
Subject: Re: [PATCH RFC 11/13] dmaengine: sdxi: Add DMA engine provider
Message-ID: <20250915161640.00004630@huawei.com>
In-Reply-To: <20250905-sdxi-base-v1-11-d0341a1292ba@amd.com>
References: <20250905-sdxi-base-v1-0-d0341a1292ba@amd.com>
	<20250905-sdxi-base-v1-11-d0341a1292ba@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 05 Sep 2025 13:48:34 -0500
Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org> wrote:

> From: Nathan Lynch <nathan.lynch@amd.com>
> 
> Add support for memcpy and interrupt capabilities. Register one
> channel per SDXI function discovered for now.
> 
> Co-developed-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
A few superficial comments inline.

Good to see support for this standard device btw.

Thanks,

Jonathan

> ---
>  drivers/dma/sdxi/device.c |   4 +
>  drivers/dma/sdxi/dma.c    | 409 ++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/dma/sdxi/dma.h    |  12 ++
>  3 files changed, 425 insertions(+)

> diff --git a/drivers/dma/sdxi/dma.c b/drivers/dma/sdxi/dma.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..ad8515deba53898b2b4ea0d38c40042b566abe1f
> --- /dev/null
> +++ b/drivers/dma/sdxi/dma.c

> +static int sdxi_dma_start_desc(struct sdxi_dma_desc *dma_desc)
> +{
> +	struct sdxi_dev *sdxi;
> +	struct sdxi_cmd *sdxi_cmd;
> +	struct sdxi_cxt *cxt;
> +	struct sdxi_desc desc;
> +	struct sdxi_copy copy;
> +	struct sdxi_cst_blk *cst_blk;
> +	dma_addr_t cst_blk_dma;
> +	int err;
> +
> +	sdxi_cmd = &dma_desc->sdxi_cmd;
> +	sdxi = sdxi_cmd->cxt->sdxi;
> +
> +	cxt = dma_desc->cxt;
Probably makes sense to combine with the declarations above.

> +
> +	if (sdxi_cmd->len > MAX_DMA_COPY_BYTES)
> +		return -EINVAL;
> +
> +	copy = (typeof(copy)) {
> +		.src = sdxi_cmd->src_addr,
> +		.dst = sdxi_cmd->dst_addr,
> +		.src_akey = 0,
> +		.dst_akey = 0,
> +		.len = sdxi_cmd->len,
> +	};
> +
> +	err = sdxi_encode_copy(&desc, &copy);
> +	if (err)
> +		return err;
> +
> +	err = sdxi_encode_copy(&desc, &copy);
> +	if (err)
> +		return err;
> +
> +	/* FIXME convert to pool */
> +	cst_blk = dma_alloc_coherent(sdxi_to_dev(sdxi), sizeof(*cst_blk),
> +				     &cst_blk_dma, GFP_NOWAIT);
> +	if (!cst_blk)
> +		return -ENOMEM;
> +
> +	cst_blk->signal = cpu_to_le64(0xff);
> +
> +	sdxi_cmd->cst_blk = cst_blk;
> +	sdxi_cmd->cst_blk_dma = cst_blk_dma;
> +	sdxi_cmd->ret = 0; /* TODO: get desc submit status & update ret value */
> +
> +	sdxi_desc_set_csb(&desc, cst_blk_dma);
> +	err = sdxi_submit_desc(cxt, &desc);
> +	if (err)
> +		goto free_cst_blk;
> +
> +	sdxi->tdata.cmd = sdxi_cmd; /* FIXME: this is not compatible w/multiple clients */
> +	dma_desc->issued_to_hw = 1;
> +	return 0;
> +free_cst_blk:
> +	dma_free_coherent(sdxi_to_dev(sdxi), sizeof(*cst_blk),
> +			  cst_blk, cst_blk_dma);
> +	return err;
> +}

> +static struct sdxi_dma_desc *sdxi_handle_active_desc(struct sdxi_dma_chan *chan,
> +						     struct sdxi_dma_desc *desc)
> +{
> +	struct dma_async_tx_descriptor *tx_desc;
> +	struct virt_dma_desc *vd;
> +	unsigned long flags;
> +
> +	/* Loop over descriptors until one is found with commands */
> +	do {
> +		if (desc) {
> +			if (!desc->issued_to_hw) {
> +				/* No errors, keep going */
> +				if (desc->status != DMA_ERROR)
> +					return desc;
> +			}
> +
> +			tx_desc = &desc->vd.tx;
> +			vd = &desc->vd;
> +		} else {
> +			tx_desc = NULL;
> +		}
> +
> +		spin_lock_irqsave(&chan->vc.lock, flags);
> +
> +		if (desc) {
> +

No blank line here.

> +			if (desc->status != DMA_COMPLETE) {
> +				if (desc->status != DMA_ERROR)
> +					desc->status = DMA_COMPLETE;
> +
> +				dma_cookie_complete(tx_desc);
> +				dma_descriptor_unmap(tx_desc);
> +				list_del(&desc->vd.node);
> +			} else {
> +				/* Don't handle it twice */
> +				tx_desc = NULL;
> +			}
> +		}
> +
> +		desc = sdxi_next_dma_desc(chan);
> +
> +		spin_unlock_irqrestore(&chan->vc.lock, flags);
> +
> +		if (tx_desc) {
> +			dmaengine_desc_get_callback_invoke(tx_desc, NULL);
> +			dma_run_dependencies(tx_desc);
> +			vchan_vdesc_fini(vd);
> +		}
> +	} while (desc);
> +
> +	return NULL;
> +}
> +
> +static void sdxi_cmd_callback(void *data, int err)
> +{
> +	struct sdxi_dma_desc *desc = data;
> +	struct dma_chan *dma_chan;
> +	struct sdxi_dma_chan *chan;
> +	int ret;
> +
> +	if (err == -EINPROGRESS)
> +		return;
> +
> +	dma_chan = desc->vd.tx.chan;
> +	chan = to_sdxi_dma_chan(dma_chan);
> +
> +	if (err)
> +		desc->status = DMA_ERROR;
> +
> +	while (true) {
> +		/* Check for DMA descriptor completion */
> +		desc = sdxi_handle_active_desc(chan, desc);
> +
> +		/* Don't submit cmd if no descriptor or DMA is paused */
> +		if (!desc)
perhaps return?
> +			break;
> +
> +		ret = sdxi_dma_start_desc(desc);
> +		if (!ret)
> +			break;
Perhaps return to make it clear that there is nothing else to do.
> +
> +		desc->status = DMA_ERROR;
> +	}
> +}
> +

> +
> +static struct sdxi_dma_desc *sdxi_dma_create_desc(struct dma_chan *dma_chan,
> +						  dma_addr_t dst,
> +						  dma_addr_t src,
> +						  unsigned int len,
> +						  unsigned long flags)
> +{
> +	struct sdxi_dma_chan *chan = to_sdxi_dma_chan(dma_chan);
> +	struct sdxi_dma_desc *desc;
> +	struct sdxi_cmd *sdxi_cmd;
> +
> +	desc = sdxi_dma_alloc_dma_desc(chan, flags);
> +	if (!desc)
> +		return NULL;
> +
> +	sdxi_cmd = &desc->sdxi_cmd;
Maybe
	*sdxi_cmd = (struct sdxi_cmd) {
		.ctx = chan->ctx,
etc

	};
> +	sdxi_cmd->cxt = chan->cxt;
> +	sdxi_cmd->cxt->sdxi = chan->cxt->sdxi;
> +	sdxi_cmd->src_addr = src;
> +	sdxi_cmd->dst_addr = dst;
> +	sdxi_cmd->len = len;
> +	sdxi_cmd->sdxi_cmd_callback = sdxi_cmd_callback;
> +	sdxi_cmd->data = desc;
> +
> +	return desc;
> +}

> +
> +static void sdxi_check_trans_status(struct sdxi_dma_chan *chan)
> +{
> +	struct sdxi_cxt *cxt = chan->cxt;
> +	struct sdxi_cmd *cmd;
> +
> +	if (!cxt)
> +		return;
> +
> +	cmd = cxt->sdxi->tdata.cmd;
> +
> +	if (le64_to_cpu(cmd->cst_blk->signal) == 0xfe)

Given that's a magic looking value, I think this 0xfe needs a define.

> +		sdxi_cmd_callback(cmd->data, cmd->ret);
> +}

> +
> +int sdxi_dma_register(struct sdxi_cxt *dma_cxt)
> +{
> +	struct sdxi_dma_chan *chan;
> +	struct sdxi_dev *sdxi = dma_cxt->sdxi;
> +	struct device *dev = sdxi_to_dev(sdxi);
> +	struct dma_device *dma_dev = &sdxi->dma_dev;
> +	int ret = 0;
> +
> +	sdxi->sdxi_dma_chan = devm_kzalloc(dev, sizeof(*sdxi->sdxi_dma_chan),
> +					   GFP_KERNEL);
This results in a mix of manual cleanup and devm.  That's generally something
we want to avoid because it makes code hard to review for race conditions etc.
I'd consider using custom actions and devm_add_action_or_reset() to ensure
that everything up to the first thing you want to not manage is done with
devm and ensure everything after that is done by hand.

Or use devm for everything.

> +	if (!sdxi->sdxi_dma_chan)
> +		return -ENOMEM;
> +
> +	sdxi->sdxi_dma_chan->cxt = dma_cxt;
> +
> +	dma_dev->dev = dev;
> +	dma_dev->src_addr_widths = DMA_SLAVE_BUSWIDTH_64_BYTES;
> +	dma_dev->dst_addr_widths = DMA_SLAVE_BUSWIDTH_64_BYTES;
> +	dma_dev->directions = BIT(DMA_MEM_TO_MEM);
> +	dma_dev->residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
> +	dma_cap_set(DMA_MEMCPY, dma_dev->cap_mask);
> +	dma_cap_set(DMA_INTERRUPT, dma_dev->cap_mask);
> +
> +	dma_cap_set(DMA_PRIVATE, dma_dev->cap_mask);
> +
> +	INIT_LIST_HEAD(&dma_dev->channels);
> +
> +	chan = sdxi->sdxi_dma_chan;
> +	chan->cxt->sdxi = sdxi;
> +
> +	/* Set base and prep routines */
> +	dma_dev->device_free_chan_resources = sdxi_dma_free_chan_resources;
> +	dma_dev->device_prep_dma_memcpy = sdxi_dma_prep_memcpy;
> +	dma_dev->device_prep_dma_interrupt = sdxi_prep_dma_interrupt;
> +	dma_dev->device_issue_pending = sdxi_dma_issue_pending;
> +	dma_dev->device_tx_status = sdxi_tx_status;
> +	dma_dev->device_terminate_all = sdxi_dma_terminate_all;
> +	dma_dev->device_synchronize = sdxi_dma_synchronize;
> +
> +	chan->vc.desc_free = sdxi_do_cleanup;
> +	vchan_init(&chan->vc, dma_dev);
> +
> +	dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
> +
> +	ret = dma_async_device_register(dma_dev);
> +	if (ret)
> +		goto err_reg;
> +
> +	return 0;
> +
> +err_reg:

Just return early unless there is something to do.

> +	return ret;
> +}
> +
> +void sdxi_dma_unregister(struct sdxi_cxt *dma_cxt)
> +{
> +	dma_async_device_unregister(&dma_cxt->sdxi->dma_dev);
> +}



