Return-Path: <dmaengine+bounces-9438-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DLsHo8IuGkWYQEAu9opvQ
	(envelope-from <dmaengine+bounces-9438-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 16 Mar 2026 14:41:35 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 18BB729AA10
	for <lists+dmaengine@lfdr.de>; Mon, 16 Mar 2026 14:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 040B930CA94C
	for <lists+dmaengine@lfdr.de>; Mon, 16 Mar 2026 13:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8A439B491;
	Mon, 16 Mar 2026 13:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="BqxEWq8I"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8507639A804
	for <dmaengine@vger.kernel.org>; Mon, 16 Mar 2026 13:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773668019; cv=none; b=mD4fN9H70HhwvanUtvUQJVeNlQO/Y8oV6063uUG8xMraUeV0XgHajsaSMLQ5cUgwiRuJ9eKTc3bQp6fQslS/+nbyEThK5H3uG4faQ4jan29bJ861+kT3hYfr99CZGdPtX74LSgsJwpIUGreaY3IP3IOasyUK+nHjVRr6+suFKKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773668019; c=relaxed/simple;
	bh=dhDbLlu8lOn7a/jmx+qOjmpwf86y4CSPKJ+nwWSmz04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dxdrnoHD0CTDSsXgdlbTuZ770w+r0cm/HckHnpwqiotzucU7iLwp+Cy+Vof+aZjZqdbeoWaf4MP1c0zWwcZguNh3Jr8NfGu1lXWYT+UuSL98lRyov8KctuG+iMWxgaNTMIRIbva98eedKBO31CAOMWtFdyticrIO4RL/llnphfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=BqxEWq8I; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-666f646f5cfso263715a12.1
        for <dmaengine@vger.kernel.org>; Mon, 16 Mar 2026 06:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1773668017; x=1774272817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZgHV2dK1l+x7JxSuaqYPcN2x0qrMhv6A3X3+/EmNbw8=;
        b=BqxEWq8IfOYkxAj6FjsXDq/WJWNPwz2VRb4nKJYRbY/U9MZKZxgFHgP2CnW/YeUvNQ
         rzZaaI8dU7pZZQ4KOWl9VLVjzyOxa99GGFIptxLHhA+OVjGEV5iSxX134G0Vg9xUmVa4
         rGYQILgCDUNYoaq4V9+hPbxX8TlGJl4CJN4CIB4apfluLcB8UB27GPFD1SQ1O8Tw0mxy
         EV49UprZbwVmZg/k6khwIhAsXyY8/I8k3pFUmlOFL8Td4AcFIZfNKWq24NTnj9JkZMbv
         0Mc+LDo/Ah321lMAwyTFBovZul8qtbXX5Hg2WCGePy5n6xRX92OiaRmiv0lQ5zTrg6nv
         tTjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773668017; x=1774272817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZgHV2dK1l+x7JxSuaqYPcN2x0qrMhv6A3X3+/EmNbw8=;
        b=KF6II8RTloIwWaWbFSbzsd/H2n/qhQPzAv7ca6rXOrNktRPkyftQjhH7DJhzOUEpTp
         tteuGL3BlCJ4nD1XvsjolL7X5DFDTpvIhehXRp/JaD+/tlvPXRt8Y/z2Rcaho1hBk0sj
         i3LvD/YuBeG4WuYnNx6/4LsbsVjNCbrGsPCTrdH3uk8bIk9ihotS2hd4oyu4obyhtDtu
         wxHJP9x22IRmMCpqmnwCPNtC0OJ/CILuMMcwhCwHKHhFFevGt+QUvw3+TkgyNvd3N9Bp
         jEwIj5NXrHql65TEIYpzQrBm5dt2GPpueIDB/2+TYNn+InUV2YuC4nFGrJTsoyoc9r2E
         mT8g==
X-Forwarded-Encrypted: i=1; AJvYcCU/4cLVTkcwCCQjbN8urSQisf6Pm6Pmh8WSBTEgbvfg0DGFbmaqlMZ0tI1x2xUS9UwpeTrmBI3mXyA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi//HCr2VGWG4Xmz4baEYtubxl9/8ErHrwp5iTGqM56LtWfPYT
	TI6zDfNeMilDkVas3yB3e3FZ8scC/0XbgNmksufbqNsuBTmaT0J5K0xEsTMQNL0OJiBpCZIdo+V
	W9WSx
X-Gm-Gg: ATEYQzzFPaGGscn751SQaxM3tkPMJ2Q0zl/gMBNBrKTTt13eylEruW6SrTGrYZBvPcB
	ViOD4tobH+Bz0aLcaON+W6Qci0DiwZ3D6UpqIZh3pAAXW5RjPCr5QTI3JJ9k1UUzu/xnQvY+kIw
	/kshyZGpkNpCZEuhyx7ffDSpy8SbDR4YpciaepbQ+WymuODzs88WMY0Y2Ye1rNEWhqSa9omr1SX
	UUawY/JGwQ2LH9cbU7KPLnuq3+SjO28s1ck6sV0OGiwR5NHM996jVeQauTRD0sTaqxoJ/3ppv3O
	ptgDK9StTBsK8azsQH3JjH3R9ue5z3rytTVF1xNcMPNqyKh/F2od5cBIMkkpDxDSoOI7Fzsi3mR
	GwLJXtxpd/avs+K1dVQiTb3PCbtUZyULWlgQ8eeqr6VLD5sm3KjWWTP60wQyZpkOseEry5y0y1O
	M1/XMWnRpLSfAN90NKzBRK7ZvvPMEWfPgSYflKdYKEMOkyWRC9kfAJwmXs55JenRfdOyJjxyF8X
	XK2MTuUd77yj59Baw==
X-Received: by 2002:a5d:5f83:0:b0:439:adc3:f0e7 with SMTP id ffacd0b85a97d-439fdf426fcmr32388981f8f.9.1773667995888;
        Mon, 16 Mar 2026 06:33:15 -0700 (PDT)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([2a02:2f04:6208:0:c5e3:3624:ad1c:6b4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b419270efsm11629888f8f.16.2026.03.16.06.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 06:33:15 -0700 (PDT)
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
To: vkoul@kernel.org,
	Frank.Li@kernel.org,
	geert+renesas@glider.be,
	biju.das.jz@bp.renesas.com,
	john.madieu.xa@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Cc: claudiu.beznea@tuxon.dev,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v10 8/8] dmaengine: sh: rz-dmac: Add device_{pause,resume}() callbacks
Date: Mon, 16 Mar 2026 15:32:52 +0200
Message-ID: <20260316133252.240348-9-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260316133252.240348-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260316133252.240348-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[tuxon.dev:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[tuxon.dev:+];
	TAGGED_FROM(0.00)[bounces-9438-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[tuxon.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@tuxon.dev,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 18BB729AA10
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The RZ/G2L SCIFA driver uses dmaengine_prep_slave_sg() to enqueue DMA
transfers and implements a timeout mechanism on RX to handle cases where
a DMA transfer does not complete. The timeout is implemented using an
hrtimer.

In the hrtimer callback, dmaengine_tx_status() is called (along with
dmaengine_pause()) to retrieve the transfer residue and handle incomplete
DMA transfers.

Add support for device_{pause, resume}() callbacks.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v10:
- none

Changes in v9:
- updated the patch description

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
index 4f6f9f4bacca..625ff29024de 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -140,10 +140,12 @@ struct rz_dmac {
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
@@ -805,11 +807,18 @@ static enum dma_status rz_dmac_tx_status(struct dma_chan *chan,
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
@@ -817,6 +826,38 @@ static enum dma_status rz_dmac_tx_status(struct dma_chan *chan,
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
@@ -1153,6 +1194,8 @@ static int rz_dmac_probe(struct platform_device *pdev)
 	engine->device_terminate_all = rz_dmac_terminate_all;
 	engine->device_issue_pending = rz_dmac_issue_pending;
 	engine->device_synchronize = rz_dmac_device_synchronize;
+	engine->device_pause = rz_dmac_device_pause;
+	engine->device_resume = rz_dmac_device_resume;
 
 	engine->copy_align = DMAENGINE_ALIGN_1_BYTE;
 	dma_set_max_seg_size(engine->dev, U32_MAX);
-- 
2.43.0


