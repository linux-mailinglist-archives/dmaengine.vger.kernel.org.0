Return-Path: <dmaengine+bounces-9200-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eKdyDicPpmnlJgAAu9opvQ
	(envelope-from <dmaengine+bounces-9200-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 02 Mar 2026 23:28:55 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A39A01E56E6
	for <lists+dmaengine@lfdr.de>; Mon, 02 Mar 2026 23:28:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3D4A130D7EF3
	for <lists+dmaengine@lfdr.de>; Mon,  2 Mar 2026 22:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D77282F22;
	Mon,  2 Mar 2026 22:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="AOGGwHOh"
X-Original-To: dmaengine@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30027282F20;
	Mon,  2 Mar 2026 22:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772489766; cv=none; b=g1vHCUNudC//quUnl4q0MaOkXpPujVKCffBP6WEnCrfbCSFCXS/tuiOwyZPXb0ENOUpA2zhrDCnPr3gSPGHjfWSOXYES9brRccKVYXSEpSqgYSkujNJMUQ3QlfonoaCYL/nwWM5TgZanEU7eqFSFiZvFwGOZ2Epzi7v+CexR9G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772489766; c=relaxed/simple;
	bh=Yx4uswrVJCSfE8uQc/bTycKNIy1H/0NEEIeSIPlEKB4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MyhLJBHZTgGw0dqnrRfBDODBSu0RB/fyhOPaWGbuViEvxAISYaZufnmlywzXku756PV0Q+uIeVqvpJTjpXBxm4ANKj4tYJJ8um1KeYFCSgxA94veGJVSu/f/kPpIyzbFAd3fmBSXFU5UQA3iI0nqT7XfM+a0Ctfk9FGEYzoxY2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=AOGGwHOh; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1772489757;
	bh=Yx4uswrVJCSfE8uQc/bTycKNIy1H/0NEEIeSIPlEKB4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AOGGwHOhMwrU3hr2+0OCWymQq5ROcDa7xKFfqE6+ph0wbHLGiPeXNZwwbuD2Nc5Uo
	 vd7Olmc2WCMM5RRnf+drTfb5q7rMj/OWNSPDvCu/05vHQs/3xijs+aBkc7P+i/JcYb
	 rVJ/r7VpwBLyb5DZVWMUAQI8aDAw3osOMNIgc8Y4=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 02 Mar 2026 23:15:56 +0100
Subject: [PATCH 4/4] dmaengine: ioatdma: make sysfs attributes const
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260302-sysfs-const-ioat-v1-4-1229ee1c83f3@weissschuh.net>
References: <20260302-sysfs-const-ioat-v1-0-1229ee1c83f3@weissschuh.net>
In-Reply-To: <20260302-sysfs-const-ioat-v1-0-1229ee1c83f3@weissschuh.net>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772489756; l=3235;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=Yx4uswrVJCSfE8uQc/bTycKNIy1H/0NEEIeSIPlEKB4=;
 b=0JTEQCGs8kJZCdx+u9T9Q88P5vmDTWMyXLht9rO+1z+LW5siUf50kblsRtIX8jNCbef6PtPhM
 SsNLqyMoZzLBZHU0244VdopQOIjWGN3gj+4VWtoIklZtBi2z1NGCZrZ
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Rspamd-Queue-Id: A39A01E56E6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[weissschuh.net,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[weissschuh.net:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9200-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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

These structures are never modified, mark them as read-only.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/dma/ioat/sysfs.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/ioat/sysfs.c b/drivers/dma/ioat/sysfs.c
index da616365fef5..e796ddb5383f 100644
--- a/drivers/dma/ioat/sysfs.c
+++ b/drivers/dma/ioat/sysfs.c
@@ -32,7 +32,7 @@ static ssize_t cap_show(struct dma_chan *c, char *page)
 		       dma_has_cap(DMA_INTERRUPT, dma->cap_mask) ? " intr" : "");
 
 }
-static struct ioat_sysfs_entry ioat_cap_attr = __ATTR_RO(cap);
+static const struct ioat_sysfs_entry ioat_cap_attr = __ATTR_RO(cap);
 
 static ssize_t version_show(struct dma_chan *c, char *page)
 {
@@ -42,15 +42,15 @@ static ssize_t version_show(struct dma_chan *c, char *page)
 	return sprintf(page, "%d.%d\n",
 		       ioat_dma->version >> 4, ioat_dma->version & 0xf);
 }
-static struct ioat_sysfs_entry ioat_version_attr = __ATTR_RO(version);
+static const struct ioat_sysfs_entry ioat_version_attr = __ATTR_RO(version);
 
 static ssize_t
 ioat_attr_show(struct kobject *kobj, struct attribute *attr, char *page)
 {
-	struct ioat_sysfs_entry *entry;
+	const struct ioat_sysfs_entry *entry;
 	struct ioatdma_chan *ioat_chan;
 
-	entry = container_of(attr, struct ioat_sysfs_entry, attr);
+	entry = container_of_const(attr, struct ioat_sysfs_entry, attr);
 	ioat_chan = container_of(kobj, struct ioatdma_chan, kobj);
 
 	if (!entry->show)
@@ -62,10 +62,10 @@ static ssize_t
 ioat_attr_store(struct kobject *kobj, struct attribute *attr,
 const char *page, size_t count)
 {
-	struct ioat_sysfs_entry *entry;
+	const struct ioat_sysfs_entry *entry;
 	struct ioatdma_chan *ioat_chan;
 
-	entry = container_of(attr, struct ioat_sysfs_entry, attr);
+	entry = container_of_const(attr, struct ioat_sysfs_entry, attr);
 	ioat_chan = container_of(kobj, struct ioatdma_chan, kobj);
 
 	if (!entry->store)
@@ -120,7 +120,7 @@ static ssize_t ring_size_show(struct dma_chan *c, char *page)
 
 	return sprintf(page, "%d\n", (1 << ioat_chan->alloc_order) & ~1);
 }
-static struct ioat_sysfs_entry ring_size_attr = __ATTR_RO(ring_size);
+static const struct ioat_sysfs_entry ring_size_attr = __ATTR_RO(ring_size);
 
 static ssize_t ring_active_show(struct dma_chan *c, char *page)
 {
@@ -129,7 +129,7 @@ static ssize_t ring_active_show(struct dma_chan *c, char *page)
 	/* ...taken outside the lock, no need to be precise */
 	return sprintf(page, "%d\n", ioat_ring_active(ioat_chan));
 }
-static struct ioat_sysfs_entry ring_active_attr = __ATTR_RO(ring_active);
+static const struct ioat_sysfs_entry ring_active_attr = __ATTR_RO(ring_active);
 
 static ssize_t intr_coalesce_show(struct dma_chan *c, char *page)
 {
@@ -154,9 +154,9 @@ size_t count)
 	return count;
 }
 
-static struct ioat_sysfs_entry intr_coalesce_attr = __ATTR_RW(intr_coalesce);
+static const struct ioat_sysfs_entry intr_coalesce_attr = __ATTR_RW(intr_coalesce);
 
-static struct attribute *ioat_attrs[] = {
+static const struct attribute *const ioat_attrs[] = {
 	&ring_size_attr.attr,
 	&ring_active_attr.attr,
 	&ioat_cap_attr.attr,

-- 
2.53.0


