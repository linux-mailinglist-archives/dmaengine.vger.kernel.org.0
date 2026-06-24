Return-Path: <dmaengine+bounces-11764-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gG2BN4uSO2qYZwgAu9opvQ
	(envelope-from <dmaengine+bounces-11764-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 24 Jun 2026 10:17:15 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 328026BC825
	for <lists+dmaengine@lfdr.de>; Wed, 24 Jun 2026 10:17:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=qFx8NW+k;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11764-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11764-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E69AB30086EC
	for <lists+dmaengine@lfdr.de>; Wed, 24 Jun 2026 08:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04802391846;
	Wed, 24 Jun 2026 08:17:13 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2833812FB
	for <dmaengine@vger.kernel.org>; Wed, 24 Jun 2026 08:17:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782289032; cv=none; b=W59eUOFHJpWBxzPeq9gtqdIvAxPEqI9B3ZYVFhscCYTaqTcsGis6gKlTu6IEhINZwypc0nM4o6o9DTWb5DhibTLAGMGGq7cI47d7xhamJ4E43clfkctUIBYu5dZoTOc0AKZwLoORi5ob4Cr/eDfvSnNFCA9G0gZ4Op8EpU+6FFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782289032; c=relaxed/simple;
	bh=jyz1DyVG7HpPxBEvVZr90DObGRcQES4BU+PqnBRSycA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UWFZWTErIyl+9GELV8igYf+q/htQhZjQRt+6MDND/MnbGSSuY07eW4YtYUQ7ft8yPVys5ZBNtcZvScTdlIx1ESya83UkpRDv00BXfscKB2SnkNBPcwKEhnZuqQL5i1kRv8nD2tv+cqKPVNPgMDPbHFhhP+fG6DzUL7G7K0AqRJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qFx8NW+k; arc=none smtp.client-ip=209.85.216.41
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-37c64d34032so932623a91.0
        for <dmaengine@vger.kernel.org>; Wed, 24 Jun 2026 01:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782289031; x=1782893831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=36jF0aae/2qf/mqPeDqHORRtGgqdr7FBWT7b1LCQhJc=;
        b=qFx8NW+k9zLv5n+g7bFH840queuFNmLec8hTW4ji4fbyiD/w4kA8VaDw2lc3h/OlFr
         meFVuOrPDJvINfrablxwZGe4tUHRi8+871zNLGI19xM3t8EbJX8SI6URxPJXD67LnwZL
         mpyR1XdWC56/gM1+hcW4dwP55OBhqKscJjZYlkIzBdPFF0gEXnZQ6mX/PPbrdioQ5CIr
         mWoKSzzIJUk9DVOJsFXxmD2ajNEjufhHdQibs40QE90Wq6EunsOMg+SChYC61fstcKab
         Gk4/p6ugULmp3tkarjigmZEngiVnKNizdr6gJH20/g0doloJE7UwYLKUJmyWkvIFkl7P
         SZHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782289031; x=1782893831;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=36jF0aae/2qf/mqPeDqHORRtGgqdr7FBWT7b1LCQhJc=;
        b=KrwDB7jocu0j9Q0Pb5Ha4n/trWiREWuO+HJLSG82tlgdNEEnWA3AqZyAsOlnNwNWzl
         qI3RMTNrXFc0b/pHoxFBjl6w93ttAf14wB7o9W5PttR3LXHE2wtuXSLSZxTNu6sjtLee
         ifvqWyAiGDzIiHRS/SgfgK7PIIN2asmaHbIGUSy+DTtGAqyOxFnPrLJ8gywIMhxO8juy
         YaUUKRaYJbcEPZCqBiXXSqUXwHWXtxs+T6GLvKj7BgVEH6BHDGW8I6DAEo/xlfZ5iSqB
         9DXkE9JCowpfg4JkTjS7rvz8gKgLdVfUqM3HViPPEe/EM078WsKAVN7z6z3QtTgKLCE8
         yNzQ==
X-Gm-Message-State: AOJu0Yz1HXmByAPqRA6wvAqKn3iu8UH5GuQAOADQZGoR780FqkXqd8rH
	G/sqkWDixr7i+a8lrGILMR6gOLO4xbAdadncxmL/V0/KfJ0cBN08+KU=
X-Gm-Gg: AfdE7clMPD94einJ37IOOSwxJdmg0hZ8WhjusDnQnDKnFD6fRvX5/7OdBiM5vRXva3c
	KgNopiAT/wsqP+4EeUB6utls8XtIjoFepLtMPPaL+safgAgvPJG9AW9Fo31nQ5jSdIWQ7CS2t30
	8Aaa5CGsZ8SHuz5aembrabZDpgp/JBfAZTTJd6Y13J7Q+3X1hq+gZwIOeZexzjLw6sDrCnACT/2
	sbs/9g+cBASLCzQBRO1RoGUWGrzsE8FDMN1j6Gis8xRA8Jz75tG1BEIUfyXr7F/K/x1+nksuZd2
	DaG7gg1k/FeJTVuy07TlNrMb/Lpq5/ZawmTjRZqNKcWUl2kOe7iuP6VtXZtNkA5LOkAlfH3R2Qj
	y3Wox831oAL2XJU+0sb4Q2OdX4VFY0aVmS5pG6b6tr7u6mOTZ93hkt1TNg/hdjFBUKKwCZqKh0P
	zgq5E+okpcaEKuC4Kuvv9Nq7hFgVoHRRKdIYM1MEtULDyFD6UAuCPEiRO/aX+8odV2
X-Received: by 2002:a17:903:8c5:b0:2bd:3c21:a053 with SMTP id d9443c01a7336-2c7c3ff8e32mr60401005ad.24.1782289030882;
        Wed, 24 Jun 2026 01:17:10 -0700 (PDT)
Received: from localhost.localdomain ([14.5.152.27])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7436f7de7sm121836085ad.32.2026.06.24.01.17.07
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 24 Jun 2026 01:17:10 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Sean Wang <sean.wang@mediatek.com>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] dmaengine: mediatek: hsdma: fix runtime PM leak on init failure
Date: Wed, 24 Jun 2026 17:16:38 +0900
Message-ID: <20260624081701.19358-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-11764-lists,dmaengine=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sean.wang@mediatek.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:dmaengine@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:mhun512@gmail.com,m:ae878000@gmail.com,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[mediatek.com,kernel.org,gmail.com,collabora.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[mhun512@gmail.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhun512@gmail.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 328026BC825

mtk_hsdma_hw_init() enables runtime PM and gets a runtime PM reference
before enabling the HSDMA clock. It currently ignores failures from
pm_runtime_get_sync(); if runtime resume fails, the usage count remains
held. If clk_prepare_enable() then fails, runtime PM is left enabled with
the usage count held.

Use pm_runtime_resume_and_get() so resume failures do not leak the usage
count, and unwind runtime PM when clk_prepare_enable() fails.

The probe path also ignores the return value from mtk_hsdma_hw_init(), so a
failed hardware init can continue as a successful probe. Propagate
mtk_hsdma_hw_init() failures from probe, while keeping a separate unwind
label so mtk_hsdma_hw_deinit() is only called after hardware init succeeds.

Fixes: 548c4597e984 ("dmaengine: mediatek: Add MediaTek High-Speed DMA controller for MT7622 and MT7623 SoC")
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>

---
 drivers/dma/mediatek/mtk-hsdma.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/mediatek/mtk-hsdma.c b/drivers/dma/mediatek/mtk-hsdma.c
index a43412ff5e..987e5274fc 100644
--- a/drivers/dma/mediatek/mtk-hsdma.c
+++ b/drivers/dma/mediatek/mtk-hsdma.c
@@ -849,16 +849,25 @@ static int mtk_hsdma_hw_init(struct mtk_hsdma_device *hsdma)
 	int err;
 
 	pm_runtime_enable(hsdma2dev(hsdma));
-	pm_runtime_get_sync(hsdma2dev(hsdma));
+	err = pm_runtime_resume_and_get(hsdma2dev(hsdma));
+	if (err < 0)
+		goto err_disable_pm;
 
 	err = clk_prepare_enable(hsdma->clk);
 	if (err)
-		return err;
+		goto err_put_pm;
 
 	mtk_dma_write(hsdma, MTK_HSDMA_INT_ENABLE, 0);
 	mtk_dma_write(hsdma, MTK_HSDMA_GLO, MTK_HSDMA_GLO_DEFAULT);
 
 	return 0;
+
+err_put_pm:
+	pm_runtime_put_sync(hsdma2dev(hsdma));
+err_disable_pm:
+	pm_runtime_disable(hsdma2dev(hsdma));
+
+	return err;
 }
 
 static int mtk_hsdma_hw_deinit(struct mtk_hsdma_device *hsdma)
@@ -983,7 +992,9 @@ static int mtk_hsdma_probe(struct platform_device *pdev)
 		goto err_unregister;
 	}
 
-	mtk_hsdma_hw_init(hsdma);
+	err = mtk_hsdma_hw_init(hsdma);
+	if (err)
+		goto err_free;
 
 	err = devm_request_irq(&pdev->dev, hsdma->irq,
 			       mtk_hsdma_irq, 0,
@@ -991,7 +1002,7 @@ static int mtk_hsdma_probe(struct platform_device *pdev)
 	if (err) {
 		dev_err(&pdev->dev,
 			"request_irq failed with err %d\n", err);
-		goto err_free;
+		goto err_deinit;
 	}
 
 	platform_set_drvdata(pdev, hsdma);
@@ -1000,8 +1011,9 @@ static int mtk_hsdma_probe(struct platform_device *pdev)
 
 	return 0;
 
-err_free:
+err_deinit:
 	mtk_hsdma_hw_deinit(hsdma);
+err_free:
 	of_dma_controller_free(pdev->dev.of_node);
 err_unregister:
 	dma_async_device_unregister(dd);
-- 
2.47.1

