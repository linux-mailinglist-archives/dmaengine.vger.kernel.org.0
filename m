Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F11148C90D
	for <lists+dmaengine@lfdr.de>; Wed, 12 Jan 2022 18:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355424AbiALRFT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 12 Jan 2022 12:05:19 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:49002 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349872AbiALRFR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 12 Jan 2022 12:05:17 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B30B2218E0;
        Wed, 12 Jan 2022 17:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1642007114; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zb6mFk8u5fWvpkJoxss3VEsUi0IprcWX5qPRtsRll/s=;
        b=qm/QkZtahI/FG2O1CtF6VHZisgqom435ISTYkpV8REehFFvDdNxTcH3bGm9HHQoj0PSrFE
        hmp/2InAIFDQlzn8E8W9OXvlJKyuKwHVCQQaRWmHiOPPTfuas3dsrfNCNDGaK/sdHsipre
        FF2hqq+zqCLJKusw/sbRNZ4Hwo0iyzk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1642007114;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zb6mFk8u5fWvpkJoxss3VEsUi0IprcWX5qPRtsRll/s=;
        b=vQdR2hTPwvBAloFpCZeNHxdMIMPbEv5o250NrDWFBrw9zssinJOOudjVH8jBFH6n9FVDKy
        5Mv2H6Hfr0HwU1Bw==
Received: from suse.de (unknown [10.163.43.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 691B3A3B83;
        Wed, 12 Jan 2022 17:05:14 +0000 (UTC)
Date:   Wed, 12 Jan 2022 17:05:12 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Alexander Fomichev <fomichev.ru@gmail.com>
Cc:     linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux@yadro.com, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC] Scheduler: DMA Engine regression because of sched/fair
 changes
Message-ID: <20220112170512.GO3301@suse.de>
References: <20220112152609.gg2boujeh5vv5cns@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20220112152609.gg2boujeh5vv5cns@yadro.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Jan 12, 2022 at 06:26:09PM +0300, Alexander Fomichev wrote:
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
> 
> 	- Additional check -
> Attempting to revert the changes above, a dirty patch for the (current)
> kernel v5.16.0-rc5 was tested too:
> 

The consequences of the patch is allowing interrupts to migrate tasks away
from potentially cache hot data -- L1 misses if the two CPUs share LLC
or incurring remote memory access if migrating cross-node. The secondary
concern is that excessive migration from interrupts that round-robin CPUs
will mean that the CPU does not increase frequency. Minimally, the RFC
patch introduces regressions of their own. The comments cover the two
scenarios of interest

+        * If this_cpu is idle, it implies the wakeup is from interrupt
+        * context. Only allow the move if cache is shared. Otherwise an
+        * interrupt intensive workload could force all tasks onto one
+        * node depending on the IO topology or IRQ affinity settings.

(This one causes remote memory accesses and potentially overutilisation
of a subset of nodes)

+        * If the prev_cpu is idle and cache affine then avoid a migration.
+        * There is no guarantee that the cache hot data from an interrupt
+        * is more important than cache hot data on the prev_cpu and from
+        * a cpufreq perspective, it's better to have higher utilisation
+        * on one CPU.

(This one incurs L1/L2 misses due to a migration even though LLC may be
shared)

The tests don't say but what CPUs to the dmatest interrupts get
delivered to? dmatest appears to be an exception that the *only* hot
data of concern is also related to the interrupt as the DMA operation is
validated.

However, given that the point of a DMA engine is to transfer data without
the host CPU being involved and the interrupt is delivered on completion,
how realistic is it that the DMA data is immediately accessed on completion
by normal workloads that happen to use the DMA engine? What impact does
it have to tbe test is noverify or polling is used?

-- 
Mel Gorman
SUSE Labs
