Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0B45206D52
	for <lists+dmaengine@lfdr.de>; Wed, 24 Jun 2020 09:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389201AbgFXHK2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 Jun 2020 03:10:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:34700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387849AbgFXHK1 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 24 Jun 2020 03:10:27 -0400
Received: from localhost (unknown [171.61.66.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7F14207DD;
        Wed, 24 Jun 2020 07:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592982627;
        bh=gPnriuhkktUuXwuXXm8Wh8xwgaAIaUIkPyz5SM3NLqI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QirBYNrudNa6tBwTgwUlEnEBKAUeBka+C9CXzZVnaAZI/E9J9Jz0/4HUCJFMo72TM
         7tlyK/fxeOK1FQdjR2zyTyDHzY/OWRUtcP9WA5z4XaNlteHZzSTYVfj3p9V7qg98Kb
         rW9mcFqMpOkEmzJa5pMkXq6VHGVkkKzMWcYyMzIM=
Date:   Wed, 24 Jun 2020 12:40:21 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: add work queue drain support
Message-ID: <20200624071021.GH2324254@vkoul-mobl>
References: <159225446067.68253.17223041454769518550.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159225446067.68253.17223041454769518550.stgit@djiang5-desk3.ch.intel.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 15-06-20, 13:54, Dave Jiang wrote:
> Add wq drain support. When a wq is being released, it needs to wait for
> all in-flight operation to complete.  A device control function
> idxd_wq_drain() has been added to facilitate this. A wq drain call
> is added to the char dev on release to make sure all user operations are
> complete. A wq drain is also added before the wq is being disabled.
> 
> A drain command can take an unpredictable period of time. Interrupt support
> for device commands is added to allow waiting on the command to
> finish. If a previous command is in progress, the new submitter can block
> until the current command is finished before proceeding. The interrupt
> based submission will submit the command and then wait until a command
> completion interrupt happens to complete. All commands are moved to the
> interrupt based command submission except for the device reset during
> probe, which will be polled.
> 
> Fixes: 42d279f9137a ("dmaengine: idxd: add char driver to expose submission portal to userland")
> 

no empty line here

> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/dma/idxd/cdev.c   |    3 +
>  drivers/dma/idxd/device.c |  156 ++++++++++++++++++++-------------------------
>  drivers/dma/idxd/idxd.h   |   11 ++-
>  drivers/dma/idxd/init.c   |   14 ++--
>  drivers/dma/idxd/irq.c    |   41 +++++-------
>  drivers/dma/idxd/sysfs.c  |   22 ++----
>  6 files changed, 115 insertions(+), 132 deletions(-)
> 
> diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
> index 207555296913..cd9f01134fd3 100644
> --- a/drivers/dma/idxd/cdev.c
> +++ b/drivers/dma/idxd/cdev.c
> @@ -117,6 +117,9 @@ static int idxd_cdev_release(struct inode *node, struct file *filep)
>  	dev_dbg(dev, "%s called\n", __func__);
>  	filep->private_data = NULL;
>  
> +	/* Wait for in-flight operations to complete. */
> +	idxd_wq_drain(wq);
> +
>  	kfree(ctx);
>  	mutex_lock(&wq->wq_lock);
>  	idxd_wq_put(wq);
> diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
> index f4f64d4678a4..8fe344412bd9 100644
> --- a/drivers/dma/idxd/device.c
> +++ b/drivers/dma/idxd/device.c
> @@ -11,8 +11,8 @@
>  #include "idxd.h"
>  #include "registers.h"
>  
> -static int idxd_cmd_wait(struct idxd_device *idxd, u32 *status, int timeout);
> -static int idxd_cmd_send(struct idxd_device *idxd, int cmd_code, u32 operand);
> +static void idxd_cmd_exec(struct idxd_device *idxd, int cmd_code, u32 operand,
> +			  u32 *status);
>  
>  /* Interrupt control bits */
>  int idxd_mask_msix_vector(struct idxd_device *idxd, int vec_id)
> @@ -235,21 +235,13 @@ int idxd_wq_enable(struct idxd_wq *wq)
>  	struct idxd_device *idxd = wq->idxd;
>  	struct device *dev = &idxd->pdev->dev;
>  	u32 status;
> -	int rc;
> -
> -	lockdep_assert_held(&idxd->dev_lock);
>  
>  	if (wq->state == IDXD_WQ_ENABLED) {
>  		dev_dbg(dev, "WQ %d already enabled\n", wq->id);
>  		return -ENXIO;
>  	}
>  
> -	rc = idxd_cmd_send(idxd, IDXD_CMD_ENABLE_WQ, wq->id);
> -	if (rc < 0)
> -		return rc;
> -	rc = idxd_cmd_wait(idxd, &status, IDXD_REG_TIMEOUT);
> -	if (rc < 0)
> -		return rc;
> +	idxd_cmd_exec(idxd, IDXD_CMD_ENABLE_WQ, wq->id, &status);
>  
>  	if (status != IDXD_CMDSTS_SUCCESS &&
>  	    status != IDXD_CMDSTS_ERR_WQ_ENABLED) {
> @@ -267,9 +259,7 @@ int idxd_wq_disable(struct idxd_wq *wq)
>  	struct idxd_device *idxd = wq->idxd;
>  	struct device *dev = &idxd->pdev->dev;
>  	u32 status, operand;
> -	int rc;
>  
> -	lockdep_assert_held(&idxd->dev_lock);
>  	dev_dbg(dev, "Disabling WQ %d\n", wq->id);
>  
>  	if (wq->state != IDXD_WQ_ENABLED) {
> @@ -278,12 +268,7 @@ int idxd_wq_disable(struct idxd_wq *wq)
>  	}
>  
>  	operand = BIT(wq->id % 16) | ((wq->id / 16) << 16);
> -	rc = idxd_cmd_send(idxd, IDXD_CMD_DISABLE_WQ, operand);
> -	if (rc < 0)
> -		return rc;
> -	rc = idxd_cmd_wait(idxd, &status, IDXD_REG_TIMEOUT);
> -	if (rc < 0)
> -		return rc;
> +	idxd_cmd_exec(idxd, IDXD_CMD_DISABLE_WQ, operand, &status);
>  
>  	if (status != IDXD_CMDSTS_SUCCESS) {
>  		dev_dbg(dev, "WQ disable failed: %#x\n", status);
> @@ -295,6 +280,23 @@ int idxd_wq_disable(struct idxd_wq *wq)
>  	return 0;
>  }
>  
> +void idxd_wq_drain(struct idxd_wq *wq)
> +{
> +	struct idxd_device *idxd = wq->idxd;
> +	struct device *dev = &idxd->pdev->dev;
> +	u32 operand;
> +
> +	if (wq->state != IDXD_WQ_ENABLED) {
> +		dev_dbg(dev, "WQ %d in wrong state: %d\n", wq->id, wq->state);
> +		return;
> +	}
> +
> +	dev_dbg(dev, "Draining WQ %d\n", wq->id);
> +	operand = BIT(wq->id % 16) | ((wq->id / 16) << 16);
> +	idxd_cmd_exec(idxd, IDXD_CMD_DRAIN_WQ, operand, NULL);
> +	dev_dbg(dev, "WQ %d drained\n", wq->id);

too much debug artifacts, pls remove

> +}
> +
>  int idxd_wq_map_portal(struct idxd_wq *wq)
>  {
>  	struct idxd_device *idxd = wq->idxd;
> @@ -356,66 +358,79 @@ static inline bool idxd_is_enabled(struct idxd_device *idxd)
>  	return false;
>  }
>  
> -static int idxd_cmd_wait(struct idxd_device *idxd, u32 *status, int timeout)
> +/*
> + * This is function is only used for reset during probe and will
> + * poll for completion. Once the device is setup with interrupts,
> + * all commands will be done via interrupt completion.
> + */
> +void idxd_device_init_reset(struct idxd_device *idxd)
>  {
> -	u32 sts, to = timeout;
> -
> -	lockdep_assert_held(&idxd->dev_lock);
> -	sts = ioread32(idxd->reg_base + IDXD_CMDSTS_OFFSET);
> -	while (sts & IDXD_CMDSTS_ACTIVE && --to) {
> -		cpu_relax();
> -		sts = ioread32(idxd->reg_base + IDXD_CMDSTS_OFFSET);
> -	}
> +	struct device *dev = &idxd->pdev->dev;
> +	union idxd_command_reg cmd;
> +	unsigned long flags;
>  
> -	if (to == 0 && sts & IDXD_CMDSTS_ACTIVE) {
> -		dev_warn(&idxd->pdev->dev, "%s timed out!\n", __func__);
> -		*status = 0;
> -		return -EBUSY;
> -	}
> +	memset(&cmd, 0, sizeof(cmd));
> +	cmd.cmd = IDXD_CMD_RESET_DEVICE;
> +	dev_dbg(dev, "%s: sending reset for init.\n", __func__);
> +	spin_lock_irqsave(&idxd->dev_lock, flags);
> +	iowrite32(cmd.bits, idxd->reg_base + IDXD_CMD_OFFSET);
>  
> -	*status = sts;
> -	return 0;
> +	while (ioread32(idxd->reg_base + IDXD_CMDSTS_OFFSET) &
> +	       IDXD_CMDSTS_ACTIVE)
> +		cpu_relax();
> +	spin_unlock_irqrestore(&idxd->dev_lock, flags);
>  }
>  
> -static int idxd_cmd_send(struct idxd_device *idxd, int cmd_code, u32 operand)
> +static void idxd_cmd_exec(struct idxd_device *idxd, int cmd_code, u32 operand,
> +			  u32 *status)
>  {
>  	union idxd_command_reg cmd;
> -	int rc;
> -	u32 status;
> -
> -	lockdep_assert_held(&idxd->dev_lock);
> -	rc = idxd_cmd_wait(idxd, &status, IDXD_REG_TIMEOUT);
> -	if (rc < 0)
> -		return rc;
> +	DECLARE_COMPLETION_ONSTACK(done);
> +	unsigned long flags;
>  
>  	memset(&cmd, 0, sizeof(cmd));
>  	cmd.cmd = cmd_code;
>  	cmd.operand = operand;
> +	cmd.int_req = 1;
> +
> +	spin_lock_irqsave(&idxd->dev_lock, flags);
> +	wait_event_lock_irq(idxd->cmd_waitq,
> +			    !test_bit(IDXD_FLAG_CMD_RUNNING, &idxd->flags),
> +			    idxd->dev_lock);
> +
>  	dev_dbg(&idxd->pdev->dev, "%s: sending cmd: %#x op: %#x\n",
>  		__func__, cmd_code, operand);
> +
> +	__set_bit(IDXD_FLAG_CMD_RUNNING, &idxd->flags);
> +	idxd->cmd_done = &done;
>  	iowrite32(cmd.bits, idxd->reg_base + IDXD_CMD_OFFSET);
>  
> -	return 0;
> +	/*
> +	 * After command submitted, release lock and go to sleep until
> +	 * the command completes via interrupt.
> +	 */
> +	spin_unlock_irqrestore(&idxd->dev_lock, flags);
> +	wait_for_completion(&done);

waiting with locks held and interrupts disabled?
-- 
~Vinod
