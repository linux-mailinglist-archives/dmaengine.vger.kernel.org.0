Return-Path: <dmaengine+bounces-12074-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PTkwC5MoTWrivwEAu9opvQ
	(envelope-from <dmaengine+bounces-12074-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 07 Jul 2026 18:25:55 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE4371DD75
	for <lists+dmaengine@lfdr.de>; Tue, 07 Jul 2026 18:25:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=deltatee.com header.s=20200525 header.b=E0AbnEc5;
	dmarc=pass (policy=quarantine) header.from=deltatee.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12074-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12074-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3D794306D259
	for <lists+dmaengine@lfdr.de>; Tue,  7 Jul 2026 16:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082EA137750;
	Tue,  7 Jul 2026 16:21:12 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412B53B71CA
	for <dmaengine@vger.kernel.org>; Tue,  7 Jul 2026 16:21:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783441271; cv=none; b=CLx4QxmcM7qJNNCX6Dhv4UpkR25NYTu02ztr2V5GGsRi6eijrSyVvHp0SPehiRTZqQSMqGgvRZS9mJgpCTW3gtRA+TRymjxkq8quoFmATmEJwouSzqw0zYBU4nsoOyMCvGBsqx3s5T7bgU8dVwuHjCheYykYWj1RbwvOGyCQYVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783441271; c=relaxed/simple;
	bh=ts5315SZO2lFwKHbrG+faeDKUmlEwkuUnmhymjUqYlk=;
	h=From:To:Cc:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Subject; b=lev2NOAh+mcXQk4SLybZKoZTdfJdQpM9Y0HOsgWapllsLzkpDw86+lCrnpHEEWKGDJnB2FAhJ1MEnc/MkEtKIjf+KmpI+WTxzfeGaOzi1/fGe6yT52sZKnKVUjZZ0VhfAq4cxF88bClatt73qH9jyw3CUkSD/1MO44HL30KlTu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=E0AbnEc5; arc=none smtp.client-ip=204.191.154.188
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Cc:To:From:content-disposition;
	bh=pa1WxCKyk+GyNH7kCC/+DTbbe07rJ5RIShHGJNYROPA=; b=E0AbnEc5HkL8zmReXwLAIgg+es
	tSPiChughCpPcm8iNBF/jNyIfyFKNpI6bAwwIAdHgvPXxhZpciGLWcCWhOW6exPAulb67ejWlVi2/
	/DVZ/3p5GrzYTn+/G1MdVBueRDpraJwyYUZfOJNKKBm+qPPId3b5jXvVKgNMhrxnGIIm+YRzJE5mz
	YQLn5ysdL7IzO/00hznhq7QrxxiQJF005fZG7XjiRd2g+0fOY3cV74I07j4YLpmU+L8sJBtRybQgO
	+biyjami0vX2pPo2TlRr4J1CYh7lkm01ySkaUZySA4La7DC7yWY0ocWi5bJv+AAKIOXOSZkY7i9JM
	27cN4/oQ==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
	by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1wh8Xc-00000000nsy-36jn;
	Tue, 07 Jul 2026 10:21:03 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1wh8XR-000000006EG-2Vv2;
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
Date: Tue,  7 Jul 2026 10:20:44 -0600
Message-ID: <20260707162045.23910-5-logang@deltatee.com>
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
Subject: [PATCH v1 4/5] dmaengine: switchtec-dma: Add pmon sysfs attributes
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
	TAGGED_FROM(0.00)[bounces-12074-lists,dmaengine=lfdr.de];
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
X-Rspamd-Queue-Id: CFE4371DD75

Switchtec hardware exposes some performance monitor registers which
can be used to monitor various statistics of the hardware.

Expose these as a sysfs interface under the switchtec group in a
pmon sub-group.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/dma/switchtec_dma.c | 199 ++++++++++++++++++++++++++++++++++++
 1 file changed, 199 insertions(+)

diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
index 4841134bd7b8..2ac43eb58995 100644
--- a/drivers/dma/switchtec_dma.c
+++ b/drivers/dma/switchtec_dma.c
@@ -12,6 +12,7 @@
 #include <linux/pci.h>
 #include <linux/delay.h>
 #include <linux/iopoll.h>
+#include <linux/io-64-nonatomic-lo-hi.h>
 
 #include "dmaengine.h"
 
@@ -91,6 +92,12 @@ struct chan_hw_regs {
 #define SE_BUF_LEN_MASK		GENMASK_U32(20, 12)
 #define SE_THRESH_MASK		GENMASK_U32(31, 23)
 
+#define SWITCHTEC_LAT_SE_FETCH   BIT(0)
+#define SWITCHTEC_LAT_VDM        BIT(1)
+#define SWITCHTEC_LAT_RD_IMM     BIT(2)
+#define SWITCHTEC_LAT_FW_NP      BIT(3)
+#define SWITCHTEC_LAT_SE_PROCESS BIT(4)
+
 #define SWITCHTEC_CHAN_ENABLE	BIT(1)
 
 struct chan_fw_regs {
@@ -1156,8 +1163,200 @@ static struct attribute_group switchtec_config_group = {
 	.attrs = switchtec_config_attrs,
 };
 
+#define pmon_show(chan, page, field, reader) ({				     \
+	struct switchtec_dma_chan *__swdma_chan =			     \
+		container_of((chan), struct switchtec_dma_chan, dma_chan);   \
+	struct chan_fw_regs __iomem *__chan_fw = __swdma_chan->mmio_chan_fw; \
+	u64 __pmon_val = 0;						     \
+	int __pmon_ret = 0;						     \
+									     \
+	rcu_read_lock();						     \
+	if (!rcu_dereference(__swdma_chan->swdma_dev->pdev)) {		     \
+		__pmon_ret = -ENODEV;					     \
+	} else {							     \
+		__pmon_val = reader(&__chan_fw->field);			     \
+		__pmon_ret = sysfs_emit((page), "0x%llx\n", __pmon_val);     \
+	}								     \
+	rcu_read_unlock();						     \
+	__pmon_ret;							     \
+})
+
+static ssize_t se_count_show(struct dma_chan *chan, char *page)
+{
+	return pmon_show(chan, page, perf_fetched_se_cnt_lo, lo_hi_readq);
+}
+static struct dma_chan_sysfs_entry se_count_attr = __ATTR_RO(se_count);
+
+static ssize_t byte_count_show(struct dma_chan *chan, char *page)
+{
+	return pmon_show(chan, page, perf_byte_cnt_lo, lo_hi_readq);
+}
+static struct dma_chan_sysfs_entry byte_count_attr = __ATTR_RO(byte_count);
+
+static ssize_t se_pending_show(struct dma_chan *chan, char *page)
+{
+	return pmon_show(chan, page, perf_se_pending, readw);
+}
+static struct dma_chan_sysfs_entry se_pending_attr = __ATTR_RO(se_pending);
+
+static ssize_t se_buf_empty_show(struct dma_chan *chan, char *page)
+{
+	return pmon_show(chan, page, perf_se_buf_empty, readw);
+}
+static struct dma_chan_sysfs_entry se_buf_empty_attr = __ATTR_RO(se_buf_empty);
+
+static ssize_t chan_idle_show(struct dma_chan *chan, char *page)
+{
+	return pmon_show(chan, page, perf_chan_idle, readl);
+}
+static struct dma_chan_sysfs_entry chan_idle_attr = __ATTR_RO(chan_idle);
+
+static ssize_t latency_max_show(struct dma_chan *chan, char *page)
+{
+	return pmon_show(chan, page, perf_lat_max, readl);
+}
+static struct dma_chan_sysfs_entry latency_max_attr = __ATTR_RO(latency_max);
+
+static ssize_t latency_min_show(struct dma_chan *chan, char *page)
+{
+	return pmon_show(chan, page, perf_lat_min, readl);
+}
+static struct dma_chan_sysfs_entry latency_min_attr = __ATTR_RO(latency_min);
+
+static ssize_t latency_last_show(struct dma_chan *chan, char *page)
+{
+	return pmon_show(chan, page, perf_lat_last, readl);
+}
+static struct dma_chan_sysfs_entry latency_last_attr = __ATTR_RO(latency_last);
+
+static ssize_t latency_selector_show(struct dma_chan *chan, char *page)
+{
+	struct switchtec_dma_chan *swdma_chan =
+		container_of(chan, struct switchtec_dma_chan, dma_chan);
+	struct chan_fw_regs __iomem *chan_fw = swdma_chan->mmio_chan_fw;
+	u32 lat = 0;
+
+	rcu_read_lock();
+	if (!rcu_dereference(swdma_chan->swdma_dev->pdev)) {
+		rcu_read_unlock();
+		return -ENODEV;
+	}
+
+	lat = readl(&chan_fw->perf_latency_selector);
+	rcu_read_unlock();
+
+	strcat(page, "To select a latency type, write the type number (1 ~ 5) to latency_selector\n\n");
+
+	strcat(page, "Latency Types:\n");
+	strcat(page, "(1) SE Fetch latency");
+	if (lat & SWITCHTEC_LAT_SE_FETCH)
+		strcat(page, " (*)\n");
+	else
+		strcat(page, "\n");
+
+	strcat(page, "(2) VDM latency");
+	if (lat & SWITCHTEC_LAT_VDM)
+		strcat(page, " (*)\n");
+	else
+		strcat(page, "\n");
+
+	strcat(page, "(3) Read Immediate latency");
+	if (lat & SWITCHTEC_LAT_RD_IMM)
+		strcat(page, " (*)\n");
+	else
+		strcat(page, "\n");
+
+	strcat(page, "(4) SE Processing latency");
+	if (lat & SWITCHTEC_LAT_SE_PROCESS)
+		strcat(page, " (*)\n");
+	else
+		strcat(page, "\n");
+
+	strcat(page, "(5) FW NP TLP latency");
+	if (lat & SWITCHTEC_LAT_FW_NP)
+		strcat(page, " (*)\n");
+	else
+		strcat(page, "\n");
+
+	strcat(page, "\n");
+
+	return strlen(page);
+}
+
+static ssize_t latency_selector_store(struct dma_chan *chan, const char *page,
+				      size_t count)
+{
+	struct switchtec_dma_chan *swdma_chan =
+		container_of(chan, struct switchtec_dma_chan, dma_chan);
+	struct chan_fw_regs __iomem *chan_fw = swdma_chan->mmio_chan_fw;
+	ssize_t ret = count;
+	int lat_type;
+
+	if (kstrtoint(page, 0, &lat_type) < 0)
+		return -EINVAL;
+
+	switch (lat_type) {
+	case 1:
+		lat_type = SWITCHTEC_LAT_SE_FETCH;
+		break;
+	case 2:
+		lat_type = SWITCHTEC_LAT_VDM;
+		break;
+	case 3:
+		lat_type = SWITCHTEC_LAT_RD_IMM;
+		break;
+	case 4:
+		lat_type = SWITCHTEC_LAT_SE_PROCESS;
+		break;
+	case 5:
+		lat_type = SWITCHTEC_LAT_FW_NP;
+		break;
+	default:
+		return -EINVAL;
+	};
+
+	rcu_read_lock();
+	if (!rcu_dereference(swdma_chan->swdma_dev->pdev)) {
+		ret = -ENODEV;
+		goto err_unlock;
+	}
+
+	if (chan->client_count) {
+		ret = -EBUSY;
+		goto err_unlock;
+	}
+
+	writel(lat_type, &chan_fw->perf_latency_selector);
+
+err_unlock:
+	rcu_read_unlock();
+
+	return ret;
+}
+static struct dma_chan_sysfs_entry
+latency_selector_attr = __ATTR_RW(latency_selector);
+
+static struct attribute *switchtec_pmon_attrs[] = {
+	&se_count_attr.attr,
+	&byte_count_attr.attr,
+	&se_pending_attr.attr,
+	&se_buf_empty_attr.attr,
+	&chan_idle_attr.attr,
+	&latency_max_attr.attr,
+	&latency_min_attr.attr,
+	&latency_last_attr.attr,
+	&latency_selector_attr.attr,
+	NULL,
+};
+
+static struct attribute_group switchtec_pmon_group = {
+	.name = "pmon",
+	.attrs = switchtec_pmon_attrs,
+};
+
 static const struct attribute_group *switchtec_groups[] = {
 	&switchtec_config_group,
+	&switchtec_pmon_group,
 	NULL,
 };
 
-- 
2.47.3


