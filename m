Return-Path: <dmaengine+bounces-1769-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B98989B304
	for <lists+dmaengine@lfdr.de>; Sun,  7 Apr 2024 18:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CE201C21FC2
	for <lists+dmaengine@lfdr.de>; Sun,  7 Apr 2024 16:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8493C472;
	Sun,  7 Apr 2024 16:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F1h7aBBq"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4408B3C467;
	Sun,  7 Apr 2024 16:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712507916; cv=none; b=Im0465tUMozm6KbpHMyEMLcSEwzeObK74R3d9KOMyW0F/HyNWHrlrGStr2unCxDmStouJ6pNCqo7xiJFGKXBdqlpaZxK/6hfZa+3oi4VPLZTpmUMzNUkP/2BlnyB6iIkgFpO5SGuWapg4E+nUN9YH+l1omFcP8dqLMpQ1SVeCAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712507916; c=relaxed/simple;
	bh=l4bciFilGDxgbieIFBfPBsWM6OS0Of5Tc625pbTHBcI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QITcD6i4av6zE6R2GLeN2mhu5GwCrCFGwF2R8f0o+vgEw4OztInndzr8rrdduC6H/c/ZHRU7bLC1sV0qk1yqErif+vUSWLcR2KFJjv+m4WSbif+oOF15SVh3dogKJ4iSsVYbBtE6e4HQszzwXWPh1xMTsNVy/X8jvQeTzP8asvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F1h7aBBq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80887C43390;
	Sun,  7 Apr 2024 16:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712507916;
	bh=l4bciFilGDxgbieIFBfPBsWM6OS0Of5Tc625pbTHBcI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=F1h7aBBq/AxKiT3sdAYHKrby3EVj9+gQFk1A0LyIOKUE+OTtPFU4sFS0s+SHs8e+1
	 i9oSj5plCuorCRj00pyLt0djy7zlBZe0fwKo8etbVQ2wp0KQo9UgphxjHzEJgwB7dE
	 RJiSrkSeEH1+QrTQdBhE/eYRs9lGKcnVVWk4KBniQfYwwqLDwnEigULJvxFcLqaDC0
	 EzJPBdVjCkWI+S5wbIn8Lu6KSulYBfPs2lVDoea9W4LN+nSsw2TVRaoG+0qBhillWo
	 2RePP0T387DGz0wdjvvoqMnESfcbcMM0dl36OKZSKKXPMxeVa9+pH0qNw3NUG6o8yP
	 5YiAyyFd4ANdw==
From: Vinod Koul <vkoul@kernel.org>
To: Dave Jiang <dave.jiang@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, 
 Terrence Xu <terrence.xu@intel.com>
In-Reply-To: <20240313214031.1658045-1-fenghua.yu@intel.com>
References: <20240313214031.1658045-1-fenghua.yu@intel.com>
Subject: Re: [PATCH] dmaengine: idxd: Fix oops during rmmod on single-CPU
 platforms
Message-Id: <171250791415.435162.15364939018197857010.b4-ty@kernel.org>
Date: Sun, 07 Apr 2024 22:08:34 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Wed, 13 Mar 2024 14:40:31 -0700, Fenghua Yu wrote:
> During the removal of the idxd driver, registered offline callback is
> invoked as part of the clean up process. However, on systems with only
> one CPU online, no valid target is available to migrate the
> perf context, resulting in a kernel oops:
> 
>     BUG: unable to handle page fault for address: 000000000002a2b8
>     #PF: supervisor write access in kernel mode
>     #PF: error_code(0x0002) - not-present page
>     PGD 1470e1067 P4D 0
>     Oops: 0002 [#1] PREEMPT SMP NOPTI
>     CPU: 0 PID: 20 Comm: cpuhp/0 Not tainted 6.8.0-rc6-dsa+ #57
>     Hardware name: Intel Corporation AvenueCity/AvenueCity, BIOS BHSDCRB1.86B.2492.D03.2307181620 07/18/2023
>     RIP: 0010:mutex_lock+0x2e/0x50
>     ...
>     Call Trace:
>     <TASK>
>     __die+0x24/0x70
>     page_fault_oops+0x82/0x160
>     do_user_addr_fault+0x65/0x6b0
>     __pfx___rdmsr_safe_on_cpu+0x10/0x10
>     exc_page_fault+0x7d/0x170
>     asm_exc_page_fault+0x26/0x30
>     mutex_lock+0x2e/0x50
>     mutex_lock+0x1e/0x50
>     perf_pmu_migrate_context+0x87/0x1f0
>     perf_event_cpu_offline+0x76/0x90 [idxd]
>     cpuhp_invoke_callback+0xa2/0x4f0
>     __pfx_perf_event_cpu_offline+0x10/0x10 [idxd]
>     cpuhp_thread_fun+0x98/0x150
>     smpboot_thread_fn+0x27/0x260
>     smpboot_thread_fn+0x1af/0x260
>     __pfx_smpboot_thread_fn+0x10/0x10
>     kthread+0x103/0x140
>     __pfx_kthread+0x10/0x10
>     ret_from_fork+0x31/0x50
>     __pfx_kthread+0x10/0x10
>     ret_from_fork_asm+0x1b/0x30
>     <TASK>
> 
> [...]

Applied, thanks!

[1/1] dmaengine: idxd: Fix oops during rmmod on single-CPU platforms
      commit: f221033f5c24659dc6ad7e5cf18fb1b075f4a8be

Best regards,
-- 
~Vinod



