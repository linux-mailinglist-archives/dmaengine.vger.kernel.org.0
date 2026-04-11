Return-Path: <dmaengine+bounces-9981-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKniI/kz2mlezAgAu9opvQ
	(envelope-from <dmaengine+bounces-9981-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 11 Apr 2026 13:43:53 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A2B3DF8B6
	for <lists+dmaengine@lfdr.de>; Sat, 11 Apr 2026 13:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 687C6305FA03
	for <lists+dmaengine@lfdr.de>; Sat, 11 Apr 2026 11:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C04345757;
	Sat, 11 Apr 2026 11:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="j7fp2xD1"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D313446AB
	for <dmaengine@vger.kernel.org>; Sat, 11 Apr 2026 11:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775907794; cv=none; b=E268o4VfLs2QpCKbUUZbINexFkozyZAzv38oJLhxv0GRljtHOMDGhMn4Q6QYz3d6UEvPHGhp7mpTyos9Ws8azD3XBwPfUt6JuoZQ7vBbY1rIhHTPBaM9BuV6SoFs6gVA5ZygRHHdu+JG9sqCvLVJkpk9IVoHkp8bnUlLgNtFKzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775907794; c=relaxed/simple;
	bh=QGre1JnMJ7EtNooAlP++jw+4gePWfV/O1V/jrTmI22o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Td0Y+zobn+ZYFcVFPkytnY6mGKyYqK3zKyko+bybTA8oAYeo76Cv/pEjfa2roWcxvUJZUySOkB4L8QW8nFwRvtQ8SoCCPQIqcPC9DwCEwhR8Ql9hoJytPdQ6S3MCilkLgEx2GZkKKgArDpI4ay96rgCfMsKVHb9ep21jLjtclcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=j7fp2xD1; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43cfb723793so1966219f8f.2
        for <dmaengine@vger.kernel.org>; Sat, 11 Apr 2026 04:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1775907791; x=1776512591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R7WML25G5xFq4y3e3IxD4yNlbeDhj8/OemWvzra0+LM=;
        b=j7fp2xD1T53W9ogUMGE9CsyEh2Wvxa5BEDuORsSFSZdijZ4g9e3Y6tM9UpNwqdRhXc
         wb8pUBCjZ+W1hRnsc5iPYBifIdr4uQd5oI5e2qsE48QDHcbBF9ppmv9P77RBPogGpCtC
         ePqFmRpxHR1Om+dU0XS90aBGf0MU17PQ4V1FuGoNtYud1FiVDaPt2A368+OnEvkILUe6
         WhTQrRV5zSNNq6N0QWIe3ulOttp3miqRRsSodLqvQn2O5Wbzt0qPJDq55Qf2bnOZhz1E
         D/kaeS4bcssqYB/l1lpJFlhY+iI3+ca+EPPfY2XLgukpciKYKTmHfigIZXSRFu6qBY/9
         7FAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775907791; x=1776512591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R7WML25G5xFq4y3e3IxD4yNlbeDhj8/OemWvzra0+LM=;
        b=c6Pr+sUpDn2y7L8rA7PH0GWBCK/KpQoIZPm+f4SsuU0F8ea+sr6iSnHStivOfBoEXH
         BcMtV8Z/JXHvBnoyUfQxu97vts0C4GRq0m9wKe2G5ZLNy1UiN8zQHHzqHKIfUBbT5NZK
         iqd93XGGjBi31ndIus3ZSPSsBX9rCawryIKYGdjGK0+QThcI6ahlMDht8XH6CWGybkJx
         pHxpSXKvzrvEmct4zNmzq+EqUAjW9sm9+4G3kJ1M1YO4CvepNm7jWUifTeju3fabWTP2
         8WPP1AaTh1jHdUFUkoKFGOFfp4s3s8HN3Qw5sfOQH2hpebR3NroCmrlfp6/dxrr6I01z
         KMTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBN+f5xapq0Joes0h1ph2WU+h0hwuQl1JNjqDIqTyLXFxILvQW2IUg4LJxBxETUULswrbdE7DeJWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgszN9cUbMfuHaK5J/S/5IvxLzW4VVSh3KlbMNkErCxxm9OtCE
	jajC0cyN7/a+oQoHJ2KRExetX/0tBFFnOw3TmCab7nVEXJndQv41THd9WlpQVqvFN68=
X-Gm-Gg: AeBDieunnVMFACBfSOyOTcbBHvw0A+KNDpjmb5lUKaRGWgw99o7onnUEu3Batcmcv+W
	UZlOumJ1s+KXiyLYaqqIvRTQwTJgEa4eDboIFL8wkCd/LifqFrLtlV9M2Kvli/Z0YmBQY//Tv0O
	bGZuVMBLNBqNlNiFlg5MG4kcACT8PDR47yu14+q/BDUVwwVfjRaHZC+Idj7eWfCXgoqQ8MyGTZ3
	kFwCOPvOopbf/t3+AJYSMaY3oKjRtNI4+aP5HWeSYg8ytxJqkR9+O4/uLtayA/My7TdXL70WBQZ
	p2G80f701V5rAfD/y+N632EEGeHveqg4QMVYb28dDzAQ24u9inVuybYQeQcTIzRP+XUJ0wO/cdN
	PhPFg6gZGVMH/LOUdKrI/DFOyrk3ybgCgvJky/q1ac9KQqzuCyx7uT2yXSEwnKtB0IGY9YT7dxy
	7cRhyubFydE9iMBkBFCNfPP9v8ph3dt5W4pdOzxO2pjBmk0Jl5YJ81
X-Received: by 2002:a05:6000:2886:b0:43b:4982:fc73 with SMTP id ffacd0b85a97d-43d642c77cemr9629206f8f.25.1775907791508;
        Sat, 11 Apr 2026 04:43:11 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e5c981sm15776447f8f.33.2026.04.11.04.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 04:43:11 -0700 (PDT)
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
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH v4 02/17] dmaengine: sh: rz-dmac: Fix incorrect NULL check on list_first_entry()
Date: Sat, 11 Apr 2026 14:42:48 +0300
Message-ID: <20260411114303.2814115-3-claudiu.beznea.uj@bp.renesas.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9981-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[renesas.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bp.renesas.com:mid]
X-Rspamd-Queue-Id: 46A2B3DF8B6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The list passed as argument to list_first_entry() is expected to be not
empty. Use list_first_entry_or_null() to avoid dereferencing invalid
memory.

Fixes: 21323b118c16 ("dmaengine: sh: rz-dmac: Add device_tx_status() callback")
Cc: stable@vger.kernel.org
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v4:
- none, this patch is new

 drivers/dma/sh/rz-dmac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 9f206a33dcc6..6d80cb668957 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -723,8 +723,8 @@ static u32 rz_dmac_chan_get_residue(struct rz_dmac_chan *channel,
 	u32 crla, crtb, i;
 
 	/* Get current processing virtual descriptor */
-	current_desc = list_first_entry(&channel->ld_active,
-					struct rz_dmac_desc, node);
+	current_desc = list_first_entry_or_null(&channel->ld_active,
+						struct rz_dmac_desc, node);
 	if (!current_desc)
 		return 0;
 
-- 
2.43.0


