Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95460490399
	for <lists+dmaengine@lfdr.de>; Mon, 17 Jan 2022 09:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238019AbiAQITR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 17 Jan 2022 03:19:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbiAQITR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 17 Jan 2022 03:19:17 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1092C061574;
        Mon, 17 Jan 2022 00:19:16 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id x11so28842440lfa.2;
        Mon, 17 Jan 2022 00:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CgFiE1xRseB0L65/zcK0C8WvrsrBuQCopXkVzsqfP4E=;
        b=MIrL15KFbodb8dwAPOc2ReAWJ15S3kOthT8ICt7Rsbi6quFPKpogoZkcq+1E+2i3ZN
         9SleM9zPMvTSG9kvV9w7CkMbyOCp5YNtsH9u+Ka2YKHQdL1HzziaC2evA3ETuexaTOJQ
         OqYxtOxHD3TXo1FYuun10VrYN2t5R7IjPtb7a6JZF6otQEGBZ21Fd7/AqzUICjyWKUXq
         w0YuA6WJ1DFyJnSSHzgq51qlO6tpDxtS5GhCmMBdpjtLbIhN4UjVlBLvb5SIa411+bFb
         yWR1aCooUq+EBqchLWdDnmLNmXtZT4ZRwvlk9RWqgyOjlsOlMYjk/GMJHJV3VhtkEf4n
         FV6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CgFiE1xRseB0L65/zcK0C8WvrsrBuQCopXkVzsqfP4E=;
        b=k2KlEFgjGGDI7g11MMfN5ZM29w5TKNZSRh8QlJIQ/rcq+38wOh2107OHPC3xCEKK9Q
         P5Bx4t5+BLK+USrxE/vBrG+wCuwyt65ZebHdeVMwp+9ScFgBojuQxL7KPkpmCf3mKwB5
         r7xiReMd/0s/SoooWnOhpNSjqlc5+pEVsY+U2/UHYg6lTUToi5HLIG2GauvsE2Ju2qJL
         +mzoqLc88AIjwydYKK/vA5kCDOm0S8mqLe1LcU3WGFkFzAMWE2k9a1X6vgper7jUlG5e
         QfpArloqfvg2F6nYfvEJtm250PtSQhoZUBb88ThHiMdU4nu1p0J2n1+7bqX7vYpW31LY
         ma7w==
X-Gm-Message-State: AOAM532rnot/mEq6MwsjaQkubSnimkCTIJpSXADABrEbu3SLgJ9yOEaD
        XieWHSKzo4wCTv9wbA2H1F6/LN10eUX3yA==
X-Google-Smtp-Source: ABdhPJwSTMtUkjOhIAUaA8niPZVsU4ZOP/r2y93VDyf6TzIZ5d4GZUGEWNMpOZygTAOvnzLH4O2h3A==
X-Received: by 2002:a2e:8041:: with SMTP id p1mr15023917ljg.331.1642407555032;
        Mon, 17 Jan 2022 00:19:15 -0800 (PST)
Received: from localhost ([46.188.51.186])
        by smtp.gmail.com with ESMTPSA id g15sm1321967lfv.113.2022.01.17.00.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 00:19:14 -0800 (PST)
Date:   Mon, 17 Jan 2022 11:19:05 +0300
From:   Alexander Fomichev <fomichev.ru@gmail.com>
To:     Mel Gorman <mgorman@suse.de>
Cc:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux@yadro.com, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC] Scheduler: DMA Engine regression because of sched/fair
 changes
Message-ID: <20220117081905.a4pwglxqj7dqpyql@yadro.com>
References: <20220112152609.gg2boujeh5vv5cns@yadro.com>
 <20220112170512.GO3301@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220112170512.GO3301@suse.de>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Jan 12, 2022 at 05:05:12PM +0000, Mel Gorman wrote:
> On Wed, Jan 12, 2022 at 06:26:09PM +0300, Alexander Fomichev wrote:
> > CC: Mel Gorman <mgorman@suse.de>
> > CC: linux@yadro.com
> > 
> > Hi all,
> > 
> > There's a huge regression found, which affects Intel Xeon's DMA Engine
> > performance between v4.14 LTS and modern kernels. In certain
> > circumstances the speed in dmatest is more than 6 times lower.
> > 
> > 	- Hardware -
> > I did testing on 2 systems:
> > 1) Intel(R) Xeon(R) Gold 6132 CPU @ 2.60GHz (Supermicro X11DAi-N)
> > 2) Intel(R) Xeon(R) Bronze 3204 CPU @ 1.90GHz (YADRO Vegman S220)
> > 
> > 	- Measurement -
> > The dmatest result speed decreases with almost any test settings.
> > Although the most significant impact is revealed with 64K transfers. The
> > following parameters were used:
> > 
> > modprobe dmatest iterations=1000 timeout=2000 test_buf_size=0x100000 transfer_size=0x10000 norandom=1
> > echo "dma0chan0" > /sys/module/dmatest/parameters/channel
> > echo 1 > /sys/module/dmatest/parameters/run
> > 
> > Every test csse was performed at least 3 times. All detailed results are
> > below.
> > 
> > 	- Analysis -
> > Bisecting revealed 2 different bad commits for those 2 systems, but both
> > change the same function/condition in the same file.
> > For the system (1) the bad commit is:
> > [7332dec055f2457c386032f7e9b2991eb05c2a0a] sched/fair: Only immediately migrate tasks due to interrupts if prev and target CPUs share cache
> > For the system (2) the bad commit is:
> > [806486c377e33ab662de6d47902e9e2a32b79368] sched/fair: Do not migrate if the prev_cpu is idle
> > 
> > 	- Additional check -
> > Attempting to revert the changes above, a dirty patch for the (current)
> > kernel v5.16.0-rc5 was tested too:
> > 
> 
> The consequences of the patch is allowing interrupts to migrate tasks away
> from potentially cache hot data -- L1 misses if the two CPUs share LLC
> or incurring remote memory access if migrating cross-node. The secondary
> concern is that excessive migration from interrupts that round-robin CPUs
> will mean that the CPU does not increase frequency. Minimally, the RFC
> patch introduces regressions of their own. The comments cover the two
> scenarios of interest
> 
> +        * If this_cpu is idle, it implies the wakeup is from interrupt
> +        * context. Only allow the move if cache is shared. Otherwise an
> +        * interrupt intensive workload could force all tasks onto one
> +        * node depending on the IO topology or IRQ affinity settings.
> 
> (This one causes remote memory accesses and potentially overutilisation
> of a subset of nodes)
> 
> +        * If the prev_cpu is idle and cache affine then avoid a migration.
> +        * There is no guarantee that the cache hot data from an interrupt
> +        * is more important than cache hot data on the prev_cpu and from
> +        * a cpufreq perspective, it's better to have higher utilisation
> +        * on one CPU.
> 
> (This one incurs L1/L2 misses due to a migration even though LLC may be
> shared)
> 
> The tests don't say but what CPUs to the dmatest interrupts get
> delivered to? dmatest appears to be an exception that the *only* hot
> data of concern is also related to the interrupt as the DMA operation is
> validated.
> 
> However, given that the point of a DMA engine is to transfer data without
> the host CPU being involved and the interrupt is delivered on completion,
> how realistic is it that the DMA data is immediately accessed on completion
> by normal workloads that happen to use the DMA engine? What impact does
> it have to tbe test is noverify or polling is used?

Thanks for the comment. Some additional notes regarding the issue.

1) You're right. When options "noverify=1" and "polling=1" are used.
then no performance reducing occurs.

2) DMA Engine on certain devices, e.g. Switchtec DMA and AMD PTDMA, is
used particularly for off-CPU data transfer via device's NTB to a remote
host. In NTRDMA project, which I'm involved to, DMA Engine sends data to
remote ring buffer and on data arrival CPU processes local ring buffers.

3) I checked dmatest with noverify=0 on PTDMA dirver: AMD EPYC 7313 16-Core
Processor/ASRock ROMED8-2T. The regression occurs on this hardware too.

4) Do you mean that with noverify=N and dirty patch, data verification
is performed on cached data and thus measured performance is fake?

5) What DMA Engine enabled drivers (and dmatest) should use as design
pattern to conform migration/cache behavior? Does scheduler optimisation
conflict to DMA Engine performance in general?

6) I didn't suggest RFC patch to real world usage. It was just a test
case to find out a low speed cause.

Comments/answers/suggestions are welcome.

-- 
Regards,
  Alexander
