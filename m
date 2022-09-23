Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02DB85E719D
	for <lists+dmaengine@lfdr.de>; Fri, 23 Sep 2022 03:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbiIWBy7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 22 Sep 2022 21:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbiIWBy6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 22 Sep 2022 21:54:58 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B1541980;
        Thu, 22 Sep 2022 18:54:56 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id h194so9265725iof.4;
        Thu, 22 Sep 2022 18:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=WWCkl804ico60F1xNbgiB+MLksWA4Nf7dgSkTsSs29U=;
        b=QM1H2VZPs+aonHB0K55H9inGDoXKTi2V8s8ooCCHWkhTxuZkoZ7kHnqTbI0p0GuPAn
         tR8qaCOIGKxytY4BrbyolR6E3f6RvFPMg89qQnS7jLcy8JIPvvcgDYsMryPuyIsLZt4s
         XHnmPLwbV6jds9JJHKPsQTL8C7dOtCpBxQ0Lhl/dU53/S0LGtDUhbt0mWmWhITEQryEa
         lP/FgJWYQB2OUwaGRtIbt5tXAhxHfsYsM6fCGzRxHJUcnRKuXgJxOikEGjQRxMhxP5Ur
         SpMh/C1uPO4ECKkLMRIZzmOzIb1hXtji8f+MclPNJRJTDXn2wJvvHC4Ra+6U0b/uephW
         36eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=WWCkl804ico60F1xNbgiB+MLksWA4Nf7dgSkTsSs29U=;
        b=O1uo5Z3BUems0B1UlWaf98Y+g5sVd8wLDJ2JX07dkdRuZhZTJmM0dlpheKDS+SbKqG
         Ri68RvXWkTIjoKZZejENn+VBX3YTrWOVOPwZfj2Ujr5pznct2pEM1wCroSYgMdXe4qHz
         UEKPmyGUvEFNrtotfsgPgNYacWl/ZAdk1aAcNLIMz/wMcynaeeLgSuvPKyuJM4NGK7qz
         xyydwalddQlYPKch0mAgB5sL+0uW6mQJfiDosCjhQ+eBHCF57s2thTuYumfRtasu2qId
         TS2NmrHi0ZJEV0sozBl4xefvzjI6YmeXaS7F2VD0G3RbIDHoOmodYbvYpYnHHuf8w/5U
         XMhQ==
X-Gm-Message-State: ACrzQf2zu+G8kYIwUDuZQ4/by+uxRNduwLwCJlIXPrt129wQe5LBzluR
        EqUaNklXdpre1GIw0lepm9w7CVMA5Zs=
X-Google-Smtp-Source: AMsMyM6p0EIAlbamOzKoK//K5mesokVqJn5kz/U/qaj7gUKhogfY2OObhcLFF9vfwXBDn5IWe54mrg==
X-Received: by 2002:a05:6638:1487:b0:35a:ba3d:ba16 with SMTP id j7-20020a056638148700b0035aba3dba16mr3631663jak.188.1663898095809;
        Thu, 22 Sep 2022 18:54:55 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00::1e16])
        by smtp.gmail.com with UTF8SMTPSA id v28-20020a056602059c00b00681b6e20a82sm2984874iox.46.2022.09.22.18.54.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 18:54:55 -0700 (PDT)
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
Subject: [PATCH 1/2] dt-bindings: dma: qcom: gpi: add compatible for sdm670
Date:   Thu, 22 Sep 2022 21:54:25 -0400
Message-Id: <20220923015426.38119-2-mailingradian@gmail.com>
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

The Snapdragon 670 uses GPI DMA for its GENI interface. Add a compatible
string for it in the documentation.

Signed-off-by: Richard Acayan <mailingradian@gmail.com>
---
 Documentation/devicetree/bindings/dma/qcom,gpi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
index eabf8a76d3a0..cabe6a51db07 100644
--- a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
+++ b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
@@ -20,6 +20,7 @@ properties:
   compatible:
     enum:
       - qcom,sc7280-gpi-dma
+      - qcom,sdm670-gpi-dma
       - qcom,sdm845-gpi-dma
       - qcom,sm6350-gpi-dma
       - qcom,sm8150-gpi-dma
-- 
2.37.3

