Return-Path: <dmaengine+bounces-12072-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xpljLpEoTWrgvwEAu9opvQ
	(envelope-from <dmaengine+bounces-12072-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 07 Jul 2026 18:25:53 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3436871DD6A
	for <lists+dmaengine@lfdr.de>; Tue, 07 Jul 2026 18:25:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=deltatee.com header.s=20200525 header.b=r+vjNxOk;
	dmarc=pass (policy=quarantine) header.from=deltatee.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12072-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12072-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1ECF13063ADA
	for <lists+dmaengine@lfdr.de>; Tue,  7 Jul 2026 16:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04AFF433E99;
	Tue,  7 Jul 2026 16:21:10 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577AD175A89
	for <dmaengine@vger.kernel.org>; Tue,  7 Jul 2026 16:21:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783441269; cv=none; b=aQVkMaVUkGuxv08Ed3jG9A+BHlWOqIEOMorr6RaLNv189lDmZDDd/OOh+KUCGe56lTnBs0WcHraRKxPPA23/2Vjq8dEGrub3iM9p/Jn4Ni2yuqKrX7muNlHVLE/Wi7R7aelRBKtkWPRd0O7l3/jiORrp9iN70CaE8odxbVzJ7Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783441269; c=relaxed/simple;
	bh=PxHfaNiltiVSFBk9+yhjXhtFcnMBg9MvRWkeIfcPDwk=;
	h=From:To:Cc:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Subject; b=JG2B/P5LM12zbhXWUqqMWC6brpkGV+YjuH2wf3lD7BxFmREl8H2mtkkNPq78fZmX/O5XJBmA4OmKXvZmXJTSsfWox+Pmt7XjsTDOQiR9yw5l9ssW/yuWB4cGcynIC1sHEvlQbFH5VtFAu4UK9BNbkMH3d8VO5L+5ho+Ga7yB5vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=r+vjNxOk; arc=none smtp.client-ip=204.191.154.188
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Cc:To:From:content-disposition;
	bh=0U/BtM0ZTMKhM7yc3tCJeVmRch1+GQex6MiqUfh0EJg=; b=r+vjNxOkr7/SYHX1CGp0ZXNR2n
	vrpvV2ejR0g8CKkefKpQ3FL6p7oYb1RDYU59SClVVwKIDxFkiUJGwpIdpkNi5n/elbU/n3ksPHVa3
	ylLU+vyDkhKry90Ze8/XfrW8t6TBODe+0h0ggbGXwXOQM0uhmmNzxcXFeZ5DpQ0dzKdJ3t2x3QKNn
	kAXVqrMMd6tXydr8/hplXdwKJx8OXzShbRwgaecSHfm2HnRO+AYOgPt7Nxicy8KKU1B48tUtWH3OW
	bnLQytfkw6lCBDsIsSVX7LomXmbf3rdcO4JvjFe1+WJMgd7+Y4aRxH8kMgcnhRQps6Z51yigrLl8X
	Zyzv4fZw==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
	by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1wh8Xc-00000000nsx-36gB;
	Tue, 07 Jul 2026 10:21:02 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1wh8XR-000000006EC-1tQa;
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
Date: Tue,  7 Jul 2026 10:20:43 -0600
Message-ID: <20260707162045.23910-4-logang@deltatee.com>
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
Subject: [PATCH v1 3/5] dmaengine: switchtec-dma: Add config sysfs attributes
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[deltatee.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[deltatee.com:s=20200525];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[nxp.com,infradead.org,wanadoo.fr,intel.com,weissschuh.net,microchip.com,deltatee.com];
	TAGGED_FROM(0.00)[bounces-12072-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dmaengine@vger.kernel.org,m:vkoul@kernel.org,m:Frank.li@nxp.com,m:hch@infradead.org,m:christophe.jaillet@wanadoo.fr,m:dave.jiang@intel.com,m:linux@weissschuh.net,m:kelvin.cao@microchip.com,m:logang@deltatee.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[logang@deltatee.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[deltatee.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
X-Rspamd-Queue-Id: 3436871DD6A

Add sysfs configuration options for switchtec-dma devices.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/dma/switchtec_dma.c | 141 ++++++++++++++++++++++++++++++++++++
 1 file changed, 141 insertions(+)

diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
index 3ef928640615..4841134bd7b8 100644
--- a/drivers/dma/switchtec_dma.c
+++ b/drivers/dma/switchtec_dma.c
@@ -1027,6 +1027,145 @@ static int switchtec_dma_alloc_chan_resources(struct dma_chan *chan)
 	return SWITCHTEC_DMA_SQ_SIZE;
 }
 
+static __always_inline ssize_t perf_cfg_show(struct dma_chan *chan, char *page,
+					     unsigned int mask)
+{
+	struct switchtec_dma_chan *swdma_chan =
+		container_of(chan, struct switchtec_dma_chan, dma_chan);
+	struct chan_fw_regs __iomem *chan_fw = swdma_chan->mmio_chan_fw;
+	u32 perf_cfg;
+	int value;
+
+	rcu_read_lock();
+	if (!rcu_dereference(swdma_chan->swdma_dev->pdev)) {
+		rcu_read_unlock();
+		return -ENODEV;
+	}
+
+	perf_cfg = readl(&chan_fw->perf_cfg);
+	value = field_get(mask, perf_cfg);
+
+	rcu_read_unlock();
+	return sprintf(page, "0x%x\n", value);
+}
+
+static __always_inline ssize_t perf_cfg_store(struct dma_chan *chan,
+		const char *page, size_t count, unsigned int mask)
+{
+	struct switchtec_dma_chan *swdma_chan =
+		container_of(chan, struct switchtec_dma_chan, dma_chan);
+	struct chan_fw_regs __iomem *chan_fw = swdma_chan->mmio_chan_fw;
+	ssize_t ret = count;
+	u32 perf_cfg;
+	int value;
+
+	if (kstrtoint(page, 0, &value) < 0)
+		return -EINVAL;
+
+	if (value < 0 || value > field_max(mask))
+		return -EINVAL;
+
+	rcu_read_lock();
+	if (!rcu_dereference(swdma_chan->swdma_dev->pdev)) {
+		ret = -ENODEV;
+		goto err_unlock;
+	}
+
+	if (chan->client_count)
+		goto err_unlock;
+
+	perf_cfg = readl(&chan_fw->perf_cfg);
+	perf_cfg = (perf_cfg & ~mask) | field_prep(mask, value);
+	writel(perf_cfg, &chan_fw->perf_cfg);
+
+err_unlock:
+	rcu_read_unlock();
+	return ret;
+}
+
+static ssize_t burst_scale_show(struct dma_chan *chan, char *page)
+{
+	return perf_cfg_show(chan, page, PERF_BURST_SCALE_MASK);
+}
+
+static ssize_t burst_scale_store(struct dma_chan *chan, const char *page,
+				 size_t count)
+{
+	return perf_cfg_store(chan, page, count, PERF_BURST_SCALE_MASK);
+}
+static struct dma_chan_sysfs_entry burst_scale_attr = __ATTR_RW(burst_scale);
+
+static ssize_t mrrs_show(struct dma_chan *chan, char *page)
+{
+	return perf_cfg_show(chan, page, PERF_MRRS_MASK);
+}
+
+static ssize_t mrrs_store(struct dma_chan *chan, const char *page,
+				 size_t count)
+{
+	return perf_cfg_store(chan, page, count, PERF_MRRS_MASK);
+}
+static struct dma_chan_sysfs_entry mrrs_attr = __ATTR_RW(mrrs);
+
+static ssize_t interval_show(struct dma_chan *chan, char *page)
+{
+	return perf_cfg_show(chan, page, PERF_INTERVAL_MASK);
+}
+
+static ssize_t interval_store(struct dma_chan *chan, const char *page,
+				 size_t count)
+{
+	return perf_cfg_store(chan, page, count, PERF_INTERVAL_MASK);
+}
+static struct dma_chan_sysfs_entry interval_attr = __ATTR_RW(interval);
+
+static ssize_t burst_size_show(struct dma_chan *chan, char *page)
+{
+	return perf_cfg_show(chan, page, PERF_BURST_SIZE_MASK);
+}
+
+static ssize_t burst_size_store(struct dma_chan *chan, const char *page,
+				size_t count)
+{
+	return perf_cfg_store(chan, page, count, PERF_BURST_SIZE_MASK);
+}
+static struct dma_chan_sysfs_entry burst_size_attr = __ATTR_RW(burst_size);
+
+static ssize_t arb_weight_show(struct dma_chan *chan, char *page)
+{
+	return perf_cfg_show(chan, page, PERF_ARB_WEIGHT_MASK);
+}
+
+static ssize_t arb_weight_store(struct dma_chan *chan, const char *page,
+				 size_t count)
+{
+	return perf_cfg_store(chan, page, count, PERF_ARB_WEIGHT_MASK);
+}
+static struct dma_chan_sysfs_entry arb_weight_attr = __ATTR_RW(arb_weight);
+
+static struct attribute *switchtec_config_attrs[] = {
+	&burst_scale_attr.attr,
+	&mrrs_attr.attr,
+	&interval_attr.attr,
+	&burst_size_attr.attr,
+	&arb_weight_attr.attr,
+	NULL
+};
+
+static struct attribute_group switchtec_config_group = {
+	.attrs = switchtec_config_attrs,
+};
+
+static const struct attribute_group *switchtec_groups[] = {
+	&switchtec_config_group,
+	NULL,
+};
+
+static const struct kobj_type switchtec_ktype = {
+	.sysfs_ops = &dma_chan_sysfs_ops,
+	.default_groups = switchtec_groups,
+};
+
 static void switchtec_dma_free_chan_resources(struct dma_chan *chan)
 {
 	struct switchtec_dma_chan *swdma_chan =
@@ -1286,6 +1425,8 @@ static int switchtec_dma_create(struct pci_dev *pdev)
 		goto err_chans_release_exit;
 	}
 
+	dma_chan_kobject_add(dma, &switchtec_ktype, "switchtec");
+
 	pci_dbg(pdev, "Channel count: %d\n", chan_cnt);
 
 	list_for_each_entry(chan, &dma->channels, device_node)
-- 
2.47.3


