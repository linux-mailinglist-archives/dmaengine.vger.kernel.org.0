Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2754C16A4
	for <lists+dmaengine@lfdr.de>; Wed, 23 Feb 2022 16:25:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235638AbiBWPZ0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 23 Feb 2022 10:25:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234260AbiBWPZ0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 23 Feb 2022 10:25:26 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21795427CA;
        Wed, 23 Feb 2022 07:24:58 -0800 (PST)
Received: from ip4d144895.dynamic.kabel-deutschland.de ([77.20.72.149] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nMtVd-0008EV-QY; Wed, 23 Feb 2022 16:24:53 +0100
Message-ID: <6bdf8ca8-8836-4e44-5c27-0644aa9819ca@leemhuis.info>
Date:   Wed, 23 Feb 2022 16:24:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC] Scheduler: DMA Engine regression because of sched/fair
 changes
Content-Language: en-BZ
To:     Alexander Fomichev <fomichev.ru@gmail.com>,
        Hillf Danton <hdanton@sina.com>
Cc:     Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux@yadro.com,
        Peter Zijlstra <peterz@infradead.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <20220112152609.gg2boujeh5vv5cns@yadro.com>
 <20220112170512.GO3301@suse.de> <20220117081905.a4pwglxqj7dqpyql@yadro.com>
 <20220117102701.GQ3301@suse.de> <20220118020448.2399-1-hdanton@sina.com>
 <20220121101217.2849-1-hdanton@sina.com>
 <20220122233314.2999-1-hdanton@sina.com>
 <20220128165058.zxyrnd7nzr4hlks2@yadro.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <20220128165058.zxyrnd7nzr4hlks2@yadro.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1645629898;bb9df89e;
X-HE-SMSGID: 1nMtVd-0008EV-QY
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi, this is your Linux kernel regression tracker. Top-posting for once,
to make this easy accessible to everyone.

After below message nothing happened anymore afaics. Could anybody be so
kind to provide a quick status update, to ensure this wasn't simply
forgotten? And if this is not considered a regression anymore (I didn#t
fully understand below message, sorry), it would be ideal if the person
that replies could include a paragraph stating something like "#regzbot
invalid: Some reason why this can be ignored", as then I'll stop
tracking this. tia!

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I'm getting a lot of
reports on my table. I can only look briefly into most of them and lack
knowledge about most of the areas they concern. I thus unfortunately
will sometimes get things wrong or miss something important. I hope
that's not the case here; if you think it is, don't hesitate to tell me
in a public reply, it's in everyone's interest to set the public record
straight.

#regzbot poke

On 28.01.22 17:50, Alexander Fomichev wrote:
> On Sun, Jan 23, 2022 at 07:33:14AM +0800, Hillf Danton wrote:
>>
>> Lets put pieces together based on the data collected.
>>
>> 1, No irq migration was observed.
>>
>> 2, Your patch that produced the highest iops fo far
>>
>> -----< 5.15.8-ioat-ptdma-dirty-fix+ >-----
>> [ 6183.356549] dmatest: Added 1 threads using dma0chan0
>> [ 6187.868237] dmatest: Started 1 threads using dma0chan0
>> [ 6187.887389] dmatest: dma0chan0-copy0: summary 1000 tests, 0 failures 52753.74 iops 3376239 KB/s (0)
>> [ 6201.913154] dmatest: Added 1 threads using dma0chan0
>> [ 6204.701340] dmatest: Started 1 threads using dma0chan0
>> [ 6204.720490] dmatest: dma0chan0-copy0: summary 1000 tests, 0 failures 52614.96 iops 3367357 KB/s (0)
>> [ 6285.114603] dmatest: Added 1 threads using dma0chan0
>> [ 6287.031875] dmatest: Started 1 threads using dma0chan0
>> [ 6287.050278] dmatest: dma0chan0-copy0: summary 1000 tests, 0 failures 54939.01 iops 3516097 KB/s (0)
>> -----< end >-----
>>
>>
>> -       if (available_idle_cpu(this_cpu) && cpus_share_cache(this_cpu, prev_cpu))
>> -               return available_idle_cpu(prev_cpu) ? prev_cpu : this_cpu;
>> +       if (available_idle_cpu(this_cpu))
>> +               return this_cpu;
>>
>> prefers this cpu if it is idle regardless of cache affinity.
>>
>> This implies task migration to the cpu that handled irq.
>>
>> 3, Given this cpu is different from the prev cpu in addition to no irq
>> migration, the tested task was bouncing between the two cpus, with one
>> more question rising, why was task migrated off from the irq-handling cpu?
>>
>> Despite no evidence, I bet no bounce occurred given iops observed.
>>
> 
> IMHO, your assumptions are correct.
> I've added CPU number counters on every step of dmatest. It reveals that
> test task migration between (at least 2) CPUs occurs in even one thread
> mode. Below is for vanilla 5.15.8 kernel:
> 
> -----< threads_per_chan=1 >-----
> [19449.557950] dmatest: Added 1 threads using dma0chan0
> [19469.238180] dmatest: Started 1 threads using dma0chan0
> [19469.253962] dmatest: dma0chan0-copy0: summary 1000 tests, 0 failures 65291.19 iops 4178636 KB/s (0)
> [19469.253973] dmatest: CPUs hit: #52:417 #63:583  (times)
> -----< end >-----
> 
> Note that IRQ handler runs on CPU #52 in this environment.
> 
> In 4 thread mode the task migrates even more aggressively:
> 
> -----< threads_per_chan=4 >-----
> [19355.460227] dmatest: Added 4 threads using dma0chan0
> [19359.841182] dmatest: Started 4 threads using dma0chan0
> [19359.860447] dmatest: dma0chan0-copy3: summary 1000 tests, 0 failures 53908.35 iops 3450134 KB/s (0)
> [19359.860451] dmatest: dma0chan0-copy2: summary 1000 tests, 0 failures 54179.98 iops 3467519 KB/s (0)
> [19359.860456] dmatest: CPUs hit: #50:1000  (times)
> [19359.860459] dmatest: CPUs hit: #17:1000  (times)
> [19359.860459] dmatest: dma0chan0-copy0: summary 1000 tests, 0 failures 54048.21 iops 3459085 KB/s (0)
> [19359.860466] dmatest: CPUs hit: #31:1000  (times)
> [19359.861420] dmatest: dma0chan0-copy1: summary 1000 tests, 0 failures 51466.80 iops 3293875 KB/s (0)
> [19359.861425] dmatest: CPUs hit: #30:213 #48:556 #52:231  (times)
> -----< end >-----
> 
> On the other hand, for dirty-patched kernel task doesn't migrate:
> 
> -----< patched threads_per_chan=1 >-----
> [ 2100.142002] dmatest: Added 1 threads using dma0chan0
> [ 2102.359727] dmatest: Started 1 threads using dma0chan0
> [ 2102.373594] dmatest: dma0chan0-copy0: summary 1000 tests, 0 failures 76173.06 iops 4875076 KB/s (0)
> [ 2102.373600] dmatest: CPUs hit: #49:1000  (times)
> -----< end >-----
> 
> IRQ handler runs on CPU #49 in this case.
> 
> Although in 4 thread mode the task still migrates. I think we should
> consider such scenario as non-relevant for this isue.
> 

