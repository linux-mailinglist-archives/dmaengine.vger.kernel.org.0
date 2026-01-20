Return-Path: <dmaengine+bounces-8399-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPJFBLhAcGnXXAAAu9opvQ
	(envelope-from <dmaengine+bounces-8399-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 03:58:00 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 440BC501E5
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 03:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6EFEA5E45AE
	for <lists+dmaengine@lfdr.de>; Tue, 20 Jan 2026 13:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76176438FEF;
	Tue, 20 Jan 2026 13:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="J8Y9GtX2"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363DF42E001
	for <dmaengine@vger.kernel.org>; Tue, 20 Jan 2026 13:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768916028; cv=none; b=cP/rzFKsWJ/kTOZGE31Uiwn3hVQtWpAbMvTirsP0UxkQzcywtveSaFzygbAV/5K4LhDWDeuOgZHIClj6KV3liWJTtSLCfFC3aJN8FTqSKXQhz7efYkZOdD8CfcWILD0w+PCAZ/i2SvfpObTVtJX5+TioZSmllEH8928PtY+JPec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768916028; c=relaxed/simple;
	bh=W0PMYWluR4s+4ZGBLZytPjvzufu5cGFxS/9iOr9nc0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NLeX+sUrDz3GFhWR2vvKUHMpqxMjQjcjWZPX/bO5RG0aRG+uJ1a8FxPEbuAWnGHhMHGu6KITbav7/YTR3hDZw/KB+fbXaxNV7PhnNwx3GTuMmJQyY49t8vZ2XEEq0//RsZrmwDKbsELSuAvzvH+Zdz/+zR98UIwoQvYNRzrCRe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=J8Y9GtX2; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42fb0fc5aa9so3083905f8f.1
        for <dmaengine@vger.kernel.org>; Tue, 20 Jan 2026 05:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768916024; x=1769520824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VcUa3wgqVKrSdjpDcbTNWk0MXPErhZe+CUK2K28sdgM=;
        b=J8Y9GtX2BE1NxQK534ARSIktMOL6MgBuXAGg2HpKQin8UppVy6PtHukzsYoDM4JoA+
         mHeRgz39cbDqocs5G3cDEAISYey62BKFqn4hE+4eXqo4IxJ8hThWubmSHHyWTMdl4TWT
         Kl3uFdsjIl97bHBmT2emmbgvhxUbDZGApZq5zzUpsWX/3G1IslNDNR8cHHeBwKqHfSiq
         nbyskSud+QGdQPNRBjG96hWA50pcedxsV/2xHNnkGBY/hXDTpEUT7YZaJYUi+RdaU1ay
         OcXRnvTct1/dJHDc/ep/Zdb4KqEQ6ge8QQOgPy7cedOtj//YQITiIqk933G6RjkHTV11
         nJKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768916024; x=1769520824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VcUa3wgqVKrSdjpDcbTNWk0MXPErhZe+CUK2K28sdgM=;
        b=pLnYlgbE01UYT6H5DqDlL6hFBFHWUDs6oRH3OPy50rQY00Ox6QfjSjYlMPbxALNSff
         cCasFumUMMZG95AMnK41n3TGti42pza704mHvgfng5mvzurnIm04ItClDvv3UgtkmMfc
         kYSDyKpTvCqXbSPHY1Js2SbHqHMhob1ves5yxbc3pr/kF0d/44UQCXa1QggI6ms45Ycc
         50K9GkdQsTpr05wgs41akbV3CyAiW5yrufytCQJkI5aEe/9uyPn8j9C/WwMy7fEVHTpe
         enFwronkf4oVgt5Oj4x67rNx+QRnilppjrfuLPxVLoSTVY6Y0RZCXK+mhaUWkIRJi53V
         31NQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/664vlQslNRFfJBEPMTTIrDx4objF75axDrFnBQeAgmzQ+pX+2cJ99Zle3ZTIq4BtVAipBKTCaxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF7eDZiK2CiNIX4kZZNN/hEZkUCRXOGj0h9c4EeTQmulV1S9Nk
	rQUEEEHDFnKN5c0V3oe7XrG+kW+SUehGK2cwdb3qd0iD3Pi8sKRkuQiuIEEavwYr0zE=
X-Gm-Gg: AZuq6aJYh6ofwTINpwWvjl8mk86dzxOc17gaWEVKhanGzyS95Sghhxt2V6KwO7UBlln
	u/6qM8+Lz8432fLNF8r9zI7gSo87kLlkGj9faSNyndsdW8FLB+zkt+bK6ZJOirs3J+0GxoDvEJ1
	6wiPDKapQFdeyFwP2HwJn+b6AnwVMpgNMMyiYq30h4gSQOHgFFz5zL/GGN6a5Df93wtXEeIrh6F
	X9L2I6BvFM6zvdY1eIDk0TmYCcnmRMD/EJfIbWd+/qZYrGtXtsTEDEbLiMzc/KH2+NuGohUEPk5
	05QfY/RBJ15UH8xlifSttA7EyLOPMChFssKWV3KETXfAXpL7MAwrI3EBGnhWI7jyPRs3Kt6BwvI
	u0eetfUDHYlbIyqhvM8g2ICEdxmfgzf6L1w5DE3lDQO063LuZQbPMW7AUyiEAEabj9AknWNPtC3
	eEi+v3leu2kNRj+s1ypSl5BZNxP9Ihe6JxAowY/zo=
X-Received: by 2002:adf:f983:0:b0:435:6c8d:d017 with SMTP id ffacd0b85a97d-4356c8dd0d7mr16960338f8f.32.1768916024434;
        Tue, 20 Jan 2026 05:33:44 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356996dad0sm29331439f8f.27.2026.01.20.05.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 05:33:43 -0800 (PST)
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
Subject: [PATCH v8 3/8] dmaengine: sh: rz-dmac: Drop read of CHCTRL register
Date: Tue, 20 Jan 2026 15:33:25 +0200
Message-ID: <20260120133330.3738850-4-claudiu.beznea.uj@bp.renesas.com>
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
	TAGGED_FROM(0.00)[bounces-8399-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[tuxon.dev];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[tuxon.dev:+];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@tuxon.dev,dmaengine@vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,tuxon.dev:dkim,renesas.com:email]
X-Rspamd-Queue-Id: 440BC501E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The CHCTRL register has 11 bits that can be updated by software. The
documentation for all these bits states the following:
- A read operation results in 0 being read
- Writing zero does not affect the operation

All bits in the CHCTRL register accessible by software are set and clear
bits.

The documentation for the CLREND bit of CHCTRL states:
Setting this bit to 1 can clear the END bit of the CHSTAT_n/nS register.
Also, the DMA transfer end interrupt is cleared. An attempt to read this
bit results in 0 being read.
1: Clears the END bit.
0: Does not affect the operation.

Since writing zero to any bit in this register does not affect controller
operation and reads always return zero, there is no need to perform
read-modify-write accesses to set the CLREND bit. Drop the read of the
CHCTRL register.

Also, since setting the CLREND bit does not interact with other
functionalities exposed through this register and only clears the END
interrupt, there is no need to lock around this operation. Add a comment
to document this.

Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v8:
- none

Changes in v7:
- collected tags

Changes in v6:
- none, this patch is new

 drivers/dma/sh/rz-dmac.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index c0f1e77996bd..bb9ca19cf784 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -697,7 +697,7 @@ static void rz_dmac_irq_handle_channel(struct rz_dmac_chan *channel)
 {
 	struct dma_chan *chan = &channel->vc.chan;
 	struct rz_dmac *dmac = to_rz_dmac(chan->device);
-	u32 chstat, chctrl;
+	u32 chstat;
 
 	chstat = rz_dmac_ch_readl(channel, CHSTAT, 1);
 	if (chstat & CHSTAT_ER) {
@@ -709,8 +709,11 @@ static void rz_dmac_irq_handle_channel(struct rz_dmac_chan *channel)
 		goto done;
 	}
 
-	chctrl = rz_dmac_ch_readl(channel, CHCTRL, 1);
-	rz_dmac_ch_writel(channel, chctrl | CHCTRL_CLREND, CHCTRL, 1);
+	/*
+	 * No need to lock. This just clears the END interrupt. Writing
+	 * zeros to CHCTRL is just ignored by HW.
+	 */
+	rz_dmac_ch_writel(channel, CHCTRL_CLREND, CHCTRL, 1);
 done:
 	return;
 }
-- 
2.43.0


