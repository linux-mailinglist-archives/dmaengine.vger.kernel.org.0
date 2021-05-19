Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6CB389170
	for <lists+dmaengine@lfdr.de>; Wed, 19 May 2021 16:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354436AbhESOkz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 19 May 2021 10:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354353AbhESOki (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 19 May 2021 10:40:38 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A092C061364
        for <dmaengine@vger.kernel.org>; Wed, 19 May 2021 07:38:46 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id g18so8376070pfr.2
        for <dmaengine@vger.kernel.org>; Wed, 19 May 2021 07:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TY0eJSU95uLiOCWXW1DYk1X5OH/Ime0PUPY+J48rkIg=;
        b=F3d7wUPyo9PBu8YRLs5cZJpSw17DtIczxMbxddaoCAbCm/qZ4eNqEJBlW6K3+/ftz5
         ZiQxmMWV1oyHOkPnF6TKxjKnTD7J2o6YaIRE5xNS9QkPLIQPr/dv3Ve5BszmenWPW20T
         RceTiqnNCAXyMMzU4ouqs/LQKpmWNFxB5dzWpjPejzxluBp2VRt+C3jLe5P5ng/CgR69
         bkVfRELgzDP2UHePljJD6dEDqykpHrLoN4k3IOrUziwzWwxdvDwr3x9Sf+xLKDH9XNWQ
         wOHzOSVN1GqoBoZ8oFgK7ifa67R2P3Abp+fHB/HVf7D0iHl8PSluEKU7wCSO6/kD+AIi
         DGvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TY0eJSU95uLiOCWXW1DYk1X5OH/Ime0PUPY+J48rkIg=;
        b=I3k1gMWt4xLmZr+o0owfj5qMxZrFP4CaEVdOKNbw57ugA1qkcV431+f7WlhvYWGhi9
         5f+EO29VoqDAVYC916ec+Xq0fLCANV0lpJhtvslAYa3ckscVPgIbOv9hlYqVcB26trtu
         7SnQ5pHVGrtHOzH2rWdHcekpImbWxdB+cU+eoH1XUHLyf/XDvr+je/XSf3TtFxq0/L90
         WUW1qD4gEr2aAAukp7PvgEsF0ptks5Jwf929Z6CKBzcm2HPrUrveB5t9jZeT4aQh0iMA
         QI5IgbZ0Mw7KBM7c7Y+kfwVWFYuCvNB8bKpJJBeomzerTfwsW7YN+bz9v/vCh3I5J398
         x7QQ==
X-Gm-Message-State: AOAM532OW+hES+e1d6qGOaTzR82qHHKP4McflCy8tQzjURIwoR/QJOMh
        XmFdSJnuts5Nx6u/vVALb+9MRrYQl5qtLA==
X-Google-Smtp-Source: ABdhPJyHx1wCzN9J3+OQs1nCUtaRmTRkPnFBIJdgGQJ4sMPEBbrS3fiqDdhkUvjCmLlBm8BwCupgfQ==
X-Received: by 2002:a62:7c12:0:b029:2d9:a70:2b9c with SMTP id x18-20020a627c120000b02902d90a702b9cmr11182474pfc.22.1621435125887;
        Wed, 19 May 2021 07:38:45 -0700 (PDT)
Received: from localhost.localdomain.name ([122.177.135.250])
        by smtp.gmail.com with ESMTPSA id o24sm9239515pgl.55.2021.05.19.07.38.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 07:38:45 -0700 (PDT)
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
Subject: [PATCH v3 12/17] crypto: qce: Add new compatibles for qce crypto driver
Date:   Wed, 19 May 2021 20:06:55 +0530
Message-Id: <20210519143700.27392-13-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210519143700.27392-1-bhupesh.sharma@linaro.org>
References: <20210519143700.27392-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Since we decided to use soc specific compatibles for describing
the qce crypto IP nodes in the device-trees, adapt the driver
now to handle the same.

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
 drivers/crypto/qce/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
index 89a17b677607..905378906ac7 100644
--- a/drivers/crypto/qce/core.c
+++ b/drivers/crypto/qce/core.c
@@ -285,8 +285,8 @@ static int qce_crypto_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id qce_crypto_of_match[] = {
-	{ .compatible = "qcom,crypto-v5.1", },
-	{ .compatible = "qcom,crypto-v5.4", },
+	{ .compatible = "qcom,ipq6018-qce", },
+	{ .compatible = "qcom,sdm845-qce", },
 	{}
 };
 MODULE_DEVICE_TABLE(of, qce_crypto_of_match);
-- 
2.31.1

