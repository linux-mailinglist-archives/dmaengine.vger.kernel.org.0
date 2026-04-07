Return-Path: <dmaengine+bounces-9909-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNVnL1EI1WnMzgcAu9opvQ
	(envelope-from <dmaengine+bounces-9909-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 07 Apr 2026 15:36:17 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2363AF3EF
	for <lists+dmaengine@lfdr.de>; Tue, 07 Apr 2026 15:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 505D7300FEF4
	for <lists+dmaengine@lfdr.de>; Tue,  7 Apr 2026 13:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CA93B9D8D;
	Tue,  7 Apr 2026 13:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="gcNCLCsv"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7693B6352
	for <dmaengine@vger.kernel.org>; Tue,  7 Apr 2026 13:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775568936; cv=none; b=ERx70cHjN/nIhUzre7a03zAHGpr5EOyGp0429LL8WP9svQwkL3qirAAROk0DdnerNr4KZNyYGQtyshzYCWWfWk0aNvIlGIorjWFq23FnFi2XFqcs/WCecnxwje0WAVuRy2EuFpE0C3CHIkrqeJ9b9klqE5z881fQdnsdMljqGi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775568936; c=relaxed/simple;
	bh=oXhP19nSq9V9gIPK7p49JTqQS9Nh248cIFDTun6vI78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RuvNI7AzG4+PX0/ldf0u729a2fMJzxwfxvTTwmuBQblpgu2F3o7e6FgL0b1JeaZcmBVzPpyXLCCy0jnHCp/UQmF9BC4B0+BgYBmyzF3CX036Jo8lMutUodZwd+d/HUS2k0H9KEtNuK2NN8cmAdf/9ysq4cGahTTax5SC7lu+v6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=gcNCLCsv; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so33202435e9.2
        for <dmaengine@vger.kernel.org>; Tue, 07 Apr 2026 06:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1775568933; x=1776173733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lPqjlgjOWitVthnX/i/FGgn586vKfxcqfC7axGBVgqQ=;
        b=gcNCLCsvstMJhU7Yd6LjAalshRtcbicMDcUMv5j7b9rMrtwjR/zwOWq81lYMq/EoNt
         07wsyRSRbnFH7e7cFi5GvpWG7/QVbzmdG+UQUFx8vwrnquuc5UZW28InAE7ZMJjeYiXW
         OdfICJj17gCNg9MZHJZhKc54KFUlr6G1yoQv8C+fppA3mpjTKeOaHYziluwfScCZnsAN
         zL3E0IJLjyHy1/dnzO+P3Ega8vOOug5Sd2ABqm1vi8Hyt+eGXU9ch3KgGXhpG2TUmV8T
         kVw5vGRC+yLmsK0PBquGlE2X3wF+aEZnfp4eagHig9NgUZQklgdifxYdMFCGJSIoHe43
         tH7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775568933; x=1776173733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lPqjlgjOWitVthnX/i/FGgn586vKfxcqfC7axGBVgqQ=;
        b=SJWwuaGXuym+3WBzCRFrsUYnrhqKW/nKLTncoMvJEuaHpRj+39D0wOfDOiDb7Ty6CJ
         zkeR3uJ94iPftP76gwVuVnhFYS9kNmBVJg5bHGs6Jp200fgIHL0FnukuybPgrjDxGLjk
         J8+WUO1j5GhduQ3raJ328E8WFgm7XjMOo5kOhJucL3BYmMDtIAx17wA4/UvFJ28VrFQA
         UY64JFJuPqGbSeC21rbHp9myBNKR593u0T/AP2A6zL/zNe2TiOCZ9dJngfFCZUornNjE
         bLBf/mipT0qJmz2qwjPSYV+xyzdVbfIcYPAq89ICivSTjW3YLIKJakZGU3ujTTYH90LA
         Dl0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVfQi0fQzOUESiRf8CBjlF5rli3jVvGVERECGBP70+AXPisineblsm9SpYV8qlHIM8eL6hjqZgTcR0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4q1FJIeGvGszCT+I2yhNx5yTsFpgXOHq4b/OLh1UFgawD0blj
	7EhgB2ykl7esJud4cObClnIoXMgB53E0GPIgJ9G/xEg3zGdjPfymPn5mrEb4cZF/K2Q=
X-Gm-Gg: AeBDievzTau3uqeT4UtHqv3CAVsciqdmkopWRuTYl821wq2+6ZbPlxaZbBSVR8sXZo5
	wlEupB+T7BrlA4N6Y13a6JJ1mmxPTgr0HF0JNLJWrfHevOjG/SRIKXXJyfe5bZHMqwDYlFoR6ss
	91+Zm4OKe6i1GEyGkS0eBLxzO7XclICur0EbYcYc9PIgpMkBVFuF7KBQj5vctfDscQCxqSzgcgV
	/MoDchXl/FileY/HETKi29OPZmgEmPkJEF5wXr2wKwN6Hz/k8GWuYAq9aE7E4AZYxLlgqK4om6G
	X69nQTOPClrm/KZDIa/n+qpo2sFDvmURthKT0Unqairui0n8JF814vCV2V8tKnNnYoyIvfNJD6K
	OJ/2DLeUVI/8nQ9zGSDLaBY8A32aZcUcaRWhiZ3yT1mNFXjvHNfJNozCu/1BNdMQKQYQboWvOdY
	jUJy001qBRc3Q/pWG6E/Q4QQcH/CCpUg+9zRbmR1KrDroVbkVxOYd/
X-Received: by 2002:a05:600c:a306:b0:488:c014:34da with SMTP id 5b1f17b1804b1-488c01436b4mr22396015e9.26.1775568933020;
        Tue, 07 Apr 2026 06:35:33 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488a91686f9sm285777675e9.10.2026.04.07.06.35.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 06:35:32 -0700 (PDT)
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
Subject: [PATCH v3 04/15] dmaengine: sh: rz-dmac: Add helper to compute the lmdesc address
Date: Tue,  7 Apr 2026 16:34:56 +0300
Message-ID: <20260407133507.887404-5-claudiu.beznea.uj@bp.renesas.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9909-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[tuxon.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,perex.cz,suse.com,bp.renesas.com,pengutronix.de,glider.be,renesas.com];
	DKIM_TRACE(0.00)[tuxon.dev:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@tuxon.dev,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bp.renesas.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BD2363AF3EF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Add a helper function to compute the lmdesc address. This makes the
code easier to understand, and the helper will be used in subsequent
patches.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v3:
- none, this patch is new

 drivers/dma/sh/rz-dmac.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 34c00f3ffd4c..ef775ffa1099 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -272,6 +272,12 @@ static void rz_dmac_lmdesc_recycle(struct rz_dmac_chan *channel)
 	channel->lmdesc.head = lmdesc;
 }
 
+static u32 rz_dmac_lmdesc_addr(struct rz_dmac_chan *channel, struct rz_lmdesc *lmdesc)
+{
+	return channel->lmdesc.base_dma +
+	       (sizeof(struct rz_lmdesc) * (lmdesc - channel->lmdesc.base));
+}
+
 static void rz_dmac_enable_hw(struct rz_dmac_chan *channel)
 {
 	struct dma_chan *chan = &channel->vc.chan;
@@ -284,9 +290,7 @@ static void rz_dmac_enable_hw(struct rz_dmac_chan *channel)
 
 	rz_dmac_lmdesc_recycle(channel);
 
-	nxla = channel->lmdesc.base_dma +
-		(sizeof(struct rz_lmdesc) * (channel->lmdesc.head -
-					     channel->lmdesc.base));
+	nxla = rz_dmac_lmdesc_addr(channel, channel->lmdesc.head);
 
 	chstat = rz_dmac_ch_readl(channel, CHSTAT, 1);
 	if (!(chstat & CHSTAT_EN)) {
-- 
2.43.0


