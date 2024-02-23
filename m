Return-Path: <dmaengine+bounces-1087-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9067286110B
	for <lists+dmaengine@lfdr.de>; Fri, 23 Feb 2024 13:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C12551C21E33
	for <lists+dmaengine@lfdr.de>; Fri, 23 Feb 2024 12:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355E87AE7A;
	Fri, 23 Feb 2024 12:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lyw8G/wH"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2015C60F;
	Fri, 23 Feb 2024 12:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708690107; cv=none; b=T7p/L1ir96+eRlm07jLmXmwH0UcWiNM1p0qL6Q97jYBRti26a2RKHtL6pT7cQfBadfhZuHlF98g5ScW8WeMfSlEj9jemvOtWtSs+80j6tu1PNcsyUxm9twxYaTAM1MA7ZEU8kFY+eGdXAGpMTrtsaBU5j0HUsrOpn6i3/acobgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708690107; c=relaxed/simple;
	bh=bVcheBD7yfXxTOc3yMDWi29q3BM0NmfM2+dmD5LnjY8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IYCeXmbeBsDD4AXLddMrW53Gz6HeszdAcuNKveQ4tZeicbEhFVJoFU0ELf+9nidnUdfcxd1+sFfrjKXI42jsJ7mVGSny6qCT8ggdAl+dbD1JAoBXyMbvIzmGsGYEflr2U1Wh+rT7F0GXCj7/hB0RXEg00h/aMrmtO5P8DKFlgzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lyw8G/wH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F8B5C433F1;
	Fri, 23 Feb 2024 12:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708690106;
	bh=bVcheBD7yfXxTOc3yMDWi29q3BM0NmfM2+dmD5LnjY8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=lyw8G/wHDhS+VVSwEM8WBdg5HCok3arZwrOHckAwm5axoPLoPTY2nBlzkCDu0IV1d
	 uN15M1xs8ld2GymkKEakmh0AxYNmTuy1ydXfob+0MOoKjimG4H2HLb+T2zCcLUgzNS
	 fLULd26a8V6AjqSkYujhMLDJeZL9GovODIHQFHyGaySoaBkypFovMAgd2Z/o50yIpM
	 bstmyZdifWUMacRevmIJJMtq8WRZoF8UW4MkHU0Q2KriGRQbHLh+H5ic+QUq5mGDaC
	 0JAcrW5lSd8cwwX28ExUjr1JJ2iu667ijf+63261hMyZ/wzKa3h1cco0rAwpYCXgPC
	 93Yz97HhAEKhw==
From: Vinod Koul <vkoul@kernel.org>
To: Dave Jiang <dave.jiang@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, 
 Tony Zhu <tony.zhu@intel.com>
In-Reply-To: <20240209191412.1050270-1-fenghua.yu@intel.com>
References: <20240209191412.1050270-1-fenghua.yu@intel.com>
Subject: Re: [PATCH] dmaengine: idxd: Ensure safe user copy of completion
 record
Message-Id: <170869010483.529426.16718868061769250519.b4-ty@kernel.org>
Date: Fri, 23 Feb 2024 17:38:24 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Fri, 09 Feb 2024 11:14:12 -0800, Fenghua Yu wrote:
> If CONFIG_HARDENED_USERCOPY is enabled, copying completion record from
> event log cache to user triggers a kernel bug.
> 
> [ 1987.159822] usercopy: Kernel memory exposure attempt detected from SLUB object 'dsa0' (offset 74, size 31)!
> [ 1987.170845] ------------[ cut here ]------------
> [ 1987.176086] kernel BUG at mm/usercopy.c:102!
> [ 1987.180946] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
> [ 1987.186866] CPU: 17 PID: 528 Comm: kworker/17:1 Not tainted 6.8.0-rc2+ #5
> [ 1987.194537] Hardware name: Intel Corporation AvenueCity/AvenueCity, BIOS BHSDCRB1.86B.2492.D03.2307181620 07/18/2023
> [ 1987.206405] Workqueue: wq0.0 idxd_evl_fault_work [idxd]
> [ 1987.212338] RIP: 0010:usercopy_abort+0x72/0x90
> [ 1987.217381] Code: 58 65 9c 50 48 c7 c2 17 85 61 9c 57 48 c7 c7 98 fd 6b 9c 48 0f 44 d6 48 c7 c6 b3 08 62 9c 4c 89 d1 49 0f 44 f3 e8 1e 2e d5 ff <0f> 0b 49 c7 c1 9e 42 61 9c 4c 89 cf 4d 89 c8 eb a9 66 66 2e 0f 1f
> [ 1987.238505] RSP: 0018:ff62f5cf20607d60 EFLAGS: 00010246
> [ 1987.244423] RAX: 000000000000005f RBX: 000000000000001f RCX: 0000000000000000
> [ 1987.252480] RDX: 0000000000000000 RSI: ffffffff9c61429e RDI: 00000000ffffffff
> [ 1987.260538] RBP: ff62f5cf20607d78 R08: ff2a6a89ef3fffe8 R09: 00000000fffeffff
> [ 1987.268595] R10: ff2a6a89eed00000 R11: 0000000000000003 R12: ff2a66934849c89a
> [ 1987.276652] R13: 0000000000000001 R14: ff2a66934849c8b9 R15: ff2a66934849c899
> [ 1987.284710] FS:  0000000000000000(0000) GS:ff2a66b22fe40000(0000) knlGS:0000000000000000
> [ 1987.293850] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 1987.300355] CR2: 00007fe291a37000 CR3: 000000010fbd4005 CR4: 0000000000f71ef0
> [ 1987.308413] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 1987.316470] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
> [ 1987.324527] PKRU: 55555554
> [ 1987.327622] Call Trace:
> [ 1987.330424]  <TASK>
> [ 1987.332826]  ? show_regs+0x6e/0x80
> [ 1987.336703]  ? die+0x3c/0xa0
> [ 1987.339988]  ? do_trap+0xd4/0xf0
> [ 1987.343662]  ? do_error_trap+0x75/0xa0
> [ 1987.347922]  ? usercopy_abort+0x72/0x90
> [ 1987.352277]  ? exc_invalid_op+0x57/0x80
> [ 1987.356634]  ? usercopy_abort+0x72/0x90
> [ 1987.360988]  ? asm_exc_invalid_op+0x1f/0x30
> [ 1987.365734]  ? usercopy_abort+0x72/0x90
> [ 1987.370088]  __check_heap_object+0xb7/0xd0
> [ 1987.374739]  __check_object_size+0x175/0x2d0
> [ 1987.379588]  idxd_copy_cr+0xa9/0x130 [idxd]
> [ 1987.384341]  idxd_evl_fault_work+0x127/0x390 [idxd]
> [ 1987.389878]  process_one_work+0x13e/0x300
> [ 1987.394435]  ? __pfx_worker_thread+0x10/0x10
> [ 1987.399284]  worker_thread+0x2f7/0x420
> [ 1987.403544]  ? _raw_spin_unlock_irqrestore+0x2b/0x50
> [ 1987.409171]  ? __pfx_worker_thread+0x10/0x10
> [ 1987.414019]  kthread+0x107/0x140
> [ 1987.417693]  ? __pfx_kthread+0x10/0x10
> [ 1987.421954]  ret_from_fork+0x3d/0x60
> [ 1987.426019]  ? __pfx_kthread+0x10/0x10
> [ 1987.430281]  ret_from_fork_asm+0x1b/0x30
> [ 1987.434744]  </TASK>
> 
> [...]

Applied, thanks!

[1/1] dmaengine: idxd: Ensure safe user copy of completion record
      commit: d3ea125df37dc37972d581b74a5d3785c3f283ab

Best regards,
-- 
~Vinod



