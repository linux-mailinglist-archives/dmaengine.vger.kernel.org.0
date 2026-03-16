Return-Path: <dmaengine+bounces-9432-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLNNG7YGuGkWYQEAu9opvQ
	(envelope-from <dmaengine+bounces-9432-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 16 Mar 2026 14:33:42 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C6C29A794
	for <lists+dmaengine@lfdr.de>; Mon, 16 Mar 2026 14:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F3E6C30172F8
	for <lists+dmaengine@lfdr.de>; Mon, 16 Mar 2026 13:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456BD39A7F5;
	Mon, 16 Mar 2026 13:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="q5I/euFS"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8813039A056
	for <dmaengine@vger.kernel.org>; Mon, 16 Mar 2026 13:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773667989; cv=none; b=L753n03amYZWmo9N4oYhxaxIbWtkckrOQicZYeF2Gm/rsEhFPKQ4REsXAIfsR37MdDgux+dea1meXhYRPijUnA3z4uLeuBa2HwSbM2iBABP7SzgeVLIGwD6XZ8yIBIlMuTKiNNik0L1fXot/AUMqL9uMXrb99CxHBJ5koyuDqWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773667989; c=relaxed/simple;
	bh=HHBTFy4zMHjrD5CSXhgI6Vm7bW76Ah/euPxJ1LSRW1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AkJy9CKpl6xI2W4Kp7256haA+FPzmIwDZkaKro0HHExUInN+/fRciQ7Cxeu0QQAtJ7+OERPVsiemzO19QhxOj9t6m4rtjw2IPykcLFIkPIN30Yy0E7ysg22jBhc6IUY4qOCXawcDa9WiECrxf7bJrJO1JAvsyRFWHH/KdGZzA7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=q5I/euFS; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43b3d9d0695so1275311f8f.0
        for <dmaengine@vger.kernel.org>; Mon, 16 Mar 2026 06:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1773667986; x=1774272786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JgZptLTx0r+9WdLD0VCkYl5EKFDxApu+RZvQ4Ya6Vgs=;
        b=q5I/euFS/li7/YUzGvqzgaPCBpyOswmLtcu9qnJx/hZnoJS4heLU1J0q4NuqrIQTjG
         MmeZ1PvPznBOxC0qUm5EuNI2PBUsc4bWvEB8OWqNUaBkKJmrdGzIbatVzCh5aWLREXKs
         Hm7Lc0HPZ1CwE3C9kL864ZKJxgchxOm15pw75PKqATkUgm/frN8cLblAwW2+qEgAeb8F
         AIQ1uMk0NN3QWIHSlhbmKK6VjTrQ79izJ1OBugm3V8Rhj+l8E8SVjMJPkJA+vjaSalFt
         rKp1XkSAzcgsVLh0rSiPUroDys8bWbk91RQhbIY6ny+TLW8FrXMT0TyCv3rIE4cQsVoR
         tp9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773667986; x=1774272786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JgZptLTx0r+9WdLD0VCkYl5EKFDxApu+RZvQ4Ya6Vgs=;
        b=h6C6/E6uzpDtFy/IwGlP9u7jibbIoMjwPtwqTjLt+ZfEEoCNAOPPNs3EKaSg0O0Q12
         FD25XD1SUj3hvO0JwYhqNQtQM2LLYEK8AG0wJesT6GKmv1T7eVu80WOxlHT1+rAopuvz
         2i4aTJcUyG7ezu3BvszH2Sgh+EbdfsUUODfhnMt4mpG93difLJciEOYPQP17FwaGrzhT
         UwtmD3o5XPmOC2lsOLWMGBJcOQUATAKacLl6/uvHK+RErPp7uY5ei6V1uS59xDm6yTKK
         v1WwZDRXttkRVqbyropPirshILVLQ0pYw8ayun5OC3Efj+j6fF3BAR8dqH52mb21wrZY
         oPGw==
X-Forwarded-Encrypted: i=1; AJvYcCWbxm0IwdsI9TqBwkKwhPnGSgZIGNH6h02jRCcEVdJvTnuPctusiqjaYKw2CXK09htFDTJvd2Fx1mY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmv+VnQn7MhQl6ICJcm4Wq1hQQm1dJs7A3qYeRpRK+rapTaW+M
	KmgVSqvIbkMlKU7SiKX27CxiJohai3AoyY0S4Rn2baYB4akcjdiDRBaCl4maFMOe+Sc=
X-Gm-Gg: ATEYQzxFUSFFef+lV06w7TWvMRar/zwi+/w2FJMc+di0iQpvsxYcEy1bRVyu6UNuOha
	c3djTapk1JOSlyRrawbun2IQzH35I21iongyWJxYTLX/J0UqvtFl9Y74Cy97iUWfqh1ir+9kUad
	W62nsMuS2WOBUSii41QKZSPCnWjFlSAARxfIIFLvazHSkStXkwUAwUQdcIVV5/q8W96wGiYMaDw
	GkAhFVvEeN1fRgmcKi6JtPZeucbNnN7yal9D/cWRsr8XzDOSrGqbUhyb5nZBpmdf3qAcZHP03nL
	5SC0RVR2pQURZDsFsJcOzaBHFNdSujwRsx5uUQzpfZzi5tYit2kQ1T1mpf1pFqy5jX2zalm2cmn
	F15w6AIVdiv54e+E1umAC429sHXX8APUURDqsC/7gYs2trBYU1+qjLeEkPeJ1EzbkuvIoCW8nhq
	YdTwL+k/zI4wBDFTBNmMWISDj6092jIC/F8fNP21LvwntwyydexfmCmcSnO9/Fief8tLJiNlwT7
	4fni9N8qxv1SNMj1A==
X-Received: by 2002:a5d:49cd:0:b0:43b:4746:7cf7 with SMTP id ffacd0b85a97d-43b47467d5bmr2174740f8f.24.1773667985830;
        Mon, 16 Mar 2026 06:33:05 -0700 (PDT)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([2a02:2f04:6208:0:c5e3:3624:ad1c:6b4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b419270efsm11629888f8f.16.2026.03.16.06.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 06:33:05 -0700 (PDT)
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
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v10 2/8] dmaengine: sh: rz-dmac: Move CHCTRL updates under spinlock
Date: Mon, 16 Mar 2026 15:32:46 +0200
Message-ID: <20260316133252.240348-3-claudiu.beznea.uj@bp.renesas.com>
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
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[tuxon.dev:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9432-lists,dmaengine=lfdr.de];
	DMARC_NA(0.00)[tuxon.dev];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[tuxon.dev:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@tuxon.dev,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 56C6C29A794
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Both rz_dmac_disable_hw() and rz_dmac_irq_handle_channel() update the
CHCTRL register. To avoid concurrency issues when configuring
functionalities exposed by this registers, take the virtual channel lock.
All other CHCTRL updates were already protected by the same lock.

Previously, rz_dmac_disable_hw() disabled and re-enabled local IRQs, before
accessing CHCTRL registers but this does not ensure race-free access.
Remove the local IRQ disable/enable code as well.

Fixes: 5000d37042a6 ("dmaengine: sh: Add DMAC driver for RZ/G2L SoC")
Cc: stable@vger.kernel.org
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v10:
- none

Changes in v9:
- collected tags

Changes in v8:
- none

Changes in v7:
- collected tags

Changes in v6:
- update patch title and description
- in rz_dmac_irq_handle_channel() lock only around the
  updates for the error path and continued using the vc lock
  as this is the error path and the channel will anyway be
  stopped; this avoids updating the code with another lock
  as it was suggested in the review process of v5 and the code
  remain simpler for a fix, w/o any impact on performance

Changes in v5:
- none, this patch is new

 drivers/dma/sh/rz-dmac.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index ec1b6b00af76..e2d506eb8194 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -303,13 +303,10 @@ static void rz_dmac_disable_hw(struct rz_dmac_chan *channel)
 {
 	struct dma_chan *chan = &channel->vc.chan;
 	struct rz_dmac *dmac = to_rz_dmac(chan->device);
-	unsigned long flags;
 
 	dev_dbg(dmac->dev, "%s channel %d\n", __func__, channel->index);
 
-	local_irq_save(flags);
 	rz_dmac_ch_writel(channel, CHCTRL_DEFAULT, CHCTRL, 1);
-	local_irq_restore(flags);
 }
 
 static void rz_dmac_set_dmars_register(struct rz_dmac *dmac, int nr, u32 dmars)
@@ -573,8 +570,8 @@ static int rz_dmac_terminate_all(struct dma_chan *chan)
 	unsigned int i;
 	LIST_HEAD(head);
 
-	rz_dmac_disable_hw(channel);
 	spin_lock_irqsave(&channel->vc.lock, flags);
+	rz_dmac_disable_hw(channel);
 	for (i = 0; i < DMAC_NR_LMDESC; i++)
 		lmdesc[i].header = 0;
 
@@ -705,7 +702,9 @@ static void rz_dmac_irq_handle_channel(struct rz_dmac_chan *channel)
 	if (chstat & CHSTAT_ER) {
 		dev_err(dmac->dev, "DMAC err CHSTAT_%d = %08X\n",
 			channel->index, chstat);
-		rz_dmac_ch_writel(channel, CHCTRL_DEFAULT, CHCTRL, 1);
+
+		scoped_guard(spinlock_irqsave, &channel->vc.lock)
+			rz_dmac_ch_writel(channel, CHCTRL_DEFAULT, CHCTRL, 1);
 		goto done;
 	}
 
-- 
2.43.0


