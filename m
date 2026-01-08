Return-Path: <dmaengine+bounces-8110-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6A4D02A6C
	for <lists+dmaengine@lfdr.de>; Thu, 08 Jan 2026 13:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3450305A2CC
	for <lists+dmaengine@lfdr.de>; Thu,  8 Jan 2026 12:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCFE393DF9;
	Thu,  8 Jan 2026 10:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="YuFPcOpN"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BFF2D94A4
	for <dmaengine@vger.kernel.org>; Thu,  8 Jan 2026 10:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767868601; cv=none; b=oGCw0a2Siq8ODAMggNjNUzj5wnXVFBhsZcOeAD0vQ6xIE3Umd0LAyBej4O/jImF+D/toZXpvjTs1CAoL74gjciozwKQM1AAWTjXwKPnowavpYHvqAyez4PNcAjVBGYACFRWu4xTt5JzsdxJShbjeNBUr5L4L05hmG4cKAxAlIb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767868601; c=relaxed/simple;
	bh=spUFrQpAHUSihVIbrTd6aDb/HQEXMQYbUxekF5wDPZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pXzevYDq5vY8tZ9nguW+OWUnlLhSm3RTRswkl4Q9HBBDFLYj52IDDwD76IgTR8EVW6z6X3sHtEMRGF/40XuE6zx5afSIytjfaX7/Oo3dR2obq6O5xkQGUDCMuKUTPhe4lSS+JT/4OOlX+KAoFUIkMn+7H6afPdx823ix0GuJLak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=YuFPcOpN; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47d3ffa6720so30913655e9.0
        for <dmaengine@vger.kernel.org>; Thu, 08 Jan 2026 02:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1767868593; x=1768473393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o7PLTkw/HbTkvBtEU+lXi+/ObfFOUjX/JmNK1olicNI=;
        b=YuFPcOpNeyae46NGGeFsfiFNhZrPb5qRP9WlE/O4oGxcGR8aR7ERqVxRLjt6lzVa9r
         +E//QSn4VStD4CCJ1CzvPoDDIM8623B27W1pGRcRM4rjVSsR2H6BrGKTXZoGHml/vlXB
         5+dezXY8ifJe/UBXFwhR2htCu913IGqhxGrtlVvcahBjQXH6aPOYpiE8hIT9Rcf8gkYq
         CXLi9CxDntOaa+m8IDVsf0Zoj8/XvhXk2PirJRdO2kWJs8Z76BJ39Ypz5uWureCXn7Ba
         f5OaqLKa9ZPOu9Jink9fCjv4uK8eKzcQ8VhuJ10esIuSelm/Lu2hm8tCwhSQASTAmLkq
         dM/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767868593; x=1768473393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o7PLTkw/HbTkvBtEU+lXi+/ObfFOUjX/JmNK1olicNI=;
        b=kY+HE5lRn1C63PePv69vhsz6YqyDZ785AfLHndrfKdBDLcOCDFsB0VJ/Evpz4XTZNh
         I5H1K+oajqXTaa29/tk4H171sgFyZCJZiL8sjURt3zevf0WlFCkgh9UURJuDe0c+J65O
         SGr3DcFqE+g4eqhc1ptNHbpOv8u/7D/Vd3ufI5X6gteNACdCV4Rau05kNv7USUFPtU25
         n+2f4K5aepu3q8kmIjZ3ht/KHQOCnV6R9iCVfErRQypud4x0bwDqW8BRqa0W8DNGPqEY
         A2dsSDKGi5A+RMlyA0dVpNmuBvDXDUBXvTwo5e3879yZUABCOCp1lIYK/w3ObvuYNtxK
         iFrg==
X-Forwarded-Encrypted: i=1; AJvYcCVjx4JqgouPhN+QPxZ6w1l7KUgWlqWw/4GkH8Sa/UOh03zizQ/ONdUC+t6u0R84ptjBprH27gS/bVw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1hP84Wkt7nwU458R20sz8zhSXDw7OQpOqJbkvUiwV27l1ndld
	Ki0ZEO+j+niJjGWK9sMSUWkC35PqvyqsIVjAKpQRlPVpRyvN+8xfj8PVGuEd/XHp/Sk=
X-Gm-Gg: AY/fxX4kpN1VaaLyQ+gAbTnpu/aKwYR/Lg/Hjm+y4DjXV0j2Cb+fLV6hjDJrHpEFZOt
	sO8CKrxjPn2KEF6mL7jL9qNfKHKrvuPRwrrXcGeAIOGXGW5+1kbGdyUdMRXSQyISxt+sBsXzvzH
	ixCCE7PKWhJSpG9jyl8IovNKNuMy3YKtg10bjz+D/2IS0q5du8qsKbpsDJsaJNYlcweTcbQI01D
	5+Aijuyo49J39JgP7yy27ocF4w1Kgac/CN9mJZT2DK/qpoIeIqJlIgkqRe/UmdT5YFyHV+p9oQ+
	6OHVBqCIcl/6Nn175KNr4Zr3bHQHj2NVxzi6fwQlp+sjcZQPyAcnLhAoOeN16toyPZTiFoB3PNV
	faAo9G4Svt8pY8eMySeWXhc185F1AbrbEpwlpMArbLxXXGtq1R0h9ha3Z3QDltT0aPcJ1Wi2IxM
	mqrAvjJvGTooaU3EgjsPZS+RW0q63DaqHlKuBvIW8=
X-Google-Smtp-Source: AGHT+IF0e1OZBhaJwQ+s5DlVX+WY1KnxeqJ91c95V464aKTYpKJlrDgGrA3vXH3o0akj7eFchMyu+A==
X-Received: by 2002:a05:6000:25c6:b0:42b:4267:83e3 with SMTP id ffacd0b85a97d-432c374f5femr7993687f8f.5.1767868592727;
        Thu, 08 Jan 2026 02:36:32 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ee243sm15399033f8f.31.2026.01.08.02.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 02:36:32 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: vkoul@kernel.org,
	fabrizio.castro.jz@renesas.com,
	geert+renesas@glider.be,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	biju.das.jz@bp.renesas.com
Cc: claudiu.beznea@tuxon.dev,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 8/8] dmaengine: sh: rz-dmac: Add device_{pause,resume}() callbacks
Date: Thu,  8 Jan 2026 12:36:20 +0200
Message-ID: <20260108103620.3482147-9-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108103620.3482147-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260108103620.3482147-1-claudiu.beznea.uj@bp.renesas.com>
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

Changes in v7:
- use guard() instead of scoped_guard()
- in rz_dmac_device_pause() checked the channel is enabled
  before suspending it to avoid read poll timeouts
- added a comment in rz_dmac_device_resume()

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
index 44f0f72cbcf1..de95139c18a0 100644
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
+
+	guard(spinlock_irqsave)(&channel->vc.lock);
+
+	val = rz_dmac_ch_readl(channel, CHSTAT, 1);
+	if (!(val & CHSTAT_EN))
+		return 0;
+
+	rz_dmac_ch_writel(channel, CHCTRL_SETSUS, CHCTRL, 1);
+	return read_poll_timeout_atomic(rz_dmac_ch_readl, val,
+					(val & CHSTAT_SUS), 1, 1024,
+					false, channel, CHSTAT, 1);
+}
+
+static int rz_dmac_device_resume(struct dma_chan *chan)
+{
+	struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
+	u32 val;
+
+	guard(spinlock_irqsave)(&channel->vc.lock);
+
+	/* Do not check CHSTAT_SUS but rely on HW capabilities. */
+
+	rz_dmac_ch_writel(channel, CHCTRL_CLRSUS, CHCTRL, 1);
+	return read_poll_timeout_atomic(rz_dmac_ch_readl, val,
+					!(val & CHSTAT_SUS), 1, 1024,
+					false, channel, CHSTAT, 1);
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


