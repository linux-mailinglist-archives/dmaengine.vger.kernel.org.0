Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 452D3389125
	for <lists+dmaengine@lfdr.de>; Wed, 19 May 2021 16:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348231AbhESOip (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 19 May 2021 10:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348095AbhESOio (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 19 May 2021 10:38:44 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D819C0613CE
        for <dmaengine@vger.kernel.org>; Wed, 19 May 2021 07:37:24 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id t21so7156647plo.2
        for <dmaengine@vger.kernel.org>; Wed, 19 May 2021 07:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nZMq8xWSXZHjYFFX9U2EDQv78qoTWHbTqwBMbdQQv0s=;
        b=lVsbFM6aeHV9QO0yMWIoUEsFvuZICTWzjhH06XiLX53vIJd5fOltlBQU1AsHgkhC7b
         GU7k6gSGN0lQBG7GaWR3AXAnUcQMwsq433ErObGTb6pDseELCOfit4GmF45i6IK022NF
         M+m7ctX0SDRhPS+HjsgbUljOhedYqSDTR0Pi7DN1iY821hWBTzJRccUOL7JfRceTEhVm
         WiUIbNY+lmeBWXgJiDm5Bwzu0VW1qgp0cDMdjjim4TeuzJzCwjGTtf4WhgkqrvH6NwRG
         gT/bcRL0+NO+q5WxqSE5QH4O5aVBTDe0mV1ytUVtiFZLkjVcha+EmZ/cETYMz3SYJzbG
         gh5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nZMq8xWSXZHjYFFX9U2EDQv78qoTWHbTqwBMbdQQv0s=;
        b=tq9Fnj+8yNwsQ8pYs5Sfgn8/AfSELHrTnIm7SOqLExV/eWaoD38dibeF30siPB/swM
         d731nQVODCjqcqEGkpPhlh+l6bxZvZWsZnlBM7vO3P1fOoTLkbF1HtArfTnAIwD8ycse
         9vXiLfQaaekn++0g1wRocYvYC0+DzKkIsQJJMX2rv2K6opu4o5wPCLZ+7pYfK1t+AOUv
         8S55EsPoV6Lw/wTTXz++zcmlQh6yiZqGEJJ8NRPXTXJdmxuXqGj2htpyK1TqOJhzFqKl
         BhVoW2BVlidThcdKyMMp/PYZzMj6PrAUMcqELj1wNbHPWYyPUtU8Hm7MGZKKb/hYoRyA
         vIhw==
X-Gm-Message-State: AOAM532bkgunO4wCaE82DMUD1zsPxsIsvofWi8AGPyBoshsr4RuXQYve
        /Jdmq8UfIFN07+00+tYjpvfhSg==
X-Google-Smtp-Source: ABdhPJx1AAoohm3tZC2APaKhDLsi3QklihlNmlo84V+Pzp/Q+nnZSaKyM1DsUUTiJWfa4t751iNqNg==
X-Received: by 2002:a17:90a:f87:: with SMTP id 7mr12090307pjz.38.1621435043946;
        Wed, 19 May 2021 07:37:23 -0700 (PDT)
Received: from localhost.localdomain.name ([122.177.135.250])
        by smtp.gmail.com with ESMTPSA id o24sm9239515pgl.55.2021.05.19.07.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 07:37:23 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhupesh.linux@gmail.com
Subject: [PATCH v3 00/17] Enable Qualcomm Crypto Engine on sm8250
Date:   Wed, 19 May 2021 20:06:43 +0530
Message-Id: <20210519143700.27392-1-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Changes since v2:
=================
- v2 can be seen here: https://lore.kernel.org/dmaengine/20210505213731.538612-1-bhupesh.sharma@linaro.org/
- Drop a couple of patches from v1, which tried to address the defered
  probing of qce driver in case bam dma driver is not yet probed.
  Replace it instead with a single (simpler) patch [PATCH 16/17].
- Convert bam dma and qce crypto dt-bindings to YAML.
- Addressed review comments from Thara, Bjorn, Vinod and Rob.

Changes since v1:
=================
- v1 can be seen here: https://lore.kernel.org/linux-arm-msm/20210310052503.3618486-1-bhupesh.sharma@linaro.org/ 
- v1 did not work well as reported earlier by Dmitry, so v2 contains the following
  changes/fixes:
  ~ Enable the interconnect path b/w BAM DMA and main memory first
    before trying to access the BAM DMA registers.
  ~ Enable the interconnect path b/w qce crytpo and main memory first
    before trying to access the qce crypto registers.
  ~ Make sure to document the required and optional properties for both
    BAM DMA and qce crypto drivers.
  ~ Add a few debug related print messages in case the qce crypto driver
    passes or fails to probe.
  ~ Convert the qce crypto driver probe to a defered one in case the BAM DMA
    or the interconnect driver(s) (needed on specific Qualcomm parts) are not
    yet probed.

Qualcomm crypto engine is also available on sm8250 SoC.
It supports hardware accelerated algorithms for encryption
and authentication. It also provides support for aes, des, 3des
encryption algorithms and sha1, sha256, hmac(sha1), hmac(sha256)
authentication algorithms.

Tested the enabled crypto algorithms with cryptsetup test utilities
on sm8250-mtp and RB5 board (see [1]) and also with crypto self-tests,
including the fuzz tests (CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y).

While at it, also make a minor fix in 'sdm845.dtsi', to make
sure it confirms with the other .dtsi files which expose
crypto nodes on qcom SoCs.

Note that this series is rebased on AEAD fixes from Thara (see [2]).
This is required for all of the fuzz tests to work.

[1]. https://linux.die.net/man/8/cryptsetup
[2]. https://lore.kernel.org/linux-crypto/20210429150707.3168383-5-thara.gopinath@linaro.org/T/

Cc: Thara Gopinath <thara.gopinath@linaro.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Andy Gross <agross@kernel.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: David S. Miller <davem@davemloft.net>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org
Cc: linux-clk@vger.kernel.org
Cc: linux-crypto@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: bhupesh.linux@gmail.com
 
Bhupesh Sharma (14):
  dt-bindings: qcom-bam: Convert binding to YAML
  dt-bindings: qcom-bam: Add 'interconnects' & 'interconnect-names' to
    optional properties
  dt-bindings: qcom-bam: Add 'iommus' to required properties
  dt-bindings: qcom-qce: Convert bindings to yaml
  dt-bindings: qcom-qce: Add 'interconnects' and move 'clocks' to
    optional properties
  dt-bindings: qcom-qce: Add 'iommus' to required properties
  arm64/dts: qcom: sdm845: Use RPMH_CE_CLK macro directly
  dt-bindings: crypto : Add new compatible strings for qcom-qce
  arm64/dts: qcom: Use new compatibles for crypto nodes
  crypto: qce: Add new compatibles for qce crypto driver
  crypto: qce: Print a failure msg in case probe() fails
  crypto: qce: Convert the device found dev_dbg() to dev_info()
  crypto: qce: Defer probing if BAM dma channel is not yet initialized
  arm64/dts: qcom: sm8250: Add dt entries to support crypto engine.

Thara Gopinath (3):
  dma: qcom: bam_dma: Add support to initialize interconnect path
  crypto: qce: core: Add support to initialize interconnect path
  crypto: qce: core: Make clocks optional

 .../devicetree/bindings/crypto/qcom-qce.txt   |  25 ----
 .../devicetree/bindings/crypto/qcom-qce.yaml  |  92 +++++++++++++++
 .../devicetree/bindings/dma/qcom_bam_dma.txt  |  50 --------
 .../devicetree/bindings/dma/qcom_bam_dma.yaml | 110 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/ipq6018.dtsi         |   2 +-
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |   6 +-
 arch/arm64/boot/dts/qcom/sm8250.dtsi          |  28 +++++
 drivers/crypto/qce/core.c                     | 110 ++++++++++++------
 drivers/crypto/qce/core.h                     |   3 +
 drivers/dma/qcom/bam_dma.c                    |  10 ++
 10 files changed, 322 insertions(+), 114 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/crypto/qcom-qce.txt
 create mode 100644 Documentation/devicetree/bindings/crypto/qcom-qce.yaml
 delete mode 100644 Documentation/devicetree/bindings/dma/qcom_bam_dma.txt
 create mode 100644 Documentation/devicetree/bindings/dma/qcom_bam_dma.yaml

-- 
2.31.1

