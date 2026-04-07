Return-Path: <dmaengine+bounces-9913-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCgrEUsL1WlQzwcAu9opvQ
	(envelope-from <dmaengine+bounces-9913-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 07 Apr 2026 15:48:59 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F233AF759
	for <lists+dmaengine@lfdr.de>; Tue, 07 Apr 2026 15:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8945930F13F1
	for <lists+dmaengine@lfdr.de>; Tue,  7 Apr 2026 13:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470773BD634;
	Tue,  7 Apr 2026 13:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="LZyB3MU3"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B1B3BB9F1
	for <dmaengine@vger.kernel.org>; Tue,  7 Apr 2026 13:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775568950; cv=none; b=ESIJezdcUdhifmAXQca/FbsL5/lBhsjecohtufzCMjbc38MHMJSFa3ry6XhCGo8IDWUmuR5ZOHdJ1aXyUVdUzjq72Ravenb7R7wmcD+aVm0BO6vI/3aSP2tsb+B6/TeQIW3Br20kasntGDuEhah6ifbl5zjipaFkjkO0wMNJn3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775568950; c=relaxed/simple;
	bh=OGJy16GF9/KuOlAbPYY8Arool4o4HNHbnVB+AWCFgco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JtxU3les2G7ASvpjBJW+g4cLWU6hxOeLFFz4Rfv7I4WTizMnl2LO67te0D24Ek0ZV3L9rD/8lpvYp6Gso7jgepqQUkKPR+EG51CX8ORxx+VZk1BUq4VSlSsziO7KNcyIoc+uXzafWsSBpEnuKKxCHZIOgLBgmkO9qa1hcd1Oiv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=LZyB3MU3; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-488a88aeec9so35058855e9.2
        for <dmaengine@vger.kernel.org>; Tue, 07 Apr 2026 06:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1775568943; x=1776173743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RfbZ4006aH4p+LsSEhfwyxhxCu3KeHA6cjylUZwq+3Q=;
        b=LZyB3MU3pC4OXVXzjPLhXW47vYRjeqGKG/CnbOB09MRF3Pv3MxMQle8VRDUnT/Snh3
         KJEgne75u3Bv09pPLS0KFnotv7BpXoXUuOSGbulESZXCsUjaJn9i5/vCJDG/ps92GcPS
         l4BOJhc87AIaoPqPIf6GOOnt2p5qHrgu2MsCJaJuXMDHOPU22tHgjrTphsgeKc8qM+12
         K1AW/hhlgwid3d7w9f/SA15WlEW+LONvfrhuoZfjBeYZPdldEdsJiUkn6scfVx3T/jBs
         tcTXpQiIigg9//DJJ4NHPJ12WK8bWZWtjo7Ola1RLtKh8icFXAUmn/lAcrNgkjWLnfc4
         OJSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775568943; x=1776173743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RfbZ4006aH4p+LsSEhfwyxhxCu3KeHA6cjylUZwq+3Q=;
        b=COY1I7UlB+7MQlOrZKjeKmuvhCZW6aoV7PPA6NCkBDOlEaWCovpc/iGMmMQB8Z/5D+
         JljXQjQ+3qwevwjxSsLztno34KER9SJTYCEaiBmQxEm5M69S9fh4XnVMHW8RLRo06dGx
         EGXThN+23tA2SeTwSm8x33b/aVlB/IkXHdePiRP/CAFQoByDazRulgDP+8qdGevjgtFL
         tFInTh+nJ/GBqoQ/0bXN2+kHiSBqVZrQkOZqZ7utNA9CWF94EOfGcGDSjq2q9pjX7UnC
         QuPKEhfCtpdEWnueGUS14dYnoIHNudqoF3MdQsxDYknC56NmsLEiowCaBRGC9zTwCpaR
         3yig==
X-Forwarded-Encrypted: i=1; AJvYcCUx6dodgykHbh3uSSm6CXGOdTerpynI0mzH+ipQFLFXzCIZzS+WQxv1wenSAzSWiJMeZPAXYRrvccM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwOxPLdoit1CJekPurEKG+9nNTl5meG3MrOUqvcZ27EdbVAgUr
	xIuzD/65pG9w00tL7fG6yTb3h6vTdI5g3H46YU7u3yPOD/yEhTL/Obpcu/ElWxx+GBI=
X-Gm-Gg: AeBDieuZ6IoBK5F4Q7b4RFeEK/nasCgAFuuTrvXdtThseWhaUXMU+WwLXUYEwwKWobZ
	+fcdVGBLch3V14uqi5btdULLgU6mdHte65GRnCSytzwBlwc0GcR1zPwQrmoRXVMhTvXXcAeUd8+
	879M4C5nukgHBzOMeJy/0U13EjbIIlJvvvVf0LrgD57cxkcXKrih/VGnPOi710O6D9bH1h9M63Q
	jibSi2KuD07VY/mULSO+yxPsaoxzwpXcjFs2szSxCbLUmi+X07bxK0IztZpryMqA/jDq8WPCs2l
	wTkQY8fGuIYVVRmcjNJazIQfY7p4YzBQVQIjRugXcey3QAQC24IihhKFW9WPHrn/BD9o68OvW2r
	OgiSOeGOjkIlJwEBBFNbmHPWv8VFowzQ2qTHhqmeIdo/CbpSsS96wmWXHtjguKayQPuLIDGau02
	fmatP+Mi7FUOQWiWQrT8AVhOBaroeaYd/zBaCFU8TIkyO87EEI5LPe
X-Received: by 2002:a05:600c:5251:b0:488:c257:a73b with SMTP id 5b1f17b1804b1-488c257a952mr14542955e9.9.1775568942953;
        Tue, 07 Apr 2026 06:35:42 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488a91686f9sm285777675e9.10.2026.04.07.06.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 06:35:42 -0700 (PDT)
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
	fabrizio.castro.jz@renesas.com
Cc: claudiu.beznea@tuxon.dev,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v3 09/15] dmaengine: sh: rz-dmac: Refactor pause/resume code
Date: Tue,  7 Apr 2026 16:35:01 +0300
Message-ID: <20260407133507.887404-10-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260407133507.887404-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260407133507.887404-1-claudiu.beznea.uj@bp.renesas.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9913-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[tuxon.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,perex.cz,suse.com,bp.renesas.com,pengutronix.de,glider.be,renesas.com];
	DKIM_TRACE(0.00)[tuxon.dev:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@tuxon.dev,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bp.renesas.com:mid,tuxon.dev:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,renesas.com:email]
X-Rspamd-Queue-Id: A7F233AF759
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

Changes in v3:
- none, this patch new new

 drivers/dma/sh/rz-dmac.c | 68 +++++++++++++++++++++++++++++++++-------
 1 file changed, 57 insertions(+), 11 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index d47c7601907f..bacde5e28616 100644
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
@@ -792,35 +803,70 @@ static enum dma_status rz_dmac_tx_status(struct dma_chan *chan,
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


