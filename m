Return-Path: <dmaengine+bounces-4165-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35133A16E8B
	for <lists+dmaengine@lfdr.de>; Mon, 20 Jan 2025 15:41:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5879516304B
	for <lists+dmaengine@lfdr.de>; Mon, 20 Jan 2025 14:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B80C1E377A;
	Mon, 20 Jan 2025 14:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwahl@gmx.de header.b="nkkbZMVr"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9A61E1C32;
	Mon, 20 Jan 2025 14:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737384106; cv=none; b=pypD2uXz7rCAcQCvNRXSexRcWkEV2Ax2XflOm52l+3SdGmfmk6n/W92WPeVmyCID8t3ikqb6Wql2ZEry4OGFabmRIVkp7SsSkh/KznehDOzHHXBOXnB3bHDPohk/ade0fhXMqqjEh12JpFZisFCzJRNRscAnjRv9mxFdP1Lw8no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737384106; c=relaxed/simple;
	bh=rsheav0WKo/SqZfUu7h21TxsRP7MKoTl1+ZUdIL9M3w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HmtF53zNqcpwvVSY6hQd99hN+GNjv4lWVX9pgVmoNizK+hFPg8v+8jONB7l+wT89eIDzFVl8WYCZBgdYhgmyEDDNEM0qAWArB88eSs5vlfir00NZIJ003jTo9wx3JZCapeCooBBEUU7Y7gwUPL117QJ5JdrOP641M2AjRYwjiaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwahl@gmx.de header.b=nkkbZMVr; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1737384095; x=1737988895; i=rwahl@gmx.de;
	bh=7ByPJ45d6LtqD5UpNfiaJd/RF8Le2mvRFLi4pn0bk8g=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=nkkbZMVrZYEanP8B03WD838tZ/ixjUJmZnVj1E9aB1nN++JLAsB89/9K9Z0xcYIO
	 EDSrkJD1HtWtTfJUst+o0G+urgYxh6QJaAooPhrdbOjFyoQTNU0RDaOKmFIuZYVOu
	 jmAMMUjCzZxl+6tqIlahW+cwd0guWIeBz5S3qNsU9upL7waEniGoswSztzOUFo8nK
	 zUOe7ahfz4KxYCIp2SzIlmCCR3x5aBBQThiZlfZ2D7IrQatLD6CcA8RwEJPtL8EQP
	 TwlJ6Y0DdyHVcO3SXe7RnLLRfMFRwbUo1QIKgRHGH36RYwKJtCL/I3aUhFYB6AS1l
	 fjsrOPhOvOm0IkgHDQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from rohan.localdomain ([84.156.157.89]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MG9kC-1tjmSp2LSm-00Fgox; Mon, 20
 Jan 2025 15:41:35 +0100
From: Ronald Wahl <rwahl@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: Ronald Wahl <ronald.wahl@legrand.com>,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] dmaengine: ti: k3-udma: Add missing locking
Date: Mon, 20 Jan 2025 15:41:31 +0100
Message-ID: <20250120144131.792609-1-rwahl@gmx.de>
X-Mailer: git-send-email 2.48.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XfSGgnm1S/6dVDt0/nO9KKb7p+sjaYLYwB0zk60A9BQ88HppOzi
 9xu8j+ETakl0KnPhL0bDl8e37GNv3zt2KYxfxU0uRtQHq0xgezeksVn6vTlrVPhv+OqGYWi
 HVHH7Ayqf+F1pbXDOFCwBDO7niND9ne/Rgr9b1c7B2eI0xDxZjSGUPfudj+irtA0u/5RK37
 Hu790QdwNP/S5S92uQz9Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0IRJXukx2Io=;ERi4oL6D+9v2vttAjQ62+JF5rBX
 VSVLmdfveHpuaqguLz9vLFW+/rChsXL0gciHR6SGiom+4U+mcH1x/Z2SXczbUvbq2U3mV0S9u
 UQvrRADjEDlfAu1XpNi+Fi7vENcxV3eNoYRRjeyUsvPhax45Wy+/xdk8RLtkdaMcIVHKFaOj4
 IlIM77eqDtD6qcX/3C/70SS2Ev6tSV+WBitspL1AzP1zl0/FBes03wRWKiZO03GK6EvXdbY44
 mocirum21pRIFXMbLcmNLxzfRpeMqGQEtKwfB6H2Ry7/v0A2lHXJXhd5KNsSdMP3WHbybkjDt
 qpcbIkVhXg8Ol9ZDZsGhEDshyHi89dfCKFMoXl4AZ0KZXe8BQqq0c1c6HDiNlGLBhjXRT3wEH
 C37ZexyAe4phMqcN/Q/Z8nl+7RkFLkU54JVgnAywA/pBC7QyBvphykXXwSMtmqN4MC3Yk7ooa
 nb0UHknH+qIn/6jRl8LELPD8BwlaGGi4MvMJlziSY6bOew8hy5a0vzJwQ8CvE43r6nGw+54t3
 JQdDPRaG/xqXpzYIejSjlpT27Ain6zcm7ut/cf8xZZKdgqbm0LTXU+Gy8Ce/3MWfMZzfcvJp5
 FuDsqLwoqcnCrvuIDNbdjTwYD3FnfohulCcXYY2eqpKQ1Vjh1x3qdcaWSyMeAecjWMmEIc9G7
 vQMcDJAqM7+FbDY6K+A8RP++h69u5sb2tUCxTtG+LY4rMBETpEG7DcyVQTnWueP7Bnyyhv2P4
 hxkJ3aR8XRWfpHWkgTCYopfJrH2y4d3yoP3BuGrbT8LZ1KV4/KBqBjptKr6spqOOYhiMQOSvn
 cVpm4ae+gfbi+I7i+EmosfH+HlEzH8AusGIwKNZGNBa21XEn1T+ZRh7hA1jn3n55o6shrKd0I
 g7NpsXU0bfWH6DPBIgDkX7zOCcN23XykULsl6vqA2aQAgZ52TqnPJkC4okx7UlOuY6fCxtujR
 A8NSzLlRi80HiDH0OUfU1YjPIeVbPm2FaKpogRBhvuqtOQA/SNVOV57NU/UBw+eP08YvOw+rY
 MYHJdxGHIxwOmOTOv7NBiIObQZQPXeVqSwM9HcH+gQO6uTp84zwGcwl2vaKrWauHoZ1lsBhBj
 g64PLFgyGvMQfRf6VTYJGy7Owob/Me+eikyzRcqC4BkyL3y/YNidTehX0uV13vaLAUpI39u1K
 S9L7m/c+QqLtmrbwQpkYlFohWHZ+K/7wrq1s2do9oEA==

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


