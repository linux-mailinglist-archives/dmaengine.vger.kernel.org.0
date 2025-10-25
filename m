Return-Path: <dmaengine+bounces-6991-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E5EC09B8D
	for <lists+dmaengine@lfdr.de>; Sat, 25 Oct 2025 18:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7823F3AC6A7
	for <lists+dmaengine@lfdr.de>; Sat, 25 Oct 2025 16:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6083195E8;
	Sat, 25 Oct 2025 16:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ECqwc7WD"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D801A3195E6;
	Sat, 25 Oct 2025 16:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761409598; cv=none; b=H17ikeF/PhoCsd5O7y3LPl4vrl9wXUefmj5bI0+c9T43hdERyQyRwfwHdlRLLBFbVoF2CwhcL2bzAKLQijnMWyyhO0zAGzPkkFNO+o+tC8dYpjQaw3Q62w5TfeQboUGn5HbxPTuOR4tOk/hcleFZx10H6VX4uObq3nNnRXiYwJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761409598; c=relaxed/simple;
	bh=dlnP5//GcbFLak41PGiJ7pnUEODVxjbgvvhsjzd+5qE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ChWy6G04hpdoLCmalpqsgFi4rW/ZauBZG4TrGDp7+Vs1pYJ8hji9jCvc9BI93ff3ReTMoJOseVVMIED8+jN6Eg13EuuFF7QEAyVwHR89p4yXVvdBQfr3AzaPEymqT11LeaxEDMeAYUBZMI1buqJBycy4pr3Mnyt3mHLu5JT4DOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ECqwc7WD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E18E8C113D0;
	Sat, 25 Oct 2025 16:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761409598;
	bh=dlnP5//GcbFLak41PGiJ7pnUEODVxjbgvvhsjzd+5qE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ECqwc7WDnV0hz6Uv4285UJ57RL33mz+J5HN+Jxl+fVdBNU04e8EM8R+Ytay/oSomo
	 WwbBpn9IUuaSp2bOHeU1Gevs1giPnLPDqSWFeLsVjHMnctpGoSbI+AvMDLnr6fUJoe
	 xMOHMDU3I1yk4Ew/HzOVTodx0hjwDWTUBN+iYqDOj9MkQQxxonJQP5IMJIOylYD765
	 auZ2Z+HSRt8JohEGhvomVzZw02QZITXJJLdFVBrcDpognpF2evwmc8UEkr2Aqx9yv5
	 Y65t2K3ybNbIxH/pPqdpd7q+GXlpo+b/RVjQnhMgYP5eLpIP/pWQ1i02lrC7f6ABnF
	 /d14K2zF9JyQA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Devendra K Verma <devverma@amd.com>,
	Vinod Koul <vkoul@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	mani@kernel.org,
	dmaengine@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17-5.4] dmaengine: dw-edma: Set status for callback_result
Date: Sat, 25 Oct 2025 12:00:15 -0400
Message-ID: <20251025160905.3857885-384-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251025160905.3857885-1-sashal@kernel.org>
References: <20251025160905.3857885-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Devendra K Verma <devverma@amd.com>

[ Upstream commit 5e742de97c806a4048418237ef1283e7d71eaf4b ]

DMA Engine has support for the callback_result which provides
the status of the request and the residue. This helps in
determining the correct status of the request and in
efficient resource management of the request.
The 'callback_result' method is preferred over the deprecated
'callback' method.

Signed-off-by: Devendra K Verma <devverma@amd.com>
Link: https://lore.kernel.org/r/20250821121505.318179-1-devverma@amd.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES

- What it fixes
  - Before this change, virt-dma initializes every descriptor’s result
    to “no error, residue 0” and drivers that don’t overwrite it will
    always report success with no remaining bytes, even on abort or
    partial transfer. See default init in vchan_tx_prep:
    drivers/dma/virt-dma.h:66 and drivers/dma/virt-dma.h:67.
  - This patch correctly sets both the transaction status and residue in
    the dw-edma driver when a transfer completes or aborts, so clients
    using callback_result get accurate results rather than misleading
    defaults.

- What changed, precisely
  - Adds a helper to compute and set the result if a `callback_result`
    was registered:
    - Helper introduction: drivers/dma/dw-edma/dw-edma-core.c:587
    - Guard against legacy callbacks (no change if `tx.callback_result`
      is NULL): drivers/dma/dw-edma/dw-edma-core.c:594
    - Residue computed as bytes left in the descriptor: `desc->alloc_sz
      - desc->xfer_sz` at drivers/dma/dw-edma/dw-edma-core.c:599
  - Sets result on successful completion (no remaining chunks) to
    NOERROR, then completes the cookie:
    - Call site in done IRQ: drivers/dma/dw-edma/dw-edma-core.c:619
  - Sets result on abort to ABORTED, then completes the cookie:
    - Call site in abort IRQ: drivers/dma/dw-edma/dw-edma-core.c:657
  - The result struct is then propagated by virt-dma when invoking the
    client’s callback_result:
    - vchan_complete uses `vd->tx_result` for invocation:
      drivers/dma/virt-dma.c:101

- Consistency with existing semantics
  - The residue computation matches what `tx_status` reports (same
    `alloc_sz - xfer_sz` basis), so callback_result and tx_status agree:
    - Residue for tx_status: drivers/dma/dw-edma/dw-edma-core.c:340
  - The driver already advertises `DMA_RESIDUE_GRANULARITY_DESCRIPTOR`,
    so per-descriptor residue reporting is expected and appropriate:
    drivers/dma/dw-edma/dw-edma-core.c:813

- Risk assessment
  - Scope is minimal and self-contained to the dw-edma driver:
    introduction of one helper and two guarded call sites in IRQ paths.
    No architectural changes.
  - Safe for legacy users: if a client still uses the deprecated
    `callback` (no `callback_result`), the helper is a no-op
    (drivers/dma/dw-edma/dw-edma-core.c:594), and virt-dma continues to
    invoke the legacy callback path unchanged.
  - Concurrency is respected: both call sites execute under
    `chan->vc.lock`, and fields used for residue (`alloc_sz`, `xfer_sz`)
    are already updated under the same locking in the transfer path.

- Why this fits stable backport criteria
  - Correctness bugfix: ensures accurate completion status and residue
    are delivered to clients using the standard DMAEngine
    `callback_result`, preventing misinterpretation of aborts as
    successful completions or reporting zero residue when bytes remain.
  - Small, contained change in a single driver, low regression risk, no
    new features or API changes, aligns with established DMAEngine
    usage.

Notes
- One follow-up improvement (not required for this backport) would be to
  also set an explicit status when handling `EDMA_REQ_STOP` in the done
  interrupt path (drivers/dma/dw-edma/dw-edma-core.c:630), but the
  absence of that does not detract from the clear correctness win
  provided here.

 drivers/dma/dw-edma/dw-edma-core.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index b43255f914f33..8e5f7defa6b67 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -584,6 +584,25 @@ dw_edma_device_prep_interleaved_dma(struct dma_chan *dchan,
 	return dw_edma_device_transfer(&xfer);
 }
 
+static void dw_hdma_set_callback_result(struct virt_dma_desc *vd,
+					enum dmaengine_tx_result result)
+{
+	u32 residue = 0;
+	struct dw_edma_desc *desc;
+	struct dmaengine_result *res;
+
+	if (!vd->tx.callback_result)
+		return;
+
+	desc = vd2dw_edma_desc(vd);
+	if (desc)
+		residue = desc->alloc_sz - desc->xfer_sz;
+
+	res = &vd->tx_result;
+	res->result = result;
+	res->residue = residue;
+}
+
 static void dw_edma_done_interrupt(struct dw_edma_chan *chan)
 {
 	struct dw_edma_desc *desc;
@@ -597,6 +616,8 @@ static void dw_edma_done_interrupt(struct dw_edma_chan *chan)
 		case EDMA_REQ_NONE:
 			desc = vd2dw_edma_desc(vd);
 			if (!desc->chunks_alloc) {
+				dw_hdma_set_callback_result(vd,
+							    DMA_TRANS_NOERROR);
 				list_del(&vd->node);
 				vchan_cookie_complete(vd);
 			}
@@ -633,6 +654,7 @@ static void dw_edma_abort_interrupt(struct dw_edma_chan *chan)
 	spin_lock_irqsave(&chan->vc.lock, flags);
 	vd = vchan_next_desc(&chan->vc);
 	if (vd) {
+		dw_hdma_set_callback_result(vd, DMA_TRANS_ABORTED);
 		list_del(&vd->node);
 		vchan_cookie_complete(vd);
 	}
-- 
2.51.0


