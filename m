Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF705EE0E2
	for <lists+dmaengine@lfdr.de>; Wed, 28 Sep 2022 17:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233194AbiI1PwB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Sep 2022 11:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiI1PwA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 28 Sep 2022 11:52:00 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C8928305A;
        Wed, 28 Sep 2022 08:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664380319; x=1695916319;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2NxRgRts5NH10GH5zaZNAr4ml97NqLJQPJNK5aYWjbI=;
  b=RuyIzQ1KoW/wEKXVlgZ2E08ByCf0F1chE6kCzOb4sUDOZtzBYK706F4x
   9Y3V3ZZEZnOG1A+GbXxxbydh3/ArPAUOvtYEALbXyYxGqXG7sqhgM7j/E
   vl7mCrbOzAS9+nMhofESKFkA0O1ReV/LJTTHDndbTuIL1sqE8kkwP9DFP
   CLLReWC8alZfO5DOepRjLaCkbrhiPjzR2BHWApDyENBI7u3kdEoGXKarg
   e9PEgW+bLh0/mvvBD4fDKW7jbV3+HFO5NuElTTY2mE8msrgtmb8EqZ42U
   WCRoyJ7AYspYxkAj+1ucG5cq7tkJXqJQgpShCW8Vc/mlFQ5BZRn7++JFt
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="302549268"
X-IronPort-AV: E=Sophos;i="5.93,352,1654585200"; 
   d="scan'208";a="302549268"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 08:51:58 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="747477181"
X-IronPort-AV: E=Sophos;i="5.93,352,1654585200"; 
   d="scan'208";a="747477181"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.212.108.153]) ([10.212.108.153])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 08:51:57 -0700
Message-ID: <e72f8966-de53-6288-517f-dd2a205a761c@intel.com>
Date:   Wed, 28 Sep 2022 08:51:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.3.0
Subject: Re: [PATCH v2 2/2] dmaengine: idxd: track enabled workqueues in
 bitmap
Content-Language: en-US
To:     Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>, Vinod Koul <vkoul@kernel.org>
References: <20220928154856.623545-1-jsnitsel@redhat.com>
 <20220928154856.623545-3-jsnitsel@redhat.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20220928154856.623545-3-jsnitsel@redhat.com>
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


On 9/28/2022 8:48 AM, Jerry Snitselaar wrote:
> Now that idxd_wq_disable_cleanup() sets the workqueue state to
> IDXD_WQ_DISABLED, use a bitmap to track which workqueues have been
> enabled. This will then be used to determine which workqueues
> should be re-enabled when attempting a software reset to recover
> from a device halt state.
>
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v2: Clear bit in case where idxd_wq_enable fails during re-init
>
>   drivers/dma/idxd/device.c | 2 ++
>   drivers/dma/idxd/idxd.h   | 2 ++
>   drivers/dma/idxd/init.c   | 6 ++++++
>   drivers/dma/idxd/irq.c    | 5 +++--
>   drivers/dma/idxd/sysfs.c  | 1 +
>   5 files changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
> index 31911e255ac1..f0c7d6d348e3 100644
> --- a/drivers/dma/idxd/device.c
> +++ b/drivers/dma/idxd/device.c
> @@ -196,6 +196,7 @@ int idxd_wq_enable(struct idxd_wq *wq)
>   	}
>   
>   	wq->state = IDXD_WQ_ENABLED;
> +	set_bit(wq->id, idxd->wq_enable_map);
>   	dev_dbg(dev, "WQ %d enabled\n", wq->id);
>   	return 0;
>   }
> @@ -223,6 +224,7 @@ int idxd_wq_disable(struct idxd_wq *wq, bool reset_config)
>   
>   	if (reset_config)
>   		idxd_wq_disable_cleanup(wq);
> +	clear_bit(wq->id, idxd->wq_enable_map);
>   	wq->state = IDXD_WQ_DISABLED;
>   	dev_dbg(dev, "WQ %d disabled\n", wq->id);
>   	return 0;
> diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
> index fed0dfc1eaa8..f527a7f88b92 100644
> --- a/drivers/dma/idxd/idxd.h
> +++ b/drivers/dma/idxd/idxd.h
> @@ -11,6 +11,7 @@
>   #include <linux/idr.h>
>   #include <linux/pci.h>
>   #include <linux/ioasid.h>
> +#include <linux/bitmap.h>
>   #include <linux/perf_event.h>
>   #include <uapi/linux/idxd.h>
>   #include "registers.h"
> @@ -299,6 +300,7 @@ struct idxd_device {
>   	int rdbuf_limit;
>   	int nr_rdbufs;		/* non-reserved read buffers */
>   	unsigned int wqcfg_size;
> +	unsigned long *wq_enable_map;
>   
>   	union sw_err_reg sw_err;
>   	wait_queue_head_t cmd_waitq;
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index aa3478257ddb..7e27e69ff741 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -151,6 +151,12 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
>   	if (!idxd->wqs)
>   		return -ENOMEM;
>   
> +	idxd->wq_enable_map = bitmap_zalloc_node(idxd->max_wqs, GFP_KERNEL, dev_to_node(dev));
> +	if (!idxd->wq_enable_map) {
> +		kfree(idxd->wqs);
> +		return -ENOMEM;
> +	}
> +
>   	for (i = 0; i < idxd->max_wqs; i++) {
>   		wq = kzalloc_node(sizeof(*wq), GFP_KERNEL, dev_to_node(dev));
>   		if (!wq) {
> diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
> index 743ead5ebc57..3fcfbb7bf6e3 100644
> --- a/drivers/dma/idxd/irq.c
> +++ b/drivers/dma/idxd/irq.c
> @@ -49,11 +49,12 @@ static void idxd_device_reinit(struct work_struct *work)
>   		goto out;
>   
>   	for (i = 0; i < idxd->max_wqs; i++) {
> -		struct idxd_wq *wq = idxd->wqs[i];
> +		if (test_bit(i, idxd->wq_enable_map)) {
> +			struct idxd_wq *wq = idxd->wqs[i];
>   
> -		if (wq->state == IDXD_WQ_ENABLED) {
>   			rc = idxd_wq_enable(wq);
>   			if (rc < 0) {
> +				clear_bit(i, idxd->wq_enable_map);
>   				dev_warn(dev, "Unable to re-enable wq %s\n",
>   					 dev_name(wq_confdev(wq)));
>   			}
> diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
> index 3f262a57441b..3325b16ed959 100644
> --- a/drivers/dma/idxd/sysfs.c
> +++ b/drivers/dma/idxd/sysfs.c
> @@ -1405,6 +1405,7 @@ static void idxd_conf_device_release(struct device *dev)
>   	struct idxd_device *idxd = confdev_to_idxd(dev);
>   
>   	kfree(idxd->groups);
> +	bitmap_free(idxd->wq_enable_map);
>   	kfree(idxd->wqs);
>   	kfree(idxd->engines);
>   	ida_free(&idxd_ida, idxd->id);
