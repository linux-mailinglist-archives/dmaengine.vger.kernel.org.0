Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D5660364F
	for <lists+dmaengine@lfdr.de>; Wed, 19 Oct 2022 01:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbiJRXEJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Oct 2022 19:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiJRXEC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 18 Oct 2022 19:04:02 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAECABD058
        for <dmaengine@vger.kernel.org>; Tue, 18 Oct 2022 16:03:58 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id a18so9719151qko.0
        for <dmaengine@vger.kernel.org>; Tue, 18 Oct 2022 16:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rDE2/66UDa0hDLDqGdcC3HGG8N6jl6s2qDtARs18Pls=;
        b=yXgA+qYbSAVhoX3vmAKigDAkRu2K24kIHV9Q3YO/fSgj7Dfow/WN4Vq0mpghp9/cF0
         zeTrol5i50aU49KgS+3toEMFfReqARWJx5Dm6eMAqhTYgxnwzfGujFd8AH26MqPbKxBz
         p9K/S+E0rNkFyhW4EadPxbyN6vVw5FnImBQay9Wo15XyDYPlU949LJ52rIemjxMoww0v
         dtarmNaaf0IZE3qBkqgMwAei49Z0ZLnaLpVJbHSbggYMI+JJlOEPObwqd7Syb2DpfOxy
         r56qOpkjFGAS6c90LZUf1LxVW0Z6SzzVnBTXmpCEn0zD50/pOKzLt4LCC/y6jJry64i0
         jRNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rDE2/66UDa0hDLDqGdcC3HGG8N6jl6s2qDtARs18Pls=;
        b=yc5TjnC32ER90J2c/ubcv0rw6Y6VZviDY14zKCpWVV+t7qBKPHdkw0gzfkaXjRQZqr
         Dd9pJ9qm9ML/iM/2fzp7kaDgC/aVT7uoYfqCTis1wPRJeaXV42ywgZo2ZmAt6vLptLoO
         8+KoXgKdzhPlRunp3em/3dXxZjjSkB7251Gi/B9T1UYu1R7EfyX8KPGhFMe5i+kM27k6
         ECWFn3n7AzzsjYN0As5Wd5vlAIo9vuhkWkEfRi0UKjO1pMCMu/4Tq4DfUFQKIB6RzkXZ
         7+TzMh4hRFURj3MOwRtD8CmHhIvpdnK9oMw+Jg3vFY6Q2f0sAn+EwNUJ7QgPhgKcwA/C
         22EQ==
X-Gm-Message-State: ACrzQf04vw0AwzPK9lMW8DLGyg4NGqRJmnMOHWpzBJPSwRGEf7adC3qA
        S5MTbXhWr9jncfrjvikZi4PC8g==
X-Google-Smtp-Source: AMsMyM7cVGVccXv1BO6ML81Bf1aWBaWaYXay5h0optGTArAokntZrhqF1SXoF01onu/mGa/hmyLO+A==
X-Received: by 2002:a05:620a:2b85:b0:6ee:cc4a:de6 with SMTP id dz5-20020a05620a2b8500b006eecc4a0de6mr3536822qkb.458.1666134237725;
        Tue, 18 Oct 2022 16:03:57 -0700 (PDT)
Received: from krzk-bin.MSRM (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id 134-20020a370a8c000000b006cbcdc6efedsm3279010qkk.41.2022.10.18.16.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 16:03:57 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Richard Acayan <mailingradian@gmail.com>
Subject: [PATCH v2 2/5] dmaengine: qcom: gpi: Document preferred SM6350 binding
Date:   Tue, 18 Oct 2022 19:03:49 -0400
Message-Id: <20221018230352.1238479-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221018230352.1238479-1-krzysztof.kozlowski@linaro.org>
References: <20221018230352.1238479-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Devices with ee offset of 0x10000 should rather bind with SM6350
compatible, so the list will not unnecessarily grow for compatible
devices.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Richard Acayan <mailingradian@gmail.com>
---
 drivers/dma/qcom/gpi.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
index f8e19e6e6117..061add832295 100644
--- a/drivers/dma/qcom/gpi.c
+++ b/drivers/dma/qcom/gpi.c
@@ -2286,13 +2286,14 @@ static int gpi_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id gpi_of_match[] = {
-	{ .compatible = "qcom,sc7280-gpi-dma", .data = (void *)0x10000 },
 	{ .compatible = "qcom,sdm845-gpi-dma", .data = (void *)0x0 },
 	{ .compatible = "qcom,sm6350-gpi-dma", .data = (void *)0x10000 },
 	/*
-	 * Deprecated, devices with ee_offset = 0 should use sdm845-gpi-dma as
-	 * fallback and not need their own entries here.
+	 * Do not grow the list for compatible devices. Instead use
+	 * qcom,sdm845-gpi-dma (for ee_offset = 0x0) or qcom,sm6350-gpi-dma
+	 * (for ee_offset = 0x10000).
 	 */
+	{ .compatible = "qcom,sc7280-gpi-dma", .data = (void *)0x10000 },
 	{ .compatible = "qcom,sm8150-gpi-dma", .data = (void *)0x0 },
 	{ .compatible = "qcom,sm8250-gpi-dma", .data = (void *)0x0 },
 	{ .compatible = "qcom,sm8350-gpi-dma", .data = (void *)0x10000 },
-- 
2.34.1

