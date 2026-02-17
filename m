Return-Path: <dmaengine+bounces-8933-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +awmOCW6lGmKHQIAu9opvQ
	(envelope-from <dmaengine+bounces-8933-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 17 Feb 2026 19:57:41 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F9A14F68F
	for <lists+dmaengine@lfdr.de>; Tue, 17 Feb 2026 19:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ABCE53004D3A
	for <lists+dmaengine@lfdr.de>; Tue, 17 Feb 2026 18:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D7CD374190;
	Tue, 17 Feb 2026 18:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=folker-schwesinger.de header.i=@folker-schwesinger.de header.b="JRfLUWQa"
X-Original-To: dmaengine@vger.kernel.org
Received: from www522.your-server.de (www522.your-server.de [195.201.215.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DC729B8E8;
	Tue, 17 Feb 2026 18:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.215.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771354656; cv=none; b=tlEIGZXC72alM5hnmztawpJye/jULOtgZeloRiqsWVcFeA5eHkWDa5pvRsLqYS/t35Mc5yIw1LejhIMPgAD6GnAaabEJKE0vBlTL6NOxyrE0AYJVkfY3Dr46dQ6bGlcuo7ohoEOhGqdkArKAhkSrJCDujNSK7TZSaABeC4f2uiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771354656; c=relaxed/simple;
	bh=imlzH067F4JDsj1zdbiGbMYee36NYYzqjex56bk8Qew=;
	h=Message-Id:Cc:To:From:Date:Subject; b=nugXIxmMU3re8eZJ1CBZkhUrLZyZT8L+lz9joajpYeyXjTQxgYLrw6E49xhUe3QJBnNjWQxNRNPS0JGvTtgiFzqL2AK5R+xN2ACFRI5UvcHXIcgQToGlvnTMETf+LdnfNLzVeuAqdCq2jYId8yXS/6AQP8KgdjE+R/GZ5bi1rcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=folker-schwesinger.de; spf=pass smtp.mailfrom=folker-schwesinger.de; dkim=pass (2048-bit key) header.d=folker-schwesinger.de header.i=@folker-schwesinger.de header.b=JRfLUWQa; arc=none smtp.client-ip=195.201.215.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=folker-schwesinger.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=folker-schwesinger.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=folker-schwesinger.de; s=default2212; h=Subject:Date:From:To:Cc:Message-Id:
	Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References;
	bh=3XPu6FDZWTL9k9evNBDfynBLXPebQkKUMud/CTiGXZg=; b=JRfLUWQaY0vZHtfEND2YNrWnM8
	RsbuEPXFiphPcsv0LWCSVj87pq7/QJA2OAWom92TMdhyGzceM0hZBeIyxYf/6aF5krduSxa/hYMrf
	WJP1kLRapoRzkamvmVnALASUfHRkSjQhzrfaIKcHe9QHlVqJhny1KCSaJAzj0PlBPxvfmsO2mnYdD
	ziAvN9VAzCBpmmevxAp2El5GQrytN/OtI4SSZGrahhQ8U1z7fMLef0wSQx1SbcuDTm2TAmAyyxtUI
	y7kn32mave0+nWSanEeSsYQnYn75/wYB+romOM9N5UBrq1CryI1/ixbFXhMGBDs7lAfB+0xRxz/ps
	dt8pcHGw==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www522.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <dev@folker-schwesinger.de>)
	id 1vsQGA-0001lc-2z;
	Tue, 17 Feb 2026 19:57:22 +0100
Received: from localhost ([127.0.0.1])
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <dev@folker-schwesinger.de>)
	id 1vsQGA-0006Eh-0B;
	Tue, 17 Feb 2026 19:57:22 +0100
Message-Id: <DGHGTCJRRZCW.9TGXQW44V6RR@folker-schwesinger.de>
Cc: "Vinod Koul" <vkoul@kernel.org>, "Frank Li" <Frank.Li@kernel.org>,
 "Michal Simek" <michal.simek@amd.com>, "Suraj Gupta"
 <suraj.gupta2@amd.com>, "Thomas Gessler"
 <thomas.gessler@brueckmann-gmbh.de>, "Radhey Shyam Pandey"
 <radhey.shyam.pandey@amd.com>, "Tomi Valkeinen"
 <tomi.valkeinen@ideasonboard.com>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, "Rahul Navale" <rahulnavale04@gmail.com>
To: <dmaengine@vger.kernel.org>
From: "Folker Schwesinger" <dev@folker-schwesinger.de>
Date: Tue, 17 Feb 2026 19:49:13 +0100
Subject: [RFC PATCH] dmaengine: xilinx_dma: Fix per-channel direction
 reporting via device_caps
X-Virus-Scanned: Clear (ClamAV 1.4.3/27915/Tue Feb 17 08:24:54 2026)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[folker-schwesinger.de,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[folker-schwesinger.de:s=default2212];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8933-lists,dmaengine=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,amd.com,brueckmann-gmbh.de,ideasonboard.com,lists.infradead.org,vger.kernel.org,gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[folker-schwesinger.de:+];
	MISSING_XM_UA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dev@folker-schwesinger.de,dmaengine@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 11F9A14F68F
X-Rspamd-Action: no action

Since commit 7e01511443c3 ("dmaengine: xilinx_dma: Set dma_device
directions") all channel directions are aggregated into
dma_device.directions so that dma_get_slave_caps() works for IIO
DMAEngine buffers.

However, this caused a regression in ASoC audio on ZynqMP platforms,
that causes cyclic playback to fail after the first buffer period,
because ASoC dmaengine PCM expects fixed per-channel direction reporting
from dma_get_slave_caps().

Implement optional device_caps() callback and override caps->directions
with the channel's fixed direction. This keeps device-wide direction
reporting for IIO intact while restoring correct per-channel semantics
for ASoC.
Other dma_slave_caps fields are left unchanged from their respective
values initialized from dma_get_slave_caps(). In case there should ever
be the need to override other fields, these can be added later.

Fixes: 7e01511443c3 ("dmaengine: xilinx_dma: Set dma_device directions")
Cc: stable@vger.kernel.org
Reported-by: Rahul Navale <rahul.navale@ifm.com>
Closes: https://lore.kernel.org/dmaengine/20260211140051.8177-1-rahulnavale04@gmail.com/T/#u
Closes: https://lore.kernel.org/dmaengine/CY1PR12MB96978AEBD6072FC469DFEAF1B762A@CY1PR12MB9697.namprd12.prod.outlook.com/T/#u
Signed-off-by: Folker Schwesinger <dev@folker-schwesinger.de>

---
Posting this as RFC because I can't verify this actually fixes the
regression as I don't have a ZynqMP. So Rahul, could you test if this
fixes the issue and report back? BR F.
---
 drivers/dma/xilinx/xilinx_dma.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 64b3fba4e44f..bdd16173d762 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -1711,6 +1711,19 @@ static void xilinx_dma_issue_pending(struct dma_chan *dchan)
 	spin_unlock_irqrestore(&chan->lock, flags);
 }
 
+/**
+ * xilinx_dma_device_caps - Write channel-specific DMA slave capabilities
+ * @dchan: DMA channel
+ * @caps: DMA slave capabilities of DMA channel
+ */
+static void xilinx_dma_device_caps(struct dma_chan *dchan,
+				   struct dma_slave_caps *caps)
+{
+	struct xilinx_dma_chan *chan = to_xilinx_chan(dchan);
+
+	caps->directions = chan->direction;
+}
+
 /**
  * xilinx_dma_device_config - Configure the DMA channel
  * @dchan: DMA channel
@@ -3292,6 +3305,7 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 	xdev->common.device_tx_status = xilinx_dma_tx_status;
 	xdev->common.device_issue_pending = xilinx_dma_issue_pending;
 	xdev->common.device_config = xilinx_dma_device_config;
+	xdev->common.device_caps = xilinx_dma_device_caps;
 	if (xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA) {
 		dma_cap_set(DMA_CYCLIC, xdev->common.cap_mask);
 		xdev->common.device_prep_peripheral_dma_vec = xilinx_dma_prep_peripheral_dma_vec;

base-commit: ab736ed52e3409b58a4888715e4425b6e8ac444f
-- 
2.53.0

