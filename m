Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDA0389175
	for <lists+dmaengine@lfdr.de>; Wed, 19 May 2021 16:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354481AbhESOlD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 19 May 2021 10:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354419AbhESOkj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 19 May 2021 10:40:39 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A48C061375
        for <dmaengine@vger.kernel.org>; Wed, 19 May 2021 07:38:52 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id j12so9599590pgh.7
        for <dmaengine@vger.kernel.org>; Wed, 19 May 2021 07:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JavEPRsMYE4L6ZTfv8wl3bF4qxOU1C90z+usn5HEmMo=;
        b=xwg/XZVIeX9loT5uM6hOfsTSscaHquFpNwOmBr8Im9I+3qO0TD/wuvwHRGbQw0kgl6
         J7COAjlgkwCLQDuypAcYT97xwBxkjRu6cxEkELc4lNI/AfkfaOq1xcjVFmnsTnXkXxtk
         pL4lZLmXy7yYBJwn3mRyIn6jXulgSA0YuZYuw6L7QKlSgSE2yn339xkT2rSf7cnvnjJ2
         /sxIJYTnA8vBfWM4tDEKLqnDi2rZFnktsCb6phxa7eKd6lEZmj9T4rAwOaa6LyXd1jo1
         B8yywUFudUiepQhMQyh3eZ0D+tqV+6t/sGNEfKLRKkDNlW3Pz2O4tibzGFHR/8blgUDn
         HzRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JavEPRsMYE4L6ZTfv8wl3bF4qxOU1C90z+usn5HEmMo=;
        b=ovIjDh4vg6DzOptUDz2oxSk1Zmk18qiq9grq//16ZkpPa1lRVKdDRgouMaDv6zvFgX
         L4VJsvZz4HgLrJy6MazHVUqG1ET4AglGVjftaKO2zez27nadXUQbnxrvoq9T3Hg+yz7u
         fcToJVf0enm+FrozwGTXMkYunDbDV3dAwJx3rPPtDwctnoF+PkBcJCotdduQ3MEVxQSu
         Rr4kmI2oKdILp3/KaoMY5iLjRN22gBSr0OD6F86PQvBBkNc8uRQDinXZXkyU7AJncdL7
         +BaFOqG93wVng57rMS8LXOpIpKZWRJSemyLdHmXYeU2tOd+DqPqBKh26ixOcK+V9ycXa
         0BMw==
X-Gm-Message-State: AOAM532r/3v8JSoyGigUcsI3c068rAL58svVFMWtRkO+F6mxHFZNlXFm
        Z8+i/UaECJl5S5BsOucyOVkbvQ==
X-Google-Smtp-Source: ABdhPJyY1iJJAF8rgiwIQMpBkw86Ji/0s3ys/j14wWlns+SE4zL+9JZpHi3g+5k5QSpYhv/sntG1TA==
X-Received: by 2002:aa7:8198:0:b029:274:8a92:51b5 with SMTP id g24-20020aa781980000b02902748a9251b5mr11031935pfi.5.1621435132367;
        Wed, 19 May 2021 07:38:52 -0700 (PDT)
Received: from localhost.localdomain.name ([122.177.135.250])
        by smtp.gmail.com with ESMTPSA id o24sm9239515pgl.55.2021.05.19.07.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 07:38:52 -0700 (PDT)
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
Subject: [PATCH v3 13/17] crypto: qce: core: Make clocks optional
Date:   Wed, 19 May 2021 20:06:56 +0530
Message-Id: <20210519143700.27392-14-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210519143700.27392-1-bhupesh.sharma@linaro.org>
References: <20210519143700.27392-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Thara Gopinath <thara.gopinath@linaro.org>

On certain Snapdragon processors, the crypto engine clocks are enabled by
default by security firmware and the driver need not handle the
clocks. Make acquiring of all the clocks optional in crypto enginer driver
so that the driver intializes properly even if no clocks are specified in
the dt.

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
Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
[ bhupesh.sharma@linaro.org: Make clock enablement optional only for qcom parts where
  firmware has already initialized them, using a bool variable and fix
  error paths ]
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 drivers/crypto/qce/core.c | 89 +++++++++++++++++++++++++--------------
 drivers/crypto/qce/core.h |  2 +
 2 files changed, 59 insertions(+), 32 deletions(-)

diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
index 905378906ac7..8c3c68ba579e 100644
--- a/drivers/crypto/qce/core.c
+++ b/drivers/crypto/qce/core.c
@@ -9,6 +9,7 @@
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/spinlock.h>
 #include <linux/types.h>
@@ -184,10 +185,20 @@ static int qce_check_version(struct qce_device *qce)
 	return 0;
 }
 
+static const struct of_device_id qce_crypto_of_match[] = {
+	{ .compatible = "qcom,ipq6018-qce", },
+	{ .compatible = "qcom,sdm845-qce", },
+	{ .compatible = "qcom,sm8250-qce", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, qce_crypto_of_match);
+
 static int qce_crypto_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct qce_device *qce;
+	const struct of_device_id *of_id =
+			of_match_device(qce_crypto_of_match, &pdev->dev);
 	int ret;
 
 	qce = devm_kzalloc(dev, sizeof(*qce), GFP_KERNEL);
@@ -198,45 +209,65 @@ static int qce_crypto_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, qce);
 
 	qce->base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(qce->base))
-		return PTR_ERR(qce->base);
+	if (IS_ERR(qce->base)) {
+		ret = PTR_ERR(qce->base);
+		goto err_out;
+	}
 
 	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
 	if (ret < 0)
-		return ret;
+		goto err_out;
 
 	qce->mem_path = devm_of_icc_get(qce->dev, "memory");
 	if (IS_ERR(qce->mem_path))
 		return dev_err_probe(dev, PTR_ERR(qce->mem_path),
 				     "Failed to get mem path\n");
 
-	qce->core = devm_clk_get(qce->dev, "core");
-	if (IS_ERR(qce->core))
-		return PTR_ERR(qce->core);
-
-	qce->iface = devm_clk_get(qce->dev, "iface");
-	if (IS_ERR(qce->iface))
-		return PTR_ERR(qce->iface);
-
-	qce->bus = devm_clk_get(qce->dev, "bus");
-	if (IS_ERR(qce->bus))
-		return PTR_ERR(qce->bus);
-
 	ret = icc_set_bw(qce->mem_path, QCE_DEFAULT_MEM_BANDWIDTH, QCE_DEFAULT_MEM_BANDWIDTH);
 	if (ret)
-		return ret;
+		goto err_out;
 
-	ret = clk_prepare_enable(qce->core);
-	if (ret)
-		return ret;
+	/* On some qcom parts the crypto clocks are already configured by
+	 * the firmware running before linux. In such cases we don't need to
+	 * enable/configure them again. Check here for the same.
+	 */
+	if (!strcmp(of_id->compatible, "qcom,ipq6018-qce") ||
+	    !strcmp(of_id->compatible, "qcom,sdm845-qce"))
+		qce->clks_configured_by_fw = false;
+	else
+		qce->clks_configured_by_fw = true;
+
+	if (!qce->clks_configured_by_fw) {
+		qce->core = devm_clk_get(qce->dev, "core");
+		if (IS_ERR(qce->core)) {
+			ret = PTR_ERR(qce->core);
+			goto err_out;
+		}
+
+		qce->iface = devm_clk_get(qce->dev, "iface");
+		if (IS_ERR(qce->iface)) {
+			ret = PTR_ERR(qce->iface);
+			goto err_out;
+		}
+
+		qce->bus = devm_clk_get(qce->dev, "bus");
+		if (IS_ERR(qce->bus)) {
+			ret = PTR_ERR(qce->bus);
+			goto err_out;
+		}
+
+		ret = clk_prepare_enable(qce->core);
+		if (ret)
+			goto err_out;
 
-	ret = clk_prepare_enable(qce->iface);
-	if (ret)
-		goto err_clks_core;
+		ret = clk_prepare_enable(qce->iface);
+		if (ret)
+			goto err_clks_core;
 
-	ret = clk_prepare_enable(qce->bus);
-	if (ret)
-		goto err_clks_iface;
+		ret = clk_prepare_enable(qce->bus);
+		if (ret)
+			goto err_clks_iface;
+	}
 
 	ret = qce_dma_request(qce->dev, &qce->dma);
 	if (ret)
@@ -268,6 +299,7 @@ static int qce_crypto_probe(struct platform_device *pdev)
 	clk_disable_unprepare(qce->iface);
 err_clks_core:
 	clk_disable_unprepare(qce->core);
+err_out:
 	return ret;
 }
 
@@ -284,13 +316,6 @@ static int qce_crypto_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id qce_crypto_of_match[] = {
-	{ .compatible = "qcom,ipq6018-qce", },
-	{ .compatible = "qcom,sdm845-qce", },
-	{}
-};
-MODULE_DEVICE_TABLE(of, qce_crypto_of_match);
-
 static struct platform_driver qce_crypto_driver = {
 	.probe = qce_crypto_probe,
 	.remove = qce_crypto_remove,
diff --git a/drivers/crypto/qce/core.h b/drivers/crypto/qce/core.h
index 228fcd69ec51..d9bf05babecc 100644
--- a/drivers/crypto/qce/core.h
+++ b/drivers/crypto/qce/core.h
@@ -23,6 +23,7 @@
  * @dma: pointer to dma data
  * @burst_size: the crypto burst size
  * @pipe_pair_id: which pipe pair id the device using
+ * @clks_configured_by_fw: clocks are already configured by fw
  * @async_req_enqueue: invoked by every algorithm to enqueue a request
  * @async_req_done: invoked by every algorithm to finish its request
  */
@@ -39,6 +40,7 @@ struct qce_device {
 	struct qce_dma_data dma;
 	int burst_size;
 	unsigned int pipe_pair_id;
+	bool clks_configured_by_fw;
 	int (*async_req_enqueue)(struct qce_device *qce,
 				 struct crypto_async_request *req);
 	void (*async_req_done)(struct qce_device *qce, int ret);
-- 
2.31.1

