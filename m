Return-Path: <dmaengine+bounces-779-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1D4836228
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jan 2024 12:41:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B95D11F268E6
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jan 2024 11:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3A83A8ED;
	Mon, 22 Jan 2024 11:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTu4K4tx"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B34C3A8EA
	for <dmaengine@vger.kernel.org>; Mon, 22 Jan 2024 11:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705923244; cv=none; b=k6MFkrE9HJtKxZeBnBakfN5k5DaU3oxtVVbLom+pKTaG/Ly4IPJ9nMsJk7JhHpOPSnD2rSgMR3EeNCrOuLBVM3Dq0j3lThty11UYKRL1VVLU7sdbFSS8B76YLleAeUHnAhJqfLHQznsW9Yl0OnS2SI6vic4bDPebWF/LaBNg4K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705923244; c=relaxed/simple;
	bh=z5DMXM53E813UdCKMC58hKWzVQkRAktlvHuLy9BMKUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y83cGLpUYYDmFIjTcXovngSpVRKBALAtGkdDYAbAHpA59aAhKVgc7weG8XGLFpVCQFCOQQQHoc4HlnX6fAzVh4q/9GN9wCMZyt33FI3ZLfsW9VA+kpqNpO69LXYDdjH3hiXWDKsfvH9cFt7r7gqRVIdu5mgRIEa3waG5hxKzU7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XTu4K4tx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F145C433C7;
	Mon, 22 Jan 2024 11:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705923244;
	bh=z5DMXM53E813UdCKMC58hKWzVQkRAktlvHuLy9BMKUQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XTu4K4txmyf76ZeDpZwrAukKCtOAdojeVQfVECVLkHPu5/IKNPAq5pNTpAwl/yjVH
	 7RN8570Rw6Ldxu8mOSrXuZC+31eVXeZs5Jo1HXAQsLR/L7kcjlBOldoM+36WA1J6r4
	 V9jgjeqkVj3h92Gl8fIKyqIOKrmRtUR5AzHtSLjsZD6CEqXVsj5W3XknADGVpZqulj
	 rjD1Fe8CU/8Nwu/j504f96T1kcA3O2bhKCXdYnKF6XIiv5wUACbHxI/jJrTJhdIn0I
	 SQ6nwJG7G78bgR9jMIWs7M/1R7WETAKGZiU+l8sb0EB2J8Wsa+FU0mugxToXd35T8e
	 jT1TH1yGLfrUQ==
Date: Mon, 22 Jan 2024 17:03:58 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Rex Zhang <rex.zhang@intel.com>
Cc: dmaengine@vger.kernel.org, dave.jiang@intel.com, fenghua.yu@intel.com,
	lijun.pan@intel.com
Subject: Re: [PATCH v2] dmaengine: idxd: Convert spinlock to mutex to lock
 evl workqueue
Message-ID: <Za5Spr6FjjL-XN2i@matsya>
References: <20231223060642.979483-1-rex.zhang@intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231223060642.979483-1-rex.zhang@intel.com>

On 23-12-23, 14:06, Rex Zhang wrote:
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

This fails to apply for me, pls rebase

-- 
~Vinod

