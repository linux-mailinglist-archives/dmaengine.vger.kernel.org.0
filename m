Return-Path: <dmaengine+bounces-7751-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1819BCC81EB
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 15:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9EBE5308E672
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 14:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E041B37A3E0;
	Wed, 17 Dec 2025 13:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="l+sXsQ2O"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D13928C87D
	for <dmaengine@vger.kernel.org>; Wed, 17 Dec 2025 13:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765979554; cv=none; b=PEKo8E0aFc7kfITSvpFLNSn8AysxdS42tj+Akd/tlOXf/fBRrhWZ3k8WteN3olpozj/CfwUaefd7iKDUSQyZo3WZCvO5q1Q305TcVir9k+Bvc9U/s/XrZrF+XPeMeh+iwXrN0hZ5/s+tbLi8nygS5oQazx/PdRPmtB8qdnyxlX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765979554; c=relaxed/simple;
	bh=D2T7TmmZbGv18Uh8J4cdBHWJXJAc+GOKLv2WgixHQ6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VLodLaUYp3TQsPXPYP9CoaNo5ZF8hNxh7M2pVU8JmvXFMNmMV87bWX35dullkCp0naQJBIK07876r+Gbhk9khl3sUHDyufHlUnya44+Uf5BmQ3TCh7gdNC+bHAI3k4Rf9/6XxKRYGVuIsJBAdZhW5vcPOgl6ya1nLb6XK0yKw6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=l+sXsQ2O; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42e2e3c0dccso3174588f8f.2
        for <dmaengine@vger.kernel.org>; Wed, 17 Dec 2025 05:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1765979548; x=1766584348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OiurWDqD087A+2PBJW62gWLArV1oM1DnASwOeXGS6o4=;
        b=l+sXsQ2OOTrJj+cmkO6cJcjLJM67rKvXtJU8F/MzaxcxCHNrRs3ufrk4lEDk3bGnBH
         146y1mKHl5xJ5viXsnLkQl4aBkeFd/qgLhuElDFeKU0Tuw3E1hJayYzFpIaI9AaxJDjR
         CoTpNSuAYUq56xkndS5K12Txg467ztZT+sprHmQochdVHSwVqJ5tEKIdYWb52uRp5kgB
         Utium2ZbAiSTWzSJO41JMTZ8TNJL0AQhmnpWpBTO4mFNC0d+E5r2EyMWG/jqZxU9Q8NI
         RTsEwvR31II+AF7k+aAHiqER4YUxakNdHc7SHB98sRhr6SqHAfit+1UkyBUJ1u4HcVbj
         pb+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765979548; x=1766584348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OiurWDqD087A+2PBJW62gWLArV1oM1DnASwOeXGS6o4=;
        b=V/THYoVqNDy3gjge5P7U2dBpO1n+KY35BXgBjOZkBMz8kOHDE51INh3/qk5dimv8B9
         mmDptz8gOe1HrtVQNHsRRrjO2bGoPmme/778l6z+qwPH6AW+uglppLXM9l4OUzBDXIvk
         0DdHQSfLhRs+6z8aAVWbSPeqV4g0WsRZ7Zc7W7S3VBHLLxxfZwnWBK6K3JecdWZ68eYI
         5IRIo+W676yPa9dnUmJqpXGvg4z3UOND6V0mRae4uXj/SR/SpoxFoJaSGKos4gkiwEQD
         0TfKC8Xw/Exjhx9O9IUCRHY3sUg5k3I5gcT57kCfMFdKoZPmKuiJcCkMOMB9lV/V+FEj
         uMOw==
X-Forwarded-Encrypted: i=1; AJvYcCWT5sResFH53Vj9YQejnjHYeqmzkQE0dSa88EYGKTkoZTN832PQpNpu6p2UCbV938hM0YpeGnGRWFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBflkrHwK/icR3i7XErkJCpJ+7GqOSpunf8G65+epA3zblRmRD
	qjtpv836pCI9NLHaq9R8H6Z7fBmYgLS/4k3sNIbbvzhF2GpTVgpAI1SXQFN3M8F0f5U=
X-Gm-Gg: AY/fxX5h62iibB/tzI0BHnR1KNXdwEjGyEkM3zcBr/Abs2j21d+qTv0I2q+pcrPjh7+
	pZxusmaeYdnccCnC2ET6Mb190Ns5xFzgE3Xftt3LJ3FGNIrouK5DFhTLwi01GifyqwSkQLEFJNs
	94gq4uTVplSZ9bwExkieehXBiyc3cvS+UVrdQlUzOiHcf2I0I+CA7DWYFFVFeQ3hKSNCcNy/Si4
	Yzsq1oZSpSujSRys+ctrI8lmHuL4BhJbIOCTlsaqru3C48OyGsWA9paIEbJFxJ++0ncmSNx2qn0
	+Sm3JURnrh1p5QEpqqbTc1SzVK7udNA1X3iiUWv+l/4zzWmuKCX3sOACnIswOJYonP5XrnSvr7C
	edUmqwADilinvvcw3kYOH2WKylm6XUkyflBDfmrVYzQQxkk2iaEk8GLVti1pMzKPI/1rhwjix10
	kFrnwG2ZGoTton8yvDkZLV2zGtBa88myq3BlyzLb9L
X-Google-Smtp-Source: AGHT+IFBGJjaVHWPYOnuom4x2tvqUJvMTQ6WQNn312V9kRaikBmwm+H4UADRXnDowE0AWwmip+iF/w==
X-Received: by 2002:a05:6000:420a:b0:430:fced:90a with SMTP id ffacd0b85a97d-430fced09ebmr9829622f8f.16.1765979548201;
        Wed, 17 Dec 2025 05:52:28 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4310adf701csm4508000f8f.42.2025.12.17.05.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 05:52:27 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: vkoul@kernel.org,
	fabrizio.castro.jz@renesas.com,
	biju.das.jz@bp.renesas.com,
	geert+renesas@glider.be,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Cc: claudiu.beznea@tuxon.dev,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH v5 2/6] dmaengine: sh: rz-dmac: Move all CHCTRL updates under spinlock
Date: Wed, 17 Dec 2025 15:52:09 +0200
Message-ID: <20251217135213.400280-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251217135213.400280-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251217135213.400280-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Both rz_dmac_disable_hw() and rz_dmac_irq_handle_channel() update the
CHCTRL registers. To avoid concurrency issues when updating these
registers, take the virtual channel lock. All other CHCTRL updates were
already protected by the same lock.

Previously, rz_dmac_disable_hw() disabled and re-enabled local IRQs, before
accessing CHCTRL registers but this does not ensure race-free access.
Remove the local IRQ disable/enable code as well.

Fixes: 5000d37042a6 ("dmaengine: sh: Add DMAC driver for RZ/G2L SoC")
Cc: stable@vger.kernel.org
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v5:
- none, this patch is new

 drivers/dma/sh/rz-dmac.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index c8e3d9f77b8a..c013bf30fa5e 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -298,13 +298,10 @@ static void rz_dmac_disable_hw(struct rz_dmac_chan *channel)
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
@@ -569,8 +566,8 @@ static int rz_dmac_terminate_all(struct dma_chan *chan)
 	unsigned int i;
 	LIST_HEAD(head);
 
-	rz_dmac_disable_hw(channel);
 	spin_lock_irqsave(&channel->vc.lock, flags);
+	rz_dmac_disable_hw(channel);
 	for (i = 0; i < DMAC_NR_LMDESC; i++)
 		lmdesc[i].header = 0;
 
@@ -721,6 +718,8 @@ static irqreturn_t rz_dmac_irq_handler(int irq, void *dev_id)
 {
 	struct rz_dmac_chan *channel = dev_id;
 
+	guard(spinlock)(&channel->vc.lock);
+
 	if (channel) {
 		rz_dmac_irq_handle_channel(channel);
 		return IRQ_WAKE_THREAD;
-- 
2.43.0


