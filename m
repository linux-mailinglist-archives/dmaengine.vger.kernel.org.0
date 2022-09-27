Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB755EB71C
	for <lists+dmaengine@lfdr.de>; Tue, 27 Sep 2022 03:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbiI0BtE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 26 Sep 2022 21:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbiI0BtC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 26 Sep 2022 21:49:02 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0727EA7ABC;
        Mon, 26 Sep 2022 18:49:02 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id b23so6722463iof.2;
        Mon, 26 Sep 2022 18:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=e/3FJGz3M1WJ7JRUlhYtYPLgkBmRsIxeSkJi7K2t5pY=;
        b=MpU2DmtTTMpf1iFm0sgeNqSL9cLZuCnEZLDopqQRmwh/qthtYDVReg4woYtHVSyyZx
         DXxzSyabBiCTTQXDnkOT+0S1h+2e1ETN1eCAHX0gV18tBOsMq8mhz0NDuYO5OIsi768N
         w39VqH0LEnuzlSSfYHebggAZF+okz+1QXBG6CiftlnQQtTZ0QEYfi1sLTUIBMJ1ivCJO
         KKJP/BuCqPvwhZ08nkJ4wPBVfQj4fkxJT/pEKlgU5IUgB8mdP/BgFyWUmS03J4oS/xP2
         i7ln1yhVfT6Z6cKCLkhtu6sFAB7Dk4BC7RZAr6zQyUu1PxbhnT2w8mCBcRws8oYhLM2z
         4AyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=e/3FJGz3M1WJ7JRUlhYtYPLgkBmRsIxeSkJi7K2t5pY=;
        b=IMQx+m0oumn/FfUBlvoDuAJvfbzNABECk2L4sK10tuFO/hzZGqiU1TJ9ZCeAGVx8VX
         vRUxmTUKkvLnCd1DxJ3LdzHYm7w1xfSEw+A82EzSjPm6htd53BiqJjx9cDrR607yy0Or
         y6K+n3slD6OszvIUc676pCRDBwYDXn6Y2oJj3uq5JfNKjDGt7lMvaeiz0q3T/S/kWaMD
         9IzO5XMxPmuaKtgOw4zOon8iclqSct6sTQQUIpAQEhVyDXa81iXMpKO6uBqHhBsfSS5C
         fDlfDAyfLudQ4FF4AgOkHlkpg6PPw6b8ZN0pOI4KYCxEr9BD8SdHn4B+1Bns/oOuxRVE
         QjLw==
X-Gm-Message-State: ACrzQf0d1AhoUS8wxnnuLO8MWscfqltWKntgKoraWMnQoh/rhQUlUHMV
        1tS2BQeWWUmVSXKZWZekOBTy5TQzUlI=
X-Google-Smtp-Source: AMsMyM73kKBBCQZV+I8Z6Qbdjg7M1DbvuOuDkic+HK62GEc0XzESlozHGmtwGNwh8R6MXPW4UrDZhQ==
X-Received: by 2002:a05:6638:24cc:b0:35a:5ee3:8f68 with SMTP id y12-20020a05663824cc00b0035a5ee38f68mr13572369jat.255.1664243341051;
        Mon, 26 Sep 2022 18:49:01 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00::ac99])
        by smtp.gmail.com with UTF8SMTPSA id r14-20020a922a0e000000b002f47787f44asm165993ile.13.2022.09.26.18.48.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 18:49:00 -0700 (PDT)
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
Subject: [PATCH v3 2/4] dt-bindings: dma: qcom: gpi: add compatible for sdm670
Date:   Mon, 26 Sep 2022 21:48:44 -0400
Message-Id: <20220927014846.32892-3-mailingradian@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220927014846.32892-1-mailingradian@gmail.com>
References: <20220927014846.32892-1-mailingradian@gmail.com>
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

