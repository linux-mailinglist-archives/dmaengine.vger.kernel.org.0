Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D48EE5F801E
	for <lists+dmaengine@lfdr.de>; Fri,  7 Oct 2022 23:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiJGVgv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 7 Oct 2022 17:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiJGVgv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 7 Oct 2022 17:36:51 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7716E10450D;
        Fri,  7 Oct 2022 14:36:50 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id h74so668231iof.0;
        Fri, 07 Oct 2022 14:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iGwDSTFX1yNvvppM4st7+wZ3wz4iLqdjk2hbWGL5Nmw=;
        b=dqUmG7S3TXPlJNBBZirfZGC8gd58jED0cMKepCTg0R7603mQ5yK15AzLSAecP3qS/H
         Cx1oXa1N5uymZcNqjjbTvFZ8V6aw96EgJ3hzPShzUFaBZojjgJVBKmSpOzi5K1IbmDI6
         BR+3uzjSuoi2WtHuQXgi7wOjKeM9oAIiQbcsqK8wN6unWLf06yFkUS6ATYb9v3gO5Jj4
         UFeqi8Ha5ftozEytSm5nEKzuptHqgNjef+DCrNxeq5lqZqjdDG3JE4fPa+vz0m1bAY2/
         tJRAhNpPilpLG+pKb0i5+PX4ypi9fwKkIUnb86G15kyZ+P4bsmWTGQek766W36rm/XBg
         tMaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iGwDSTFX1yNvvppM4st7+wZ3wz4iLqdjk2hbWGL5Nmw=;
        b=VU5Ch+5lsO/pjQ063HAQMy6mx+X8vjQa5+tqUO/F3mbDblBSRTjG1cfptglXvJPgfA
         JIKAO2aYwCFE9RnR/2vWr/gqkpuoJQa4uhRrZzSq/xMkpQPYADhY+uZ61xqd+yU7O/u8
         o3leqR94NIVSIjZSrsW15AjndxNGAJvVOJ1J3P53xmgGLzr1IMKaz5ny32+jtDFsbdmj
         0ZjnsxEdCBVrQZKARgzL/Uc8AlPlin9V57vaguYdOZ6RO1ZgN3c4iXGvIvIBBdW8HTjx
         0QA9RhMymGBqlCLVS2TIlxgJAJFLoJrMmdrDs13Vx8aGin4jbdJpjdcsnmLDPySvbkWo
         zu+Q==
X-Gm-Message-State: ACrzQf2+6Pq1EpW5Gmq/CAEV0ft04dWviOyuKaGPAIUQdsQ81ZKqX10/
        4KnWSDicXQjAXMwU9elOl7fr92CFS6aGZw==
X-Google-Smtp-Source: AMsMyM5kTPhPcT6bwrnb6AjZzwXl1NMM1itFrXrm4xcaoM1YdOCsuTwHv/twTec/nUaN+Q9O4AHycQ==
X-Received: by 2002:a02:c90a:0:b0:363:2b87:887c with SMTP id t10-20020a02c90a000000b003632b87887cmr3732135jao.72.1665178609689;
        Fri, 07 Oct 2022 14:36:49 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00::b714])
        by smtp.gmail.com with UTF8SMTPSA id d11-20020a02858b000000b0036384f898a0sm1115121jai.133.2022.10.07.14.36.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Oct 2022 14:36:49 -0700 (PDT)
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
Subject: [PATCH v5 2/3] dt-bindings: dma: qcom: gpi: add compatible for sdm670
Date:   Fri,  7 Oct 2022 17:36:39 -0400
Message-Id: <20221007213640.85469-3-mailingradian@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221007213640.85469-1-mailingradian@gmail.com>
References: <20221007213640.85469-1-mailingradian@gmail.com>
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
2.38.0

