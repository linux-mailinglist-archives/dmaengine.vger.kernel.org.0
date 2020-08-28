Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4735B255C82
	for <lists+dmaengine@lfdr.de>; Fri, 28 Aug 2020 16:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgH1Obi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 28 Aug 2020 10:31:38 -0400
Received: from mga06.intel.com ([134.134.136.31]:59632 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726400AbgH1Obh (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 28 Aug 2020 10:31:37 -0400
IronPort-SDR: P6fyv2FZrdFQriYGkG7xwChThsx4ZQ5AQ5q1tbGlY5AXESlkn/IOe45kGwClGlUF37N8t+vBsX
 jtUNxDFbG0wA==
X-IronPort-AV: E=McAfee;i="6000,8403,9726"; a="218222561"
X-IronPort-AV: E=Sophos;i="5.76,364,1592895600"; 
   d="scan'208";a="218222561"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2020 07:31:36 -0700
IronPort-SDR: BhDktNtynDwVDxGIxIXdMCqby8wgFuPmDmlDyl+bxsIe5kiar/VCNGzwDuJpdFmK+vg9EDFxsD
 01fy5R730bvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,364,1592895600"; 
   d="scan'208";a="332559168"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.251.152.119]) ([10.251.152.119])
  by fmsmga002.fm.intel.com with ESMTP; 28 Aug 2020 07:31:36 -0700
Subject: Re: [PATCH] dmaengine: idxd: add command status to idxd sysfs
 attribute
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org
References: <159856348828.3418.7745506843326238999.stgit@djiang5-desk3.ch.intel.com>
 <20200828104255.GS2639@vkoul-mobl>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <c94d48a8-9aa6-ff48-b3ef-266bcc7705fc@intel.com>
Date:   Fri, 28 Aug 2020 07:31:35 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200828104255.GS2639@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 8/28/2020 3:42 AM, Vinod Koul wrote:
> On 27-08-20, 14:24, Dave Jiang wrote:
>> Export admin command status to sysfs attribute in order to allow user to
>> retrieve configuration error. Allows user tooling to retrieve the command
>> error and provide more user friendly error messages.
>>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>   drivers/dma/idxd/device.c |    6 +++++-
>>   drivers/dma/idxd/idxd.h   |    1 +
>>   drivers/dma/idxd/sysfs.c  |   10 ++++++++++
>>   3 files changed, 16 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
>> index 00dab1465ca3..bdca1bc55cfa 100644
>> --- a/drivers/dma/idxd/device.c
>> +++ b/drivers/dma/idxd/device.c
>> @@ -368,6 +368,7 @@ static void idxd_cmd_exec(struct idxd_device *idxd, int cmd_code, u32 operand,
>>   	dev_dbg(&idxd->pdev->dev, "%s: sending cmd: %#x op: %#x\n",
>>   		__func__, cmd_code, operand);
>>   
>> +	idxd->cmd_status = 0;
>>   	__set_bit(IDXD_FLAG_CMD_RUNNING, &idxd->flags);
>>   	idxd->cmd_done = &done;
>>   	iowrite32(cmd.bits, idxd->reg_base + IDXD_CMD_OFFSET);
>> @@ -379,8 +380,11 @@ static void idxd_cmd_exec(struct idxd_device *idxd, int cmd_code, u32 operand,
>>   	spin_unlock_irqrestore(&idxd->dev_lock, flags);
>>   	wait_for_completion(&done);
>>   	spin_lock_irqsave(&idxd->dev_lock, flags);
>> -	if (status)
>> +	if (status) {
>>   		*status = ioread32(idxd->reg_base + IDXD_CMDSTS_OFFSET);
>> +		idxd->cmd_status = *status & 0xff;
> 
> define the magic 0xff and use GENMASK to define that!

Ok will do.

> 
>> +	}
>> +
>>   	__clear_bit(IDXD_FLAG_CMD_RUNNING, &idxd->flags);
>>   	/* Wake up other pending commands */
>>   	wake_up(&idxd->cmd_waitq);
>> diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
>> index e8bec6eb9f7e..c64df197e724 100644
>> --- a/drivers/dma/idxd/idxd.h
>> +++ b/drivers/dma/idxd/idxd.h
>> @@ -156,6 +156,7 @@ struct idxd_device {
>>   	unsigned long flags;
>>   	int id;
>>   	int major;
>> +	u8 cmd_status;
>>   
>>   	struct pci_dev *pdev;
>>   	void __iomem *reg_base;
>> diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
>> index c5f19802cb9e..1db8d021f5ae 100644
>> --- a/drivers/dma/idxd/sysfs.c
>> +++ b/drivers/dma/idxd/sysfs.c
>> @@ -1395,6 +1395,15 @@ static ssize_t cdev_major_show(struct device *dev,
>>   }
>>   static DEVICE_ATTR_RO(cdev_major);
>>   
>> +static ssize_t cmd_status_show(struct device *dev,
>> +			       struct device_attribute *attr, char *buf)
>> +{
>> +	struct idxd_device *idxd = container_of(dev, struct idxd_device, conf_dev);
>> +
>> +	return sprintf(buf, "%#x\n", idxd->cmd_status);
>> +}
>> +static DEVICE_ATTR_RO(cmd_status);
> 
> Update ABI docs for this?
> 

Yes

>> +
>>   static struct attribute *idxd_device_attributes[] = {
>>   	&dev_attr_version.attr,
>>   	&dev_attr_max_groups.attr,
>> @@ -1413,6 +1422,7 @@ static struct attribute *idxd_device_attributes[] = {
>>   	&dev_attr_max_tokens.attr,
>>   	&dev_attr_token_limit.attr,
>>   	&dev_attr_cdev_major.attr,
>> +	&dev_attr_cmd_status.attr,
>>   	NULL,
>>   };
>>   
> 
