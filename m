Return-Path: <dmaengine+bounces-4791-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2074A748CA
	for <lists+dmaengine@lfdr.de>; Fri, 28 Mar 2025 11:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52F0F17C208
	for <lists+dmaengine@lfdr.de>; Fri, 28 Mar 2025 10:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D0F1E833C;
	Fri, 28 Mar 2025 10:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ClilAa7J"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF55212FAB
	for <dmaengine@vger.kernel.org>; Fri, 28 Mar 2025 10:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743159430; cv=none; b=kxB7z8AhM8/mNRT6OZcPh5bSVywfa5cQcSaU8AWmYjT81AD+JBEkeRjJBFytpSRuZVD8LwK3guHhPlxyVJkB+5vUOW04A6Zh3JxYZV3JcGVfRbhrRq8+BpAUqJZ1qngsm7zwSiTp8iBnefGUDM56pE+6Matx1ee/z5KiZlXYD54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743159430; c=relaxed/simple;
	bh=0C/kW5A9PtIImTbaSmS10vauXIXNt6b9M1a6rUMrsCQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aFRVgjqU7qodxdxcAiVP+HBc6E0F091NotD1ggjJ3qs5dedbjY5wFbwDoxRpjprhCiWA58GaxZ/hxO0pSpwdrBkxaWz619djP2WXLlxmMtrK86PqNdx8lq+v0YP0iE31Vsk7KCI3jD5S0HVOBJj7NQjzNS9q3KaIQG6a1W1K0aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ClilAa7J; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-54993c68ba0so2109264e87.2
        for <dmaengine@vger.kernel.org>; Fri, 28 Mar 2025 03:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743159426; x=1743764226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AA2iifuZLLKE6Um4OIk38K43eNvXX7huxRWiSxa/7cw=;
        b=ClilAa7JxKxxFT5hhnPXUpJ7Cnjh4wOYFqVQG6ez57Ax69DOgLOT07AkSoN2o6Q9aQ
         StX1qeixmj7bqMmsnIDpCyT/JfFJxLTZ2A9vhxZ+jcy4nnGqtJVv7SAJQ3MsOguZDQt+
         /DoxORxIzSx6EUrX32f0beeRSco2cWayKEt9j7Obqmdstlzres/10ywhj/7a6fIdi3ym
         oVl2eQKS5o5hBS0d9v9fkZ/zlzQUJdH1co9WI4nPz9XFN8hBjPIlVZHAIj5Zg3Br67p5
         tgN+O2L+TbY3xqSeIOEgAjsu+lOF5EP0vu4QjQS9O+LqqGgEp0cZo/REEFUrMJWPQeD1
         hNqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743159426; x=1743764226;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AA2iifuZLLKE6Um4OIk38K43eNvXX7huxRWiSxa/7cw=;
        b=Dwoc3Oh87Tv6tDB5cQAl/hhFXxIGN1moUQ3jZWheXD+H0CGG5KdUeDYXt1dB2LJCoc
         YRHNJoU7d6fXtDxVD0ricRlEej/8fkjVCYBGSknkpkiifuCd7CM3vNN9+0vWeZSwIU39
         XVd9qU4o6Jsm6Ncul7+7a1lcYEsnwPcI51blmTuqA9sJMJsBqcvvXTtCgQDEguGyWDo6
         SHeTxD7YOGLq2dKC7/ZxS3yF7S7ra288wlYIC/hIeSVdCXglqAZyFse0urBwq4mpKCUt
         KKda16Wj/TgEmPFjwVgPP3+vzjeCGU36VXwuv32MFv5IBug/LrjmZ8mbc8em9+pHK/Zg
         Y0xg==
X-Forwarded-Encrypted: i=1; AJvYcCU8Qifl939Z4K/UMT196eW1+e68Gh3WRBuA6WcKYBqGIBF+jKzgY4tBIwLNjtOAXjRNxPd57gC8pTU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw98evkn29LIjXr0ef/9UzT1eYX3XjB3ErOM5tJO6yEmyj0jhrB
	1hzsf0LANoHncHIMSi3gRpK94GthvVFnBWLHLrn2u1rXgjzvV85f
X-Gm-Gg: ASbGncu2dTgQqifAgePWOe3KagRDplzEOouQu9ryhBBFGv+o7MAtwHCoXBmB85G5wHt
	PO64JEXcOIfTJPEXVbF7he36sB4bmJMdZ6pr7CMm7Iv17BOQvJAqk03e6sz88X9xvSrZ3BDoTu2
	ethUT8dognenAlqiea274GxNqXdglv4TKDqd9aRowjLc61HZzA5N4SYJiN8+dOocoLHCVSLkgFi
	Dcp5snMq5dj9W7wxA38qW+iMd4miFDzypQ6FBRis3X/UI7h1zscFNpgG1+7Ryye7n2ekeRfUWjy
	xLSFP3OMC+Z6RZFZIxTjVruPP1LahQdmSnNUAyM4FRrLUy7TreWQ3+SCSIWjlzZWRzZ+NmtD94h
	ONg==
X-Google-Smtp-Source: AGHT+IFWW/u8xH2nZ4zWp5g5cik5QWlDJZGM2o+7SInp+46pZ5yqn9v7XWiYq8ype7pBtrFZ2L04gQ==
X-Received: by 2002:a05:6512:2508:b0:54b:e49:6274 with SMTP id 2adb3069b0e04-54b0e4964ebmr126267e87.1.1743159426305;
        Fri, 28 Mar 2025 03:57:06 -0700 (PDT)
Received: from localhost.localdomain ([188.243.23.53])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54b09580006sm264257e87.130.2025.03.28.03.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 03:57:04 -0700 (PDT)
From: Alexander Shiyan <eagle.alexander923@gmail.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>,
	Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org,
	Alexander Shiyan <eagle.alexander923@gmail.com>
Subject: [PATCH] dmaengine: at_xdmac: Fixed printk format specifier when printing driver information.
Date: Fri, 28 Mar 2025 13:56:54 +0300
Message-Id: <20250328105654.143676-1-eagle.alexander923@gmail.com>
X-Mailer: git-send-email 2.39.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the correct printk specifier to print the address, otherwise
you get weird information:
at_xdmac f0010000.dma-controller: 16 channels, mapped at 0x(ptrval)
at_xdmac f0004000.dma-controller: 16 channels, mapped at 0x(ptrval)

After the change, the information looks much more informative:
at_xdmac f0010000.dma-controller: 16 channels, mapped at 0xc8892000
at_xdmac f0004000.dma-controller: 16 channels, mapped at 0xc8894000

Signed-off-by: Alexander Shiyan <eagle.alexander923@gmail.com>
---
 drivers/dma/at_xdmac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index ba25c23164e7..a4188046804d 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -2409,7 +2409,7 @@ static int at_xdmac_probe(struct platform_device *pdev)
 		goto err_dma_unregister;
 	}
 
-	dev_info(&pdev->dev, "%d channels, mapped at 0x%p\n",
+	dev_info(&pdev->dev, "%d channels, mapped at 0x%px\n",
 		 nr_channels, atxdmac->regs);
 
 	at_xdmac_axi_config(pdev);
-- 
2.39.1


