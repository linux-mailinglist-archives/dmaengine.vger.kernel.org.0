Return-Path: <dmaengine+bounces-9806-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ZeTbDMb/zGlNZQYAu9opvQ
	(envelope-from <dmaengine+bounces-9806-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 01 Apr 2026 13:21:42 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E015D3794B3
	for <lists+dmaengine@lfdr.de>; Wed, 01 Apr 2026 13:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7DD6530B83B4
	for <lists+dmaengine@lfdr.de>; Wed,  1 Apr 2026 10:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7029401A05;
	Wed,  1 Apr 2026 10:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bereza.email header.i=@bereza.email header.b="PjqYLWLj"
X-Original-To: dmaengine@vger.kernel.org
Received: from fsn-vps-1.bereza.email (fsn-vps-1.bereza.email [162.55.44.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6A73F881A;
	Wed,  1 Apr 2026 10:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.55.44.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775041023; cv=none; b=UoczDfUEkZDxuYys7bsjncNtg/ZfMzlqeB4vHyoKSgfjjosKXucea+8AVjO4l2faj50ek1fSN8onvPbpe6FIg+PK/5PYUYIpwJ4/ZwI+9XEyayta7vRPg9TJX6O4UiBQe1TMKRzCpyMQUOayfpbLZNhVsULDr10z9epG73m1jtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775041023; c=relaxed/simple;
	bh=9YI3mR7RGj+FXV1f08vFjbtn+zYBmLDDNzXU0ekoR44=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pUlQIrbnOR7Hls4a4OfegplVEhoDRYz2o0LFmQpFh3t02LS/bUHZZv8Jl2y2eRM93Am3a/XK6bmraG7pt7bq9sJdovi0rsmCk4PDaCUhIe6fiSIh9hc+HgHsYdnH+83WDfw5O8vn3JC92MlecdfyYnvsIFdMa+VCnl3Up/0w4Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bereza.email; spf=pass smtp.mailfrom=bereza.email; dkim=pass (2048-bit key) header.d=bereza.email header.i=@bereza.email header.b=PjqYLWLj; arc=none smtp.client-ip=162.55.44.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bereza.email
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bereza.email
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bereza.email; s=mail;
	t=1775041020; bh=9YI3mR7RGj+FXV1f08vFjbtn+zYBmLDDNzXU0ekoR44=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PjqYLWLjqMaKbIakqE0KTgyHhH6palLoN0nAzlVrxhL0W3elcKAwhYAu31ClYBzs1
	 iZFS4XBBkRfnYBjTsmsMjsnKF3Iw+BDwDQsn3Ae33Hw4KtwpDQrFSb7m6rlVwJe/+Q
	 0jyhrF1IASVBehnmhl4k9gI5NSKmfoVhcmR5xPovtNnGrfzcrzdHwO7vmqcQXcs+Vw
	 vmyzKugCNbBrG8TY9tdysO9T+M2A2Ts6j7+0QdAIxnH4m5iXhc3X4aePc3wkIcabqT
	 u0oc3OT3KmhPLFYW+HR42quPBjHu855iIj8HGtPNNqbBgXE7GdhKGxkeC/FXaZt+q1
	 j+Z3SCfNCUtLw==
Received: from [127.0.1.1] (pd95bbad8.dip0.t-ipconnect.de [217.91.186.216])
	by fsn-vps-1.bereza.email (Postfix) with ESMTPSA id 7D0EA5DF96;
	Wed,  1 Apr 2026 12:57:00 +0200 (CEST)
From: Alex Bereza <alex@bereza.email>
Date: Wed, 01 Apr 2026 12:56:33 +0200
Subject: [PATCH v3 2/2] dmaengine: xilinx_dma: Rename XILINX_DMA_LOOP_COUNT
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260401-fix-atomic-poll-timeout-regression-v3-2-85508f0aedde@bereza.email>
References: <20260401-fix-atomic-poll-timeout-regression-v3-0-85508f0aedde@bereza.email>
In-Reply-To: <20260401-fix-atomic-poll-timeout-regression-v3-0-85508f0aedde@bereza.email>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Michal Simek <michal.simek@amd.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
 Tony Lindgren <tony@atomide.com>, 
 Kedareswara rao Appana <appana.durga.rao@xilinx.com>
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Alex Bereza <alex@bereza.email>
X-Mailer: b4 0.15.1
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bereza.email,quarantine];
	R_DKIM_ALLOW(-0.20)[bereza.email:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9806-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alex@bereza.email,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[bereza.email:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,bereza.email:dkim,bereza.email:email,bereza.email:mid]
X-Rspamd-Queue-Id: E015D3794B3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Rename XILINX_DMA_LOOP_COUNT to XILINX_DMA_POLL_TIMEOUT_US because the
former is incorrect. It is a timeout value for polling various register
bits in microseconds. It is not a loop count.

Signed-off-by: Alex Bereza <alex@bereza.email>
---
 drivers/dma/xilinx/xilinx_dma.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 345a738bab2c..253c27fd1a0e 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -165,8 +165,8 @@
 #define XILINX_DMA_FLUSH_MM2S		2
 #define XILINX_DMA_FLUSH_BOTH		1
 
-/* Delay loop counter to prevent hardware failure */
-#define XILINX_DMA_LOOP_COUNT		1000000
+/* Timeout for polling various registers */
+#define XILINX_DMA_POLL_TIMEOUT_US	1000000
 /* Delay between polls (avoid a delay of 0 to prevent CPU stalls) */
 #define XILINX_DMA_POLL_DELAY_US	10
 
@@ -1336,7 +1336,7 @@ static int xilinx_dma_stop_transfer(struct xilinx_dma_chan *chan)
 	return xilinx_dma_poll_timeout(chan, XILINX_DMA_REG_DMASR, val,
 				       val & XILINX_DMA_DMASR_HALTED,
 				       XILINX_DMA_POLL_DELAY_US,
-				       XILINX_DMA_LOOP_COUNT);
+				       XILINX_DMA_POLL_TIMEOUT_US);
 }
 
 /**
@@ -1352,7 +1352,7 @@ static int xilinx_cdma_stop_transfer(struct xilinx_dma_chan *chan)
 	return xilinx_dma_poll_timeout(chan, XILINX_DMA_REG_DMASR, val,
 				       val & XILINX_DMA_DMASR_IDLE,
 				       XILINX_DMA_POLL_DELAY_US,
-				       XILINX_DMA_LOOP_COUNT);
+				       XILINX_DMA_POLL_TIMEOUT_US);
 }
 
 /**
@@ -1370,7 +1370,7 @@ static void xilinx_dma_start(struct xilinx_dma_chan *chan)
 	err = xilinx_dma_poll_timeout(chan, XILINX_DMA_REG_DMASR, val,
 				      !(val & XILINX_DMA_DMASR_HALTED),
 				      XILINX_DMA_POLL_DELAY_US,
-				      XILINX_DMA_LOOP_COUNT);
+				      XILINX_DMA_POLL_TIMEOUT_US);
 
 	if (err) {
 		dev_err(chan->dev, "Cannot start channel %p: %x\n",
@@ -1787,7 +1787,7 @@ static int xilinx_dma_reset(struct xilinx_dma_chan *chan)
 	err = xilinx_dma_poll_timeout(chan, XILINX_DMA_REG_DMACR, tmp,
 				      !(tmp & XILINX_DMA_DMACR_RESET),
 				      XILINX_DMA_POLL_DELAY_US,
-				      XILINX_DMA_LOOP_COUNT);
+				      XILINX_DMA_POLL_TIMEOUT_US);
 
 	if (err) {
 		dev_err(chan->dev, "reset timeout, cr %x, sr %x\n",

-- 
2.53.0


