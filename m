Return-Path: <dmaengine+bounces-12314-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BjlMFnTgUGri6gIAu9opvQ
	(envelope-from <dmaengine+bounces-12314-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 14:07:16 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4467173A848
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 14:07:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=y0YjSnLK;
	dmarc=pass (policy=reject) header.from=bootlin.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12314-lists+dmaengine=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="dmaengine+bounces-12314-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5011D3001A52
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 12:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B203C4B9A;
	Fri, 10 Jul 2026 12:07:09 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E507B3C9892
	for <dmaengine@vger.kernel.org>; Fri, 10 Jul 2026 12:07:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783685229; cv=none; b=WV7t3WAvmtQOoLj73zOgFjHGfODIh4L0oKa6vlLQ0tQvmq4yAofnwpOOBJ/4c9VpSIw069/97M2+QoJ2LBAhXyB26SYiCRBgKp03MePqj0nQ/eSJP8jIYx+SoMErOpIZkLvEGANpffvyNvYB5ErkhfLeSnmeH23x3eXavU+Zfjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783685229; c=relaxed/simple;
	bh=jKnXIpvL88HqV9czvsBpE4syZ9onPnIFVuryxMVD3Lo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bqH8Z345yAGYxO5yJ7P7pRbtTG6yU95TWoL2gQWf9qcS1h+NIwHndMo9BFpKuuiJWXO3V/Urks7X3OtXrcm7h8Uxri8XYnglIvCHLjoOe198X+BIr3tLOYIbffjfTDZgAY9QSsVXkJ2X5yVn2ODZ7X66U1yf9WcG8rX3HhOY5pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=y0YjSnLK; arc=none smtp.client-ip=185.171.202.116
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 18AE4C2C641;
	Fri, 10 Jul 2026 12:07:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 386C860342;
	Fri, 10 Jul 2026 12:07:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 88E9E11BD0BCF;
	Fri, 10 Jul 2026 14:07:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783685224; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=qoGea9P2hn5GwEWx560Wpe+wG3lWyCKZN5FcLlZbMSI=;
	b=y0YjSnLK20uxdsS79Vp2+60KkDnhvA2wg/Wdwokgrwcx8uNGzQqRunLPmAmXytkH8bmaIi
	EcqZlEpdjhT3yrOcckSqYcBoSIYGUvE++p6uZ11Yq07v6UUHXkwWx8mLyu6hxmrRHUG44f
	mEVTpuhyf+dPUES4Z+lS9p7vOwjs9rZz8Gddhl7MqAsB3XwmX1XHSpsE2dRJ/y4KXb134s
	BXViYOJdhhu6Jok9rF2RHdHvAYm6IqMvRxLd50B0aDMgP57l9T2Pn7WkFAooNh9O1IO8bk
	FRt0/iGmfLGP8y+UTN51qvQRJpQs/5a9lP719bD2RVRz1lI6qepM7Fdj/3sngQ==
From: =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Subject: [PATCH v6 0/2] dmaengine: fsl-edma: Scatter/gather improvements
Date: Fri, 10 Jul 2026 14:06:59 +0200
Message-Id: <20260710-fsl-edma-dyn-sg-v6-0-831b96be3f31@bootlin.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAGPgUGoC/23Qy2rDMBAF0F8JWldFo7ez6n+ULvQYJyqJVSxXN
 AT/e+W0kFB1eeHOuTBXUnBOWMh+dyUz1lRSnlrQTzsSjm46IE2xZcIZ10xyS8dyohjPjsbLRMu
 BDpoZAShMdJy0q48Zx/R1E1/ffnL59O8Ylo3ZGsdUljxfbpMVtt6vLlinV6CMSmQYPPI4av3ic
 15OaXoO+Uw2v/K7oJjuBd4EraUYQowSJPaCeBAAekE0YbAOLBijovtHkI9C/6Mqm2ADmjgoDwG
 HXlB3wTDeC6oJoI01YJVH+UdY1/UbocEbE8oBAAA=
X-Change-ID: 20260428-fsl-edma-dyn-sg-960731e37da2
To: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Frank Li <Frank.Li@kernel.org>, imx@lists.linux.dev, 
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12314-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:Frank.Li@nxp.com,m:vkoul@kernel.org,m:thomas.petazzoni@bootlin.com,m:Frank.Li@kernel.org,m:imx@lists.linux.dev,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:benoit.monin@bootlin.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[benoit.monin@bootlin.com,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[benoit.monin@bootlin.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4467173A848

This series adds support for scatter/gather DMA transfers via dma_vec
and dynamic descriptor chaining to the Freescale eDMA controller driver.

The first patch implements the .device_prep_peripheral_dma_vec() callback,
enabling the DMA engine to accept an array of dma_vec structures. This
callback supports both regular and cyclic transfer modes.

The second patch introduces dynamic scatter/gather chaining, which allows
multiple DMA descriptors to be linked together without stopping the channel.
This optimization eliminates idle periods when back-to-back transfers are
submitted, improving throughput and reducing latency. The implementation
carefully preserves cyclic transfer semantics and respects hardware
constraints on platforms with split register layouts.

I tested it on the i.MX93. The dynamic scatter/gather chaining should
work with other eDMA controller with split register layout.

Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
---
Changes in v6:
- Link DMA transactions in fsl_edma_issue_pending() when they are issued,
  not when submitted.
- Add an identifier to linked transactions to handle missed/coalesced
  end-of-transfer interrupt.
- Link to v5: https://patch.msgid.link/20260702-fsl-edma-dyn-sg-v5-0-16787185be49@bootlin.com

Changes in v5:
- Rebased on v7.2-rc1.
- Add a call to dma_wmb() to ensure that dlast_sga is updated
  before csr when linking scatter/gather transactions.
- Don't update TCD registers if updating csr requires clearing the
  channel DONE bit to avoid a status mismatch in fsl_edma_tx_chan_handler().
- Link to v4: https://patch.msgid.link/20260518-fsl-edma-dyn-sg-v4-0-8ce7d95b1ce9@bootlin.com

Changes in v4:
- To keep transactions in order, link DMA transaction to the end of
  submitted list first, only lookup the issued list is the submitted
  list is empty.
- Link to v3: https://patch.msgid.link/20260511-fsl-edma-dyn-sg-v3-0-98a181775dae@bootlin.com

Changes in v3:
- Fix formatting errors reported by Frank Li.
- Add fsl_edma_tx_submit() to link the DMA transactions
  when they are submitted, not when they are prepared.
- Link to v2: https://patch.msgid.link/20260506-fsl-edma-dyn-sg-v2-0-66439cdd414e@bootlin.com

Changes in v2:
- Drop the RFC prefix, as asked by Frank Li
- No code change
- Link to v1: https://patch.msgid.link/20260430-fsl-edma-dyn-sg-v1-0-4e0ecbe2df66@bootlin.com

To: Frank Li <Frank.Li@nxp.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: Frank Li <Frank.Li@kernel.org>
Cc: imx@lists.linux.dev
Cc: dmaengine@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Benoît Monin (2):
      dmaengine: fsl-edma: Implement device_prep_peripheral_dma_vec
      dmaengine: fsl-edma: Support dynamic scatter/gather chaining

 drivers/dma/fsl-edma-common.c | 207 ++++++++++++++++++++++++++++++++++++++++--
 drivers/dma/fsl-edma-common.h |   7 ++
 drivers/dma/fsl-edma-main.c   |   2 +
 drivers/dma/fsl-edma-trace.h  |   5 +
 4 files changed, 215 insertions(+), 6 deletions(-)
---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260428-fsl-edma-dyn-sg-960731e37da2

Best regards,
--  
Benoît Monin, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


