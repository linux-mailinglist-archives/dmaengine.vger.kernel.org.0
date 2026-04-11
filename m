Return-Path: <dmaengine+bounces-9990-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFysGDo12ml9zAgAu9opvQ
	(envelope-from <dmaengine+bounces-9990-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 11 Apr 2026 13:49:14 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6523DF9B0
	for <lists+dmaengine@lfdr.de>; Sat, 11 Apr 2026 13:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3E5CF30A241A
	for <lists+dmaengine@lfdr.de>; Sat, 11 Apr 2026 11:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B1A35838B;
	Sat, 11 Apr 2026 11:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="LRqrgw8o"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A1234D3BE
	for <dmaengine@vger.kernel.org>; Sat, 11 Apr 2026 11:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775907811; cv=none; b=DsfFKwXZJfmV1B3m8vkIC37PNfk4KphdK5p7UDi0KV47P7zN+8N9MOsUJyubfxj2EquU8B9eq290T1yRxoCflh35vtIEej+7s+w4LCtxxnLh73BHYWN2v0jvBdno3SwkU2jhp5/FwihMyjiGwiyfDo0BXZ6arSK6DAijVc66jBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775907811; c=relaxed/simple;
	bh=iQawvjhzIGXmzEbrFF8bHIYm/8QPf/NESexbbH0n3Ow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=muzW/5f5Usv2Vlbj968cNBzZ5Is90fsncAjaZAFXgbxm3LpFpvECDIU5DnJdqxlLNfuILY5IlwXVbrDrHo88ri5hhBdlD+4+zAB6fz/uGE9ErIgdJIkx60wUJZeXuvn90ZpolWCLn2cPp/h84cZl5M+lw/OC4fCvsjp48MHnNQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=LRqrgw8o; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488a8ca4aadso33200625e9.3
        for <dmaengine@vger.kernel.org>; Sat, 11 Apr 2026 04:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1775907807; x=1776512607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IUGFjnyw33YmgBsDPw6KMQ7GHcl3buE/kN68Vb3dY6k=;
        b=LRqrgw8ouf09WxyIcw8weWyhkZ2lqt34blgmZmyUXukcWMGTcn8tgwcIYiZUkia1q4
         NFrKy6IhbTY1m17AykVE2+1edcVdU+JOCwi9mO3u4o8mAIN5f8UZ/Dp2bx+ZsNOA1eYu
         36pApcDvNhRn0ekxQzGNvxZEwmhFnXkjQCPGsXdQ1NLsrNbikjoCOtUSTQ2bD1UJ/G4P
         /1bcrHU1IhCQb2n2OCauhbQxN5MVS9Qe8kJPXaSw7mAIkvdONtExMw+o3q/ug87nMN55
         tW6xJCSTwlTIwsvqiZdPIpmIRT969ApU96Ti7dyz10NlTspqsbFU/ijeFKRelyDAXQwS
         /Ixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775907807; x=1776512607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IUGFjnyw33YmgBsDPw6KMQ7GHcl3buE/kN68Vb3dY6k=;
        b=AXpTyqrnZKkjX/KYDqd04Cm/z/XxomoaZN14UDq81ctiAScCbEfXa+juCTwntLVoum
         ErMdi2rM1uLVQjY+pUMWc+gl9r0eIjKtEf6se7MYfPTZFKKBRql0Lu3ChMdeIzTbW6RB
         0M749VBcDes01xYv8gH9DhXDUVHpONWijQ30oMhTdb7Nt6EFDWG5CJJkJDdjgXHTZSf8
         1qDcXZ9f4hTJltClRIID88yUM1PliWLrdi71wMcoaJ6aE+Kq8+aECEcPWAeelcJcMlhk
         ha9lXZYkuaBBwbOhiJamObXxDEqinoqAah5eFQ1B0egl0METx6qGxwvnCk4CZouyHi2k
         tZAA==
X-Forwarded-Encrypted: i=1; AJvYcCV43OS5sYo2pH6fwIkQUN+Q6kHJbyk4B+XhH3i4TXrqvW2/0RqAD664nF1ZBVbvqxg5Zdb0gLH5YGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxTGAEHYDOg20CVLlCDF1KJ23foOoADBt82VhNI1dJXCn+uvkQ
	8eITBR8dq2dvaszJS0uSiFL3Y2Y855BCjvOiU2Af3Cx14U9hwd9U64YG4xn1SFevF6k=
X-Gm-Gg: AeBDiesJkQqy3kG2Qly0zzPqSgWSJMDM7k6edrXj7f9H4uooq1EJaC0v8v6ouhnOPaD
	W29gghusjKk/rj3LWO0Qi6AdqMK8izFL7jnf1xW5GXBNmsfDb+V7GnOoBluxSTovGzsGtIdSLj2
	E78ztSzKDvy5u9yY1Prwg8JWOAw2XEGGzFFFm1240v6DylDkAwMANfS+1bzkkSiK2oys1YUkUOP
	Umo7oD4hCqzmEn268aHX/0MvsGbGPOg/ad/Rywo+D4BsuAi8r51lR/vxOQqOO5ne4uSYx9CVNB4
	DedO7OXZoLFWGGlN+pNnsRPsjvoj2XbZ3FVgJngPyQL+93qeEe9MXfYItNQKM403LQYr/KVVJI1
	0TVE08v4+mLiU2Vx7Vv5xKsmY6biE0h4+Nwsd1fWvcWIxzmDcA2xphTf1rUyZ/ZCgTOx+VOvypv
	zT0yqFEnyMyp7UG/DmCNDDR5xHKhCklQwdbqlsa9qhpwJW7cexEXoU
X-Received: by 2002:a05:6000:24c2:b0:43c:f90b:5668 with SMTP id ffacd0b85a97d-43d642a7a6dmr9677284f8f.23.1775907806737;
        Sat, 11 Apr 2026 04:43:26 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e5c981sm15776447f8f.33.2026.04.11.04.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 04:43:26 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: vkoul@kernel.org,
	Frank.Li@kernel.org,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	p.zabel@pengutronix.de,
	geert+renesas@glider.be,
	fabrizio.castro.jz@renesas.com,
	long.luu.ur@renesas.com
Cc: claudiu.beznea@tuxon.dev,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v4 11/17] dmaengine: sh: rz-dmac: Refactor pause/resume code
Date: Sat, 11 Apr 2026 14:42:57 +0300
Message-ID: <20260411114303.2814115-12-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260411114303.2814115-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260411114303.2814115-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[tuxon.dev:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9990-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[tuxon.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,perex.cz,suse.com,bp.renesas.com,pengutronix.de,glider.be,renesas.com];
	DKIM_TRACE(0.00)[tuxon.dev:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@tuxon.dev,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[renesas.com:email,bp.renesas.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,tuxon.dev:dkim]
X-Rspamd-Queue-Id: CF6523DF9B0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Subsequent patches will add suspend/resume and cyclic DMA support to the
rz-dmac driver. This support needs to work on SoCs where power to most
components (including DMA) is turned off during system suspend. For this,
some channels (for example cyclic ones) may need to be paused and resumed
manually by the DMA driver during system suspend/resume.

Refactor the pause/resume support so the same code can be reused in the
system suspend/resume path.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v4:
- reset channel->status in rz_dmac_free_chan_resources() and
  rz_dmac_terminate_all()

Changes in v3:
- none, this patch new new

 drivers/dma/sh/rz-dmac.c | 73 ++++++++++++++++++++++++++++++++++------
 1 file changed, 62 insertions(+), 11 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 04eb1a7f1e62..d009b7607d44 100644
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
@@ -63,6 +64,14 @@ struct rz_dmac_desc {
 
 #define to_rz_dmac_desc(d)	container_of(d, struct rz_dmac_desc, vd)
 
+/**
+ * enum rz_dmac_chan_status: RZ DMAC channel status
+ * @RZ_DMAC_CHAN_STATUS_PAUSED: Channel is paused though DMA engine callbacks
+ */
+enum rz_dmac_chan_status {
+	RZ_DMAC_CHAN_STATUS_PAUSED,
+};
+
 struct rz_dmac_chan {
 	struct virt_dma_chan vc;
 	void __iomem *ch_base;
@@ -74,6 +83,8 @@ struct rz_dmac_chan {
 	dma_addr_t src_per_address;
 	dma_addr_t dst_per_address;
 
+	unsigned long status;
+
 	u32 chcfg;
 	u32 chctrl;
 	int mid_rid;
@@ -491,6 +502,8 @@ static void rz_dmac_free_chan_resources(struct dma_chan *chan)
 		channel->mid_rid = -EINVAL;
 	}
 
+	channel->status = 0;
+
 	spin_unlock_irqrestore(&channel->vc.lock, flags);
 
 	vchan_free_chan_resources(&channel->vc);
@@ -589,6 +602,9 @@ static int rz_dmac_terminate_all(struct dma_chan *chan)
 	}
 
 	vchan_get_all_descriptors(&channel->vc, &head);
+
+	channel->status = 0;
+
 	spin_unlock_irqrestore(&channel->vc.lock, flags);
 	vchan_dma_desc_free_list(&channel->vc, &head);
 
@@ -795,35 +811,70 @@ static enum dma_status rz_dmac_tx_status(struct dma_chan *chan,
 	return status;
 }
 
-static int rz_dmac_device_pause(struct dma_chan *chan)
+static int rz_dmac_device_pause_set(struct rz_dmac_chan *channel,
+				    unsigned long set_bitmask)
 {
-	struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
+	int ret = 0;
 	u32 val;
 
-	guard(spinlock_irqsave)(&channel->vc.lock);
+	lockdep_assert_held(&channel->vc.lock);
 
 	if (!rz_dmac_chan_is_enabled(channel))
 		return 0;
 
+	if (rz_dmac_chan_is_paused(channel))
+		goto set_bit;
+
 	rz_dmac_ch_writel(channel, CHCTRL_SETSUS, CHCTRL, 1);
-	return read_poll_timeout_atomic(rz_dmac_ch_readl, val,
-					(val & CHSTAT_SUS), 1, 1024,
-					false, channel, CHSTAT, 1);
+	ret = read_poll_timeout_atomic(rz_dmac_ch_readl, val,
+				       (val & CHSTAT_SUS), 1, 1024, false,
+				       channel, CHSTAT, 1);
+
+set_bit:
+	channel->status |= set_bitmask;
+
+	return ret;
 }
 
-static int rz_dmac_device_resume(struct dma_chan *chan)
+static int rz_dmac_device_pause(struct dma_chan *chan)
 {
 	struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
-	u32 val;
 
 	guard(spinlock_irqsave)(&channel->vc.lock);
 
+	return rz_dmac_device_pause_set(channel, BIT(RZ_DMAC_CHAN_STATUS_PAUSED));
+}
+
+static int rz_dmac_device_resume_set(struct rz_dmac_chan *channel,
+				     unsigned long clear_bitmask)
+{
+	int ret = 0;
+	u32 val;
+
+	lockdep_assert_held(&channel->vc.lock);
+
 	/* Do not check CHSTAT_SUS but rely on HW capabilities. */
 
 	rz_dmac_ch_writel(channel, CHCTRL_CLRSUS, CHCTRL, 1);
-	return read_poll_timeout_atomic(rz_dmac_ch_readl, val,
-					!(val & CHSTAT_SUS), 1, 1024,
-					false, channel, CHSTAT, 1);
+	ret = read_poll_timeout_atomic(rz_dmac_ch_readl, val,
+				       !(val & CHSTAT_SUS), 1, 1024, false,
+				       channel, CHSTAT, 1);
+
+	channel->status &= ~clear_bitmask;
+
+	return ret;
+}
+
+static int rz_dmac_device_resume(struct dma_chan *chan)
+{
+	struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
+
+	guard(spinlock_irqsave)(&channel->vc.lock);
+
+	if (!(channel->status & BIT(RZ_DMAC_CHAN_STATUS_PAUSED)))
+		return 0;
+
+	return rz_dmac_device_resume_set(channel, BIT(RZ_DMAC_CHAN_STATUS_PAUSED));
 }
 
 /*
-- 
2.43.0


