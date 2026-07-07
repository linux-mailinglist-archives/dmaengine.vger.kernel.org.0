Return-Path: <dmaengine+bounces-12073-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ia6gEJIoTWrhvwEAu9opvQ
	(envelope-from <dmaengine+bounces-12073-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 07 Jul 2026 18:25:54 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E341971DD6F
	for <lists+dmaengine@lfdr.de>; Tue, 07 Jul 2026 18:25:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=deltatee.com header.s=20200525 header.b=dDP8G+f4;
	dmarc=pass (policy=quarantine) header.from=deltatee.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12073-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-12073-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 43D693063CEF
	for <lists+dmaengine@lfdr.de>; Tue,  7 Jul 2026 16:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD835340419;
	Tue,  7 Jul 2026 16:21:10 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0535434E25
	for <dmaengine@vger.kernel.org>; Tue,  7 Jul 2026 16:21:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783441270; cv=none; b=Zj9Y/Lequ85a9FJEnRhYgLHq49xfWOWITH1pCLGqHHCZqcUJoTKSCWhwrC7RHAiNBP7oAYnde3Y8R2D0SV6ul8c9eFYvYP1sIjdAyuO2XVuRu5Z2zbTuntuKiFLvw308SodCkdVfYQDEYshWpYHJT0qpgaxF8vMlSxI9M1QebzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783441270; c=relaxed/simple;
	bh=Ekrb+FrKRQaNCuPrxfMZ6ojZaI7V7z5M8te3HPoh4qs=;
	h=From:To:Cc:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Subject; b=WtPCZktmAz8LXT+rxaw8ktVtFiik2Y0i5z+rtuuvGGQj0f821scs5JwuXdUhksrSMleWbj0zl/3eAYsPwnL6IE3MJ8hxEhSpfy9M7NFcQAXY/xNU1hxtMHMn8dQs7kzx3pmRAylsY0+IJsizGi0ozAFfY6CmK5bXIaJ13HmzvEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=dDP8G+f4; arc=none smtp.client-ip=204.191.154.188
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Cc:To:From:content-disposition;
	bh=fAOc72ImzyZ/DgqJpDIwjn0pUKI5Z4GRrttfv+YxGrY=; b=dDP8G+f4RwMJMg74Z+a66joYZA
	GDSjTKcE6BSATVW0l5WlB1wLZHsUI+rCJcbzyowCY0M1ATf6d/3p899BmjY/dLEG0mdYY8igvViSy
	zwRiQUVia7cJKgcmhEYr6UmP5Bj3Sqa2PfEhcr6npLKL36vUaUm7KxacYsFYaO4rrSeCYM68GXn0h
	710T/daI4aQs4OytaPifv2MW+mkX4bRZXYaDfLKcY0q+f4OR49eUebAD66dffEOhkGlyBqMnk3nC6
	mihJBAPv9m59HczmtreN2IFLCpQXgs0GlOmdFjO+XYiRDu00v8Tz8tEoa+UyDqsRgSTYotaopKZIV
	RnYs/1eA==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
	by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1wh8Xc-00000000nsv-36gz;
	Tue, 07 Jul 2026 10:21:01 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1wh8XR-000000006E5-0haz;
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
Date: Tue,  7 Jul 2026 10:20:41 -0600
Message-ID: <20260707162045.23910-2-logang@deltatee.com>
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
Subject: [PATCH v1 1/5] dmaengine: add support for custom per-channel sysfs attributes
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[deltatee.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[deltatee.com:s=20200525];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[nxp.com,infradead.org,wanadoo.fr,intel.com,weissschuh.net,microchip.com,deltatee.com];
	TAGGED_FROM(0.00)[bounces-12073-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:Frank.li@nxp.com,m:hch@infradead.org,m:christophe.jaillet@wanadoo.fr,m:dave.jiang@intel.com,m:linux@weissschuh.net,m:kelvin.cao@microchip.com,m:logang@deltatee.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[logang@deltatee.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[deltatee.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,deltatee.com:from_mime,deltatee.com:email,deltatee.com:mid,deltatee.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E341971DD6F

Add specific support for adding sysfs attributes to channels.

This will be used to replace similar functionality in ioat so it can
be used in other drivers.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/dma/dmaengine.c   | 62 +++++++++++++++++++++++++++++++++++++++
 drivers/dma/dmaengine.h   | 11 +++++++
 include/linux/dmaengine.h |  3 ++
 3 files changed, 76 insertions(+)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 9049171df857..7ea2a8709c07 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -125,6 +125,63 @@ static int dmaengine_summary_show(struct seq_file *s, void *data)
 }
 DEFINE_SHOW_ATTRIBUTE(dmaengine_summary);
 
+static ssize_t
+dma_chan_attr_show(struct kobject *kobj, struct attribute *attr, char *page)
+{
+	const struct dma_chan_sysfs_entry *entry;
+	struct dma_chan *dma_chan;
+
+	entry = container_of_const(attr, struct dma_chan_sysfs_entry, attr);
+	dma_chan = container_of(kobj, struct dma_chan, kobj);
+
+	if (!entry->show)
+		return -EIO;
+
+	return entry->show(dma_chan, page);
+}
+
+static ssize_t
+dma_chan_attr_store(struct kobject *kobj, struct attribute *attr,
+		    const char *page, size_t count)
+{
+	const struct dma_chan_sysfs_entry *entry;
+	struct dma_chan *dma_chan;
+
+	entry = container_of_const(attr, struct dma_chan_sysfs_entry, attr);
+	dma_chan = container_of(kobj, struct dma_chan, kobj);
+
+	if (!entry->store)
+		return -EIO;
+
+	return entry->store(dma_chan, page, count);
+}
+
+const struct sysfs_ops dma_chan_sysfs_ops = {
+	.show = dma_chan_attr_show,
+	.store = dma_chan_attr_store,
+};
+EXPORT_SYMBOL_GPL(dma_chan_sysfs_ops);
+
+void dma_chan_kobject_add(struct dma_device *dev, const struct kobj_type *type,
+			  const char *name)
+{
+	struct dma_chan *chan;
+	int err;
+
+	list_for_each_entry(chan, &dev->channels, device_node) {
+		chan->kobj_used = true;
+		err = kobject_init_and_add(&chan->kobj, type,
+					   &chan->dev->device.kobj, name);
+		if (err) {
+			dev_warn(dev->dev,
+				 "sysis init error(%d), continuinng...\n", err);
+			kobject_put(&chan->kobj);
+			chan->kobj_used = false;
+		}
+	}
+}
+EXPORT_SYMBOL_GPL(dma_chan_kobject_add);
+
 static void __init dmaengine_debugfs_init(void)
 {
 	rootdir = debugfs_create_dir("dmaengine", NULL);
@@ -1143,6 +1200,11 @@ static void __dma_async_device_channel_unregister(struct dma_device *device,
 	if (chan->local == NULL)
 		return;
 
+	if (chan->kobj_used) {
+		kobject_del(&chan->kobj);
+		kobject_put(&chan->kobj);
+	}
+
 	WARN_ONCE(!device->device_release && chan->client_count,
 		  "%s called while %d clients hold a reference\n",
 		  __func__, chan->client_count);
diff --git a/drivers/dma/dmaengine.h b/drivers/dma/dmaengine.h
index 53f16d3f0029..496cac056350 100644
--- a/drivers/dma/dmaengine.h
+++ b/drivers/dma/dmaengine.h
@@ -182,6 +182,17 @@ dmaengine_desc_callback_valid(struct dmaengine_desc_callback *cb)
 struct dma_chan *dma_get_slave_channel(struct dma_chan *chan);
 struct dma_chan *dma_get_any_slave_channel(struct dma_device *device);
 
+struct dma_chan_sysfs_entry {
+	struct attribute attr;
+	ssize_t (*show)(struct dma_chan *chan, char *page);
+	ssize_t (*store)(struct dma_chan *chan, const char *page, size_t count);
+};
+
+extern const struct sysfs_ops dma_chan_sysfs_ops;
+
+void dma_chan_kobject_add(struct dma_device *dev, const struct kobj_type *type,
+			  const char *name);
+
 #ifdef CONFIG_DEBUG_FS
 #include <linux/debugfs.h>
 
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index b3d251c9734e..852943ef46b8 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -358,6 +358,9 @@ struct dma_chan {
 	struct dma_router *router;
 	void *route_data;
 
+	bool kobj_used;
+	struct kobject kobj;
+
 	void *private;
 };
 
-- 
2.47.3


