Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B37592CEE
	for <lists+dmaengine@lfdr.de>; Mon, 15 Aug 2022 12:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242074AbiHOKM6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 15 Aug 2022 06:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231904AbiHOKMy (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 15 Aug 2022 06:12:54 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D258618E24;
        Mon, 15 Aug 2022 03:12:52 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id u3so10001036lfk.8;
        Mon, 15 Aug 2022 03:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=w89xCg2DJrJPW8V3cF8x8hrEYxnShDOQLITDiKSZkEc=;
        b=l8Tlvfgc1cMV2pOl5lWM7OjERWMTwmI2EVvQtbojA0fdn/02tWADFLrtYt/18s3Nww
         gGORT2ZOnkDGu+TH9asBMAxin9e52D6YJANNxYRH0M6B9snyXCf3HxxR2LF07Kl+tuXh
         3EZFYVELNnbgsEqj/h8Amy/xbvpyAZXo4Gv7DTZjDOyG0tSfzpJJgVY/in+eiNmaBVW0
         z6IJB48OWG4DqKh/O9nC9fafTFvO1h5x1IjzfY7fFnFaCaVTuJ3XUYtX2S8PD4g95JuL
         X0zFLf731ntq/hsByoYcLcaMYXHdC0LhP0z0QQASpCRCPZuJDkrJ0nVbEoWjIQiypnOy
         HBMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=w89xCg2DJrJPW8V3cF8x8hrEYxnShDOQLITDiKSZkEc=;
        b=dKjUayhDhcQ9isnzkf1GF+NlRFWDtO0aKI5jshowHBdn8oWR3/t2udwpDyDeTxC2qA
         f35882cK93o7gWIz428i9IVOA69U+cwCW0st9zzgN1iGa90e0iO6wJBqqCcWds4vQWLc
         hxeELfHSX4HC95TKveQFhXhyukLmqDrMmma3+GbALBMvKQdt7S8GVhsRiKTXisEHs2Ag
         aWmnK206V3UCb/+MN9tu3vIbT2AiTZLVQtlj7XCYqBiOGvJy05DRacmbt9AM8zf7fr4F
         1TFOMbDeng7fvAocjMlaKyj4VNWIEiWmIn+VLtc/2WYTONG1IluhMCX/ZVAX/KF2PgZq
         XORQ==
X-Gm-Message-State: ACgBeo0+JgfVvjwYLf4W66d8ivrUJ2xFLn+i8K9V9bql55wvEucWjwTY
        I1fs7gC0Pqo4q8sM1YqD7uRNEbEEmZ0=
X-Google-Smtp-Source: AA6agR4Y8c+05pNlzgn0h0JNXaPAWlMLUxPgeJJDPHNrCo75V+e7HeobYI4nZTSut+hiM8h0MSCJqA==
X-Received: by 2002:a19:4f56:0:b0:48b:205f:91a9 with SMTP id a22-20020a194f56000000b0048b205f91a9mr5157474lfk.543.1660558371054;
        Mon, 15 Aug 2022 03:12:51 -0700 (PDT)
Received: from localhost.localdomain (admv234.neoplus.adsl.tpnet.pl. [79.185.51.234])
        by smtp.gmail.com with ESMTPSA id 18-20020ac25f52000000b0048b1ba4d2a4sm1047264lfz.265.2022.08.15.03.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 03:12:50 -0700 (PDT)
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
        Sibi Sankar <sibis@codeaurora.org>,
        Adam Skladowski <a_skl39@protonmail.com>
Subject: [PATCH 7/7] dt-bindings: firmware: document Qualcomm SM6115 SCM
Date:   Mon, 15 Aug 2022 12:09:45 +0200
Message-Id: <20220815100952.23795-8-a39.skl@gmail.com>
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

Document the compatible for Qualcomm  SM6115 SCM.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 Documentation/devicetree/bindings/firmware/qcom,scm.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.txt b/Documentation/devicetree/bindings/firmware/qcom,scm.txt
index b3f702cbed87..f6b95d86efc6 100644
--- a/Documentation/devicetree/bindings/firmware/qcom,scm.txt
+++ b/Documentation/devicetree/bindings/firmware/qcom,scm.txt
@@ -26,6 +26,7 @@ Required properties:
  * "qcom,scm-qcs404"
  * "qcom,scm-sc7180"
  * "qcom,scm-sc7280"
+ * "qcom,scm-sm6115"
  * "qcom,scm-sm6125"
  * "qcom,scm-sdm845"
  * "qcom,scm-sdx55"
-- 
2.25.1

