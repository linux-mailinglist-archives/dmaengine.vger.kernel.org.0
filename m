Return-Path: <dmaengine+bounces-4598-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50AE6A49C20
	for <lists+dmaengine@lfdr.de>; Fri, 28 Feb 2025 15:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54069173B3F
	for <lists+dmaengine@lfdr.de>; Fri, 28 Feb 2025 14:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C82E26FD88;
	Fri, 28 Feb 2025 14:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gw0wMCyY"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E986B26FD81;
	Fri, 28 Feb 2025 14:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740753354; cv=none; b=F9AuDWKCrMb6JFRDs5FKlA1HrjlDqRRc0DVOOkeU8jfvk4qcihoVAPIz5ndesRvw3Pj0i2oP9xMoWwPR9tDGd+p7hG+s6SMk3qx4MEJwXwcB8v2WPT+oeMDrF9Aw0kvloUQM/+5sILa2UhPICD1HW62eOF1g0GUdTLh4NEZBWTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740753354; c=relaxed/simple;
	bh=w65gw6pcvn4/IhADuzAEL+BMY22nnW1RgyNEgJj8uoc=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Cc:Content-Type; b=olZDVrRtGkG4/a9unPTHh64rjKL3q1ncBiXIFulxx5e06UjEwgDpDRG2eLw7o1XUxZZmDHD09jIPFaR2n/XFArVd+mQds9yPPqGmgWCUkhAzFBHF1lOHfAV6yoUI34LhshZYs9s6LH+KUYjVfVo6IkfyxSMHMbMQLg1YxS2J2kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gw0wMCyY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58990C4CED6;
	Fri, 28 Feb 2025 14:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740753352;
	bh=w65gw6pcvn4/IhADuzAEL+BMY22nnW1RgyNEgJj8uoc=;
	h=Date:To:From:Subject:Cc:From;
	b=Gw0wMCyYVC8+hSmdc6N8qzDOvQew99S7FsW3OSpycOffsvcKtKFwGwn+LPItQlIsz
	 TGjN2vC1fgYtSSOwSUf52s9QzCT53rWZNT8JJK4I5c3yGQNztpArRE9hwrIJri268u
	 JIM0bHImGQHWK21KEO+0ySC02REZTUU9eJzBdq9EHlv1Tg9il/zGVFY+BrAIgKvxOT
	 chaMR07cIGvlPAKwPjIo8uKjPbpDmC56GGeSJftbG+ecn1PwmYPzV/jHd/ow3h6Nvy
	 keBtv1oVERvPJ3zehHmf+fFRmRpIXtikaf1jYIitLyqVL5RD/DV7o4tFkra0W0nIvs
	 Wt6LKNAt3ySuw==
Message-ID: <45ddbb23-bf92-4d46-84b6-6c80886d4278@kernel.org>
Date: Fri, 28 Feb 2025 15:35:48 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
From: Jesper Dangaard Brouer <hawk@kernel.org>
Subject: Kernel module ae4dma caused my system to not boot
Cc: Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Basavaraj,

When rebasing my devel kernel to v6.14 (6.14.0-rc3-traits-009-bench+),
my AMD testlab system didn't boot due to the kernel module: ae4dma.
I disabled the kernel module via CONFIG_AMD_AE4DMA so I can boot my
system again.

CPU: AMD EPYC 9684X 96-Core Processor

As a help for you to debug here are the kernel console messages that
seems relevant:

[   13.853689] ae4dma 0000:85:00.1: enabling device (0000 -> 0002)
[   13.861287] genirq: Flags mismatch irq 0. 00000000 (0000:85:00.1) vs. 
00215a00 (timer)
[   13.870123] CPU: 0 UID: 0 PID: 8 Comm: kworker/0:0 Not tainted 
6.14.0-rc3-traits-009-bench+ #32
[   13.870125] Hardware name: Lenovo HR355M-V3-G12/HR355M_V3_HPM, BIOS 
HR355M_V3.G.026 10/13/2023
[   13.870126] Workqueue: events work_for_cpu_fn
[   13.870132] Call Trace:
[   13.870134]  <TASK>
[   13.870136]  dump_stack_lvl+0x64/0x80
[   13.870141]  __setup_irq+0x522/0x6d0
[   13.870145]  request_threaded_irq+0x10d/0x180
[   13.870146]  devm_request_threaded_irq+0x71/0xd0
[   13.870149]  ? __pfx_ae4_core_irq_handler+0x10/0x10 [ae4dma]
[   13.870153]  ae4_core_init+0x8f/0x2f0 [ae4dma]
[   13.870155]  ae4_pci_probe+0x1f3/0x270 [ae4dma]
[   13.870156]  local_pci_probe+0x42/0xa0
[   13.870161]  work_for_cpu_fn+0x17/0x30
[   13.870162]  process_one_work+0x181/0x3a0
[   13.870165]  worker_thread+0x251/0x360
[   13.870166]  ? __pfx_worker_thread+0x10/0x10
[   13.870168]  kthread+0xee/0x240
[   13.870170]  ? finish_task_switch.isra.0+0x88/0x2d0
[   13.870173]  ? __pfx_kthread+0x10/0x10
[   13.870174]  ret_from_fork+0x31/0x50
[   13.870177]  ? __pfx_kthread+0x10/0x10
[   13.870178]  ret_from_fork_asm+0x1a/0x30
[   13.870182]  </TASK>
[   14.010326] ccp 0000:03:00.5: SEV firmware updated from 1.55.32 to 
1.55.37
[   16.565527] ae4dma 0000:85:00.1: probe with driver ae4dma failed with 
error -16
[   16.574958] ae4dma 0000:c1:00.1: enabling device (0000 -> 0002)

Let me know if you need other data,
--Jesper


