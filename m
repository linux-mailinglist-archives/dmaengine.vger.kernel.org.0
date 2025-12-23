Return-Path: <dmaengine+bounces-7899-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C17C7CD9823
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 14:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 62882307DF35
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 13:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2AB529D28F;
	Tue, 23 Dec 2025 13:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="IWR/Qf+v"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEE92D8383
	for <dmaengine@vger.kernel.org>; Tue, 23 Dec 2025 13:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766497855; cv=none; b=P9mHaMqV6//f5eJMzazbN3OZMP4qPh5t/xkbJwLrTEKvPVuqVqhlaGg8agEPt/P09e+mMkdtzZVsTf6igS7kJhyoKBn553yln1QeQ/NvgvGbaFMyOP6drH4UqCMpRyu/I9XGf79U2PylguxfJY9VuQRVPvHwicU2xL/d8nzr7Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766497855; c=relaxed/simple;
	bh=y8JjTRWJmfiv2OxDGhF68Hgb5xnCNX77wcUy8YnPBmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NZ2yfG0mjsnn4cHqdGlHjn2AVNJTQPTRwbJOcqkJHP8Nnyv+4RPOu1oH9h81FTlvEjyMkHKJsxn15EiJ2Ve+UqF2yf/fKySnfzmg97uYQMKdt1Ovalp3S26HYhYsdQpYmc89P2PB/fMXcCy93O+aGsQ9slXq2hrFPrBW8cK0dso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=IWR/Qf+v; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4777771ed1aso34936595e9.2
        for <dmaengine@vger.kernel.org>; Tue, 23 Dec 2025 05:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1766497852; x=1767102652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MKrJmDMIWUzrtkIZ/VCoAjqFFgEwqOpXrTNpw0HEcIU=;
        b=IWR/Qf+vswDEYlcbqykJfwup+TswyGwHp9OYPTATrV6uHPxiqKMO+DQAWcTey3Ndsx
         1ed9lH7Rx1l2oZoy9YwkNXjDyhOMhHGHxy45QemWEb3Y+AakZnYQ7YFa68OpTwGKR+zK
         RerIctryvhbkaTllryO1is0uxkPQJOquOaCMtKC/3WbfnWlQtd2YUDyHKyXJfZEdhRIi
         mBMkMT/kUplTBFBJJOndQxduB2x6K4DJTrc1BGqzItFuuVfDDeIQqgL/wJQLyENr+9zF
         QYAJ4HIMTPakQ4PvLNxJwy3HG/qycTYFnn1uACg/69uToMK+gH7SAn0RECUY1sNbe0my
         hp9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766497852; x=1767102652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MKrJmDMIWUzrtkIZ/VCoAjqFFgEwqOpXrTNpw0HEcIU=;
        b=hY7GX3+LZFaV2JRYvQRgC5vRKx0pvjdtOr3DfuV48K2T7u/3PprwEsj0NgU01/G90A
         gW20VPAJ/L5hwwyo0CjRlmLBwND9EjZU5OpiA+iaO7qbnWDqf88XzpmHHAkwq5Em5v2v
         w+j7uVAL9xrp4H6AHDStnRIEVK0muWzYxIXjcCdOPkJpIv/aIYV+tQ/KSJ6K9ZQvKoxm
         VPRU7yXnJCPoHqN5d5m0Q5C7eUt49k67R3zzVucKIkYt47Vsxwy0Nnw6LOOYBUeLfpBe
         U/zdkk3MFqExP/PJ3t+kf3nPSCLtI81akzISPpH0O9XgFqbk6yZ56qMP/2cBtKYHTJwa
         a5rw==
X-Forwarded-Encrypted: i=1; AJvYcCXCAbRM/lJ6VV3c9bHwSK46KQ04tA/cSwyEcXN0RHrLbiU4sYeb0xp85BYOl6chhEAe7u4jtj4Qng8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/LY6Wk7jBV8IDuUhbay6hrps0AdZaR269Xhj41F5wLvVoyEML
	H+MEEK6kB+kHj/eFDpSFaQFoGfTWw7IoG3z4nDzpjQ0/YV/ksBmbpoxg1i6R40jCZA4=
X-Gm-Gg: AY/fxX76k1mRRnba4DFAD1E5L/+7rv3/uVLHmsa5m6ISVcIhFkY6k4+gn72sogGiz/N
	5O20KHlopEsRzHCMoTZqLqhR29SpYXa0fa/mWttsD7XYkVrejMYpduuaUDBvswdpIzxkn/P/JZS
	TuMELt1yR35+LzXS1P918p8oTTHIbF1yha0uvufWWjTAQRJQFjN6cY4sEJO9sKO0GXvEgvaxMou
	BNQXpXWAowyG2SwVJ1Zt6pR9eng2jbSIM8DVzfMFPJahLWL9dlIO2w69XD1edGoasKjCutfzKcW
	otm2kLUwVVIVyxwtcMfYd37bVKLDWlRZaLNd5zbq6C0CdYIN0zCgV3SlT0VqV64tNJnduHH/A0p
	+Llf9XdETBLPLi3JUh84J3s2/ouQXndBuzzJHEQISua/bz79l/pcFT7v9Kzztfl/rrbuEfgvg+O
	2Wp5Z+54CqZkDD8oSnDzDwiClca7zn/IwY4TygLojeLMb9OL9bWIADucf5Cth0IPyf56RVDgh/s
	eQJWPo+bA==
X-Google-Smtp-Source: AGHT+IEWWB84HrNYbZE5+pBtM/5LWAW0LB7tSxaP0PIQtlfFAdxXlXvqkqVb7M10LhvThrKsgAGDJw==
X-Received: by 2002:a05:600c:c0d2:20b0:477:89d5:fdb2 with SMTP id 5b1f17b1804b1-47d1c4d78b4mr98878225e9.14.1766497851867;
        Tue, 23 Dec 2025 05:50:51 -0800 (PST)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([2a02:2f04:620a:8300:4258:c40f:5faf:7af5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d192e88f5sm237921025e9.0.2025.12.23.05.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 05:50:51 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: vkoul@kernel.org,
	biju.das.jz@bp.renesas.com,
	fabrizio.castro.jz@renesas.com,
	geert+renesas@glider.be,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Cc: claudiu.beznea@tuxon.dev,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v6 8/8] dmaengine: sh: rz-dmac: Add device_{pause,resume}() callbacks
Date: Tue, 23 Dec 2025 15:49:52 +0200
Message-ID: <20251223134952.460284-9-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251223134952.460284-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251223134952.460284-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Add support for device_{pause, resume}() callbacks. These are required by
the RZ/G2L SCIFA driver.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v6:
- set CHCTRL_SETSUS for pause and CHCTRL_CLRSUS for resume
- dropped read-modify-update approach for CHCTRL updates as the
  HW returns zero when reading CHCTRL
- moved the read_poll_timeout_atomic() under spin lock to
  ensure avoid any races b/w pause and resume functionalities

Changes in v5:
- used suspend capability of the controller to pause/resume
  the transfers

 drivers/dma/sh/rz-dmac.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 44f0f72cbcf1..377bdd5c9425 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -135,10 +135,12 @@ struct rz_dmac {
 #define CHANNEL_8_15_COMMON_BASE	0x0700
 
 #define CHSTAT_ER			BIT(4)
+#define CHSTAT_SUS			BIT(3)
 #define CHSTAT_EN			BIT(0)
 
 #define CHCTRL_CLRINTMSK		BIT(17)
 #define CHCTRL_CLRSUS			BIT(9)
+#define CHCTRL_SETSUS			BIT(8)
 #define CHCTRL_CLRTC			BIT(6)
 #define CHCTRL_CLREND			BIT(5)
 #define CHCTRL_CLRRQ			BIT(4)
@@ -827,6 +829,38 @@ static enum dma_status rz_dmac_tx_status(struct dma_chan *chan,
 	return status;
 }
 
+static int rz_dmac_device_pause(struct dma_chan *chan)
+{
+	struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
+	u32 val;
+	int ret;
+
+	scoped_guard(spinlock_irqsave, &channel->vc.lock) {
+		rz_dmac_ch_writel(channel, CHCTRL_SETSUS, CHCTRL, 1);
+		ret = read_poll_timeout_atomic(rz_dmac_ch_readl, val,
+					       (val & CHSTAT_SUS), 1, 1024,
+					       false, channel, CHSTAT, 1);
+	}
+
+	return ret;
+}
+
+static int rz_dmac_device_resume(struct dma_chan *chan)
+{
+	struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
+	u32 val;
+	int ret;
+
+	scoped_guard(spinlock_irqsave, &channel->vc.lock) {
+		rz_dmac_ch_writel(channel, CHCTRL_CLRSUS, CHCTRL, 1);
+		ret = read_poll_timeout_atomic(rz_dmac_ch_readl, val,
+					       !(val & CHSTAT_SUS), 1, 1024,
+					       false, channel, CHSTAT, 1);
+	}
+
+	return ret;
+}
+
 /*
  * -----------------------------------------------------------------------------
  * IRQ handling
@@ -1165,6 +1199,8 @@ static int rz_dmac_probe(struct platform_device *pdev)
 	engine->device_terminate_all = rz_dmac_terminate_all;
 	engine->device_issue_pending = rz_dmac_issue_pending;
 	engine->device_synchronize = rz_dmac_device_synchronize;
+	engine->device_pause = rz_dmac_device_pause;
+	engine->device_resume = rz_dmac_device_resume;
 
 	engine->copy_align = DMAENGINE_ALIGN_1_BYTE;
 	dma_set_max_seg_size(engine->dev, U32_MAX);
-- 
2.43.0


