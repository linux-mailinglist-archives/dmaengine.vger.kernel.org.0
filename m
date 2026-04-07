Return-Path: <dmaengine+bounces-9917-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJgKAzgK1WnMzgcAu9opvQ
	(envelope-from <dmaengine+bounces-9917-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 07 Apr 2026 15:44:24 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A881C3AF615
	for <lists+dmaengine@lfdr.de>; Tue, 07 Apr 2026 15:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0F967305830C
	for <lists+dmaengine@lfdr.de>; Tue,  7 Apr 2026 13:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B98A3BED01;
	Tue,  7 Apr 2026 13:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Y7tsGpto"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A363BB9F0
	for <dmaengine@vger.kernel.org>; Tue,  7 Apr 2026 13:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775568957; cv=none; b=WSYlC2x/uVN02qtrqQeAM1M1yv1ebxpO+epLYG/MBhCtr0vQp+xg84JaGP02JuR+XOHA4Jjy/3d+EFRij/dsuHFZzChMrODZlTfV3dXt1fOqCc6WeTiL/vbLmp+LgU2W1unfrlX++b/7QUsYRhqhOwz5KAA+AziPWevns6IKvpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775568957; c=relaxed/simple;
	bh=rBbNuLetMHuecYYiQdVKCfgcTJZ2MFfS+stiyk79XS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aZ7vbRG7oaDSOd7DWNeqC57s6MWooH3Xk87w5dC0+0CXQA6U0I1v+/4XNSswQNzoEJrSE4rrJKeV0++lNmiARLfrhQ+Cd30NVOp1SWA+ZWERv7W0lm/WMqzK91b8zu9PM1O1L3p8dFU8O8DAkby9kq9yfAlR49FQqTDx3GeuN9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Y7tsGpto; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48897fd88ebso37070965e9.2
        for <dmaengine@vger.kernel.org>; Tue, 07 Apr 2026 06:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1775568950; x=1776173750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tR9Osv3U5Kocq80qg3AQf1FnSrs0NQ0fc/wysBCHSXo=;
        b=Y7tsGptozEVoAmu0qgh+eXPwv99E9E41+7bEAA+4av8gexervSBx9zOOKJfJysdmwQ
         7yIiIG18n7BVaV4S7FAIFj4C6AFmyuEKaRdO6eBbYtL7oWRVsszH/d5QOmp79ue3aKoA
         LT1S7jkSV+GSxyDddKXxZwUrig2HnbfVCMT279g+mmxPriJuydAQrqcYYF6M7SKr2frN
         WBhJp9a5TVivAuzQoqC3wz/fWoq7yFHM+gpoE9U4sL8nFKLokTsWnGX7EEF+ECVrOZCN
         EyoCqbygs1VPVpaJ+Ir8T9f4Nm+EprJgZoUc4LxWK9e70p7e9xG5aqMKy1YBTL1CUjYi
         QY6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775568950; x=1776173750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tR9Osv3U5Kocq80qg3AQf1FnSrs0NQ0fc/wysBCHSXo=;
        b=OlKeid7fcby8DLqLpqBiPp5bPhHl1Ge5lrMP99DPVg8bIXKKYSou8Sx8XYhgeCxeSe
         CFLCwlqcrim4sUVcQTR1AZkJTfSYcOyKTiGEX+WslSBCmYVia1Ce6tWqRt77hFeDuEBz
         PId6BJ9t61A9NH9t3Q0+HBAJL88Vgk0hhu59yk9iVMQJeI5TrUBzBqprRnDTrbyAKMCH
         zblzrlcM53iGLL6LquKb/EKKGaUSlI/lfB6waU/JLeMQkcaCMZsnhlfbK0uqD5buCQZW
         MXWdFOy1WlxngHmfknl3iWZA1M7p0QtreviYK9YjjvsON/OElNTEguUoPiJHph4EwNRb
         zOuw==
X-Forwarded-Encrypted: i=1; AJvYcCUF3yNwvVwpBkTv+M4unb5S03aRQztdGZzPW0REFAZOelxZF1g6SJdX5rdYDNw7Zt+xnYcBVHtz0RU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiYYLv7VARxg3FxPlKZrQsLLDwXkgQ2cHKdEV1uI/oLH96Mlch
	ZaEUEI2XGdiq6y9udddoAbGldZPR17bfBeiRCw0HxE64k53t5jh3UhZ8HhO/lFVc+f4=
X-Gm-Gg: AeBDievaxbeTw4r5qMfgvPWwr8HJpxkLI18+3h/D495kFPogO97/lwbiZek2V4utSMS
	kdcyLZpbqQAMPN8s0l9W3ruiLDV3NDln3SpVXvBjI+S+P2z94oDjWL7jBbih5TjPCnJ1u2PChdy
	l/qhBl1tnYS9Q1cR8ZuZHT3GRFnMLMm6rNbAi0AIF6hQS5Q/b6gY3BwizlU3RhYnFgIA7TB89NI
	aAcCoHvpYPrH5RFZ/RHnqzzbgj0TjVQfeRzoVUix8uToJQluQXmGMFoOStwdKTwKrnH79X9cw55
	b6W1LoIVseGxXuCm1Fk9xFZrvAOsYSEUjpl61nLkZ7dedCbwEcmUKaeFprIofh5LQKrzyrpzhpC
	w7z49idscK3G2AMcE75qdJrY6XqyThxYoaEOh9B021ZXRc5UD5VsVfIS+PMfRxjz3QtcoFKOM16
	pWF/PE7T8ZpoE1eKy3RyKf6CzXZLXQWyRPjYvV9pJAlVq9/rt+cHzQ
X-Received: by 2002:a05:600c:638e:b0:487:575:5e1 with SMTP id 5b1f17b1804b1-488997adbbcmr239785785e9.24.1775568950101;
        Tue, 07 Apr 2026 06:35:50 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488a91686f9sm285777675e9.10.2026.04.07.06.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 06:35:49 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: vkoul@kernel.org,
	Frank.Li@kernel.org,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	p.zabel@pengutronix.de,
	geert+renesas@glider.be,
	fabrizio.castro.jz@renesas.com
Cc: claudiu.beznea@tuxon.dev,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v3 13/15] ASoC: renesas: rz-ssi: Add pause support
Date: Tue,  7 Apr 2026 16:35:05 +0300
Message-ID: <20260407133507.887404-14-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260407133507.887404-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260407133507.887404-1-claudiu.beznea.uj@bp.renesas.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9917-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[tuxon.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,perex.cz,suse.com,bp.renesas.com,pengutronix.de,glider.be,renesas.com];
	DKIM_TRACE(0.00)[tuxon.dev:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@tuxon.dev,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bp.renesas.com:mid,tuxon.dev:dkim,renesas.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A881C3AF615
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Add pause support as a preparatory step to switch to PCM dmaengine APIs.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v3:
- none, this patch is new

 sound/soc/renesas/rz-ssi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/renesas/rz-ssi.c b/sound/soc/renesas/rz-ssi.c
index 71e434cfe07b..d4e1dded3a9c 100644
--- a/sound/soc/renesas/rz-ssi.c
+++ b/sound/soc/renesas/rz-ssi.c
@@ -847,6 +847,7 @@ static int rz_ssi_dai_trigger(struct snd_pcm_substream *substream, int cmd,
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		ret = rz_ssi_trigger_resume(ssi, strm);
 		if (ret)
 			return ret;
@@ -888,6 +889,7 @@ static int rz_ssi_dai_trigger(struct snd_pcm_substream *substream, int cmd,
 		break;
 
 	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 		rz_ssi_stop(ssi, strm);
 		break;
 
@@ -1054,7 +1056,8 @@ static const struct snd_pcm_hardware rz_ssi_pcm_hardware = {
 	.info			= SNDRV_PCM_INFO_INTERLEAVED	|
 				  SNDRV_PCM_INFO_MMAP		|
 				  SNDRV_PCM_INFO_MMAP_VALID	|
-				  SNDRV_PCM_INFO_RESUME,
+				  SNDRV_PCM_INFO_RESUME		|
+				  SNDRV_PCM_INFO_PAUSE,
 	.buffer_bytes_max	= PREALLOC_BUFFER,
 	.period_bytes_min	= 32,
 	.period_bytes_max	= 8192,
-- 
2.43.0


