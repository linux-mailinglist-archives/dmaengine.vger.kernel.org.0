Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 125495EE0A1
	for <lists+dmaengine@lfdr.de>; Wed, 28 Sep 2022 17:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234622AbiI1Pim (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Sep 2022 11:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233659AbiI1Pia (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 28 Sep 2022 11:38:30 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7079A98DB;
        Wed, 28 Sep 2022 08:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664379509; x=1695915509;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oVdfOOd1cyOseQwIDkFgUNlgmXR4bsi2J2HqIl9UECM=;
  b=e9bENAQsxoQ8BuNk05bIDBz7tgu/O0B76BrlJdEZTWpaJ2440FlrkC2Z
   zuGMPAbvEwb/zc8/3JC0WiiNngYHimcA6EqEzGlS5CAXvpd5fzioVgoQN
   JaeRxnoPAG/fNXNjzltuj4vxqokk1Hq3DA//81fVcYXB6XNOhI9rtAiIC
   w77ff0Q8W0lWjdMHlGrl4ssshlH0Cc8qNmNyk0twFNnewoEx/fJ8tss/1
   IKKSyQJ8QxccKYI3SLTzqiUDIebNk1fBJqxveeTLDZPkzAxq8xclBsGes
   8Y+/uTm7R26yCk6Fuck3Zv/9FVPpD/0NIkDZ0TCUzMHNsrzh/gQC65DcQ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="288794391"
X-IronPort-AV: E=Sophos;i="5.93,352,1654585200"; 
   d="scan'208";a="288794391"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 08:38:28 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="684451803"
X-IronPort-AV: E=Sophos;i="5.93,352,1654585200"; 
   d="scan'208";a="684451803"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.212.108.153]) ([10.212.108.153])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 08:38:26 -0700
Message-ID: <b268bd69-7d2b-6236-b5cc-1f8058165d31@intel.com>
Date:   Wed, 28 Sep 2022 08:38:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.3.0
Subject: Re: [PATCH 2/2] dmaengine: idxd: track enabled workqueues in bitmap
Content-Language: en-US
To:     Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>, Vinod Koul <vkoul@kernel.org>
References: <20220919215553.600246-1-jsnitsel@redhat.com>
 <20220919215553.600246-3-jsnitsel@redhat.com>
 <20220928152120.3wsvc4iungzsmryn@cantor>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20220928152120.3wsvc4iungzsmryn@cantor>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 9/28/2022 8:21 AM, Jerry Snitselaar wrote:
> On Mon, Sep 19, 2022 at 02:55:53PM -0700, Jerry Snitselaar wrote:
>> Now that idxd_wq_disable_cleanup() sets the workqueue state to
>> IDXD_WQ_DISABLED, use a bitmap to track which workqueues have been
>> enabled. This will then be used to determine which workqueues
>> should be re-enabled when attempting a software reset to recover
>> from a device halt state.
>>
>> Cc: Fenghua Yu <fenghua.yu@intel.com>
>> Cc: Dave Jiang <dave.jiang@intel.com>
>> Cc: Vinod Koul <vkoul@kernel.org>
>> Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
>> ---
>>   drivers/dma/idxd/device.c | 2 ++
>>   drivers/dma/idxd/idxd.h   | 2 ++
>>   drivers/dma/idxd/init.c   | 6 ++++++
>>   drivers/dma/idxd/irq.c    | 4 ++--
>>   drivers/dma/idxd/sysfs.c  | 1 +
>>   5 files changed, 13 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
>> index 31911e255ac1..f0c7d6d348e3 100644
>> --- a/drivers/dma/idxd/device.c
>> +++ b/drivers/dma/idxd/device.c
>> @@ -196,6 +196,7 @@ int idxd_wq_enable(struct idxd_wq *wq)
>>   	}
>>   
>>   	wq->state = IDXD_WQ_ENABLED;
>> +	set_bit(wq->id, idxd->wq_enable_map);
>>   	dev_dbg(dev, "WQ %d enabled\n", wq->id);
>>   	return 0;
>>   }
>> @@ -223,6 +224,7 @@ int idxd_wq_disable(struct idxd_wq *wq, bool reset_config)
>>   
>>   	if (reset_config)
>>   		idxd_wq_disable_cleanup(wq);
>> +	clear_bit(wq->id, idxd->wq_enable_map);
>>   	wq->state = IDXD_WQ_DISABLED;
>>   	dev_dbg(dev, "WQ %d disabled\n", wq->id);
>>   	return 0;
>> diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
>> index fed0dfc1eaa8..f527a7f88b92 100644
>> --- a/drivers/dma/idxd/idxd.h
>> +++ b/drivers/dma/idxd/idxd.h
>> @@ -11,6 +11,7 @@
>>   #include <linux/idr.h>
>>   #include <linux/pci.h>
>>   #include <linux/ioasid.h>
>> +#include <linux/bitmap.h>
>>   #include <linux/perf_event.h>
>>   #include <uapi/linux/idxd.h>
>>   #include "registers.h"
>> @@ -299,6 +300,7 @@ struct idxd_device {
>>   	int rdbuf_limit;
>>   	int nr_rdbufs;		/* non-reserved read buffers */
>>   	unsigned int wqcfg_size;
>> +	unsigned long *wq_enable_map;
>>   
>>   	union sw_err_reg sw_err;
>>   	wait_queue_head_t cmd_waitq;
>> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
>> index aa3478257ddb..7e27e69ff741 100644
>> --- a/drivers/dma/idxd/init.c
>> +++ b/drivers/dma/idxd/init.c
>> @@ -151,6 +151,12 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
>>   	if (!idxd->wqs)
>>   		return -ENOMEM;
>>   
>> +	idxd->wq_enable_map = bitmap_zalloc_node(idxd->max_wqs, GFP_KERNEL, dev_to_node(dev));
>> +	if (!idxd->wq_enable_map) {
>> +		kfree(idxd->wqs);
>> +		return -ENOMEM;
>> +	}
>> +
>>   	for (i = 0; i < idxd->max_wqs; i++) {
>>   		wq = kzalloc_node(sizeof(*wq), GFP_KERNEL, dev_to_node(dev));
>>   		if (!wq) {
>> diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
>> index 743ead5ebc57..8efaf137fc65 100644
>> --- a/drivers/dma/idxd/irq.c
>> +++ b/drivers/dma/idxd/irq.c
>> @@ -49,9 +49,9 @@ static void idxd_device_reinit(struct work_struct *work)
>>   		goto out;
>>   
>>   	for (i = 0; i < idxd->max_wqs; i++) {
>> -		struct idxd_wq *wq = idxd->wqs[i];
>> +		if (test_bit(i, idxd->wq_enable_map)) {
>> +			struct idxd_wq *wq = idxd->wqs[i];
>>   
>> -		if (wq->state == IDXD_WQ_ENABLED) {
>>   			rc = idxd_wq_enable(wq);
>>   			if (rc < 0) {
>>   				dev_warn(dev, "Unable to re-enable wq %s\n",
> Hi Dave and Fenghua,
>
> Thinking about this last night, this should probably clear the bit here in
> the case where an error is returned from idxd_wq_enable here, yes? I can
> send a v2.
Ah yeah I think so. We failed to enable, so just give up. Thanks.
>
>> diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
>> index 3f262a57441b..3325b16ed959 100644
>> --- a/drivers/dma/idxd/sysfs.c
>> +++ b/drivers/dma/idxd/sysfs.c
>> @@ -1405,6 +1405,7 @@ static void idxd_conf_device_release(struct device *dev)
>>   	struct idxd_device *idxd = confdev_to_idxd(dev);
>>   
>>   	kfree(idxd->groups);
>> +	bitmap_free(idxd->wq_enable_map);
>>   	kfree(idxd->wqs);
>>   	kfree(idxd->engines);
>>   	ida_free(&idxd_ida, idxd->id);
>> -- 
>> 2.37.2
>>
