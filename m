Return-Path: <dmaengine+bounces-7753-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C96E2CC816A
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 15:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 996E03008BC4
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 14:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE0237C110;
	Wed, 17 Dec 2025 13:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="MBAqUXyC"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6083563D8
	for <dmaengine@vger.kernel.org>; Wed, 17 Dec 2025 13:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765979558; cv=none; b=t1CNSkZ+Gu07izpfqTSHRj2UzsHarJwZ/BFuUz8mya8j/Zu8cwwcF0DuKL/w8Nn6g7WKl2fbhSyZZJjADqlwJXK65+bqyj8eEby5e8YBhgZZ6HjYe4wF8sKJOzow9oqhfjTvWV3dE5eVZLKJjYLvEDj9KBF0HCPO/qPkipNBS/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765979558; c=relaxed/simple;
	bh=gEmoRtjLtJIWXeIxbyc1ZwCZe9AbS1c3qYMrSFz21rg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o8qIY3Ah/v+GB0vWj5U1kWkrw8XDjAXQSkhhHd7OBH+VeuEAuBcBq3kuCng4brvOh8FJ2ig20DRihKjQ5QVB4qAFblhFBmFbG9OPbuSfYTolZfxxPpNSq+dsf7o3cQKFKqYfm9fOcJUQk5JLZSGNA/OlOn9CQTZmSayU7pA5Wv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=MBAqUXyC; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-430f3ef2d37so2957928f8f.3
        for <dmaengine@vger.kernel.org>; Wed, 17 Dec 2025 05:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1765979549; x=1766584349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zGVStpQwPomlTdstFsandqO2eIQ1hd4Sclxyb3yiqx4=;
        b=MBAqUXyCqdf5c1rgnBVnMqf5nLaB6TW/OIrvqEHlB3bTxHe2Q+9eyiu/8JaBTNjkLk
         FYy6WTKM7ydojbdWWPM7wSkROg+uGXPARNNebu/kSsSNDFhtJ7nMlWbnPL8pOOLC/eXE
         jCV68UOKrdqG6AudBHUEFCHZewJIaEGzOIP5KjaQIp/3MyxjJ3O/PnJX0DxrfK0vtmVD
         KMC/WpWUfYXHzPZOaMQbzKar2gCh5uAPrQd72lCA7PXiQQzECXjl1fNyWsScqY165BNI
         Fp3WJny1p+nZIHWtaIEqMmY6wbYSpm6Ivu6Ahbo5hrv+RE13L/6rlHiK6o4Uv1aGFm9e
         KTXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765979549; x=1766584349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zGVStpQwPomlTdstFsandqO2eIQ1hd4Sclxyb3yiqx4=;
        b=Z25Il657C8AHsMa2SRdVY7SZMPpmcWWEhR9YvoUrB83lvwlv3WVf7OfZbdLQ1eRhV8
         z/MWh7ea/Vq6Jdsvcm1tRBI1MB1kQyY/FeQcYsL8XmixX4Gfcs3m6ReN578jZZ2Q+izY
         fB756ve1dGtglxOxDAJn2GVUxzE/zf57zgaVR22+DRVUb7YNXdONV+xaxVegtRBuT8G0
         DnC9TJ4sFpRFgoktGPDBdpyLCWCp1QAfFrXAGtSnapgMdMkPfoWhj+BwAtUWFLHIggP2
         gxWFRuCz90E365BvOAURQ4C1dEGUYCrpCX+yEDBYDPYHjuiJSViL5v8KFdWnNDOIw3x9
         4rpQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0L+rumopvSLsoXUczK8Dym8ZZ6HCEteJVv2juh7+l1WZJBsbI3MnSAY+H0Fhf3z0vYMfsepl/okM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/9KQ73HjPoXeBv4leTu7d/RuNcXCSL+oprnoTXNJ9FZzeoy8F
	QvLnrBLPDJZJIf7JcY30ecctqL+HE4HPqVUi44cXnqhFiRabC8rxsGBfJtfojqCloHU=
X-Gm-Gg: AY/fxX5X2VBmqvjlG++UOSH9HU6Mro6ZUmFuHxHGsgdkQ9ZbPXowfcJvX67pC7PRKXz
	mZ6oKDNn9t5epqiBHQ2cIoecicPJL4C9mgF9APFNkYBGxxLo3LWbnjb+YWe5e9K5skfSFLCqqPN
	8BlBp/fPz8e4FOB08PR3XUnKd/OVqIGpLYAtqaKVE2dIuyn9q++F0JkmTKmKm5+VzrjaQYRViIf
	nwUqaU1IBFh70Z5mzz+0UpXCrjKuRVMfOwS7HU0Kp7KVL1gOiCyPtmDNkacRrbvVm0lEAnyWVcF
	7p9X35YEWk8QsCPs+vhXkxx0nBPrHS8EV9OMIbAPzunNANoI1xI9hVSyUwyNpJY7dBXWao8t9rD
	83U7DKHzZUS41XFg0gsr4Zn8aa1cvj1jIfGAXKLWduO3vIIRMt6F0EDZBW/u5LHK8BwEXeCbK64
	388L3Kiebn+/VRVZtW4u26nmXa225aqZbjXFMGMe/Y
X-Google-Smtp-Source: AGHT+IED9HanqqLjN0QtB0ReE4lGpkn+FHqD4ofAHtZbJtmJpbrl0xl9aY+9K4+DrVBoQRCemkHTLg==
X-Received: by 2002:a05:6000:4202:b0:431:1ae:a3d0 with SMTP id ffacd0b85a97d-43101aeacf1mr10038607f8f.25.1765979549499;
        Wed, 17 Dec 2025 05:52:29 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4310adf701csm4508000f8f.42.2025.12.17.05.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 05:52:29 -0800 (PST)
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
Subject: [PATCH v5 3/6] dmaengine: sh: rz-dmac: Drop unnecessary local_irq_save() call
Date: Wed, 17 Dec 2025 15:52:10 +0200
Message-ID: <20251217135213.400280-4-claudiu.beznea.uj@bp.renesas.com>
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

rz_dmac_enable_hw() calls local_irq_save()/local_irq_restore(), but
this is not needed because the callers of rz_dmac_enable_hw() already
protect the critical section using spin_lock_irqsave()/spin_lock_irqrestore().

Remove the local_irq_save()/local_irq_restore() calls.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v5:
- none, this patch is new

 drivers/dma/sh/rz-dmac.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index c013bf30fa5e..ae8a4bd9d7fa 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -267,15 +267,12 @@ static void rz_dmac_enable_hw(struct rz_dmac_chan *channel)
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
@@ -290,8 +287,6 @@ static void rz_dmac_enable_hw(struct rz_dmac_chan *channel)
 		rz_dmac_ch_writel(channel, CHCTRL_SWRST, CHCTRL, 1);
 		rz_dmac_ch_writel(channel, chctrl, CHCTRL, 1);
 	}
-
-	local_irq_restore(flags);
 }
 
 static void rz_dmac_disable_hw(struct rz_dmac_chan *channel)
-- 
2.43.0


