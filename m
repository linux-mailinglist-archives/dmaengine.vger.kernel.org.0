Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B026493AAD
	for <lists+dmaengine@lfdr.de>; Wed, 19 Jan 2022 13:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244021AbiASMzZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 19 Jan 2022 07:55:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbiASMzZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 19 Jan 2022 07:55:25 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A992AC061574;
        Wed, 19 Jan 2022 04:55:24 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id m3so9205973lfu.0;
        Wed, 19 Jan 2022 04:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CkpzK6QyCgjOy6m0uZh925C04j1z8rB6D8/FeixmF08=;
        b=ZVmtZJhIxrDC84ho7SdnLpjeF1W0L1ijKtwOPuKBcoRBxpp6U7Fikw8V0CU+de0EeX
         fu7NsGHhrZILexhy7qkyNSvnag7YXXEvHL4Nh6QUGqy268I2cMB3EU5BNr6cNcAGeeEQ
         nMlqBb3yUsulNZx9EG6d69BWaRCyQoiXO7QfOp6CMEhYwAcUbGVvwBKs4NAUmIGBtbOB
         8PHRGgtk0ZaAaZwKso74chZ2wVn8RLb0yFTpCqRMU1d6ussT54ujNzepxC0rLDkcyxhJ
         bFu+IC5bjdJafjaLFE1gSk2qcylhMGa7+J3f1r1IIr/k8VLIu6pCm3VpupYbY5nPFZGK
         +pNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CkpzK6QyCgjOy6m0uZh925C04j1z8rB6D8/FeixmF08=;
        b=HcD3wNeQ1lnrOTfNCLdXW4jzEVmDzRF9JxgWXmnz3T1aLcFfmSh6/5exq4dfvtmHGK
         Mpo6WtGKEYZCtTPdl/udWnpAkGpu4UxIgn4CXeTYuqaLoCX1vfh0Aledzz9+aCghHow8
         9POFvxkk1a6RTX7b6iTdngJV3YdKTXQbH04wAXgws915ilfy+LmAzRTVSsWKRo6OVM/M
         fxKfHNgY+8HowcsSBgpysnU1bldr8ncC/Kg3R41jH8pkkNlHM96XXOQ7u8Ccum3F3jpg
         yjU7uWhKxHb+2AD8XXdH+s+FqCSevdQZ4x4KPI9DWx9YYyF8xfK2wtH7f9UntAjrtT97
         QqrQ==
X-Gm-Message-State: AOAM530jzKcscDxZJwIu/KwmGBASY7z9r05T7VyHhYp1r4DYyippP1Ss
        7dwo1ptimFF7Wa02JJfQuX8=
X-Google-Smtp-Source: ABdhPJwAOMrkyUduYOuKrHQsIP5HtvIhdODe/m4cilEFyPaRYVH3U2NlYqGtD0WScq3NqLsgrXcGmQ==
X-Received: by 2002:a05:6512:3a86:: with SMTP id q6mr21372729lfu.649.1642596922941;
        Wed, 19 Jan 2022 04:55:22 -0800 (PST)
Received: from localhost ([89.207.88.249])
        by smtp.gmail.com with ESMTPSA id y20sm221791lji.82.2022.01.19.04.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 04:55:21 -0800 (PST)
Date:   Wed, 19 Jan 2022 15:55:13 +0300
From:   Alexander Fomichev <fomichev.ru@gmail.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux@yadro.com,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC] Scheduler: DMA Engine regression because of sched/fair
 changes
Message-ID: <20220119125513.bpnf563tjc2u6g47@yadro.com>
References: <20220112152609.gg2boujeh5vv5cns@yadro.com>
 <20220112170512.GO3301@suse.de>
 <20220117081905.a4pwglxqj7dqpyql@yadro.com>
 <20220117102701.GQ3301@suse.de>
 <20220118020448.2399-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220118020448.2399-1-hdanton@sina.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Jan 18, 2022 at 10:04:48AM +0800, Hillf Danton wrote:
> On Mon, 17 Jan 2022 20:44:19 +0300 Alexander Fomichev wrote:
> > On Mon, Jan 17, 2022 at 10:27:01AM +0000, Mel Gorman wrote:
> > > > 1) You're right. When options "noverify=1" and "polling=1" are used.
> > > > then no performance reducing occurs.
> > > 
> > > How about just noverify=1 on its own? It's a stronger indicator that
> > > cache hotness is a factor.
> > > 
> > 
> > With "noverify=1 polled=0" the performance reduction is only 10-20%,
> > but still exists.
> > 
> > -----< v5.15.8-vanilla >-----
> > [17057.866760] dmatest: Added 1 threads using dma0chan0
> > [17060.133880] dmatest: Started 1 threads using dma0chan0
> > [17060.154343] dmatest: dma0chan0-copy0: summary 1000 tests, 0 failures 49338.85 iops 3157686 KB/s (0)
> > [17063.737887] dmatest: Added 1 threads using dma0chan0
> > [17065.113838] dmatest: Started 1 threads using dma0chan0
> > [17065.137659] dmatest: dma0chan0-copy0: summary 1000 tests, 0 failures 42183.41 iops 2699738 KB/s (0)
> > [17100.339989] dmatest: Added 1 threads using dma0chan0
> > [17102.190764] dmatest: Started 1 threads using dma0chan0
> > [17102.214285] dmatest: dma0chan0-copy0: summary 1000 tests, 0 failures 42844.89 iops 2742073 KB/s (0)
> > -----< end >-----
> > 
> > -----< 5.15.8-ioat-ptdma-dirty-fix+ >-----
> > [ 6183.356549] dmatest: Added 1 threads using dma0chan0
> > [ 6187.868237] dmatest: Started 1 threads using dma0chan0
> > [ 6187.887389] dmatest: dma0chan0-copy0: summary 1000 tests, 0 failures 52753.74 iops 3376239 KB/s (0)
> > [ 6201.913154] dmatest: Added 1 threads using dma0chan0
> > [ 6204.701340] dmatest: Started 1 threads using dma0chan0
> > [ 6204.720490] dmatest: dma0chan0-copy0: summary 1000 tests, 0 failures 52614.96 iops 3367357 KB/s (0)
> > [ 6285.114603] dmatest: Added 1 threads using dma0chan0
> > [ 6287.031875] dmatest: Started 1 threads using dma0chan0
> > [ 6287.050278] dmatest: dma0chan0-copy0: summary 1000 tests, 0 failures 54939.01 iops 3516097 KB/s (0)
> > -----< end >-----
> > 
> 
> Check if cold cache provides some room for selecting CPU.
> 
> Only for thoughts now.
> 
> Hillf
> 
> +++ x/kernel/sched/fair.c
> @@ -5889,19 +5889,16 @@ static int
>  wake_affine_idle(int this_cpu, int prev_cpu, int sync)
>  {
>  	/*
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
> +	 * select this cpu if both are idle because of
> +	 * cold shared cache
>  	 */
> -	if (available_idle_cpu(this_cpu) && cpus_share_cache(this_cpu, prev_cpu))
> -		return available_idle_cpu(prev_cpu) ? prev_cpu : this_cpu;
> +	if (cpus_share_cache(this_cpu, prev_cpu)) {
> +		if (available_idle_cpu(this_cpu))
> +			return this_cpu;
> +
> +		if (available_idle_cpu(prev_cpu))
> +			return prev_cpu;
> +	}
>  
>  	if (sync && cpu_rq(this_cpu)->nr_running == 1)
>  		return this_cpu;

Hi Hillf,

The results with your patch are controversial:

-----< v5.15.8-Hillf-Danton-patch+ >-----
[ 1572.178884] dmatest: Added 1 threads using dma0chan0
[ 1577.413535] dmatest: Started 1 threads using dma0chan0
[ 1577.432495] dmatest: dma0chan0-copy0: summary 1000 tests, 0 failures 53188.66 iops 3404074 KB/s (0)
[ 1592.356173] dmatest: Added 1 threads using dma0chan0
[ 1593.791100] dmatest: Started 1 threads using dma0chan0
[ 1593.815282] dmatest: dma0chan0-copy0: summary 1000 tests, 0 failures 41668.40 iops 2666777 KB/s (0)
[ 1617.117040] dmatest: Added 1 threads using dma0chan0
[ 1619.545890] dmatest: Started 1 threads using dma0chan0
[ 1619.569639] dmatest: dma0chan0-copy0: summary 1000 tests, 0 failures 42426.81 iops 2715316 KB/s (0)
-----< end >-----

Just to remind, used dmatest parameters:

/sys/module/dmatest/parameters/iterations:1000
/sys/module/dmatest/parameters/alignment:-1
/sys/module/dmatest/parameters/verbose:N
/sys/module/dmatest/parameters/norandom:Y
/sys/module/dmatest/parameters/max_channels:0
/sys/module/dmatest/parameters/dmatest:0
/sys/module/dmatest/parameters/polled:N
/sys/module/dmatest/parameters/threads_per_chan:1
/sys/module/dmatest/parameters/noverify:Y
/sys/module/dmatest/parameters/test_buf_size:1048576
/sys/module/dmatest/parameters/transfer_size:65536
/sys/module/dmatest/parameters/run:N
/sys/module/dmatest/parameters/wait:Y
/sys/module/dmatest/parameters/timeout:2000
/sys/module/dmatest/parameters/xor_sources:3
/sys/module/dmatest/parameters/pq_sources:3


-- 
Regards,
  Alexander
