Return-Path: <dmaengine+bounces-5746-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6242CAFAE8F
	for <lists+dmaengine@lfdr.de>; Mon,  7 Jul 2025 10:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6FB23B9BD2
	for <lists+dmaengine@lfdr.de>; Mon,  7 Jul 2025 08:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831FA2853E0;
	Mon,  7 Jul 2025 08:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bLs3RSW3"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFF33597A;
	Mon,  7 Jul 2025 08:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751876697; cv=none; b=jWHDwHNAATAi6Iw9+p2nLFh8pkKOBIam+Sz94zOWkqBCLoyk0KWOaK9JIRudzYqCaW852a04LSJzHNXkexFpkwsIJNmbcuvNEat5rn5xmJnn7FLprMJO5SSnc+Obot2/0Tbmb/38WdbYcVzY1sYAwQ8Pf56HWwhWAg8z+ms8sk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751876697; c=relaxed/simple;
	bh=S5Ika/MUmQioSyrdtHySzBnBTfVpwXCnBKujrhp31t4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cKnRlvj3yvlcFSeltmedPcgcb7zJACV7sdhfb5LJw2yhwTV0AzRxJu4kyOgEyU7T+e5W0wGYZD60BHtzFi1U9vlg2DV5LRqkiLT5+m12cJSFpecw2t+49lcXuwh4TLR691GB4TONdAiHAW8SzTo+lgdBFcGwA+mjwY7qQeWF6lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bLs3RSW3; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-454b9185d93so523815e9.2;
        Mon, 07 Jul 2025 01:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751876694; x=1752481494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mwMOzoroQSnOfARQkHiBV9YHAp34sReMbRyY/c+joRc=;
        b=bLs3RSW36alZ2IdhcedII4vZ1pfCSOA+2xEnBCaVntBhBcFpmnEb2ajFeavo7nxdYS
         WO+b5qZ4ZEJbPoo8CF0FcO19mYZq1RhEmSQsrfYlYaI3ZEnVJJe+/FNQJ4W+KyDcduMf
         iOJONXYcyh45tDKowayUjPc2UBJKaY9yHaiduPAFu74kKe0OoVVFdUZgmIiLNxfxM93x
         oPo8PyIAH14Hbz89vndF1iBhXbKqjotdlUuLsL27IRjMnhIN+xNCrmM42/YamaV0ckO7
         /1+F+AAx6QLyyK1zY461fejgJKbGpv8RvVFXKT3LPqUysTXvwU3Jb8/I3TnAmeJfj0dZ
         JVcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751876694; x=1752481494;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mwMOzoroQSnOfARQkHiBV9YHAp34sReMbRyY/c+joRc=;
        b=d1ixWQnQGqXczUzDjmieb6FI6FpR0sR2swzkrEmEutSzlJ1/zNAEXdtz5fED2qHOSF
         7HowQ0Ry2oG2e1vc/eN8r3c8yplG14Y+f/8of26xeYy2xH6qP1TwDYHsikivxtILMWut
         x6hHyeI9DfRYOHyNqeGmAzBIwlzNUeIzV8IpNa9eU6Xyn+/2aDpOjNnHrKedzDJkst3O
         qpLw4vIRB+V5SiBj8yIT9gAULFH1bKQpUrLlsyd7ua0RPHsDe8jAMYRCH87LNSSmOf+r
         A1HkbYVe0OR1JWgZecGWo9VMXcwHYaEaR4qWP130yKhGAox9wjf7unp+kszhIUM15A45
         E+6A==
X-Forwarded-Encrypted: i=1; AJvYcCU5yZsaxC1c4m4oIXkLqLXCLth29g2rxHKGW5CSsjPSjO1JfMg32xQStjlT69WzeDg0jGuDDk/vPVc=@vger.kernel.org, AJvYcCVwa9o3HWziQJlLkwc5TXfCkeLQgKdm62JlSwySamo49ugAzYalgRMe7aF5Xvr+/LdV++AvMUsLk0IVrLlw@vger.kernel.org
X-Gm-Message-State: AOJu0YzCWypaNnX1dl5Zny1oP/M8WknmuFhBlT0sS/clP3AO+252CceZ
	YVRTrYfDW2zME0f2CiBWcjBCvfgXIO9BURENx/ZnO32rDmV7bWg9/cxd
X-Gm-Gg: ASbGnctrYTw0n8jA3UJa6XOypQJxF9ao2U2GuyQITPfRnp6b0aQ/Rfry6+ZH+PVn2IR
	9fcZf+Wic1tEsdyexXUWLGlSYdISRFU5xhDNJCs/Dps+bLe/7K5W5EmRC+/GcfvSVXBhilreD0S
	wR+fvTYC9Z6rbuoUGr2BfGmQgxNj7FFQa3mlD6AJV7bhOd0Q34t7PKFjblYN3ghil9r0Qp63S/+
	t4wifR7Zm/Haq9dkSOcCS769l9A5EJPjb3YVewxkBOWFB5zLwtXgsNtRfMFsb2IuxEhpqhV3dzh
	nBYAzJ4ZRFi3tm06DOgY/akCq5F6z5B+Y7jOd+q8/cy78SEZbujj5ArmfHZY5u3GeOONQe8UZsN
	Hb1mzl8ygD+jPpSNtZL0uqLVRHg==
X-Google-Smtp-Source: AGHT+IEbDLJcy5ZqREwJbM42EHIycM8Ein3uRHCtPk37fpEjgqrXkBj7yigo7bzmd5qhw57OmEHqhQ==
X-Received: by 2002:a05:600c:1990:b0:453:59b5:25cc with SMTP id 5b1f17b1804b1-454b383241dmr37095825e9.7.1751876693628;
        Mon, 07 Jul 2025 01:24:53 -0700 (PDT)
Received: from thomas-precision3591.imag.fr ([2001:660:5301:24:ef01:c9dd:1349:ddcf])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-453b35309casm113055385e9.1.2025.07.07.01.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 01:24:53 -0700 (PDT)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: nbpfaxi: Fix possible array access out of bounds of nbpf->chan
Date: Mon,  7 Jul 2025 10:23:52 +0200
Message-ID: <20250707082353.40402-2-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The nbpf is alloc'd at line 1324 with a size of num_channels so it seems
like the maximum index of nbpf->chan should be num_channels - 1.

Fixes: b45b262cefd5 ("dmaengine: add a driver for AMBA AXI NBPF DMAC IP cores")
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
 drivers/dma/nbpfaxi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/nbpfaxi.c b/drivers/dma/nbpfaxi.c
index 0b75bb122898..dd1b5e2a603c 100644
--- a/drivers/dma/nbpfaxi.c
+++ b/drivers/dma/nbpfaxi.c
@@ -1364,7 +1364,7 @@ static int nbpf_probe(struct platform_device *pdev)
 	if (irqs == 1) {
 		eirq = irqbuf[0];
 
-		for (i = 0; i <= num_channels; i++)
+		for (i = 0; i < num_channels; i++)
 			nbpf->chan[i].irq = irqbuf[0];
 	} else {
 		eirq = platform_get_irq_byname(pdev, "error");
@@ -1374,7 +1374,7 @@ static int nbpf_probe(struct platform_device *pdev)
 		if (irqs == num_channels + 1) {
 			struct nbpf_channel *chan;
 
-			for (i = 0, chan = nbpf->chan; i <= num_channels;
+			for (i = 0, chan = nbpf->chan; i < num_channels;
 			     i++, chan++) {
 				/* Skip the error IRQ */
 				if (irqbuf[i] == eirq)
@@ -1391,7 +1391,7 @@ static int nbpf_probe(struct platform_device *pdev)
 			else
 				irq = irqbuf[0];
 
-			for (i = 0; i <= num_channels; i++)
+			for (i = 0; i < num_channels; i++)
 				nbpf->chan[i].irq = irq;
 		}
 	}
-- 
2.43.0


