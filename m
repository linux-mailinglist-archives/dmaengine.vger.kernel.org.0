Return-Path: <dmaengine+bounces-2304-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B548FFE18
	for <lists+dmaengine@lfdr.de>; Fri,  7 Jun 2024 10:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 410BC1C2396A
	for <lists+dmaengine@lfdr.de>; Fri,  7 Jun 2024 08:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A4315B115;
	Fri,  7 Jun 2024 08:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Zg8h1t+i"
X-Original-To: dmaengine@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2337E15AD9B;
	Fri,  7 Jun 2024 08:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717749283; cv=none; b=Eq54W5HMcsJvQHhhoA2nzqU+0N8kcgXxvReEKeSYWyNZw580iWJ2F9oX0FWL8ubEGzPfpdK97wZwIN29rV4Qgq8UXsis3LH1bNy2Dp+Ib0iWLcLKubLVQ3PomyAjUFEQ6ueSqpScdcn4fwbndm5ttg4sowYuik9HCKdTF6s0wZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717749283; c=relaxed/simple;
	bh=zPRpjAYUt97meGMe/dTkxWNci342kzEvUmNIKExzJy0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=TRSFbt9N7pOn9YE6YXM+n1Mredc/apP7Kwnr4SPC30LpOwHsuRDe1fklr2G8QvjLUgXwNUsfVq7PKLb+W0kiTApO9rTES5xJ6+qQ3089LCwPl3FP8dyO21SEpu/gCKziqSslUzSOREJkd6RfhmAseaZerl2wkaLqYLGPRTKSZF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Zg8h1t+i; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9175860002;
	Fri,  7 Jun 2024 08:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1717749279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kC7Mkqte1GNcI58Ap7NFvmtEPtCKep5B67HlI4T5e9o=;
	b=Zg8h1t+ieDdEbmuX3VesTFo5fRadzqvA4p5CwE/eJXnsg3o1UvORmAnp6iquxrWto4odGu
	LiF0CfNob79FA/cAZmWMo8toGWTI7qcx+VVPHy3Zp2Z1H9yYYRntYJLNV4mfIreF4Nv2Om
	ohqNBnRVMOY9oDfN7flr2GXLfUtLGfWWxTXo2XolLCSyYTHN6ANOevzBTutoiJsywbDXSe
	V2sMxttnDoJzKBu5EK0y3MRw8i0puGfyFYsxrZ8ykAPCOA870jC9mFJvZuFynt/2BcfXbj
	ZGi4YRzBg0/qyfW0WzNZK+yQpiYNnoy9rWeskilrxkCcEk/jHYBnc3acYSthdA==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Fri, 07 Jun 2024 10:34:38 +0200
Subject: [PATCH v2] dmaengine: xilinx: xdma: Fix data synchronisation in
 xdma_channel_isr()
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240607-xdma-fixes-v2-1-0282319ce345@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAB3GYmYC/22MTQ6DIBBGr2JmXRoZsZqueo/GhcBYJ6lgwBAbw
 91LXXf5vp93QKTAFOFeHRAocWTvCuClAjOP7kWCbWHAGlXdYid2u4xi4p2i6JTWhNZo0j2Uwxr
 oLMr+ORSeOW4+fE53kr/0ryZJIcXUSNUo3d56hQ/t/fZmdzV+gSHn/AUlKr6rpgAAAA==
To: Lizhi Hou <lizhi.hou@amd.com>, Brian Xu <brian.xu@amd.com>, 
 Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>, 
 Vinod Koul <vkoul@kernel.org>, Michal Simek <michal.simek@amd.com>
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, markus.elfring@web.de, stable@vger.kernel.org, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1148;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=zPRpjAYUt97meGMe/dTkxWNci342kzEvUmNIKExzJy0=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBmYsYe6MaFjYQCt+CSytoKScFCdjwkqda9Yw8IU
 LUD4haz1TOJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZmLGHgAKCRAgrS7GWxAs
 4m6XD/42ttI5gdQT0NeEFycj9oQdOtaolq+foYxCmvvs/FJuyFmVxvsEFezkLsjjXjp9swRiwwM
 /wjKCrgggWcBKNiQ1TyuualeA5XEgzVHWC5mbcVLjZXkPVFTn7mSHH5C+p0es/6TCZ4pegjs0Jj
 HnxhKHSKzyGSBT+MZKiG5NW5W0ogzXIYBzk0NkdEeUQDIzZzYWe8fmrOcY7Dnxz0FVxi+pzRvQW
 R5qS8KHL7q8qvbNIYsAifBYqZsCaBVEydWqJPoYqmMOPdXEPg/b7AbmjQgZggLIdQ+p3eFeGvZ+
 8FxalgcU+Bjg+s2YuQu0VEErlmk2ph0DaSBTaLIagUdUb2r/BoRhsz77r9eUG1ktwctGhGs5Bi6
 Zvf2GAcSpu+N/sf1YRim3tbn+GlPQSzbCOzoqTwPSXfv9rLJI9ZUJYWFIi/akNvzQ+tU308kD39
 TcxwztK+OcOBXjevvndKrE4LRQO/9RcCEzqjFtiWNH31LTrStXOvke49nnKmWFQzqZXf1XN8iQa
 r2PSL2Nqsomb1WRVXudK8yrE/HYG2htrrCITY+NIzPKcz8GR52nYHb+HoLJ9nDMg5WuM4egk++a
 QPGRdVQ3nI4VVmIh65P/nobvTBD1dREsogPuOZTd8MFtuTEdW2AxsBx3BlTTpUiOGAl7Z1scJrB
 KdQtP+WqkgZN2RQ==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

Requests the vchan lock before using xdma->stop_request.

Fixes: 6a40fb824596 ("dmaengine: xilinx: xdma: Fix synchronization issue")
Cc: stable@vger.kernel.org
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
Changes in v2:
- Apply comments from Markus
- Link to v1: https://lore.kernel.org/r/20240527-xdma-fixes-v1-1-f31434b56842@bootlin.com
---
 drivers/dma/xilinx/xdma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
index e143a7330816..718842fdaf98 100644
--- a/drivers/dma/xilinx/xdma.c
+++ b/drivers/dma/xilinx/xdma.c
@@ -885,11 +885,11 @@ static irqreturn_t xdma_channel_isr(int irq, void *dev_id)
 	u32 st;
 	bool repeat_tx;
 
+	spin_lock(&xchan->vchan.lock);
+
 	if (xchan->stop_requested)
 		complete(&xchan->last_interrupt);
 
-	spin_lock(&xchan->vchan.lock);
-
 	/* get submitted request */
 	vd = vchan_next_desc(&xchan->vchan);
 	if (!vd)

---
base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
change-id: 20240527-xdma-fixes-74bbe2dcbeb8

Best regards,
-- 
Louis Chauvet <louis.chauvet@bootlin.com>


