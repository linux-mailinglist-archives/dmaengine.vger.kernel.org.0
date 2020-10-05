Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6BBD282FAE
	for <lists+dmaengine@lfdr.de>; Mon,  5 Oct 2020 06:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725857AbgJEEmT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 5 Oct 2020 00:42:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:51342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbgJEEmT (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 5 Oct 2020 00:42:19 -0400
Received: from localhost (unknown [171.61.67.142])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49A1F2080C;
        Mon,  5 Oct 2020 04:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601872938;
        bh=OkM3YVc0/tncaspLjohAk4nF73ui6KcGWNkJMSMAF2w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ycUf8nrDyFMzLWMuxk4JNJq6CN8vDI6uHHR5TB2zZ7AZ236pN+kzCcKQLjHVU/78o
         7dCLl5TAG8jr9atkM+wma/I2cT0BDbyHXvkKzWvxXJ0LVPr8NycBoVAV24OqyAND1y
         zqMrCmX1wrns9jHUu4Nf7L/LKQTKkTzt+mf9nPis=
Date:   Mon, 5 Oct 2020 10:12:13 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dan.j.williams@intel.com, tony.luck@intel.com, jing.lin@intel.com,
        ashok.raj@intel.com, sanjay.k.kumar@intel.com,
        fenghua.yu@intel.com, kevin.tian@intel.com,
        David.Laight@aculab.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/5] dmaengine: idxd: Clean up descriptors with fault
 error
Message-ID: <20201005044213.GF2968@vkoul-mobl>
References: <20200924180041.34056-1-dave.jiang@intel.com>
 <20200924180041.34056-5-dave.jiang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924180041.34056-5-dave.jiang@intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 24-09-20, 11:00, Dave Jiang wrote:
> Add code to "complete" a descriptor when the descriptor or its completion
> address hit a fault error when SVA mode is being used. This error can be
> triggered due to bad programming by the user. A lock is introduced in order
> to protect the descriptor completion lists since the fault handler will run
> from the system work queue after being scheduled in the interrupt handler.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/dma/idxd/idxd.h |   5 ++
>  drivers/dma/idxd/init.c |   1 +
>  drivers/dma/idxd/irq.c  | 143 ++++++++++++++++++++++++++++++++++++----
>  3 files changed, 137 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
> index 43a216c42d25..b64b6266ca97 100644
> --- a/drivers/dma/idxd/idxd.h
> +++ b/drivers/dma/idxd/idxd.h
> @@ -34,6 +34,11 @@ struct idxd_irq_entry {
>  	int id;
>  	struct llist_head pending_llist;
>  	struct list_head work_list;
> +	/*
> +	 * Lock to protect access between irq thread process descriptor
> +	 * and irq thread processing error descriptor.
> +	 */
> +	spinlock_t list_lock;
>  };
>  
>  struct idxd_group {
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index 626401a71fdd..1bb7637b02eb 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -97,6 +97,7 @@ static int idxd_setup_interrupts(struct idxd_device *idxd)
>  	for (i = 0; i < msixcnt; i++) {
>  		idxd->irq_entries[i].id = i;
>  		idxd->irq_entries[i].idxd = idxd;
> +		spin_lock_init(&idxd->irq_entries[i].list_lock);
>  	}
>  
>  	msix = &idxd->msix_entries[0];
> diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
> index 17a65a13fb64..9e6cc55ad22f 100644
> --- a/drivers/dma/idxd/irq.c
> +++ b/drivers/dma/idxd/irq.c
> @@ -11,6 +11,24 @@
>  #include "idxd.h"
>  #include "registers.h"
>  
> +enum irq_work_type {
> +	IRQ_WORK_NORMAL = 0,
> +	IRQ_WORK_PROCESS_FAULT,
> +};
> +
> +struct idxd_fault {
> +	struct work_struct work;
> +	u64 addr;
> +	struct idxd_device *idxd;
> +};
> +
> +static int irq_process_work_list(struct idxd_irq_entry *irq_entry,
> +				 enum irq_work_type wtype,
> +				 int *processed, u64 data);
> +static int irq_process_pending_llist(struct idxd_irq_entry *irq_entry,
> +				     enum irq_work_type wtype,
> +				     int *processed, u64 data);
> +
>  static void idxd_device_reinit(struct work_struct *work)
>  {
>  	struct idxd_device *idxd = container_of(work, struct idxd_device, work);
> @@ -44,6 +62,46 @@ static void idxd_device_reinit(struct work_struct *work)
>  	idxd_device_wqs_clear_state(idxd);
>  }
>  
> +static void idxd_device_fault_work(struct work_struct *work)
> +{
> +	struct idxd_fault *fault = container_of(work, struct idxd_fault, work);
> +	struct idxd_irq_entry *ie;
> +	int i;
> +	int processed;
> +	int irqcnt = fault->idxd->num_wq_irqs + 1;
> +
> +	for (i = 1; i < irqcnt; i++) {
> +		ie = &fault->idxd->irq_entries[i];
> +		irq_process_work_list(ie, IRQ_WORK_PROCESS_FAULT,
> +				      &processed, fault->addr);
> +		if (processed)
> +			break;
> +
> +		irq_process_pending_llist(ie, IRQ_WORK_PROCESS_FAULT,
> +					  &processed, fault->addr);
> +		if (processed)
> +			break;
> +	}
> +
> +	kfree(fault);
> +}
> +
> +static int idxd_device_schedule_fault_process(struct idxd_device *idxd,
> +					      u64 fault_addr)
> +{
> +	struct idxd_fault *fault;
> +
> +	fault = kmalloc(sizeof(*fault), GFP_ATOMIC);
> +	if (!fault)
> +		return -ENOMEM;
> +
> +	fault->addr = fault_addr;
> +	fault->idxd = idxd;
> +	INIT_WORK(&fault->work, idxd_device_fault_work);
> +	queue_work(idxd->wq, &fault->work);
> +	return 0;
> +}
> +
>  irqreturn_t idxd_irq_handler(int vec, void *data)
>  {
>  	struct idxd_irq_entry *irq_entry = data;
> @@ -125,6 +183,16 @@ irqreturn_t idxd_misc_thread(int vec, void *data)
>  	if (!err)
>  		goto out;
>  
> +	/*
> +	 * This case should rarely happen and typically is due to software
> +	 * programming error by the driver.
> +	 */
> +	if (idxd->sw_err.valid &&
> +	    idxd->sw_err.desc_valid &&
> +	    idxd->sw_err.fault_addr)
> +		idxd_device_schedule_fault_process(idxd,
> +						   idxd->sw_err.fault_addr);

This should fit in a single line ;)

> +
>  	gensts.bits = ioread32(idxd->reg_base + IDXD_GENSTATS_OFFSET);
>  	if (gensts.state == IDXD_DEVICE_STATE_HALT) {
>  		idxd->state = IDXD_DEV_HALTED;
> @@ -152,57 +220,106 @@ irqreturn_t idxd_misc_thread(int vec, void *data)
>  	return IRQ_HANDLED;
>  }
>  
> +static bool process_fault(struct idxd_desc *desc, u64 fault_addr)
> +{
> +	if ((u64)desc->hw == fault_addr ||
> +	    (u64)desc->completion == fault_addr) {

you are casting descriptor address and completion, I can understand
former, but later..? Can you explain this please

-- 
~Vinod
