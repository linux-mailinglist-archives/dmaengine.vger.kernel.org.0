Return-Path: <dmaengine+bounces-10231-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yO1sDylO+2nWYwMAu9opvQ
	(envelope-from <dmaengine+bounces-10231-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 06 May 2026 16:20:25 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7344E4DC023
	for <lists+dmaengine@lfdr.de>; Wed, 06 May 2026 16:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E206307FDF7
	for <lists+dmaengine@lfdr.de>; Wed,  6 May 2026 14:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9301B23D7FF;
	Wed,  6 May 2026 14:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="q91Mrhlp"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DC947F2E4
	for <dmaengine@vger.kernel.org>; Wed,  6 May 2026 14:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778076650; cv=none; b=M2foQKf9vJiOdadmPUyM8wksN2Dq4IF7vkehz60Jq6ZgEWHpAhWYkKDzba0a98DoSS90JX+KsiU+POrDiTRpeQXGG/Mucj2mc9WT9QetSMOSOT7aGi3jrCNXkkLiW9gia2QIleSVmqULPPnzGd0dRL67lRN+PRIZ7OCTJvP2ukw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778076650; c=relaxed/simple;
	bh=vrUfaSELMjHL3+C78icXSJHLZY5KNMzxnFjfsHwkDys=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WipM7f+2TGBTOECZqxeWVx0wDuVpDAB6EwGJwlERnzGIzlpN26/KluJzmLc7hrAZ2e9UpQDrbPuN6x5oSGKEpJApwqBH+IkQtGJQcKUGgi/1E1doUlhU+Eo/ALg9uhXyET2/Hmo8WIALwx60QaJkU4HHQkareun14PcvtrzUPzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=q91Mrhlp; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 1A6E11A3540;
	Wed,  6 May 2026 14:10:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E3A906053C;
	Wed,  6 May 2026 14:10:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 17039107F1BA9;
	Wed,  6 May 2026 16:10:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778076646; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=rk3cCHOlkMoL0jIGFneb33B9G59/J16GywOMjhdoQf4=;
	b=q91MrhlpLNuSje1uU/7YC3n6zsX7UG8XvZoXcoT9wC3Q0N2E50ZWX4wzu0h2ZKmpj51k3a
	cu9hoO9hc/QZT5cYgBTTIa9j/psrS1YrWY4CiZjuXxGlzxFURgCf/lkG+Z43IKogW950qD
	ToW5FFrBZfMEiPsgvJkSkZ2L/wUoIafp4eAMeLs3K3UPlNTyCGOBQB2Wp6AkUkiIXMqsZ9
	nldpSuEV4tG0EOeHucpVXMKwSJknPBhXVBY3QcDD55YfpWUvwriazJHygLD62JSAy/HStD
	kdaxUMCiAIx4MmH1ouTqcQo7R+SyrToXu7vfNAy2E3i6PSPitTjzzwr3QmHGFw==
From: =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Subject: [PATCH v2 0/2] dmaengine: fsl-edma: Scatter/gather improvements
Date: Wed, 06 May 2026 16:10:34 +0200
Message-Id: <20260506-fsl-edma-dyn-sg-v2-0-66439cdd414e@bootlin.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIANpL+2kC/2WNQQ6CMBBFr0Jm7ZhSSFFX3sOwgHaAMdiaDhIJ4
 e4CunP5kvffn0EoMglckhkijSwc/Ar6kIDtKt8SslsZtNJG5fqEjfRI7lGhmzxKi2ejiiylrHC
 VhnX1jNTwey/eyi/Lq76THbbMZnQsQ4jTfjmmm/erZ+qvPqaoMCdFtibtGmOudQhDz/5owwPKZ
 Vk+L7IsmMIAAAA=
X-Change-ID: 20260428-fsl-edma-dyn-sg-960731e37da2
To: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Frank Li <Frank.Li@kernel.org>, imx@lists.linux.dev, 
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 7344E4DC023
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	TAGGED_FROM(0.00)[bounces-10231-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[benoit.monin@bootlin.com,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:mid,bootlin.com:email,bootlin.com:dkim,bootlin.com:url,msgid.link:url]

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
Changes in v2:
- Drop the RFC prefix, as asked by Frank Li
- No code change
- Link to v1: https://patch.msgid.link/20260430-fsl-edma-dyn-sg-v1-0-4e0ecbe2df66@bootlin.com

---
Benoît Monin (2):
      dmaengine: fsl-edma: Implement device_prep_peripheral_dma_vec
      dmaengine: fsl-edma: Support dynamic scatter/gather chaining

 drivers/dma/fsl-edma-common.c | 174 +++++++++++++++++++++++++++++++++++++++++-
 drivers/dma/fsl-edma-common.h |   4 +
 drivers/dma/fsl-edma-main.c   |   2 +
 drivers/dma/fsl-edma-trace.h  |   5 ++
 4 files changed, 181 insertions(+), 4 deletions(-)
---
base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
change-id: 20260428-fsl-edma-dyn-sg-960731e37da2

Best regards,
--  
Benoît Monin, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


