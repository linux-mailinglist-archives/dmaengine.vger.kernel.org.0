Return-Path: <dmaengine+bounces-9300-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEaMF//NqmlRXQEAu9opvQ
	(envelope-from <dmaengine+bounces-9300-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 06 Mar 2026 13:52:15 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F2153221090
	for <lists+dmaengine@lfdr.de>; Fri, 06 Mar 2026 13:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6069C31AD822
	for <lists+dmaengine@lfdr.de>; Fri,  6 Mar 2026 12:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247873659F2;
	Fri,  6 Mar 2026 12:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="aq6p0/zd"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAEC2C11FA
	for <dmaengine@vger.kernel.org>; Fri,  6 Mar 2026 12:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772800906; cv=none; b=tZRMhMGtyvgMpBIakP2JEdDN2TMUxuuhM17qashsSTeBM2rKghDw2rfoW38Wt+npI1hWuEWjrvPXSX7CMFIIKJBTzATsPvw+tBf0eoGCQPX8y61NCPiURwyNcunW3d3QzQ7g2lQ0vQjS86zhYHH20wtYGJOjMTNfem0fqOK7QOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772800906; c=relaxed/simple;
	bh=E8FrnPZikkCzYivt8gFgvp5FnUb2bbAQTvsngXDzgMc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jETgQaAOY1KzfZ8dX8Ls6WPIevHeJVKRy9BvM3Sa477rOcpmqy669Vj/sFLlyfZtITmUeSU7dhwEXy8Z+SLB27rN3e6anEfN0PkKmoDDdqmwsbSCwd45/KTsFGDyx9FapFdiuVP3sVWiX/+YNQqhR9P01v2P+VUZ016zOz6xChQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=aq6p0/zd; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4837584120eso70568285e9.1
        for <dmaengine@vger.kernel.org>; Fri, 06 Mar 2026 04:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1772800902; x=1773405702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=evbDeWChFM1NVRF6K9uXPZD1Lo9mgGF+LHECV76EJao=;
        b=aq6p0/zd5k9UXb34x/efHkKY8StCobYra99vTZFq20TO5yelFUxFcDysifqJfxs31l
         BQhw/wtITQZVwroabNS670FU31dn+dxNW3FRwCCwy8zTgwHE6lE3Vzkm9ca2479pUVU/
         CSH2Jl8HNKISVRY+uMpC3Af1l5yfAqr+6l4UnDfYAbIvSu0OmoSbjFHOgYnQUffeYTz0
         Wbh0jcoO+3+LornuMXJVb111JZVaVRZc+CcF3DOUqg8aoFX5Rnkzs1db73+V9nswFcr7
         nK2gAos8xSAVa6RtABkAhNoggFKO9Je76Ql20UQXSYROnOLpx7H+5srv280wachhJ7ed
         /JOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772800902; x=1773405702;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=evbDeWChFM1NVRF6K9uXPZD1Lo9mgGF+LHECV76EJao=;
        b=YYJBp9swQun5Gz/eH4VjlQrHW9SVrwKEIauqg+PU4itSXPgNA/iyc5aTI1LGTpN4U9
         IOlp5vYRJjev9Deh+irrBPynrZ7X4aGmnm4icpg4kooWhPkrFFbITuRnk/2BCd9G3TwD
         TrlS8tSgv/OHNBHI5217dB7ClGk6HiTT+TxGP+AIqf2MJWjEjNp7YFYBSdSnUvoKNvyf
         0IeiNdlnOa+4XllR8uVLLHiyIhWjuSA/d2J3Orec4ullsTbq+TPsElFQvWbeTOJ4Yy0H
         ERT6EjhphLM9UxSpqeRxlfMNBXUhWllanmHwXbcqawpiib9ZrQmfcTwnz9aQSAJK9gWf
         zG1g==
X-Forwarded-Encrypted: i=1; AJvYcCWj9caft2OC5fKrrIdP3no1kbnKSaiI9WwApMVmLPGuWXgx2rMFkFAzmH73mj4Nb3C4yLM+Nqksy6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSO5Afis1BnPjGMZqiiTcds02lUVXl00ygPOYChMM2nXb/Katv
	v8QkK37s4MkvNMidAzNkxjO/H3CvbNJaWcjOE5IEwsnj9gcC0CJC36T1NJegZzuEgyA=
X-Gm-Gg: ATEYQzycPtdZf2Zy1JqO19qjra4Ir7J4wtIoxhvz1C9Lyy5jf85qAo3y5hOXNQKWaUQ
	T+rdekPETbq1DCEeA/8vXfvYUWRxK07CcA0QA31bJxTcxU+gfGbrIWOrzJcFEBzP8uyUAuZMt9G
	N8Wpp7wDrpSsll+ZRQJbOrY1GiZABBkrypKzejNpWuhqzassWgWzw+ajmUGJVhJVuMPlftxduby
	u6Ar/PxAm5feVVzZ3k0kzk6kFHKyySBY9qma4qZBgoPjpm51ZmJgM4TKHVINuUfoeIJ5uzHOQFX
	7Z8z9nceNKFavgBWtl9Gq6QWuTsYbp9m84hD5XZCWRnXjMGld/TEPbbC5twE5xcsY3rw2azStME
	QDDKMkq/7OzjT/B4yRxAPGVDDsa6raHu19xXX4zwX9Iz8VUUqwZuxDHOwuw9vNqIioPmeGcVREG
	IiskDv5BrFsksylXJQartYsdMOFbyzkaBbswC02itCQKU6xmrlYWEG
X-Received: by 2002:a05:600c:3b04:b0:483:71f7:2796 with SMTP id 5b1f17b1804b1-48526923e1amr31113775e9.10.1772800901899;
        Fri, 06 Mar 2026 04:41:41 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485276b0c38sm38150505e9.9.2026.03.06.04.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 04:41:41 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: vkoul@kernel.org,
	Frank.Li@kernel.org,
	biju.das.jz@bp.renesas.com,
	geert+renesas@glider.be,
	fabrizio.castro.jz@renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com
Cc: claudiu.beznea@tuxon.dev,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v9 4/8] dmaengine: sh: rz-dmac: Drop goto instruction and label
Date: Fri,  6 Mar 2026 14:41:29 +0200
Message-ID: <20260306124133.2304687-5-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306124133.2304687-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260306124133.2304687-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F2153221090
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[tuxon.dev:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[tuxon.dev:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9300-lists,dmaengine=lfdr.de];
	DMARC_NA(0.00)[tuxon.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@tuxon.dev,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,renesas.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bp.renesas.com:mid,tuxon.dev:dkim]
X-Rspamd-Action: no action

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

There is no need to jump to the done label, so return immediately.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v9:
- collected tags
- updated patch description

Changes in v8:
- none

Changes in v7:
- none

Changes in v6:
- none, this patch is new

 drivers/dma/sh/rz-dmac.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 2895d10aa2c8..4bb446c1cd67 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -706,7 +706,7 @@ static void rz_dmac_irq_handle_channel(struct rz_dmac_chan *channel)
 
 		scoped_guard(spinlock_irqsave, &channel->vc.lock)
 			rz_dmac_ch_writel(channel, CHCTRL_DEFAULT, CHCTRL, 1);
-		goto done;
+		return;
 	}
 
 	/*
@@ -714,8 +714,6 @@ static void rz_dmac_irq_handle_channel(struct rz_dmac_chan *channel)
 	 * zeros to CHCTRL is just ignored by HW.
 	 */
 	rz_dmac_ch_writel(channel, CHCTRL_CLREND, CHCTRL, 1);
-done:
-	return;
 }
 
 static irqreturn_t rz_dmac_irq_handler(int irq, void *dev_id)
-- 
2.43.0


