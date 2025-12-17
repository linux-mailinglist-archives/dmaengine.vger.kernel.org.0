Return-Path: <dmaengine+bounces-7755-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8F1CC80E9
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 15:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 04F4F3011BD2
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 14:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3174237A3FD;
	Wed, 17 Dec 2025 13:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="erR89aGM"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AC237A3C7
	for <dmaengine@vger.kernel.org>; Wed, 17 Dec 2025 13:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765979560; cv=none; b=Hr2mAHkJfGyWdrwWSvIND+iNsZoJq62QiGg3+8HKjebRn5ugPCJiuaPNBiEVW3aV294lOcUkcZYDPcUZgohKa93V08ngB3Stpm6vrMFJcWv/vbSFIo+CaaoquQRq91hjS2JG0eERbVz7vJVPlyDNFXbjGFoPbxd7Bgr5JqW5k9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765979560; c=relaxed/simple;
	bh=aJfLLPMUp+evG2AodbfJkm/nqB5l1BtlKMvcSM3zLIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p38WjJOtmglGcWeKehXQ9zZmbW+n72DreCMR2TLgQEpyHjNMZAmLWJHhSKrzqxr322FwSsGQ1baWpCO53GKgwFzwdk/0zv0sxDu9jHgWuOruMFwLU/KZm93/agiJkmI8s+ESwOdgovSgeFuhqXuS2tCLef3ARnt2Lpk5w0al9UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=erR89aGM; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47a95efd2ceso35757565e9.2
        for <dmaengine@vger.kernel.org>; Wed, 17 Dec 2025 05:52:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1765979553; x=1766584353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XPB2Urq/Z3LIE8SZWsDGvZUfi7e7of7RJ2VsMzFAP2M=;
        b=erR89aGMZHrmCesFJKhvjqTaBk8VOVAQHRX3YrWGZebjFQbArAgjpkQUxYa2USD7Rc
         NiR01UIHgEjN49iKFq0NcTK1t6iIPICYBsWMQOBlKwiVIjEtDtzb18JOIVXvhPki4AuT
         6bZ8ES9vmG/WIToWIC+wdPOaAWONWeODAhsr2CfNl7SOzvO9TvMRFsKhbEIko0Q2uckT
         4WI/MrM16dZzU6ecn5x0yXR51+NOIVIJsyqb8GS4cIkRMDr99uLPKIVTs8/n/CZfS2+q
         cKXAaZLcwSepAV8yDImKM7V8MWBgcgHB6NLqzF/8jiMWXoofjZj5Z3Iwz7rDHaNt7whT
         IU9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765979553; x=1766584353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XPB2Urq/Z3LIE8SZWsDGvZUfi7e7of7RJ2VsMzFAP2M=;
        b=FP94jB49uE8cQEbyrJbOhCsPhQJxXbRD5uVu2hVglnNHuRkYiIh0AOvPdkkzET22c1
         BsMmIqT9J1Q8/Tmc51J9IOuCjqj2ZkyF35haYfBws9bzTytkIr3YOjcXAvPgSIMKK+73
         tbBVJID4M/zYglOwfWeEexot5hHDien8tlQJUZEs0FEkdb23PPENd0IdGTaNdl0zw+uk
         e5N4oN5W4USIG3FSyZdHEnIv4Kk9hNqmNnjAwZilTAt84Oz6drjAuGySuQCkjZdsWQbM
         Gd2lmy2nRvCCe06UsYQRe264d6+Yx4qgFCuQ6whrXn0EqHKFXsHNtmvsMUd+wTFC88w/
         L6Qw==
X-Forwarded-Encrypted: i=1; AJvYcCVtnGatJbM5ilEGTV/MuoEg8m0wOlnI7KE1rEeNfSKHdmegXq3HnbSJuHWxf3tIoPJ0PLbDl8rKhnY=@vger.kernel.org
X-Gm-Message-State: AOJu0YypowhIj87XPqqRYz6wfQbjKe9bARC5HQF21Qh7nTZmxDefOrTw
	IB7dd7diFjFu3+GQGPWzfU5WkhHaaHpJg/3QtIQnYgGIuPR4rtGb31JMNEHpqr46f88=
X-Gm-Gg: AY/fxX510788YkRWDWx3NTWSziK0LOTpX1gR2xGEGyAm/CfH2C+KtNDkPpZ0Ldgu4/M
	hWhEW97t93iDvxlumP5X5cvfua59Ku8zsZtMIrJiXkbCF5WAg+kqVSekTVZ2txr/ziJXmev8QGz
	0cwjilNy9oiByktf05fRmALgFQl//46b1Kh352RSB2C8acA5PhAIUJJ7qE1wlgJs01cJZg4/Wh+
	QCpBV1YPXf7TQZNnlsTCd1Br8WMt1I6G+rHMXuVgRdNazCPjYcJMv/xF38/gjjlYJtE7l1A2GA9
	4LM06vWx2KD/W1DBHMuPTXqyybsZIKxHQg2ZjGrUrQseX/jKAqk/xt/Vl7rMBEe97pMQ7y472cM
	ZOSV3w4sx1ZziXdpYRXZwgyG3Fr0gKKX+NjolSPMPvTnCaGeorFY6kMTGAqu6BvhWz8Z7Shed0W
	I5XYXp2xFVv1IFx7D9JlKdWlF8Fp2giB/eGVvjYURu
X-Google-Smtp-Source: AGHT+IHqKzZqwnIzsTyyQU445sfL744bqhVDoPbK7zdfhdFeUrSmApoUq6VPEpF0T/JEjddI8072tw==
X-Received: by 2002:a05:600c:8b61:b0:477:6d96:b3ca with SMTP id 5b1f17b1804b1-47a8f89b69fmr209961345e9.5.1765979553489;
        Wed, 17 Dec 2025 05:52:33 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4310adf701csm4508000f8f.42.2025.12.17.05.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 05:52:33 -0800 (PST)
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
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v5 6/6] dmaengine: sh: rz-dmac: Add device_{pause,resume}() callbacks
Date: Wed, 17 Dec 2025 15:52:13 +0200
Message-ID: <20251217135213.400280-7-claudiu.beznea.uj@bp.renesas.com>
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

Add support for device_{pause, resume}() callbacks. These are required by
the RZ/G2L SCIFA driver.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v5:
- used suspend capability of the controller to pause/resume
  the transfers

 drivers/dma/sh/rz-dmac.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index c3035b94ef2c..e349ade1845f 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -135,6 +135,7 @@ struct rz_dmac {
 #define CHANNEL_8_15_COMMON_BASE	0x0700
 
 #define CHSTAT_ER			BIT(4)
+#define CHSTAT_SUS			BIT(3)
 #define CHSTAT_EN			BIT(0)
 
 #define CHCTRL_CLRINTMSK		BIT(17)
@@ -827,6 +828,38 @@ static enum dma_status rz_dmac_tx_status(struct dma_chan *chan,
 	return status;
 }
 
+static int rz_dmac_device_pause(struct dma_chan *chan)
+{
+	struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
+	u32 val;
+
+	scoped_guard(spinlock_irqsave, &channel->vc.lock) {
+		val = rz_dmac_ch_readl(channel, CHCTRL, 1);
+		val |= CHCTRL_CLRSUS;
+		rz_dmac_ch_writel(channel, val, CHCTRL, 1);
+	}
+
+	return read_poll_timeout_atomic(rz_dmac_ch_readl, val,
+					(val & CHSTAT_SUS), 1, 1024, false,
+					channel, CHSTAT, 1);
+}
+
+static int rz_dmac_device_resume(struct dma_chan *chan)
+{
+	struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
+	u32 val;
+
+	scoped_guard(spinlock_irqsave, &channel->vc.lock) {
+		val = rz_dmac_ch_readl(channel, CHCTRL, 1);
+		val &= ~CHCTRL_CLRSUS;
+		rz_dmac_ch_writel(channel, val, CHCTRL, 1);
+	}
+
+	return read_poll_timeout_atomic(rz_dmac_ch_readl, val,
+					!(val & CHSTAT_SUS), 1, 1024, false,
+					channel, CHSTAT, 1);
+}
+
 /*
  * -----------------------------------------------------------------------------
  * IRQ handling
@@ -1164,6 +1197,8 @@ static int rz_dmac_probe(struct platform_device *pdev)
 	engine->device_terminate_all = rz_dmac_terminate_all;
 	engine->device_issue_pending = rz_dmac_issue_pending;
 	engine->device_synchronize = rz_dmac_device_synchronize;
+	engine->device_pause = rz_dmac_device_pause;
+	engine->device_resume = rz_dmac_device_resume;
 
 	engine->copy_align = DMAENGINE_ALIGN_1_BYTE;
 	dma_set_max_seg_size(engine->dev, U32_MAX);
-- 
2.43.0


