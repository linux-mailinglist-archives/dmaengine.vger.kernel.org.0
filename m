Return-Path: <dmaengine+bounces-8109-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28EFAD04417
	for <lists+dmaengine@lfdr.de>; Thu, 08 Jan 2026 17:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0CA593074F4D
	for <lists+dmaengine@lfdr.de>; Thu,  8 Jan 2026 15:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BF13921EC;
	Thu,  8 Jan 2026 10:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="rSz7bJTD"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEBD4B8DD6
	for <dmaengine@vger.kernel.org>; Thu,  8 Jan 2026 10:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767868600; cv=none; b=Q6vvQJntj/ZNG5GnGqp9K3jRQP1isffKJJoMwHLAic2MvQKKnjMNmYxIC1o6EzD9fYi6fT8U/wKmjDlibhdGa1ilpvXDVX/XCUYOaxrlqnYuym7eTdY3K65TdhGlcHjAMd4nRfTDh4NTcq2zxx5duH/xYgFOW4P6Cx28OK1gRdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767868600; c=relaxed/simple;
	bh=HETVrG2xXKuP/JPJ6ag7HnrtvAYHmwaCMinWzd9CPyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=naPXmhy9DVvshPIBftc6eUm/EuXPmBC3XQ//F52uXOTLBWwV4fzZN6zskli5D0ZZkDDKtq4vQn3uC+fomMRmFjAQIld0DSsh6Q6lcbPj/A0vDjpTq+/tnGqGzvBinpgknqSlXxv+jLheI2ICNFwbnehSOy5WaS0vQZOxP08ls6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=rSz7bJTD; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42fbc3056afso1627569f8f.2
        for <dmaengine@vger.kernel.org>; Thu, 08 Jan 2026 02:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1767868586; x=1768473386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZBsL+5U9mBQbUpXgenVPfjce381EbAdS3YvmQ5cZZAE=;
        b=rSz7bJTDHxYiHge7Dky7s3miRn37Re71RiDqQLpmOA9l5498YzGQSenEgwqYzhMTkh
         St0CDCuE7cllfVYGsathm6hD05jto9xKTgRqR/MfqZ+0D9K/Q6Achl5N5323w6o11uaI
         rU2M8PZdM6eB2T/0Arm62wy93a72hwuvkIGEV4oN6aea5wFY6NIP5RRqdUj8RJ1b/014
         UlT9nHQtHVguUTUsKzDTxHPI1abwmgmnIAlu5KUHv6AiACLSYgrESXymQoceJKlIhJC2
         G6rjWJ0V0G8cOiQOzY4qhGytmGigvP3PR5x+8lMny3VBGJ74UyZlE5Gp9dw3yjWmMuiJ
         iunA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767868586; x=1768473386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZBsL+5U9mBQbUpXgenVPfjce381EbAdS3YvmQ5cZZAE=;
        b=aumTYL9aCxVCnnrfzOKR4sUe8A+OuOFI5pfjou4fhfJdyR+8XDwsHIQBTDRkS72WpF
         lI7qcd5sE+FpvunwE44iYAhl+ZH5i9XWzyP5TwcgPMjklQq4bxMorriyxB2kkqXqDAa9
         7J8tHRO4BfMDfw0xVm9IDewmXEKgB4JGtg7+yUbikmsj4gW09EHsXXsiOsnwUINk6gQz
         YzXBRXsU8W6qnqEpGV8WArHF5EDgenPn4BFpCSX/WwhkQCj++586D4XVFieCXNrsFRaI
         U1cDeHhC/uGd1WyorwcGDcu48gOdw6xpv77VXJYx7wrbX1g6HLf/VOOp6lRJKl7guSmH
         0ujw==
X-Forwarded-Encrypted: i=1; AJvYcCXgbvSgxfCWbATMNbGQWSBqpnDvxuGtffQ03EitOtZXd6Ftqb8M0V6W9HYI5qQqm8mVi1n98HbSbkM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAL9VG6DZmGibBi427f25CKkyfgMhpgR/N1+CiPGyB+TWGCtTX
	bKhQeaDgytlD0Ix2DS7bR7+XsOGsW0CVE3L4luZeXTvYFflNVeBJ/Mvv0aGnbbHVdVWEZCQkdwx
	At49a
X-Gm-Gg: AY/fxX6JTXmK+uTCUsMHVJ7vB+e2lkMwBHQGSmiQYpuxUUEAKqbo55ZLbE3ELN3dvsU
	Q+4mjBULAozD236jU4S3be+e67zj82ezWn/3azmJU0uICQJR2gLfrayYNYIpAE6vDJhd9SZ6O7F
	G5nZxWF7H3Rse8gNEADr8bYTQttgZoo/p3cgJBTUDBtTN698OmSNmX8aCVQXVjHxhshIVYAUJhZ
	WokC5BfDSEuoGG6oWHIyNdexPogYWM7Bo8ALtoufPgATVHwTRbzN2L1MUOlB8k7ZuPf9bL0OvXj
	F+A8FKNZb3oWdkZUStD6BdAQE7M6G0uGaqJNF+AEWBkTIJ5/Z/U3e616LsXPXYM0azsUIcdiWUa
	V0m/XA6+0KQvIYLAACqdntL/eB4aTzBTZbQcp4WiPYiwnjOXJds/vuQvuHnB3lX8ksqmXrq0TAd
	tD/lCRxJsJHTLgtDOJA+rQLE1RO0bH+eSy0Y+wtnM=
X-Google-Smtp-Source: AGHT+IFN6hOBhvkM+I+ctFJfN3aGqoA1MUMOHG5e0LucOvl5KGhtkxH/erS6N+bFoWDZhu8EOHkqFA==
X-Received: by 2002:a05:6000:2913:b0:42f:b871:66b9 with SMTP id ffacd0b85a97d-432c3778dc8mr7189927f8f.56.1767868586329;
        Thu, 08 Jan 2026 02:36:26 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ee243sm15399033f8f.31.2026.01.08.02.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 02:36:25 -0800 (PST)
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
Subject: [PATCH v7 3/8] dmaengine: sh: rz-dmac: Drop read of CHCTRL register
Date: Thu,  8 Jan 2026 12:36:15 +0200
Message-ID: <20260108103620.3482147-4-claudiu.beznea.uj@bp.renesas.com>
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

Changes in v7:
- collected tags

Changes in v6:
- none, this patch is new

 drivers/dma/sh/rz-dmac.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 818d1ef6f0bf..43a772e4478c 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -698,7 +698,7 @@ static void rz_dmac_irq_handle_channel(struct rz_dmac_chan *channel)
 {
 	struct dma_chan *chan = &channel->vc.chan;
 	struct rz_dmac *dmac = to_rz_dmac(chan->device);
-	u32 chstat, chctrl;
+	u32 chstat;
 
 	chstat = rz_dmac_ch_readl(channel, CHSTAT, 1);
 	if (chstat & CHSTAT_ER) {
@@ -710,8 +710,11 @@ static void rz_dmac_irq_handle_channel(struct rz_dmac_chan *channel)
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


