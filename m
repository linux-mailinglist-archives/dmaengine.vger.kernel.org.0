Return-Path: <dmaengine+bounces-10293-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKJ/MNzgAWptlgEAu9opvQ
	(envelope-from <dmaengine+bounces-10293-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 15:59:56 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 617DE50F847
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 15:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 60FCB301AF40
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 13:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCDA13FE65D;
	Mon, 11 May 2026 13:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="k0XHq3Xb"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2FF3F54AE;
	Mon, 11 May 2026 13:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778507864; cv=none; b=MXGbwfVhXdv5VPi7f8+4nBTR6xgi0KoQksFi7pgBkMScGACFIQv/JChCf0/ScRrO97wZqQBLHxg1T77iamCgO7zPYVv+YWeHrJFTPgEoBLjL2/43rlmCCcNGTm/5wfdnSpA4B3vqpZQN4m0rtxIXlyefHzOSkwVc06zqVu7aSq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778507864; c=relaxed/simple;
	bh=nTE6c7SgBb81H40j2YQ5psWkZ9pWEoiy03RwrEqFWMk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VkEkPb2fWYy0dntlOyRXnAgbA1vDBj8AjNoEbXN9kSAvcycLT/bdb9sKpMvUS7WX5M9ZhH4L11Xnn7uyXl1RjiGVS+Nb/aTRaQZlEmZWH3L0f50R7VM+4Ao8qwBzoB0gIWCApHze0djTM++2IYgPJjVKmZhlfj14WsGtVgxlsCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=k0XHq3Xb; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id F341E1A350A;
	Mon, 11 May 2026 13:57:25 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C7E3960646;
	Mon, 11 May 2026 13:57:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9F95911AF9DE0;
	Mon, 11 May 2026 15:57:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778507845; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=VOT2SXB5ElYlbnnd1oWydGe1sZFq9skpp0x20xRY/3g=;
	b=k0XHq3XbLVKfQjUYA+qzFlQS3KCXdglTG//3tONkKyq6oExAATtHLeCcuGkowoPdvvHc1y
	037poVm91baBlmF3ErJ3Y4rnvFN+hD1rdvpfkiSsh+OeqRCtCWFGvvNow7o1yFLWCdeOAQ
	NHPBVutSS9xx0LxJ7QHYhUS70xE2PU4eYAw19k4ON/wDrCsjlHuzhW9bS5zu3Se3HVv3/w
	0deZp5ztFE9K0g8fBTRCC/11wb4T96MQbqm+48qUY+CUxSnbw18lhKAvwJIZMbm7Tky1mb
	CosRWXl6i9+NALk8ankSJI12cehMUiHzTR8St15h0Ea9fOOryOcO4NdtOO3EIg==
From: =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Subject: [PATCH v3 0/2] dmaengine: fsl-edma: Scatter/gather improvements
Date: Mon, 11 May 2026 15:57:18 +0200
Message-Id: <20260511-fsl-edma-dyn-sg-v3-0-98a181775dae@bootlin.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAD7gAWoC/2XNTQ6CMBCG4auQrq3pn0VceQ/jAtoBaqA1LTYSw
 t1t0cQYl2/yzTMLCuANBHQqFuQhmmCcTcF3BVJ9bTvARqdGjDBJBDviNgwY9FhjPVscOlxJUnI
 KvNQ1Q+nq7qE1z028XN8dHs0N1JSZvOhNmJyft5eR5t1H5+RPjxQTLICAaoDpVspz49w0GLtXb
 kTZj+wrHIj8F1gSpBS8UloLKuBXWNf1Bap1yRIEAQAA
X-Change-ID: 20260428-fsl-edma-dyn-sg-960731e37da2
To: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Frank Li <Frank.Li@kernel.org>, imx@lists.linux.dev, 
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 617DE50F847
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	TAGGED_FROM(0.00)[bounces-10293-lists,dmaengine=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[benoit.monin@bootlin.com,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:email,bootlin.com:email,bootlin.com:mid,bootlin.com:url,bootlin.com:dkim]
X-Rspamd-Action: no action

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
base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
change-id: 20260428-fsl-edma-dyn-sg-960731e37da2

Best regards,
--  
Benoît Monin, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


