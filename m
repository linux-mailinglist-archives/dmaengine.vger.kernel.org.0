Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C48E438EA0
	for <lists+dmaengine@lfdr.de>; Mon, 25 Oct 2021 07:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhJYFKx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 25 Oct 2021 01:10:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:59266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229678AbhJYFKw (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 25 Oct 2021 01:10:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4AE4660F0F;
        Mon, 25 Oct 2021 05:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635138511;
        bh=uke0OEtsGnqY+DurdqRsAJ/5Zg2sW7YmLSCTReAFrqQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O4Oe3VSaaYChX3PtwGpKt6EIwJ1AEpBYtRl56K4zqdaRzvo33H8ZdYLSuu0Kw6vpJ
         ab4vGcOE7tItFS5to2rwg8geZOL1RGEXZwhsbLoF1f4N1FBiVZlVODD4WfDrEilpXX
         2hm/5VuFlBiwyXZsc2pJaN8XaLh15Gsbva+vVuLd0MydNb2QZqnIHgFSChM2kzQ6N1
         m6KFYgBqx3RwFcO/569TyOXEqCNfP4O39/3OZVULx2KMksvuuH0e1U9q2ouF4rG8iq
         R2l6XBPLjS16sjhAqo/Cej8rewI8OdUB2zxVjXdgjLDXkM+ngaQIedV4Lm/sH4ifU6
         CVCwkp8nR5xbA==
Date:   Mon, 25 Oct 2021 10:38:26 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Kevin Tian <kevin.tian@intel.com>, dmaengine@vger.kernel.org
Subject: Re: [PATCH 6/7] dmaengine: idxd: handle invalid interrupt handle
 descriptors
Message-ID: <YXY7yh7uIy5xZjMa@matsya>
References: <163474864017.2608004.10983485368237365990.stgit@djiang5-desk3.ch.intel.com>
 <163474884968.2608004.28577475888887187.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163474884968.2608004.28577475888887187.stgit@djiang5-desk3.ch.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 20-10-21, 09:54, Dave Jiang wrote:
> Handle a descriptor that has been marked with invalid interrupt handle
> error in status. Create a work item that will resubmit the descriptor. This
> typically happens when the driver has handled the revoke interrupt handle
> event and has a new interrupt handle.
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/dma/idxd/dma.c  |   14 +++++++++----
>  drivers/dma/idxd/idxd.h |    1 +
>  drivers/dma/idxd/irq.c  |   50 +++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 61 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/idxd/dma.c b/drivers/dma/idxd/dma.c
> index 375dbae18583..2ce873994e33 100644
> --- a/drivers/dma/idxd/dma.c
> +++ b/drivers/dma/idxd/dma.c
> @@ -24,18 +24,24 @@ void idxd_dma_complete_txd(struct idxd_desc *desc,
>  			   enum idxd_complete_type comp_type,
>  			   bool free_desc)
>  {
> +	struct idxd_device *idxd = desc->wq->idxd;
>  	struct dma_async_tx_descriptor *tx;
>  	struct dmaengine_result res;
>  	int complete = 1;
>  
> -	if (desc->completion->status == DSA_COMP_SUCCESS)
> +	if (desc->completion->status == DSA_COMP_SUCCESS) {
>  		res.result = DMA_TRANS_NOERROR;
> -	else if (desc->completion->status)
> +	} else if (desc->completion->status) {
> +		if (idxd->request_int_handles && comp_type != IDXD_COMPLETE_ABORT &&
> +		    desc->completion->status == DSA_COMP_INT_HANDLE_INVAL &&
> +		    idxd_queue_int_handle_resubmit(desc))
> +			return;
>  		res.result = DMA_TRANS_WRITE_FAILED;
> -	else if (comp_type == IDXD_COMPLETE_ABORT)
> +	} else if (comp_type == IDXD_COMPLETE_ABORT) {
>  		res.result = DMA_TRANS_ABORTED;
> -	else
> +	} else {
>  		complete = 0;
> +	}
>  
>  	tx = &desc->txd;
>  	if (complete && tx->cookie) {
> diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
> index 970701738c8a..82c4915f58a2 100644
> --- a/drivers/dma/idxd/idxd.h
> +++ b/drivers/dma/idxd/idxd.h
> @@ -524,6 +524,7 @@ void idxd_unregister_devices(struct idxd_device *idxd);
>  int idxd_register_driver(void);
>  void idxd_unregister_driver(void);
>  void idxd_wqs_quiesce(struct idxd_device *idxd);
> +bool idxd_queue_int_handle_resubmit(struct idxd_desc *desc);
>  
>  /* device interrupt control */
>  void idxd_msix_perm_setup(struct idxd_device *idxd);
> diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
> index 8bca0ed2d23c..26fa871934e6 100644
> --- a/drivers/dma/idxd/irq.c
> +++ b/drivers/dma/idxd/irq.c
> @@ -22,6 +22,11 @@ struct idxd_fault {
>  	struct idxd_device *idxd;
>  };
>  
> +struct idxd_resubmit {
> +	struct work_struct work;
> +	struct idxd_desc *desc;
> +};
> +
>  static void idxd_device_reinit(struct work_struct *work)
>  {
>  	struct idxd_device *idxd = container_of(work, struct idxd_device, work);
> @@ -218,6 +223,51 @@ irqreturn_t idxd_misc_thread(int vec, void *data)
>  	return IRQ_HANDLED;
>  }
>  
> +static void idxd_int_handle_resubmit_work(struct work_struct *work)
> +{
> +	struct idxd_resubmit *irw = container_of(work, struct idxd_resubmit, work);
> +	struct idxd_desc *desc = irw->desc;
> +	struct idxd_wq *wq = desc->wq;
> +	int rc;
> +
> +	desc->completion->status = 0;
> +	rc = idxd_submit_desc(wq, desc);
> +	if (rc < 0) {
> +		dev_dbg(&wq->idxd->pdev->dev, "Failed to resubmit desc %d to wq %d.\n",
> +			desc->id, wq->id);
> +		/*
> +		 * If the error is not -EAGAIN, it means the submission failed due to wq
> +		 * has been killed instead of ENQCMDS failure. Here the driver needs to
> +		 * notify the submitter of the failure by reporting abort status.
> +		 *
> +		 * -EAGAIN comes from ENQCMDS failure. idxd_submit_desc() will handle the
> +		 * abort.
> +		 */
> +		if (rc != -EAGAIN) {
> +			desc->completion->status = IDXD_COMP_DESC_ABORT;
> +			idxd_dma_complete_txd(desc, IDXD_COMPLETE_ABORT, false);
> +		}
> +		idxd_free_desc(wq, desc);
> +	}
> +	kfree(irw);
> +}
> +
> +bool idxd_queue_int_handle_resubmit(struct idxd_desc *desc)
> +{
> +	struct idxd_wq *wq = desc->wq;
> +	struct idxd_device *idxd = wq->idxd;
> +	struct idxd_resubmit *irw;
> +
> +	irw = kzalloc(sizeof(*irw), GFP_KERNEL);

What is the context of this function, should this be GFP_ATOMIC?

> +	if (!irw)
> +		return false;
> +
> +	irw->desc = desc;
> +	INIT_WORK(&irw->work, idxd_int_handle_resubmit_work);
> +	queue_work(idxd->wq, &irw->work);
> +	return true;
> +}
> +
>  static void irq_process_pending_llist(struct idxd_irq_entry *irq_entry)
>  {
>  	struct idxd_desc *desc, *t;
> 

-- 
~Vinod
