Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95F85490FCF
	for <lists+dmaengine@lfdr.de>; Mon, 17 Jan 2022 18:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237226AbiAQRob (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 17 Jan 2022 12:44:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237179AbiAQRob (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 17 Jan 2022 12:44:31 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2AC2C061574;
        Mon, 17 Jan 2022 09:44:30 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id m1so60528423lfq.4;
        Mon, 17 Jan 2022 09:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Q8fxr20pIr+ESFSZOh2Cb0P9YmUl6xsNUhnn6jXR0dc=;
        b=eyAaBUYqljd6HQvRePdNJfbxTUq+yGUbx5rg6nFEWd/f/vJ+OZYaM5RUH/bo6Jvvdu
         ztxDYIBXmxHSMWp3UJKZ/f+gQ7oz2Eo82WNwberwKdbD2u+cRAu4yWzQWMmW4tNQ6WcS
         s4f4MDZCwEBDoeUTxN/7RJDDfPwC5EmTyPRdjLzu3nEoS6WiSYeHhdDHSYy18/QJNE/7
         MUu2CzPYmP1wBmyAIWutljn6/9liyPZ7cA+QvIHJxp1+9kUvq/U3R6qAO34uxFn/Iixt
         i4pSoGuOcVQEFtz/i6dH9UQa09gK6gykYuwePnWGiFdoyO1EQBgCxzOtptMBuYPYkrNA
         1vgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q8fxr20pIr+ESFSZOh2Cb0P9YmUl6xsNUhnn6jXR0dc=;
        b=2cMGvjMOIiw85w2x6CNdH2t8tSy+LJ1rTUIYw8qTYJxOqVRWeNJ+/dLHHwIDMgXfUE
         mjKTAXoQL3Mv/78bfdzACAi6y3AuHzTP74yecPKNet6EhdTOWkPHsmacCtZ2s0ucv7dB
         6zBj8RTJentS3QWFkNR+EfoWOtOp8JgGKmH0lJ/7V3ilsuJ55Eb4u7hqa4TqJGw/Z/qF
         FmseY65Sr7c66i07vZ+f0DBb5otRIHdByWzDrMilkNDCmEiaEd5ilMIZhgK3izV9YpIZ
         StgILSffaVqSR5Y3PZSGhQvt43q7v6yQ267ulJ6vBneZoO/zfqgbWtk6vKnA7cFrHYUf
         tjGg==
X-Gm-Message-State: AOAM533G4v0+aTsaerw4tk/B/0qwgmAVEOqyzpvpn+fxUc/DOd3JXj14
        DEP0jl2pcIIXIlXW/yH2dnA=
X-Google-Smtp-Source: ABdhPJxkcDRy7r51BNJ7SlHoNGsRKpfLyiA+hDeaRsQJPjL2AKZNJvXAQkzKn6VXAntBVWgd6vmmpg==
X-Received: by 2002:a2e:92c7:: with SMTP id k7mr14209005ljh.297.1642441469063;
        Mon, 17 Jan 2022 09:44:29 -0800 (PST)
Received: from localhost ([46.188.51.186])
        by smtp.gmail.com with ESMTPSA id bi15sm1449527lfb.140.2022.01.17.09.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 09:44:28 -0800 (PST)
Date:   Mon, 17 Jan 2022 20:44:19 +0300
From:   Alexander Fomichev <fomichev.ru@gmail.com>
To:     Mel Gorman <mgorman@suse.de>
Cc:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux@yadro.com, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC] Scheduler: DMA Engine regression because of sched/fair
 changes
Message-ID: <20220117174419.hqj2mz2ctrjdq57d@yadro.com>
References: <20220112152609.gg2boujeh5vv5cns@yadro.com>
 <20220112170512.GO3301@suse.de>
 <20220117081905.a4pwglxqj7dqpyql@yadro.com>
 <20220117102701.GQ3301@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220117102701.GQ3301@suse.de>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Jan 17, 2022 at 10:27:01AM +0000, Mel Gorman wrote:
> > 1) You're right. When options "noverify=1" and "polling=1" are used.
> > then no performance reducing occurs.
> 
> How about just noverify=1 on its own? It's a stronger indicator that
> cache hotness is a factor.
> 

With "noverify=1 polled=0" the performance reduction is only 10-20%,
but still exists.

-----< v5.15.8-vanilla >-----
[17057.866760] dmatest: Added 1 threads using dma0chan0
[17060.133880] dmatest: Started 1 threads using dma0chan0
[17060.154343] dmatest: dma0chan0-copy0: summary 1000 tests, 0 failures 49338.85 iops 3157686 KB/s (0)
[17063.737887] dmatest: Added 1 threads using dma0chan0
[17065.113838] dmatest: Started 1 threads using dma0chan0
[17065.137659] dmatest: dma0chan0-copy0: summary 1000 tests, 0 failures 42183.41 iops 2699738 KB/s (0)
[17100.339989] dmatest: Added 1 threads using dma0chan0
[17102.190764] dmatest: Started 1 threads using dma0chan0
[17102.214285] dmatest: dma0chan0-copy0: summary 1000 tests, 0 failures 42844.89 iops 2742073 KB/s (0)
-----< end >-----

-----< 5.15.8-ioat-ptdma-dirty-fix+ >-----
[ 6183.356549] dmatest: Added 1 threads using dma0chan0
[ 6187.868237] dmatest: Started 1 threads using dma0chan0
[ 6187.887389] dmatest: dma0chan0-copy0: summary 1000 tests, 0 failures 52753.74 iops 3376239 KB/s (0)
[ 6201.913154] dmatest: Added 1 threads using dma0chan0
[ 6204.701340] dmatest: Started 1 threads using dma0chan0
[ 6204.720490] dmatest: dma0chan0-copy0: summary 1000 tests, 0 failures 52614.96 iops 3367357 KB/s (0)
[ 6285.114603] dmatest: Added 1 threads using dma0chan0
[ 6287.031875] dmatest: Started 1 threads using dma0chan0
[ 6287.050278] dmatest: dma0chan0-copy0: summary 1000 tests, 0 failures 54939.01 iops 3516097 KB/s (0)
-----< end >-----

> > 2) DMA Engine on certain devices, e.g. Switchtec DMA and AMD PTDMA, is
> > used particularly for off-CPU data transfer via device's NTB to a remote
> > host. In NTRDMA project, which I'm involved to, DMA Engine sends data to
> > remote ring buffer and on data arrival CPU processes local ring buffers.
> > 
> 
> Is there any impact of the patch in this case? Given that it's a remote
> host, the data is likely cache cold anyway.
> 

It's complicated. Currently we have a bunch of problems with the
project. So we do decomposition and try to solve them separately. Here
we faced the DMA Engine issue.

> > 4) Do you mean that with noverify=N and dirty patch, data verification
> > is performed on cached data and thus measured performance is fake?
> > 
> 
> I think it's the data verification going slower because the tasks are
> not aggressively migrating on interrupt. The flip side is other
> interrupts such as IO completion should not migrate the tasks given that
> the interrupt is not necessarily correlated with data hotness.
> 

It's quite strange, because dmatest substitutes verification time from
overall test time. I suspect measurement may be inaccurate.

> > 5) What DMA Engine enabled drivers (and dmatest) should use as design
> > pattern to conform migration/cache behavior? Does scheduler optimisation
> > conflict to DMA Engine performance in general?
> > 
> 
> I'm not familiar with DMA engine drivers but if they use wake_up
> interfaces then passing WF_SYNC or calling the wake_up_*_sync helpers
> may force the migration.
> 

Thanks for the advice. I'll try to check if this is a solution.


-- 
Regards,
  Alexander
