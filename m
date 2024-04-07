Return-Path: <dmaengine+bounces-1766-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B9F89B2FD
	for <lists+dmaengine@lfdr.de>; Sun,  7 Apr 2024 18:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94EC11F22D0C
	for <lists+dmaengine@lfdr.de>; Sun,  7 Apr 2024 16:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E44639FF2;
	Sun,  7 Apr 2024 16:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZpmL2upA"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1597939AE7;
	Sun,  7 Apr 2024 16:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712507907; cv=none; b=ufwGnvt3My1y8xIhZNQC/vZDczs0FTB6vAB50+c17Hg56I7oNMGI69vq1JhKyPBtGFhJ2Vqc0+BqHZFk/vo4ysDCBqCmrU6xLwRdWSslGZ37VjTlHa6OrWWn2Z8kBkTQeNvqRU+tHdOAEAIGkhis3IA7OYFGSL4ntSEu+tlODH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712507907; c=relaxed/simple;
	bh=+xS8JAqxy0bR6BvrRMYh7DrcUUy8Lz8VUgER8txR/JY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=D3miBW/J0wHiPc9Kn+187BIV4psHDzkTIBXL08NThd3lmwRy82l0ulB3jgtg9qDEH7ufjYFqFRmGArK3DglXWlgrfcd3aIBcc2olsa2ixa42Kz1yOuaDMWKDyWKRXixnqdxw6v3cXGn3z2Cij1TVw0aJqyzfOMK9eHVQaxi8j/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZpmL2upA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E301C43390;
	Sun,  7 Apr 2024 16:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712507906;
	bh=+xS8JAqxy0bR6BvrRMYh7DrcUUy8Lz8VUgER8txR/JY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ZpmL2upAitYtX2YpUdcuymhtyQw+FbUqrxz/4N6+buJ6MNsGCDGEoWN8Igf+2PYXM
	 8p0kfCJfn0Z5gUSbSA6orpdemSDVvWG8A4mflt1IwHV5TZ7tSWVt8Z32fSvXs6PgSQ
	 paTiqZ7HpZ6JTOQ4Vn8isBx0eHGpT8PzLv7g4nmJUQTUA7atcXNxPEKQrieX+S/xoq
	 MpSb3yUbFBLorw9rLB7BAbDHQjeh5cigHfZsEUd4Zw8wIQh/pRCNQbJPVRZmoXjFWh
	 35qV+FBEEFgThQhm4Jv6O/NP/2ZhouveUcqri1BAdFEEcMZ4STwEe/rhZIPRWLwl0/
	 SChhwbLOfu0oQ==
From: Vinod Koul <vkoul@kernel.org>
To: Dave Jiang <dave.jiang@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, 
 Rex Zhang <rex.zhang@intel.com>, Lijun Pan <lijun.pan@intel.com>
In-Reply-To: <20240404223949.2885604-1-fenghua.yu@intel.com>
References: <20240404223949.2885604-1-fenghua.yu@intel.com>
Subject: Re: [PATCH v4] dmaengine: idxd: Convert spinlock to mutex to lock
 evl workqueue
Message-Id: <171250790396.435162.11246124579899247281.b4-ty@kernel.org>
Date: Sun, 07 Apr 2024 22:08:23 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Thu, 04 Apr 2024 15:39:49 -0700, Fenghua Yu wrote:
> drain_workqueue() cannot be called safely in a spinlocked context due to
> possible task rescheduling. In the multi-task scenario, calling
> queue_work() while drain_workqueue() will lead to a Call Trace as
> pushing a work on a draining workqueue is not permitted in spinlocked
> context.
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
> 
> [...]

Applied, thanks!

[1/1] dmaengine: idxd: Convert spinlock to mutex to lock evl workqueue
      commit: d5638de827cff0fce77007e426ec0ffdedf68a44

Best regards,
-- 
~Vinod



