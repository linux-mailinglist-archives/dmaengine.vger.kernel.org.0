Return-Path: <dmaengine+bounces-4913-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E73CDA92134
	for <lists+dmaengine@lfdr.de>; Thu, 17 Apr 2025 17:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 081288A1852
	for <lists+dmaengine@lfdr.de>; Thu, 17 Apr 2025 15:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2063B253F09;
	Thu, 17 Apr 2025 15:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZekauNp"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8A9253923;
	Thu, 17 Apr 2025 15:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744903117; cv=none; b=h6cLEl9g1oaWtTl+EGo26EMMFJw5bGdW9UMOJrLo4NoMQiyzcrTRnIuWukEcSuiJxrbZVdwNvazB6zl7Ytk8dFGfKnTDMVAEI9kL4Wz/dOvJBEYT/ZdaZFbDqM8XjG1MXFbXryB7sXMluw9gtRgXCqxm07kWhFRLh0SXvjg68hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744903117; c=relaxed/simple;
	bh=/nOcNn8EezHvH1nww4P/jymAn/3bvvpqzZOb8XA/XIM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iLx1KIEw7Jrt7vso1SkJ5s7s/XH+SIAWcxIKa/0FRtAShl3tmdSkW4R0gGHWMjDA2ErThaPGSS7MNyKdwzCg5rmdUzcf9lzSicCu78N7NcIPnoO4mJRoproiwj7DHoRkbSqmSMQaaNvPljNO737TVlYIkjGR0Pfw2WEfBzraEck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZekauNp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83C12C4CEE4;
	Thu, 17 Apr 2025 15:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744903116;
	bh=/nOcNn8EezHvH1nww4P/jymAn/3bvvpqzZOb8XA/XIM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=BZekauNpbUPo1U4jRnMG2Vq/tfDgjhDYT0kiH/wP2zYsyc63bp/DqKoX+uaWckxvw
	 Di0zyqnp56DUm1WhWFOo2mmfV3rHKSYM/Lj4FYBG1JgEEIoQATfV9BDUE9mRFR3CO3
	 /z4O8fqjgl9f9KvPJW1mg5qHwM9kLsGo/ZfYb4ZfBN1vEtr0wKBu34bF9bvc/L2/X9
	 U9WKI7COjUgj2DfLbJ5rDnrwYpMb0IhjAjAdy4/cOGwhpW5nrPTpARQglemuhQZReR
	 pqwBlC5mSihE9q5+2Kfn5ND/GWLL2/Z5E9o/6L4eso3ofEeOtP5PJDVsO8oSnpGBwp
	 nEaFy9XNFxZPg==
From: Vinod Koul <vkoul@kernel.org>
To: linux-kernel@vger.kernel.org, Ronald Wahl <rwahl@gmx.de>
Cc: Ronald Wahl <ronald.wahl@legrand.com>, 
 Peter Ujfalusi <peter.ujfalusi@gmail.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, dmaengine@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20250414173113.80677-1-rwahl@gmx.de>
References: <20250414173113.80677-1-rwahl@gmx.de>
Subject: Re: [PATCH RESEND] dmaengine: ti: k3-udma: Add missing locking
Message-Id: <174490311416.238609.6695864107940746884.b4-ty@kernel.org>
Date: Thu, 17 Apr 2025 20:48:34 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 14 Apr 2025 19:31:13 +0200, Ronald Wahl wrote:
> Recent kernels complain about a missing lock in k3-udma.c when the lock
> validator is enabled:
> 
> [    4.128073] WARNING: CPU: 0 PID: 746 at drivers/dma/ti/../virt-dma.h:169 udma_start.isra.0+0x34/0x238
> [    4.137352] CPU: 0 UID: 0 PID: 746 Comm: kworker/0:3 Not tainted 6.12.9-arm64 #28
> [    4.144867] Hardware name: pp-v12 (DT)
> [    4.148648] Workqueue: events udma_check_tx_completion
> [    4.153841] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [    4.160834] pc : udma_start.isra.0+0x34/0x238
> [    4.165227] lr : udma_start.isra.0+0x30/0x238
> [    4.169618] sp : ffffffc083cabcf0
> [    4.172963] x29: ffffffc083cabcf0 x28: 0000000000000000 x27: ffffff800001b005
> [    4.180167] x26: ffffffc0812f0000 x25: 0000000000000000 x24: 0000000000000000
> [    4.187370] x23: 0000000000000001 x22: 00000000e21eabe9 x21: ffffff8000fa0670
> [    4.194571] x20: ffffff8001b6bf00 x19: ffffff8000fa0430 x18: ffffffc083b95030
> [    4.201773] x17: 0000000000000000 x16: 00000000f0000000 x15: 0000000000000048
> [    4.208976] x14: 0000000000000048 x13: 0000000000000000 x12: 0000000000000001
> [    4.216179] x11: ffffffc08151a240 x10: 0000000000003ea1 x9 : ffffffc08046ab68
> [    4.223381] x8 : ffffffc083cabac0 x7 : ffffffc081df3718 x6 : 0000000000029fc8
> [    4.230583] x5 : ffffffc0817ee6d8 x4 : 0000000000000bc0 x3 : 0000000000000000
> [    4.237784] x2 : 0000000000000000 x1 : 00000000001fffff x0 : 0000000000000000
> [    4.244986] Call trace:
> [    4.247463]  udma_start.isra.0+0x34/0x238
> [    4.251509]  udma_check_tx_completion+0xd0/0xdc
> [    4.256076]  process_one_work+0x244/0x3fc
> [    4.260129]  process_scheduled_works+0x6c/0x74
> [    4.264610]  worker_thread+0x150/0x1dc
> [    4.268398]  kthread+0xd8/0xe8
> [    4.271492]  ret_from_fork+0x10/0x20
> [    4.275107] irq event stamp: 220
> [    4.278363] hardirqs last  enabled at (219): [<ffffffc080a27c7c>] _raw_spin_unlock_irq+0x38/0x50
> [    4.287183] hardirqs last disabled at (220): [<ffffffc080a1c154>] el1_dbg+0x24/0x50
> [    4.294879] softirqs last  enabled at (182): [<ffffffc080037e68>] handle_softirqs+0x1c0/0x3cc
> [    4.303437] softirqs last disabled at (177): [<ffffffc080010170>] __do_softirq+0x1c/0x28
> [    4.311559] ---[ end trace 0000000000000000 ]---
> 
> [...]

Applied, thanks!

[1/1] dmaengine: ti: k3-udma: Add missing locking
      commit: fca280992af8c2fbd511bc43f65abb4a17363f2f

Best regards,
-- 
~Vinod



