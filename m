Return-Path: <dmaengine+bounces-9452-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIQSEDeCuGltfAEAu9opvQ
	(envelope-from <dmaengine+bounces-9452-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 16 Mar 2026 23:20:39 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA362A1668
	for <lists+dmaengine@lfdr.de>; Mon, 16 Mar 2026 23:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6B490304F487
	for <lists+dmaengine@lfdr.de>; Mon, 16 Mar 2026 22:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577C1372B58;
	Mon, 16 Mar 2026 22:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="aL50Bc4G"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1009372B28;
	Mon, 16 Mar 2026 22:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773699588; cv=none; b=lvtif3FkKS0hhSAX2Zg01x2g/4UHB7LjlxRAqE4Ha/onrtSJxRR4I8FjRSQ5YT1Za1t/nZ7G4hcjMHmlibPFQxe3reSt8MSO7vmRAxuuWEw1PFXcmV4J8w+OJ8Df5l4fHmJsB2NEmp3q7riManuY4XiPC+eZDM56YOgM7+aSYlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773699588; c=relaxed/simple;
	bh=OWnQVGt9V3fItGqliY8CZkL4JZtj3I2vnqi3VRaw+qQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F2tOn48Vx1OX8CB3Hnfmlh+ZIeAiVaP1xykF1BJ7HGq0xIf1yJuOiGgZZnyaA3YwvktgZKa0TxsBAJn5a1BUgr5Choo8fkKCPJ6Q0BaA1txhAH7EoS3PNWIuvum/GGhnqVufpZWEwNch6eBJ4KssXOTote/sA67rJhSjTS8e3IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=aL50Bc4G; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C4E7810D3F8;
	Mon, 16 Mar 2026 23:19:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1773699584; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=6thiR54CY8QtVoPqPm+NGB5mFkJooDA5caJGg49p0mE=;
	b=aL50Bc4Gt/6D9g+t/299iADka6rEAQLrLZeyg/UrQc1URI5rzXtLHNaqt+3lS9K8ysyMpQ
	w1myUIjUl1BTBbNaeZPm7i83Ao1sMeagd3UmHyhEa0owg+Mo3ePztDXQ+d5t7kseC0q6o+
	n6WkhuQMK8URqzdqrpKLIQUiOWYntbQKCnyllBIrBfmbM8xMjPnHqhI+MF+dJlRQhQkyOD
	W6Ib3Q7kN0GIRAMAMh68Tc67T6orAJJgp/1/tZ2jVNYtGOnj8TwYpPOl0XoQD8K8w/6I6E
	ILifXcvCeyOc2O8btZ6nv1IWgmWCB5q38r33/kRT2VFbmLQCWDq0LeCbhA9O5g==
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
Subject: [PATCH] dmaengine: xilinx: xilinx_dma: Fix residue calculation for cyclic DMA
Date: Mon, 16 Mar 2026 23:18:57 +0100
Message-ID: <20260316221943.160375-1-marex@nabladev.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[nabladev.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9452-lists,dmaengine=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
X-Rspamd-Queue-Id: ADA362A1668
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The cyclic DMA calculation is currently entirely broken and reports
residue only for the first segment. The problem is twofold.

First, when the first descriptor finishes, it is moved from active_list
to done_list, but it is never returned back into the active_list. The
xilinx_dma_tx_status() expects the descriptor to be in the active_list
to report any meaningful residue information, which never happens after
the first descriptor finishes. Fix this up in xilinx_dma_start_transfer()
and if the descriptor is cyclic, lift it from done_list and place it back
into active_list list.

Second, the segment .status fields of the descriptor remain dirty. Once
the DMA did one pass on the descriptor, the .status fields are populated
with data by the DMA, but the .status fields are not cleared before reuse
during the next cyclic DMA round. The xilinx_dma_get_residue() recognizes
that as if the descriptor was complete and had 0 residue, which is bogus.
Reinitialize the status field before placing the descriptor back into the
active_list.

Fixes: c0bba3a99f07 ("dmaengine: vdma: Add Support for Xilinx AXI Direct Memory Access Engine")
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
 drivers/dma/xilinx/xilinx_dma.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 6b0927e3d684b..6e8e348973a9e 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -1564,8 +1564,29 @@ static void xilinx_dma_start_transfer(struct xilinx_dma_chan *chan)
 	if (chan->err)
 		return;
 
-	if (list_empty(&chan->pending_list))
+	if (list_empty(&chan->pending_list)) {
+		if (chan->cyclic) {
+			struct xilinx_dma_tx_descriptor *desc;
+			struct list_head *entry;
+
+			desc = list_last_entry(&chan->done_list,
+					       struct xilinx_dma_tx_descriptor, node);
+			list_for_each(entry, &desc->segments) {
+				struct xilinx_axidma_tx_segment *axidma_seg;
+				struct xilinx_axidma_desc_hw *axidma_hw;
+				axidma_seg = list_entry(entry,
+							struct xilinx_axidma_tx_segment,
+							node);
+				axidma_hw = &axidma_seg->hw;
+				axidma_hw->status = 0;
+			}
+
+			list_splice_tail_init(&chan->done_list, &chan->active_list);
+			chan->desc_pendingcount = 0;
+			chan->idle = false;
+		}
 		return;
+	}
 
 	if (!chan->idle)
 		return;
-- 
2.51.0


