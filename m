Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA221495FEF
	for <lists+dmaengine@lfdr.de>; Fri, 21 Jan 2022 14:46:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380567AbiAUNqy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 21 Jan 2022 08:46:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380591AbiAUNqw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 21 Jan 2022 08:46:52 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6F6C061574;
        Fri, 21 Jan 2022 05:46:52 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id p27so34075515lfa.1;
        Fri, 21 Jan 2022 05:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CbBhtk+FwZeZiOwygU4RpebRe7o9G8cdyJXAclSwLLM=;
        b=FNlOu2aTk58X7VLO1V57HUjxdnxJrz3XpW4USxal+A4eNLs9bDx4Suukp0bOmgrqev
         hoDYmKpsyOberf63mUEMZxJHeZsuBCl3nEqP59+TBxNuKL5H6N4jKwb+UsGLRDBAtv8h
         s60GnDZLpSPtiHbv4AKEGW9XGq1ibyzDUnrlet/8YqpeRY8Amwgb02plVod2yYEktd2n
         6WgJu7QPKSPn/oMEYL+1ljNOcFNv3BXFwbJW5p7cFM0f6UBKOY5vVutuHHSi5TV0SiSq
         PJqmAz/zcpytvli5C98+N4kHCYKW8C9t88/lf20LuAuR6tcl//UcFAQp0nfZZhVvj8Hn
         PWXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CbBhtk+FwZeZiOwygU4RpebRe7o9G8cdyJXAclSwLLM=;
        b=uuYJ12DD6FNg3TQDkcZiva7dPqqdRswTepF0hG227/Mrfs1xNlzeRiOu/cljhtJERM
         Yq02C1VbYOQ3nd4/spGDIrs6zifrr53r6OwyJI0HQOOBKlnNTLnW4GgQfVQ4R/pHTyV4
         2DHUbD+FpFuLyLqNttpn9eHKHq/qpvxo3kjEEsv8eQ1mh/Iv8qn2f3yRiA7jrS42KqLg
         E81Vz7ZPhCDgNERBn+O9zYKLGZe1KNnSaBWfLt6IB7v2BuJ2GCuUezJrvm83joHA/AAV
         NAnVw43M3CdZ7vB6qaDsKMFGxS6Wr6gGIzSgVOloAavT2VMIzMfmnW7pHOFLw31CKnOS
         XohQ==
X-Gm-Message-State: AOAM533RPzyz4xOiUcXBBd37+AUUTkyOr44WR8Vyb6nUCbOa/Ndvebwn
        ZjufmAXPeNybihZXtjRTP5A=
X-Google-Smtp-Source: ABdhPJxdELd84UCu9UZX5X2OOAJO7w4TJhSRCVa3eHg9e+fXNr+QYibXtTTV5U/MRkaiOf8bLkZMFQ==
X-Received: by 2002:ac2:5e85:: with SMTP id b5mr3841501lfq.0.1642772810532;
        Fri, 21 Jan 2022 05:46:50 -0800 (PST)
Received: from localhost ([46.188.51.186])
        by smtp.gmail.com with ESMTPSA id b5sm258238lft.301.2022.01.21.05.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 05:46:49 -0800 (PST)
Date:   Fri, 21 Jan 2022 16:46:40 +0300
From:   Alexander Fomichev <fomichev.ru@gmail.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux@yadro.com,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC] Scheduler: DMA Engine regression because of sched/fair
 changes
Message-ID: <20220121134640.ghdq3wbwa5jcfplz@yadro.com>
References: <20220112152609.gg2boujeh5vv5cns@yadro.com>
 <20220112170512.GO3301@suse.de>
 <20220117081905.a4pwglxqj7dqpyql@yadro.com>
 <20220117102701.GQ3301@suse.de>
 <20220118020448.2399-1-hdanton@sina.com>
 <20220121101217.2849-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220121101217.2849-1-hdanton@sina.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Jan 21, 2022 at 06:12:17PM +0800, Hillf Danton wrote:
> On Wed, 19 Jan 2022 15:55:13 +0300 Alexander Fomichev wrote:
> >On Tue, Jan 18, 2022 at 10:04:48AM +0800, Hillf Danton wrote:
> >> On Mon, 17 Jan 2022 20:44:19 +0300 Alexander Fomichev wrote:
> >> > On Mon, Jan 17, 2022 at 10:27:01AM +0000, Mel Gorman wrote:
> >> > 
> >> > -----< v5.15.8-vanilla >-----
> >> > [17057.866760] dmatest: Added 1 threads using dma0chan0
> >> > [17060.133880] dmatest: Started 1 threads using dma0chan0
> >> > [17060.154343] dmatest: dma0chan0-copy0: summary 1000 tests, 0 failures 49338.85 iops 3157686 KB/s (0)
> >> > [17063.737887] dmatest: Added 1 threads using dma0chan0
> >> > [17065.113838] dmatest: Started 1 threads using dma0chan0
> >> > [17065.137659] dmatest: dma0chan0-copy0: summary 1000 tests, 0 failures 42183.41 iops 2699738 KB/s (0)
> >> > [17100.339989] dmatest: Added 1 threads using dma0chan0
> >> > [17102.190764] dmatest: Started 1 threads using dma0chan0
> >> > [17102.214285] dmatest: dma0chan0-copy0: summary 1000 tests, 0 failures 42844.89 iops 2742073 KB/s (0)
> >> > -----< end >-----
> >> > 
> >
> >Just to remind, used dmatest parameters:
> >
> >/sys/module/dmatest/parameters/iterations:1000
> >/sys/module/dmatest/parameters/alignment:-1
> >/sys/module/dmatest/parameters/verbose:N
> >/sys/module/dmatest/parameters/norandom:Y
> >/sys/module/dmatest/parameters/max_channels:0
> >/sys/module/dmatest/parameters/dmatest:0
> >/sys/module/dmatest/parameters/polled:N
> >/sys/module/dmatest/parameters/threads_per_chan:1
> >/sys/module/dmatest/parameters/noverify:Y
> >/sys/module/dmatest/parameters/test_buf_size:1048576
> >/sys/module/dmatest/parameters/transfer_size:65536
> >/sys/module/dmatest/parameters/run:N
> >/sys/module/dmatest/parameters/wait:Y
> >/sys/module/dmatest/parameters/timeout:2000
> >/sys/module/dmatest/parameters/xor_sources:3
> >/sys/module/dmatest/parameters/pq_sources:3
> 
> 
> See if tuning back down 10 degree can close the gap in iops, in the
> assumption that the prev CPU can be ignored in case of cold cache.
> 
> Also want to see the diff in output of "cat /proc/interrupts" before
> and after dmatest, wondering if the dma irq is bond to a CPU core of
> dancing on several ones.
> 
> Hillf
> 
> +++ x/kernel/sched/fair.c
> @@ -5888,20 +5888,10 @@ static int wake_wide(struct task_struct
>  static int
>  wake_affine_idle(int this_cpu, int prev_cpu, int sync)
>  {
> -	/*
> -	 * If this_cpu is idle, it implies the wakeup is from interrupt
> -	 * context. Only allow the move if cache is shared. Otherwise an
> -	 * interrupt intensive workload could force all tasks onto one
> -	 * node depending on the IO topology or IRQ affinity settings.
> -	 *
> -	 * If the prev_cpu is idle and cache affine then avoid a migration.
> -	 * There is no guarantee that the cache hot data from an interrupt
> -	 * is more important than cache hot data on the prev_cpu and from
> -	 * a cpufreq perspective, it's better to have higher utilisation
> -	 * on one CPU.
> -	 */
> -	if (available_idle_cpu(this_cpu) && cpus_share_cache(this_cpu, prev_cpu))
> -		return available_idle_cpu(prev_cpu) ? prev_cpu : this_cpu;
> +	/* select this cpu because of cold cache */
> +	if (cpus_share_cache(this_cpu, prev_cpu))
> +		if (available_idle_cpu(this_cpu))
> +			return this_cpu;
>  
>  	if (sync && cpu_rq(this_cpu)->nr_running == 1)
>  		return this_cpu;
> --

Hi Hillf,

Thanks for the information.
With the recent patch (I called it patch2) the results are following:

-----< 5.15.8-Hillf-Danton-patch2+ noverify=Y >-----
[  646.568455] dmatest: Added 1 threads using dma0chan0
[  661.127077] dmatest: Started 1 threads using dma0chan0
[  661.147156] dmatest: dma0chan0-copy0: summary 1000 tests, 0 failures 50251.25 iops 3216080 KB/s (0)
[  675.132323] dmatest: Added 1 threads using dma0chan0
[  676.205829] dmatest: Started 1 threads using dma0chan0
[  676.225991] dmatest: dma0chan0-copy0: summary 1000 tests, 0 failures 50022.50 iops 3201440 KB/s (0)
[  703.100813] dmatest: Added 1 threads using dma0chan0
[  704.933579] dmatest: Started 1 threads using dma0chan0
[  704.953733] dmatest: dma0chan0-copy0: summary 1000 tests, 0 failures 49950.04 iops 3196803 KB/s (0)
-----< end >-----

Also I have re-run the test with 'noverify=N' option, just for
illustration.

-----< 5.15.8-Hillf-Danton-patch2+ noverify=N >-----
[ 1614.739687] dmatest: Added 1 threads using dma0chan0
[ 1620.346536] dmatest: Started 1 threads using dma0chan0
[ 1623.254880] dmatest: dma0chan0-copy0: summary 1000 tests, 0 failures 23544.92 iops 1506875 KB/s (0)
[ 1634.974200] dmatest: Added 1 threads using dma0chan0
[ 1635.981532] dmatest: Started 1 threads using dma0chan0
[ 1638.892182] dmatest: dma0chan0-copy0: summary 1000 tests, 0 failures 23703.98 iops 1517055 KB/s (0)
[ 1652.878143] dmatest: Added 1 threads using dma0chan0
[ 1655.235130] dmatest: Started 1 threads using dma0chan0
[ 1658.143206] dmatest: dma0chan0-copy0: summary 1000 tests, 0 failures 23526.64 iops 1505705 KB/s (0)
-----< end >-----

/proc/interrupts changes before/after the test:

-----< interrupts.diff >-----
- 184:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0       6000          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 103813120-edge      0000:c6:00.2
+ 184:          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0          0       9000          0          0          0          0          0          0          0          0          0          0          0  IR-PCI-MSI 103813120-edge      0000:c6:00.2
-----< end >-----

It looks like the MSI handler is called on the same CPU all the time.

-- 
Regards,
  Alexander
