Return-Path: <dmaengine+bounces-9304-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKMyAmzMqmnUXAEAu9opvQ
	(envelope-from <dmaengine+bounces-9304-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 06 Mar 2026 13:45:32 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE5D220E5E
	for <lists+dmaengine@lfdr.de>; Fri, 06 Mar 2026 13:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3F984306583F
	for <lists+dmaengine@lfdr.de>; Fri,  6 Mar 2026 12:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1824538F248;
	Fri,  6 Mar 2026 12:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="N4XPZ5+V"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B35628BA95
	for <dmaengine@vger.kernel.org>; Fri,  6 Mar 2026 12:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772800910; cv=none; b=SebfEOdls4ObcKNR/l2HqaKHqDZmNP3szE0Y4wujMewqy2qEaLvcH9MMeTJ8EpBdbEHs6qBI3NgWaC/wyORUuJQjEpLU46Egh+O6mKJBJbSFwoE+a6qcLctPwl3J5rSSZuKfvIIHsUP9TuNOtiKfPmkw+xgRnB2zHme3nwGOEbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772800910; c=relaxed/simple;
	bh=m8HVDXAI0gFsFczYRIXenJR42GRKUDLDJ1N+K6c+Cok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KfBECaTsN3D5jpidAfFUyuq+wl+U/N3006FEn8JBoy2vbj18l5I/hP+7+AJYyveO2yOlVlz8nRq/sL0YSw9qdJjn1LpWRFqDdJynxsSNhdjy55rPmmdTZYTTKVYAvdoS7G7ji9IR6bXRgyZ+jwixSxGTcpS/g0ZuHSbTOr9EGr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=N4XPZ5+V; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4836f363ad2so107485915e9.1
        for <dmaengine@vger.kernel.org>; Fri, 06 Mar 2026 04:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1772800907; x=1773405707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zoqbEN/HoHhqzl9Aahz7CWhnPYMvokOytjXCAykOjvU=;
        b=N4XPZ5+V6hl/xQylb76IRz/46cOrSgDw+aOkzOJAdHrHcraJ9Yt0nDzZxKFIVMk360
         9NEZDV8h3rIPG7hgNYtqieBqR/kg0Y8CTi7T+enDAy7/DPii9RDLIunlWeBwQhpgU119
         e3QmU5E3t7lGsEJoQTLMHyF+U9dX7is3Eg9lPsbUKCA3MxnwpczHpz991F5ANuqUqoX0
         GU4+79k9ssfpMPwPzMT0A8k/8HAXmg6fewFSX3e23L+NRkEVdBgwvyIR3y110NX2USCh
         BVQiOYioPlWXt0SEFBCm/l9dDDeSe6A2oXk/Fy7uOSP1OcGrQxK/6HHeMIkknz/6mx4F
         zrFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772800907; x=1773405707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zoqbEN/HoHhqzl9Aahz7CWhnPYMvokOytjXCAykOjvU=;
        b=nj1KqQPqdSIKv4WwGj2A+JSTGYrRcElh/yITWzpIBlAMZ047+6oYOIZ5PXbEeeX+vO
         kudKixpL7UVqfTn3U0wv350l5MOQHVnhogihwj3BQR/DnmYRaK0eKRLXizQMZjc7eC6h
         QTaVex75cAIy6ziOvyJ/T42JzFOG8vIC1BGcDlb1/sb0WAeFtUP6FBqTYBJorCNYamKB
         EX4qu0O6/xaLS2Tp28CGXTlDuSI2nne/PRDZvprlvZ3eIPjnFSt5+p0MBPRLoU/Xwcvt
         bLkz77sGIBM52yJJkjvnCq6Y3F9+VvNuk54pcXM8poVbWbKuH88iQRI4BSghbghijsuN
         nrVw==
X-Forwarded-Encrypted: i=1; AJvYcCXLTchjbCygE5EGh5GMD6SjGL4mkFp6ftkZ9TTkTXyvhvtwpvONDj/7lB/ii1hZVTw+L2VX3QWIV8g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8jN3X3VL0kTif9Qhlc9NyDzWbcI+4/DJdGoS0s7a2xJYRZo8S
	nmScx2z1tHjLQfSALLcutSiUps9L7Ui8FFvXihXbiPG2JE6ki+GaGeZn53U81UkT2RU=
X-Gm-Gg: ATEYQzw1WFjH1Znc3OLq3sHCPyxAaZjdLFe8nPpNFMTgCI57qqHk663kDIjZDdzam6x
	61OGxRxdsYhQAHiPkwX7i/f81OudtEM3d1M28E07isWRjmeiQnWel3kb0tFQm0zByaH7tMz4nbv
	5ErxX5VZJFAPoBdUxgqu9ceUiuu96h49sEk1xvstBRLlDrDHLbez7EYLaPwJGIHK9KGtl06Lut3
	3BF5YcL4dmbuJc4WqwZ/CPM+D5JRExGOJktLbAbpuLFV9cwwIbmXnA0oCKCQiXlDcUGaTwPyQvL
	8PxsLufrGkhTX5I9lOuJ001UUM7JdYjMNBNnpnOdRTFnP9d80kWBftzOo/3SngJKOLXhUFTFV5l
	tXVmz9IzMn/jxk1z1QASibNvT72vcgiBQXRAxlJLkhY64nCTJ9CV3g92RQDyXY+FcqtJPCsIxph
	2TWW0aesV8XifRC0TbJZKizlIDVhtlRneECbX3wT/oDDL87w2p3Asn
X-Received: by 2002:a05:600c:5303:b0:477:c478:46d7 with SMTP id 5b1f17b1804b1-4852695aa55mr31872855e9.22.1772800906819;
        Fri, 06 Mar 2026 04:41:46 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485276b0c38sm38150505e9.9.2026.03.06.04.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 04:41:46 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: vkoul@kernel.org,
	Frank.Li@kernel.org,
	biju.das.jz@bp.renesas.com,
	geert+renesas@glider.be,
	fabrizio.castro.jz@renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Cc: claudiu.beznea@tuxon.dev,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v9 8/8] dmaengine: sh: rz-dmac: Add device_{pause,resume}() callbacks
Date: Fri,  6 Mar 2026 14:41:33 +0200
Message-ID: <20260306124133.2304687-9-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306124133.2304687-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260306124133.2304687-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AFE5D220E5E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[tuxon.dev:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[tuxon.dev:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9304-lists,dmaengine=lfdr.de];
	DMARC_NA(0.00)[tuxon.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@tuxon.dev,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,tuxon.dev:dkim,bp.renesas.com:mid,renesas.com:email]
X-Rspamd-Action: no action

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

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
index 3b318fe06f28..6ad41e0285f5 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -134,10 +134,12 @@ struct rz_dmac {
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
@@ -813,11 +815,18 @@ static enum dma_status rz_dmac_tx_status(struct dma_chan *chan,
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
@@ -825,6 +834,38 @@ static enum dma_status rz_dmac_tx_status(struct dma_chan *chan,
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
@@ -1162,6 +1203,8 @@ static int rz_dmac_probe(struct platform_device *pdev)
 	engine->device_terminate_all = rz_dmac_terminate_all;
 	engine->device_issue_pending = rz_dmac_issue_pending;
 	engine->device_synchronize = rz_dmac_device_synchronize;
+	engine->device_pause = rz_dmac_device_pause;
+	engine->device_resume = rz_dmac_device_resume;
 
 	engine->copy_align = DMAENGINE_ALIGN_1_BYTE;
 	dma_set_max_seg_size(engine->dev, U32_MAX);
-- 
2.43.0


