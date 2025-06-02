Return-Path: <dmaengine+bounces-5296-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93687ACB4B7
	for <lists+dmaengine@lfdr.de>; Mon,  2 Jun 2025 16:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3E7E7B0F91
	for <lists+dmaengine@lfdr.de>; Mon,  2 Jun 2025 14:47:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EAF1225761;
	Mon,  2 Jun 2025 14:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZhmTFWMM"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AC8224AF1;
	Mon,  2 Jun 2025 14:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748875428; cv=none; b=OArhnaPiyBnk9hEFqap0uW/u62Jp3Dab/bYQWRGl0kQg0tZ3IKzEuKAvGf5AW+Oc6x4BQiZMQWM8mGQ6dpYD4FmLOqx6aWI4fS1Bn8BnOusE3/5GdHs6t8UICaguamIhat/zSYT5IETmkNpB4JjSPHr6+nPGiucKKrVhBXzabEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748875428; c=relaxed/simple;
	bh=yv+nl+HMoWGplbpFYJ2V8XCl5o25UfLHaMhs6WFA70w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k/wNnskvAfml1fHnbggop0NL7sDpdSFQT/MxhXzCHiX4wFbbcvi5OWYERcQ7OFWn63XCGuuGmjnZV0yJFoktK72WWuVEEXPWHt0jFO7X6Pja7EkXQTf6JTmcP0q9s/kpLb8I4kFOXKlzWnNtoYCs7D2nJrUHBrE7LLCops1on5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZhmTFWMM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A90C9C4CEEB;
	Mon,  2 Jun 2025 14:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748875428;
	bh=yv+nl+HMoWGplbpFYJ2V8XCl5o25UfLHaMhs6WFA70w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZhmTFWMMMn/sCNwsUVZNUPUi5eVqFrRfh4GmZ1WqjUeRuADlTgT01YBI6+lsNF/J1
	 VYtDUcu1SLoP4Zv4jDZZ0WBce5vRprqiSxOs1PDwddnuyfhxxLxtodslvBeSFbw3Sv
	 qa26bPJvezjjOwQTpa+EKJP3iPLYjBOUNftZku5M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org,
	Ronald Wahl <ronald.wahl@legrand.com>
Subject: [PATCH 5.10 102/270] dmaengine: ti: k3-udma: Add missing locking
Date: Mon,  2 Jun 2025 15:46:27 +0200
Message-ID: <20250602134311.339187089@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134307.195171844@linuxfoundation.org>
References: <20250602134307.195171844@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ronald Wahl <ronald.wahl@legrand.com>

commit fca280992af8c2fbd511bc43f65abb4a17363f2f upstream.

Recent kernels complain about a missing lock in k3-udma.c when the lock
validator is enabled:

[    4.128073] WARNING: CPU: 0 PID: 746 at drivers/dma/ti/../virt-dma.h:169 udma_start.isra.0+0x34/0x238
[    4.137352] CPU: 0 UID: 0 PID: 746 Comm: kworker/0:3 Not tainted 6.12.9-arm64 #28
[    4.144867] Hardware name: pp-v12 (DT)
[    4.148648] Workqueue: events udma_check_tx_completion
[    4.153841] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    4.160834] pc : udma_start.isra.0+0x34/0x238
[    4.165227] lr : udma_start.isra.0+0x30/0x238
[    4.169618] sp : ffffffc083cabcf0
[    4.172963] x29: ffffffc083cabcf0 x28: 0000000000000000 x27: ffffff800001b005
[    4.180167] x26: ffffffc0812f0000 x25: 0000000000000000 x24: 0000000000000000
[    4.187370] x23: 0000000000000001 x22: 00000000e21eabe9 x21: ffffff8000fa0670
[    4.194571] x20: ffffff8001b6bf00 x19: ffffff8000fa0430 x18: ffffffc083b95030
[    4.201773] x17: 0000000000000000 x16: 00000000f0000000 x15: 0000000000000048
[    4.208976] x14: 0000000000000048 x13: 0000000000000000 x12: 0000000000000001
[    4.216179] x11: ffffffc08151a240 x10: 0000000000003ea1 x9 : ffffffc08046ab68
[    4.223381] x8 : ffffffc083cabac0 x7 : ffffffc081df3718 x6 : 0000000000029fc8
[    4.230583] x5 : ffffffc0817ee6d8 x4 : 0000000000000bc0 x3 : 0000000000000000
[    4.237784] x2 : 0000000000000000 x1 : 00000000001fffff x0 : 0000000000000000
[    4.244986] Call trace:
[    4.247463]  udma_start.isra.0+0x34/0x238
[    4.251509]  udma_check_tx_completion+0xd0/0xdc
[    4.256076]  process_one_work+0x244/0x3fc
[    4.260129]  process_scheduled_works+0x6c/0x74
[    4.264610]  worker_thread+0x150/0x1dc
[    4.268398]  kthread+0xd8/0xe8
[    4.271492]  ret_from_fork+0x10/0x20
[    4.275107] irq event stamp: 220
[    4.278363] hardirqs last  enabled at (219): [<ffffffc080a27c7c>] _raw_spin_unlock_irq+0x38/0x50
[    4.287183] hardirqs last disabled at (220): [<ffffffc080a1c154>] el1_dbg+0x24/0x50
[    4.294879] softirqs last  enabled at (182): [<ffffffc080037e68>] handle_softirqs+0x1c0/0x3cc
[    4.303437] softirqs last disabled at (177): [<ffffffc080010170>] __do_softirq+0x1c/0x28
[    4.311559] ---[ end trace 0000000000000000 ]---

This commit adds the missing locking.

Fixes: 25dcb5dd7b7c ("dmaengine: ti: New driver for K3 UDMA")
Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org
Cc: stable@vger.kernel.org
Signed-off-by: Ronald Wahl <ronald.wahl@legrand.com>
Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
Link: https://lore.kernel.org/r/20250414173113.80677-1-rwahl@gmx.de
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/dma/ti/k3-udma.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -962,8 +962,11 @@ static void udma_check_tx_completion(str
 	u32 residue_diff;
 	ktime_t time_diff;
 	unsigned long delay;
+	unsigned long flags;
 
 	while (1) {
+		spin_lock_irqsave(&uc->vc.lock, flags);
+
 		if (uc->desc) {
 			/* Get previous residue and time stamp */
 			residue_diff = uc->tx_drain.residue;
@@ -998,6 +1001,8 @@ static void udma_check_tx_completion(str
 				break;
 			}
 
+			spin_unlock_irqrestore(&uc->vc.lock, flags);
+
 			usleep_range(ktime_to_us(delay),
 				     ktime_to_us(delay) + 10);
 			continue;
@@ -1014,6 +1019,8 @@ static void udma_check_tx_completion(str
 
 		break;
 	}
+
+	spin_unlock_irqrestore(&uc->vc.lock, flags);
 }
 
 static irqreturn_t udma_ring_irq_handler(int irq, void *data)



