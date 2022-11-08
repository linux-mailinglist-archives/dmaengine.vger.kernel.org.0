Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC40621B8E
	for <lists+dmaengine@lfdr.de>; Tue,  8 Nov 2022 19:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234370AbiKHSMH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 8 Nov 2022 13:12:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234281AbiKHSME (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 8 Nov 2022 13:12:04 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5316359851
        for <dmaengine@vger.kernel.org>; Tue,  8 Nov 2022 10:12:01 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id ay14-20020a05600c1e0e00b003cf6ab34b61so12256740wmb.2
        for <dmaengine@vger.kernel.org>; Tue, 08 Nov 2022 10:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A8Nn7FR+ibB53QJL8o9ZqwbAccpQC4pR0InqfudyfLs=;
        b=PBjnfDVmggCWMS+XYXPxAz5Am3hcRfWSxmYSECtzCK6iTX7uOwU6CzJYJDkLTML2+m
         Nv/WVSYdtAY0PKfDxZLJ/LXynJJafnY/stksKFozK4dbIM+iPhPoFwgJwG13aNwBBX3W
         wvsQ8fGLerysGOXIwc/Gzk2EiWgff6bEd6KWuBAHk0I2l27IkzR/5tsYnbstN66ETAjb
         HNZXvWvsbMoXfL1z+9BsFcMmvI7AERuBSoeDKZX7b/eGcXSfGiNxEF3UBU2T8Q/suGBr
         R6TPk5+ryEBj+RhpPICftHvxHnFt9ZzHi2D8pS2z3MQcI3Q5PlC3GjvHIARZZweq5lOx
         c+GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A8Nn7FR+ibB53QJL8o9ZqwbAccpQC4pR0InqfudyfLs=;
        b=TZXal1id1mcNrH3l0JApJ8lGMM4aULv2QCSWuCL9fx/Xs+AtDiE7WHwvqdDOEp0EIm
         pKqYghfUtHmKB05RMWw0mISYM844HEqMcEyYZkmhmmtLAw2aNgOuLg2qZyTtTfMbN5IR
         v3QvUnA5r3JAadY9B4rAI2zyAeP8XHKMOb65YT/kr2aFcAtTOQZDaZMs4SH4t1ulk3Xb
         B6Js6Uov81NandGmUK5LKmbq8QcP4mtDwr1u08YkofGA05XOg7qXhpszRLnP+Gbo8B6Z
         9StTvcnYERLX7r8yUzbuz6y73osY5VjK9gwvvYelCq7aRATPlLQ3QrDpbjNJ3LXEOsPE
         +cag==
X-Gm-Message-State: ANoB5pkqEwD23lWjTFfIllHSYuGzVy/8/0ljivt0TMI7yZA4EZXbd46c
        QW2wlH7eeyIr/mRN158EPZIe1A==
X-Google-Smtp-Source: AA0mqf5OYJs6Mea9M4/w5JBh0YgnFEs93kqHNrZKS3FhEDXrM473nHj+/uL++VfmlJWAiAn+kgB4jg==
X-Received: by 2002:a05:600c:2d44:b0:3cf:aae0:8367 with SMTP id a4-20020a05600c2d4400b003cfaae08367mr8518017wmg.132.1667931119895;
        Tue, 08 Nov 2022 10:11:59 -0800 (PST)
Received: from nicolas-Precision-3551.home ([2001:861:5180:dcc0:7d10:e9e8:fd9a:2f72])
        by smtp.gmail.com with ESMTPSA id q12-20020a5d61cc000000b002238ea5750csm13037109wrv.72.2022.11.08.10.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 10:11:59 -0800 (PST)
From:   Nicolas Frayer <nfrayer@baylibre.com>
To:     nm@ti.com, ssantosh@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, peter.ujfalusi@gmail.com,
        vkoul@kernel.org, dmaengine@vger.kernel.org,
        grygorii.strashko@ti.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, linux-omap@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     khilman@baylibre.com, glaroque@baylibre.com, nfrayer@baylibre.com
Subject: [PATCH v4 3/4] dmaengine: ti: k3-udma: Deferring probe when soc_device_match() returns NULL
Date:   Tue,  8 Nov 2022 19:11:43 +0100
Message-Id: <20221108181144.433087-4-nfrayer@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221108181144.433087-1-nfrayer@baylibre.com>
References: <20221108181144.433087-1-nfrayer@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

When the k3 socinfo driver is built as a module, there is a possibility
that it will probe after the k3 udma driver and the later returns -ENODEV.
By deferring the k3 udma probe we allow the k3 socinfo to probe and
register the soc_device_attribute structure needed by the k3 udma driver.

Signed-off-by: Nicolas Frayer <nfrayer@baylibre.com>
---
 drivers/dma/ti/k3-udma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 7b5081989b3d..a6bb5077900b 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -5285,7 +5285,7 @@ static int udma_probe(struct platform_device *pdev)
 	soc = soc_device_match(k3_soc_devices);
 	if (!soc) {
 		dev_err(dev, "No compatible SoC found\n");
-		return -ENODEV;
+		return -EPROBE_DEFER;
 	}
 	ud->soc_data = soc->data;
 
-- 
2.25.1

