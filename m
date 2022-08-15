Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD892592C24
	for <lists+dmaengine@lfdr.de>; Mon, 15 Aug 2022 12:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242144AbiHOKM5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 15 Aug 2022 06:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242407AbiHOKMm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 15 Aug 2022 06:12:42 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601ED167F2;
        Mon, 15 Aug 2022 03:12:41 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id u6so7172048ljk.8;
        Mon, 15 Aug 2022 03:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=pgmOEAhTB4c0Rk4dzh/uT4thgRDZIHmGfPeSwRRJ/84=;
        b=hnHCRK8Q+UxNpKPvzeerxtCOKBJH1jxjedRjN0LqDucNeVtuSVUGUXE8p3eN+HUAlA
         MXV6uTrfLlYPc9SKe0mw5fDa2UkUZp1RIX67iiPKuCxBVWz5CNSisa1J3e10ln2ZZZ6s
         MZVBG6YJ8LNf1kWiVBR+Gjl2oja2uYGWx5HCfupYYTYxzi/9mSQMjAKixx4te3EHyoNt
         lkIw7HFr+V12kj3oYgLDxcXaHxNl7LF0hpADsJDNcPrEhCDq7e74rLVuaS+ffDHItZGX
         auHafzn7A2K57uaJPVKZ9ukDucS0+D6ATjZoPT7W6/m6zrtjh9WmqmWCcc0Lob+ivxB6
         8t8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=pgmOEAhTB4c0Rk4dzh/uT4thgRDZIHmGfPeSwRRJ/84=;
        b=Ouj/VFhvx4aUMFSj74je03+4Kx4tReXGjn5Jj+Yoe7K7YAcv3AOpxbmVFB6uYP/V0g
         SAXzi/oa6U3xrkJCmVpw87qDh5l8bi4W693i/zProtWlC3z0U9aOHiTnFR9pnmRDfa8a
         5Ww0Uiskv3kGmPeDLrp+NUMmFf1aI5JH3Sc3+zqHpw22TJf+48mLRkaPEf9gIqd35vWk
         0PmfYZ0YYkB2pcXZhqPYRRgplbpMfo1svURzF1YD5wRvMR4MVea97h23xlAwAxSL+HnS
         L+zzfj/5c2xnE7c9mZjLPpL2jD5iAklnN5wBo4QuT6j/96Qpvx/vJE6gTmPku5/6dc5n
         G5GQ==
X-Gm-Message-State: ACgBeo2Db3Dz2td+2fNiQppBBDWsZfXf/s9LS/Aq/95rgIIP59a4Lkab
        c+esIs3ryVsiENLBHhx46woTq0aluCU=
X-Google-Smtp-Source: AA6agR6OohB1gAlSOX87kZJXM0HKoTso5IZAqCd692ZEM35DA0cnjXRxTqWgNdhzVNadBobpNWF4Rw==
X-Received: by 2002:a2e:b88c:0:b0:25f:eae4:74ff with SMTP id r12-20020a2eb88c000000b0025feae474ffmr5030106ljp.48.1660558359743;
        Mon, 15 Aug 2022 03:12:39 -0700 (PDT)
Received: from localhost.localdomain (admv234.neoplus.adsl.tpnet.pl. [79.185.51.234])
        by smtp.gmail.com with ESMTPSA id 18-20020ac25f52000000b0048b1ba4d2a4sm1047264lfz.265.2022.08.15.03.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 03:12:39 -0700 (PDT)
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
Subject: [PATCH 4/7] cpufreq: Add SM6115 to cpufreq-dt-platdev blocklist
Date:   Mon, 15 Aug 2022 12:09:42 +0200
Message-Id: <20220815100952.23795-5-a39.skl@gmail.com>
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

The Qualcomm SM6115 platform uses the
qcom-cpufreq-hw driver, so add it to the cpufreq-dt-platdev driver's
blocklist.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 2c96de3f2d83..6ac3800db450 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -146,6 +146,7 @@ static const struct of_device_id blocklist[] __initconst = {
 	{ .compatible = "qcom,sc8180x", },
 	{ .compatible = "qcom,sc8280xp", },
 	{ .compatible = "qcom,sdm845", },
+	{ .compatible = "qcom,sm6115", },
 	{ .compatible = "qcom,sm6350", },
 	{ .compatible = "qcom,sm8150", },
 	{ .compatible = "qcom,sm8250", },
-- 
2.25.1

