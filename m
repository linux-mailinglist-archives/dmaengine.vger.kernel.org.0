Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 717DE48FC12
	for <lists+dmaengine@lfdr.de>; Sun, 16 Jan 2022 10:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234800AbiAPJzP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 16 Jan 2022 04:55:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232360AbiAPJzP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 16 Jan 2022 04:55:15 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D800C061574;
        Sun, 16 Jan 2022 01:55:15 -0800 (PST)
Received: from ip4d173d02.dynamic.kabel-deutschland.de ([77.23.61.2] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1n92Fj-0004oF-Ou; Sun, 16 Jan 2022 10:55:11 +0100
Message-ID: <4e7a5b11-541d-ef27-21b1-bc563677e045@leemhuis.info>
Date:   Sun, 16 Jan 2022 10:55:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [RFC] Scheduler: DMA Engine regression because of sched/fair
 changes
Content-Language: en-BS
To:     Alexander Fomichev <fomichev.ru@gmail.com>,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Cc:     Mel Gorman <mgorman@suse.de>, linux@yadro.com,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <20220112152609.gg2boujeh5vv5cns@yadro.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <20220112152609.gg2boujeh5vv5cns@yadro.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1642326915;e61157a7;
X-HE-SMSGID: 1n92Fj-0004oF-Ou
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


[TLDR: I'm adding this regression to regzbot, the Linux kernel
regression tracking bot; most text you find below is compiled from a few
templates paragraphs some of you might have seen already.]

Hi, this is your Linux kernel regression tracker speaking.

Thanks for the report.

Adding the regression mailing list to the list of recipients, as it
should be in the loop for all regressions, as explained here:
https://www.kernel.org/doc/html/latest/admin-guide/reporting-issues.html

To be sure this issue doesn't fall through the cracks unnoticed, I'm
adding it to regzbot, my Linux kernel regression tracking bot:

On 12.01.22 16:26, Alexander Fomichev wrote:
> CC: Mel Gorman <mgorman@suse.de>
> CC: linux@yadro.com
> 
> Hi all,
> 
> There's a huge regression found, which affects Intel Xeon's DMA Engine
> performance between v4.14 LTS and modern kernels. In certain
> circumstances the speed in dmatest is more than 6 times lower.
> 
> 	- Hardware -
> I did testing on 2 systems:
> 1) Intel(R) Xeon(R) Gold 6132 CPU @ 2.60GHz (Supermicro X11DAi-N)
> 2) Intel(R) Xeon(R) Bronze 3204 CPU @ 1.90GHz (YADRO Vegman S220)
> 
> 	- Measurement -
> The dmatest result speed decreases with almost any test settings.
> Although the most significant impact is revealed with 64K transfers. The
> following parameters were used:
> 
> modprobe dmatest iterations=1000 timeout=2000 test_buf_size=0x100000 transfer_size=0x10000 norandom=1
> echo "dma0chan0" > /sys/module/dmatest/parameters/channel
> echo 1 > /sys/module/dmatest/parameters/run
> 
> Every test csse was performed at least 3 times. All detailed results are
> below.
> 
> 	- Analysis -
> Bisecting revealed 2 different bad commits for those 2 systems, but both
> change the same function/condition in the same file.
> For the system (1) the bad commit is:
> [7332dec055f2457c386032f7e9b2991eb05c2a0a] sched/fair: Only immediately migrate tasks due to interrupts if prev and target CPUs share cache
> For the system (2) the bad commit is:
> [806486c377e33ab662de6d47902e9e2a32b79368] sched/fair: Do not migrate if the prev_cpu is idle

Uhh, regzbot is not prepared for this, hence I'll simply pick
7332dec055f2457c386032f7e9b2991eb05c2a0a

#regzbot ^introduced 7332dec055f2457c386032f7e9b2991eb05c2a0a
#regzbot title sched: DMA Engine regression because of sched/fair changes
#regzbot ignore-activity

Reminder: when fixing the issue, please add a 'Link:' tag with the URL
to the report (the parent of this mail) using the kernel.org redirector,
as explained in 'Documentation/process/submitting-patches.rst'. Regzbot
then will automatically mark the regression as resolved once the fix
lands in the appropriate tree. For more details about regzbot see footer.

Sending this to everyone that got the initial report, to make all aware
of the tracking. I also hope that messages like this motivate people to
directly get at least the regression mailing list and ideally even
regzbot involved when dealing with regressions, as messages like this
wouldn't be needed then.

Don't worry, I'll send further messages wrt to this regression just to
the lists (with a tag in the subject so people can filter them away), as
long as they are intended just for regzbot. With a bit of luck no such
messages will be needed anyway.

Ciao, Thorsten (wearing his 'Linux kernel regression tracker' hat)

P.S.: As a Linux kernel regression tracker I'm getting a lot of reports
on my table. I can only look briefly into most of them. Unfortunately
therefore I sometimes will get things wrong or miss something important.
I hope that's not the case here; if you think it is, don't hesitate to
tell me about it in a public reply, that's in everyone's interest.

BTW, I have no personal interest in this issue, which is tracked using
regzbot, my Linux kernel regression tracking bot
(https://linux-regtracking.leemhuis.info/regzbot/). I'm only posting
this mail to get things rolling again and hence don't need to be CC on
all further activities wrt to this regression.

> 	- Additional check -
> Attempting to revert the changes above, a dirty patch for the (current)
> kernel v5.16.0-rc5 was tested too:
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 6f16dfb74246..0a58cc00b1b8 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5931,8 +5931,8 @@ wake_affine_idle(int this_cpu, int prev_cpu, int sync)
>          * a cpufreq perspective, it's better to have higher utilisation
>          * on one CPU.
>          */
> -       if (available_idle_cpu(this_cpu) && cpus_share_cache(this_cpu, prev_cpu))
> -               return available_idle_cpu(prev_cpu) ? prev_cpu : this_cpu;
> +       if (available_idle_cpu(this_cpu))
> +               return this_cpu;
> 
>         if (sync && cpu_rq(this_cpu)->nr_running == 1)
>                 return this_cpu;
> 
> Please, take a look if this makes sense. But with this patch applied the
> performance of DMA Engine restores.
> 
> 	- Dmatest results TL;DR -
> 
> System (1) before bad commit:
> ---------------------
> [  519.894642] dmatest: Added 1 threads using dma0chan0
> [  525.383021] dmatest: Started 1 threads using dma0chan0
> [  528.521915] dmatest: dma0chan0-copy0: summary 1000 tests, 0 failures 98367.10 iops 6295494 KB/s (0)
> [  544.851751] dmatest: Added 1 threads using dma0chan0
> [  546.460064] dmatest: Started 1 threads using dma0chan0
> [  549.609504] dmatest: dma0chan0-copy0: summary 1000 tests, 0 failures 100310.96 iops 6419901 KB/s (0)
> [  562.178365] dmatest: Added 1 threads using dma0chan0
> [  563.852534] dmatest: Started 1 threads using dma0chan0
> [  567.004898] dmatest: dma0chan0-copy0: summary 1000 tests, 0 failures 98580.44 iops 6309148 KB/s (0)
> ---------------------
> 
> System (1) on HEAD=bad commit:
> ---------------------
> [  149.555401] dmatest: Added 1 threads using dma0chan0
> [  154.162444] dmatest: Started 1 threads using dma0chan0
> [  157.490868] dmatest: dma0chan0-copy0: summary 1000 tests, 0 failures 26653.87 iops 1705847 KB/s (0)
> [  176.783450] dmatest: Added 1 threads using dma0chan0
> [  178.428518] dmatest: Started 1 threads using dma0chan0
> [  181.606531] dmatest: dma0chan0-copy0: summary 1000 tests, 0 failures 14194.86 iops 908471 KB/s (0)
> [  192.125218] dmatest: Added 1 threads using dma0chan0
> [  194.060029] dmatest: Started 1 threads using dma0chan0
> [  197.235265] dmatest: dma0chan0-copy0: summary 1000 tests, 0 failures 14757.09 iops 944454 KB/s (0)
> ---------------------
> 
> Systen (1) on v5.16.0-rc5:
> ---------------------
> [ 1430.860170] dmatest: Added 1 threads using dma0chan0
> [ 1437.367447] dmatest: Started 1 threads using dma0chan0
> [ 1442.756660] dmatest: dma0chan0-copy0: summary 1000 tests, 0 failures 24837.31 iops 1589588 KB/s (0)
> [ 1561.614191] dmatest: Added 1 threads using dma0chan0
> [ 1562.816375] dmatest: Started 1 threads using dma0chan0
> [ 1566.619614] dmatest: dma0chan0-copy0: summary 1000 tests, 0 failures 13666.05 iops 874627 KB/s (0)
> [ 1585.019601] dmatest: Added 1 threads using dma0chan0
> [ 1587.585741] dmatest: Started 1 threads using dma0chan0
> [ 1591.386816] dmatest: dma0chan0-copy0: summary 1000 tests, 0 failures 13521.91 iops 865402 KB/s (0)
> ---------------------
> 
> System (1) on v5.16.0-rc5 with dirty patch:
> ---------------------
> [  733.571508] dmatest: Added 1 threads using dma0chan0
> [  746.050800] dmatest: Started 1 threads using dma0chan0
> [  749.765600] dmatest: dma0chan0-copy0: summary 1000 tests, 0 failures 87260.03 iops 5584642 KB/s (0)
> [  915.051955] dmatest: Added 1 threads using dma0chan0
> [  916.550732] dmatest: Started 1 threads using dma0chan0
> [  920.267525] dmatest: dma0chan0-copy0: summary 1000 tests, 0 failures 88464.25 iops 5661712 KB/s (0)
> [  936.781273] dmatest: Added 1 threads using dma0chan0
> [  939.528616] dmatest: Started 1 threads using dma0chan0
> [  943.247694] dmatest: dma0chan0-copy0: summary 1000 tests, 0 failures 88833.61 iops 5685351 KB/s (0)
> ---------------------
> 
> System (2) before bad commit:
> ---------------------
> [  481.309411] dmatest: Added 1 threads using dma0chan0
> [  491.197425] dmatest: Started 1 threads using dma0chan0
> [  497.047315] dmatest: dma0chan0-copy0: summary 1000 tests, 0 failures 78988.94 iops 5055292 KB/s (0)
> [  506.057101] dmatest: Added 1 threads using dma0chan0
> [  508.939426] dmatest: Started 1 threads using dma0chan0
> [  514.788823] dmatest: dma0chan0-copy0: summary 1000 tests, 0 failures 77754.44 iops 4976284 KB/s (0)
> [  531.894587] dmatest: Added 1 threads using dma0chan0
> [  534.053360] dmatest: Started 1 threads using dma0chan0
> [  539.906424] dmatest: dma0chan0-copy0: summary 1000 tests, 0 failures 76988.21 iops 4927246 KB/s (0)
> ---------------------
> 
> System (2) on HEAD=bad commit:
> ---------------------
> [44522.892995] dmatest: Added 1 threads using dma0chan0
> [44526.193331] dmatest: Started 1 threads using dma0chan0
> [44532.043932] dmatest: dma0chan0-copy0: summary 1000 tests, 0 failures 80360.01 iops 5143040 KB/s (0)
> [44561.121118] dmatest: Added 1 threads using dma0chan0
> [44562.868428] dmatest: Started 1 threads using dma0chan0
> [44568.808577] dmatest: dma0chan0-copy0: summary 1000 tests, 0 failures 16080.53 iops 1029154 KB/s (0)
> [44728.597409] dmatest: Added 1 threads using dma0chan0
> [44730.301566] dmatest: Started 1 threads using dma0chan0
> [44736.259009] dmatest: dma0chan0-copy0: summary 1000 tests, 0 failures 16091.91 iops 1029882 KB/s (0)
> ---------------------
> 
> Thanks for reading.
> 

---
Additional information about regzbot:

If you want to know more about regzbot, check out its web-interface, the
getting start guide, and/or the references documentation:

https://linux-regtracking.leemhuis.info/regzbot/
https://gitlab.com/knurd42/regzbot/-/blob/main/docs/getting_started.md
https://gitlab.com/knurd42/regzbot/-/blob/main/docs/reference.md

The last two documents will explain how you can interact with regzbot
yourself if your want to.

Hint for reporters: when reporting a regression it's in your interest to
tell #regzbot about it in the report, as that will ensure the regression
gets on the radar of regzbot and the regression tracker. That's in your
interest, as they will make sure the report won't fall through the
cracks unnoticed.

Hint for developers: you normally don't need to care about regzbot once
it's involved. Fix the issue as you normally would, just remember to
include a 'Link:' tag to the report in the commit message, as explained
in Documentation/process/submitting-patches.rst
That aspect was recently was made more explicit in commit 1f57bd42b77c:
https://git.kernel.org/linus/1f57bd42b77c
