Return-Path: <dmaengine+bounces-8489-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOiKGrRCd2mMdQEAu9opvQ
	(envelope-from <dmaengine+bounces-8489-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 26 Jan 2026 11:32:20 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4792B86FD1
	for <lists+dmaengine@lfdr.de>; Mon, 26 Jan 2026 11:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CC33F30041E4
	for <lists+dmaengine@lfdr.de>; Mon, 26 Jan 2026 10:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D97D331217;
	Mon, 26 Jan 2026 10:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="CGQQtia/"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246B63126C0
	for <dmaengine@vger.kernel.org>; Mon, 26 Jan 2026 10:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769423528; cv=none; b=Lsc1+OD+6VrzsKoPREveICp+skD0B9xQE6RGw8VCK6ys4kVGT644N6xAIPwz04zetzqc9rtXt5dHxlm1BHt1Spb0Q4Zhqh0Uv44gtfioP2x46IX/l3tVn6NCL21eEArdQZCogIdX9dWhGc3HK4w9FeOP8EdqO+9erhERnwxUo28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769423528; c=relaxed/simple;
	bh=wTSw5rrByeywpyx4b28b6t68newYvzHr0oIdTZgnlTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zh4cghQNg8Gps8WpTie66g/AvIg1uTdsXKD0xGKWgOfYYyGvkYw4YI/fZsJOS8EW7RCe+fHKJXelv1GOZMhgZd8wxjm9n2rN9iQYqJgCkOgZpoOVY5NSlzYgFJNmcTIIs8m3hdM3AOxGwvixTZG2JDj4XhADfzlfDAv5fVE+cpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=CGQQtia/; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42fbbc3df8fso2642567f8f.2
        for <dmaengine@vger.kernel.org>; Mon, 26 Jan 2026 02:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1769423524; x=1770028324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=28LJKOzZr0ga3QymY5qs2v0wCcRNeHJMj2ha9kW7dhM=;
        b=CGQQtia/yGqo1RzFvOAcEJ0DGUf1TSVm/seO+wYRE1X/fXwDJ1GQZv+B7YkUZeaCtZ
         RyXG1R7457kAFOnZjNti1M9b5ZGCCJ3smcOlNhzpLUuwgcW8fj6yyU8ZipBHXlz+RndZ
         Idx52vFSCVDIsqUxQq4iW9062c7QyZgMl+nIe6EWxP58fnl+syUTB3v9KvK/ic8ZMY57
         Je1P7TfymdMnPTTmpyxHbAfXc7uRjX92zoMFmWeonrlYdLCsyZ6/FxkXAHgLINcGNhAa
         ac0TeTRFfzXVGEm61KFUMRf0q0WLh+RS6cuAp2Jj5hbt7S2jvMoRXCCALuU2Ps2Mm5WO
         J7hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769423524; x=1770028324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=28LJKOzZr0ga3QymY5qs2v0wCcRNeHJMj2ha9kW7dhM=;
        b=YlgSOCPvDRXAVbYyh8wK/NBIZzy/mlHDlZ216owLZt/oCSVgcOiBfoNcc6ttGzU/sW
         YNsQn0EAhgtQKP4Kn/grRHhryzg1wshQFVc3ML7nAe0JVMliwiHAxpuUPpIcn2wbEqtO
         cy4SiTmtVA1QFjzFG+aWQB+Q4RRJ5RlNwNpXKCz4+L9ldYJgl0dzDcUeoSrB65utkOEG
         aX9/7pKbmgtLYvY57nW0tWcEMLikZJMa/zBjRfASnL/MUn5/8D5RgOBmM5iTgXx1RGm0
         M1cFpLUK9I5QiMO353o6658mnDmgr3TkfE8IXW6W65iD4n4s0QVbNz2vc1c1ZsCHVzf5
         1qqg==
X-Forwarded-Encrypted: i=1; AJvYcCUYQDFkWwc1iypne+nordhyxOFCbhMShIQEB7nKcF5RRjPk9P3aQHWtjRUBh69kzNO9LiV+VOAmYrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJVLWgrRSHh4CWcPc/qO78V1TMtWw5kEAlH4/bXJzjeGBwu6B7
	PHsln6FYY5Md/LgCL+ZbBdYDdUkomQfTR2xbATnnMrtpdo3ym7I66KWktyYYKDl4vb0=
X-Gm-Gg: AZuq6aKuxmNLgA33fKhhb6hguRLk4JgqaWmS+ES9F2RRxooHBoaq70ruZfrAkztooH6
	QqU5bzwtlKYxU/ntPb++knxLI2lpaZqTw6J0SHWDeBy5kW9A3qVC3zV5gh8VA/cCC+01y97Fr8V
	q2kJuPXmOCECV1Bx0NmXtcJqMqr9T6efQQnpyXcr3LbBulVdLo/Nf66b6zhBjLe6ifgw93NplpO
	x/nGywN8NeC18siiakzQ10VeSJIj/yRjXrgcnc2ZzD79fo2G31HGwqHvXeqClQWL1blBZU/0JEY
	MW/Lrzd+TCPKpNDAU2wV14aC6yaPzUNU3RnD2QDqYgc6KD4SjgsQ49dRME0lgzSgnNQm6ZEZd9Q
	s9x9v7PsREJlAvm4NmZXOIFCV0R3O6NDjn3+3OvDxv4DBxU7SY0fG3kY360vuSLdoLFII6gUUAB
	IMHB3DtQ467LCMgGI6G8X1XFHA6Udwf8vR4JtUyXQ=
X-Received: by 2002:a5d:5850:0:b0:435:a258:76e with SMTP id ffacd0b85a97d-435ca3a93d0mr6619369f8f.60.1769423524419;
        Mon, 26 Jan 2026 02:32:04 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1c246ecsm29715049f8f.10.2026.01.26.02.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 02:32:04 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: vkoul@kernel.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	p.zabel@pengutronix.de,
	geert+renesas@glider.be,
	fabrizio.castro.jz@renesas.com
Cc: claudiu.beznea@tuxon.dev,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 2/7] dmaengine: sh: rz-dmac: Add pause status bit
Date: Mon, 26 Jan 2026 12:31:50 +0200
Message-ID: <20260126103155.2644586-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260126103155.2644586-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260126103155.2644586-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[tuxon.dev:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8489-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[tuxon.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,bp.renesas.com,gmail.com,perex.cz,suse.com,pengutronix.de,glider.be,renesas.com];
	DKIM_TRACE(0.00)[tuxon.dev:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@tuxon.dev,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tuxon.dev:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4792B86FD1
X-Rspamd-Action: no action

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Add the RZ_DMAC_CHAN_STATUS_PAUSED status bit index. This is needed to
implement suspend to RAM support for cyclic DMA channels, which will be
added in subsequent commits.

The pause and resume implementations are updated to reuse the code added
for suspend to RAM handling. Since the pause state is now stored in a
per-channel software cache, there is no longer a need to interrogate the
hardware registers in the pause path. Using the software status cache
simplifies the implementation. The resume code was updated to use the
software status cache as well.

This is a preparatory commit for cyclic DMA suspend to RAM support.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 68 ++++++++++++++++++++++++++++++----------
 1 file changed, 52 insertions(+), 16 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 95ed357f2b74..8d8391a5b3a7 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -18,6 +18,7 @@
 #include <linux/irqchip/irq-renesas-rzv2h.h>
 #include <linux/irqchip/irq-renesas-rzt2h.h>
 #include <linux/list.h>
+#include <linux/lockdep.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_dma.h>
@@ -65,9 +66,11 @@ struct rz_dmac_desc {
 /**
  * enum rz_dmac_chan_status: RZ DMAC channel status
  * @RZ_DMAC_CHAN_STATUS_ENABLED: Channel is enabled
+ * @RZ_DMAC_CHAN_STATUS_PAUSED: Channel is paused though DMA engine callbacks
  */
 enum rz_dmac_chan_status {
 	RZ_DMAC_CHAN_STATUS_ENABLED,
+	RZ_DMAC_CHAN_STATUS_PAUSED,
 };
 
 struct rz_dmac_chan {
@@ -833,12 +836,9 @@ static enum dma_status rz_dmac_tx_status(struct dma_chan *chan,
 		return status;
 
 	scoped_guard(spinlock_irqsave, &channel->vc.lock) {
-		u32 val;
-
 		residue = rz_dmac_chan_get_residue(channel, cookie);
 
-		val = rz_dmac_ch_readl(channel, CHSTAT, 1);
-		if (val & CHSTAT_SUS)
+		if (channel->status & BIT(RZ_DMAC_CHAN_STATUS_PAUSED))
 			status = DMA_PAUSED;
 	}
 
@@ -851,35 +851,71 @@ static enum dma_status rz_dmac_tx_status(struct dma_chan *chan,
 	return status;
 }
 
-static int rz_dmac_device_pause(struct dma_chan *chan)
+static int rz_dmac_device_pause_set(struct rz_dmac_chan *channel,
+				    enum rz_dmac_chan_status status)
 {
-	struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
 	u32 val;
+	int ret;
 
-	guard(spinlock_irqsave)(&channel->vc.lock);
+	lockdep_assert_held(&channel->vc.lock);
 
 	if (!(channel->status & BIT(RZ_DMAC_CHAN_STATUS_ENABLED)))
 		return 0;
 
 	rz_dmac_ch_writel(channel, CHCTRL_SETSUS, CHCTRL, 1);
-	return read_poll_timeout_atomic(rz_dmac_ch_readl, val,
-					(val & CHSTAT_SUS), 1, 1024,
-					false, channel, CHSTAT, 1);
+	ret = read_poll_timeout_atomic(rz_dmac_ch_readl, val,
+				       (val & CHSTAT_SUS), 1, 1024, false,
+				       channel, CHSTAT, 1);
+	if (ret)
+		return ret;
+
+	channel->status |= BIT(status);
+
+	return 0;
 }
 
-static int rz_dmac_device_resume(struct dma_chan *chan)
+static int rz_dmac_device_pause(struct dma_chan *chan)
 {
 	struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
-	u32 val;
 
 	guard(spinlock_irqsave)(&channel->vc.lock);
 
-	/* Do not check CHSTAT_SUS but rely on HW capabilities. */
+	if (channel->status & BIT(RZ_DMAC_CHAN_STATUS_PAUSED))
+		return 0;
+
+	return rz_dmac_device_pause_set(channel, RZ_DMAC_CHAN_STATUS_PAUSED);
+}
+
+static int rz_dmac_device_resume_set(struct rz_dmac_chan *channel,
+				     enum rz_dmac_chan_status status)
+{
+	u32 val;
+	int ret;
+
+	lockdep_assert_held(&channel->vc.lock);
+
+	if (!(channel->status & BIT(RZ_DMAC_CHAN_STATUS_PAUSED)))
+		return 0;
 
 	rz_dmac_ch_writel(channel, CHCTRL_CLRSUS, CHCTRL, 1);
-	return read_poll_timeout_atomic(rz_dmac_ch_readl, val,
-					!(val & CHSTAT_SUS), 1, 1024,
-					false, channel, CHSTAT, 1);
+	ret = read_poll_timeout_atomic(rz_dmac_ch_readl, val,
+				       !(val & CHSTAT_SUS), 1, 1024, false,
+				       channel, CHSTAT, 1);
+	if (ret)
+		return ret;
+
+	channel->status &= ~BIT(status);
+
+	return 0;
+}
+
+static int rz_dmac_device_resume(struct dma_chan *chan)
+{
+	struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
+
+	guard(spinlock_irqsave)(&channel->vc.lock);
+
+	return rz_dmac_device_resume_set(channel, RZ_DMAC_CHAN_STATUS_PAUSED);
 }
 
 /*
-- 
2.43.0


