Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2E875F1FBC
	for <lists+dmaengine@lfdr.de>; Sat,  1 Oct 2022 23:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbiJAVTq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 1 Oct 2022 17:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiJAVTp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 1 Oct 2022 17:19:45 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3D5659D;
        Sat,  1 Oct 2022 14:19:43 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id p202so5733493iod.6;
        Sat, 01 Oct 2022 14:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=W45UiD2TumgDHADA0Bi3A73GMwe5dfWiZOQNYdF92SY=;
        b=mqi5UeL4NN8J4sXjI7AOWnU8jZonIf3ImSkDEUYdxacv6jOvgBvpL61SMb3DzW9Zv4
         /kP+EJ0NN+T/pb8o3J4K3vr/UGq7jk/ZeJd6ln6HPHWWsO6tHTj/zbMzzOoEZRwariOj
         wrKUASiOnVkpHr0NpsCb4kIUl/RYHnh6IHtI8h9WOejN8/8tWoJwXP8o1ZjSkY8RP3Ai
         Td3xjKnP6332WQtLiSgAbKpiEbGvbep4Quo0Az81NdSep2wblFWIVJs6mAN/GjGdBQKP
         j9CluzHXzr+OHQFOQLcwPvckklnDdE36yXMxMKTH4QSAuPnooGW913FwUI+tImEYFUDZ
         86Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=W45UiD2TumgDHADA0Bi3A73GMwe5dfWiZOQNYdF92SY=;
        b=N8ia9Qgdq2FOGPES4qMPLnilzMYd3FOxpV8cqLmW0uhPKApaH9hWwN3PHzAY9PwD1O
         ErwRGhXuRoLgYX8l98yFJB5XlukFw+GOw2O34TJ/SaF1ds9RneTYYQgQDGxO4ZiEr/Lm
         RI80PHw5o3Ki/HE5ohD4r/pb9SyGi4Ju8A4mKE/NeNyr8DFLaHI/byzgvZnzxDK/3NXu
         RTKbc9coMxrYxePMdBCRRPL43/+Ra7aaPDACGTR4WiX6x+ap+J3PsvkaV2n1dMEs6K9m
         CzvJ/0lS7gwruc+3uT2rl611TLV/ytydaVsiPHhbJQLIkEktvcDmVeY1BoTjkLV9xXTw
         VVZg==
X-Gm-Message-State: ACrzQf3ynVskEKBDbmxLa69dT/p5BBFBx62DghFFYbbinEPNiccNI3z+
        NBBKWWjBEiYq15zzOGhjmN5aHeORlKcQEA==
X-Google-Smtp-Source: AMsMyM4fSyY4UVQKxgr1kycGYFuo068e1zqkSkumS1yVZPshVg2VHVa7zARlNRkmFq1IL82O4p636Q==
X-Received: by 2002:a6b:cd86:0:b0:6a8:4861:fc2e with SMTP id d128-20020a6bcd86000000b006a84861fc2emr1902728iog.38.1664659182495;
        Sat, 01 Oct 2022 14:19:42 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00::1eda])
        by smtp.gmail.com with UTF8SMTPSA id x6-20020a026f06000000b00352a7f96772sm2356074jab.38.2022.10.01.14.19.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Oct 2022 14:19:41 -0700 (PDT)
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
Subject: [PATCH v4 2/4] dt-bindings: dma: qcom: gpi: add compatible for sdm670
Date:   Sat,  1 Oct 2022 17:19:32 -0400
Message-Id: <20221001211934.62511-3-mailingradian@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221001211934.62511-1-mailingradian@gmail.com>
References: <20221001211934.62511-1-mailingradian@gmail.com>
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

The Snapdragon 670 uses GPI DMA for its GENI interface. Add a compatible
string for it in the documentation.

Signed-off-by: Richard Acayan <mailingradian@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/dma/qcom,gpi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
index 081b8a2d393d..750b40c32213 100644
--- a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
+++ b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
@@ -28,6 +28,7 @@ properties:
 
       - items:
           - enum:
+              - qcom,sdm670-gpi-dma
               - qcom,sm8150-gpi-dma
               - qcom,sm8250-gpi-dma
           - const: qcom,sdm845-gpi-dma
-- 
2.37.3

