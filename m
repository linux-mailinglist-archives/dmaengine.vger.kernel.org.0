Return-Path: <dmaengine+bounces-5217-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9BCABDA20
	for <lists+dmaengine@lfdr.de>; Tue, 20 May 2025 15:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46E2A3BB87E
	for <lists+dmaengine@lfdr.de>; Tue, 20 May 2025 13:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5EF246788;
	Tue, 20 May 2025 13:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hmhtu7hS"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CF424677A;
	Tue, 20 May 2025 13:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747749244; cv=none; b=jGEheEBgaTDk8FSexg1voqV8IXXgAYg9kqHRqPOn3Lv80cPUrV5kFyTRM8MBKRo2cKDV1GEAdI9TLSCyw0lFZ54ZIfg3z6MYkIfDXmqZ2uc3jQdfQCAEJAMsbuZTTph8pWk+01jvSeczFAsgoopLlAmdzT0KqWZRWnheNPYc1R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747749244; c=relaxed/simple;
	bh=GkpE6fcC7kOlcQACMcKhUiAtH5GSLmJSGDPUjtyBdl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ULt93t7mZ40yOgHZGYXAFkOK8wLAmXd2es+RVtnQLqDbZsTtsx3lWpREQAGrLS1WlEWENwMl2h+gTUu7KUUcEnrHrQ8KP9CAMyHOaR/k1ZavmlhszHezJTb9/M7zATb5GP6XvMK0sGW6j4rm0aaCOWKlDfMRe391eJzXryMZbvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hmhtu7hS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30967C4CEEB;
	Tue, 20 May 2025 13:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747749244;
	bh=GkpE6fcC7kOlcQACMcKhUiAtH5GSLmJSGDPUjtyBdl8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hmhtu7hSmx4vRDlm9nH+PYAh1QLLL2WmP43otE4QhD4n7O0HZ0ArHX66hL//WqrDQ
	 GPB0MR2y5sIXMNVbCMawbEpK59mhYLXSjgmJJHvvmM8TZ+Pd37quDVKDGy9y32d5Ie
	 /tVFZnVztUReaTtzDfQObTTCXa1AinXqudYuDx8w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org,
	Ronald Wahl <ronald.wahl@legrand.com>
Subject: [PATCH 5.15 42/59] dmaengine: ti: k3-udma: Add missing locking
Date: Tue, 20 May 2025 15:50:33 +0200
Message-ID: <20250520125755.519864236@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520125753.836407405@linuxfoundation.org>
References: <20250520125753.836407405@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1082,8 +1082,11 @@ static void udma_check_tx_completion(str
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
@@ -1118,6 +1121,8 @@ static void udma_check_tx_completion(str
 				break;
 			}
 
+			spin_unlock_irqrestore(&uc->vc.lock, flags);
+
 			usleep_range(ktime_to_us(delay),
 				     ktime_to_us(delay) + 10);
 			continue;
@@ -1134,6 +1139,8 @@ static void udma_check_tx_completion(str
 
 		break;
 	}
+
+	spin_unlock_irqrestore(&uc->vc.lock, flags);
 }
 
 static irqreturn_t udma_ring_irq_handler(int irq, void *data)



