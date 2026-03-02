Return-Path: <dmaengine+bounces-9197-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEiiAw0XpmlWKQAAu9opvQ
	(envelope-from <dmaengine+bounces-9197-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 03 Mar 2026 00:02:37 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFD71E633F
	for <lists+dmaengine@lfdr.de>; Tue, 03 Mar 2026 00:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9F98315CF1E
	for <lists+dmaengine@lfdr.de>; Mon,  2 Mar 2026 22:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B743282F09;
	Mon,  2 Mar 2026 22:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="I/D2hA/b"
X-Original-To: dmaengine@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF213909BA;
	Mon,  2 Mar 2026 22:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772489765; cv=none; b=mdpjxXmGza1wi/uR33vX0adi45OyFlwO1ccptjVSs7uqnn1HD/A526HHvRhRB2PA26M+0WV3iF2D8RJ3s1Rvsz0i+uKNgwnxIuHUoSEP27fQ8MFWfrQwdCt5gq8Dmfe03Kmz0QikNWgJ0stkJD1MdCCSB85/bu33UFimty2hrfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772489765; c=relaxed/simple;
	bh=JZP2Abqextap6gz847k1XOtMIXftBFTpr8gDUzGYlK4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qBDEZUc9lz2RrmRpocznRxoMOC7wGt1o8vqLhJ7UxyIi7c+sitqyL3gDsttXHKW+z1gEKW0RcDBV1fZBEoNc7zzHTPkHYXmHsD8VpjJXATigXMRSPYl+/7srue8h8hawyBrXtx+2/L6Lq7MTJ+60b7IqBIdtqPZhdiSFKWDC9Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=I/D2hA/b; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1772489757;
	bh=JZP2Abqextap6gz847k1XOtMIXftBFTpr8gDUzGYlK4=;
	h=From:Subject:Date:To:Cc:From;
	b=I/D2hA/bZBa0jzFew7gZf/b/6ZKnroKS4PQuY5wuoo3SWO02yXJLe6Kza0HP+csgS
	 EKAstXSnX3ZMF6Uga8GKeBRKTBN1oXY00FeOBQBGBAftah1nmfzDhCo9xYDK8Fsuil
	 MORfbfaSz7bafqS2jWMTlyOxtYzidx9yOdi9jIZ4=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 0/4] dmaengine: ioatdma: some sysfs cleanups and
 constifications
Date: Mon, 02 Mar 2026 23:15:52 +0100
Message-Id: <20260302-sysfs-const-ioat-v1-0-1229ee1c83f3@weissschuh.net>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MMQ6AIAxA0auYzjYBVAavYhwUi3YBQ4nRGO4uc
 XzD/y8IJSaBsXkh0cXCMVTotgF3LGEn5K0ajDJWdcqgPOIFXQySkeOSUZG1g+71auwKNTsTeb7
 /5TSX8gFgqCx/YgAAAA==
X-Change-ID: 20260302-sysfs-const-ioat-0e665141b26b
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772489756; l=737;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=JZP2Abqextap6gz847k1XOtMIXftBFTpr8gDUzGYlK4=;
 b=SEuiwMTLg0gpcEdxWr67LNrlk8blKttdJg/YT2zXEpy49IciV5I6uWrT6VUezKvMWOMHjnh8i
 4Bmji6RsBDKAe7VeYrk56oNKEZbtzNV5XYVE/o6nubVSM3jdjFwWOq9
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Rspamd-Queue-Id: 0BFD71E633F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[weissschuh.net,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[weissschuh.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9197-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@weissschuh.net,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[weissschuh.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,weissschuh.net:dkim,weissschuh.net:email,weissschuh.net:mid]
X-Rspamd-Action: no action

Reduce the visibility of some symbols and make some structures readonly.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
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


