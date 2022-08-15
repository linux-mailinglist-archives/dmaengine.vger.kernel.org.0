Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 978C7592C69
	for <lists+dmaengine@lfdr.de>; Mon, 15 Aug 2022 12:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241543AbiHOKMx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 15 Aug 2022 06:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233494AbiHOKM0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 15 Aug 2022 06:12:26 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183DE175AC;
        Mon, 15 Aug 2022 03:12:24 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id a9so9988247lfm.12;
        Mon, 15 Aug 2022 03:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=MdskW5HP+CDyH23eInIpuoo8lXjbVqnmwkTOrQWFXYg=;
        b=UEx3+L/gV5rSZ6L2pIExhA4Ehw9o+jAookhe3x/Dl20YZFyIOgTKcbXMT/Kbcy0w9T
         PDDp+S5H5IRKkmc+DWuvU1KlfL/oTOA44P5OfeBI4698ZD/9uYM0so34cliZLrd+iUpd
         LQWx/p4UsAHk5rO+2I2ee/Q2VD0VZ55wG+ACs37Qh2CSJrdqeJq6jXNha5jO5IHSUMZ+
         wdyYxXgX71C+f/vC/2yVOsZR+2yUp65e6ibUygaza8v21jfbHoWyGTCRg3Vlgyo241/2
         +axA/OyBaJibj73Wm4khKZHCXqNw85d50/xKs6fFrjsn4zymMz6DzJun5Xyr0aQOb8G0
         8iwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=MdskW5HP+CDyH23eInIpuoo8lXjbVqnmwkTOrQWFXYg=;
        b=yo/x7Ut9eqWCwXpmjgVbFAR5VhmaWjcU+AyLNzFvxntpbjK6ciUyOx03eriw44R1Nw
         gRs4bnzG906C8/qsPZMTU6xqUu8g35Oc508+qeJMJ/pLwVZLOOC1jXKa5mxLc8BX9Ek7
         BWRQx8kP9DprFui7S3eT9EC+fP3Lb30R3ynJ50CW6g+p4tPWkJgiWmse7R/4lQt+MZs1
         WdCe0f9MjSj0ywL3DMOka/phYHw6aPBhXXEOqItJcgqrjHdD67aDhvRqcF6mXoh44CwG
         GL5gCjwG2/OM5NFsQdSipIhLxQC/pHRvYTb97SFn4lMlmTFlTTBtUzMsiU/6JrVFGqfy
         beEg==
X-Gm-Message-State: ACgBeo2KzBQOmQCgSh/A4vbXJzW9kf1oLT9LxrH2ibQ3lA9DouK9E2a7
        sDnzuCzRa6v1dLyO4KXOIU59NbNxMeo=
X-Google-Smtp-Source: AA6agR48ajQgkYbbBMkMx9FOY/cUH0YJqIDV8pf/uiQQV6pIiKrB6lPAhRoCRX+EWp5C+JPLBH6S5Q==
X-Received: by 2002:a19:710f:0:b0:491:fce9:cfb1 with SMTP id m15-20020a19710f000000b00491fce9cfb1mr2367812lfc.264.1660558343143;
        Mon, 15 Aug 2022 03:12:23 -0700 (PDT)
Received: from localhost.localdomain (admv234.neoplus.adsl.tpnet.pl. [79.185.51.234])
        by smtp.gmail.com with ESMTPSA id 18-20020ac25f52000000b0048b1ba4d2a4sm1047264lfz.265.2022.08.15.03.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 03:12:22 -0700 (PDT)
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
        linux-mmc@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 0/7] Compatibles for SM6115
Date:   Mon, 15 Aug 2022 12:09:38 +0200
Message-Id: <20220815100952.23795-1-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
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

This patch series add bunch of compatibles in preparation
for sending device tree patches for Snapdragon 662 SoC

Adam Skladowski (7):
  dt-bindings: dmaengine: qcom: gpi: add compatible for SM6115
  dmaengine: qcom: gpi: Add SM6115 support
  dt-bindings: mmc: sdhci-msm: Document the SM6115 compatible
  cpufreq: Add SM6115 to cpufreq-dt-platdev blocklist
  dt-bindings: arm-smmu: Add compatible for Qualcomm SM6115
  iommu/arm-smmu-qcom: Add SM6115 support
  dt-bindings: firmware: document Qualcomm SM6115 SCM

 Documentation/devicetree/bindings/dma/qcom,gpi.yaml     | 1 +
 Documentation/devicetree/bindings/firmware/qcom,scm.txt | 1 +
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml   | 1 +
 Documentation/devicetree/bindings/mmc/sdhci-msm.yaml    | 1 +
 drivers/cpufreq/cpufreq-dt-platdev.c                    | 1 +
 drivers/dma/qcom/gpi.c                                  | 1 +
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c              | 2 ++
 7 files changed, 8 insertions(+)

-- 
2.25.1

