Return-Path: <dmaengine+bounces-9824-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPseOpkgzmnElAYAu9opvQ
	(envelope-from <dmaengine+bounces-9824-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 02 Apr 2026 09:54:01 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 52948385782
	for <lists+dmaengine@lfdr.de>; Thu, 02 Apr 2026 09:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86AB93068F07
	for <lists+dmaengine@lfdr.de>; Thu,  2 Apr 2026 07:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384C2389DE3;
	Thu,  2 Apr 2026 07:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bereza.email header.i=@bereza.email header.b="YO+fG+cH"
X-Original-To: dmaengine@vger.kernel.org
Received: from fsn-vps-1.bereza.email (fsn-vps-1.bereza.email [162.55.44.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329DD359A7C;
	Thu,  2 Apr 2026 07:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.55.44.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775116037; cv=none; b=TmQBO/XNgc3nU+vL80YUmf5S574XZ5QTXIllE95kQFVBZTrp1vwiZNb2Tbn0dg0cAJMCSflDcGj8xNkgOHK7EZba7UCrQ1E6ryTw/CZcTGEltLfZ3lho41jCDZk/PppA+I2W914PBcx8UOsAB4kOeX2wTzaLOgQ6iZKDoD2E/C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775116037; c=relaxed/simple;
	bh=CF7O3i7wHSzlyimOTIc/kLCwdu7hGG6ESx7aNHgmZKQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Em51eTMuBL3KDRtdBQICArXrnuA33xmeftPV/ujkkhqAezxuvdbhYXfQKjc3gp331bs4AWcR0ZycTmoznwj+9mYjkB58vRA933XyhuoFgzgRr7VBtYDSPPOjBEIbywjRcSV5yX9KTvtYv4kQSZPlloF1sUdKxftLO+JHtgCftZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bereza.email; spf=pass smtp.mailfrom=bereza.email; dkim=pass (2048-bit key) header.d=bereza.email header.i=@bereza.email header.b=YO+fG+cH; arc=none smtp.client-ip=162.55.44.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bereza.email
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bereza.email
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bereza.email; s=mail;
	t=1775116026; bh=CF7O3i7wHSzlyimOTIc/kLCwdu7hGG6ESx7aNHgmZKQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YO+fG+cHociVuiNRfv2Aquhhm8HO/hcJjZnR2tL8+48Asp/a9n01WNjJA5zLEk+D0
	 Yqj9zL0MqleqT6hVkSIT5gejgqXG5KbHlxQVHE9flxDRkq4LpSm9xnzTQoo6Cuao5R
	 LUdPgW4StDCpyo1EoJXT8D6CqMEDoupZyg6EbPqH0hSiwoBZ5lAV4L9N8N6lm1mnZ7
	 9oiJFRx4TD5z+/9IqR5UiVT1VNtGUrrh761E9AJi+qxINcVEt5taHBXLuPyY4OyxOz
	 j2N4NUnHyAcGyUrm4R+plaZv9NilFcihhDKfp6ZaeVipsG7OBW2XZnYSx1k1cmNW0W
	 s+9LzQNJKYwpQ==
Received: from [127.0.1.1] (pd95bbad8.dip0.t-ipconnect.de [217.91.186.216])
	by fsn-vps-1.bereza.email (Postfix) with ESMTPSA id 67B966025A;
	Thu,  2 Apr 2026 09:47:06 +0200 (CEST)
From: Alex Bereza <alex@bereza.email>
Date: Thu, 02 Apr 2026 09:46:23 +0200
Subject: [PATCH v4 2/2] dmaengine: xilinx_dma: Rename XILINX_DMA_LOOP_COUNT
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-fix-atomic-poll-timeout-regression-v4-2-f30d6a6c13cb@bereza.email>
References: <20260402-fix-atomic-poll-timeout-regression-v4-0-f30d6a6c13cb@bereza.email>
In-Reply-To: <20260402-fix-atomic-poll-timeout-regression-v4-0-f30d6a6c13cb@bereza.email>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Michal Simek <michal.simek@amd.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
 Tony Lindgren <tony@atomide.com>, 
 Kedareswara rao Appana <appana.durga.rao@xilinx.com>
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Alex Bereza <alex@bereza.email>, 
 Suraj Gupta <suraj.gupta2@amd.com>
X-Mailer: b4 0.15.1
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bereza.email,quarantine];
	R_DKIM_ALLOW(-0.20)[bereza.email:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9824-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alex@bereza.email,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[bereza.email:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email]
X-Rspamd-Queue-Id: 52948385782
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Rename XILINX_DMA_LOOP_COUNT to XILINX_DMA_POLL_TIMEOUT_US because it is
a timeout value, not a loop count for polling register in microseconds.

No functional changes.

Reviewed-by: Suraj Gupta <suraj.gupta2@amd.com>
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


