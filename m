Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0AE592C99
	for <lists+dmaengine@lfdr.de>; Mon, 15 Aug 2022 12:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241931AbiHOKM6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 15 Aug 2022 06:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242421AbiHOKMq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 15 Aug 2022 06:12:46 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28CD618B15;
        Mon, 15 Aug 2022 03:12:45 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id e15so10065931lfs.0;
        Mon, 15 Aug 2022 03:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=0aiK8oEVUknjQ/kFKM1Zoa7em7h8jPtDacZ1gsZezrs=;
        b=HWo1DgSkxhAANSjcWUOA0TiwznpZBpDvJCSJ7MjjR4jNaQQsaI1nJqZH6RPmtTNcUS
         PHEnklUIGr/0mptrSiTImNt4rMpRbXxv6WZ+fiwxpHBCP5HR7IDjLWBXGElqJMLxzcvY
         MoohSf5bqWRdzJptVhym4klsBeZXbkpvt1phXR9vzKHbn+lqKBBW/PaUO3dif4L49XFk
         3sueV0Hask46IHCv4HxlQzuDfVmJq06iq9osAUxyK+2pv6A4sl6x7Gyj/i/c995Ut7/Y
         T+3pMkdKK2sAlGhKGk/A1+cPv3/scbJJbFD2I1fM51MjdZkw5tq4brVKzDL5lp7lEq78
         Q+Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=0aiK8oEVUknjQ/kFKM1Zoa7em7h8jPtDacZ1gsZezrs=;
        b=8OUIjAf9Y22V08X3jjEhM6E4T7Issl2/5sAnsa9IOPv0Y0aVWw9bXbZ7s+0tQe4II2
         IyUj0nc4DvypDN4eNJ8bGzXky6mjQRBmPsXfQrk8Uqv6rYGLq3szZEMbwjz3Egs9nb/u
         icbks5Un57TjxLSNpd1cwQ90v025cR0U1TDv5EHfzMrNDicE+xPmU+s6iz5VrF3AGM5R
         QUKNbJnfu/8G0FWwXfYiG47VdBcXobrRX2as/phSyIZhqaWYIOmLwQs4CQHXpbkhZuUS
         FFPAM7hX6SKnOGbZazt7y+PTlU2VbRrNZd4DZiObkaNuJpfUgw3QpPGsLiww+ctxZMva
         PaXA==
X-Gm-Message-State: ACgBeo2aXyzg34rbQflPw0KATg280MHdj//EOl2SpbNGMqL238mwxBv7
        Fq+AErfSYXoBrEI/W/Lh3et9bAwLzb4=
X-Google-Smtp-Source: AA6agR7KF39lbkfwH+fJnTC4y2+jJqk2OXiZ7h/3q79X/zqHE9z1CvaR4+vorBEsi8CYQNY1FxLa1Q==
X-Received: by 2002:a05:6512:398c:b0:48b:a1e6:c631 with SMTP id j12-20020a056512398c00b0048ba1e6c631mr5171565lfu.229.1660558363510;
        Mon, 15 Aug 2022 03:12:43 -0700 (PDT)
Received: from localhost.localdomain (admv234.neoplus.adsl.tpnet.pl. [79.185.51.234])
        by smtp.gmail.com with ESMTPSA id 18-20020ac25f52000000b0048b1ba4d2a4sm1047264lfz.265.2022.08.15.03.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 03:12:43 -0700 (PDT)
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
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH 5/7] dt-bindings: arm-smmu: Add compatible for Qualcomm SM6115
Date:   Mon, 15 Aug 2022 12:09:43 +0200
Message-Id: <20220815100952.23795-6-a39.skl@gmail.com>
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

Add compatible for the Qualcomm SM6115 platform to the ARM SMMU
DeviceTree binding.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 9066e6df1ba1..71f8f638a1f8 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -41,6 +41,7 @@ properties:
               - qcom,sdm845-smmu-500
               - qcom,sdx55-smmu-500
               - qcom,sdx65-smmu-500
+              - qcom,sm6115-smmu-500
               - qcom,sm6350-smmu-500
               - qcom,sm6375-smmu-500
               - qcom,sm8150-smmu-500
-- 
2.25.1

