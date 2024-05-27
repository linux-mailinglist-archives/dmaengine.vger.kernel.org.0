Return-Path: <dmaengine+bounces-2183-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB328D088A
	for <lists+dmaengine@lfdr.de>; Mon, 27 May 2024 18:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BD08286888
	for <lists+dmaengine@lfdr.de>; Mon, 27 May 2024 16:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A586161FCE;
	Mon, 27 May 2024 16:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JThKJZTS"
X-Original-To: dmaengine@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988CD155C8C;
	Mon, 27 May 2024 16:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716827374; cv=none; b=LDE7pIDDSCFVaibGPARlzQKFq/4PlK7ls6u9z3w52VYHOA897HA3MHQE79PfAbOcxSp2pu0RPU9dUUvOPWgLHTgtUQEcXhp2qA98ECEdcSpm398d8TvOf41oYX47y/gI6gHKgZ17cnvDIF2Dx+rcAiwSnG60+w1qbWM09XKdGSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716827374; c=relaxed/simple;
	bh=ZIrLwguLCcWL9NbjO5PeAwKzODMb0QfIDnQF87pLD5g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=d/opsGCvROPrI3qNpY1U9b6vEE9/lSlPR6bVt+M7tOuXu/ssFjmfqMME2bvL+ToO7kOcCHl9o/r9jYwJL+59jFQ8Zf+Ailf/v0e1FSiooZadmjVM9VODAH5JO4hTlJg1WPFF2QpNpF5QZC5LJxdQ8hTc+VuRvHEKbvRWcfox6HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JThKJZTS; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 52C3B240002;
	Mon, 27 May 2024 16:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1716827365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=l4JMQmm16LQ4vza9Usv2p7EkveNlgJJeDpkhkQyzzXY=;
	b=JThKJZTSgvNMB1GQSiRo3fgxkot5wMMGOenXzv5ehnRi4U1fIXhzDmpxoPTl8sVCg8yXtW
	QA+gOPypaID0Z04NPWV1hxQNXTe/oN4eD+MUGrkKDc8EYw6z1RxQ3FcFP2jdPgxdlgv4h3
	7NukpUbT2rX8r1XhP00XokO4dFNI6mmbmBMXgv4PeviW2Yeh6L3ElS4kKWlEYpOlUppw0J
	5/69P/pNFbEE51uFD+pVusOGwC7t93fagfI+dpUhctkdPGH0UFrwLtw0nSOPA1JLw8UTxB
	AYoci1FnA5hS5vh5qERz441W9co5QTQH+7xQucPbASz4kbArKQKpeXqrA2DR2Q==
From: Louis Chauvet <louis.chauvet@bootlin.com>
Date: Mon, 27 May 2024 18:29:17 +0200
Subject: [PATCH] dmaengine: xilinx: xdma: Fixes possible threading issue
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240527-xdma-fixes-v1-1-f31434b56842@bootlin.com>
X-B4-Tracking: v=1; b=H4sIANy0VGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDUyNz3YqU3ETdtMyK1GJdc5OkpFSjlOSk1CQLJaCGgqJUsARQfXRsbS0
 AOI9bh1wAAAA=
To: Lizhi Hou <lizhi.hou@amd.com>, Brian Xu <brian.xu@amd.com>, 
 Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>, 
 Vinod Koul <vkoul@kernel.org>, Michal Simek <michal.simek@amd.com>
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1022;
 i=louis.chauvet@bootlin.com; h=from:subject:message-id;
 bh=ZIrLwguLCcWL9NbjO5PeAwKzODMb0QfIDnQF87pLD5g=;
 b=owEBbQKS/ZANAwAIASCtLsZbECziAcsmYgBmVLTkuJyOqjUA7AHg9fbdvDWSyOUooke9+evHq
 a2C61iZlfSJAjMEAAEIAB0WIQRPj7g/vng8MQxQWQQgrS7GWxAs4gUCZlS05AAKCRAgrS7GWxAs
 4kOjD/9D5YRTDgMxefAtrP0NOPdBSUBsC4gsY+kxNvOPfbefXs2D3bITZCvqRfCrX4Y7skq1S1d
 Org1xM115JmTQNkiqzzX/aSsCIFAxbQj0GvRlp432D4QL9AJmAdpcAYyi56U+hbUdwMbprGTNHu
 d1x2wDCe5S0f8dkWZ8B2LzioiyiMDvxJ3kcMawQpWOMm4UIgl5iXPoEjcYF14eF4Nk77zht4MC9
 UsGYG4Ry/vPvu4i2YLWsoqynelkBWy15zItik9GUxEsI4G0ms+EwMwmw61DhNzdwABZrmiMhiz+
 ug3TAfQnuzqyhYx6jkDNtt+tZS/5Zw40HNmhZ+uVLF1e0KKs3yprZ0upvQh5GbNdcSWRGMuNs/u
 9kVTj/HGWkX3E6R3meDV+htA8y94IRXxoI5SfNOGthWX+n33wBpABuj/P+q4486OcGdi3cLFH/l
 m57JI2GxMYlZYXxwVgtS5fusIRoZe9EyBBbu4kZSgfYOW2OLxpyUmNbuOe3wHVkQhkBLzQvj1bY
 w5VkbnQTUaWflHQWkQPB2cmjD4rqmAFTl6nrLegNI3UOIoI0FXsEYmSshwszWGJJwmfaLvKAQe4
 Q3KizdRIYQhJIx+0u9eDj/S3ECdTLvRT2Kpt3brF/Im5ZQwhm1ql/9rvKO01OXgtTHd8Di9DnDj
 UmKS08MEVTcqI+w==
X-Developer-Key: i=louis.chauvet@bootlin.com; a=openpgp;
 fpr=8B7104AE9A272D6693F527F2EC1883F55E0B40A5
X-GND-Sasl: louis.chauvet@bootlin.com

The current interrupt handler in xdma.c was using xdma->stop_request
before locking the vchan lock.

Fixes: 6a40fb824596 ("dmaengine: xilinx: xdma: Fix synchronization issue")
Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
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


