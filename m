Return-Path: <dmaengine+bounces-11962-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id y8erEA9eRmqERwsAu9opvQ
	(envelope-from <dmaengine+bounces-11962-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 14:48:15 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 372A86F7DEA
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 14:48:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=qTNwRlFm;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11962-lists+dmaengine=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="dmaengine+bounces-11962-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2A08830086BA
	for <lists+dmaengine@lfdr.de>; Thu,  2 Jul 2026 12:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2055647F2E8;
	Thu,  2 Jul 2026 12:34:38 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D24478E3A;
	Thu,  2 Jul 2026 12:34:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782995678; cv=none; b=a17ZfLbRYAQOF2747QLyz63TqzsItaXGAjQLfLtopQbVlu86/e6DoBq6YOUrh+UQNTobHVpR0I35s2v0qxcxwTHwiYnjGLCmLajkYWEZfQWzjA6uyVovpbN9aFjY7rUi2iNFN8BR5lwwOYEFCAtK+PcqOGgW6i2sUsa0LZzdAuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782995678; c=relaxed/simple;
	bh=IrZoI8l6PHELBrFIdQHIKoYJz2yoNzWMOxsvBGnZMi4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=g2rv1uyTarrlqOk9LUD1/QMb05MQjLUXAJc2qPTxpz+Y6+orEF/XW4jILisfh0AQzSOziOjpyK04D7SGcfB3QX0lGkDSeEguHM5cARRERXm8Q4RD6i9Zn53VtEiJS7aWJh3wQj1Sib4bbr55h1y7ZpMsS+CX7Xu+oZ6YCR4W+QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=qTNwRlFm; arc=none smtp.client-ip=185.246.84.56
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 5CC511A0DEB;
	Thu,  2 Jul 2026 12:34:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 318D45FF03;
	Thu,  2 Jul 2026 12:34:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 29009104C954F;
	Thu,  2 Jul 2026 14:34:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782995673; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=teUl6Jtux4B81cS2GHb5PuK8CaN/Gdn/KAMjiXmi1/0=;
	b=qTNwRlFmGh3W3zsgCI/6bClyEDkChdUh2RQoWx5ks4EYTUAhvzYRI5ifJcwKB8QLb981Hr
	nf4Xvfo3c1M6iD3aEDrFlERgwf0N3f53kji0vJ+FwnJPq1YPetzOYZ3VWC7+C3JFLZmrAA
	MgZkOdWzTBRHRZQHUAYlgB/QaxCBvvQV04bbssjVT4TrWohkauhWMfacL2gqmzS1PdyDwT
	okjiwrzoqs6D2ZvQHStzxavmVvNh5mKm7dkJjqPxMZt7+9IW5gcdn8BS5MT03UoSPm6uNQ
	pwNkFm6KvbLsQU4pwe9MK9TR/xxm3n4x4OpkOCvqL/kAE3hrYHV3Fqz3FtSdaA==
From: =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Subject: [PATCH v5 0/2] dmaengine: fsl-edma: Scatter/gather improvements
Date: Thu, 02 Jul 2026 14:34:23 +0200
Message-Id: <20260702-fsl-edma-dyn-sg-v5-0-16787185be49@bootlin.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAM9aRmoC/23QQW7DIBAF0KtErEvFAAbTVe9RZYGZcUKVmMo4q
 FHkuxenlZqKLr/0531pbizTHCmzl92NzVRijmmqoXvasXD004F4xJqZFNIILXs+5hMnPHuO14n
 nA3dGWAWkLHrJ6tXHTGP8vItv+++cL8M7hWVjtsYx5iXN1/tkga33oyvR6AW44JoEhYEkjsa8D
 iktpzg9h3Rmm1/kr9AJ0wqyCsZo5QKiBk2toB4EgFZQVXC9hx6s7dD/I+hHof1R0VXoA1l03QC
 B3F9hXdcvkhg/rIgBAAA=
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
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-11962-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FORGED_SENDER(0.00)[benoit.monin@bootlin.com,dmaengine@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:Frank.Li@nxp.com,m:vkoul@kernel.org,m:thomas.petazzoni@bootlin.com,m:Frank.Li@kernel.org,m:imx@lists.linux.dev,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:benoit.monin@bootlin.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[benoit.monin@bootlin.com,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RWL_MAILSPIKE_POSSIBLE(0.00)[104.64.211.4:from];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,bootlin.com:url,bootlin.com:from_mime,bootlin.com:dkim,bootlin.com:email,bootlin.com:mid,nxp.com:email,msgid.link:url,vger.kernel.org:from_smtp,linux.dev:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 372A86F7DEA

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

 drivers/dma/fsl-edma-common.c | 197 ++++++++++++++++++++++++++++++++++++++++--
 drivers/dma/fsl-edma-common.h |   4 +
 drivers/dma/fsl-edma-main.c   |   2 +
 drivers/dma/fsl-edma-trace.h  |   5 ++
 4 files changed, 202 insertions(+), 6 deletions(-)
---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260428-fsl-edma-dyn-sg-960731e37da2

Best regards,
--  
Benoît Monin, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


