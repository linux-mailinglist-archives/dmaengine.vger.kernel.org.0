Return-Path: <dmaengine+bounces-1765-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0FA89B2FC
	for <lists+dmaengine@lfdr.de>; Sun,  7 Apr 2024 18:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E737C1C21F6C
	for <lists+dmaengine@lfdr.de>; Sun,  7 Apr 2024 16:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4BA39AF2;
	Sun,  7 Apr 2024 16:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lz7s4n9i"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B0139AE7
	for <dmaengine@vger.kernel.org>; Sun,  7 Apr 2024 16:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712507904; cv=none; b=uzeGHGi1vU1KQ9sPzC4WhNmxts6tIjo/TN3w6orb5PiqBrwV10xxzJbCioitzuCefLEMhwBcAmGg/8fnHmpj/LOpAiKK9o48w8FPut7yUczYPc3lE5oPle8IS7U4hVFUXqL9maKO6Jeg+5aMH8HvPt5q4Nb9dyWUz9d5Wacl3Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712507904; c=relaxed/simple;
	bh=FAOK+1ogPj2CYqtRH6DOGi4MQhtO0hSMdMG0c1XAWh0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GQ34Wj+pDIqwphB6/xquGBMC9hUkYUUQfW5BrqSufmcGhvS5pY7i5QoEDYhT75udh4hefdeMUBKMXXMNhIB/j1WZOtyQE6UcJeipXK57/S8hq4y8PGvkvkUdMHBx1m4bCQGkowa1AgfmDQFOEfxtkULosVTKIkMrFPDkqK8Tg00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lz7s4n9i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E18D9C433C7;
	Sun,  7 Apr 2024 16:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712507903;
	bh=FAOK+1ogPj2CYqtRH6DOGi4MQhtO0hSMdMG0c1XAWh0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Lz7s4n9izQy/uKwwbF+kJa8tWs7/lFfGs5fGKvUIiuYbMX44Ms3q4zBhCR9hwsq0p
	 4RfvFhpnI/QMCI+Zr7ANn+z6SXvnTBY9eDwRM/CuLbhHoUwXm6gZqlEavZhOXOzRe3
	 EWBVyu5ycLRnOwUlPzCfGCVOnT0YFSMUsOLVwczykaqDuv/Wx3Z3fYj9qE4JNi3A33
	 hvlE2lWbHFpeJVwHPinv8YWboNY38pycLHJCbtf0hPp5eoNZMdwNgbg1zXIYeU/9Tw
	 J/3/andYyQkBwRiTPSq+N7UTo25L0lMFOIwpxQei+dM7+IsXrbDB4kPRFU2wbUByFG
	 j86ySro/WfJrA==
From: Vinod Koul <vkoul@kernel.org>
To: dmaengine@vger.kernel.org, Rex Zhang <rex.zhang@intel.com>
Cc: dave.jiang@intel.com, fenghua.yu@intel.com, lijun.pan@intel.com
In-Reply-To: <20231223060642.979483-1-rex.zhang@intel.com>
References: <20231223060642.979483-1-rex.zhang@intel.com>
Subject: Re: [PATCH v2] dmaengine: idxd: Convert spinlock to mutex to lock
 evl workqueue
Message-Id: <171250790148.435162.6131841757415946525.b4-ty@kernel.org>
Date: Sun, 07 Apr 2024 22:08:21 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Sat, 23 Dec 2023 14:06:42 +0800, Rex Zhang wrote:
> The drain_workqueue() is not in a locked context. In the multi-task case,
> it's possible to call queue_work() when drain_workqueue() is ongoing, then
> it can cause Call Trace due to pushing a work into a draining workqueue:
>     Call Trace:
>     <TASK>
>     ? __warn+0x7d/0x140
>     ? __queue_work+0x2b2/0x440
>     ? report_bug+0x1f8/0x200
>     ? handle_bug+0x3c/0x70
>     ? exc_invalid_op+0x18/0x70
>     ? asm_exc_invalid_op+0x1a/0x20
>     ? __queue_work+0x2b2/0x440
>     queue_work_on+0x28/0x30
>     idxd_misc_thread+0x303/0x5a0 [idxd]
>     ? __schedule+0x369/0xb40
>     ? __pfx_irq_thread_fn+0x10/0x10
>     ? irq_thread+0xbc/0x1b0
>     irq_thread_fn+0x21/0x70
>     irq_thread+0x102/0x1b0
>     ? preempt_count_add+0x74/0xa0
>     ? __pfx_irq_thread_dtor+0x10/0x10
>     ? __pfx_irq_thread+0x10/0x10
>     kthread+0x103/0x140
>     ? __pfx_kthread+0x10/0x10
>     ret_from_fork+0x31/0x50
>     ? __pfx_kthread+0x10/0x10
>     ret_from_fork_asm+0x1b/0x30
>     </TASK>
> The original lock for event log was spinlock, drain_workqueue() can't
> be in a spinlocked context because it may cause task rescheduling. The
> spinlock was called in thread and irq thread context, the current usages
> does not require a spinlock for event log, so it's feasible to convert
> spinlock to mutex.
> For putting drain_workqueue() into a locked context, convert the spinlock
> to mutex, then lock drain_workqueue() by mutex.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: idxd: Convert spinlock to mutex to lock evl workqueue
      commit: d5638de827cff0fce77007e426ec0ffdedf68a44

Best regards,
-- 
~Vinod



