Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7A8461C3B
	for <lists+dmaengine@lfdr.de>; Mon, 29 Nov 2021 17:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbhK2Q47 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 29 Nov 2021 11:56:59 -0500
Received: from mga03.intel.com ([134.134.136.65]:15852 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244953AbhK2Qy7 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 29 Nov 2021 11:54:59 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10183"; a="235942242"
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="235942242"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 08:47:13 -0800
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="540049563"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.209.175.223]) ([10.209.175.223])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 08:47:13 -0800
Message-ID: <f7676145-4d47-1305-8f4c-a01696df4f39@intel.com>
Date:   Mon, 29 Nov 2021 09:47:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH] dmaengine: idxd: add knob for enqcmds retries
Content-Language: en-US
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Sanjay Kumar <sanjay.k.kumar@intel.com>, dmaengine@vger.kernel.org
References: <163596021257.928002.3977423972243944934.stgit@djiang5-desk3.ch.intel.com>
 <YZs1tJgKPIfUb0Ok@matsya>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <YZs1tJgKPIfUb0Ok@matsya>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 11/21/2021 11:16 PM, Vinod Koul wrote:
> On 03-11-21, 10:23, Dave Jiang wrote:
>> Add a sysfs knob to allow tuning of retries for the kernel ENQCMDS
>> descriptor submission. While on host, it is not as likely that ENQCMDS
>> return busy during normal operations due to the driver controlling the
>> number of descriptors allocated for submission. However, when the driver is
>> operating as a guest driver, the chance of retry goes up significantly due
>> to sharing a wq with multiple VMs. A default value is provided with the
>> system admin being able to tune the value on a per WQ basis.
>>
>> Suggested-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>   Documentation/ABI/stable/sysfs-driver-dma-idxd |    6 ++++
>>   drivers/dma/idxd/device.c                      |    1 +
>>   drivers/dma/idxd/idxd.h                        |    4 +++
>>   drivers/dma/idxd/init.c                        |    1 +
>>   drivers/dma/idxd/irq.c                         |    2 +
>>   drivers/dma/idxd/submit.c                      |   32 ++++++++++++++++++-----
>>   drivers/dma/idxd/sysfs.c                       |   33 ++++++++++++++++++++++++
>>   7 files changed, 71 insertions(+), 8 deletions(-)
>>
>> diff --git a/Documentation/ABI/stable/sysfs-driver-dma-idxd b/Documentation/ABI/stable/sysfs-driver-dma-idxd
>> index df4afbccf037..fd1a611df510 100644
>> --- a/Documentation/ABI/stable/sysfs-driver-dma-idxd
>> +++ b/Documentation/ABI/stable/sysfs-driver-dma-idxd
>> @@ -220,6 +220,12 @@ Contact:	dmaengine@vger.kernel.org
>>   Description:	Show the current number of entries in this WQ if WQ Occupancy
>>   		Support bit WQ capabilities is 1.
>>   
>> +What:		/sys/bus/dsa/devices/wq<m>.<n>/enqcmds_retries
>> +Date		Oct 29, 2021
>> +KernelVersion:	5.17.0
>> +Contact:	dmaengine@vger.kernel.org
>> +Description:	Indicate the number of retires for an enqcmds submission on a shared wq.
>> +
>>   What:           /sys/bus/dsa/devices/engine<m>.<n>/group_id
>>   Date:           Oct 25, 2019
>>   KernelVersion:  5.6.0
>> diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
>> index 36e213a8108d..5a50ee6f6881 100644
>> --- a/drivers/dma/idxd/device.c
>> +++ b/drivers/dma/idxd/device.c
>> @@ -387,6 +387,7 @@ static void idxd_wq_disable_cleanup(struct idxd_wq *wq)
>>   	wq->threshold = 0;
>>   	wq->priority = 0;
>>   	wq->ats_dis = 0;
>> +	wq->enqcmds_retries = IDXD_ENQCMDS_RETRIES;
>>   	clear_bit(WQ_FLAG_DEDICATED, &wq->flags);
>>   	clear_bit(WQ_FLAG_BLOCK_ON_FAULT, &wq->flags);
>>   	memset(wq->name, 0, WQ_NAME_SIZE);
>> diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
>> index 89e98d69115b..6fe9c7bf78ac 100644
>> --- a/drivers/dma/idxd/idxd.h
>> +++ b/drivers/dma/idxd/idxd.h
>> @@ -52,6 +52,8 @@ enum idxd_type {
>>   #define IDXD_NAME_SIZE		128
>>   #define IDXD_PMU_EVENT_MAX	64
>>   
>> +#define IDXD_ENQCMDS_RETRIES	32
>> +
>>   struct idxd_device_driver {
>>   	const char *name;
>>   	enum idxd_dev_type *type;
>> @@ -173,6 +175,7 @@ struct idxd_dma_chan {
>>   struct idxd_wq {
>>   	void __iomem *portal;
>>   	u32 portal_offset;
>> +	unsigned int enqcmds_retries;
>>   	struct percpu_ref wq_active;
>>   	struct completion wq_dead;
>>   	struct completion wq_resurrect;
>> @@ -584,6 +587,7 @@ int idxd_wq_init_percpu_ref(struct idxd_wq *wq);
>>   int idxd_submit_desc(struct idxd_wq *wq, struct idxd_desc *desc);
>>   struct idxd_desc *idxd_alloc_desc(struct idxd_wq *wq, enum idxd_op_type optype);
>>   void idxd_free_desc(struct idxd_wq *wq, struct idxd_desc *desc);
>> +int idxd_enqcmds(struct idxd_wq *wq, void __iomem *portal, const void *desc);
>>   
>>   /* dmaengine */
>>   int idxd_register_dma_device(struct idxd_device *idxd);
>> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
>> index 94ecd4bf0f0e..8b3afce9ea67 100644
>> --- a/drivers/dma/idxd/init.c
>> +++ b/drivers/dma/idxd/init.c
>> @@ -248,6 +248,7 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
>>   		init_completion(&wq->wq_resurrect);
>>   		wq->max_xfer_bytes = WQ_DEFAULT_MAX_XFER;
>>   		wq->max_batch_size = WQ_DEFAULT_MAX_BATCH;
>> +		wq->enqcmds_retries = IDXD_ENQCMDS_RETRIES;
>>   		wq->wqcfg = kzalloc_node(idxd->wqcfg_size, GFP_KERNEL, dev_to_node(dev));
>>   		if (!wq->wqcfg) {
>>   			put_device(conf_dev);
>> diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
>> index a3bf3ea84587..0b0055a0ad2a 100644
>> --- a/drivers/dma/idxd/irq.c
>> +++ b/drivers/dma/idxd/irq.c
>> @@ -98,7 +98,7 @@ static void idxd_int_handle_revoke_drain(struct idxd_irq_entry *ie)
>>   	if (wq_dedicated(wq)) {
>>   		iosubmit_cmds512(portal, &desc, 1);
>>   	} else {
>> -		rc = enqcmds(portal, &desc);
>> +		rc = idxd_enqcmds(wq, portal, &desc);
>>   		/* This should not fail unless hardware failed. */
>>   		if (rc < 0)
>>   			dev_warn(dev, "Failed to submit drain desc on wq %d\n", wq->id);
>> diff --git a/drivers/dma/idxd/submit.c b/drivers/dma/idxd/submit.c
>> index 776fa81db61d..dd897accb9fb 100644
>> --- a/drivers/dma/idxd/submit.c
>> +++ b/drivers/dma/idxd/submit.c
>> @@ -123,6 +123,30 @@ static void llist_abort_desc(struct idxd_wq *wq, struct idxd_irq_entry *ie,
>>   		idxd_dma_complete_txd(found, IDXD_COMPLETE_ABORT, false);
>>   }
>>   
>> +
> This blank should be removed
Ooops. Will remove.
>
>> +/*
>> + * ENQCMDS typically fail when the WQ is inactive or busy. On host submission, the driver
>> + * has better control of number of descriptors being submitted to a shared wq by limiting
>> + * the number of driver allocated descriptors to the wq size. However, when the swq is
>> + * exported to a guest kernel, it may be shared with multiple guest kernels. This means
>> + * the likelihood of getting busy returned on the swq when submitting goes significantly up.
>> + * Having a tunable retry mechanism allows the driver to keep trying for a bit before giving
>> + * up. The sysfs knob can be tuned by the system administrator.
>> + */
>> +int idxd_enqcmds(struct idxd_wq *wq, void __iomem *portal, const void *desc)
>> +{
>> +	int rc, retries = 0;
>> +
>> +	do {
>> +		rc = enqcmds(portal, desc);
>> +		if (rc == 0)
>> +			break;
>> +		cpu_relax();
>> +	} while (retries++ < wq->enqcmds_retries);
>> +
>> +	return rc;
>> +}
>> +
>>   int idxd_submit_desc(struct idxd_wq *wq, struct idxd_desc *desc)
>>   {
>>   	struct idxd_device *idxd = wq->idxd;
>> @@ -166,13 +190,7 @@ int idxd_submit_desc(struct idxd_wq *wq, struct idxd_desc *desc)
>>   	if (wq_dedicated(wq)) {
>>   		iosubmit_cmds512(portal, desc->hw, 1);
>>   	} else {
>> -		/*
>> -		 * It's not likely that we would receive queue full rejection
>> -		 * since the descriptor allocation gates at wq size. If we
>> -		 * receive a -EAGAIN, that means something went wrong such as the
>> -		 * device is not accepting descriptor at all.
>> -		 */
>> -		rc = enqcmds(portal, desc->hw);
>> +		rc = idxd_enqcmds(wq, portal, desc->hw);
>>   		if (rc < 0) {
>>   			percpu_ref_put(&wq->wq_active);
>>   			/* abort operation frees the descriptor */
>> diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
>> index 90857e776273..7620cf00dabc 100644
>> --- a/drivers/dma/idxd/sysfs.c
>> +++ b/drivers/dma/idxd/sysfs.c
>> @@ -945,6 +945,38 @@ static ssize_t wq_occupancy_show(struct device *dev, struct device_attribute *at
>>   static struct device_attribute dev_attr_wq_occupancy =
>>   		__ATTR(occupancy, 0444, wq_occupancy_show, NULL);
>>   
>> +static ssize_t wq_enqcmds_retries_show(struct device *dev,
>> +				       struct device_attribute *attr, char *buf)
>> +{
>> +	struct idxd_wq *wq = confdev_to_wq(dev);
>> +
>> +	if (wq_dedicated(wq))
>> +		return -EOPNOTSUPP;
>> +
>> +	return sysfs_emit(buf, "%u\n", wq->enqcmds_retries);
>> +}
>> +
>> +static ssize_t wq_enqcmds_retries_store(struct device *dev, struct device_attribute *attr,
>> +					const char *buf, size_t count)
>> +{
>> +	struct idxd_wq *wq = confdev_to_wq(dev);
>> +	int rc;
>> +	unsigned int retries;
>> +
>> +	if (wq_dedicated(wq))
>> +		return -EOPNOTSUPP;
>> +
>> +	rc = kstrtouint(buf, 10, &retries);
>> +	if (rc < 0)
>> +		return rc;
>> +
>> +	wq->enqcmds_retries = retries;
> Should there be no upper limit on the retries? Surely we dont want
> userspace to write max and let it keep retrying...
Yes will add reasonable limit.
