Return-Path: <dmaengine+bounces-7933-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 451EACDA8DB
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 21:43:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 460703009F2F
	for <lists+dmaengine@lfdr.de>; Tue, 23 Dec 2025 20:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24C730F803;
	Tue, 23 Dec 2025 20:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N3Gz0D31"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBB62EA749
	for <dmaengine@vger.kernel.org>; Tue, 23 Dec 2025 20:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766522584; cv=none; b=QCjokBQ0jAENYp1DwO5nGDtxoHECC4L0bKRcUeRxIouT51jwuiwMRC1Ot20tEKkPdAEDswpfs1T9N6Wht3OrbvqhMCQ3OMt5BmXD2NRPzDTT6E918RBw1kJKbGyKcfFIvXLWEQUhzalDid+GzSCOAFXDTgiHsVthznrmnXk2TmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766522584; c=relaxed/simple;
	bh=dVPhSupKjkNxYTT4xpPhhp81sYshESJdrI9dqnFc014=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HsSY1RtgRw/l15sWoRYvIRFkT8OEXzkU6eKC3QkXmAHmXIErNbumYZD7i0g30UUSLmC77HqlSazSKpI4ipaKmrWnleL8CfP8IMpVgmfYgAaOL8rdp8kieOSIwljKKOdebmVwPVPWES1QNMsVaNH0pZjIFMtr+/gLlzKKywocMHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N3Gz0D31; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-34be2be4b7cso3552668a91.3
        for <dmaengine@vger.kernel.org>; Tue, 23 Dec 2025 12:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766522581; x=1767127381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1skd3xL+sZ59w+5Tt0e9sUWzqt/UFsyMduMqakn5wi4=;
        b=N3Gz0D31AAU6ro6MT7Sk0B4+enHwziWIGVH6YQb42azaj3j3LBp15Hj3lmtrzPyARM
         I0nOzqzErdMb5Or5QD2WF7+ZgVgAQaHvygmzyyKnQbtCJj1Wpu/ArY7VvTzZFYYRgJrb
         Qr4Br2axwfpuCOHEkr38TcedSHeWm+a9VqVdDwT/a381mQ6fhubHzgFSbWEL+1uszD9x
         vr3l5tqaf0LypSSy875rnudBNNhexHw58o4J/M7pppKJQSsLVuLm85QjMCE+PRVzs1VD
         wduNYh2WOW5nlpkBIi0IkBzfkIDDi/E1yJaaU+JmS/t2LcjnZQNqTrPbiWSIhdwseEoH
         892g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766522581; x=1767127381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1skd3xL+sZ59w+5Tt0e9sUWzqt/UFsyMduMqakn5wi4=;
        b=CXaXdC/EbkW984ZZYlGjLNCQ7lDiB5dEsNWRLuVufW9fpsa9ok8ogqRmgsq8N9ftNs
         ZD0rI66PpBGzAgastdZmUfMicmQj5WGZRB0oeT8P7G80rLAKmjfnKBw8tUk4UbizRkQL
         FzY8ep18HNbHJGt822/zbMtgGpcMIUHldmuEgm9NQxYl0WMsGl65ziha52jAwLMA2ZoG
         FKXfdxnB+EF4BCtKOCQvNXBEW8X4rf8WUnjxEw3YIb1iUL3aPWRDo8FWIL9xjD8jF9Ot
         Zigk4Pzpq7weU04oosm9ULbalXOhIL2rE3sL6XjlXlKWaVuZsn80HvoVleZFOc2HgU2j
         cYFA==
X-Gm-Message-State: AOJu0YxKVhReExxrEjrBFypqr1NtsNy3wDpFygsXFZVx/FrmuhSBqtru
	Tn7GL+96FNc3pGIWD4pUVawSAFn5DgTxZjIxyD5Sjl2hHvd6mEU+vCzSIOvHKQ==
X-Gm-Gg: AY/fxX4nMexVUH5aHY7GvP7kIv8nNlSfLgTPnAsEl7A9bUNOEcVtbGSfpmeBPKsBLIM
	3HvYyaW11sDnUWe1qPWbx/DYK0bwClQUS0iGIzxSLhyaD+wliQJVZ4krDZ6ttoQxUelAk5250Y6
	jdsMfK5x+70+d9UMBEThOgEKos8Afj1luIQJg9+EizjkCSQJMpeiHC6P3BR57HeXY8g6E50F6xu
	UbnpiUY7x4st4IfwJVZjJV5WqtxTyjtTc3Fulvu+67/qVRcteqPZLLKioippRC9cQO1YY8UDV3k
	PmEQTkGNEK+y+gGQxPNRtT4Y8zf9KjlX5hJzKHlfjNP2nKrz0haE3fuD4y00tEXJbLxCKdZe1gI
	Ijdjfu7ffV4ST5f3zNEgogHol31A5HxuexmYyrn3NpHs8fxN1twEss6B30w==
X-Google-Smtp-Source: AGHT+IGMQDSi2ZlhEGbkrnswZLpBeB3IntHFJSFQ1YG0eY3xXfHJGFZXfsVzOiSVxxWF80SQqc05ng==
X-Received: by 2002:a17:90b:5610:b0:34c:7182:cf9d with SMTP id 98e67ed59e1d1-34e921c7373mr12211478a91.25.1766522581140;
        Tue, 23 Dec 2025 12:43:01 -0800 (PST)
Received: from ryzen ([2601:644:8000:8e26::ea0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34e922278a4sm13931871a91.11.2025.12.23.12.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 12:43:00 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv5 1/2] dmaengine: mv_xor: use devm_platform_ioremap_resource
Date: Tue, 23 Dec 2025 12:42:41 -0800
Message-ID: <20251223204242.3415-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251223204242.3415-1-rosenp@gmail.com>
References: <20251223204242.3415-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplifies probe slightly by removing explicit struct resource pointers
and platform_get_resource calls.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/mv_xor.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index 5e8386296046..3597ad8d1220 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -1309,7 +1309,6 @@ static int mv_xor_probe(struct platform_device *pdev)
 	const struct mbus_dram_target_info *dram;
 	struct mv_xor_device *xordev;
 	struct mv_xor_platform_data *pdata = dev_get_platdata(&pdev->dev);
-	struct resource *res;
 	unsigned int max_engines, max_channels;
 	int i, ret;
 
@@ -1319,23 +1318,13 @@ static int mv_xor_probe(struct platform_device *pdev)
 	if (!xordev)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -ENODEV;
+	xordev->xor_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(xordev->xor_base))
+		return PTR_ERR(xordev->xor_base);
 
-	xordev->xor_base = devm_ioremap(&pdev->dev, res->start,
-					resource_size(res));
-	if (!xordev->xor_base)
-		return -EBUSY;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-	if (!res)
-		return -ENODEV;
-
-	xordev->xor_high_base = devm_ioremap(&pdev->dev, res->start,
-					     resource_size(res));
-	if (!xordev->xor_high_base)
-		return -EBUSY;
+	xordev->xor_high_base = devm_platform_ioremap_resource(pdev, 1);
+	if (IS_ERR(xordev->xor_high_base))
+		return PTR_ERR(xordev->xor_high_base);
 
 	platform_set_drvdata(pdev, xordev);
 
-- 
2.52.0


