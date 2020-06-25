Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E93EE20985F
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jun 2020 04:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389070AbgFYCFO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 Jun 2020 22:05:14 -0400
Received: from mga05.intel.com ([192.55.52.43]:17499 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389136AbgFYCFN (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 24 Jun 2020 22:05:13 -0400
IronPort-SDR: mK5VHYsLkpSpdBg2bI2L5WE8BKqBWQV/bC54wjMqhg9Gq29rQKa0odCpr+roDa769BqWFIP+x2
 obhbXIv8g0qQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9662"; a="229418954"
X-IronPort-AV: E=Sophos;i="5.75,277,1589266800"; 
   d="scan'208";a="229418954"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2020 19:05:05 -0700
IronPort-SDR: 8NgWKPwsAPf6h/00mFxqZB733Ob673C61Tu5v6mqWdViNfDwHJtzo+5BjDvlWT9RierD5pBv4E
 JPp6nKhIvALQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,277,1589266800"; 
   d="scan'208";a="265231801"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.251.31.242]) ([10.251.31.242])
  by fmsmga008.fm.intel.com with ESMTP; 24 Jun 2020 19:05:05 -0700
Subject: Re: [PATCH] dmaengine: idxd: add work queue drain support
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org
References: <159225446067.68253.17223041454769518550.stgit@djiang5-desk3.ch.intel.com>
 <20200624071021.GH2324254@vkoul-mobl>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <3e7e4d8c-3f74-326b-ff3d-f1ec4542817f@intel.com>
Date:   Wed, 24 Jun 2020 19:05:05 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200624071021.GH2324254@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 6/24/2020 12:10 AM, Vinod Koul wrote:
> On 15-06-20, 13:54, Dave Jiang wrote:
>> Add wq drain support. When a wq is being released, it needs to wait for
>> all in-flight operation to complete.  A device control function
>> idxd_wq_drain() has been added to facilitate this. A wq drain call
>> is added to the char dev on release to make sure all user operations are
>> complete. A wq drain is also added before the wq is being disabled.
>>
>> A drain command can take an unpredictable period of time. Interrupt support
>> for device commands is added to allow waiting on the command to
>> finish. If a previous command is in progress, the new submitter can block
>> until the current command is finished before proceeding. The interrupt
>> based submission will submit the command and then wait until a command
>> completion interrupt happens to complete. All commands are moved to the
>> interrupt based command submission except for the device reset during
>> probe, which will be polled.
>>
>> Fixes: 42d279f9137a ("dmaengine: idxd: add char driver to expose submission portal to userland")
>>
> 
> no empty line here
> 
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> Reviewed-by: Tony Luck <tony.luck@intel.com>
>> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>> ---
>>   drivers/dma/idxd/cdev.c   |    3 +
>>   drivers/dma/idxd/device.c |  156 ++++++++++++++++++++-------------------------
>>   drivers/dma/idxd/idxd.h   |   11 ++-
>>   drivers/dma/idxd/init.c   |   14 ++--
>>   drivers/dma/idxd/irq.c    |   41 +++++-------
>>   drivers/dma/idxd/sysfs.c  |   22 ++----
>>   6 files changed, 115 insertions(+), 132 deletions(-)
>>
>> diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
>> index 207555296913..cd9f01134fd3 100644
>> --- a/drivers/dma/idxd/cdev.c
>> +++ b/drivers/dma/idxd/cdev.c
>> @@ -117,6 +117,9 @@ static int idxd_cdev_release(struct inode *node, struct file *filep)
>>   	dev_dbg(dev, "%s called\n", __func__);
>>   	filep->private_data = NULL;
>>   
>> +	/* Wait for in-flight operations to complete. */
>> +	idxd_wq_drain(wq);
>> +
>>   	kfree(ctx);
>>   	mutex_lock(&wq->wq_lock);
>>   	idxd_wq_put(wq);
>> diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
>> index f4f64d4678a4..8fe344412bd9 100644
>> --- a/drivers/dma/idxd/device.c
>> +++ b/drivers/dma/idxd/device.c
>> @@ -11,8 +11,8 @@
>>   #include "idxd.h"
>>   #include "registers.h"
>>   
>> -static int idxd_cmd_wait(struct idxd_device *idxd, u32 *status, int timeout);
>> -static int idxd_cmd_send(struct idxd_device *idxd, int cmd_code, u32 operand);
>> +static void idxd_cmd_exec(struct idxd_device *idxd, int cmd_code, u32 operand,
>> +			  u32 *status);
>>   
>>   /* Interrupt control bits */
>>   int idxd_mask_msix_vector(struct idxd_device *idxd, int vec_id)
>> @@ -235,21 +235,13 @@ int idxd_wq_enable(struct idxd_wq *wq)
>>   	struct idxd_device *idxd = wq->idxd;
>>   	struct device *dev = &idxd->pdev->dev;
>>   	u32 status;
>> -	int rc;
>> -
>> -	lockdep_assert_held(&idxd->dev_lock);
>>   
>>   	if (wq->state == IDXD_WQ_ENABLED) {
>>   		dev_dbg(dev, "WQ %d already enabled\n", wq->id);
>>   		return -ENXIO;
>>   	}
>>   
>> -	rc = idxd_cmd_send(idxd, IDXD_CMD_ENABLE_WQ, wq->id);
>> -	if (rc < 0)
>> -		return rc;
>> -	rc = idxd_cmd_wait(idxd, &status, IDXD_REG_TIMEOUT);
>> -	if (rc < 0)
>> -		return rc;
>> +	idxd_cmd_exec(idxd, IDXD_CMD_ENABLE_WQ, wq->id, &status);
>>   
>>   	if (status != IDXD_CMDSTS_SUCCESS &&
>>   	    status != IDXD_CMDSTS_ERR_WQ_ENABLED) {
>> @@ -267,9 +259,7 @@ int idxd_wq_disable(struct idxd_wq *wq)
>>   	struct idxd_device *idxd = wq->idxd;
>>   	struct device *dev = &idxd->pdev->dev;
>>   	u32 status, operand;
>> -	int rc;
>>   
>> -	lockdep_assert_held(&idxd->dev_lock);
>>   	dev_dbg(dev, "Disabling WQ %d\n", wq->id);
>>   
>>   	if (wq->state != IDXD_WQ_ENABLED) {
>> @@ -278,12 +268,7 @@ int idxd_wq_disable(struct idxd_wq *wq)
>>   	}
>>   
>>   	operand = BIT(wq->id % 16) | ((wq->id / 16) << 16);
>> -	rc = idxd_cmd_send(idxd, IDXD_CMD_DISABLE_WQ, operand);
>> -	if (rc < 0)
>> -		return rc;
>> -	rc = idxd_cmd_wait(idxd, &status, IDXD_REG_TIMEOUT);
>> -	if (rc < 0)
>> -		return rc;
>> +	idxd_cmd_exec(idxd, IDXD_CMD_DISABLE_WQ, operand, &status);
>>   
>>   	if (status != IDXD_CMDSTS_SUCCESS) {
>>   		dev_dbg(dev, "WQ disable failed: %#x\n", status);
>> @@ -295,6 +280,23 @@ int idxd_wq_disable(struct idxd_wq *wq)
>>   	return 0;
>>   }
>>   
>> +void idxd_wq_drain(struct idxd_wq *wq)
>> +{
>> +	struct idxd_device *idxd = wq->idxd;
>> +	struct device *dev = &idxd->pdev->dev;
>> +	u32 operand;
>> +
>> +	if (wq->state != IDXD_WQ_ENABLED) {
>> +		dev_dbg(dev, "WQ %d in wrong state: %d\n", wq->id, wq->state);
>> +		return;
>> +	}
>> +
>> +	dev_dbg(dev, "Draining WQ %d\n", wq->id);
>> +	operand = BIT(wq->id % 16) | ((wq->id / 16) << 16);
>> +	idxd_cmd_exec(idxd, IDXD_CMD_DRAIN_WQ, operand, NULL);
>> +	dev_dbg(dev, "WQ %d drained\n", wq->id);
> 
> too much debug artifacts, pls remove

Will fix

> 
>> +}
>> +
>>   int idxd_wq_map_portal(struct idxd_wq *wq)
>>   {
>>   	struct idxd_device *idxd = wq->idxd;
>> @@ -356,66 +358,79 @@ static inline bool idxd_is_enabled(struct idxd_device *idxd)
>>   	return false;
>>   }
>>   
>> -static int idxd_cmd_wait(struct idxd_device *idxd, u32 *status, int timeout)
>> +/*
>> + * This is function is only used for reset during probe and will
>> + * poll for completion. Once the device is setup with interrupts,
>> + * all commands will be done via interrupt completion.
>> + */
>> +void idxd_device_init_reset(struct idxd_device *idxd)
>>   {
>> -	u32 sts, to = timeout;
>> -
>> -	lockdep_assert_held(&idxd->dev_lock);
>> -	sts = ioread32(idxd->reg_base + IDXD_CMDSTS_OFFSET);
>> -	while (sts & IDXD_CMDSTS_ACTIVE && --to) {
>> -		cpu_relax();
>> -		sts = ioread32(idxd->reg_base + IDXD_CMDSTS_OFFSET);
>> -	}
>> +	struct device *dev = &idxd->pdev->dev;
>> +	union idxd_command_reg cmd;
>> +	unsigned long flags;
>>   
>> -	if (to == 0 && sts & IDXD_CMDSTS_ACTIVE) {
>> -		dev_warn(&idxd->pdev->dev, "%s timed out!\n", __func__);
>> -		*status = 0;
>> -		return -EBUSY;
>> -	}
>> +	memset(&cmd, 0, sizeof(cmd));
>> +	cmd.cmd = IDXD_CMD_RESET_DEVICE;
>> +	dev_dbg(dev, "%s: sending reset for init.\n", __func__);
>> +	spin_lock_irqsave(&idxd->dev_lock, flags);
>> +	iowrite32(cmd.bits, idxd->reg_base + IDXD_CMD_OFFSET);
>>   
>> -	*status = sts;
>> -	return 0;
>> +	while (ioread32(idxd->reg_base + IDXD_CMDSTS_OFFSET) &
>> +	       IDXD_CMDSTS_ACTIVE)
>> +		cpu_relax();
>> +	spin_unlock_irqrestore(&idxd->dev_lock, flags);
>>   }
>>   
>> -static int idxd_cmd_send(struct idxd_device *idxd, int cmd_code, u32 operand)
>> +static void idxd_cmd_exec(struct idxd_device *idxd, int cmd_code, u32 operand,
>> +			  u32 *status)
>>   {
>>   	union idxd_command_reg cmd;
>> -	int rc;
>> -	u32 status;
>> -
>> -	lockdep_assert_held(&idxd->dev_lock);
>> -	rc = idxd_cmd_wait(idxd, &status, IDXD_REG_TIMEOUT);
>> -	if (rc < 0)
>> -		return rc;
>> +	DECLARE_COMPLETION_ONSTACK(done);
>> +	unsigned long flags;
>>   
>>   	memset(&cmd, 0, sizeof(cmd));
>>   	cmd.cmd = cmd_code;
>>   	cmd.operand = operand;
>> +	cmd.int_req = 1;
>> +
>> +	spin_lock_irqsave(&idxd->dev_lock, flags);
>> +	wait_event_lock_irq(idxd->cmd_waitq,
>> +			    !test_bit(IDXD_FLAG_CMD_RUNNING, &idxd->flags),
>> +			    idxd->dev_lock);
>> +
>>   	dev_dbg(&idxd->pdev->dev, "%s: sending cmd: %#x op: %#x\n",
>>   		__func__, cmd_code, operand);
>> +
>> +	__set_bit(IDXD_FLAG_CMD_RUNNING, &idxd->flags);
>> +	idxd->cmd_done = &done;
>>   	iowrite32(cmd.bits, idxd->reg_base + IDXD_CMD_OFFSET);
>>   
>> -	return 0;
>> +	/*
>> +	 * After command submitted, release lock and go to sleep until
>> +	 * the command completes via interrupt.
>> +	 */
>> +	spin_unlock_irqrestore(&idxd->dev_lock, flags);
>> +	wait_for_completion(&done);
> 
> waiting with locks held and interrupts disabled? >

No we release lock here before we wait. And it gets re-acquired once we are 
woken up.

