Return-Path: <dmaengine+bounces-9257-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IM91HeanqGlgwQAAu9opvQ
	(envelope-from <dmaengine+bounces-9257-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 04 Mar 2026 22:45:10 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 317FC208288
	for <lists+dmaengine@lfdr.de>; Wed, 04 Mar 2026 22:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 96C60302EAB3
	for <lists+dmaengine@lfdr.de>; Wed,  4 Mar 2026 21:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59AF3B7B94;
	Wed,  4 Mar 2026 21:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="lkt88XuF"
X-Original-To: dmaengine@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7D53932D6;
	Wed,  4 Mar 2026 21:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772660689; cv=none; b=Yq6Ol9z2dgRf4N6mIBzD/uz6Nq6K/cUk7jsG3V+TOjDHLvFtxjeVLLqx/Mpl84Fln1g/TjRLyfb2HBKjlhavMfkTdPQzQiwFg+ha5DOZRpjLPzgf37OImNoz+/4M0sapFblJnWaFkt9+quZRMPo7ZI+f21qZNVdLA1JkiNsJvBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772660689; c=relaxed/simple;
	bh=au4hr4SRiPU1CnIo4lT89wqmdY1G78qriD+p3/2be7Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MvvsyHrRka69QE5sdFTZdnirBjw4gt4jBnyg3F1Rtj+P+37yz/vCZuQBT37qEol0JWqPYdZ6xyd7eGhkTOqsoNhJK8K/gDugGi090NhXDGO8iQ36M0Dleihc3z+WvqUU+7qb5p3JAzT/L35iCJ01MX9fYtLRuD/J/e3inhBw2oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=lkt88XuF; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1772660680;
	bh=au4hr4SRiPU1CnIo4lT89wqmdY1G78qriD+p3/2be7Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lkt88XuF0bgl6pcTn8jxSitfEx7DlWgFtA845JlrIBEbEd5hembPHPdb8QxWncDns
	 36WA+A3Bnj/u91yff9U9QW//AHOnX6uY49Z8f0tF+VwOeyQ8k2roBWkBs+MI/wjFth
	 vUIAmfjCQNPIrxH/2Mh/8bv40ryLbatEhBg5Rf+0=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 04 Mar 2026 22:44:40 +0100
Subject: [PATCH v2 4/4] dmaengine: ioatdma: make sysfs attributes const
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260304-sysfs-const-ioat-v2-4-b9b82651219b@weissschuh.net>
References: <20260304-sysfs-const-ioat-v2-0-b9b82651219b@weissschuh.net>
In-Reply-To: <20260304-sysfs-const-ioat-v2-0-b9b82651219b@weissschuh.net>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dave Jiang <dave.jiang@intel.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772660679; l=3296;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=au4hr4SRiPU1CnIo4lT89wqmdY1G78qriD+p3/2be7Y=;
 b=cgSBUmOQFXnxgLvDYscfzOi34Fp2hRFph9czGTcEg/5uzj8K7iwgPvAIdVS8AJf+rtW1DRN+X
 bYdWmqXG6t4CCSaN+X1mFPDgX1I3lJIzIPg93ypVZpDXS9PjN84Txm4
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Rspamd-Queue-Id: 317FC208288
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
	TAGGED_FROM(0.00)[bounces-9257-lists,dmaengine=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linux@weissschuh.net,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[weissschuh.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:email]
X-Rspamd-Action: no action

The ioat_sysfs_entry structures are never modified, mark them as
read-only.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Acked-by: Dave Jiang <dave.jiang@intel.com>
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


