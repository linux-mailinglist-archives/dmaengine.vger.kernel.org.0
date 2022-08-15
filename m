Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E75CA592D44
	for <lists+dmaengine@lfdr.de>; Mon, 15 Aug 2022 12:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241583AbiHOKMz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 15 Aug 2022 06:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbiHOKMj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 15 Aug 2022 06:12:39 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C8520F43;
        Mon, 15 Aug 2022 03:12:34 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id z6so10005899lfu.9;
        Mon, 15 Aug 2022 03:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=XFDcvvTwcmcM0SO0UVivfLd048EZbiPv12fEaB32GFw=;
        b=o+OXd0Wy23lss/jW6hPBvLsnqzCFBUKtzdGSITp2WzaIPHwI0NGfJgR/kI1/E53hbI
         34CjzmO0kyqXPFYarSNmRoqudHUIsRIctGZmGyLMTfCy7LHHX81NTRfiwfWOTMFjPoZs
         gYjNbnAAyYHCqZw3Mv+lMgYjRgWCeLHEojwrRhv0gNOWWb7ByxDoN9ivg0U0kUXZyfAp
         y1NbMbtwd0PybE0zHxx1uguT92fqTIRcf2uIRmttvp4JIJfLmW1QABXX4jc5WbMVv4cX
         o2qHkxBWF1Jkr7xpwOScU9ecMPo9bXScRqRuUTEERcY+QDX45AAJ1bmKiU3iZDRkLjiF
         2Ajw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=XFDcvvTwcmcM0SO0UVivfLd048EZbiPv12fEaB32GFw=;
        b=HxCJW8yw1ysI6tlta8Hmrf8gNG+PXkTv/lp4wwhKq7JsphOzlgb1ngEfXl++s2W98F
         QHnUIV/fY6N5K9ahcR3+iJbHwPJoMCG9okA7sylgCYRvP4G8xbjiyRrzMMnv4KxmULCy
         B4imEUWpe7lK+g9I1CP7Lz9vNOz8s9GyTWQ21mRxvX953Z+Iw+KrcuqqY09KH+ikVQUO
         u+uni3fKfbxtyEY6dTM76gxaS/C6C6UssrjWXBr7StKZiZ1sVpmFrOUGRmvp3Dz2U8+N
         B5S2xZ2i3aXjC/PjK1qnl2NhtCdZsuMk4sjXnwXFelIgAPN/aI3jZ6l07Kjatjq5FnYO
         a22g==
X-Gm-Message-State: ACgBeo1BeI/fzYfSQ5nQodmL6Fdafdoo3gbVSmxlkzu6haYj6Jd+xqjt
        RTUeP2Ln1zQA071ljIA7aaKdVj+ACTc=
X-Google-Smtp-Source: AA6agR5xdRZD5HfsRYV+hNt3a82Ms4B8JDZGHDd7e4DeGWYbF5JNn7TG5ajAnBGBqGuv6mEhTpy9Mw==
X-Received: by 2002:a05:6512:3d18:b0:48d:244d:2120 with SMTP id d24-20020a0565123d1800b0048d244d2120mr5149783lfv.387.1660558352372;
        Mon, 15 Aug 2022 03:12:32 -0700 (PDT)
Received: from localhost.localdomain (admv234.neoplus.adsl.tpnet.pl. [79.185.51.234])
        by smtp.gmail.com with ESMTPSA id 18-20020ac25f52000000b0048b1ba4d2a4sm1047264lfz.265.2022.08.15.03.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 03:12:32 -0700 (PDT)
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
Subject: [PATCH 2/7] dmaengine: qcom: gpi: Add SM6115 support
Date:   Mon, 15 Aug 2022 12:09:40 +0200
Message-Id: <20220815100952.23795-3-a39.skl@gmail.com>
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

Add GPI compatible for SM6115 ee-offset is set to 0x10000 on downstream.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 drivers/dma/qcom/gpi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
index 8f0c9c4e2efd..b7fc6e0168f3 100644
--- a/drivers/dma/qcom/gpi.c
+++ b/drivers/dma/qcom/gpi.c
@@ -2288,6 +2288,7 @@ static int gpi_probe(struct platform_device *pdev)
 static const struct of_device_id gpi_of_match[] = {
 	{ .compatible = "qcom,sc7280-gpi-dma", .data = (void *)0x10000 },
 	{ .compatible = "qcom,sdm845-gpi-dma", .data = (void *)0x0 },
+	{ .compatible = "qcom,sm6115-gpi-dma", .data = (void *)0x10000 },
 	{ .compatible = "qcom,sm8150-gpi-dma", .data = (void *)0x0 },
 	{ .compatible = "qcom,sm8250-gpi-dma", .data = (void *)0x0 },
 	{ .compatible = "qcom,sm8350-gpi-dma", .data = (void *)0x10000 },
-- 
2.25.1

