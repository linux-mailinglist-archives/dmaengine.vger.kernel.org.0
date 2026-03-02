Return-Path: <dmaengine+bounces-9201-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eET7LkYPpmkJJwAAu9opvQ
	(envelope-from <dmaengine+bounces-9201-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 02 Mar 2026 23:29:26 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 741821E5733
	for <lists+dmaengine@lfdr.de>; Mon, 02 Mar 2026 23:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C678430DA1DF
	for <lists+dmaengine@lfdr.de>; Mon,  2 Mar 2026 22:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505FD31E85A;
	Mon,  2 Mar 2026 22:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="rHHjByPQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E981DE3B7;
	Mon,  2 Mar 2026 22:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772489767; cv=none; b=GK4HPycJKJ/L+dGK4fFRzPiXATrpjpd0dwfpFLZ6AFDWwrhyOip39qWGoRoKq121drnmZpaKP+IB9eHvlilYZGCQfBRrfOnGctL0s8DVmaA3nyYXr9fg8wsOVL43zpyZIYh1W05KvN1Dovr3gSj0Z52KGWOaa5FJ0GUYiVPIEH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772489767; c=relaxed/simple;
	bh=uCHVU4aMcslsNR62ySaA3wlI0q+wLxUZU06lIe7mkAQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cldlyJHYsfMxuLUGYeNSOreCr5wWAjLhTWvYQItQ5lX+yFYVpbclh2oJ++9CntP9UmU8KokWrT0B4iS4ejKBmDmHm/DZyO8Z+696lHpr5mgSa6qhew4HdOVA00AG/CBRnShYZSKzN5Iws05Vw2+NIY7tui8k+/js0hh48WE1GG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=rHHjByPQ; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1772489757;
	bh=uCHVU4aMcslsNR62ySaA3wlI0q+wLxUZU06lIe7mkAQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rHHjByPQ7VSCVYmT/hFgPjBiI6rSh7dqWodNiFcZt8r2LpzVGeWOS9DlsySXkzF2/
	 XOi019NVuwhTaSK/P9dR3ta1dToGmuti8VwTg5MJ0ms4y5uDIEIZ8U7JIkjO5BIBTA
	 jWdG/VeDz30TLfmxLFKix1GZjiIMMhzIw/z5eKmM=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 02 Mar 2026 23:15:54 +0100
Subject: [PATCH 2/4] dmaengine: ioatdma: move sysfs entry definition out of
 header
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260302-sysfs-const-ioat-v1-2-1229ee1c83f3@weissschuh.net>
References: <20260302-sysfs-const-ioat-v1-0-1229ee1c83f3@weissschuh.net>
In-Reply-To: <20260302-sysfs-const-ioat-v1-0-1229ee1c83f3@weissschuh.net>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772489756; l=1302;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=uCHVU4aMcslsNR62ySaA3wlI0q+wLxUZU06lIe7mkAQ=;
 b=cWF078ulHq3Rtdxph2M53Tytl9OqEu4aygFEl8VOH8vwEf6ksqSlB/7ZM5b2mDrnc1NTxjSbB
 OpQ0+VfIDueAt1mVbzReFwTnv7iJvsk1T8ibjIRUEJl0Gpk8LHq42Q7
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Rspamd-Queue-Id: 741821E5733
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[weissschuh.net,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[weissschuh.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9201-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@weissschuh.net,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[weissschuh.net:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[weissschuh.net:dkim,weissschuh.net:email,weissschuh.net:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

This structure is only ever used from sysfs.c.

Move its definition there.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/dma/ioat/dma.h   | 6 ------
 drivers/dma/ioat/sysfs.c | 6 ++++++
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/ioat/dma.h b/drivers/dma/ioat/dma.h
index 27d2b411853f..e187f3a7e968 100644
--- a/drivers/dma/ioat/dma.h
+++ b/drivers/dma/ioat/dma.h
@@ -140,12 +140,6 @@ struct ioatdma_chan {
 	int prev_intr_coalesce;
 };
 
-struct ioat_sysfs_entry {
-	struct attribute attr;
-	ssize_t (*show)(struct dma_chan *, char *);
-	ssize_t (*store)(struct dma_chan *, const char *, size_t);
-};
-
 /**
  * struct ioat_sed_ent - wrapper around super extended hardware descriptor
  * @hw: hardware SED
diff --git a/drivers/dma/ioat/sysfs.c b/drivers/dma/ioat/sysfs.c
index 5da9b0a7b2bb..709d672bae51 100644
--- a/drivers/dma/ioat/sysfs.c
+++ b/drivers/dma/ioat/sysfs.c
@@ -14,6 +14,12 @@
 
 #include "../dmaengine.h"
 
+struct ioat_sysfs_entry {
+	struct attribute attr;
+	ssize_t (*show)(struct dma_chan *, char *);
+	ssize_t (*store)(struct dma_chan *, const char *, size_t);
+};
+
 static ssize_t cap_show(struct dma_chan *c, char *page)
 {
 	struct dma_device *dma = c->device;

-- 
2.53.0


