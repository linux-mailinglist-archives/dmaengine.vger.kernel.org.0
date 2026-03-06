Return-Path: <dmaengine+bounces-9301-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEHULUzNqmkNXQEAu9opvQ
	(envelope-from <dmaengine+bounces-9301-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 06 Mar 2026 13:49:16 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C622220F43
	for <lists+dmaengine@lfdr.de>; Fri, 06 Mar 2026 13:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7156B31ADC53
	for <lists+dmaengine@lfdr.de>; Fri,  6 Mar 2026 12:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43206368273;
	Fri,  6 Mar 2026 12:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="M3mgMlM/"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B026328C864
	for <dmaengine@vger.kernel.org>; Fri,  6 Mar 2026 12:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772800906; cv=none; b=ibaB90b3g/z5QlXr/CqiIW5F8SdTMYESIAg5mmj4c2ooVYlqmja/07G2FTBmxheKlgDWLDPs/1s1qjezZnDZjsWCYZ/7TminMJVYnFXaUoOSGVWFiKDdtnc4yiavspwClYZtonZIpp3R6YHxR15J7Gn35N+uzFYdr+95PjIoHxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772800906; c=relaxed/simple;
	bh=zMC8Z35n6hZqb+F6CM9QqlHZLYZ6S/y6G2PDsOYtUHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W4qOB2DBqjObftypGoeQSQSASypp18FiWhq/0vIj4o3Y9KkgpbtzmDPwmWEGWBMqgCuA8Vg2KfbbTXAiQu2CfJ9xbF1tPUJI8kha+V5oNGNoOIYE0/62OekDKBhNNzRmhwQP1ypqrD4SYUOhAJnQfE5EbaVzPoaTC84tTggs5mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=M3mgMlM/; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-482f454be5bso94140625e9.0
        for <dmaengine@vger.kernel.org>; Fri, 06 Mar 2026 04:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1772800903; x=1773405703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=djodlEhOqxbj01WP7bf1DpXdR4vQl3fw8jTNz3jaE3g=;
        b=M3mgMlM/Jp9a1z+gVPXJ8IxZJTHvybbgRL82752E/YwqRZURITyQ03y/rabHbm2oJ4
         uqoEy7n0+j9LCA8bScZjRh66p3VesD8l9aFIqHONkdMNZq+we4WTshbNrMTswdHeiwu+
         QPUtmZCbAdCOviBgoCpd7kveutPlrJuKczR9hhZ/FQQ0nKFkgqCeHKix2iKLv28A0G+8
         lh60WnEJN1y6Pp8dhzABTgl75MUtgl7Kem7uu+cY/j0nvEjPoE54WC1kfzDmFnukq/Zm
         0HkPVPDmyvJfP8Yy/ECqK2B4+Ia1hDPyjVE4G0ACcE25kSWwnXavZLkn/Dox1NHgl5vM
         CQ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772800903; x=1773405703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=djodlEhOqxbj01WP7bf1DpXdR4vQl3fw8jTNz3jaE3g=;
        b=LQfP0ku0wCe3pv1KvnxNsWUOc9G5wJpWI3BSqb+aeGe+49UJ5mhtkifkD4nanuQjer
         8VtEJhKnaD9K9fzkcE5xKhBNNDZHPgpPigPKEaIdKasqKipvPRYvx1EXZcHqqiGnyTbj
         Bos5zKnOYBYTeCrY8HxrkaLnHYAU3WxQoA0pk+6ZRxMmS2lmCoDo416luxmDpROnehM8
         XoBWE+7wEX8eXt3cIPhqgarrU3RDH7gpoS1xA6ZTPiFLKCFivrq823JiPdRlqwpi1E20
         kWS+aSDETPAUk0rg+GLHaLRRhJWmEfAhEjzlIswAs1J9xPuHxqoW/AMxX8MKBLvl+d3C
         Oz3A==
X-Forwarded-Encrypted: i=1; AJvYcCVbA0HDDY306gmnZ0Sqy382YWiR9Zc7B0jYdjrEj64jRjyksYETNQNF0XWF0cmxY+LEWnxkmsYo6P8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJZc3IruoMO7/O3gqnEy4L+aYW+LxmXKLYKT6IdfqoJGLO+6Qh
	5fC9hlfM0RpMxBwhRqOJF/dT+PbDySsi/dY781A82H/txkOoQnK0qKGT0GWzL+FM8jM=
X-Gm-Gg: ATEYQzxq+uZB5clpUV0SOA0l1EN75UILyaeGUUVMBbnZEkWwEhLAmxehGQ1OuDygfql
	RZp6tfWY66XXdrq6cYAcrGGaM0wdKAPCnv0ebp3gBxNAMeeagQPgydrpi4CLMLQdnsgRKLMA3NC
	js+j+Z9hPqRiRUIVCrCwNl/6fSIqJjQxA9yQiJDSsn+EUVd5tiJ63MZ+YMeTRH1krNEW8urkljN
	cya1d9Y/Cop9TGD2LY2OlZ6X2nvdEt+51zPUiD9ymbU2n/iaWZ27/jmI61CVRn+VUE0c96WQODe
	RF9rnGuXjQcDOVmrzzPlK9UFfVTdaDvXOUwmMeeaN2FflLwkGPLboTA3wrmk1SCuvhIM7dPa7j6
	kNmnRQfnYPV8CCO6bAblQOMziEI35+u/p7pcR0a9HyiiR+wP9UQx6cwtc7EqCn/kZNO/2xxTwd5
	byaHSXbMHN8N95bSdQOhVl44QWtPoB6V4XbnfJg+0kbptZY+b1HzAQdqmE+U0DjVA=
X-Received: by 2002:a05:600c:8b2b:b0:477:9890:9ab8 with SMTP id 5b1f17b1804b1-48526715213mr28640755e9.3.1772800903039;
        Fri, 06 Mar 2026 04:41:43 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485276b0c38sm38150505e9.9.2026.03.06.04.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 04:41:42 -0800 (PST)
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
Subject: [PATCH v9 5/8] dmaengine: sh: rz-dmac: Drop unnecessary local_irq_save() call
Date: Fri,  6 Mar 2026 14:41:30 +0200
Message-ID: <20260306124133.2304687-6-claudiu.beznea.uj@bp.renesas.com>
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
X-Rspamd-Queue-Id: 1C622220F43
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[tuxon.dev:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[tuxon.dev:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9301-lists,dmaengine=lfdr.de];
	DMARC_NA(0.00)[tuxon.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@tuxon.dev,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tuxon.dev:dkim,renesas.com:email,bp.renesas.com:mid,nxp.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

rz_dmac_enable_hw() calls local_irq_save()/local_irq_restore(), but
this is not needed because the callers of rz_dmac_enable_hw() already
protect the critical section using
spin_lock_irqsave()/spin_lock_irqrestore().

Remove the local_irq_save()/local_irq_restore() calls.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v9:
- collected tags

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
index 4bb446c1cd67..9c159c53e3ee 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -266,15 +266,12 @@ static void rz_dmac_enable_hw(struct rz_dmac_chan *channel)
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
@@ -289,8 +286,6 @@ static void rz_dmac_enable_hw(struct rz_dmac_chan *channel)
 		rz_dmac_ch_writel(channel, CHCTRL_SWRST, CHCTRL, 1);
 		rz_dmac_ch_writel(channel, chctrl, CHCTRL, 1);
 	}
-
-	local_irq_restore(flags);
 }
 
 static void rz_dmac_disable_hw(struct rz_dmac_chan *channel)
-- 
2.43.0


