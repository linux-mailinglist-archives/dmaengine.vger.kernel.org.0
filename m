Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBD6282FE8
	for <lists+dmaengine@lfdr.de>; Mon,  5 Oct 2020 06:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725853AbgJEEzv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 5 Oct 2020 00:55:51 -0400
Received: from mga12.intel.com ([192.55.52.136]:24941 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbgJEEzv (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 5 Oct 2020 00:55:51 -0400
IronPort-SDR: NWAmf0OMciQFBr2m+bT622fFg/xmfLeAEEfV88EiKAE8pkakMCi3FxNoQYiCRX4v+5gQDmIMRc
 UJ4BlYzjNLRQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9764"; a="142718977"
X-IronPort-AV: E=Sophos;i="5.77,338,1596524400"; 
   d="scan'208";a="142718977"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2020 21:55:47 -0700
IronPort-SDR: jKtP316VucJ4hrRkuLzp+CDpM/XDD7Vs9n2QwiP00JDzRnmpZqRS+uZjMYxQl+/NUjpp3fatH6
 vYl6fWmufDfw==
X-IronPort-AV: E=Sophos;i="5.77,338,1596524400"; 
   d="scan'208";a="347170264"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.213.183.74]) ([10.213.183.74])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2020 21:55:42 -0700
Subject: Re: [PATCH v6 4/5] dmaengine: idxd: Clean up descriptors with fault
 error
To:     Vinod Koul <vkoul@kernel.org>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dan.j.williams@intel.com, tony.luck@intel.com, jing.lin@intel.com,
        ashok.raj@intel.com, sanjay.k.kumar@intel.com,
        fenghua.yu@intel.com, kevin.tian@intel.com,
        David.Laight@aculab.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200924180041.34056-1-dave.jiang@intel.com>
 <20200924180041.34056-5-dave.jiang@intel.com>
 <20201005044213.GF2968@vkoul-mobl>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <47c6fa6b-8bbe-ee9d-e6e0-b27d8828a6d9@intel.com>
Date:   Sun, 4 Oct 2020 21:55:40 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201005044213.GF2968@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 10/4/2020 9:42 PM, Vinod Koul wrote:
> On 24-09-20, 11:00, Dave Jiang wrote:
>> Add code to "complete" a descriptor when the descriptor or its completion
>> address hit a fault error when SVA mode is being used. This error can be
>> triggered due to bad programming by the user. A lock is introduced in order
>> to protect the descriptor completion lists since the fault handler will run
>> from the system work queue after being scheduled in the interrupt handler.
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> Reviewed-by: Tony Luck <tony.luck@intel.com>
>> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>> ---
>>   drivers/dma/idxd/idxd.h |   5 ++
>>   drivers/dma/idxd/init.c |   1 +
>>   drivers/dma/idxd/irq.c  | 143 ++++++++++++++++++++++++++++++++++++----
>>   3 files changed, 137 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
>> index 43a216c42d25..b64b6266ca97 100644
>> --- a/drivers/dma/idxd/idxd.h
>> +++ b/drivers/dma/idxd/idxd.h
>> @@ -34,6 +34,11 @@ struct idxd_irq_entry {
>>   	int id;
>>   	struct llist_head pending_llist;
>>   	struct list_head work_list;
>> +	/*
>> +	 * Lock to protect access between irq thread process descriptor
>> +	 * and irq thread processing error descriptor.
>> +	 */
>> +	spinlock_t list_lock;
>>   };
>>   
>>   struct idxd_group {
>> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
>> index 626401a71fdd..1bb7637b02eb 100644
>> --- a/drivers/dma/idxd/init.c
>> +++ b/drivers/dma/idxd/init.c
>> @@ -97,6 +97,7 @@ static int idxd_setup_interrupts(struct idxd_device *idxd)
>>   	for (i = 0; i < msixcnt; i++) {
>>   		idxd->irq_entries[i].id = i;
>>   		idxd->irq_entries[i].idxd = idxd;
>> +		spin_lock_init(&idxd->irq_entries[i].list_lock);
>>   	}
>>   
>>   	msix = &idxd->msix_entries[0];
>> diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
>> index 17a65a13fb64..9e6cc55ad22f 100644
>> --- a/drivers/dma/idxd/irq.c
>> +++ b/drivers/dma/idxd/irq.c
>> @@ -11,6 +11,24 @@
>>   #include "idxd.h"
>>   #include "registers.h"
>>   
>> +enum irq_work_type {
>> +	IRQ_WORK_NORMAL = 0,
>> +	IRQ_WORK_PROCESS_FAULT,
>> +};
>> +
>> +struct idxd_fault {
>> +	struct work_struct work;
>> +	u64 addr;
>> +	struct idxd_device *idxd;
>> +};
>> +
>> +static int irq_process_work_list(struct idxd_irq_entry *irq_entry,
>> +				 enum irq_work_type wtype,
>> +				 int *processed, u64 data);
>> +static int irq_process_pending_llist(struct idxd_irq_entry *irq_entry,
>> +				     enum irq_work_type wtype,
>> +				     int *processed, u64 data);
>> +
>>   static void idxd_device_reinit(struct work_struct *work)
>>   {
>>   	struct idxd_device *idxd = container_of(work, struct idxd_device, work);
>> @@ -44,6 +62,46 @@ static void idxd_device_reinit(struct work_struct *work)
>>   	idxd_device_wqs_clear_state(idxd);
>>   }
>>   
>> +static void idxd_device_fault_work(struct work_struct *work)
>> +{
>> +	struct idxd_fault *fault = container_of(work, struct idxd_fault, work);
>> +	struct idxd_irq_entry *ie;
>> +	int i;
>> +	int processed;
>> +	int irqcnt = fault->idxd->num_wq_irqs + 1;
>> +
>> +	for (i = 1; i < irqcnt; i++) {
>> +		ie = &fault->idxd->irq_entries[i];
>> +		irq_process_work_list(ie, IRQ_WORK_PROCESS_FAULT,
>> +				      &processed, fault->addr);
>> +		if (processed)
>> +			break;
>> +
>> +		irq_process_pending_llist(ie, IRQ_WORK_PROCESS_FAULT,
>> +					  &processed, fault->addr);
>> +		if (processed)
>> +			break;
>> +	}
>> +
>> +	kfree(fault);
>> +}
>> +
>> +static int idxd_device_schedule_fault_process(struct idxd_device *idxd,
>> +					      u64 fault_addr)
>> +{
>> +	struct idxd_fault *fault;
>> +
>> +	fault = kmalloc(sizeof(*fault), GFP_ATOMIC);
>> +	if (!fault)
>> +		return -ENOMEM;
>> +
>> +	fault->addr = fault_addr;
>> +	fault->idxd = idxd;
>> +	INIT_WORK(&fault->work, idxd_device_fault_work);
>> +	queue_work(idxd->wq, &fault->work);
>> +	return 0;
>> +}
>> +
>>   irqreturn_t idxd_irq_handler(int vec, void *data)
>>   {
>>   	struct idxd_irq_entry *irq_entry = data;
>> @@ -125,6 +183,16 @@ irqreturn_t idxd_misc_thread(int vec, void *data)
>>   	if (!err)
>>   		goto out;
>>   
>> +	/*
>> +	 * This case should rarely happen and typically is due to software
>> +	 * programming error by the driver.
>> +	 */
>> +	if (idxd->sw_err.valid &&
>> +	    idxd->sw_err.desc_valid &&
>> +	    idxd->sw_err.fault_addr)
>> +		idxd_device_schedule_fault_process(idxd,
>> +						   idxd->sw_err.fault_addr);
> 
> This should fit in a single line ;)

Yes. With the new 100 col guideline this should be single line.

> 
>> +
>>   	gensts.bits = ioread32(idxd->reg_base + IDXD_GENSTATS_OFFSET);
>>   	if (gensts.state == IDXD_DEVICE_STATE_HALT) {
>>   		idxd->state = IDXD_DEV_HALTED;
>> @@ -152,57 +220,106 @@ irqreturn_t idxd_misc_thread(int vec, void *data)
>>   	return IRQ_HANDLED;
>>   }
>>   
>> +static bool process_fault(struct idxd_desc *desc, u64 fault_addr)
>> +{
>> +	if ((u64)desc->hw == fault_addr ||
>> +	    (u64)desc->completion == fault_addr) {
> 
> you are casting descriptor address and completion, I can understand
> former, but later..? Can you explain this please
> 

It is possible to fail on the completion writeback address if the completion 
address programmed into the descriptor is bad.

