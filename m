Return-Path: <dmaengine+bounces-9377-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oC3nLCL/sGljpgIAu9opvQ
	(envelope-from <dmaengine+bounces-9377-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 11 Mar 2026 06:35:30 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 58AEC25C790
	for <lists+dmaengine@lfdr.de>; Wed, 11 Mar 2026 06:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C39B5302977C
	for <lists+dmaengine@lfdr.de>; Wed, 11 Mar 2026 05:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E28301708;
	Wed, 11 Mar 2026 05:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Dq5cjP1d"
X-Original-To: dmaengine@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831BF1D5ADE;
	Wed, 11 Mar 2026 05:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773207326; cv=none; b=G3ixYJa4Ek2NoGPzjXSCWa8fnd80tzo74gItBlWGkugrpil94Y+W9Dg7UTcYo/WPQftxBYsx+msdnqlPeDenEk/OJqxruSHgYOd7zAU0lKfJ76HWbrNeX8LTqdOVOQASPpm1Ez5CXzoiVxm+s8msr2Kq/am4DPbvIONoT2+uUtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773207326; c=relaxed/simple;
	bh=FLKf2KNUhcSfWOh79rwBmsC6RKR5mCsHFe+rCiWz4Yc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Jr9IRrEatGW6Lc9y+Gp1J+mSo+IaNu+jLc9F0WUpvqBZa2Da1CyTEzYONfRHvj81OHTvlE4olvRl0cXuDdtxD2vd3EiVTUkAV/stMSF+a0UTL5mi0FHWfCW/35fpvpk5W8cHUbNPx+iodMCceXChHdxl32DlrwaRKBAAhExCUR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Dq5cjP1d; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 35B543DA;
	Wed, 11 Mar 2026 06:34:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1773207253;
	bh=FLKf2KNUhcSfWOh79rwBmsC6RKR5mCsHFe+rCiWz4Yc=;
	h=From:Date:Subject:To:Cc:From;
	b=Dq5cjP1dPkqs4P5YWNoQQXFqO44gF/zAoZeLn1Kk+rDFTi3xdr+HX+8h97A5sp/co
	 /eOT2sToxU7oGJ/g/CRxB+n6r2lFx1F6cKP4EVYMNFG70XCXFgnu1PvRu4Qa1CvB4K
	 t2NOu6XrR9YvpSdshdrKbYiF4GKy+fFDscnVkr3c=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 11 Mar 2026 07:34:46 +0200
Subject: [PATCH v2] dmaengine: xilinx_dma: Fix reset related timeout with
 two-channel AXIDMA
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-xilinx-dma-fix-v2-1-a725abb66e3c@ideasonboard.com>
X-B4-Tracking: v=1; b=H4sIAPb+sGkC/3WMywrCMBBFf6XM2pEmkFBd+R/SRR6jHbCJJCVES
 v7d2L13dw7cs0OmxJThOuyQqHDmGDrI0wBuMeFJyL4zyFEq0YeVXxwq+tXggytaJ7XRdLGkDPT
 TO1HXR/A+d144bzF9jn4RP/s3VQQKHLV2Qk3WiYlu7MnkGGw0yZ9dXGFurX0B5WXNjrMAAAA=
X-Change-ID: 20251111-xilinx-dma-fix-bc26a6e9be5a
To: Vinod Koul <vkoul@kernel.org>, Michal Simek <michal.simek@amd.com>
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Vishal Sagar <vishal.sagar@amd.com>, 
 Suraj Gupta <Suraj.Gupta2@amd.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4466;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=FLKf2KNUhcSfWOh79rwBmsC6RKR5mCsHFe+rCiWz4Yc=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBpsP8TJ514U8+kbT+XwJ1IXPYHGlpiw71KJ4gQX
 fCvGGVGBIKJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCabD/EwAKCRD6PaqMvJYe
 9eUYD/9TaVPyNGKOBg46lshwakseFhmIQdb8v+X44b7E0yzSXXjhSY0J0EDt5Z6yneJk7OOGwcO
 isHUVtcV0j3hvD1dj0aZvN21A9Znd9RAt02+Uk8VuoMXq+AdYs6fc6/2PXhfHXUJ84rOj+kbl6Q
 /24mUUPyQTrJcmbtfFV8YdgX3ChS9hE9vWLsNPkA55Ed6T/d/AiPFAJlfe//Ddut5XKDUTPL9ft
 6Q9mm7wkJ4QCd04KsoCCvDbGwgT+CZ164RkoTb6qBGYm9VNw1aIj3HxOtyA0jdxstoQEhmNPhh3
 qSK58V5XyZMocQhZdW4kO40kuwkTAuCxFvVcqvZu+nnyw+OlUh9/NUGiLLu7SbMKI1uyOOYAkye
 /FTJM6RFUwgtP6yLF5u9RnqBnmvRNHGiWcvv8w5Y087QGRG1evLQsjXYLvGbJ56yVSB3XpNZ6Td
 uoODwEgCB5wxNyN65UcoG/lcJwW5r2Iq+CaexvozS36c/CsgUrmkfvKhM4t6Drdk2TgNtto0ATg
 XEHefvuoiUZzx5EqYe+5bPrp8qMg9kqKDTa/eVniInjunPkuOwVV96bWbne/zdH4h5Gsgv+h/r6
 in8bil8Nv451kLF6Uyyr8pAoQD99BPQC92+BSkabGmIp2p24HPHR3ZTqt+YCHrm2zxORZN4Aeqg
 djYcexLytcwSBFg==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
X-Rspamd-Queue-Id: 58AEC25C790
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ideasonboard.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[ideasonboard.com:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9377-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ideasonboard.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tomi.valkeinen@ideasonboard.com,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

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
Fixes: c0bba3a99f07 ("dmaengine: vdma: Add Support for Xilinx AXI Direct Memory Access Engine")
---
Changes in v2:
- Rewrite the title to reflect that this is a fix
- Add Fixes tag
- Rebase on v7.0-rc2
- Link to v1: https://lore.kernel.org/r/20251111-xilinx-dma-fix-v1-1-066c158bc18e@ideasonboard.com
---
 drivers/dma/xilinx/xilinx_dma.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index b53292e02448..ef397cd9ed5e 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -1235,14 +1235,6 @@ static int xilinx_dma_alloc_chan_resources(struct dma_chan *dchan)
 
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
@@ -1591,6 +1583,7 @@ static void xilinx_dma_start_transfer(struct xilinx_dma_chan *chan)
 			     head_desc->async_tx.phys);
 	reg  &= ~XILINX_DMA_CR_DELAY_MAX;
 	reg  |= chan->irq_delay << XILINX_DMA_CR_DELAY_SHIFT;
+	reg |= XILINX_DMA_DMAXR_ALL_IRQ_MASK;
 	dma_ctrl_write(chan, XILINX_DMA_REG_DMACR, reg);
 
 	xilinx_dma_start(chan);

---
base-commit: 11439c4635edd669ae435eec308f4ab8a0804808
change-id: 20251111-xilinx-dma-fix-bc26a6e9be5a

Best regards,
-- 
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>


