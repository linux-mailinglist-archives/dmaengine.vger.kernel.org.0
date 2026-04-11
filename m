Return-Path: <dmaengine+bounces-9983-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMdTMEA02mlezAgAu9opvQ
	(envelope-from <dmaengine+bounces-9983-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 11 Apr 2026 13:45:04 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5E53DF8F7
	for <lists+dmaengine@lfdr.de>; Sat, 11 Apr 2026 13:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5CFB03074A23
	for <lists+dmaengine@lfdr.de>; Sat, 11 Apr 2026 11:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E048834846A;
	Sat, 11 Apr 2026 11:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="LWK5zAMA"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B7D340DA6
	for <dmaengine@vger.kernel.org>; Sat, 11 Apr 2026 11:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775907797; cv=none; b=bup61B3oI5GxLanSlxKh4m3yM86bBg92/22oz5a2r+xqpz1+0ALO20Yc24iS9zqLBpTVIvjUzqn/vo1sTqU2pqcTljl+3Si0ooFI0z2DChxV+XDCVBpd3gBYmz5CKsJ1NjqIhlowTQqOqToir8MM9gkAgIXG4e75sDucJFU7ZVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775907797; c=relaxed/simple;
	bh=gmR2MVgWRVwxG2GLS1GQZ1Ib/I0giv+IntwWqRZ8pCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lXpf8z9YIDoBf1faF/OFHz/E3Vw2Tx9HPkr/M5A2oFe3pyBtxyBEvpaWS2v1KHCLeecpyXnWd2r7vEsY3iucZyNQ9KE+Q6WtcVS0c5AqzcdSpqa4i5k9KTMksI8GHWRV/gXrZRljo21WYnSSBHfAuVgDoye0tAh7MrEB/9C6UZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=LWK5zAMA; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43b8982c2f4so1721690f8f.2
        for <dmaengine@vger.kernel.org>; Sat, 11 Apr 2026 04:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1775907795; x=1776512595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uEklTJzShDhVfSMVqbktdCdKI5vT2XbfZJslRpJnIVQ=;
        b=LWK5zAMAs5Qrl1Q/JOXtiW2AyxCvqFKJHYeCsBZ2SPR/cN2cMKxQ80H+jKARE6Cx3F
         Ni8HLEOvVriHKK7lCRP7CXIEFtHD17VPnuQvGYajQOtRgtwVDtU6m4af8ffmRt8EyjRk
         FMFYNFNM3WYUAm7fFe4rEJQS/P9s7KAI4bjfzxXriAhK5EZhtUvzwXY5rZFUzfo3MQkG
         7255XWamcLGLD/ykQFcaQ5dS29M2cnkhFpRjjedzK7l0Y6LElbZDFDt762qZrVLf54oL
         R4GTYMKVsH7W6qtxwx8OlxjzjVD7umaqLRgRICDgNqGIg/VGdTUDb9YEsEyZdwpAnSM+
         RbyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775907795; x=1776512595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uEklTJzShDhVfSMVqbktdCdKI5vT2XbfZJslRpJnIVQ=;
        b=drcbpw8WIBOdOts6VbQYAPbhYCLh4VvxKwYY1tq42aCO+RA5NnWoRgM60umzi5BB98
         SRf5GwglO/j/S1dg4ocibf6SGs63KMq3VnNjewTGT5WdkU38lpumJ2SG3hooJCEsTBTY
         5WU8HIdFOY2LwbPlMQ3VNh3o81Cvo2oTZwcfoYMK6L1QNTSJbE+xKoiS59OcF8hwsYrO
         NOkZhqSF7pizylMAZMM++PYpP2aLie+e/mkXUt6pQcLS9yCWd4SZ6sfRXAG34hcUrzmU
         6uRfiSnsGmcfyiZegmU4/HtwkfFEvaBzMQ18uaXe/ktGogGlyyL9ZonBUsX71CrPRNRr
         Qetw==
X-Forwarded-Encrypted: i=1; AJvYcCU0pQ5v5ozQzKxNalats8v5ab1i/KXEJnubmpGrfKS3oWgRH4a0W44MqDP58M7EVMRZdynKD1obpv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtJR+ytknYZQYPXFQVxx5DvvvUKCY/8GPaPsSTngKedZRAKTeg
	1i0H/0Nsf9URmHNXaAo7VT0utw4F8yAhmBM6u3mUAM55si1capcfWsV8tHpML7FhzwU=
X-Gm-Gg: AeBDiesnRVZAcjQ0cPXv7MKPsYTzQw5/x0ub3zjTHGdVIZ1Mki71AVx6U+ORkZsLFub
	p1CnJC2HijCTyuABGJuVNiDN1xxeo6xlS4Fp+LOZbbkl9Ng9fTR60ezeRkPE7yjBzoeRldjDljo
	1/FhV8mvqyco8doG5Y8hnoiKkj7jzcBDsaaUL/YNdJ9B1hRbQpJpEkzjDK2eB8IH5BCXRJ/ZI/O
	5dxfsnXRcNSHIqCsW2temmi3aayAwyYswGLYn7WItDQC8s9lVzdAbeHyNfwVl24wTTm8xO7ty+0
	foIUgvxMVRXwUzNmsAdCHd2R4XMW3DOToAYvN/q5kvtcAFssjaQd2jW2ykbTpk+9tC+BVc+Ap4Y
	OmQM4WEsRf97REZhiBBG+tcSk8AgHs5C43Y7GZAgiMQ0FKeG3bomef/AuhdHsjrq4GObP+vwinH
	cb/BnHn62c+YvnL6qimf1fo8Xwrsm0gB5RGi7rGTpGloJUBlfwiQxl
X-Received: by 2002:a05:6000:208a:b0:43d:1df6:ea9 with SMTP id ffacd0b85a97d-43d642c0938mr8925884f8f.40.1775907794662;
        Sat, 11 Apr 2026 04:43:14 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e5c981sm15776447f8f.33.2026.04.11.04.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 04:43:14 -0700 (PDT)
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
Subject: [PATCH v4 04/17] dmaengine: sh: rz-dmac: Use rz_dmac_disable_hw()
Date: Sat, 11 Apr 2026 14:42:50 +0300
Message-ID: <20260411114303.2814115-5-claudiu.beznea.uj@bp.renesas.com>
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
	TAGGED_FROM(0.00)[bounces-9983-lists,dmaengine=lfdr.de];
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
X-Rspamd-Queue-Id: 3E5E53DF8F7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Use rz_dmac_disable_hw() instead of open codding it. This unifies the
code and prepares it for the addition of suspend to RAM and cyclic DMA.

The rz_dmac_disable_hw() from rz_dmac_chan_probe() was moved after
vchan_init() as it initializes the channel->vc.chan.device used in
rz_dmac_disable_hw().

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v4:
- in rz_dmac_chan_probe(): moved rz_dmac_disable_hw() after the
  vchan_init(&channel->vc, &dmac->engine) call as this is the one which
  initializes data structures used by the debug code from
  rz_dmac_disable_hw(); updated the patch description to reflect this
 
Changes in v3:
- none, this patch is new

 drivers/dma/sh/rz-dmac.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 1717b407ab9e..40ddf534c094 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -873,7 +873,7 @@ static void rz_dmac_irq_handle_channel(struct rz_dmac_chan *channel)
 			channel->index, chstat);
 
 		scoped_guard(spinlock_irqsave, &channel->vc.lock)
-			rz_dmac_ch_writel(channel, CHCTRL_DEFAULT, CHCTRL, 1);
+			rz_dmac_disable_hw(channel);
 		return;
 	}
 
@@ -1000,15 +1000,15 @@ static int rz_dmac_chan_probe(struct rz_dmac *dmac,
 	}
 	rz_lmdesc_setup(channel, lmdesc);
 
-	/* Initialize register for each channel */
-	rz_dmac_ch_writel(channel, CHCTRL_DEFAULT, CHCTRL, 1);
-
 	channel->vc.desc_free = rz_dmac_virt_desc_free;
 	vchan_init(&channel->vc, &dmac->engine);
 	INIT_LIST_HEAD(&channel->ld_queue);
 	INIT_LIST_HEAD(&channel->ld_free);
 	INIT_LIST_HEAD(&channel->ld_active);
 
+	/* Initialize register for each channel */
+	rz_dmac_disable_hw(channel);
+
 	/* Request the channel interrupt. */
 	scnprintf(pdev_irqname, sizeof(pdev_irqname), "ch%u", index);
 	irq = platform_get_irq_byname(pdev, pdev_irqname);
-- 
2.43.0


