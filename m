Return-Path: <dmaengine+bounces-4883-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F2DA889DB
	for <lists+dmaengine@lfdr.de>; Mon, 14 Apr 2025 19:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85CD916DA5A
	for <lists+dmaengine@lfdr.de>; Mon, 14 Apr 2025 17:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5998B19CC0A;
	Mon, 14 Apr 2025 17:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwahl@gmx.de header.b="srBdywEv"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9071B2DFA3B;
	Mon, 14 Apr 2025 17:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744651892; cv=none; b=gLYk9zS4ZAFayVygnv90Xcs7KDpCLBp8WZhkZHzc1/5iVfWhymhH+5UAXp+L5lSSaHr1Dx6FMQWoWkKglRAtfhTrY7D9U1c3n45VnYyintkKRkLiJlOklBJJkiyQXH8LyxdYQ0B4iNbsJDbRxKXRhXnGjiMHLp+Lpl5uQW2v9WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744651892; c=relaxed/simple;
	bh=rsheav0WKo/SqZfUu7h21TxsRP7MKoTl1+ZUdIL9M3w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=APr9x/QC5rt0NTQwglUhDOck8lGHUqYUZKMQ6uXzlrdmDoDobu3DwsqfmoZ0XFmN0eMKGaRT7kRozzyhtQ8RzCLkwvz7WE7OgyP2zAXUCmoW1orGrjOKeavwG52V9PW/jZZ6vuEAzYgnnNOUURuNDvnH3tCDGWxwIlmBPvo9QTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwahl@gmx.de header.b=srBdywEv; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1744651883; x=1745256683; i=rwahl@gmx.de;
	bh=7ByPJ45d6LtqD5UpNfiaJd/RF8Le2mvRFLi4pn0bk8g=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=srBdywEviPMICu46XsIznUbF5/k3arY97g0EdvIZ91vPU0AsLSpdVzTZhKF2FeYT
	 ECveXLf0Yzol+2VUSOpMu435EeD9JUyq+/m+zhR8W3dlq/9MnW0GHwovLPAoF6yCZ
	 AuqpTUipojUumzgAexqyyeoI8Dq210zapbJ7NTNR7Ki1KggdHNH5jcVLehbMkrZwC
	 GWCBtfwME++/iZdDgXX7bqcbdPmfuZkBkVLNxCM5zrpDBKEczo8j7URch9oROB4ch
	 CaatO2DBENQboDalXfJdiwGfvh/zbDfzuoese7B8B5pYOtzH7TL/w6Y4ySy8E/YTu
	 0UoP7oojd74I96xLIQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from rohan.localdomain ([93.236.252.50]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MIwzA-1tl4LY3nJ4-00VZKd; Mon, 14
 Apr 2025 19:31:22 +0200
From: Ronald Wahl <rwahl@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: Ronald Wahl <ronald.wahl@legrand.com>,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH RESEND] dmaengine: ti: k3-udma: Add missing locking
Date: Mon, 14 Apr 2025 19:31:13 +0200
Message-ID: <20250414173113.80677-1-rwahl@gmx.de>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zUW4N9yrNhr2CM1WljW7EourAazgdFzvCrpI9ZesvlhkEds4QYC
 7QJPhz9cCePEu8fUvDo0NG8saU6p/FxHJA+68LSt4glXIEkzt9cvvFEZDpB12YG6/3IVOm0
 q7WmPjU0mRcvU0S4k9ezyhz1q+9Y3We7nXHr5Fgg36XlWanpDb5TVXhE51+5xI36xo1F/02
 rY8097L4XlAh51+K8rHFA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wt6aeIx52cM=;Mn+AA2jEjTN9M886bHrwIpgVWne
 NZ+1aNdYHME+92Fjf2i/S9N/+0ScGPfoOj55FZ3eKbGiISxZKiY148W6zzW+LMtn2At6lk8W2
 ABBRCVoRxP0aft6HY+QpFvePF/0CSSaRmNb14bmi638a+L68xOPRvf6YE3KsHA5pPfDmU3Q5P
 s+EZzEHs+ZxTLk7qolV6ixXH3TaYVOHfFrci9fJKFch9xPeGGEY/LEfu97fYDzbNZarZWxA6k
 IV47gw0Ir7t4dJI23cShq+lEIFMHoDYloUjbYq5JtzyQNALBP8DmYhk5NZzzzw3DZwEUZRgPb
 Y4+La/arhNv+LWifnmrnKhsxKLus7f9JMciGPq6bw68YuxJPrkRF6V131xsIoAwjMgzFemple
 2fLrHyKtOiQFhAeyepwt0pASf4KIkkRbBD/Exss0Qm9lMJPs1zrRRnjB///8JUPdt0s8rYmG2
 6PkdROhs+SnvOSSFR1YBB1DrrsFN5cgkNgKKADn/XO4WL8RNdnM/uPZREmV1yT6APQWnH4xOf
 svSE2iK6PJh/4BRTLJ+Ws8FMzIpl40aLQj86bEyhgRMuR4IVmlkbFcMv5rUZkpPjK1YA5becg
 CeTyOG5n9abGezEtwfIXQxUtIwTvM8gh4oIsG720DW4myOuzWgfRtmkGzx8ea6Rzv2nagQDsB
 weZkTNAv49D2Zv/DUWf2YMATEmNKabUqcH7ugr8PMRJRb3M+QtLf0KROmEpEw804y7o61P50b
 AXlaEbDEhV0jFIu4zlC+VzF+RWHS8WRYeqk1bBfEyVi+4iwI1egXQoHSOEeS2WJEPhwUH7eDG
 BXMY+ZQ6itISfQIfIZFDPxENMtCCgZnBqe89zoabbWwNFP0UjA/9fZPtZ87C6JYo7tuvCZdJg
 NjTp3eqI5krInOGQx4uxoj4cOBtMKigPz6By7J4go7bgDAWhXVfUVPAkmIp9Q0fwybZl+rp7O
 q46Ei32ptvzGrk/sbS9/3V1Lt5B/3ni1YpYsiZGSgwVOb7f6qp9Ei6r3Y04jjxkenyXakzg9l
 SePoY3Luy2vdiI9BKcI1r+rNJ+RYnr/6B8kyPf4XMLHiDDct5WHIOgHqY2uMBOoashlkRxZSr
 OVgObFH9cFkTcDpvWM/6+v5KjU8wGKBK69awtyfagF0P1PMaVF3ITL4WIWPqzzykZJ3BbiDpB
 N1eKDttlsn/UwxeBxbUvhQ1ezjPlX5fmIftC/G8uHpcZ2IiJOCHcqs1s6fMswQUtw9zcZi0Dx
 ruJmLnW3EoLgI0VRss0A80HqUQLqPWd/NtAhsIq/O9fqkhEGWv0MlO8Q+tnx9T/Jn5iLpNMur
 3bJFAaAomG8tK9PMArMsv/gYfE9vQp/E3t+Hl6yTnqSB3S9lnGOYr+bth6MGV5YbwSc3tRwls
 7whqAGqwiT/dWD5Mg3j+WFJ914rgqCm6WpF/6kpJpXPaikF68qo6eIegAK9FCsDmIvJSvDTMf
 LlM4ntaPGIlonZWUTENalWZUdXeI=

From: Ronald Wahl <ronald.wahl@legrand.com>

Recent kernels complain about a missing lock in k3-udma.c when the lock
validator is enabled:

[    4.128073] WARNING: CPU: 0 PID: 746 at drivers/dma/ti/../virt-dma.h:16=
9 udma_start.isra.0+0x34/0x238
[    4.137352] CPU: 0 UID: 0 PID: 746 Comm: kworker/0:3 Not tainted 6.12.9=
-arm64 #28
[    4.144867] Hardware name: pp-v12 (DT)
[    4.148648] Workqueue: events udma_check_tx_completion
[    4.153841] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
[    4.160834] pc : udma_start.isra.0+0x34/0x238
[    4.165227] lr : udma_start.isra.0+0x30/0x238
[    4.169618] sp : ffffffc083cabcf0
[    4.172963] x29: ffffffc083cabcf0 x28: 0000000000000000 x27: ffffff8000=
01b005
[    4.180167] x26: ffffffc0812f0000 x25: 0000000000000000 x24: 0000000000=
000000
[    4.187370] x23: 0000000000000001 x22: 00000000e21eabe9 x21: ffffff8000=
fa0670
[    4.194571] x20: ffffff8001b6bf00 x19: ffffff8000fa0430 x18: ffffffc083=
b95030
[    4.201773] x17: 0000000000000000 x16: 00000000f0000000 x15: 0000000000=
000048
[    4.208976] x14: 0000000000000048 x13: 0000000000000000 x12: 0000000000=
000001
[    4.216179] x11: ffffffc08151a240 x10: 0000000000003ea1 x9 : ffffffc080=
46ab68
[    4.223381] x8 : ffffffc083cabac0 x7 : ffffffc081df3718 x6 : 0000000000=
029fc8
[    4.230583] x5 : ffffffc0817ee6d8 x4 : 0000000000000bc0 x3 : 0000000000=
000000
[    4.237784] x2 : 0000000000000000 x1 : 00000000001fffff x0 : 0000000000=
000000
[    4.244986] Call trace:
[    4.247463]  udma_start.isra.0+0x34/0x238
[    4.251509]  udma_check_tx_completion+0xd0/0xdc
[    4.256076]  process_one_work+0x244/0x3fc
[    4.260129]  process_scheduled_works+0x6c/0x74
[    4.264610]  worker_thread+0x150/0x1dc
[    4.268398]  kthread+0xd8/0xe8
[    4.271492]  ret_from_fork+0x10/0x20
[    4.275107] irq event stamp: 220
[    4.278363] hardirqs last  enabled at (219): [<ffffffc080a27c7c>] _raw_=
spin_unlock_irq+0x38/0x50
[    4.287183] hardirqs last disabled at (220): [<ffffffc080a1c154>] el1_d=
bg+0x24/0x50
[    4.294879] softirqs last  enabled at (182): [<ffffffc080037e68>] handl=
e_softirqs+0x1c0/0x3cc
[    4.303437] softirqs last disabled at (177): [<ffffffc080010170>] __do_=
softirq+0x1c/0x28
[    4.311559] ---[ end trace 0000000000000000 ]---

This commit adds the missing locking.

Fixes: 25dcb5dd7b7c ("dmaengine: ti: New driver for K3 UDMA")
Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org
Cc: stable@vger.kernel.org
Signed-off-by: Ronald Wahl <ronald.wahl@legrand.com>
=2D--
 drivers/dma/ti/k3-udma.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index b3f27b3f9209..b9e497e8134b 100644
=2D-- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -1091,8 +1091,11 @@ static void udma_check_tx_completion(struct work_st=
ruct *work)
 	u32 residue_diff;
 	ktime_t time_diff;
 	unsigned long delay;
+	unsigned long flags;

 	while (1) {
+		spin_lock_irqsave(&uc->vc.lock, flags);
+
 		if (uc->desc) {
 			/* Get previous residue and time stamp */
 			residue_diff =3D uc->tx_drain.residue;
@@ -1127,6 +1130,8 @@ static void udma_check_tx_completion(struct work_str=
uct *work)
 				break;
 			}

+			spin_unlock_irqrestore(&uc->vc.lock, flags);
+
 			usleep_range(ktime_to_us(delay),
 				     ktime_to_us(delay) + 10);
 			continue;
@@ -1143,6 +1148,8 @@ static void udma_check_tx_completion(struct work_str=
uct *work)

 		break;
 	}
+
+	spin_unlock_irqrestore(&uc->vc.lock, flags);
 }

 static irqreturn_t udma_ring_irq_handler(int irq, void *data)
=2D-
2.48.0


