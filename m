Return-Path: <dmaengine+bounces-7135-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3C3C4EB62
	for <lists+dmaengine@lfdr.de>; Tue, 11 Nov 2025 16:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66E931885E51
	for <lists+dmaengine@lfdr.de>; Tue, 11 Nov 2025 15:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7418935A15D;
	Tue, 11 Nov 2025 15:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="SY9ZyJo/"
X-Original-To: dmaengine@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BE92ECD37;
	Tue, 11 Nov 2025 15:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762873628; cv=none; b=RHmzINj1QbZAXKihMORj3oRFT96jLKb/9ZJ+ubNMhVLSq3d1D7mPE74SwkaBoMngiIFHmtQz9LbAsuggrMQwU25u3IXCozzJ+KO329XwwcXu7o5pYQBmBO3OIQaCeS52lUO/LJStAIzzbJX6nehcMD7x3HN5ZnhCA9IWLXKDjWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762873628; c=relaxed/simple;
	bh=8ab0z0efd7h/t9/jZI966Tl0kwb7kTcwZtcQTAG26U8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=B8/0ECPVHVF/G4oQxy2r0AS33ofjol10zRfM9+oOO9L19ByCVFiXr5fYiry0DHjq6D27bR4FYmQCIo3k3hMijnVOwAC0rlR5gLOvsPQPgxTbjXn9MQJ/zH7+TKfSZIJXMTu4e1TZ2BabSQ2G32/KbQ7wy3uahAhBth3M7P8FDLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=SY9ZyJo/; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8BA281D29;
	Tue, 11 Nov 2025 16:05:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1762873502;
	bh=8ab0z0efd7h/t9/jZI966Tl0kwb7kTcwZtcQTAG26U8=;
	h=From:Date:Subject:To:Cc:From;
	b=SY9ZyJo/oCpZk1StEFEsbzrZICx+SgG+8W04Zk33YiJa+U6B223euzr/ALTt/iyU3
	 qESkUdMVVnUHR6DtkRul3YjFf8mwUgNHl4CIA1fstjcOfK8aO21GGnQAjOmANRs6GF
	 4/aRNtOskk60OtE7sN6vsy1A3Ud8kk1Lfp6psDhI=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Tue, 11 Nov 2025 17:06:41 +0200
Subject: [PATCH] dmaengine: xilinx_dma: Enable IRQs for AXIDMA in
 start_transfer
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251111-xilinx-dma-fix-v1-1-066c158bc18e@ideasonboard.com>
X-B4-Tracking: v=1; b=H4sIAABRE2kC/x2MUQqAIBAFrxL73UIKCnWV6MN0q4WyUAhBvHtL8
 zcD71XIlJgyTF2FRC9nvqOI6jvwh4s7IQdx0IM2SsDCJ8eC4XK4ccHVa+ssjSsZBzJ6Ekn+D+e
 ltQ8ibdONYAAAAA==
X-Change-ID: 20251111-xilinx-dma-fix-bc26a6e9be5a
To: Vinod Koul <vkoul@kernel.org>, Michal Simek <michal.simek@amd.com>
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Vishal Sagar <vishal.sagar@amd.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4158;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=8ab0z0efd7h/t9/jZI966Tl0kwb7kTcwZtcQTAG26U8=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBpE1EQD3Na3TcGQCyk+gNyK1DTZlQgsvZeDWMo3
 qIWsGhhp0CJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCaRNREAAKCRD6PaqMvJYe
 9dh8EACUAQP2hyhea7187lj/rvm8d1q44qxnmz2N76+XM/6vf5gBBY7+VH8jxEnizjHJfDDCoDR
 Q0/m7vdvRedFd0OCU7opESRUKiVgjWlTQZandFVgncmxWXoH/kPyGKRVrl/RiL7eKGg1CldIhoW
 +1WsZP3Y3SqT+rW/f0mpijlycjblGSOQzOWz85hFVK/soMsPNOBlODIvQheuKhtvuAojKg9MAlQ
 S/ga6Y/shFQuMgEHrqrlS+zrUcPir7swzyU+2MJaHtb14baZGKlof3bX+prrgfoIK/4DYPE8QZn
 qvZbI7VyruS1MlZ/T7Fz/PoVbO1Y+SSSexOMFT0/GvOaQ2HR4K7m7a7OAI02XhHOdCeouil2+bz
 9vXC7K0DQIhhYxUOvtakrXc9Sr+UbBEFfk/j8hWE3IW/x5yUQOA1HgwEgIj/ZhY2N520/XUVP4J
 iTPdpWMaaghnX9LGwR9dR62DKtPAgRtFFgZCwc/OQZ3r/jwMRQWeWXQ4prIoW/NwWN+Q/P007MF
 r3vuV1B1obpbzg1+Rh5fbQylvcM2E927ZguBYJ5704bOcJRR0fo4rniVoDYISBPNDf2d9hxs4lA
 KIjdkIE5eDgwT+IwbIIrZGOF14Taj3RUBDE2hh3RZL51mg5MLICs8IpiFcZbF81jq1NtP1vDQnK
 eOk0ZWeM1BFsW4g==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

A single AXIDMA controller can have one or two channels. When it has two
channels, the reset for both are tied together: resetting one channel
resets the other as well. This creates a problem where resetting one
channel will reset the registers for both channels, including clearing
interrupt enable bits for the other channel, which can then lead  to
timeouts as the driver is waiting for an interrupt which never comes.

The driver currently has a probe-time work around for this: when a
channel is created, the driver also resets and enables the
interrupts. With two channels the reset for the second channel will
clear the interrupt enables for the first one. The work around in the
driver is just to manually enable the interrupts again in
xilinx_dma_alloc_chan_resources().

This workaround only addresses the probe-time issue. When channels are
reset at runtime (e.g., in xilinx_dma_terminate_all() or during error
recovery), there's no corresponding mechanism to restore the other
channel's interrupt enables. This leads to one channel having its
interrupts disabled while the driver expects them to work, causing
timeouts and DMA failures.

A proper fix is a complicated matter, as we should not reset the other
channel when it's operating normally. So, perhaps, there should be some
kind of synchronization for a common reset, which is not trivial to
implement. To add to the complexity, the driver also supports other DMA
types, like VDMA, CDMA and MCDMA, which don't have a shared reset.

However, when the two-channel AXIDMA is used in the (assumably) normal
use case, providing DMA for a single memory-to-memory device, the common
reset is a bit smaller issue: when something bad happens on one channel,
or when one channel is terminated, the assumption is that we also want
to terminate the other channel. And thus resetting both at the same time
is "ok".

With that line of thinking we can implement a bit better work around
than just the current probe time work around: let's enable the
AXIDMA interrupts at xilinx_dma_start_transfer() instead.
This ensures interrupts are enabled whenever a transfer starts,
regardless of any prior resets that may have cleared them.

This approach is also more logical: enable interrupts only when needed
for a transfer, rather than at resource allocation time, and, I think,
all the other DMA types should also use this model, but I'm reluctant to
do such changes as I cannot test them.

The reset function still enables interrupts even though it's not needed
for AXIDMA anymore, but it's common code for all DMA types (VDMA, CDMA,
MCDMA), so leave it unchanged to avoid affecting other variants.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/dma/xilinx/xilinx_dma.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index a34d8f0ceed8..50dd93ce6741 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -1216,14 +1216,6 @@ static int xilinx_dma_alloc_chan_resources(struct dma_chan *dchan)
 
 	dma_cookie_init(dchan);
 
-	if (chan->xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA) {
-		/* For AXI DMA resetting once channel will reset the
-		 * other channel as well so enable the interrupts here.
-		 */
-		dma_ctrl_set(chan, XILINX_DMA_REG_DMACR,
-			      XILINX_DMA_DMAXR_ALL_IRQ_MASK);
-	}
-
 	if ((chan->xdev->dma_config->dmatype == XDMA_TYPE_CDMA) && chan->has_sg)
 		dma_ctrl_set(chan, XILINX_DMA_REG_DMACR,
 			     XILINX_CDMA_CR_SGMODE);
@@ -1572,6 +1564,7 @@ static void xilinx_dma_start_transfer(struct xilinx_dma_chan *chan)
 			     head_desc->async_tx.phys);
 	reg  &= ~XILINX_DMA_CR_DELAY_MAX;
 	reg  |= chan->irq_delay << XILINX_DMA_CR_DELAY_SHIFT;
+	reg |= XILINX_DMA_DMAXR_ALL_IRQ_MASK;
 	dma_ctrl_write(chan, XILINX_DMA_REG_DMACR, reg);
 
 	xilinx_dma_start(chan);

---
base-commit: e5f0a698b34ed76002dc5cff3804a61c80233a7a
change-id: 20251111-xilinx-dma-fix-bc26a6e9be5a

Best regards,
-- 
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>


