Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8B8C49FE60
	for <lists+dmaengine@lfdr.de>; Fri, 28 Jan 2022 17:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239528AbiA1QvK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 28 Jan 2022 11:51:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245358AbiA1QvJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 28 Jan 2022 11:51:09 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E1FC061714;
        Fri, 28 Jan 2022 08:51:08 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id e17so9874246ljk.5;
        Fri, 28 Jan 2022 08:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=edh+gQ6yhY/He+pkxj+P6wGsnjq947gdpUu4H2TBVdE=;
        b=fGm/ro4/78ymjqHneLtVbXUu5402zkPY1bFHqqzCx+Yo3aBYFmWwSxmlvGkl1AmJ8F
         ZfZeTgAPcBg9rrHVIGj60Im2LaJJLU17uYsbuAaOZBVt1cWcnwBupUYe8e3ptPmfeEPP
         t829cK/Rsszn+SWUTnbP/AfmqE3gu4Q9hD6ZuRQva7F3JOoxKwJv7ho+gIpzbcLZ5xW6
         9lBvLcFX7bDdDMRIFFg7bZ7qsBethY/za/FpdlJZlrP30XkMfy5zkEdXj8nlskQ7YcCE
         YqLgnM2rp+9QJLfbg5BGc+vDKaXl14/K8wOfaykU40vcStDW8Q+jE6Y95ZaatrpV4VXS
         6AJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=edh+gQ6yhY/He+pkxj+P6wGsnjq947gdpUu4H2TBVdE=;
        b=6OHC5FPsRRuhwRVOe+qEgISQGzIL7zzrB1UtQ/LBpIJtQPMMF2WTPRgn5F2Ws9RqUw
         J/UPUXnKMjO8SM9VOF3YOaLBIxs2jC5BQ0ahh46fv5wUmBUE4dwTPEV8pZy2SO3PwsYn
         0zeSAb3Jd1Cb6GivbMJGrNJ2K1AzYgMq+mCfCbl5bKAwTSjyBO4jJe4R4ZjBONGCa7jm
         AveL6SOHCY2SIPdpYhF426bZpAAA92CscfzaloJWWOFF5EC780HAVBkkb2TCMXRbo5EP
         H8YVTyeF0Ta6XMwdhN7nyXCNbFgXNUDeKzGGZH5hoe6Bh2amD2TSPy4bCykQFFERwgsW
         DVYA==
X-Gm-Message-State: AOAM531e6tNIjrjyHLiw4F6ktYD+mIFfyuqRNQMtyDORXNpOjTI8Jw/M
        VCMQgfPFJICkuYe7DgQtdVU=
X-Google-Smtp-Source: ABdhPJz/OcViveQ0LwJLqY3AeuyjpR4X6Gu2AdYbyM9OmMmIoEyJAfrdnySrgfovLQlv2IShWHAWkA==
X-Received: by 2002:a2e:a361:: with SMTP id i1mr6354533ljn.146.1643388667100;
        Fri, 28 Jan 2022 08:51:07 -0800 (PST)
Received: from localhost ([46.188.51.186])
        by smtp.gmail.com with ESMTPSA id j29sm2010104lfk.285.2022.01.28.08.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 08:51:06 -0800 (PST)
Date:   Fri, 28 Jan 2022 19:50:58 +0300
From:   Alexander Fomichev <fomichev.ru@gmail.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux@yadro.com,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC] Scheduler: DMA Engine regression because of sched/fair
 changes
Message-ID: <20220128165058.zxyrnd7nzr4hlks2@yadro.com>
References: <20220112152609.gg2boujeh5vv5cns@yadro.com>
 <20220112170512.GO3301@suse.de>
 <20220117081905.a4pwglxqj7dqpyql@yadro.com>
 <20220117102701.GQ3301@suse.de>
 <20220118020448.2399-1-hdanton@sina.com>
 <20220121101217.2849-1-hdanton@sina.com>
 <20220122233314.2999-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220122233314.2999-1-hdanton@sina.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sun, Jan 23, 2022 at 07:33:14AM +0800, Hillf Danton wrote:
> 
> Lets put pieces together based on the data collected.
> 
> 1, No irq migration was observed.
> 
> 2, Your patch that produced the highest iops fo far
> 
> -----< 5.15.8-ioat-ptdma-dirty-fix+ >-----
> [ 6183.356549] dmatest: Added 1 threads using dma0chan0
> [ 6187.868237] dmatest: Started 1 threads using dma0chan0
> [ 6187.887389] dmatest: dma0chan0-copy0: summary 1000 tests, 0 failures 52753.74 iops 3376239 KB/s (0)
> [ 6201.913154] dmatest: Added 1 threads using dma0chan0
> [ 6204.701340] dmatest: Started 1 threads using dma0chan0
> [ 6204.720490] dmatest: dma0chan0-copy0: summary 1000 tests, 0 failures 52614.96 iops 3367357 KB/s (0)
> [ 6285.114603] dmatest: Added 1 threads using dma0chan0
> [ 6287.031875] dmatest: Started 1 threads using dma0chan0
> [ 6287.050278] dmatest: dma0chan0-copy0: summary 1000 tests, 0 failures 54939.01 iops 3516097 KB/s (0)
> -----< end >-----
> 
> 
> -       if (available_idle_cpu(this_cpu) && cpus_share_cache(this_cpu, prev_cpu))
> -               return available_idle_cpu(prev_cpu) ? prev_cpu : this_cpu;
> +       if (available_idle_cpu(this_cpu))
> +               return this_cpu;
> 
> prefers this cpu if it is idle regardless of cache affinity.
> 
> This implies task migration to the cpu that handled irq.
> 
> 3, Given this cpu is different from the prev cpu in addition to no irq
> migration, the tested task was bouncing between the two cpus, with one
> more question rising, why was task migrated off from the irq-handling cpu?
> 
> Despite no evidence, I bet no bounce occurred given iops observed.
> 

IMHO, your assumptions are correct.
I've added CPU number counters on every step of dmatest. It reveals that
test task migration between (at least 2) CPUs occurs in even one thread
mode. Below is for vanilla 5.15.8 kernel:

-----< threads_per_chan=1 >-----
[19449.557950] dmatest: Added 1 threads using dma0chan0
[19469.238180] dmatest: Started 1 threads using dma0chan0
[19469.253962] dmatest: dma0chan0-copy0: summary 1000 tests, 0 failures 65291.19 iops 4178636 KB/s (0)
[19469.253973] dmatest: CPUs hit: #52:417 #63:583  (times)
-----< end >-----

Note that IRQ handler runs on CPU #52 in this environment.

In 4 thread mode the task migrates even more aggressively:

-----< threads_per_chan=4 >-----
[19355.460227] dmatest: Added 4 threads using dma0chan0
[19359.841182] dmatest: Started 4 threads using dma0chan0
[19359.860447] dmatest: dma0chan0-copy3: summary 1000 tests, 0 failures 53908.35 iops 3450134 KB/s (0)
[19359.860451] dmatest: dma0chan0-copy2: summary 1000 tests, 0 failures 54179.98 iops 3467519 KB/s (0)
[19359.860456] dmatest: CPUs hit: #50:1000  (times)
[19359.860459] dmatest: CPUs hit: #17:1000  (times)
[19359.860459] dmatest: dma0chan0-copy0: summary 1000 tests, 0 failures 54048.21 iops 3459085 KB/s (0)
[19359.860466] dmatest: CPUs hit: #31:1000  (times)
[19359.861420] dmatest: dma0chan0-copy1: summary 1000 tests, 0 failures 51466.80 iops 3293875 KB/s (0)
[19359.861425] dmatest: CPUs hit: #30:213 #48:556 #52:231  (times)
-----< end >-----

On the other hand, for dirty-patched kernel task doesn't migrate:

-----< patched threads_per_chan=1 >-----
[ 2100.142002] dmatest: Added 1 threads using dma0chan0
[ 2102.359727] dmatest: Started 1 threads using dma0chan0
[ 2102.373594] dmatest: dma0chan0-copy0: summary 1000 tests, 0 failures 76173.06 iops 4875076 KB/s (0)
[ 2102.373600] dmatest: CPUs hit: #49:1000  (times)
-----< end >-----

IRQ handler runs on CPU #49 in this case.

Although in 4 thread mode the task still migrates. I think we should
consider such scenario as non-relevant for this isue.

-- 
Regards,
  Alexander
