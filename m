Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42145E71A2
	for <lists+dmaengine@lfdr.de>; Fri, 23 Sep 2022 03:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbiIWBzA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 22 Sep 2022 21:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbiIWBy7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 22 Sep 2022 21:54:59 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05F941980;
        Thu, 22 Sep 2022 18:54:58 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id q83so9258406iod.7;
        Thu, 22 Sep 2022 18:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=mW8s+qE2+PwiW8Hix8DWVqRMl3AzSFEjSxAF23tGUY8=;
        b=TjFHpFqES2r2mVynq7XsYrt3agVUBuifUpdkQfonrme9LHyEUBPt34KrIN5axEbbMJ
         RMIg+F5kk7Ikr367Ei/nDUa1RjAvTklRUj2Ife8nzPqVHXU4DBR8PAgJ3/u7uW2NUm0O
         CRHPKnvBjuemZGo2CMuPvnITg9yiUTTvHNhouhZexi1vcZ7OGUllRLtLB8qPJ1WSgdcU
         J52wNNh/wd7hmuBqU6A+Y8xEv3Y+dvRHWsueUDNKXZxUQw3ys3sVbqkprNntT0FrzVx8
         czSt6RqfiX24xp0uuV+mQOYNfPtI4tMVDANC+26BA7da3sYS5eO2BYpxFBGD5ePC+F26
         Gd6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=mW8s+qE2+PwiW8Hix8DWVqRMl3AzSFEjSxAF23tGUY8=;
        b=I1ViYas4+7ckDEwqo4gJ6Cihw0uesDb6rBECm4wb2gXES6fr3qIGFm3WvtTEUjzMW+
         I78S8A5Qiy07cuE0zB1xiPpTsjRC+SD4mzLhkSf44F8KjV5tA8Y+iruC5ZCHGHpNiAOu
         Re8nyXnpOhEwlH/O/gBDSmwMU4SMJmwicg65nlF5k1jOYW3kXHxlhpvmWQo0FHZTHxAB
         SOy0eZmAuVHB/sVEDlflqyrP4Cz0HkTqI3hR+GrlTaCXqvunZ8to4O4QGvFvnf17I5ms
         A8Sma+JO/L+Gp+MGkNH86FvjbHascl4RwNBoilGODP3uyJhqJidoA1i0cI/0XhSD0uMF
         49/w==
X-Gm-Message-State: ACrzQf1drbRKDRUHy2tcYMIqkO2MNxErLTWoa7FGo39EShYvntB8RzSh
        KwJeRMy48/yRXl+2X8sAk7lJA6wm3VI=
X-Google-Smtp-Source: AMsMyM7sZxd5nPOCs59XV8m+x9XtHd9Qk493E9JbC/Tz8JwzedajoccvvRiIV+7P4ALuiBKPx+gerA==
X-Received: by 2002:a05:6638:16d6:b0:358:31d8:65d8 with SMTP id g22-20020a05663816d600b0035831d865d8mr3786532jat.137.1663898098323;
        Thu, 22 Sep 2022 18:54:58 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00::1e16])
        by smtp.gmail.com with UTF8SMTPSA id r10-20020a02b10a000000b003583d27d258sm2847885jah.105.2022.09.22.18.54.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 18:54:57 -0700 (PDT)
From:   Richard Acayan <mailingradian@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        Richard Acayan <mailingradian@gmail.com>
Subject: [PATCH 2/2] dmaengine: qcom: gpi: add sdm670 support
Date:   Thu, 22 Sep 2022 21:54:26 -0400
Message-Id: <20220923015426.38119-3-mailingradian@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220923015426.38119-1-mailingradian@gmail.com>
References: <20220923015426.38119-1-mailingradian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The Snapdragon 670 uses GPI DMA for its GENI interface. Add support for
it.

Signed-off-by: Richard Acayan <mailingradian@gmail.com>
---
 drivers/dma/qcom/gpi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
index 89839864b4ec..9634be23e46b 100644
--- a/drivers/dma/qcom/gpi.c
+++ b/drivers/dma/qcom/gpi.c
@@ -2287,6 +2287,7 @@ static int gpi_probe(struct platform_device *pdev)
 
 static const struct of_device_id gpi_of_match[] = {
 	{ .compatible = "qcom,sc7280-gpi-dma", .data = (void *)0x10000 },
+	{ .compatible = "qcom,sdm670-gpi-dma", .data = (void *)0x0 },
 	{ .compatible = "qcom,sdm845-gpi-dma", .data = (void *)0x0 },
 	{ .compatible = "qcom,sm6350-gpi-dma", .data = (void *)0x10000 },
 	{ .compatible = "qcom,sm8150-gpi-dma", .data = (void *)0x0 },
-- 
2.37.3

