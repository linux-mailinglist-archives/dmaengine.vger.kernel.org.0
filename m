Return-Path: <dmaengine+bounces-9453-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DK+L56DuGltfAEAu9opvQ
	(envelope-from <dmaengine+bounces-9453-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 16 Mar 2026 23:26:38 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 268352A1714
	for <lists+dmaengine@lfdr.de>; Mon, 16 Mar 2026 23:26:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08DAD301AD03
	for <lists+dmaengine@lfdr.de>; Mon, 16 Mar 2026 22:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C191371D01;
	Mon, 16 Mar 2026 22:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="OD5qwL8v"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD88932B989;
	Mon, 16 Mar 2026 22:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773699936; cv=none; b=qr9ihrfBBUd0Rc8oJPLS3W5m0sDD8yq5+DlpuTVtW+2jt1gSh6JmX/mLeLDuuKMtH/dKRGotpRZNNxfrDCY9aEBA3XxrUwTwCm0c9dAEOj+KDpyXOyf3h5Q9CVi+RDtWtGOB+tHz2N2h2CmRDoKi4Umf4oWpcQvzyFgDMDtbvhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773699936; c=relaxed/simple;
	bh=cPNvEvxHxameKKNzF8eiKWQjW9PXSmlz8namd2mC1TQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MYyVaPdOiIRESS6IA6RGLhuATOH4XDPPHYvMSkG1TTgmsCdWZ5q8F5ezltwe4ZKNcVsEs1nMEyvbwoJDAA6iuu6o8vva2Q30vRmfmihsWvxkKdTqeZNjOb4jroiHzblgV/78uFKOESp1ae1aOVz8q9PiNXy9Vwn8lpAJqJk0YBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=OD5qwL8v; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1B30110B833;
	Mon, 16 Mar 2026 23:25:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1773699932; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=yesz3TLnlVcpzCTRtmZKcz16YVTRA/sjUd1tdRoIf5k=;
	b=OD5qwL8vL4+FKjs+8oJ/v/K668ZcXnGbLdVGAvQOgeD6r4R4pncUXU6CY9lEtVG7RboCsw
	4/k2Vyh1SrCzYLbjfffTk7Hjx4j3vLFZ2visF3HuwL2p/pM5JSK45+4Gc2LvmJ8aPOwzG4
	ZqDMAZTHptjw0h6uB4iC2uJFbX5Foj3hQbBCIkKQfdDJ6Meez/jrFPaCRshE2yfdiql1/9
	okgNhFQGYl2rID/PKdLvfd7GFIkBLSlpHEPkCf4NzEMN4TWeJ0QNTJJkGg7lC9MdAR1zpp
	Xlm6iSDClHYM1XgOgLwrn6n5F+KdMFUzE5+HlGUgzek6c+te2xVh/tFMmpGhqQ==
From: Marek Vasut <marex@nabladev.com>
To: dmaengine@vger.kernel.org
Cc: Marek Vasut <marex@nabladev.com>,
	Michal Simek <michal.simek@amd.com>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Rahul Navale <rahul.navale@ifm.com>,
	Sasha Levin <sashal@kernel.org>,
	Suraj Gupta <suraj.gupta2@amd.com>,
	Thomas Gessler <thomas.gessler@brueckmann-gmbh.de>,
	Vinod Koul <vkoul@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: xilinx: xilinx_dma: Fix unmasked residue subtraction
Date: Mon, 16 Mar 2026 23:25:24 +0100
Message-ID: <20260316222530.163815-1-marex@nabladev.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nabladev.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nabladev.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9453-lists,dmaengine=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marex@nabladev.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nabladev.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 268352A1714
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The segment .control and .status fields both contain top bits which are
not part of the buffer size, the buffer size is located only in the bottom
max_buffer_len bits. To avoid interference from those top bits, mask out
the size using max_buffer_len first, and only then subtract the values.

Fixes: a575d0b4e663 ("dmaengine: xilinx_dma: Introduce xilinx_dma_get_residue")
Signed-off-by: Marek Vasut <marex@nabladev.com>
---
Cc: Michal Simek <michal.simek@amd.com>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc: Rahul Navale <rahul.navale@ifm.com>
Cc: Sasha Levin <sashal@kernel.org>
Cc: Suraj Gupta <suraj.gupta2@amd.com>
Cc: Thomas Gessler <thomas.gessler@brueckmann-gmbh.de>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/dma/xilinx/xilinx_dma.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 6e8e348973a9e..4f88ba92bd2d8 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -997,16 +997,16 @@ static u32 xilinx_dma_get_residue(struct xilinx_dma_chan *chan,
 					      struct xilinx_cdma_tx_segment,
 					      node);
 			cdma_hw = &cdma_seg->hw;
-			residue += (cdma_hw->control - cdma_hw->status) &
-				   chan->xdev->max_buffer_len;
+			residue += (cdma_hw->control & chan->xdev->max_buffer_len) -
+			           (cdma_hw->status & chan->xdev->max_buffer_len);
 		} else if (chan->xdev->dma_config->dmatype ==
 			   XDMA_TYPE_AXIDMA) {
 			axidma_seg = list_entry(entry,
 						struct xilinx_axidma_tx_segment,
 						node);
 			axidma_hw = &axidma_seg->hw;
-			residue += (axidma_hw->control - axidma_hw->status) &
-				   chan->xdev->max_buffer_len;
+			residue += (axidma_hw->control & chan->xdev->max_buffer_len) -
+			           (axidma_hw->status & chan->xdev->max_buffer_len);
 		} else {
 			aximcdma_seg =
 				list_entry(entry,
@@ -1014,8 +1014,8 @@ static u32 xilinx_dma_get_residue(struct xilinx_dma_chan *chan,
 					   node);
 			aximcdma_hw = &aximcdma_seg->hw;
 			residue +=
-				(aximcdma_hw->control - aximcdma_hw->status) &
-				chan->xdev->max_buffer_len;
+				(aximcdma_hw->control & chan->xdev->max_buffer_len) -
+				(aximcdma_hw->status & chan->xdev->max_buffer_len);
 		}
 	}
 
-- 
2.51.0


