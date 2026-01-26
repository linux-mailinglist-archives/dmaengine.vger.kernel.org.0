Return-Path: <dmaengine+bounces-8490-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJPIIddCd2mMdQEAu9opvQ
	(envelope-from <dmaengine+bounces-8490-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 26 Jan 2026 11:32:55 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 244248702D
	for <lists+dmaengine@lfdr.de>; Mon, 26 Jan 2026 11:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1FC2A301DEFD
	for <lists+dmaengine@lfdr.de>; Mon, 26 Jan 2026 10:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D14A330D5E;
	Mon, 26 Jan 2026 10:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="HwlYUNH3"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B55330B39
	for <dmaengine@vger.kernel.org>; Mon, 26 Jan 2026 10:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769423530; cv=none; b=LVFqPkEBBTytzgPBSTBtT5BMkIJuKSr7ys5mPLfQR8Kwdykyeix1Z7ET8SMb2SYlZ9ZNkfXHs7+FHX8j6cICBNJi7QP63GhRIIKfj+5JooPfZpZm6ka9+Ede58ffooIhvrmowo4AyrOlwvElyoG2Hk9yN097HOPfE38Nc/mbNE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769423530; c=relaxed/simple;
	bh=r/SU5oimCuoe+JcHi0XUqVFDCGGG+2pEiPjSeS+Fvhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HOzPYXrxo0JwRt6QiVpMuHxvReEsiWJw8jQ7Bulzj0V3m/N/hJkilcXeAYgwfs+/TbbIB7Zyu/WEJQ1gyu6rdkonSs78hGtCshOTSZdE3yLlAUafZSfoa66DWdzhPN5aqLtlFsuE/b5GMKxQVYGl398rOAHSBTFVxxkmnK/KW98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=HwlYUNH3; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-430f3ef2d37so3815328f8f.3
        for <dmaengine@vger.kernel.org>; Mon, 26 Jan 2026 02:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1769423527; x=1770028327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nWa0aGJtSMtx7LCzliIPZcMgkE6x5phxxbaj/EtOLPo=;
        b=HwlYUNH3Wn+odahPefogz6BXJ3wnDaNVajiYnyDjhjToqMIKq4UMP51TmP05SWISDf
         0dWNHkB1yrQijuTSmDsAWPZOZZb5L7d2AuO6Z95fvVF9b8TBUuO0Uit5S68YNrWroLyD
         iLvqdxs41ehk/os9QuSVIZ1PBPn8DI5PYOJrWc7zG3XBwR+l8g7Awnwi5pRv3sV3hoTb
         8O2TK0XrfFT1TqPR85Z4mEXslHKomILN/B7O0q6DQpfwG52iXJ4HL1xtn5wtbrbMFUo0
         BxwlR0zm3X1YIDJHhBramH49UGC53nKLXsw99J4EH/8EmoLbKvJKrkV9JAG9Q53I+tqj
         DU5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769423527; x=1770028327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nWa0aGJtSMtx7LCzliIPZcMgkE6x5phxxbaj/EtOLPo=;
        b=S0XnoPdhzAYD0MNESlritbBdgcsy57ZbsNHqmcWKDsddKS+WoNi7YucXK1txWmu79+
         g4+bmBUd7zOB2ERl5MZc9kasyKWKH7SiofFMWT9BNXYg/dnaQmVqruoM5CTRKrQT0mjG
         2iLgxEvIPLsgS6mKV4tlr0DtxHM2Fcq+uHCgCxQt8K3IdkwERCdxxShslc3ud/dhCSEP
         qfxQclIfy5jM/7HU9xeFBJWI/MINUpuzp0V/+EIf2eL07/SPJx1TcC/dmpMI4izi0mX+
         r3gnQkdSBAS88rV4rq9SfE19hQ4+C840tvhmcHdxDv5GgFlwrEvdokcECgxUYjCK4mWw
         YRhw==
X-Forwarded-Encrypted: i=1; AJvYcCVhgK3nRanVXIFOLm1F/yU9KDLzFyyJxnAaEyytEywa3XsiU+S9tqSZPpEKkBX6YwamuqBtZxqkEVo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9qUgu3yeuNwjfSOnVaPM9MxaMpyRYISOuJSPjOBA0k/uJgnJC
	D0GeOk5MLcVWllvOPvdHh0EeZJIpHSfZcqZ6XyTNu6vV5pZirEwvAo6XzaWtgsurf2k=
X-Gm-Gg: AZuq6aJDMO2+n/nMWKLXrNWi7prRYSAzz1WuHWVGVTvvgkJsYS8dKUass9EJCPbfTWp
	NQU+2+oCj1rM/N1cGnTcaFd+V+vRJ1mexNIJXbOGHDJtGDDqiRpvzfvLKU6OyC8QkZ5qCrDRa0R
	vGbx0F0isnfvmdSO6MBht7ip98yvwA33GCOjGPp4Smr9uuoFRyRFDZz/rPfzKcFS9gtZRrQQspC
	oTg2rg4bSqX0meo1vuVGcY32KtInxYDxnsj3g69qgl+/vQQcBrUUPY3grewZrc8BCUDjexP57ES
	EYgZJzMFT2xUVEpUHj81xZmmMh217slcEMeL73Z0dRpfZvf2ykfPRLq6oFHit9U8nIP/Vpwarkp
	w7Acyi28EEsaPa/534RW520RaIaP4skqT1tL3B6umQIqIVe1HqN0GOYjTUZ3BKEywRiD26hm/S/
	qlOzCKrT9mGtcLQgebPnggrUJGzJvPkdemazbHuHw=
X-Received: by 2002:a05:6000:24c1:b0:433:1d30:44c with SMTP id ffacd0b85a97d-435ca138ae8mr6980335f8f.43.1769423526727;
        Mon, 26 Jan 2026 02:32:06 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1c246ecsm29715049f8f.10.2026.01.26.02.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 02:32:06 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: vkoul@kernel.org,
	biju.das.jz@bp.renesas.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	p.zabel@pengutronix.de,
	geert+renesas@glider.be,
	fabrizio.castro.jz@renesas.com
Cc: claudiu.beznea@tuxon.dev,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 3/7] dmaengine: sh: rz-dmac: Drop the update of CHCTRL_SETEN in channel->chctrl APIs
Date: Mon, 26 Jan 2026 12:31:51 +0200
Message-ID: <20260126103155.2644586-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260126103155.2644586-1-claudiu.beznea.uj@bp.renesas.com>
References: <20260126103155.2644586-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[tuxon.dev:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8490-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[tuxon.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,bp.renesas.com,gmail.com,perex.cz,suse.com,pengutronix.de,glider.be,renesas.com];
	DKIM_TRACE(0.00)[tuxon.dev:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[claudiu.beznea@tuxon.dev,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tuxon.dev:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bp.renesas.com:mid,renesas.com:email]
X-Rspamd-Queue-Id: 244248702D
X-Rspamd-Action: no action

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The CHCTRL_SETEN bit is explicitly set in rz_dmac_enable_hw(). Updating
struct rz_dmac_chan::chctrl with this bit is unnecessary in the current
code base. Moreover, it conflicts with the configuration sequence used for
cyclic DMA channels during suspend to RAM, which will be introduced in
subsequent commits.

This is a preparatory commit for cyclic DMA suspend to RAM support.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 8d8391a5b3a7..4bc7ea9566fd 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -375,7 +375,7 @@ static void rz_dmac_prepare_desc_for_memcpy(struct rz_dmac_chan *channel)
 	rz_dmac_set_dma_req_no(dmac, channel->index, dmac->info->default_dma_req_no);
 
 	channel->chcfg = chcfg;
-	channel->chctrl = CHCTRL_STG | CHCTRL_SETEN;
+	channel->chctrl = CHCTRL_STG;
 }
 
 static void rz_dmac_prepare_descs_for_slave_sg(struct rz_dmac_chan *channel)
@@ -424,8 +424,6 @@ static void rz_dmac_prepare_descs_for_slave_sg(struct rz_dmac_chan *channel)
 	channel->lmdesc.tail = lmdesc;
 
 	rz_dmac_set_dma_req_no(dmac, channel->index, channel->mid_rid);
-
-	channel->chctrl = CHCTRL_SETEN;
 }
 
 static int rz_dmac_xfer_desc(struct rz_dmac_chan *chan)
-- 
2.43.0


