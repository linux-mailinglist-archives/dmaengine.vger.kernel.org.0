Return-Path: <dmaengine+bounces-8404-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDsbHXfBcGmKZgAAu9opvQ
	(envelope-from <dmaengine+bounces-8404-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 13:07:19 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 364FD567D8
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 13:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 67EFB709366
	for <lists+dmaengine@lfdr.de>; Tue, 20 Jan 2026 13:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298EA43CEE8;
	Tue, 20 Jan 2026 13:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="NoZvxrsy"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A713F43C06B
	for <dmaengine@vger.kernel.org>; Tue, 20 Jan 2026 13:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768916035; cv=none; b=oj4DlpDUhs4606EBY6lb5sHRciJMoiNhRA/m0w+Tk1ju96bvJB5LCqfmORB8+8qwb9uDRKaNn4L0bS1iEMHho+6lVPqi4V+bTivj/ik8qjjKAHlBGMLxSJb70SDZXlKyHSQStPDr051QUKUWcAX5rZgRkjdHbUkPpxp/BCEqjBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768916035; c=relaxed/simple;
	bh=hrsUEoSTkdNYFm8WzseU1HUqOXHvGZY2m9IltHxuiXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IcJdXtHLX0Ztwkul+lAgjVfv515Yev/a2v6o22wWesAumvyWUnE2ui+/u+/lYomHv8s1opB272orcJ1VZuoEU4ViAAuPjq90SurPcgYk08yJuSnuKHB43T8/xuTMdGxDbifG8DHuSEEJYHirT3Z3uFyHfPf93LDMJbLWl8rc5Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=NoZvxrsy; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-432d2c7a8b9so4647532f8f.2
        for <dmaengine@vger.kernel.org>; Tue, 20 Jan 2026 05:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768916031; x=1769520831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Or2PvAUr6ZHPTcmvHehxrdDkv+cU8AUyLZ4ALfe+ybo=;
        b=NoZvxrsyD1xGhuk4FK7nw7eqjfhLs9D60QPao7OO+n5kWBeZcHd2T5nUz/A0xt56dn
         m2qQO5+yAQb4M/Kyku7dzyzTDYzH3iPaFXRzVWlbCV9I4/wR5bUkM1oZAQDyp2bFrjXQ
         JLk6Sn1ycvQxb+aHX9DoT1C2ofKbDlmnMgvIxjd+HihSfg0cXijfk2tnDjjpNwGX6fP5
         V0m+5QCfo8U7UK3hmzQsveM/vatxSw566g2+/DXXI0nutyHFtTfPxYG8PSGNOWoUSKPB
         5rg1/Su0oDKeTxeQD2SM2P1jkZS646Vb2tjL5P2rfDgOrPsZTdJ8OxJz6YSAxMPJpPdO
         V4mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768916031; x=1769520831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Or2PvAUr6ZHPTcmvHehxrdDkv+cU8AUyLZ4ALfe+ybo=;
        b=FTSbFfIlTLEGZt7+EShUXcqyB2y0SXUpjGEU5iiqxH7SvRa9LiFhi62HmGdxpOZuUe
         z//xhv1WMV4GlKcbiptqxBF/kzrJyIDQixrJ/KcawMYmxeo4f/OB2tt1XEThpJSgrf1j
         uHeaO5KbwdNH5laAbKxOGqe+oIG832n/7Nd9s6UdFvIzK2aMzD4AIWQOFgTuMwn7Xi4x
         NsZKSueTF6Xyy0P/22195+CuP/8tk+Q3S/01NiI25/NZsqW80FWsQDp155LrkpoPHVuU
         lJgwzEb84t+w/FZo+p/Ck/jJLvOxi7YLQLZcUnhgbeSy7UlFnDkPAA39FyY99y7uVXF+
         OQsg==
X-Forwarded-Encrypted: i=1; AJvYcCVsVYnhWOq2IJ1TrwglHBLjdl4hd2ltCuHqPbMF4qYQzElbvNVJKJw3nKUdy9IqA4ZCYGHPAzuMrTM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLbrue9nd9IiNmOm/yvxUzG7Z+hYwBkfwc1m15ofosjh5yW15N
	338C9N2QvZXGfYNAWdUl9yZV4QbxqeCJwDMIt/CXPVX3nYm3Z6I0JWJolBEcYnlYzgM=
X-Gm-Gg: AZuq6aI3CfrQEiQzfcInGO4+Ugmru0i3u+EyTxTVZaJzbL/YrtU0fwfAMzxHQgzhWpJ
	yBOF4xOLTf3jKpNEwHOrbPLJiZqartU2vwTsc4PPNsOaeaj78REyi1YZzMlPyVHvp+OEhA/05rG
	4G7oU5Buf/8TRN2MQ1mHWCe7wMtY+qn8DUcJSBmEejVuEn9J83BfxfCbjbYdQDDU7ZLoSsGsz73
	4MHDZMp8azrN4fJX2ztpaO0C8lAvkQtR9Jt4B5x4fZfJIkDWWQgOwQKQ6QveDYXRkIanCYvj5oI
	9VjjO4AaEYXzkLFB2qhp7Qi8qmY2bV9AgxVtb344boYtcYBBCmJkRxhcmIxVNM4laRk0o0capLK
	naM8p6qsPaPlzUzxfblLUSK6XWgTSc/tNUoEwPdPkunnRx4464JC1B9z/5Y0bA4jaig+KQrSd0j
	HrHgCMjK6fVYpA0q9Kr0nuG4t5HA3HZo6D2Qhbc3A=
X-Received: by 2002:a5d:5889:0:b0:430:ff81:2961 with SMTP id ffacd0b85a97d-4356a082ebfmr20516546f8f.51.1768916030840;
        Tue, 20 Jan 2026 05:33:50 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356996dad0sm29331439f8f.27.2026.01.20.05.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 05:33:50 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: vkoul@kernel.org,
	geert+renesas@glider.be,
	biju.das.jz@bp.renesas.com,
	fabrizio.castro.jz@renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Cc: claudiu.beznea@tuxon.dev,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v8 8/8] dmaengine: sh: rz-dmac: Add device_{pause,resume}() callbacks
Date: Tue, 20 Jan 2026 15:33:30 +0200
Message-ID: <20260120133330.3738850-9-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260120133330.3738850-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260120133330.3738850-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[tuxon.dev:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8404-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[tuxon.dev];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[tuxon.dev:+];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@tuxon.dev,dmaengine@vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 364FD567D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Add support for device_{pause, resume}() callbacks. These are required by
the RZ/G2L SCIFA driver.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v8:
- reported residue for paused channels as well

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

 drivers/dma/sh/rz-dmac.c | 49 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 46 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 27c963083e29..caa3335bf95d 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -141,10 +141,12 @@ struct rz_dmac {
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
@@ -814,11 +816,18 @@ static enum dma_status rz_dmac_tx_status(struct dma_chan *chan,
 	if (status == DMA_COMPLETE || !txstate)
 		return status;
 
-	scoped_guard(spinlock_irqsave, &channel->vc.lock)
+	scoped_guard(spinlock_irqsave, &channel->vc.lock) {
+		u32 val;
+
 		residue = rz_dmac_chan_get_residue(channel, cookie);
 
-	/* if there's no residue, the cookie is complete */
-	if (!residue)
+		val = rz_dmac_ch_readl(channel, CHSTAT, 1);
+		if (val & CHSTAT_SUS)
+			status = DMA_PAUSED;
+	}
+
+	/* if there's no residue and no paused, the cookie is complete */
+	if (!residue && status != DMA_PAUSED)
 		return DMA_COMPLETE;
 
 	dma_set_residue(txstate, residue);
@@ -826,6 +835,38 @@ static enum dma_status rz_dmac_tx_status(struct dma_chan *chan,
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
@@ -1164,6 +1205,8 @@ static int rz_dmac_probe(struct platform_device *pdev)
 	engine->device_terminate_all = rz_dmac_terminate_all;
 	engine->device_issue_pending = rz_dmac_issue_pending;
 	engine->device_synchronize = rz_dmac_device_synchronize;
+	engine->device_pause = rz_dmac_device_pause;
+	engine->device_resume = rz_dmac_device_resume;
 
 	engine->copy_align = DMAENGINE_ALIGN_1_BYTE;
 	dma_set_max_seg_size(engine->dev, U32_MAX);
-- 
2.43.0


