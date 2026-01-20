Return-Path: <dmaengine+bounces-8400-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HvTJlUEcGmUUgAAu9opvQ
	(envelope-from <dmaengine+bounces-8400-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 20 Jan 2026 23:40:21 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 197C34D1C5
	for <lists+dmaengine@lfdr.de>; Tue, 20 Jan 2026 23:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AE2615E4BC6
	for <lists+dmaengine@lfdr.de>; Tue, 20 Jan 2026 13:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E8C439010;
	Tue, 20 Jan 2026 13:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="V02zpTjo"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7226438FE7
	for <dmaengine@vger.kernel.org>; Tue, 20 Jan 2026 13:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768916029; cv=none; b=leYHM288PEOwJEKqAl6Psd/17jGmseDoWX6c7jOMUzZVOQqYt0HzZpKhzSk/kxYDrXxt03WQ8fNzRTCW+0NdLZc0uOB/5r9+f3WKTaaQJsxBo0tM7vW06DuR4KSGJ2RqXV7wgt7tAh2kUA8sjkg9W9wBj10ip5Ps4EfMUUY9ifA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768916029; c=relaxed/simple;
	bh=5mM2uTcjaYXheBt0FIVFSFgIssygZdhyDFfDja25cB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A/b+JoeUKhVxxWAP8HBlJYPWRaClRn6rcdXsMpd+YruGUdDkVVnZNf7zZuWRXfdoapJP3MpHs/P+nAWegeNSQHGBYvaBJyq3GN8wq16J74v5K9mWYIIEAwMtFxMmcRSF4o805Ur0JcxQ82xUHBMzSz3R8b0I4PfPSoDBzg3lqw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=V02zpTjo; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47f5c2283b6so35474175e9.1
        for <dmaengine@vger.kernel.org>; Tue, 20 Jan 2026 05:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768916026; x=1769520826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GCRWv8BoukUYariTfudysMyZzqcHq5px1XRxiaHfVGI=;
        b=V02zpTjoMYI5fv4nhphhgeiGxy9WYLfJzrTjT8xmmn0m1LWGJ33PhQdFFGPG2Pm0Be
         6ezJAJbtQ3f3GmqMNZAoM+CI2ML3lffm6X5MGtP8phyAhigmOX2p0lVyEDJhwUS0bgfL
         armNaa0kCt9BbLgWV1rkY7blGqafr9CWthSGVIfY1FMiIhvgU5xzoDLc5YAgfw3VFXlS
         TmuQdEMlN6WC2eIIzcDuq0mx4s8P7vYlDcgkPkglJ5Q4t+a1l5lfB8xSp2NYy0r9MNJy
         CJiKkNCAUWi8wxaxNJugbKnFPPaKGpmzScpOZTv15mZiFPtBuIY+cZGwWzzkayHb+AyV
         KT1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768916026; x=1769520826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GCRWv8BoukUYariTfudysMyZzqcHq5px1XRxiaHfVGI=;
        b=lAdokTTtHvpr2oPO+rLXARkSoZOIjum3J5OS+boHY2cmzmVGcwPq+JJl6ukmNmUKwB
         eqkx0UIGX1xLcfk//qZuyHa11tM4PBS3o6LCvVMl4op3kRzQ6fjJmN5xwlTiudQlqWxH
         fPgb1mYZ2MexeMVp/JKmf/x3yA1ow6NQVLJ9GAKEPu0HaNsZmXr/jewWhCIcwhb/pk60
         CMBdsyaUJfDL3ZjDv+HZT0QND+8WtXd7/Fpw3pLXEmDlv3fqmr+uU/2LYW/73VjsOvCN
         0SvlsSocuqb06/ckdPHKnq0qndckQZjuiaJvQbcStIro4AB2CJ6zA1ur+ZZY2f9U36aw
         XLCw==
X-Forwarded-Encrypted: i=1; AJvYcCXsZbfvyGeiP3uUNy1YhiKGl0aPFzouELU9dgT3F2+cxBFhCVrfLLuUnsJlyrR4mM4+p5EtHgNLNH8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3K4AsUJtdOSbE3IRfvKDFOpa5vpINGId+AeE31HxbDSwubBTJ
	we9I2fCyrlBoOm5+nf4ni+kmwyaBL4kZwxbD3YUNqXhNm3KP5nNgx9zD//LYjXKdcTE=
X-Gm-Gg: AY/fxX5oDO4NtWyKEs5xuxf8ViEb0azNmqBFZCF5PUhcuNuGqUkhhP8U/gY/sKxjx7Z
	yGdGWMo3ouOeiidwg0N3BSCz3bg1jG6pGw22RpQBCu8pCeb7wAKSZM9mMY/esQE5EaAOiKHmzBE
	i1Ui2z+oyr5RFxTHd5lwiqlyh1gS7auJ4XrmXIzb96l1/v897aFLe3HavXcGYq5dC8pm0GNQ1Gg
	+dfGowoa5XNA905iMmeyZXbdfwxUmoLNZylKNGpByMuDDysKJg5FiFvm7J5QGxtinB/ATATH4FR
	stw0jAr0BWO18wYU3S8m6pAELJ903kcDg1TNTYBTjQoyC143aNSUeerjTDv5vG+fApoF+vcvDt8
	r9VUQu6J2kme7b1k8gp7+rokI8S/vipT7l4NVqHLDG7ui7B5zlywRVCwF20+ClJyUmNZ2diuU73
	eVQ1wjlpUaiW5jRjpnqo/MfQQbIg9SS9dClgCAT/Q=
X-Received: by 2002:a05:600c:4f8a:b0:480:3c28:838 with SMTP id 5b1f17b1804b1-4803e78ffbemr25694855e9.8.1768916025719;
        Tue, 20 Jan 2026 05:33:45 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356996dad0sm29331439f8f.27.2026.01.20.05.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 05:33:45 -0800 (PST)
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
Subject: [PATCH v8 4/8] dmaengine: sh: rz-dmac: Drop goto instruction and label
Date: Tue, 20 Jan 2026 15:33:26 +0200
Message-ID: <20260120133330.3738850-5-claudiu.beznea.uj@bp.renesas.com>
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
	TAGGED_FROM(0.00)[bounces-8400-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[tuxon.dev];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[tuxon.dev:+];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@tuxon.dev,dmaengine@vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[renesas.com:email,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,bp.renesas.com:mid]
X-Rspamd-Queue-Id: 197C34D1C5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

There is no need to jump to the done label just to return.
Return immediately.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v8:
- none

Changes in v7:
- none

Changes in v6:
- none, this patch is new

 drivers/dma/sh/rz-dmac.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index bb9ca19cf784..cc540b35dc29 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -706,7 +706,7 @@ static void rz_dmac_irq_handle_channel(struct rz_dmac_chan *channel)
 
 		scoped_guard(spinlock_irqsave, &channel->vc.lock)
 			rz_dmac_ch_writel(channel, CHCTRL_DEFAULT, CHCTRL, 1);
-		goto done;
+		return;
 	}
 
 	/*
@@ -714,8 +714,6 @@ static void rz_dmac_irq_handle_channel(struct rz_dmac_chan *channel)
 	 * zeros to CHCTRL is just ignored by HW.
 	 */
 	rz_dmac_ch_writel(channel, CHCTRL_CLREND, CHCTRL, 1);
-done:
-	return;
 }
 
 static irqreturn_t rz_dmac_irq_handler(int irq, void *dev_id)
-- 
2.43.0


