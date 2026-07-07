Return-Path: <dmaengine+bounces-12070-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2b2CLngnTWqkvwEAu9opvQ
	(envelope-from <dmaengine+bounces-12070-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 07 Jul 2026 18:21:12 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C91AC71DC90
	for <lists+dmaengine@lfdr.de>; Tue, 07 Jul 2026 18:21:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=deltatee.com header.s=20200525 header.b=BQJQxmzw;
	dmarc=pass (policy=quarantine) header.from=deltatee.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12070-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12070-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 19FCA30087C9
	for <lists+dmaengine@lfdr.de>; Tue,  7 Jul 2026 16:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D621ABED9;
	Tue,  7 Jul 2026 16:21:09 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0433433E9E
	for <dmaengine@vger.kernel.org>; Tue,  7 Jul 2026 16:21:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783441269; cv=none; b=H3JlJfLnkJD4kE49e83pqmPCwiQhEHme580mFm/zph8f1FqBWgaEwW0q+gL/vd5jtDabCD+/apWaV/fqk9KjhDJIZfMVsZIgzCb4TXXgHzYe5XEnfbgkKJhaB/b8C7jdbq4pOZYuujNY26sr/8kjY/1G35hFIesy1u1QFDpmTdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783441269; c=relaxed/simple;
	bh=snuMzwebrzBcg3AtPpa0riT3h/vIaWuet9CF7M2UDSA=;
	h=From:To:Cc:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Subject; b=u5kasquGPNwuHh9O0/6jy9XuGqwQfTE6aEdiYF1wz3AhY6S9Ut8q2cYY1AbFwms3JQB+ewLulC6p8BIBN/RwE+2/B6+3jV+0HT1rgycaABtYyz7r/7RGG71lEpBN26nAmBRp01T7tis3R1Kq26o9MyzOsIVQMPYPHcMeMjcUR30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=BQJQxmzw; arc=none smtp.client-ip=204.191.154.188
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Cc:To:From:content-disposition;
	bh=oqKXTOOA0NgLffHjYC0maEA/FMT7Cjd3M2/MCySeCm8=; b=BQJQxmzwetAZgaWSkrLQ/ePAjl
	AROtIU1eQwXM1TvpGPM0cZlD4vwYlCoi/cD7cL65WpbCsplVZdc6el8j949qeURHISpHY7QIpkdJn
	15gBfJxmg1RDW0FHHUY3KG0ggQ61kuQ1pP1/X1ipSkvirvH5QgfP4V8/KQPGUzvvd0Dcw/sULjLdn
	mw7u2pHTEo9krPz2fHOLxB0uSAKb3WdeQndrqKo3ipiuUGT5OEhq9MwIGZcyi91GwQ8dx2oP5Vsll
	qW7jP4SE3AnD+2V50btXFSgmn83mBkdkbuiomt7IS6++o4WcOmtK3qgtz2UoXvv91GAuWUMJdvY0v
	YBl5sEDQ==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
	by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1wh8Xc-00000000nsw-36h9;
	Tue, 07 Jul 2026 10:21:01 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1wh8XR-000000006E8-1Iqh;
	Tue, 07 Jul 2026 10:20:49 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: dmaengine@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>
Cc: Frank Li <Frank.li@nxp.com>,
	Christoph Hellwig <hch@infradead.org>,
	Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
	Dave Jiang <dave.jiang@intel.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Kelvin Cao <kelvin.cao@microchip.com>,
	Logan Gunthorpe <logang@deltatee.com>
Date: Tue,  7 Jul 2026 10:20:42 -0600
Message-ID: <20260707162045.23910-3-logang@deltatee.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260707162045.23910-1-logang@deltatee.com>
References: <20260707162045.23910-1-logang@deltatee.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: dmaengine@vger.kernel.org, vkoul@kernel.org, Frank.li@nxp.com, hch@infradead.org, christophe.jaillet@wanadoo.fr, dave.jiang@intel.com, linux@weissschuh.net, kelvin.cao@microchip.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Level: 
Subject: [PATCH v1 2/5] dmaengine: ioatdma: use common channel sysfs attribute creation
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[deltatee.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[deltatee.com:s=20200525];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[nxp.com,infradead.org,wanadoo.fr,intel.com,weissschuh.net,microchip.com,deltatee.com];
	TAGGED_FROM(0.00)[bounces-12070-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:Frank.li@nxp.com,m:hch@infradead.org,m:christophe.jaillet@wanadoo.fr,m:dave.jiang@intel.com,m:linux@weissschuh.net,m:kelvin.cao@microchip.com,m:logang@deltatee.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[logang@deltatee.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[deltatee.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[logang@deltatee.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,deltatee.com:from_mime,deltatee.com:email,deltatee.com:mid,deltatee.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C91AC71DC90

Instead of manually creating and adding sysfs attributes to each channel
use the common dma_chan_kobject_add() facility.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/dma/ioat/dma.h   |  2 -
 drivers/dma/ioat/init.c  |  4 +-
 drivers/dma/ioat/sysfs.c | 88 +++-------------------------------------
 3 files changed, 7 insertions(+), 87 deletions(-)

diff --git a/drivers/dma/ioat/dma.h b/drivers/dma/ioat/dma.h
index e8a880f338c6..bea2a0101ede 100644
--- a/drivers/dma/ioat/dma.h
+++ b/drivers/dma/ioat/dma.h
@@ -393,8 +393,6 @@ void ioat_issue_pending(struct dma_chan *chan);
 /* IOAT Init functions */
 bool is_bwd_ioat(struct pci_dev *pdev);
 struct dca_provider *ioat_dca_init(struct pci_dev *pdev, void __iomem *iobase);
-void ioat_kobject_add(struct ioatdma_device *ioat_dma, const struct kobj_type *type);
-void ioat_kobject_del(struct ioatdma_device *ioat_dma);
 int ioat_dma_setup_interrupts(struct ioatdma_device *ioat_dma);
 void ioat_stop(struct ioatdma_chan *ioat_chan);
 #endif /* IOATDMA_H */
diff --git a/drivers/dma/ioat/init.c b/drivers/dma/ioat/init.c
index 737496391109..82f76fd0ccc1 100644
--- a/drivers/dma/ioat/init.c
+++ b/drivers/dma/ioat/init.c
@@ -541,8 +541,6 @@ static void ioat_dma_remove(struct ioatdma_device *ioat_dma)
 
 	ioat_disable_interrupts(ioat_dma);
 
-	ioat_kobject_del(ioat_dma);
-
 	dma_async_device_unregister(dma);
 }
 
@@ -1174,7 +1172,7 @@ static int ioat3_dma_probe(struct ioatdma_device *ioat_dma, int dca)
 	if (err)
 		goto err_disable_interrupts;
 
-	ioat_kobject_add(ioat_dma, &ioat_ktype);
+	dma_chan_kobject_add(&ioat_dma->dma_dev, &ioat_ktype, "quickdata");
 
 	if (dca)
 		ioat_dma->dca = ioat_dca_init(pdev, ioat_dma->reg_base);
diff --git a/drivers/dma/ioat/sysfs.c b/drivers/dma/ioat/sysfs.c
index e796ddb5383f..4dc61fdddb21 100644
--- a/drivers/dma/ioat/sysfs.c
+++ b/drivers/dma/ioat/sysfs.c
@@ -14,12 +14,6 @@
 
 #include "../dmaengine.h"
 
-struct ioat_sysfs_entry {
-	struct attribute attr;
-	ssize_t (*show)(struct dma_chan *, char *);
-	ssize_t (*store)(struct dma_chan *, const char *, size_t);
-};
-
 static ssize_t cap_show(struct dma_chan *c, char *page)
 {
 	struct dma_device *dma = c->device;
@@ -32,7 +26,7 @@ static ssize_t cap_show(struct dma_chan *c, char *page)
 		       dma_has_cap(DMA_INTERRUPT, dma->cap_mask) ? " intr" : "");
 
 }
-static const struct ioat_sysfs_entry ioat_cap_attr = __ATTR_RO(cap);
+static const struct dma_chan_sysfs_entry ioat_cap_attr = __ATTR_RO(cap);
 
 static ssize_t version_show(struct dma_chan *c, char *page)
 {
@@ -42,77 +36,7 @@ static ssize_t version_show(struct dma_chan *c, char *page)
 	return sprintf(page, "%d.%d\n",
 		       ioat_dma->version >> 4, ioat_dma->version & 0xf);
 }
-static const struct ioat_sysfs_entry ioat_version_attr = __ATTR_RO(version);
-
-static ssize_t
-ioat_attr_show(struct kobject *kobj, struct attribute *attr, char *page)
-{
-	const struct ioat_sysfs_entry *entry;
-	struct ioatdma_chan *ioat_chan;
-
-	entry = container_of_const(attr, struct ioat_sysfs_entry, attr);
-	ioat_chan = container_of(kobj, struct ioatdma_chan, kobj);
-
-	if (!entry->show)
-		return -EIO;
-	return entry->show(&ioat_chan->dma_chan, page);
-}
-
-static ssize_t
-ioat_attr_store(struct kobject *kobj, struct attribute *attr,
-const char *page, size_t count)
-{
-	const struct ioat_sysfs_entry *entry;
-	struct ioatdma_chan *ioat_chan;
-
-	entry = container_of_const(attr, struct ioat_sysfs_entry, attr);
-	ioat_chan = container_of(kobj, struct ioatdma_chan, kobj);
-
-	if (!entry->store)
-		return -EIO;
-	return entry->store(&ioat_chan->dma_chan, page, count);
-}
-
-static const struct sysfs_ops ioat_sysfs_ops = {
-	.show	= ioat_attr_show,
-	.store  = ioat_attr_store,
-};
-
-void ioat_kobject_add(struct ioatdma_device *ioat_dma, const struct kobj_type *type)
-{
-	struct dma_device *dma = &ioat_dma->dma_dev;
-	struct dma_chan *c;
-
-	list_for_each_entry(c, &dma->channels, device_node) {
-		struct ioatdma_chan *ioat_chan = to_ioat_chan(c);
-		struct kobject *parent = &c->dev->device.kobj;
-		int err;
-
-		err = kobject_init_and_add(&ioat_chan->kobj, type,
-					   parent, "quickdata");
-		if (err) {
-			dev_warn(to_dev(ioat_chan),
-				 "sysfs init error (%d), continuing...\n", err);
-			kobject_put(&ioat_chan->kobj);
-			set_bit(IOAT_KOBJ_INIT_FAIL, &ioat_chan->state);
-		}
-	}
-}
-
-void ioat_kobject_del(struct ioatdma_device *ioat_dma)
-{
-	struct dma_device *dma = &ioat_dma->dma_dev;
-	struct dma_chan *c;
-
-	list_for_each_entry(c, &dma->channels, device_node) {
-		struct ioatdma_chan *ioat_chan = to_ioat_chan(c);
-
-		if (!test_bit(IOAT_KOBJ_INIT_FAIL, &ioat_chan->state)) {
-			kobject_del(&ioat_chan->kobj);
-			kobject_put(&ioat_chan->kobj);
-		}
-	}
-}
+static const struct dma_chan_sysfs_entry ioat_version_attr = __ATTR_RO(version);
 
 static ssize_t ring_size_show(struct dma_chan *c, char *page)
 {
@@ -120,7 +44,7 @@ static ssize_t ring_size_show(struct dma_chan *c, char *page)
 
 	return sprintf(page, "%d\n", (1 << ioat_chan->alloc_order) & ~1);
 }
-static const struct ioat_sysfs_entry ring_size_attr = __ATTR_RO(ring_size);
+static const struct dma_chan_sysfs_entry ring_size_attr = __ATTR_RO(ring_size);
 
 static ssize_t ring_active_show(struct dma_chan *c, char *page)
 {
@@ -129,7 +53,7 @@ static ssize_t ring_active_show(struct dma_chan *c, char *page)
 	/* ...taken outside the lock, no need to be precise */
 	return sprintf(page, "%d\n", ioat_ring_active(ioat_chan));
 }
-static const struct ioat_sysfs_entry ring_active_attr = __ATTR_RO(ring_active);
+static const struct dma_chan_sysfs_entry ring_active_attr = __ATTR_RO(ring_active);
 
 static ssize_t intr_coalesce_show(struct dma_chan *c, char *page)
 {
@@ -154,7 +78,7 @@ size_t count)
 	return count;
 }
 
-static const struct ioat_sysfs_entry intr_coalesce_attr = __ATTR_RW(intr_coalesce);
+static const struct dma_chan_sysfs_entry intr_coalesce_attr = __ATTR_RW(intr_coalesce);
 
 static const struct attribute *const ioat_attrs[] = {
 	&ring_size_attr.attr,
@@ -167,6 +91,6 @@ static const struct attribute *const ioat_attrs[] = {
 ATTRIBUTE_GROUPS(ioat);
 
 const struct kobj_type ioat_ktype = {
-	.sysfs_ops = &ioat_sysfs_ops,
+	.sysfs_ops = &dma_chan_sysfs_ops,
 	.default_groups = ioat_groups,
 };
-- 
2.47.3


