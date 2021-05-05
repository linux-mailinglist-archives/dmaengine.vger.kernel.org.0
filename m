Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DC2E374A64
	for <lists+dmaengine@lfdr.de>; Wed,  5 May 2021 23:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234061AbhEEVji (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 5 May 2021 17:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233924AbhEEVje (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 5 May 2021 17:39:34 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0EEFC061763
        for <dmaengine@vger.kernel.org>; Wed,  5 May 2021 14:38:37 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id h11so3275885pfn.0
        for <dmaengine@vger.kernel.org>; Wed, 05 May 2021 14:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hn7TfYIdfqD0Oz8Zkvw4koFjDOZwR1ktbKdET4xonRI=;
        b=kg1P1d40yTtEG4b3W3pZCw8Z/F3EGVZYk24xAubD+8ctiTWheYqABJrrsBfj7b8QNC
         VLMdYpk/Xq2C+BmQjZZoV5XT+RYkwAnJ0DoGA7kTRFOdSNXPB9+N2BswsCHYzxmyvC1y
         iKVV9h5oh9MmQjOh9Qow75M3NqetBTOo7XvvITALJY3Gu4QBXVG/cuxvnQTFqYtdxRjr
         +LnMZDvo2ragoamp23py2/wnW/1gCtaW+DpgUGttqzDklozot8WODqF6lMjEFrF6rgo4
         nqsOtBrWDGy+6Qi7f/4Pv2kqBQpIn0I6ZwV1j8ifAyE/nAYjhwac3inN1P7Od66lpBma
         k9Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hn7TfYIdfqD0Oz8Zkvw4koFjDOZwR1ktbKdET4xonRI=;
        b=Q4yYF5PirJx23Vbae/hj8oTlvLwbJlrEFAtPuMJpzurYVxQWulJgnRVQLw7M+dbBs6
         JC2BgraLKysPbNtlaCE1RPeQwvDHWntH7Af0NKUvT2f0u+hmfMavFZjmKgCJmqtJF6QR
         3c5C8NGeOJ+xrSY9mmppUmVxNrFhJKpuReawx7FRSHvlpb8a476VqsXi6GiFri3KOpRu
         K9wjh5LiJ+bQq01qGJv+HchzERlo3F2UQnem5Q7Z+1J6Da/ZfqzyhI+uuGYZLgjVMEvC
         gASVK0BMQcnRaOmNBC4LZrSpkJAUPZ917ovXApiwOIAi6HizNKK+iY2OZSga0Pzu7+9Z
         SlOA==
X-Gm-Message-State: AOAM53319khTd/bXXxE9o0v0zBVLJ+FcGhUyGUCDA67jmhp+BJV/zmAb
        lm/SQG5kJhfnAHX0J7zrpnVyPQ==
X-Google-Smtp-Source: ABdhPJxkph90MEwZINVgDmvXeuVMnLzlhhibn3dL5GYQ3RA2vgrMKUt4MMM7ty3BO5rfnnZpSNin+w==
X-Received: by 2002:a63:4c55:: with SMTP id m21mr923423pgl.251.1620250717194;
        Wed, 05 May 2021 14:38:37 -0700 (PDT)
Received: from localhost.localdomain.name ([223.235.141.68])
        by smtp.gmail.com with ESMTPSA id z26sm167031pfq.86.2021.05.05.14.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 14:38:36 -0700 (PDT)
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
Subject: [PATCH v2 06/17] dt-bindings: crypto : Add new compatible strings for qcom-qce
Date:   Thu,  6 May 2021 03:07:20 +0530
Message-Id: <20210505213731.538612-7-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210505213731.538612-1-bhupesh.sharma@linaro.org>
References: <20210505213731.538612-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Newer qcom chips support newer versions of the qce crypto IP, so add
soc specific compatible strings for qcom-qce instead of using crypto
IP version specific ones.

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
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 Documentation/devicetree/bindings/crypto/qcom-qce.txt | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/crypto/qcom-qce.txt b/Documentation/devicetree/bindings/crypto/qcom-qce.txt
index 3f70cee1a491..814fe3c577fb 100644
--- a/Documentation/devicetree/bindings/crypto/qcom-qce.txt
+++ b/Documentation/devicetree/bindings/crypto/qcom-qce.txt
@@ -2,7 +2,12 @@ Qualcomm crypto engine driver
 
 Required properties:
 
-- compatible  : should be "qcom,crypto-v5.1"
+- compatible  : Supported versions are:
+		- "qcom,ipq6018-qce", for ipq6018
+		- "qcom,sdm845-qce", for sdm845
+		- "qcom,sm8150-qce", for sm8150
+		- "qcom,sm8250-qce", for sm8250
+		- "qcom,sm8350-qce", for sm8350
 - reg         : specifies base physical address and size of the registers map
 - dmas        : DMA specifiers for tx and rx dma channels. For more see
                 Documentation/devicetree/bindings/dma/dma.txt
-- 
2.30.2

