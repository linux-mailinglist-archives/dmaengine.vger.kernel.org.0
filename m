Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6B8748C72C
	for <lists+dmaengine@lfdr.de>; Wed, 12 Jan 2022 16:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343601AbiALP0W (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 12 Jan 2022 10:26:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343589AbiALP0V (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 12 Jan 2022 10:26:21 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8085DC06173F;
        Wed, 12 Jan 2022 07:26:20 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id br17so9370626lfb.6;
        Wed, 12 Jan 2022 07:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=W3FY86n2dVRYMZ94C1JVe/XZFgcvtGbHSJ6xyUABmuM=;
        b=ZzdzY7uxdL36zuMBWIIZBTu2ow3ebdNvvnU29GBJoIg+Y9OinIdchXW0mtZ7Z8aj6d
         qxKXUXaR6+FoqHHM6hJhvyaHZER23dWNn/rtor82i0KSmcQRCNFK8C5T8NG4Dsj74/0h
         0V6k2rF+5fHcvEPG4iYTTKh0uGvB5vFHog4yXtzNy8NgLDS+oTbFR+bikdoNuInpvfS6
         JUDPbIbNNxt367vy6YQroX7tMEOmZRP6vIrgfzdkXisUdeaSZMT0y8FvT3FiWXENLkoW
         EW6XEn3iGfUA7UTYPdatevXJeYlPA6JeQ/UAmP6fRWYIAlNhAX1s51SpW0UbtBBKcD8o
         IxdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=W3FY86n2dVRYMZ94C1JVe/XZFgcvtGbHSJ6xyUABmuM=;
        b=SnCml09jkRPFuan/1wop0BosqwnJEpMo2UcQpbhD5kU8Y95/L9adCxO54UvQCdHxHN
         Uos32/P3myvovIK3Ho963/Z6m3UfI263Oh/QK7EFzsgJO3WJXDhN0bUU1sPkScSWyg+G
         nuzvKwjupyNdN7WgIiKONpyNYPE4kjDn9Ut9/FUBqSF8PqVDnmjxScdtcpuWz2Sf8Xyw
         3FfCLwDjUqJzXOGPzorXazLGDi8lHtWpj0GdgicjlSNI0S0KUQjmbfdxYCk+u/jDBBTy
         6KhP1f8L+bf3X4adZGAhvIV6rynt0W8IU+7oAwi1YaGQXw3yWGv8+z+A4p7Pd5801ivP
         jzCA==
X-Gm-Message-State: AOAM531CQw+8oYXAvx4fVSrK7L7t+i28SDCP+RW+TnO7oOIMJEddKRot
        6RYB5i0YVm13lGWamCeEAaruS6q5+Kl1JA==
X-Google-Smtp-Source: ABdhPJxqhJRdB0tGdjuEQ4nH9ycrn+lYrkDv94CrOYc9/hpo47FY3TBBdYXPlrqNWjJq7CawFKL94Q==
X-Received: by 2002:a05:651c:1505:: with SMTP id e5mr43098ljf.398.1642001178536;
        Wed, 12 Jan 2022 07:26:18 -0800 (PST)
Received: from localhost ([89.207.88.249])
        by smtp.gmail.com with ESMTPSA id j8sm17663lfe.156.2022.01.12.07.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 07:26:17 -0800 (PST)
Date:   Wed, 12 Jan 2022 18:26:09 +0300
From:   Alexander Fomichev <fomichev.ru@gmail.com>
To:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Cc:     Mel Gorman <mgorman@suse.de>, linux@yadro.com
Subject: [RFC] Scheduler: DMA Engine regression because of sched/fair changes
Message-ID: <20220112152609.gg2boujeh5vv5cns@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

CC: Mel Gorman <mgorman@suse.de>
CC: linux@yadro.com

Hi all,

There's a huge regression found, which affects Intel Xeon's DMA Engine
performance between v4.14 LTS and modern kernels. In certain
circumstances the speed in dmatest is more than 6 times lower.

	- Hardware -
I did testing on 2 systems:
1) Intel(R) Xeon(R) Gold 6132 CPU @ 2.60GHz (Supermicro X11DAi-N)
2) Intel(R) Xeon(R) Bronze 3204 CPU @ 1.90GHz (YADRO Vegman S220)

	- Measurement -
The dmatest result speed decreases with almost any test settings.
Although the most significant impact is revealed with 64K transfers. The
following parameters were used:

modprobe dmatest iterations=1000 timeout=2000 test_buf_size=0x100000 transfer_size=0x10000 norandom=1
echo "dma0chan0" > /sys/module/dmatest/parameters/channel
echo 1 > /sys/module/dmatest/parameters/run

Every test csse was performed at least 3 times. All detailed results are
below.

	- Analysis -
Bisecting revealed 2 different bad commits for those 2 systems, but both
change the same function/condition in the same file.
For the system (1) the bad commit is:
[7332dec055f2457c386032f7e9b2991eb05c2a0a] sched/fair: Only immediately migrate tasks due to interrupts if prev and target CPUs share cache
For the system (2) the bad commit is:
[806486c377e33ab662de6d47902e9e2a32b79368] sched/fair: Do not migrate if the prev_cpu is idle

	- Additional check -
Attempting to revert the changes above, a dirty patch for the (current)
kernel v5.16.0-rc5 was tested too:

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6f16dfb74246..0a58cc00b1b8 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5931,8 +5931,8 @@ wake_affine_idle(int this_cpu, int prev_cpu, int sync)
         * a cpufreq perspective, it's better to have higher utilisation
         * on one CPU.
         */
-       if (available_idle_cpu(this_cpu) && cpus_share_cache(this_cpu, prev_cpu))
-               return available_idle_cpu(prev_cpu) ? prev_cpu : this_cpu;
+       if (available_idle_cpu(this_cpu))
+               return this_cpu;

        if (sync && cpu_rq(this_cpu)->nr_running == 1)
                return this_cpu;

Please, take a look if this makes sense. But with this patch applied the
performance of DMA Engine restores.

	- Dmatest results TL;DR -

System (1) before bad commit:
---------------------
[  519.894642] dmatest: Added 1 threads using dma0chan0
[  525.383021] dmatest: Started 1 threads using dma0chan0
[  528.521915] dmatest: dma0chan0-copy0: summary 1000 tests, 0 failures 98367.10 iops 6295494 KB/s (0)
[  544.851751] dmatest: Added 1 threads using dma0chan0
[  546.460064] dmatest: Started 1 threads using dma0chan0
[  549.609504] dmatest: dma0chan0-copy0: summary 1000 tests, 0 failures 100310.96 iops 6419901 KB/s (0)
[  562.178365] dmatest: Added 1 threads using dma0chan0
[  563.852534] dmatest: Started 1 threads using dma0chan0
[  567.004898] dmatest: dma0chan0-copy0: summary 1000 tests, 0 failures 98580.44 iops 6309148 KB/s (0)
---------------------

System (1) on HEAD=bad commit:
---------------------
[  149.555401] dmatest: Added 1 threads using dma0chan0
[  154.162444] dmatest: Started 1 threads using dma0chan0
[  157.490868] dmatest: dma0chan0-copy0: summary 1000 tests, 0 failures 26653.87 iops 1705847 KB/s (0)
[  176.783450] dmatest: Added 1 threads using dma0chan0
[  178.428518] dmatest: Started 1 threads using dma0chan0
[  181.606531] dmatest: dma0chan0-copy0: summary 1000 tests, 0 failures 14194.86 iops 908471 KB/s (0)
[  192.125218] dmatest: Added 1 threads using dma0chan0
[  194.060029] dmatest: Started 1 threads using dma0chan0
[  197.235265] dmatest: dma0chan0-copy0: summary 1000 tests, 0 failures 14757.09 iops 944454 KB/s (0)
---------------------

Systen (1) on v5.16.0-rc5:
---------------------
[ 1430.860170] dmatest: Added 1 threads using dma0chan0
[ 1437.367447] dmatest: Started 1 threads using dma0chan0
[ 1442.756660] dmatest: dma0chan0-copy0: summary 1000 tests, 0 failures 24837.31 iops 1589588 KB/s (0)
[ 1561.614191] dmatest: Added 1 threads using dma0chan0
[ 1562.816375] dmatest: Started 1 threads using dma0chan0
[ 1566.619614] dmatest: dma0chan0-copy0: summary 1000 tests, 0 failures 13666.05 iops 874627 KB/s (0)
[ 1585.019601] dmatest: Added 1 threads using dma0chan0
[ 1587.585741] dmatest: Started 1 threads using dma0chan0
[ 1591.386816] dmatest: dma0chan0-copy0: summary 1000 tests, 0 failures 13521.91 iops 865402 KB/s (0)
---------------------

System (1) on v5.16.0-rc5 with dirty patch:
---------------------
[  733.571508] dmatest: Added 1 threads using dma0chan0
[  746.050800] dmatest: Started 1 threads using dma0chan0
[  749.765600] dmatest: dma0chan0-copy0: summary 1000 tests, 0 failures 87260.03 iops 5584642 KB/s (0)
[  915.051955] dmatest: Added 1 threads using dma0chan0
[  916.550732] dmatest: Started 1 threads using dma0chan0
[  920.267525] dmatest: dma0chan0-copy0: summary 1000 tests, 0 failures 88464.25 iops 5661712 KB/s (0)
[  936.781273] dmatest: Added 1 threads using dma0chan0
[  939.528616] dmatest: Started 1 threads using dma0chan0
[  943.247694] dmatest: dma0chan0-copy0: summary 1000 tests, 0 failures 88833.61 iops 5685351 KB/s (0)
---------------------

System (2) before bad commit:
---------------------
[  481.309411] dmatest: Added 1 threads using dma0chan0
[  491.197425] dmatest: Started 1 threads using dma0chan0
[  497.047315] dmatest: dma0chan0-copy0: summary 1000 tests, 0 failures 78988.94 iops 5055292 KB/s (0)
[  506.057101] dmatest: Added 1 threads using dma0chan0
[  508.939426] dmatest: Started 1 threads using dma0chan0
[  514.788823] dmatest: dma0chan0-copy0: summary 1000 tests, 0 failures 77754.44 iops 4976284 KB/s (0)
[  531.894587] dmatest: Added 1 threads using dma0chan0
[  534.053360] dmatest: Started 1 threads using dma0chan0
[  539.906424] dmatest: dma0chan0-copy0: summary 1000 tests, 0 failures 76988.21 iops 4927246 KB/s (0)
---------------------

System (2) on HEAD=bad commit:
---------------------
[44522.892995] dmatest: Added 1 threads using dma0chan0
[44526.193331] dmatest: Started 1 threads using dma0chan0
[44532.043932] dmatest: dma0chan0-copy0: summary 1000 tests, 0 failures 80360.01 iops 5143040 KB/s (0)
[44561.121118] dmatest: Added 1 threads using dma0chan0
[44562.868428] dmatest: Started 1 threads using dma0chan0
[44568.808577] dmatest: dma0chan0-copy0: summary 1000 tests, 0 failures 16080.53 iops 1029154 KB/s (0)
[44728.597409] dmatest: Added 1 threads using dma0chan0
[44730.301566] dmatest: Started 1 threads using dma0chan0
[44736.259009] dmatest: dma0chan0-copy0: summary 1000 tests, 0 failures 16091.91 iops 1029882 KB/s (0)
---------------------

Thanks for reading.

-- 
Regards,
  Alexander Fomichev
