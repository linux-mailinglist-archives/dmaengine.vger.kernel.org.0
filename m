Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDBC8592D4E
	for <lists+dmaengine@lfdr.de>; Mon, 15 Aug 2022 12:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241824AbiHOKMy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 15 Aug 2022 06:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242099AbiHOKMe (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 15 Aug 2022 06:12:34 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761A614D36;
        Mon, 15 Aug 2022 03:12:30 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id v2so10024423lfi.6;
        Mon, 15 Aug 2022 03:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=37hkLcdgNgubX4Qyk91CfdXf5mvcvwFudIhsOtr9EEw=;
        b=NYGLyQQqUqYkwf3Q3pX8yKdsheZJ3SvVkcE9UOn7QPgncXgUbQodtaSxUYtp027LAC
         ToSQcTy891ShBwIOFSDY+8UROK0Lt/NkgmVaD29EL9+uc1uVYGlgSOK2EiaWqYTClS+E
         whG5eU+xAkrtgSo/HHDcvA+J2Qea++Ex9Uy7PVLSMp47A6KhLKbmCuHaIOuh8xh8KbG1
         wSgsaf4YV1bkDgpg9oQlFreGWmyGHLHps0n8pFiWK1Vk5/eekQeTDdIwivOl2Qf1YZGR
         C9rb5KaviuBxn35NrtTQhqehcQ53EranXBUdupLctPpqoFV5VlyukQ2bnU7AgRb9HEnh
         cuTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=37hkLcdgNgubX4Qyk91CfdXf5mvcvwFudIhsOtr9EEw=;
        b=k65w08lYD0Dnse3Dw/gGVcsD1URcM+9NN6dyGWAsE0SOH35GUo34d/ygLA4syfBiFO
         Um0xMDO1HtUUWVrFvRQJY2ugA22PduvBEgrpS+X8rR74phgTKEppQ2pLTnLVyS88i1AC
         2mxsdDtDaOiGQS0H/92KM/MPTV6/wUAET6JSgX1lYolHJoHp3Bu9yxjJwCHwltHibbyd
         oK6moX2HHIceedIMD6VqCT4ndnaxFSZaBBYVwnM9TlnuyX7rTVUZEW3pnWv4wh7Nxopm
         Q1LvC+H9mvqDl4HY3SdKS7liY0XjsIFct9Tcyi2qyd76Lw4o8UvA7MBf/PHxqIFxVgH6
         9Llg==
X-Gm-Message-State: ACgBeo3a8EzfboR5DtQGiiYv/O9n5lMR4UYh6dAU3+uMlziy70/cQAXJ
        iZBruT15PUU63NDNMnrV0Ur7lbA5O3U=
X-Google-Smtp-Source: AA6agR67Y7mKftzVsB+SIg6QPvZgzAK+AadkJqp6OVGpsZPfsnMVVn3NBr7IVazQjALdim1s3/TCZg==
X-Received: by 2002:a19:c21a:0:b0:48b:2a91:e70 with SMTP id l26-20020a19c21a000000b0048b2a910e70mr5101349lfc.585.1660558348637;
        Mon, 15 Aug 2022 03:12:28 -0700 (PDT)
Received: from localhost.localdomain (admv234.neoplus.adsl.tpnet.pl. [79.185.51.234])
        by smtp.gmail.com with ESMTPSA id 18-20020ac25f52000000b0048b1ba4d2a4sm1047264lfz.265.2022.08.15.03.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 03:12:28 -0700 (PDT)
From:   Adam Skladowski <a39.skl@gmail.com>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Adam Skladowski <a39.skl@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Emma Anholt <emma@anholt.net>,
        Rob Clark <robdclark@chromium.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        linux-mmc@vger.kernel.org, linux-pm@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>,
        Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH 1/7] dt-bindings: dmaengine: qcom: gpi: add compatible for SM6115
Date:   Mon, 15 Aug 2022 12:09:39 +0200
Message-Id: <20220815100952.23795-2-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220815100952.23795-1-a39.skl@gmail.com>
References: <20220815100952.23795-1-a39.skl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Document the compatible for GPI DMA controller on SM6115 SoC.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 Documentation/devicetree/bindings/dma/qcom,gpi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
index 7d2fc4eb5530..fcfe8a373a16 100644
--- a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
+++ b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
@@ -21,6 +21,7 @@ properties:
     enum:
       - qcom,sc7280-gpi-dma
       - qcom,sdm845-gpi-dma
+      - qcom,sm6115-gpi-dma
       - qcom,sm8150-gpi-dma
       - qcom,sm8250-gpi-dma
       - qcom,sm8350-gpi-dma
-- 
2.25.1

