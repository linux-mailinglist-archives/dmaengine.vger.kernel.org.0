Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5D6438E9B
	for <lists+dmaengine@lfdr.de>; Mon, 25 Oct 2021 07:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbhJYFJO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 25 Oct 2021 01:09:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:59046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229678AbhJYFJN (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 25 Oct 2021 01:09:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1A67960EE3;
        Mon, 25 Oct 2021 05:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635138412;
        bh=iLk7XdDpZBVlm8yA+gdw2mmh7NqFZmVTD3GCpW5/bYY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OgpYodVui6KQS1SIJAwTl3/CaWBt/XGpXfQKZbT3mpb90tA2cM0Y3cemb7ngz0Okx
         AlHiITgNZl4WqXrsQpIRxUXwB9L+0JFrrdKj0czXHtZFiFk/h/zbMxYhZ+91WX10Ay
         CSB9aifEh36Q8RtSr2YdHrR4tL99iLE+SSvWK8jOLIos+OdoKXGGPDCu3Begs6ZKiw
         yB25oxHL//H3p+mPAfhfgSBw015V+NlECHU7NRQyLS09citftMZ9StbqSelqkx93dM
         wC7ylW6jkROYyFSG2Pz0muEV2iszo3gBeJ2vHwgV8s+hEQt5XlnIlIcSU1n94v7cxS
         reSWp1fQ/qi6w==
Date:   Mon, 25 Oct 2021 10:36:47 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Kevin Tian <kevin.tian@intel.com>, dmaengine@vger.kernel.org
Subject: Re: [PATCH 4/7] dmaengine: idxd: add helper for per interrupt handle
 drain
Message-ID: <YXY7Zy/g/jrSDuFD@matsya>
References: <163474864017.2608004.10983485368237365990.stgit@djiang5-desk3.ch.intel.com>
 <163474883845.2608004.9330596081850512248.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163474883845.2608004.9330596081850512248.stgit@djiang5-desk3.ch.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 20-10-21, 09:53, Dave Jiang wrote:
> The helper is called at the completion of the interrupt handle refresh
> event. It issues drain descriptors to each of the wq with associated
> interrupt handle. The drain descriptor will have interrupt request set but
> without completion record. This will ensure all descriptors with incorrect
> interrupt completion handle get drained and a completion interrupt is
> triggered for the guest driver to process them.
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/dma/idxd/irq.c |   41 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
> index 573a2f6d0f7f..8bca0ed2d23c 100644
> --- a/drivers/dma/idxd/irq.c
> +++ b/drivers/dma/idxd/irq.c
> @@ -55,6 +55,47 @@ static void idxd_device_reinit(struct work_struct *work)
>  	idxd_device_clear_state(idxd);
>  }
>  
> +/*
> + * The function sends a drain descriptor for the interrupt handle. The drain ensures
> + * all descriptors with this interrupt handle is flushed and the interrupt
> + * will allow the cleanup of the outstanding descriptors.
> + */
> +static void idxd_int_handle_revoke_drain(struct idxd_irq_entry *ie)
> +{
> +	struct idxd_wq *wq = ie->wq;
> +	struct idxd_device *idxd = ie->idxd;
> +	struct device *dev = &idxd->pdev->dev;
> +	struct dsa_hw_desc desc;
> +	void __iomem *portal;
> +	int rc;
> +
> +	memset(&desc, 0, sizeof(desc));

declare and init it and avoid the memset:
        struct dsa_hw_desc desc = {};

> +
> +	/* Issue a simple drain operation with interrupt but no completion record */
> +	desc.flags = IDXD_OP_FLAG_RCI;
> +	desc.opcode = DSA_OPCODE_DRAIN;
> +	desc.priv = 1;
> +
> +	if (ie->pasid != INVALID_IOASID)
> +		desc.pasid = ie->pasid;
> +	desc.int_handle = ie->int_handle;
> +	portal = idxd_wq_portal_addr(wq);
> +
> +	/*
> +	 * The wmb() makes sure that the descriptor is all there before we
> +	 * issue.
> +	 */
> +	wmb();
> +	if (wq_dedicated(wq)) {
> +		iosubmit_cmds512(portal, &desc, 1);
> +	} else {
> +		rc = enqcmds(portal, &desc);
> +		/* This should not fail unless hardware failed. */
> +		if (rc < 0)
> +			dev_warn(dev, "Failed to submit drain desc on wq %d\n", wq->id);
> +	}
> +}
> +
>  static int process_misc_interrupts(struct idxd_device *idxd, u32 cause)
>  {
>  	struct device *dev = &idxd->pdev->dev;
> 

-- 
~Vinod
