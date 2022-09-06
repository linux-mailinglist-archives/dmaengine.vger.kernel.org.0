Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D13C5AEF2A
	for <lists+dmaengine@lfdr.de>; Tue,  6 Sep 2022 17:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233058AbiIFPoZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 6 Sep 2022 11:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236845AbiIFPoF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 6 Sep 2022 11:44:05 -0400
Received: from mta-01.yadro.com (mta-02.yadro.com [89.207.88.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1BBB488
        for <dmaengine@vger.kernel.org>; Tue,  6 Sep 2022 07:54:31 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 206A84171B;
        Tue,  6 Sep 2022 14:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        in-reply-to:content-disposition:content-type:content-type
        :mime-version:references:message-id:subject:subject:from:from
        :date:date:received:received:received:received; s=mta-01; t=
        1662474489; x=1664288890; bh=1IbFbWmxHkS94mpXuoKU8aUHKSoPr15rm69
        38Gg6usU=; b=OybMLaAh+jueHwf5/YdZuLyigTDUjWPte5sxbV3r5SDNMynlNAf
        gnmjy4ea3lNsqfl217wvPKbrlPQgv0aUyWLE6rVD5sQgHHm5PpLoOhtEUd/e9mMK
        oYLyiR/6dfsRsPX4BIOg65nYkGASM7hayX94DuiTXKFz/9MtrEzQxKf8=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1MOFz83EPxVO; Tue,  6 Sep 2022 17:28:09 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (T-EXCH-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 4B77C412F9;
        Tue,  6 Sep 2022 17:28:09 +0300 (MSK)
Received: from T-EXCH-08.corp.yadro.com (172.17.11.58) by
 T-EXCH-02.corp.yadro.com (172.17.10.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Tue, 6 Sep 2022 17:28:09 +0300
Received: from localhost (10.199.0.46) by T-EXCH-08.corp.yadro.com
 (172.17.11.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1118.9; Tue, 6 Sep 2022
 17:28:08 +0300
Date:   Tue, 6 Sep 2022 17:27:40 +0300
From:   Alexander Fomichev <a.fomichev@yadro.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     Alexander Fomichev <fomichev.ru@gmail.com>,
        <dmaengine@vger.kernel.org>, <linux@yadro.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH] dmatest: add CPU binding parameter
Message-ID: <20220906142015.tmsejxeqrof7dx32@yadro.com>
References: <20220822114804.95751-1-fomichev.ru@gmail.com>
 <c92c5668-ae90-847e-c4af-c55733ad7e10@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c92c5668-ae90-847e-c4af-c55733ad7e10@intel.com>
X-Originating-IP: [10.199.0.46]
X-ClientProxiedBy: T-EXCH-02.corp.yadro.com (172.17.10.102) To
 T-EXCH-08.corp.yadro.com (172.17.11.58)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Dave,

Thanks for the comment. Maybe it makes sense to add a note (or comment) that choosing CPU from the same NUMA node as the DMA channel is recommended.
Anyway we can assign a different CPU for every DMA channel.

On Mon, Aug 22, 2022 at 08:40:35AM -0700, Dave Jiang wrote:
> 
> I don't think this would work for multi-socket systems given when it's
> on you bind all threads to a single CPU even if you may have channels on
> a different NUMA node. One possible way to do this is perhaps using
> on_cpu for Nth core for the NUMA node the channel is on? Just throwing
> out ideas.
> 
> 
> > 
> > Signed-off-by: Alexander Fomichev <a.fomichev@yadro.com>
> > ---
> >   drivers/dma/dmatest.c | 23 +++++++++++++++++++++--
> >   1 file changed, 21 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
> > index f696246f57fd..c91cbc9e5d1a 100644
> > --- a/drivers/dma/dmatest.c
> > +++ b/drivers/dma/dmatest.c
> > @@ -89,6 +89,10 @@ static bool polled;
> >   module_param(polled, bool, S_IRUGO | S_IWUSR);
> >   MODULE_PARM_DESC(polled, "Use polling for completion instead of interrupts");
> > 
> > +static int on_cpu = -1;
> > +module_param(on_cpu, int, 0644);
> > +MODULE_PARM_DESC(on_cpu, "Bind CPU to run threads on (default: auto scheduled (-1))");
> > +
> >   /**
> >    * struct dmatest_params - test parameters.
> >    * @buf_size:               size of the memcpy test buffer
> > @@ -237,6 +241,7 @@ struct dmatest_thread {
> >   struct dmatest_chan {
> >       struct list_head        node;
> >       struct dma_chan         *chan;
> > +     int                                     cpu;
> >       struct list_head        threads;
> >   };
> > 
> > @@ -602,6 +607,7 @@ static int dmatest_func(void *data)
> >       ret = -ENOMEM;
> > 
> >       smp_rmb();
> > +
> 
> 
> Stray blank line
> 
> >       thread->pending = false;
> >       info = thread->info;
> >       params = &info->params;
> > @@ -1010,6 +1016,7 @@ static int dmatest_add_channel(struct dmatest_info *info,
> >       struct dmatest_chan     *dtc;
> >       struct dma_device       *dma_dev = chan->device;
> >       unsigned int            thread_count = 0;
> > +     char    cpu_str[20];
> >       int cnt;
> > 
> >       dtc = kmalloc(sizeof(struct dmatest_chan), GFP_KERNEL);
> > @@ -1018,6 +1025,13 @@ static int dmatest_add_channel(struct dmatest_info *info,
> >               return -ENOMEM;
> >       }
> > 
> > +     memset(cpu_str, 0, sizeof(cpu_str));
> > +     if (on_cpu >= nr_cpu_ids || on_cpu < -1)
> > +             on_cpu = -1;
> > +     dtc->cpu = on_cpu;
> > +     if (dtc->cpu != -1)
> > +             snprintf(cpu_str, sizeof(cpu_str) - 1, " on CPU #%d", dtc->cpu);
> > +
> >       dtc->chan = chan;
> >       INIT_LIST_HEAD(&dtc->threads);
> > 
> > @@ -1050,8 +1064,8 @@ static int dmatest_add_channel(struct dmatest_info *info,
> >               thread_count += cnt > 0 ? cnt : 0;
> >       }
> > 
> > -     pr_info("Added %u threads using %s\n",
> > -             thread_count, dma_chan_name(chan));
> > +     pr_info("Added %u threads using %s%s\n",
> > +             thread_count, dma_chan_name(chan), cpu_str);
> > 
> >       list_add_tail(&dtc->node, &info->channels);
> >       info->nr_channels++;
> > @@ -1125,6 +1139,11 @@ static void run_pending_tests(struct dmatest_info *info)
> > 
> >               thread_count = 0;
> >               list_for_each_entry(thread, &dtc->threads, node) {
> > +                     if (dtc->cpu != -1) {
> > +                             if (!thread->pending)
> > +                                     continue;
> > +                             kthread_bind(thread->task, dtc->cpu);
> > +                     }
> >                       wake_up_process(thread->task);
> >                       thread_count++;
> >               }

All the best,
Alexander.
