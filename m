Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB61374A7B
	for <lists+dmaengine@lfdr.de>; Wed,  5 May 2021 23:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234393AbhEEVjz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 5 May 2021 17:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234275AbhEEVjx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 5 May 2021 17:39:53 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3EEAC061763
        for <dmaengine@vger.kernel.org>; Wed,  5 May 2021 14:38:56 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id lj11-20020a17090b344bb029015bc3073608so1740400pjb.3
        for <dmaengine@vger.kernel.org>; Wed, 05 May 2021 14:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EiBQGXYFrfCnZUi3Qrj72wva/FJNobB/Gmt17VjquqY=;
        b=MWoU747xjoIPLLFuMd9w7vEB7A2x9fDTPO4vH7gdS640PAUoRBjxYrI43DAZXvgfyi
         NNftfA4WsfW4ch21kfISSrmHuZUsmU7Z9fWVVQWu8Wy0VqRLu11SD5Vgv3tJYLYndAQb
         k3hvxfX1eZci72giEqdTfhGI2Nsk6EcpKzOAKgBvGi01pb0NlcNIGTyTl5QLrCfoZRuv
         sYaaT72JeTVA3RBwqdqPYFgWe9wtwCUWNBdKEba5R2badAAId53SkIpdK2Yll4S5TPOr
         owXBfD1Y/1Sv6QSHYsD7q0ZW4DfmZ7y/JZ/8GRbJpddSKxzFGvHri8EC9gaySeC7vVCA
         OtzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EiBQGXYFrfCnZUi3Qrj72wva/FJNobB/Gmt17VjquqY=;
        b=kIvnJQk0DiJYl9BjLxgd2HfQbXXtmQjNiGcEditsPaQZcIiCd/dqDbGQnYAdWM5Fzg
         x08VWXJEvzEj/g7p3uGu77PeTey7HGz7zLHzvWbUu9Ve1InKuafacX8F70+P3EToPeI2
         Qvmjv6qQe5g9jpRzET7MX3aNdZQAYcpVN9PUgz6wBFtHDMMQ9Vh8Q0Sx96a20XctPGRt
         zptdFudzZizzq9jYtWWdZz+0JCwq/Pyi4KGf1g4Yk03TotZYr2aqly4NZYJ8NX8Ykh0C
         g7OE3dGwv0Mw+PXVc9VLr0+onECD7Mb44lo8ohhUbDGJwV5cRVcsG1hwbn2E0OHTwvUO
         eCLQ==
X-Gm-Message-State: AOAM532Do38FNKny4aIlIE6pqkBG/JrFO/BjiTz8YsjcWvKS6zTho8ts
        8FYVESz8VjxgeSXO33Rnn1ZCrQ==
X-Google-Smtp-Source: ABdhPJxd7I2r5weGX9L8Q7n4b1OwKzK7MlzICqi26e47BNvQrhKnDo3cuWTD/D8JUjI9ugvHgAfnUg==
X-Received: by 2002:a17:90a:3e0f:: with SMTP id j15mr736891pjc.70.1620250736310;
        Wed, 05 May 2021 14:38:56 -0700 (PDT)
Received: from localhost.localdomain.name ([223.235.141.68])
        by smtp.gmail.com with ESMTPSA id z26sm167031pfq.86.2021.05.05.14.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 14:38:55 -0700 (PDT)
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
Subject: [PATCH v2 09/17] crypto: qce: core: Add support to initialize interconnect path
Date:   Thu,  6 May 2021 03:07:23 +0530
Message-Id: <20210505213731.538612-10-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210505213731.538612-1-bhupesh.sharma@linaro.org>
References: <20210505213731.538612-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Thara Gopinath <thara.gopinath@linaro.org>

Crypto engine on certain Snapdragon processors like sm8150, sm8250, sm8350
etc. requires interconnect path between the engine and memory to be
explicitly enabled and bandwidth set prior to any operations. Add support
in the qce core to enable the interconnect path appropriately.

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
[Make header file inclusion alphabetical]
Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 drivers/crypto/qce/core.c | 35 ++++++++++++++++++++++++++++-------
 drivers/crypto/qce/core.h |  1 +
 2 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
index 80b75085c265..92a0ff1d357e 100644
--- a/drivers/crypto/qce/core.c
+++ b/drivers/crypto/qce/core.c
@@ -5,6 +5,7 @@
 
 #include <linux/clk.h>
 #include <linux/dma-mapping.h>
+#include <linux/interconnect.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
@@ -21,6 +22,8 @@
 #define QCE_MAJOR_VERSION5	0x05
 #define QCE_QUEUE_LENGTH	1
 
+#define QCE_DEFAULT_MEM_BANDWIDTH	393600
+
 static const struct qce_algo_ops *qce_ops[] = {
 #ifdef CONFIG_CRYPTO_DEV_QCE_SKCIPHER
 	&skcipher_ops,
@@ -202,21 +205,35 @@ static int qce_crypto_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
+	qce->mem_path = of_icc_get(qce->dev, "memory");
+	if (IS_ERR(qce->mem_path))
+		return PTR_ERR(qce->mem_path);
+
 	qce->core = devm_clk_get(qce->dev, "core");
-	if (IS_ERR(qce->core))
-		return PTR_ERR(qce->core);
+	if (IS_ERR(qce->core)) {
+		ret = PTR_ERR(qce->core);
+		goto err_mem_path_put;
+	}
 
 	qce->iface = devm_clk_get(qce->dev, "iface");
-	if (IS_ERR(qce->iface))
-		return PTR_ERR(qce->iface);
+	if (IS_ERR(qce->iface)) {
+		ret = PTR_ERR(qce->iface);
+		goto err_mem_path_put;
+	}
 
 	qce->bus = devm_clk_get(qce->dev, "bus");
-	if (IS_ERR(qce->bus))
-		return PTR_ERR(qce->bus);
+	if (IS_ERR(qce->bus)) {
+		ret = PTR_ERR(qce->bus);
+		goto err_mem_path_put;
+	}
+
+	ret = icc_set_bw(qce->mem_path, QCE_DEFAULT_MEM_BANDWIDTH, QCE_DEFAULT_MEM_BANDWIDTH);
+	if (ret)
+		goto err_mem_path_put;
 
 	ret = clk_prepare_enable(qce->core);
 	if (ret)
-		return ret;
+		goto err_mem_path_disable;
 
 	ret = clk_prepare_enable(qce->iface);
 	if (ret)
@@ -256,6 +273,10 @@ static int qce_crypto_probe(struct platform_device *pdev)
 	clk_disable_unprepare(qce->iface);
 err_clks_core:
 	clk_disable_unprepare(qce->core);
+err_mem_path_disable:
+	icc_set_bw(qce->mem_path, 0, 0);
+err_mem_path_put:
+	icc_put(qce->mem_path);
 	return ret;
 }
 
diff --git a/drivers/crypto/qce/core.h b/drivers/crypto/qce/core.h
index 085774cdf641..228fcd69ec51 100644
--- a/drivers/crypto/qce/core.h
+++ b/drivers/crypto/qce/core.h
@@ -35,6 +35,7 @@ struct qce_device {
 	void __iomem *base;
 	struct device *dev;
 	struct clk *core, *iface, *bus;
+	struct icc_path *mem_path;
 	struct qce_dma_data dma;
 	int burst_size;
 	unsigned int pipe_pair_id;
-- 
2.30.2

