Return-Path: <dmaengine+bounces-9258-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KQKAuynqGlOwQAAu9opvQ
	(envelope-from <dmaengine+bounces-9258-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 04 Mar 2026 22:45:16 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 07FE7208296
	for <lists+dmaengine@lfdr.de>; Wed, 04 Mar 2026 22:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BA365302EE1D
	for <lists+dmaengine@lfdr.de>; Wed,  4 Mar 2026 21:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EAEF3CE49F;
	Wed,  4 Mar 2026 21:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="aJGCIN/g"
X-Original-To: dmaengine@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA563822BD;
	Wed,  4 Mar 2026 21:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772660690; cv=none; b=kzHOL6XHrTNgw3hJ3sfNE9PnVS4bGTu/dbEO6xn/DcTvD3tgMrsPDWCTGD72HVS0+GvPecIEtX0dVuweDQCDKUorPF7Y3C58N8Zm+Ty0yZjpczMAcsT3VR+1jSsvJkwvSAo4dhscW6NwERB+R4zyLqfqD5CNunRX98GXMvlceJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772660690; c=relaxed/simple;
	bh=Ud4dXcaRBf76pDPCIF8536beflPS3zVAq4vQbGr7SMs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LQWxX8rqctE4zf4gg25Qc0DLGeOFg9alIF6uqo1F6RiAD6HGomBgQot0vrq7BchmEmq22FaJhSnoHu2MDL1Hl2xeB+fNWmlNmWKPcJia89c1NegFBmR5vCXp9JXvgGi5w2ZdadFLO3Md2FXUpAVuSl7vwPTPJD478VadJrvhetk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=aJGCIN/g; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1772660680;
	bh=Ud4dXcaRBf76pDPCIF8536beflPS3zVAq4vQbGr7SMs=;
	h=From:Subject:Date:To:Cc:From;
	b=aJGCIN/g4ryvnmt7aSXUlW2zELXISFqbtYY59PGXRUPDybpqAP5hfg2z9cxs2fLKM
	 RUkVsh0bLzkEvNvtlbxiAIEYSPMqEJP2/wwezkcf0tpfDBsA1eb4rmhB0h4PDLBV0w
	 nQPVD7ifYBFSYKqJ8PoBgDFphsGLWubUh3X9MPac=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v2 0/4] dmaengine: ioatdma: some sysfs cleanups and
 constifications
Date: Wed, 04 Mar 2026 22:44:36 +0100
Message-Id: <20260304-sysfs-const-ioat-v2-0-b9b82651219b@weissschuh.net>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NQQ7CMAwEv1L5jFHiQgSc+AfqoQ0u8SVBcShUV
 f9O6AM4zkg7u4ByFla4NAtknkQlxQq0a8CHPj4Y5V4ZyJAzrSHUWUdFn6IWlNQXNOzc0R7sQG6
 AOntmHuWzJW9d5SBaUp63h8n+7J/YZNGgJTozW39qx/b6ZlFVH15hH7lAt67rFwzYiYG1AAAA
X-Change-ID: 20260302-sysfs-const-ioat-0e665141b26b
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dave Jiang <dave.jiang@intel.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772660679; l=926;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=Ud4dXcaRBf76pDPCIF8536beflPS3zVAq4vQbGr7SMs=;
 b=cmiKWpDPsPGAj09x4Vri4oUraQ4OSiMpA/BQruox0KdI0Bkm6OcZYGi8Gt1wc4NkUg/Id33Q9
 Cv5HuqbQLufB23ex7sMvbr55QQeenSmgFQs3kqJPcCe2+2bfg3Emkzd
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Rspamd-Queue-Id: 07FE7208296
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[weissschuh.net,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[weissschuh.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9258-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[weissschuh.net:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@weissschuh.net,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

Reduce the visibility of some symbols and make some structures readonly.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Changes in v2:
- Pick up tags.
- Rewrite commit messages as requested by Frank.
- Link to v1: https://patch.msgid.link/20260302-sysfs-const-ioat-v1-0-1229ee1c83f3@weissschuh.net

---
Thomas Weißschuh (4):
      dmaengine: ioatdma: make some sysfs structures static
      dmaengine: ioatdma: move sysfs entry definition out of header
      dmaengine: ioatdma: make ioat_ktype const
      dmaengine: ioatdma: make sysfs attributes const

 drivers/dma/ioat/dma.h   | 13 ++-----------
 drivers/dma/ioat/sysfs.c | 32 +++++++++++++++++++-------------
 2 files changed, 21 insertions(+), 24 deletions(-)
---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20260302-sysfs-const-ioat-0e665141b26b

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


