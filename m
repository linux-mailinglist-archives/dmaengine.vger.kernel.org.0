Return-Path: <dmaengine+bounces-8108-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D4483D025C8
	for <lists+dmaengine@lfdr.de>; Thu, 08 Jan 2026 12:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F0755309835B
	for <lists+dmaengine@lfdr.de>; Thu,  8 Jan 2026 11:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1531389E17;
	Thu,  8 Jan 2026 10:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="gdjyhQKW"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD3D4BB0A0
	for <dmaengine@vger.kernel.org>; Thu,  8 Jan 2026 10:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767868594; cv=none; b=hNtG4phujjSa7B4oGMRzujgbRYW593eRltj4gFNA3Kuz6UHo0QEAUfdRxfi9AWFaAnHnxXC+5Z21mkDSuVgE+oteka7NlyDEuhPV4ALRoMaTrOOxnhVmu90rlnwNPne60QKMzYS/rATBtIjM3Jn6aET3ZHt8UBksDFsAbnAq3rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767868594; c=relaxed/simple;
	bh=cKZhuVFO1q2xfKQugBDH5m/0EIcp/48jwQv4HFV08PA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CjuyOt8yOSO3uazlec/nr+Jtv73U2h+OUnItVc8ouI4ABUqiQ7tPKPvNuPI7B2fqTgdw48A1ltwm7ZaR+9khqePfbLpUfTXUw+5hcPYAAYTkwRvNLBO2bxRWuTODQ0TCQsZN7gJZnbafQvjwHIQOeEXFuMItNH/sFCEEMpkgc1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=gdjyhQKW; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4775ae77516so33426215e9.1
        for <dmaengine@vger.kernel.org>; Thu, 08 Jan 2026 02:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1767868587; x=1768473387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YLrl6GiIePCtteP1jR08IO97Jd422famCxZr1GzvOdM=;
        b=gdjyhQKWBvGcyhYJr5XKaFkbYr7XCHoS10ATr4Us6K9RX0igBlf7PTRJ3M4VaiYS4w
         c+sV4PoAmdR5cqCoC04U+zZpCtU+gedapZKLN0mVeKSDZguK+UWiC5pqpz1sByPqTysD
         YOMfAgmFCh9uSCXpCnWOy8RpAUf/BOM3PzhoP5LwY/9WvmX4FdWbFnUZUlaSSNvwfAzk
         LY99KpKjFgNXCd1Nzp3k0a/7LtnqLZ+4DNykiajhb+o3rWHMZuZdiRY0LjphDqzGCsIs
         byOeM8pKlNZkznHGxw+fSpkMuTFQe1LakHlCUnaxvWnUkb7rQP2YNv3v+p0SFX9qD0cb
         qflg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767868587; x=1768473387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YLrl6GiIePCtteP1jR08IO97Jd422famCxZr1GzvOdM=;
        b=flHIm38EK4DgYjvhBO7TGhH2qRxbahlcXJcuE5b30XMr1N7lEB3Gm+nOzZuhRrWi4/
         ufHIcWtzFahyyHEzB74CVp14l4c7kIt5NRRKQd7SdQc8kCiT5qHAlbKMdbL3SFkUAtM/
         2BtlIXG9azR1nlBMmI3OPythaEH2ShAgStnBgXLLhJ8yblWp6mYR9Hh/+uhbTrsAdSBw
         t43SDJNBl83KsHmn0KgJswqye2dBDpaLgeF46cmQb1MJa9cgvZx58LlfOu2PK8G/gJMu
         EVf6EAWFDCQNELtFbEe3S7h/2A9hDrMz+0PMfs6NhWljN0aZR3vfO24++Rr48IJH2PRl
         mCuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCCsV9FjpaT779bboS5GOQ40R4zRqyTqLYSdI24oPI9r+QRFA0n3xN2VMQNfqrhoJcSJEuCwj+13s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNgmJBNcK02HQ6tsJQOaiuEjJCqunVROuegVIBe7W7Dt5yGH4d
	GmkLtbQqCYl8khez57BarDAUkmy6kM33bKA3nHXpJ33COg5Ak8+9SqiHZ4RhM7DOTbc=
X-Gm-Gg: AY/fxX4FtQ4qs9jokwI796BtITXH7dVYLblhVrbKI7QcTTtqGh/BM6SHBCWTc+BfP3I
	CzhqBEapuiSMwuSJ9JEdX3hhFdPoLFCBpk3+KBe1obroKNzKGPv1fwOyU8pzOnnjedWQdOV7bzS
	5/QSrAl9WToBISF9pInEQkBeyzMUXE12JiVzVE87zVDAOQGRaKExPtuw1lT9euFTBNkMu5skLnv
	LLjAetMqow0zIMnrEOM9aW4JvFwYKyJLdjcQ3uHMPRAlS/CNnNR37e+s5sfFMR6X3hJ3diseogN
	zmnQQ7+UU5Eezry7W60MVv166oJZO7rLNZxnzmaq+Yrgy3h51omG0VP4Yp2+MKRXPhjCIdxJELx
	L15sC+o+ZnpMpXKLhjG59/7jDI59zqt53VQMF1cLnhfd8a8fRjRwJZQW/DmqOfR+IuV0WNkxVjJ
	lxPCebxbO4tx1sqmzz+/PUKRBSqd6NXKKM79OU9yE=
X-Google-Smtp-Source: AGHT+IEeoFFEPeqUu/5dUdvSI7Ttbgabj544hEOiXsYJUJMKsoX04E+p6Y5ieTX7aNcxvUT+g71maQ==
X-Received: by 2002:a5d:64e3:0:b0:430:f68f:ee7d with SMTP id ffacd0b85a97d-432c379b79cmr7333948f8f.47.1767868587539;
        Thu, 08 Jan 2026 02:36:27 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ee243sm15399033f8f.31.2026.01.08.02.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 02:36:27 -0800 (PST)
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
Subject: [PATCH v7 4/8] dmaengine: sh: rz-dmac: Drop goto instruction and label
Date: Thu,  8 Jan 2026 12:36:16 +0200
Message-ID: <20260108103620.3482147-5-claudiu.beznea.uj@bp.renesas.com>
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

There is no need to jump to the done label just to return.
Return immediately.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v7:
- none

Changes in v6:
- none, this patch is new

 drivers/dma/sh/rz-dmac.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 43a772e4478c..a2e16b52efe8 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -707,7 +707,7 @@ static void rz_dmac_irq_handle_channel(struct rz_dmac_chan *channel)
 
 		scoped_guard(spinlock_irqsave, &channel->vc.lock)
 			rz_dmac_ch_writel(channel, CHCTRL_DEFAULT, CHCTRL, 1);
-		goto done;
+		return;
 	}
 
 	/*
@@ -715,8 +715,6 @@ static void rz_dmac_irq_handle_channel(struct rz_dmac_chan *channel)
 	 * zeros to CHCTRL is just ignored by HW.
 	 */
 	rz_dmac_ch_writel(channel, CHCTRL_CLREND, CHCTRL, 1);
-done:
-	return;
 }
 
 static irqreturn_t rz_dmac_irq_handler(int irq, void *dev_id)
-- 
2.43.0


