Return-Path: <dmaengine+bounces-6863-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B944BE3875
	for <lists+dmaengine@lfdr.de>; Thu, 16 Oct 2025 14:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4DD958314B
	for <lists+dmaengine@lfdr.de>; Thu, 16 Oct 2025 12:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DB2335BC7;
	Thu, 16 Oct 2025 12:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EMO5bhvJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48ADE30648D;
	Thu, 16 Oct 2025 12:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760619362; cv=none; b=vB2pR4nyIskNbajRsvKbft4vDtcqYlrtc2P9y6jQv6HUcZ9oAdh8HE3MrOQpkObgkiE3mCeZlG5ibrotLCLqZ14/K9W80G3tztfQbkRFne+jMLUZ+rn1quxV75/64i6yPqB6GhL1r5u20hJ1iHsOnI2r6DllF9PYV3mGlSHk2WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760619362; c=relaxed/simple;
	bh=zoapc+7QyCxB1b9d8Cgr+h25xaMbmomS/mn0JcTKFVw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PDOeaecnFYqqR0da9FowBcA6RFO+GUGKkNdCreVVLxrwwfPxJ1IeH8GifB1VDPaplRI8shBhWXhn5lJu5gOSqR9XgDU0VOpHZzXo1PWsLC3lIht0uadvjJn3lE2n4UdzmQo5QkWh/Y80NMT4gM4mCFWGgIvjo4LB6kWyHmhNfD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EMO5bhvJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C59A8C4CEFE;
	Thu, 16 Oct 2025 12:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760619361;
	bh=zoapc+7QyCxB1b9d8Cgr+h25xaMbmomS/mn0JcTKFVw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=EMO5bhvJgf3IggIxXuLwqvecRE2Lleg70q8JPZqqVFwGEoR4v8jw+WdQ+7Q+gLBJY
	 uclLqsqjIQvXi/2CVy3ZJMUVUNhZALlfY2R63rnOslH87gOZ6aoRiKCy57ZNAXXmW7
	 wajwWhTY/OAajNJtS4vcMhvB4hvNlVpeY5UgQxStPbkzUIWr2r1xFhIgE11AHwDXPG
	 mUz8J6fCZX89pExtv6W28IA7SobaOwB2pwOFD5LibE1QxGYKUxchK6T0v/Fce1rbDd
	 YmD0ogFuFN20qapyyAyaI31Av/98iWxuYys2YPiYnv9xST3yCaPUyQs31iVCjPF1ML
	 45wGpCTfACP2g==
From: Vinod Koul <vkoul@kernel.org>
To: Lizhi Hou <lizhi.hou@amd.com>, Brian Xu <brian.xu@amd.com>, 
 Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>, 
 Michal Simek <michal.simek@amd.com>, Sonal Santan <sonal.santan@amd.com>, 
 Max Zhen <max.zhen@amd.com>, Anthony Brandon <anthony@amarulasolutions.com>
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>
In-Reply-To: <20251013-xdma-max-reg-v5-1-83efeedce19d@amarulasolutions.com>
References: <20251013-xdma-max-reg-v5-1-83efeedce19d@amarulasolutions.com>
Subject: Re: [PATCH v5] dmaengine: xilinx: xdma: Fix regmap max_register
Message-Id: <176061935845.510550.12282030175889296984.b4-ty@kernel.org>
Date: Thu, 16 Oct 2025 18:25:58 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Mon, 13 Oct 2025 17:48:49 +0200, Anthony Brandon wrote:
> The max_register field is assigned the size of the register memory
> region instead of the offset of the last register.
> The result is that reading from the regmap via debugfs can cause
> a segmentation fault:
> 
> tail /sys/kernel/debug/regmap/xdma.1.auto/registers
> Unable to handle kernel paging request at virtual address ffff800082f70000
> Mem abort info:
>   ESR = 0x0000000096000007
>   EC = 0x25: DABT (current EL), IL = 32 bits
>   SET = 0, FnV = 0
>   EA = 0, S1PTW = 0
>   FSC = 0x07: level 3 translation fault
> [...]
> Call trace:
>  regmap_mmio_read32le+0x10/0x30
>  _regmap_bus_reg_read+0x74/0xc0
>  _regmap_read+0x68/0x198
>  regmap_read+0x54/0x88
>  regmap_read_debugfs+0x140/0x380
>  regmap_map_read_file+0x30/0x48
>  full_proxy_read+0x68/0xc8
>  vfs_read+0xcc/0x310
>  ksys_read+0x7c/0x120
>  __arm64_sys_read+0x24/0x40
>  invoke_syscall.constprop.0+0x64/0x108
>  do_el0_svc+0xb0/0xd8
>  el0_svc+0x38/0x130
>  el0t_64_sync_handler+0x120/0x138
>  el0t_64_sync+0x194/0x198
> Code: aa1e03e9 d503201f f9400000 8b214000 (b9400000)
> ---[ end trace 0000000000000000 ]---
> note: tail[1217] exited with irqs disabled
> note: tail[1217] exited with preempt_count 1
> Segmentation fault
> 
> [...]

Applied, thanks!

[1/1] dmaengine: xilinx: xdma: Fix regmap max_register
      commit: 81935b90b6fc9cd2dbef823a1fc0a92c00f0c6ea

Best regards,
-- 
~Vinod



