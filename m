Return-Path: <dmaengine+bounces-9994-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIevDNQ12ml9zAgAu9opvQ
	(envelope-from <dmaengine+bounces-9994-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 11 Apr 2026 13:51:48 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 998A63DFA02
	for <lists+dmaengine@lfdr.de>; Sat, 11 Apr 2026 13:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CEBF3306B12F
	for <lists+dmaengine@lfdr.de>; Sat, 11 Apr 2026 11:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2BD35DA64;
	Sat, 11 Apr 2026 11:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="FMT5r8zZ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D5534752F
	for <dmaengine@vger.kernel.org>; Sat, 11 Apr 2026 11:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775907817; cv=none; b=LKV9ZYtpz02FObaIpBmvCDX/DGkfJu3CwITUJZ/373nBh4MpHGT4D4Otko6i2rhRZxhzHpQVLMBVJejdPysqM1jdK7YE2EXATvQXoaqKPM+/n+TpRI6Eg6irI0AR4Q21Okk5OoHamxHnOkQuLl5fre0igxdDRoAxN+9A7vjFMOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775907817; c=relaxed/simple;
	bh=FpCWJ1/MY4BN1v1ry6eYA3qXFhCvUdewz0pHLK1RDgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K11NdSHlGgaAVaRUmeYZfMpvTqmODfVQQMM+Y7Y56j32hPQn40SfkGDLz6BeU7J/EOSbRjtUwHFrvMP43qNPv+HEFMe0c+ZYrqyY3FEtvHpfk+R9k6w1K4hbQcu4W/1QeqCq1aqSm1p36VCluLVdXALYzprXYGDnq1Z79XztCoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=FMT5r8zZ; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43b8982c2f4so1721758f8f.2
        for <dmaengine@vger.kernel.org>; Sat, 11 Apr 2026 04:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1775907815; x=1776512615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=278h+cjHuGOS99RHJ8gfM7jOA+QjEIxjWNs1as6pY7E=;
        b=FMT5r8zZ0GqmJhNImWqWntYRSQ08KRs/R1J8N5YJFZTjn+Gxnrg1hZihd6x35QHH6/
         SHkVjUPupmo8meiRrsdzhGQbx7eSk91bUKdJyjmb/lh+jO3j+SumlwN/KU0DyE9+/j8i
         lKligzr6mZWbk9UdW9f/ggQA+lLwq/tMpxH5PMR480uXF3OLwfFgNHkjKAZ2FkKhr6Oy
         AhO8vWrz5qPOrQ/+y1m2bxEhm7z/SK+eTvwq0siJGjkrskbgtGSKs67u9E/H31NxAHvw
         LIZfREL5VtlXnYigoxcekg5KLayyvO6CiF506yVKv7ukjbngUMun2q2xDUQ/+wPM8hiM
         J6UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775907815; x=1776512615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=278h+cjHuGOS99RHJ8gfM7jOA+QjEIxjWNs1as6pY7E=;
        b=FhHRsA1HPRZ+/+D0svH8D6ihbhPL6XIN/UHECl9VMFkO7GZaxVUaCvom4FWPbQ/QQH
         9maAvYpfKaOWEK7ExBjJ8mQGWcLse/OB2lKlt9bl9VVgYuXx1F+OkrtwXv+CF12RvHCt
         SAbBSYAsVkDNVhiNHpvjPyBlbNLZobNdggpvTFM/EYzJQV+ueV82GwvumtToebo2PoA7
         PuznfKa6mvvUjIcLkFlTTsnmAqcVvTeoyL8eZWK5Sv0tK0nvxnCsXD4lC+NLx5npFqIu
         9JufA5vCuI+dKEcH5RcG2QjxwE3FErBQkc3d0rVQDJgmLOpEi+ZG4jRIXyTWj0KIRHpM
         Ki0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXnyS+OWY23mneTP+Tt8MTzGMwccqbai2neqiG1gB5VBGf5eUZwNsFzlIlsqsl/7VOisEnW04yDwAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkkOwUo7XtZbE4FznKgFZaCiWNto4fXmceLoPC7BX/FO1h3LEt
	XxzzlAgod4shS1yBGzXNU+Hizkjfntha0tUrfp5O+6+zSg/0gN69h3GVGcVBImjvWx+SmKVVubf
	AOSRv
X-Gm-Gg: AeBDietPWIvuhVCVlxAD67zOgCoOGTOYYbpGDGoAZYn4YChKMdFen3opu56RW73oKrv
	A9uLojvriV7D/UhEHW1Mhgpw00wrrlRyeRnQ+jHiyWhbe1kNVGqLwBgRRcOg5YcASMl5U8s6BO5
	SU3LGmZsWvgpsjpeBF18VSDyWavWppVWjWLzPhZ4Cz8t+KNmmz082DgeimIerIBVsIMckbMZozY
	z5R2blTx7gV+HrCqczg6xwcna945lTRfsQ3H9/zIQ480vZiBo98CDzRNXrOMp/dM6Z5LBSsFxoM
	ub6xX75/Co2KYoCIyD4AzR/Bh8k007zw+WZAQLMY3zxogRHKqVtjeUdQezKx1dGd4C324OzRHtN
	eBeB9S6ynNHkrrka9d9pKmAQ5P5TGAq8xYnjv+SDuXdasr2U02JDxF2Q7/xZLAbK+maPl/6rea2
	tZg5O/KYKK98w7r2Jjgt+wn6m57cAbc5bDZctn/srOrpfF87YfDMcZ
X-Received: by 2002:a05:6000:18a9:b0:43c:fde6:212e with SMTP id ffacd0b85a97d-43d642b8ebemr10073612f8f.24.1775907814878;
        Sat, 11 Apr 2026 04:43:34 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e5c981sm15776447f8f.33.2026.04.11.04.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 04:43:33 -0700 (PDT)
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
	fabrizio.castro.jz@renesas.com,
	long.luu.ur@renesas.com
Cc: claudiu.beznea@tuxon.dev,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v4 15/17] ASoC: renesas: rz-ssi: Add pause support
Date: Sat, 11 Apr 2026 14:43:01 +0300
Message-ID: <20260411114303.2814115-16-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260411114303.2814115-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260411114303.2814115-1-claudiu.beznea.uj@bp.renesas.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9994-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[renesas.com:email,bp.renesas.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,tuxon.dev:dkim]
X-Rspamd-Queue-Id: 998A63DFA02
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Add pause support as a preparatory step to switch to PCM dmaengine APIs.

Acked-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v4:
- collected tags

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


