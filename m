Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA48592CD5
	for <lists+dmaengine@lfdr.de>; Mon, 15 Aug 2022 12:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242535AbiHOKNZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 15 Aug 2022 06:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242424AbiHOKMs (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 15 Aug 2022 06:12:48 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF57165A4;
        Mon, 15 Aug 2022 03:12:47 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id u6so7172290ljk.8;
        Mon, 15 Aug 2022 03:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=M6PIQlUx6Zdh6S9AJkWXOp4FOoOhzviQOAnjrgwO1aU=;
        b=WHGZmAbVH/Rt3jRuhcbO3MFReqRlbxNEcw89HPrkihvsw/6AUsLBLpMuuStY2tYoX3
         oSh5kwhi5Fyl8nm1nALfAIHq9Rd8FatG6DzFHJdsChe0LKyNSdl31DTqcIZKyh05TbLT
         rOSdSfpb0UFzHzUdQS9Sef9729xmTekAkHhZFthukrCEiDrPZ3dyX6lP7NL33uWLQBMo
         Ss6+1e+s0/kihYNcMQmeixIz4k/RNE649wo/OiAvfJgoVzmZEdodbwGGwJnaVcXoylUF
         r+l/8C1DxdD2bACELb7jCojdgZ3iixLENaffCZsrmRk4Ax7AOzDqanM9aHHnzmj0Y8J/
         BDKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=M6PIQlUx6Zdh6S9AJkWXOp4FOoOhzviQOAnjrgwO1aU=;
        b=J32QinGMOv0XJxV0x4R4y6n6IU/ZuzGvtDrID4OyFRkPM8zDt+g0z3UHKh012B6PPZ
         WDi3ewJRjULAg9i+YkaglZiNAdeilR39R9BoRD+p2dw8wTjRFgZcrqlIAQoRzricu5OK
         cUM7v5eh979p5SuKre6oj6MlOquzGkXI5/J35lSUimp2uthzD6agbA2vmGNTHCTKCVc7
         7iLL9ZzRuSlcMFom+i+cB1afb2paUpm3CgkBHO3ok7PD+hXOOuYGcEHeR/0fuU2yJSrA
         wgX39KdWjpqQWrjPV3Hbsbr6UT1aTrFeAlrwxVy3HvQk6pOuuOMxDpT/gCoG9oSJBzXR
         r05A==
X-Gm-Message-State: ACgBeo0P4JDrkOMAinBAB7p9dJX2JETX2jFm9Ak6Ak2jJ/qtBXoxcqDs
        +7RD+wiG0SdUtaDaBDcrFzl7i7DNgCM=
X-Google-Smtp-Source: AA6agR6ue/K7NDIBySkoofjS+cIh1O8Y2SxFzadrHzRFoVcUPw4z2N/CPH6O60kVQGA+Ty7tgtHhRw==
X-Received: by 2002:a2e:8885:0:b0:25e:bf9b:2de2 with SMTP id k5-20020a2e8885000000b0025ebf9b2de2mr5014503lji.367.1660558367059;
        Mon, 15 Aug 2022 03:12:47 -0700 (PDT)
Received: from localhost.localdomain (admv234.neoplus.adsl.tpnet.pl. [79.185.51.234])
        by smtp.gmail.com with ESMTPSA id 18-20020ac25f52000000b0048b1ba4d2a4sm1047264lfz.265.2022.08.15.03.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 03:12:46 -0700 (PDT)
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
        Adam Skladowski <a_skl39@protonmail.com>
Subject: [PATCH 6/7] iommu/arm-smmu-qcom: Add SM6115 support
Date:   Mon, 15 Aug 2022 12:09:44 +0200
Message-Id: <20220815100952.23795-7-a39.skl@gmail.com>
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

Add the Qualcomm SM6115 platform to the list of compatible,
this target uses MMU500 for both APSS and GPU.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index b2708de25ea3..526fec79b4fe 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -432,6 +432,7 @@ static const struct of_device_id __maybe_unused qcom_smmu_impl_of_match[] = {
 	{ .compatible = "qcom,sc8280xp-smmu-500" },
 	{ .compatible = "qcom,sdm630-smmu-v2" },
 	{ .compatible = "qcom,sdm845-smmu-500" },
+	{ .compatible = "qcom,sm6115-smmu-500" },
 	{ .compatible = "qcom,sm6125-smmu-500" },
 	{ .compatible = "qcom,sm6350-smmu-500" },
 	{ .compatible = "qcom,sm6375-smmu-500" },
-- 
2.25.1

