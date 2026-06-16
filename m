Return-Path: <dmaengine+bounces-11555-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QLl6GARwMWo5jQUAu9opvQ
	(envelope-from <dmaengine+bounces-11555-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 16 Jun 2026 17:47:16 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E2B69161F
	for <lists+dmaengine@lfdr.de>; Tue, 16 Jun 2026 17:47:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=HsZYz83h;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11555-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-11555-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CE51F3039881
	for <lists+dmaengine@lfdr.de>; Tue, 16 Jun 2026 15:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C834611CF;
	Tue, 16 Jun 2026 15:39:53 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DF94611C1;
	Tue, 16 Jun 2026 15:39:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781624393; cv=none; b=rBHwq9ov+FoiSo7qNR8r1938DnxfLsR53wOoqvnlq4TL8fW49Hp8kaphsmh7to0HQZ8/Hp3OT4CvXfsBXWJRLZ43cTC/fRbJ07Enu7nhiLjlE5Dhq6VJNkAkhscOUFWjZQZD5ShF0pz+bjEdKk5hmzFrl67GfBE3K4QaDm9yuMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781624393; c=relaxed/simple;
	bh=oQq3yLuyHGjLa0GJ346W7tMuWSX4yq2K+HhZggGzkAk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HEYdKGoLsFm330KOQOMsEcKdveqAxNvCl2130HVfNU4Ej+vqMO612o5U0PcbUYADmegg2vO96e0O4BXyztFb5LzVUGVsJutf82ln2vIFAN6mccTTh9S0x7hMT+RE4JY/47NpJaXTpsH1GXm0RPoozayUfa8RfUcyfE+Xs8iqSKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HsZYz83h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3B35BC4AF0F;
	Tue, 16 Jun 2026 15:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781624393;
	bh=oQq3yLuyHGjLa0GJ346W7tMuWSX4yq2K+HhZggGzkAk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=HsZYz83hZhomdTI4kWBdepJKb5rxQ1UFC5fcazRHKEwxVLAINMptjQUQIwM/VOlAd
	 lHh2pPr4Tw5a9dx6PlHpA4Wf1Kt/ZOjMG87H2dfTUOToBk7YKhYE25yE1UZHfbATDR
	 OApDAGSRIzGwAHG9zPpWYlvC4mQu0Y+bysjYYXTxzetz9ACa9pAh1eDvqObhL7vAel
	 FEYvVwbK3II2BgoAtBAxrXRP7oiROU3lAy2eNNbX7QpOMfFQC1rNH/bcabh91GCOXy
	 CgsTNw4cpih4Hi3QSwfv0HCyOME1ekmHZy0rn2TsA+xiUrslwnMWR1HSVjfRXCdUoa
	 Bjb75C9X6TS8A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2586DCD98E1;
	Tue, 16 Jun 2026 15:39:53 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 16 Jun 2026 16:40:52 +0100
Subject: [PATCH RFC 1/3] dmaengine: Support address bus widths of 32 bytes
 and above
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260616-dmaengine-support-wider-dma-masks-v1-1-da23a8dcb756@analog.com>
References: <20260616-dmaengine-support-wider-dma-masks-v1-0-da23a8dcb756@analog.com>
In-Reply-To: <20260616-dmaengine-support-wider-dma-masks-v1-0-da23a8dcb756@analog.com>
To: dmaengine@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781624455; l=6136;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=seK2wQ1gP5/CY+c6SdU0DSHpgs7+1OD32PnCpLFnNMU=;
 b=VaSoQ22ie0zIfavrrNdBnJAYVMaoPhET+P1sK1CJcaHwofsEfWskGzpE1WIYXko/2LjABb4Bg
 9RDlOcrGB3sC+T4i94u/b9UbtFuta4UtWqxEHLuYX8weyX0HFdrgZQA
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11555-lists,dmaengine=lfdr.de,nuno.sa.analog.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dmaengine@vger.kernel.org,m:linux-iio@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:lars@metafoo.de,m:jic23@kernel.org,m:dlechner@baylibre.com,m:andy@kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[devnull@kernel.org,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[nuno.sa@analog.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,analog.com:replyto,analog.com:email,analog.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 21E2B69161F

From: Nuno Sá <nuno.sa@analog.com>

The src_addr_widths and dst_addr_widths capability masks encode each
supported width as a bit whose position equals the corresponding
enum dma_slave_buswidth value (e.g. DMA_SLAVE_BUSWIDTH_4_BYTES sets
bit 4). As these masks are plain u32, widths of 32 bytes and above
(DMA_SLAVE_BUSWIDTH_32/64/128_BYTES map to bits 32, 64 and 128) cannot
be represented at all.

Introduce bitmap-based masks that span the full enum range. To allow
controllers and consumers to be converted incrementally, the legacy
u32 fields are kept alongside the new bitmaps: producers populate the
bitmap (mirroring the low 32 bits back into the legacy field) and
dma_get_slave_caps() folds a legacy-only producer's u32 into the
returned bitmap.

Add dma_set_{src,dst}_addr_mask() for producers and
dma_slave_caps_get_{src,dst}_width_min() for consumers so that, once
every user is converted, the legacy u32 fields can be dropped and the
bitmaps renamed without further churn.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/dma/dmaengine.c   |  18 +++++++++
 include/linux/dmaengine.h | 100 ++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 114 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 9049171df857..a21bc9c140aa 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -593,7 +593,25 @@ int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps)
 		return -ENXIO;
 
 	caps->src_addr_widths = device->src_addr_widths;
+	if (bitmap_empty(device->src_addr_widths_mask, DMA_SLAVE_BUSWIDTH_MAX)) {
+		bitmap_zero(caps->src_addr_widths_mask, DMA_SLAVE_BUSWIDTH_MAX);
+		bitmap_from_arr32(caps->src_addr_widths_mask,
+				  &device->src_addr_widths, 32);
+	} else {
+		bitmap_copy(caps->src_addr_widths_mask,
+			    device->src_addr_widths_mask, DMA_SLAVE_BUSWIDTH_MAX);
+	}
+
 	caps->dst_addr_widths = device->dst_addr_widths;
+	if (bitmap_empty(device->dst_addr_widths_mask, DMA_SLAVE_BUSWIDTH_MAX)) {
+		bitmap_zero(caps->dst_addr_widths_mask, DMA_SLAVE_BUSWIDTH_MAX);
+		bitmap_from_arr32(caps->dst_addr_widths_mask,
+				  &device->dst_addr_widths, 32);
+	} else {
+		bitmap_copy(caps->dst_addr_widths_mask,
+			    device->dst_addr_widths_mask, DMA_SLAVE_BUSWIDTH_MAX);
+	}
+
 	caps->directions = device->directions;
 	caps->min_burst = device->min_burst;
 	caps->max_burst = device->max_burst;
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index b3d251c9734e..e249158aa4a5 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -5,6 +5,7 @@
 #ifndef LINUX_DMAENGINE_H
 #define LINUX_DMAENGINE_H
 
+#include <linux/bitops.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/uio.h>
@@ -391,6 +392,7 @@ enum dma_slave_buswidth {
 	DMA_SLAVE_BUSWIDTH_32_BYTES = 32,
 	DMA_SLAVE_BUSWIDTH_64_BYTES = 64,
 	DMA_SLAVE_BUSWIDTH_128_BYTES = 128,
+	DMA_SLAVE_BUSWIDTH_MAX
 };
 
 /**
@@ -509,8 +511,14 @@ enum dma_residue_granularity {
  * resubmitted multiple times
  */
 struct dma_slave_caps {
-	u32 src_addr_widths;
-	u32 dst_addr_widths;
+	struct {
+		DECLARE_BITMAP(src_addr_widths_mask, DMA_SLAVE_BUSWIDTH_MAX);
+		u32 src_addr_widths;
+	};
+	struct {
+		DECLARE_BITMAP(dst_addr_widths_mask, DMA_SLAVE_BUSWIDTH_MAX);
+		u32 dst_addr_widths;
+	};
 	u32 directions;
 	u32 min_burst;
 	u32 max_burst;
@@ -887,8 +895,14 @@ struct dma_device {
 	struct module *owner;
 	struct ida chan_ida;
 
-	u32 src_addr_widths;
-	u32 dst_addr_widths;
+	struct {
+		DECLARE_BITMAP(src_addr_widths_mask, DMA_SLAVE_BUSWIDTH_MAX);
+		u32 src_addr_widths;
+	};
+	struct {
+		DECLARE_BITMAP(dst_addr_widths_mask, DMA_SLAVE_BUSWIDTH_MAX);
+		u32 dst_addr_widths;
+	};
 	u32 directions;
 	u32 min_burst;
 	u32 max_burst;
@@ -1678,4 +1692,82 @@ static inline struct device *dmaengine_get_dma_device(struct dma_chan *chan)
 	return chan->device->dev;
 }
 
+static inline enum dma_slave_buswidth
+__dma_slave_caps_get_width_min(const unsigned long *bitmask)
+{
+	enum dma_slave_buswidth width = find_first_bit(bitmask,
+						       DMA_SLAVE_BUSWIDTH_MAX);
+
+	if (width == DMA_SLAVE_BUSWIDTH_MAX)
+		return DMA_SLAVE_BUSWIDTH_UNDEFINED;
+
+	return width;
+}
+
+static inline enum dma_slave_buswidth
+dma_slave_caps_get_src_width_min(const struct dma_slave_caps *caps)
+{
+	return __dma_slave_caps_get_width_min(caps->src_addr_widths_mask);
+}
+
+static inline enum dma_slave_buswidth
+dma_slave_caps_get_dst_width_min(const struct dma_slave_caps *caps)
+{
+	return __dma_slave_caps_get_width_min(caps->dst_addr_widths_mask);
+}
+
+static inline int __dma_set_addr_mask(unsigned long *bitmask,
+				      enum dma_slave_buswidth *widths,
+				      unsigned int n_widths)
+{
+	for (unsigned int i = 0; i < n_widths; i++) {
+		switch (widths[i]) {
+		case DMA_SLAVE_BUSWIDTH_1_BYTE:
+		case DMA_SLAVE_BUSWIDTH_2_BYTES:
+		case DMA_SLAVE_BUSWIDTH_3_BYTES:
+		case DMA_SLAVE_BUSWIDTH_4_BYTES:
+		case DMA_SLAVE_BUSWIDTH_8_BYTES:
+		case DMA_SLAVE_BUSWIDTH_16_BYTES:
+		case DMA_SLAVE_BUSWIDTH_32_BYTES:
+		case DMA_SLAVE_BUSWIDTH_64_BYTES:
+		case DMA_SLAVE_BUSWIDTH_128_BYTES:
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		__set_bit(widths[i], bitmask);
+	}
+
+	return 0;
+}
+
+static inline int dma_set_src_addr_mask(struct dma_device *device,
+					enum dma_slave_buswidth *widths,
+					unsigned int n_widths)
+{
+	int ret;
+
+	ret = __dma_set_addr_mask(device->src_addr_widths_mask, widths, n_widths);
+	if (ret)
+		return ret;
+
+	device->src_addr_widths = bitmap_read(device->src_addr_widths_mask, 0, 32);
+	return 0;
+}
+
+static inline int dma_set_dst_addr_mask(struct dma_device *device,
+					enum dma_slave_buswidth *widths,
+					unsigned int n_widths)
+{
+	int ret;
+
+	ret = __dma_set_addr_mask(device->dst_addr_widths_mask, widths, n_widths);
+	if (ret)
+		return ret;
+
+	device->dst_addr_widths = bitmap_read(device->dst_addr_widths_mask, 0, 32);
+	return 0;
+}
+
 #endif /* DMAENGINE_H */

-- 
2.54.0



