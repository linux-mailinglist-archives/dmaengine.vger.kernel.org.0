Return-Path: <dmaengine+bounces-9786-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNAyN+P9y2mcNAYAu9opvQ
	(envelope-from <dmaengine+bounces-9786-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 19:01:23 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BB436DA98
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 19:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 41B77311161A
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 16:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6B2426EDE;
	Tue, 31 Mar 2026 16:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bereza.email header.i=@bereza.email header.b="0bhZXFkZ"
X-Original-To: dmaengine@vger.kernel.org
Received: from fsn-vps-1.bereza.email (fsn-vps-1.bereza.email [162.55.44.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C574E413225;
	Tue, 31 Mar 2026 16:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.55.44.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975912; cv=none; b=GqaqDwQnk/y6fZ9PQ1qd0SKs5pfCiib2J29usfXB6igc/wGItPyaA4qDjByVV27m02Y8c75bwOGulEdk0nbC4Rm8U6zCNYnXFcZREsESwbOlbjBvHw2BhL12DphrFf40zsKpwGRbuVwc6nI+vJjMEE9RMebC6Cx4JbNd0Gb2xWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975912; c=relaxed/simple;
	bh=9PyHENddhGjJqQ3dIJrsaurapatYX0PZNL/WyIPsycU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qsNmxOhffLj9LEdoKuw3nrZV+FXUjJEAs5tdGzCmchut7Wcj2y6phWH49VDPtM6/7jmLE0NRos5YibrgXRd4D4JF1PgZUmzcAADtwzR9vgf1gy1CQaxBXU+AxbrAcFZDh/7hQErC0dXyatrGMNYLmFb1D2/GULiW+9/sOaapowY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bereza.email; spf=pass smtp.mailfrom=bereza.email; dkim=pass (2048-bit key) header.d=bereza.email header.i=@bereza.email header.b=0bhZXFkZ; arc=none smtp.client-ip=162.55.44.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bereza.email
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bereza.email
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bereza.email; s=mail;
	t=1774975460; bh=9PyHENddhGjJqQ3dIJrsaurapatYX0PZNL/WyIPsycU=;
	h=From:Date:Subject:To:Cc:From;
	b=0bhZXFkZ8tmu2R82WFklCpkQlIQx74k1AOnQWpeuPqlbOcibVoPZkRpHuO8a+GkZe
	 WzUEKi0EF0WeLB6NlvJ5PG4cxnGMO827wAxQpJ0SiraVIBFwnGU0v6LwYFQFUPaEuV
	 9XdsAfsiJP0GFVq5rWPU2xz3PHBwRymk7kr5IhrD9SekexTznbdI8fMOR8GsZnknjv
	 Ak3LoSaagaeYqXNCScR1v8p/DsfWFcq1ztuM4gAoU4Oh/i5XXis2Jzmf1EURQFQAQs
	 2YeTvmF+2ZtOz9qYGaUwms9V4EPFJigHvSfd84EmLFnOym0X1Qva1RDdqYW5OjnwfY
	 b02aave3JMFZw==
Received: from [127.0.1.1] (pd95bbad8.dip0.t-ipconnect.de [217.91.186.216])
	by fsn-vps-1.bereza.email (Postfix) with ESMTPSA id 5FC5F60F1B;
	Tue, 31 Mar 2026 18:44:20 +0200 (CEST)
From: Alex Bereza <alex@bereza.email>
Date: Tue, 31 Mar 2026 18:44:00 +0200
Subject: [PATCH] dmaengine: xilinx_dma: Fix CPU stall in
 xilinx_dma_poll_timeout
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260331-fix-atomic-poll-timeout-regression-v1-1-5b7bd96eaca0@bereza.email>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWNwQqDMBAFf0X23IXUiIX+Sukhxhe7RY1sYimI/
 95Yj3OYmY0SVJDoXm2k+EiSOBe4XiryLzcPYOkLU23q1lhrOMiXXY6TeF7iOHKWCXHNrBgU6dC
 5CQ1s54IN/Y1KaFEU6z95PE9Oa/eGz0eZ9v0H2q6Fh4YAAAA=
X-Change-ID: 20260330-fix-atomic-poll-timeout-regression-4f4e3baf3fd7
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Michal Simek <michal.simek@amd.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
 Tony Lindgren <tony@atomide.com>
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Alex Bereza <alex@bereza.email>
X-Mailer: b4 0.15.1
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bereza.email,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[bereza.email:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9786-lists,dmaengine=lfdr.de];
	DKIM_TRACE(0.00)[bereza.email:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alex@bereza.email,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A1BB436DA98
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Currently when calling xilinx_dma_poll_timeout with delay_us=0 and a
condition that is never fulfilled, the CPU busy-waits for prolonged time
and the timeout triggers only with a massive delay causing a CPU stall.

This happens due to a huge underestimation of wall clock time in
poll_timeout_us_atomic. Commit 7349a69cf312 ("iopoll: Do not use
timekeeping in read_poll_timeout_atomic()") changed the behavior to no
longer use ktime_get at the expense of underestimation of wall clock
time which appears to be very large for delay_us=0. Instead of timing
out after approximately XILINX_DMA_LOOP_COUNT microseconds, the timeout
takes XILINX_DMA_LOOP_COUNT * 1000 * (time that the overhead of the for
loop in poll_timeout_us_atomic takes) which is in the range of several
minutes for XILINX_DMA_LOOP_COUNT=1000000. Fix this by using a non-zero
value for delay_us. Use delay_us=10 to keep the delay in the hot path of
starting DMA transfers minimal but still avoid CPU stalls in case of
unexpected hardware failures.

One-off measurement with delay_us=0 causes the cpu to busy wait around 7
minutes in the timeout case. After applying this patch with delay_us=10
the measured timeout was 1053428 microseconds which is roughly
equivalent to the expected 1000000 microseconds specified in
XILINX_DMA_POLL_TIMEOUT_US.

Rename XILINX_DMA_LOOP_COUNT to XILINX_DMA_POLL_TIMEOUT_US because the
former is incorrect. It is a timeout value for polling various register
bits in microseconds. It is not a loop count. Add a constant
XILINX_DMA_POLL_DELAY_US for delay_us value.

Fixes: 7349a69cf312 ("iopoll: Do not use timekeeping in read_poll_timeout_atomic()")
Signed-off-by: Alex Bereza <alex@bereza.email>
---
Hi, in addition to this patch I also have a question: what is the point
of atomically polling for the HALTED or IDLE bit in the stop_transfer
functions? Does device_terminate_all really need to be callable from
atomic context? If not, one could switch to polling non-atomically and
avoid burning CPU cycles.

As this is my first patch, please feel free to point me in the right
direction if I am missing anything.
---
 drivers/dma/xilinx/xilinx_dma.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 02a05f215614..8556c357b665 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -165,8 +165,10 @@
 #define XILINX_DMA_FLUSH_MM2S		2
 #define XILINX_DMA_FLUSH_BOTH		1
 
-/* Delay loop counter to prevent hardware failure */
-#define XILINX_DMA_LOOP_COUNT		1000000
+/* Timeout for polling various registers */
+#define XILINX_DMA_POLL_TIMEOUT_US		1000000
+/* Delay between polls (avoid a delay of 0 to prevent CPU stalls) */
+#define XILINX_DMA_POLL_DELAY_US		10
 
 /* AXI DMA Specific Registers/Offsets */
 #define XILINX_DMA_REG_SRCDSTADDR	0x18
@@ -1332,8 +1334,9 @@ static int xilinx_dma_stop_transfer(struct xilinx_dma_chan *chan)
 
 	/* Wait for the hardware to halt */
 	return xilinx_dma_poll_timeout(chan, XILINX_DMA_REG_DMASR, val,
-				       val & XILINX_DMA_DMASR_HALTED, 0,
-				       XILINX_DMA_LOOP_COUNT);
+				       val & XILINX_DMA_DMASR_HALTED,
+				       XILINX_DMA_POLL_DELAY_US,
+				       XILINX_DMA_POLL_TIMEOUT_US);
 }
 
 /**
@@ -1347,8 +1350,9 @@ static int xilinx_cdma_stop_transfer(struct xilinx_dma_chan *chan)
 	u32 val;
 
 	return xilinx_dma_poll_timeout(chan, XILINX_DMA_REG_DMASR, val,
-				       val & XILINX_DMA_DMASR_IDLE, 0,
-				       XILINX_DMA_LOOP_COUNT);
+				       val & XILINX_DMA_DMASR_IDLE,
+				       XILINX_DMA_POLL_DELAY_US,
+				       XILINX_DMA_POLL_TIMEOUT_US);
 }
 
 /**
@@ -1364,8 +1368,9 @@ static void xilinx_dma_start(struct xilinx_dma_chan *chan)
 
 	/* Wait for the hardware to start */
 	err = xilinx_dma_poll_timeout(chan, XILINX_DMA_REG_DMASR, val,
-				      !(val & XILINX_DMA_DMASR_HALTED), 0,
-				      XILINX_DMA_LOOP_COUNT);
+				      !(val & XILINX_DMA_DMASR_HALTED),
+				      XILINX_DMA_POLL_DELAY_US,
+				      XILINX_DMA_POLL_TIMEOUT_US);
 
 	if (err) {
 		dev_err(chan->dev, "Cannot start channel %p: %x\n",
@@ -1780,8 +1785,9 @@ static int xilinx_dma_reset(struct xilinx_dma_chan *chan)
 
 	/* Wait for the hardware to finish reset */
 	err = xilinx_dma_poll_timeout(chan, XILINX_DMA_REG_DMACR, tmp,
-				      !(tmp & XILINX_DMA_DMACR_RESET), 0,
-				      XILINX_DMA_LOOP_COUNT);
+				      !(tmp & XILINX_DMA_DMACR_RESET),
+				      XILINX_DMA_POLL_DELAY_US,
+				      XILINX_DMA_POLL_TIMEOUT_US);
 
 	if (err) {
 		dev_err(chan->dev, "reset timeout, cr %x, sr %x\n",

---
base-commit: b7560798466a07d9c3fb011698e92c335ab28baf
change-id: 20260330-fix-atomic-poll-timeout-regression-4f4e3baf3fd7

Best regards,
--  
Alex Bereza <alex@bereza.email>


