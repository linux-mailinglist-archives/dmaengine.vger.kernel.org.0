Return-Path: <dmaengine+bounces-8402-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONpNBHCTcGlyYgAAu9opvQ
	(envelope-from <dmaengine+bounces-8402-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 09:50:56 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7B953DE9
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 09:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 68E44708568
	for <lists+dmaengine@lfdr.de>; Tue, 20 Jan 2026 13:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8703C43C066;
	Tue, 20 Jan 2026 13:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="IuORIvlC"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD64E42E001
	for <dmaengine@vger.kernel.org>; Tue, 20 Jan 2026 13:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768916032; cv=none; b=fYzMGnW8997NCoeZYJs0d0c4cGy7dqozrUTLPn0Wl4vgYwxAJTEPzeEICubXRIqL+yMYoBmrM3OA/rbGBhn5NJIecFMhDApxBy7PEw5GCppKr8DNBH76eBcxznRmZSKudF5AqxstzaNHGh9FQqiZ10z3tqcjkgxj4ZrrIlvt8yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768916032; c=relaxed/simple;
	bh=Srrns1UbIhd+W/08Zz/FajPVxyWsymnEvTSHjcquxoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YkS5JpZMq+xmt+1Z0AjFN907Z9R26fbzuiIOcueqHmPw/eNDwSk5JiiymnDGjY8HKsUng9RawV0VM01xAp5bFu8kWDyEhUQGtfUo7dkEhYfrBDlR27Tlx18wqFrb/TdvzEOFuP2Mug9ugYAvsY9PIKxAw9WkXOceTxC2QRcOUzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=IuORIvlC; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4801bbbdb4aso27678035e9.1
        for <dmaengine@vger.kernel.org>; Tue, 20 Jan 2026 05:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768916027; x=1769520827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MV8DeVgKKaG/bWcnGvfHKBTE2gBrbH2K1tyqM9pJWLk=;
        b=IuORIvlCBulJHSjzNd7BlDcuIfjId1s25m2v3ni88fAn/0FWB9FQIJy/SXKqnyHYvD
         xolALuacTXK3Hr6R1OEcKYtG8YqHUKVpArhzTTyTH0sIXCb/zNnx2N35VcGNcwVYmKcO
         F/rCtYzDpm3tc/ffsS8tzhRW4ty8ujuBqc5K6Omk2hxP2m1FC8NmaioOQCNHPVtMGMG8
         4d/jFzcKvOeqJibqtzHE15qDZbOnRD2QmAvS+LkGdRAcXd2Mn5sVZXyr2u64+fRHhuIr
         BraKOy+WwP90NblFxE4Cx9RrwR0OIYIonWJBFBr3V+u7+1lIeoCa9iXSn9uLcVjVxMpw
         LJDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768916027; x=1769520827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MV8DeVgKKaG/bWcnGvfHKBTE2gBrbH2K1tyqM9pJWLk=;
        b=EBlqqSzhKGl6y7qQa88DUe0RcXY531DTH/BGLQVyxUlPkb3giS3oT29mNBrg+d1p4M
         uKXs8vvHperFk3VarzQ5ZmVurVLpjCuMGo9pHWh9ydd/3engBNLLLsjMGjGRLqhv4sT4
         UYsweONwXm9z6K5Q+kyTcOPO0VNDd5GDfaq/lv3OeeBxspT+LNuYBRldPOFgv31mhbdF
         L3kRAHf8BRUopWo1EpHpC7VHjXuJGW9Xpq/kvzuYwW4u3gXNOihY+VA89YHbqghtR1IQ
         PkfgSNE1NjjEZ+qB54dfBeOIcdoHvvyumiyHLTapDxyNZj+3eF235Er6DIewAIQq6P7Q
         9iCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAwo+PMZOhNyYx3GhzmnJyq2ZKcA/KcNQ69ryf+GkQ9+ZzWsGtrEE/lphlzuHHO9yjLN7tDMMXWsA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhGCQSjt4aIkw8/i9tXgzg2/VnHLRqGFt5pDMFY+Dot+au79pW
	GS8ccmMu171OmdRwJQK7Bc1qK65zn8xtCLHOKWSI3dqIlBQwgWpXJmej87+aMGVQblM=
X-Gm-Gg: AZuq6aJ8WO2QfI5dHs1GHtD3z3RbMpbM5wsofSuNgZWylfpex0fKdtX3aqwkhRtnzei
	7kIctGEnTvl2++fObKQAZk4ShqoOGDpn0sMPlFoVO9v5trdgkqpQC0p0P2q3k38dH4ryy7mOcZK
	PzIpC3fdLZ5Ma5xaK7OPnw/lIRY4K7NoUZ4uELh5xWm7ZhtzLTtZD1pmmRsjRF4kE824XZzC9ZE
	ljPePkPj1r2A0Hi+WyneZ3O5yULw5om2rYboWq/ouNPj2rPLuj4Ey9ASjnD8FHS69TGDxANC8Vn
	nQmDTBzvB/XKgGU4wAJdq3qz7t+jedlYIdLnliybYGeq3EEcZHwnJsHQPUDYigfd35TlneqkIck
	IsaMQAMcbJLiJlOSxCucQJidvYstNuvG6EyzUudfYYSGMMDwu0CfZWB5RC8Tjf+ifvgbSz6941a
	Hb8YvDHLqELZLB8bQqfdQjMHqF4yJ50cGUFJl2TNA=
X-Received: by 2002:a05:6000:25c3:b0:435:953e:5897 with SMTP id ffacd0b85a97d-435953e5bbcmr1722508f8f.25.1768916027069;
        Tue, 20 Jan 2026 05:33:47 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356996dad0sm29331439f8f.27.2026.01.20.05.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 05:33:46 -0800 (PST)
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
Subject: [PATCH v8 5/8] dmaengine: sh: rz-dmac: Drop unnecessary local_irq_save() call
Date: Tue, 20 Jan 2026 15:33:27 +0200
Message-ID: <20260120133330.3738850-6-claudiu.beznea.uj@bp.renesas.com>
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
	TAGGED_FROM(0.00)[bounces-8402-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[tuxon.dev];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[tuxon.dev:+];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@tuxon.dev,dmaengine@vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[renesas.com:email,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 9C7B953DE9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

rz_dmac_enable_hw() calls local_irq_save()/local_irq_restore(), but
this is not needed because the callers of rz_dmac_enable_hw() already
protect the critical section using
spin_lock_irqsave()/spin_lock_irqrestore().

Remove the local_irq_save()/local_irq_restore() calls.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v8:
- none

Changes in v7:
- none

Changes in v6:
- none

Changes in v5:
- none, this patch is new

 drivers/dma/sh/rz-dmac.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index cc540b35dc29..1d2b50d6273b 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -273,15 +273,12 @@ static void rz_dmac_enable_hw(struct rz_dmac_chan *channel)
 {
 	struct dma_chan *chan = &channel->vc.chan;
 	struct rz_dmac *dmac = to_rz_dmac(chan->device);
-	unsigned long flags;
 	u32 nxla;
 	u32 chctrl;
 	u32 chstat;
 
 	dev_dbg(dmac->dev, "%s channel %d\n", __func__, channel->index);
 
-	local_irq_save(flags);
-
 	rz_dmac_lmdesc_recycle(channel);
 
 	nxla = channel->lmdesc.base_dma +
@@ -296,8 +293,6 @@ static void rz_dmac_enable_hw(struct rz_dmac_chan *channel)
 		rz_dmac_ch_writel(channel, CHCTRL_SWRST, CHCTRL, 1);
 		rz_dmac_ch_writel(channel, chctrl, CHCTRL, 1);
 	}
-
-	local_irq_restore(flags);
 }
 
 static void rz_dmac_disable_hw(struct rz_dmac_chan *channel)
-- 
2.43.0


