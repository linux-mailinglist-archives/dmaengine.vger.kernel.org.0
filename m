Return-Path: <dmaengine+bounces-11826-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9fG4FurUP2rbYgkAu9opvQ
	(envelope-from <dmaengine+bounces-11826-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 27 Jun 2026 15:49:30 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 378F06D20AC
	for <lists+dmaengine@lfdr.de>; Sat, 27 Jun 2026 15:49:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=gcPV5Mcs;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11826-lists+dmaengine=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="dmaengine+bounces-11826-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 46C7630074E7
	for <lists+dmaengine@lfdr.de>; Sat, 27 Jun 2026 13:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5077E3ACF0B;
	Sat, 27 Jun 2026 13:49:25 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1623D2D12EC
	for <dmaengine@vger.kernel.org>; Sat, 27 Jun 2026 13:49:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782568165; cv=none; b=e39EANK2EOOMlnIGQYK1nj+qB2KrcT/SYcVMnXMDWVF2BgkJmoSzpNRFokb4EEz3DgVqqxRg+cKV378hMnEaMK3/xPTxZXL4oIWd3lu2IXnHQOxiBpaSb/hSxmwEglrf+rzV9KiObfGOK2sVNm+/B7tuX9DLbeT/W2tQDrJKSmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782568165; c=relaxed/simple;
	bh=GOzRzWbEhVp1+PxLWp0Tf6FKj+pa/ze+t4q/T24vfNw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P4TUZIlZJ1KVsH/pVBItbPiZ2NP9HV1oMOJOFCCyIausd8QLNhiO7O8LbJAY78pvF95VuFEbECjBECCf/iBk6R5gbiR1txfdZCW/dF9+EssAsxQ6BCJtv0qy6RSe4G4ONH7UYIzCzZn7c5nqqhcuCsp930uga7gXFNnGVM2Db8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gcPV5Mcs; arc=none smtp.client-ip=209.85.215.176
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c96d2bebca3so10671a12.3
        for <dmaengine@vger.kernel.org>; Sat, 27 Jun 2026 06:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782568163; x=1783172963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GE0WgxrhQlszpq0bFS8ekUeWF2E3M+uVciQ9zYtpewc=;
        b=gcPV5Mcs6BrVma3w5TCRMI9NP/+ph5KQCZiljT/c2fBW0QMfrL6SC0PVtyihXe2ytQ
         QvKuQbq1zvwj9jn2yDxXIb7HXKe1TWF5B+r7rUhye6k2zAam4fxnlCPhoxcD4tqWDB2m
         I4Mn8SFxjOj/pq3IXG27jopX6uzQVDmm26ZC4u/e1YEP5+ugd68TTfoR7gxJjKvvTl5i
         4BYD2YHiZ7Pq1hpKbwKmp6O50ckOxFgJ2FW6zKVEDbqUBR/j+cYtWSVIseQRvacNU7w5
         Zmx468/FWZbdaQyLJ4RLptJKceDd6yWPbl/8mwSUPURXqqTQGSu8EXk6F0lozG7jN1hA
         pztQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782568163; x=1783172963;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GE0WgxrhQlszpq0bFS8ekUeWF2E3M+uVciQ9zYtpewc=;
        b=p3vYBSW7sj6M3NyWzqBXutlfS/6eWA4xpfBUhTV320dLuP5pXQpDLh5zF50QZgonjR
         QG7KtVCAWpi6s14Y5ZELesWvRg3TrAzlOgr6tJWPqS1IQN2twSoIaG3QhHSZxJvhRBTJ
         qF1QhwYlwFGZNbD4co06O6lXiC5dd87dXzENHjWfh3/lfAXEZnYx3162cyTufXwvZrVR
         EYSvoXoZ4iEYciDIqGuTeBGOArUNWRMQ2UqKDnKyX5rIvOW6roRq/TeNOzCUZOvEO1Ax
         bEUsck6/BXjUHQthf1/3N9BdKf7aDxf96ZNprlbekudryYBlWU4lOPWDBHIEkqs3gLhQ
         PCPw==
X-Gm-Message-State: AOJu0YxFr3HLXBt7SIm3VohUHLN5/2fO5lW8Axo2Swu8o1o+RNnE+VDW
	qjmJB0MyOf6BjJ8Y7I1J9sRbEzhR8bz4Ro7SkLKZyqzRYXhUklOvLNY=
X-Gm-Gg: AfdE7cncTFVbeVp97O1/mYKXLsjwfsj7PeOkJTcLDdYc5gWp9cXdXUUmbTTbWc8VJKe
	n0x1YYzQVwT08RMs6r63E6ra6TcISMgJkbcAG6gGOiAcJ+TIIBRqKIqYtNsiDwWorIN6vjQsCfF
	61/GePJhNRfEKAzYcmB//naj7gjFsM8rt3u4C3aH5pX8wImnFa6LVc1IM89mnV3wwADlOK9n/Ie
	VsAWcIWvjtowkSKIwkkZa7arhmuwcU+V+W/B+iUJyu/pRw4o68nAfoGNoQfcUI9JrH3ZdPwRsdC
	y2SbnQDHh5BP5NW4btJ5kHek7VoM2V2GOuTpt/kpsxT7FUFtDT9f65d050hG9wrkIyYCoQWVRXB
	DRtYCltLGWrC+cwLiRk15WUEiwBCmHzuF9TP/BIl0j2z3Rpux7BLNXBQBM+5dtH0YevuD0dFiLY
	+/V71Qa5aPOnlK5QA9MSBqnb6hRj92CujzckBgWcqJ4VkI2rSfI3eJ0/7vbhdGE9KE8i/RokbP6
	BvJ8Z7pLKza75+JsO+3MxcUX+ZNisH3zq9S/umWkn8rtdL7tQ==
X-Received: by 2002:a05:6a00:f8b:b0:842:38d2:a35f with SMTP id d2e1a72fcca58-845b3ae02b7mr11286739b3a.31.1782568163272;
        Sat, 27 Jun 2026 06:49:23 -0700 (PDT)
Received: from localhost.localdomain ([14.5.152.27])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845ba9fa138sm4691580b3a.52.2026.06.27.06.49.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 27 Jun 2026 06:49:22 -0700 (PDT)
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
Subject: [PATCH v2] dmaengine: mediatek: hsdma: fix runtime PM leak on init failure
Date: Sat, 27 Jun 2026 22:49:02 +0900
Message-ID: <20260627134915.8749-1-mhun512@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-11826-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 378F06D20AC

mtk_hsdma_hw_init() enables runtime PM and gets a runtime PM reference
before enabling the HSDMA clock. It currently ignores failures from
pm_runtime_get_sync(); if runtime resume fails, the usage count remains
held. If clk_prepare_enable() then fails, the usage count remains held.

Use devm_pm_runtime_enable() to manage runtime PM enablement, and use
pm_runtime_resume_and_get() so resume failures do not leak the usage count.
If clk_prepare_enable() fails after a successful runtime resume, drop the
runtime PM reference before returning.

The probe path also ignores the return value from mtk_hsdma_hw_init(), so a
failed hardware init can continue as a successful probe. Propagate
mtk_hsdma_hw_init() failures from probe, while keeping a separate unwind
label so mtk_hsdma_hw_deinit() is only called after hardware init succeeds.

Fixes: 548c4597e984 ("dmaengine: mediatek: Add MediaTek High-Speed DMA controller for MT7622 and MT7623 SoC")
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>

---
Changes in v2:
- Use devm_pm_runtime_enable() for runtime PM enablement.
- Drop manual pm_runtime_disable() calls from init/deinit paths.

 drivers/dma/mediatek/mtk-hsdma.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/mediatek/mtk-hsdma.c b/drivers/dma/mediatek/mtk-hsdma.c
index a43412ff5e..27cb370106 100644
--- a/drivers/dma/mediatek/mtk-hsdma.c
+++ b/drivers/dma/mediatek/mtk-hsdma.c
@@ -848,17 +848,27 @@ static int mtk_hsdma_hw_init(struct mtk_hsdma_device *hsdma)
 {
 	int err;
 
-	pm_runtime_enable(hsdma2dev(hsdma));
-	pm_runtime_get_sync(hsdma2dev(hsdma));
+	err = devm_pm_runtime_enable(hsdma2dev(hsdma));
+	if (err)
+		return err;
+
+	err = pm_runtime_resume_and_get(hsdma2dev(hsdma));
+	if (err < 0)
+		return err;
 
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
+
+	return err;
 }
 
 static int mtk_hsdma_hw_deinit(struct mtk_hsdma_device *hsdma)
@@ -868,7 +878,6 @@ static int mtk_hsdma_hw_deinit(struct mtk_hsdma_device *hsdma)
 	clk_disable_unprepare(hsdma->clk);
 
 	pm_runtime_put_sync(hsdma2dev(hsdma));
-	pm_runtime_disable(hsdma2dev(hsdma));
 
 	return 0;
 }
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

