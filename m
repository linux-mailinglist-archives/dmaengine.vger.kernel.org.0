Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF0E592C81
	for <lists+dmaengine@lfdr.de>; Mon, 15 Aug 2022 12:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241795AbiHOKM4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 15 Aug 2022 06:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242390AbiHOKMl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 15 Aug 2022 06:12:41 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF70714D36;
        Mon, 15 Aug 2022 03:12:37 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id y23so7153023ljh.12;
        Mon, 15 Aug 2022 03:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=fYQsm9UdRD9rnFhcYGRNbb5PGnoO8X04eE31X6T9EuY=;
        b=VD2DdiifLjGal1AJ5jTkkihLDv9UxDue4ZQIRS7YAxyyXc0QZkA7QUbtVsIS/7/R+f
         FFxJzx4S+AfRDlqTHdSo6++qHa/FK751Vj0yYY3IC255+Fes+aytf9Oz0ff6uCyBScYp
         r87nIamuWoyNFm6I91B7ji73uhy0/I9ScU3vSiAEA+OqfYbXLqoZLPoOGAL7MN4+0dGk
         +wDaiXmS/OmJX4YtrXP+9wfxVrFsSEE1REIaR4+uXpmik8Uf/zCX7gg6l7+T29POIV+f
         hkEJ9EMl2QJmSiIgBPKzzOuf7GUv4igoZyBfq4i0pfn3t9J8h0MTxj8IxW71FOvhdueh
         wJ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=fYQsm9UdRD9rnFhcYGRNbb5PGnoO8X04eE31X6T9EuY=;
        b=1Fzr+/6S6neBlxV9OXySvoho5cMHJhKweEE42kchPj0jsXKnnj20ETNXsA0a63DVx8
         T13s4QoomXQcfRdRTT0YvmYuHbX03oakUU1AtXNhE43LOUUwZimnO9KyFSNGv8pCgp6B
         cWBmXw4GjWYZ+Toww0X9dAJoe/W05e3KU/tltqozzHplBbSmgyGY2i3qbYhrG2WC+wLY
         /cJSixhhjtaN25A6QlIZseYXwremt8pb8QZKb6izYb4s7q1ENrTCxsXDHJMMZwnC+KeV
         fUkL7EMeIPMVpQv75MZbEXomDhSmKmcgo0SAIlpBiOhh/OwYPm6IlS/0F5xxbqz72a81
         NQIA==
X-Gm-Message-State: ACgBeo2fBJDwp/nSZUUYMu4ywTQ/SpBTXM5FN79RLHw698jc/7k0oTcA
        2Spo4YwxqX+aqAA/k+gEjppvp0thDGU=
X-Google-Smtp-Source: AA6agR7w0kwVxCBmcmTnLXYnt44uoSZ39GekewNXMNQ2SP1VnQiEqRTXU/4xvIbJ7zFBAO3sq8xJLQ==
X-Received: by 2002:a2e:8954:0:b0:25e:42f7:5ba6 with SMTP id b20-20020a2e8954000000b0025e42f75ba6mr4765880ljk.213.1660558356089;
        Mon, 15 Aug 2022 03:12:36 -0700 (PDT)
Received: from localhost.localdomain (admv234.neoplus.adsl.tpnet.pl. [79.185.51.234])
        by smtp.gmail.com with ESMTPSA id 18-20020ac25f52000000b0048b1ba4d2a4sm1047264lfz.265.2022.08.15.03.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 03:12:35 -0700 (PDT)
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
Subject: [PATCH 3/7] dt-bindings: mmc: sdhci-msm: Document the SM6115 compatible
Date:   Mon, 15 Aug 2022 12:09:41 +0200
Message-Id: <20220815100952.23795-4-a39.skl@gmail.com>
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

Document the compatible for SDHCI on SM6115.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
index fc0e81c2066c..a792fa5574a0 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
@@ -41,6 +41,7 @@ properties:
               - qcom,sdm845-sdhci
               - qcom,sdx55-sdhci
               - qcom,sdx65-sdhci
+              - qcom,sm6115-sdhci
               - qcom,sm6125-sdhci
               - qcom,sm6350-sdhci
               - qcom,sm8150-sdhci
-- 
2.25.1

