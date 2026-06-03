Return-Path: <dmaengine+bounces-11133-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gTOnGo+bH2oDnwAAu9opvQ
	(envelope-from <dmaengine+bounces-11133-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 03 Jun 2026 05:12:15 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DDB633C9A
	for <lists+dmaengine@lfdr.de>; Wed, 03 Jun 2026 05:12:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=OGl8ceDC;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11133-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11133-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B21C30C3968
	for <lists+dmaengine@lfdr.de>; Wed,  3 Jun 2026 03:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD4D3E63B5;
	Wed,  3 Jun 2026 03:08:26 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805193E5EF5
	for <dmaengine@vger.kernel.org>; Wed,  3 Jun 2026 03:08:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780456106; cv=none; b=DlhO9SwoZU1jrtI7EEyBlXZ+jFtsHV/UOLd/+R5uHR0DbsTscJvFtbdXDAOQrNGq5BUi7foc9vXrPfUlvz+/0ZP2wqvZTM0jJEqOffMl5Fo1DowDIcCD/fjggLStVlk7ZxIwj4y0WKlAAoGE1RJYJLiAbkz2OTIoCfG8Luz5Clg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780456106; c=relaxed/simple;
	bh=UU+KzLESSp0kk4B2q1HC+6X1v604zjgC2rTFZxQX9f4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ioPrYlqijfPPE7nmhjXeI0YEWRk6nIia9l8d8APNTY5BDwSV/wfPRccmMIaIEd3ivJyv+wUNLq6xRJQUkeT9fNF3WTnxPYO1aJqFmUWk1Arln2+v9jXmcxfH/u+H5p7ak+TuB7vGexpkiEDW/38Vf3U+oyZmkKS23QtwpULFitA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OGl8ceDC; arc=none smtp.client-ip=209.85.216.50
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-36b903567fdso5483123a91.1
        for <dmaengine@vger.kernel.org>; Tue, 02 Jun 2026 20:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780456104; x=1781060904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hJVVrtusx/XpEEVdlLkuxUdKg7eDHMaqI+aWjwG9HdM=;
        b=OGl8ceDCBtlLCERK3ugdlfbuHCwGRae3xVXkKdyuFXLkvcn0Vd0SNbtZwmWAE5ylFY
         lqGExur9LRChbI8mXwnSFP2iLTYDNEUYYU5FrkeboLA6MsF/ztBilcgvGKdexwfY/TIN
         YWDQ4Pt7X8pLbkB6qQTv4hfosQleVTDgBjov0XU8OV+UULuENg9NDDQkPzKbaIyalUHL
         CsSQCYzqkrlt2E6p8tXD6tXB5Ks3bvH5c2uKlhWGNEiwafInq2SgSNrIJpYynUAFbzdU
         5oL1MSfDqIaStX11z/r3gNrYlzka8LsMOuif0XvgMXoHcgTrteYsBNnhpZ3mwpqmKTjq
         o5QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780456104; x=1781060904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hJVVrtusx/XpEEVdlLkuxUdKg7eDHMaqI+aWjwG9HdM=;
        b=cubbDTsCO2KPh31+l7PPyO7pKK2tIQvvy2iSzVd6wWAW28FRD/7hHmFfwsmc5qB2RI
         TxVqx5VL1I7Ph7JScqvdFJlL4550D+wUf9PK4BKW1kp4MF3jiB8cTN9TTnUufiyb9Usu
         7FKqZ+ZpY2BCk2rCvOIZTYTWTRJXuQQFtTT3Wzv3QnyVxUDkNRXvdvWpmFnPqNvyzvMQ
         hx7zbe4TNBY4h4aXl0MbUVHNJXdZHdKoH+sDLcCUvkY6Ly4rV1BoVbhLbGYtibOYo9C0
         Z5WKWSbRQCyvObTb14XldOup1ZB9W06n6WeWBJgVPD3SN5qQxmf77NllaklyoFms5lz0
         iR7g==
X-Gm-Message-State: AOJu0Yw95W90sNRvbJoGnfm8Av5nKwiDmec0UGeb279fLGmZ02ZtvVR0
	0e8r1oAsMXNZw8GHgcZ17tJd7MOR+qgqVS+CgHrW6pD8IKUdpCsQAsbqLavzd8aY
X-Gm-Gg: Acq92OFzeaTbnfHPM46Q2fFkNhc9VTbGjvQa+jE2Up6/8Tigow7qVwUa41icP/vHBWf
	KfVfelxWeY0ArH+Gw/3g7I1P3DLzt9+wKczpGV2kZ2VykVOS4D2KNZI/uXDhjWB+Ir560AUNzLa
	9MEF6cvkoCYQ0r1pcU4p0E0QQa4TJPXqNP8xGk628noDxrpUN9MyOB+UWSr6Ai7M46Req+OtBCR
	yM4vI/En1a95t7KoCHdHLxDIMFKs3juR4mqbezkXmISjwLmxArc/iG5oQckngFTuqWqhqiYK13R
	G5OeQ8ysuKIeBU1PBZG8Tc8iY7Uz9VJLtVIjESrJyE3cTaXTAzMLf/OxIbHVzFnHy16d91yQ+AI
	JlxkTpNiTPrMJKw1Sm+YAtLCAG5aBk2d9aBu2AlEYVkYkZI6uKA9rkYpixfhx6uKIG3aaUH/t30
	CLv4D78EwwbLbYiOQ+X5D32iEyDRtfhXNhfP2zmRK1mXn2W0DP57FUL3YP81JACsf8zXnrzDIZ1
	+02OH1DtLbcK4yz7Zo8j5vl4m2n9MiLQ54uNjkAkE0RBA==
X-Received: by 2002:a17:90a:c887:b0:36b:293:68d1 with SMTP id 98e67ed59e1d1-36e30a29736mr1332510a91.16.1780456103709;
        Tue, 02 Jun 2026 20:08:23 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36e0a186741sm1247102a91.8.2026.06.02.20.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 20:08:22 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Haotian Zhang <vulab@iscas.ac.cn>,
	Tony Lindgren <tony@atomide.com>,
	Russell King <rmk+kernel@arm.linux.org.uk>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be|_ptr)?\b)
Subject: [PATCHv3 6/8] dmaengine: ti: omap-dma: destroy descriptor pool last
Date: Tue,  2 Jun 2026 20:07:52 -0700
Message-ID: <20260603030754.288757-7-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603030754.288757-1-rosenp@gmail.com>
References: <20260603030754.288757-1-rosenp@gmail.com>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,iscas.ac.cn,atomide.com,arm.linux.org.uk,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11133-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dmaengine@vger.kernel.org,m:peter.ujfalusi@gmail.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:kees@kernel.org,m:gustavoars@kernel.org,m:vulab@iscas.ac.cn,m:tony@atomide.com,m:rmk+kernel@arm.linux.org.uk,m:linux-kernel@vger.kernel.org,m:linux-hardening@vger.kernel.org,m:peterujfalusi@gmail.com,m:rmk@arm.linux.org.uk,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,kernel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C4DDB633C9A

Linked-list descriptors are allocated from desc_pool and can be
released from omap_dma_free() through the channel descriptor cleanup
path. Destroying desc_pool before freeing channels leaves descriptor
cleanup with a dangling pool pointer.

Free the channels before destroying desc_pool in probe failure paths
and in remove.

Fixes: 1c2e8e6b6429 ("dmaengine: omap-dma: Support for LinkedList transfer of slave_sg")
Fixes: 2e1136acf8a8 ("dmaengine: omap-dma: fix dma_pool resource leak in error paths")
Cc: stable@vger.kernel.org
Assisted-by: Codex:GPT-5
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/ti/omap-dma.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
index 61a935660341..c0890d8c43ba 100644
--- a/drivers/dma/ti/omap-dma.c
+++ b/drivers/dma/ti/omap-dma.c
@@ -1818,9 +1818,9 @@ static int omap_dma_probe(struct platform_device *pdev)
 			spin_unlock_irq(&od->irq_lock);
 			omap_dma_glbl_read(od, IRQENABLE_L1);
 		}
+		omap_dma_free(od);
 		if (od->ll123_supported)
 			dma_pool_destroy(od->desc_pool);
-		omap_dma_free(od);
 		return rc;
 	}
 
@@ -1842,9 +1842,9 @@ static int omap_dma_probe(struct platform_device *pdev)
 				spin_unlock_irq(&od->irq_lock);
 				omap_dma_glbl_read(od, IRQENABLE_L1);
 			}
+			omap_dma_free(od);
 			if (od->ll123_supported)
 				dma_pool_destroy(od->desc_pool);
-			omap_dma_free(od);
 			return rc;
 		}
 	}
@@ -1888,10 +1888,10 @@ static void omap_dma_remove(struct platform_device *pdev)
 		omap_dma_glbl_write(od, IRQENABLE_L0, 0);
 	}
 
+	omap_dma_free(od);
+
 	if (od->ll123_supported)
 		dma_pool_destroy(od->desc_pool);
-
-	omap_dma_free(od);
 }
 
 static const struct omap_dma_config omap2420_data = {
-- 
2.54.0


