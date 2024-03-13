Return-Path: <dmaengine+bounces-1361-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3F787A91D
	for <lists+dmaengine@lfdr.de>; Wed, 13 Mar 2024 15:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B327F1C2292C
	for <lists+dmaengine@lfdr.de>; Wed, 13 Mar 2024 14:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8614C60B;
	Wed, 13 Mar 2024 14:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ObjMiWsP"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF8A482D3
	for <dmaengine@vger.kernel.org>; Wed, 13 Mar 2024 14:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710338939; cv=none; b=pPLkKIqRevjmG2bhqjohSFiEN3Czxc3VbEnfEiv68fiSQvjLkVLuGb+AS+SdmqNj0qEz44Lj6eyboT29kNZH1QY/Nm0Wr/5fQKoTskLvkEOwj+1hKj6jETLIwhk7JPMDXMIOxZweE1Q0jW8XyGjiq1LUN9Rww8HD46XHoFGcSps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710338939; c=relaxed/simple;
	bh=xti/oKwQScDc9qv8BINO2ll3pJ6JN65BhusLnK1Mk28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DSpM0RiTZP/gM4PV1FWn1+nmznd6uobAyBakN6CCVSb60JGCy/Q8OVO6pb2BBjec/iQxF7NTzI30qnUHy7NBYmVK+m+HgxmT5mZLUuEesqurJ1Y+ipOGg/rLgnRRSv1vnYycXdHtLHhvbUpEOsUmGUuNcKFKNg2xWE9MF5YbDIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ObjMiWsP; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a46644fee93so59343366b.2
        for <dmaengine@vger.kernel.org>; Wed, 13 Mar 2024 07:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1710338936; x=1710943736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sxhFutbq+Y+6CXRWNL6/WkO0dcfzVUrgph3wJP5gbgo=;
        b=ObjMiWsPaucYxmbdOMzrpFDWzzoqeFdz1nl8qMn0KCwwZ8AFyg6ncUmYmzNV1IUnoA
         YnO9ni+W1BdgbXVTSW2XUBGrUMAqwj8SnY3ta2IgEBtPfgP8JHrbuK2uMiNj/yXBLNwA
         GgtMPVtzrHL/2kLsMYXwdUeKddxxqjkwVvbWap5zeZv3I4IwBjXUQ+Qr0QizrbD/YiJO
         jtZMomOESuwR/ZYrUG+IJdALR+t8DkV9ezds3j6MlCtjkmwPvls3o0QAWsfXoju3VZNi
         SsTl6upO+BVLAKsxmmGEGSXs5h5ln47zNqnZIOwnKqAL/aDO6zoSzuKiwYYJKwuU0LHG
         xsrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710338936; x=1710943736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sxhFutbq+Y+6CXRWNL6/WkO0dcfzVUrgph3wJP5gbgo=;
        b=Yn2c5FgHM4pTm1VRLD9tPkw//LgBKexnuZdEwlPmIzaf/PCudcVRgKqPEfG9WHMbNR
         BEOI81KNfVLY+l3N6RtznNT1fhAXLl6klV9Zh79Bhw5E1h0LzOQ6wsyhwH08f8Z1STdV
         p+Rsbxg7K2FgA2SH+M4zh9BGUHQQaBovxhiZDHmGnshaQqJ8/XPHDz6E29rE0wTGxB92
         2/pSUwWoBMAg2/gOXEeLOWx6ofGr8nolEGCaC3k/xAJ3yd6v3k1hQoTLwq6X3pg/JnuP
         0UfcOPyAupLR3E/xE8QAPeLOrcMZf2Yqp3q+Yppt8T1BWH8WOzLMNZioEbQXExjMfniU
         wr5Q==
X-Forwarded-Encrypted: i=1; AJvYcCW3lQLOiCit1HxfVQsriZOeYbPwD5fdAkj0m5yejBi9r1a7/gMe5Iik6ubxHh8shBD5GNCxNHvgdhmRu+DTLvvblt/5L2f5mIyE
X-Gm-Message-State: AOJu0YzmbHVHmCrbRsoQJ4h2736FKRDc0cIwjE52Gn4ZDMaUr/g2w2ml
	iquRfAeJj+n7PTQK+9uSvGCAEJ46QHKqaGoO6G7v8tOlVJcSDXEkG/HRe9OKPVM=
X-Google-Smtp-Source: AGHT+IHGhXmShKjT2bgraHVp5n3iw9VUmNLl0npsFuV9YOWwmAyXpR7Lt4bTH+kxGpjAq2xtbLLcbw==
X-Received: by 2002:a17:906:55cf:b0:a46:5fd2:f26a with SMTP id z15-20020a17090655cf00b00a465fd2f26amr1116133ejp.65.1710338935915;
        Wed, 13 Mar 2024 07:08:55 -0700 (PDT)
Received: from localhost (host-82-56-173-172.retail.telecomitalia.it. [82.56.173.172])
        by smtp.gmail.com with ESMTPSA id ku2-20020a170907788200b00a44936527b5sm4907081ejc.99.2024.03.13.07.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 07:08:55 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
To: Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Saenz Julienne <nsaenz@kernel.org>,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	dave.stevenson@raspberrypi.com
Cc: Phil Elwell <phil@raspberrypi.org>,
	Maxime Ripard <maxime@cerno.tech>,
	Stefan Wahren <stefan.wahren@i2se.com>,
	Dom Cobley <popcornmix@gmail.com>,
	Andrea della Porta <andrea.porta@suse.com>
Subject: [PATCH v2 06/15] dmaengine: bcm2835: Support common dma-channel-mask
Date: Wed, 13 Mar 2024 15:08:31 +0100
Message-ID: <33415530388855ba8964c1f32dd126cb173e191d.1710226514.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1710226514.git.andrea.porta@suse.com>
References: <cover.1710226514.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Nowadays there is a generic property for dma-channel-mask in the DMA
controller binding. So prefer this one instead of the old vendor specific
one. Print a warning in case the old one is used. Btw use the result of
of_property_read_u32() as return code in error case.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 drivers/dma/bcm2835-dma.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/bcm2835-dma.c b/drivers/dma/bcm2835-dma.c
index 6b8e7461efaf..88aaf7769864 100644
--- a/drivers/dma/bcm2835-dma.c
+++ b/drivers/dma/bcm2835-dma.c
@@ -986,12 +986,19 @@ static int bcm2835_dma_probe(struct platform_device *pdev)
 	}
 
 	/* Request DMA channel mask from device tree */
-	if (of_property_read_u32(pdev->dev.of_node,
-				 "brcm,dma-channel-mask",
-				 &chans_available)) {
-		dev_err(&pdev->dev, "Failed to get channel mask\n");
-		rc = -EINVAL;
-		goto err_no_dma;
+	rc = of_property_read_u32(pdev->dev.of_node, "dma-channel-mask",
+				  &chans_available);
+
+	if (rc) {
+		/* Try deprecated property */
+		if (of_property_read_u32(pdev->dev.of_node,
+					 "brcm,dma-channel-mask",
+					 &chans_available)) {
+			dev_err(&pdev->dev, "Failed to get channel mask\n");
+			goto err_no_dma;
+		}
+
+		dev_warn(&pdev->dev, "Please update DT blob\n");
 	}
 
 	/* get irqs for each channel that we support */
-- 
2.35.3


