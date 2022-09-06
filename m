Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96B65AF045
	for <lists+dmaengine@lfdr.de>; Tue,  6 Sep 2022 18:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232675AbiIFQWF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 6 Sep 2022 12:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234338AbiIFQVq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 6 Sep 2022 12:21:46 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B238883C3
        for <dmaengine@vger.kernel.org>; Tue,  6 Sep 2022 08:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662479419; x=1694015419;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ppg3Cghs1NKSekd7rQs3WoDErN71TP+oEUM3WgSRCoM=;
  b=DzYoYHaT6QhiFLxonO8g6fGYmbYPmCh80RQPb9CRk8DK2XAR7gnaZVLQ
   R9Bci2ayJ9Au3caiucY+O5GgxvYRlvFL13J8U68dgnZbW+XbrvhjwggIM
   zhxM1y/7F6N0MKD8chRRwEZoKukTHr5U6wdWVx0Moau+vkAQf7YQ8QQmi
   CjqTNzNxpWD5c6+YBXymDHtY7rNpoedLusNeeK2JtHbpk+71200lsk0ko
   3lAcHGAgma41cG1hnrBTlhSu6Gdaz9FxvsDfG/HUL8Sxk5d/wNEsNKIoD
   qkhwqn7YqkD9bHlLwg6zCov5dhHmFFewWijU32rNUo/FA6/auRfpKQ3ZU
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="283623648"
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="283623648"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 08:50:18 -0700
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="942502752"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.212.70.228]) ([10.212.70.228])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 08:50:17 -0700
Message-ID: <b8b0f591-bf80-5a43-eba9-7293c86ce13c@intel.com>
Date:   Tue, 6 Sep 2022 08:50:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.0
Subject: Re: [PATCH] dmatest: add CPU binding parameter
To:     Alexander Fomichev <a.fomichev@yadro.com>
Cc:     Alexander Fomichev <fomichev.ru@gmail.com>,
        dmaengine@vger.kernel.org, linux@yadro.com,
        Vinod Koul <vkoul@kernel.org>
References: <20220822114804.95751-1-fomichev.ru@gmail.com>
 <c92c5668-ae90-847e-c4af-c55733ad7e10@intel.com>
 <20220906142015.tmsejxeqrof7dx32@yadro.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20220906142015.tmsejxeqrof7dx32@yadro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 9/6/2022 7:27 AM, Alexander Fomichev wrote:
> Hi Dave,
>
> Thanks for the comment. Maybe it makes sense to add a note (or comment) that choosing CPU from the same NUMA node as the DMA channel is recommended.
> Anyway we can assign a different CPU for every DMA channel.
Having that option probably be best.
>
> On Mon, Aug 22, 2022 at 08:40:35AM -0700, Dave Jiang wrote:
>> I don't think this would work for multi-socket systems given when it's
>> on you bind all threads to a single CPU even if you may have channels on
>> a different NUMA node. One possible way to do this is perhaps using
>> on_cpu for Nth core for the NUMA node the channel is on? Just throwing
>> out ideas.
>>
>>
>>> Signed-off-by: Alexander Fomichev <a.fomichev@yadro.com>
>>> ---
>>>    drivers/dma/dmatest.c | 23 +++++++++++++++++++++--
>>>    1 file changed, 21 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
>>> index f696246f57fd..c91cbc9e5d1a 100644
>>> --- a/drivers/dma/dmatest.c
>>> +++ b/drivers/dma/dmatest.c
>>> @@ -89,6 +89,10 @@ static bool polled;
>>>    module_param(polled, bool, S_IRUGO | S_IWUSR);
>>>    MODULE_PARM_DESC(polled, "Use polling for completion instead of interrupts");
>>>
>>> +static int on_cpu = -1;
>>> +module_param(on_cpu, int, 0644);
>>> +MODULE_PARM_DESC(on_cpu, "Bind CPU to run threads on (default: auto scheduled (-1))");
>>> +
>>>    /**
>>>     * struct dmatest_params - test parameters.
>>>     * @buf_size:               size of the memcpy test buffer
>>> @@ -237,6 +241,7 @@ struct dmatest_thread {
>>>    struct dmatest_chan {
>>>        struct list_head        node;
>>>        struct dma_chan         *chan;
>>> +     int                                     cpu;
>>>        struct list_head        threads;
>>>    };
>>>
>>> @@ -602,6 +607,7 @@ static int dmatest_func(void *data)
>>>        ret = -ENOMEM;
>>>
>>>        smp_rmb();
>>> +
>>
>> Stray blank line
>>
>>>        thread->pending = false;
>>>        info = thread->info;
>>>        params = &info->params;
>>> @@ -1010,6 +1016,7 @@ static int dmatest_add_channel(struct dmatest_info *info,
>>>        struct dmatest_chan     *dtc;
>>>        struct dma_device       *dma_dev = chan->device;
>>>        unsigned int            thread_count = 0;
>>> +     char    cpu_str[20];
>>>        int cnt;
>>>
>>>        dtc = kmalloc(sizeof(struct dmatest_chan), GFP_KERNEL);
>>> @@ -1018,6 +1025,13 @@ static int dmatest_add_channel(struct dmatest_info *info,
>>>                return -ENOMEM;
>>>        }
>>>
>>> +     memset(cpu_str, 0, sizeof(cpu_str));
>>> +     if (on_cpu >= nr_cpu_ids || on_cpu < -1)
>>> +             on_cpu = -1;
>>> +     dtc->cpu = on_cpu;
>>> +     if (dtc->cpu != -1)
>>> +             snprintf(cpu_str, sizeof(cpu_str) - 1, " on CPU #%d", dtc->cpu);
>>> +
>>>        dtc->chan = chan;
>>>        INIT_LIST_HEAD(&dtc->threads);
>>>
>>> @@ -1050,8 +1064,8 @@ static int dmatest_add_channel(struct dmatest_info *info,
>>>                thread_count += cnt > 0 ? cnt : 0;
>>>        }
>>>
>>> -     pr_info("Added %u threads using %s\n",
>>> -             thread_count, dma_chan_name(chan));
>>> +     pr_info("Added %u threads using %s%s\n",
>>> +             thread_count, dma_chan_name(chan), cpu_str);
>>>
>>>        list_add_tail(&dtc->node, &info->channels);
>>>        info->nr_channels++;
>>> @@ -1125,6 +1139,11 @@ static void run_pending_tests(struct dmatest_info *info)
>>>
>>>                thread_count = 0;
>>>                list_for_each_entry(thread, &dtc->threads, node) {
>>> +                     if (dtc->cpu != -1) {
>>> +                             if (!thread->pending)
>>> +                                     continue;
>>> +                             kthread_bind(thread->task, dtc->cpu);
>>> +                     }
>>>                        wake_up_process(thread->task);
>>>                        thread_count++;
>>>                }
> All the best,
> Alexander.
