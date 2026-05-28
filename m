Return-Path: <dmaengine+bounces-11006-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mM/0KkFIGGr2iQgAu9opvQ
	(envelope-from <dmaengine+bounces-11006-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2026 15:50:57 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADF35F3075
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2026 15:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E8D79301530F
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2026 13:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8B828CF4A;
	Thu, 28 May 2026 13:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="eaouD/XP"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D3827AC48
	for <dmaengine@vger.kernel.org>; Thu, 28 May 2026 13:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779976225; cv=none; b=WGp5OuiLXqn+eBUmuR2YisWot8nI9uFjMHKD7zu/yjHe66jCilSaRE8b2b+ZhjKrRhvOSBhI5zel3GPVUaZAkMhoo7rdSUlSI2NSuE0nMHin7iT/MbrU5ObMSOshA327K+DbsIq49VdwSP9rHadRmzjwfLCr6x5UUCODtnkiAKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779976225; c=relaxed/simple;
	bh=sCw7FtaG3QEoIeycoMDDazd6TFJyzO5RGri3sYmQgtU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EUmgP+xd+1DHTZX3aLUA9Ile0bM4MBajsUnTkK74/sxerSOwiYiRBwEaIeWzVIDyCrEjeKI7DazIm7INiexjDkAQF5WfUW4ymheP1IfuFYzmMfXpZR5xluza+U5SiG5ReNLqfrZsEclNOsIy3ZJrpeFbD84JqIcVxyaFGvkSCwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=eaouD/XP; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-45eee266c6cso147636f8f.1
        for <dmaengine@vger.kernel.org>; Thu, 28 May 2026 06:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779976220; x=1780581020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cQiBtfW273MEpqVw/bgib56fWooXdt01yOmehx1vkfY=;
        b=eaouD/XPTNXznTHHZuxGjodvuquz/wfXlZeLnCBB5Ow8+BnLCAlh4e4wgMWN4ZsfmL
         ZzdL2ZYlIKb4kkcW6xLR7Q5R0WbKDV3KnsbJ/gfH0D3xuGCaeFsOWnLWLY9D3XU+LUb1
         84o4qQKj0dVMSbCcawYcl/aNBpIEz6+DltnLaioim8gPDt6nO50coiUSaP6/P0v35NHe
         J3Vcpdp+qR5pCFvChQFd5lsYtu3kZ2q7rTkxMCQSr0a7qPt5WybZoZAOgsCVZjBjejIP
         lmoS679BtVzdJbjr8jvg0n/uXupZKncG0MZi3kKhRgCKWkCcFpBRhQeJ5l7lAS1c0kAi
         2fAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779976220; x=1780581020;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cQiBtfW273MEpqVw/bgib56fWooXdt01yOmehx1vkfY=;
        b=n6WjwVqNxI98Anqf2ctn/hsQ7jUgPviDH9vqjFKqZK9pDEqII62MZRdWLK8Rs7eAlp
         AeImzVV4fIYWKbAl1CwwVMkDB0mFuUmiUtkdk5F5qVOd9JaxEqovctVTir4xD2/vCDRi
         cOY/AvCsopBQSVj2Yg7fylkbS7+feh/yqVftKB1rfSANC/6b6uPGRgmn3wAgJhmbmO1T
         6FsHUyvFTyvuvd1P0vHVl1gaqjMMfuzXIMawO/83gmgQbatpS39Z+X++Z5XsHzSY3mDG
         hpPvFkoXWbDv1ReICXtoe/adOAXurtq18Lki2kfiG2jcgOwgB6GkPsBAz45lrGn027Sd
         Ithg==
X-Forwarded-Encrypted: i=1; AFNElJ+13m4y8hf0qizws+xcshWXKr/r0Gi0S1Dm+cWhzh+6+4shr5q4PXCYL/B/fw5tHOCBHhn4hm0Vo8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVTLJm/V/ioIRDIYtAWwL/dZmGW5xk8WRqre7eE37kvy8x3xi6
	NV7LxXxORR4O9ZyafE0w6UYG7G+7pMqYHVkgeOVijJyw2J5ixb9d5YvCbRzKOEMKNAU=
X-Gm-Gg: Acq92OFQKRZrFbb3B8KIJNOVDeXon2/U15HAwDfyvXTEiuVGOsFlrTmXzBH4K4ft4S+
	7+GqUOhPkDl6MrCOAm/QVlUqnqWCkRVOv6691gcd0bCQxj7UudvdXxvysxlpPdcDMD7bYtGSBSc
	VRuza1FuHfR1jVOb35AMUyCjDIj2+5H87ghSVu0dc+tjs0iAdUAsZoFD1an8/PqRh6l9V6z+r+q
	t2RJa5EyHXodGByE8KetDUFEiGIghj5yZ0wzMIS1hdn71P87m5u7+SV007dNooYDI75b7yDxy/7
	PQLm5yrQMqs/KPRFhrtprkf8PlxQpLOOqWl/0Hw+7W6BWVxjs5HXWyQChyxhNo5O5XGTBOEQvev
	+w0z7a+gdXdS70/U4Hyg2NBv03d6Qcj6HFy76JJ5e6ldmbFQdgSC8BzEM8Jje9amknAm+9O+otS
	fvgkf1bwPo0imvG6jcDgDwNDi0TOpR944GKV9VEouhPDLXkukWSRKT8Z6+Gu1T3OqCpC5EFPkN3
	EVLii3gh/7zYxpDEg1ziz2PtQ==
X-Received: by 2002:a05:600c:628f:b0:490:5057:f602 with SMTP id 5b1f17b1804b1-49050580d79mr399434335e9.17.1779976220123;
        Thu, 28 May 2026 06:50:20 -0700 (PDT)
Received: from localhost (p200300f65f47db04e567da92d09b3dda.dip0.t-ipconnect.de. [2003:f6:5f47:db04:e567:da92:d09b:3dda])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-45edb5b314dsm12839457f8f.30.2026.05.28.06.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 06:50:19 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: Frank Li <Frank.Li@kernel.org>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] dmaengine: cirrus: Drop left-over from platform probing
Date: Thu, 28 May 2026 15:50:10 +0200
Message-ID:  <c3830cb95b0bb939f9cc9543dfa3047e41532c47.1779976024.git.ukleinek@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1146; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=sCw7FtaG3QEoIeycoMDDazd6TFJyzO5RGri3sYmQgtU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqGEgV7i8UmCLBJ4CZZKgTAnoYovzNNb2Wnn1Xc RLgQQxDvwiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCahhIFQAKCRCPgPtYfRL+ TmprCACaEQTSIKwLw8woN4QWodOthDZZ0Z+A1oD274o2CryHkOVMEAs/szN+b/BrEQfQw/uMbX+ R6dy90KwLkIuwlT5QesptBIJIQoHuGUX6Do69e9CDadvIE+Un2EGiWYj2kXo+Cl0nyZY9qKSkyz nAgSVug0nsKGy2xAnHSYzRSqLEpDylCWwoQJLd6O8SaIcoIdHaZnbnBknbq//8a4xfYzE2pr6B2 30ttr4kUUxSkcv5Io5pukIQVV1RUHw+j04uxXflNK/5ECnCsIb43YHbM5KFvVZG1rHCDvx2S4Tz lDpniY2J5P45ro8bmmaVT5Dm/W+PAiBA+HjNXclWhjlvTX9P
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_RHS_MATCH_TO(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[baylibre.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11006-lists,dmaengine=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	DKIM_TRACE(0.00)[baylibre.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,baylibre.com:email,baylibre.com:dkim]
X-Rspamd-Queue-Id: 4ADF35F3075
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Since commit 2e7f55ce4302 ("dmaengine: cirrus: Convert to DT for Cirrus
EP93xx") the driver cannot probe devices using the traditional platform
device way any more. Thus the driver's .id_table serves no purpose any
more and can be dropped.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/dma/ep93xx_dma.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/dma/ep93xx_dma.c b/drivers/dma/ep93xx_dma.c
index 8eceb96d058c..a3395cfcf5dd 100644
--- a/drivers/dma/ep93xx_dma.c
+++ b/drivers/dma/ep93xx_dma.c
@@ -1587,18 +1587,11 @@ static const struct of_device_id ep93xx_dma_of_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, ep93xx_dma_of_ids);
 
-static const struct platform_device_id ep93xx_dma_driver_ids[] = {
-	{ "ep93xx-dma-m2p", 0 },
-	{ "ep93xx-dma-m2m", 1 },
-	{ },
-};
-
 static struct platform_driver ep93xx_dma_driver = {
 	.driver		= {
 		.name	= "ep93xx-dma",
 		.of_match_table = ep93xx_dma_of_ids,
 	},
-	.id_table	= ep93xx_dma_driver_ids,
 	.probe		= ep93xx_dma_probe,
 };
 

base-commit: e7d700e14934e68f86338c5610cf2ae76798b663
-- 
2.47.3


