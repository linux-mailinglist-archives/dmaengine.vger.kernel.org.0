Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E055859C2FF
	for <lists+dmaengine@lfdr.de>; Mon, 22 Aug 2022 17:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235583AbiHVPkn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 22 Aug 2022 11:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236743AbiHVPkj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 22 Aug 2022 11:40:39 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30ABE006
        for <dmaengine@vger.kernel.org>; Mon, 22 Aug 2022 08:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661182836; x=1692718836;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xLB5NxfB+VYXh283yw0L3JVbtY7UrWB5PURgj/4MWjE=;
  b=SGe2Ea4E1BQc+OH7YBHZGFKOOVEu57X1I14Vp9H9hWYYXCn2Kf/PS701
   vFGl9xyXdd/K8W8ZJ7YZjhSld3gSq47yVh6GIABn0EwfUnqxW2ORugkuw
   NdBOl3b5TsK8QoPvNGixeVluXcs75p3zd/ZAmdKw7SWE7isQAgNwmhzxE
   /Wcl+bg9ZFuEp1XSVO83ANPNGneGhVEOUdRfpLDEvnx/tdNTOQx4N6hVW
   zIwKtVPy7SLlrSFeJlFpjDj0B0Zd+oKTS4oY6LW5Jod/OIJk86UwZmOq2
   0AXqyJABX8hrCXEf1wvTpR5ZMV1vi3/nM0kXNcse5RRsoVkaIDX5FvXto
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="273199970"
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="273199970"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 08:40:36 -0700
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="698328652"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.212.127.248]) ([10.212.127.248])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 08:40:36 -0700
Message-ID: <c92c5668-ae90-847e-c4af-c55733ad7e10@intel.com>
Date:   Mon, 22 Aug 2022 08:40:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.12.0
Subject: Re: [PATCH] dmatest: add CPU binding parameter
Content-Language: en-US
To:     Alexander Fomichev <fomichev.ru@gmail.com>,
        dmaengine@vger.kernel.org
Cc:     linux@yadro.com, Vinod Koul <vkoul@kernel.org>,
        Alexander Fomichev <a.fomichev@yadro.com>
References: <20220822114804.95751-1-fomichev.ru@gmail.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20220822114804.95751-1-fomichev.ru@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 8/22/2022 4:48 AM, Alexander Fomichev wrote:
> From: Alexander Fomichev <a.fomichev@yadro.com>
>
> Introduce "on_cpu" module parameter for dmatest.
> By default, its value is -1 which means no binding implies.
> Positive values or zero cause the next "channel" assignment(s) to bind
> channel's thread to certain CPU. Thus, it is possible to bind different
> DMA channels' threads to different CPUs.
>
> This is useful for the cases when cold cache (because of task migrating
> between CPUs) significantly impacts DMA Engine performance. Such
> situation was analyzed in [1].
>
> [1] Scheduler: DMA Engine regression because of sched/fair changes
> https://lore.kernel.org/all/20220128165058.zxyrnd7nzr4hlks2@yadro.com/

I don't think this would work for multi-socket systems given when it's 
on you bind all threads to a single CPU even if you may have channels on 
a different NUMA node. One possible way to do this is perhaps using 
on_cpu for Nth core for the NUMA node the channel is on? Just throwing 
out ideas.


>
> Signed-off-by: Alexander Fomichev <a.fomichev@yadro.com>
> ---
>   drivers/dma/dmatest.c | 23 +++++++++++++++++++++--
>   1 file changed, 21 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
> index f696246f57fd..c91cbc9e5d1a 100644
> --- a/drivers/dma/dmatest.c
> +++ b/drivers/dma/dmatest.c
> @@ -89,6 +89,10 @@ static bool polled;
>   module_param(polled, bool, S_IRUGO | S_IWUSR);
>   MODULE_PARM_DESC(polled, "Use polling for completion instead of interrupts");
>   
> +static int on_cpu = -1;
> +module_param(on_cpu, int, 0644);
> +MODULE_PARM_DESC(on_cpu, "Bind CPU to run threads on (default: auto scheduled (-1))");
> +
>   /**
>    * struct dmatest_params - test parameters.
>    * @buf_size:		size of the memcpy test buffer
> @@ -237,6 +241,7 @@ struct dmatest_thread {
>   struct dmatest_chan {
>   	struct list_head	node;
>   	struct dma_chan		*chan;
> +	int					cpu;
>   	struct list_head	threads;
>   };
>   
> @@ -602,6 +607,7 @@ static int dmatest_func(void *data)
>   	ret = -ENOMEM;
>   
>   	smp_rmb();
> +


Stray blank line

>   	thread->pending = false;
>   	info = thread->info;
>   	params = &info->params;
> @@ -1010,6 +1016,7 @@ static int dmatest_add_channel(struct dmatest_info *info,
>   	struct dmatest_chan	*dtc;
>   	struct dma_device	*dma_dev = chan->device;
>   	unsigned int		thread_count = 0;
> +	char	cpu_str[20];
>   	int cnt;
>   
>   	dtc = kmalloc(sizeof(struct dmatest_chan), GFP_KERNEL);
> @@ -1018,6 +1025,13 @@ static int dmatest_add_channel(struct dmatest_info *info,
>   		return -ENOMEM;
>   	}
>   
> +	memset(cpu_str, 0, sizeof(cpu_str));
> +	if (on_cpu >= nr_cpu_ids || on_cpu < -1)
> +		on_cpu = -1;
> +	dtc->cpu = on_cpu;
> +	if (dtc->cpu != -1)
> +		snprintf(cpu_str, sizeof(cpu_str) - 1, " on CPU #%d", dtc->cpu);
> +
>   	dtc->chan = chan;
>   	INIT_LIST_HEAD(&dtc->threads);
>   
> @@ -1050,8 +1064,8 @@ static int dmatest_add_channel(struct dmatest_info *info,
>   		thread_count += cnt > 0 ? cnt : 0;
>   	}
>   
> -	pr_info("Added %u threads using %s\n",
> -		thread_count, dma_chan_name(chan));
> +	pr_info("Added %u threads using %s%s\n",
> +		thread_count, dma_chan_name(chan), cpu_str);
>   
>   	list_add_tail(&dtc->node, &info->channels);
>   	info->nr_channels++;
> @@ -1125,6 +1139,11 @@ static void run_pending_tests(struct dmatest_info *info)
>   
>   		thread_count = 0;
>   		list_for_each_entry(thread, &dtc->threads, node) {
> +			if (dtc->cpu != -1) {
> +				if (!thread->pending)
> +					continue;
> +				kthread_bind(thread->task, dtc->cpu);
> +			}
>   			wake_up_process(thread->task);
>   			thread_count++;
>   		}
