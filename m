Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 542E9374A87
	for <lists+dmaengine@lfdr.de>; Wed,  5 May 2021 23:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234445AbhEEVka (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 5 May 2021 17:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234575AbhEEVkH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 5 May 2021 17:40:07 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF4DC061761
        for <dmaengine@vger.kernel.org>; Wed,  5 May 2021 14:39:09 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id m190so2855669pga.2
        for <dmaengine@vger.kernel.org>; Wed, 05 May 2021 14:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/siEfisWfBJM0n73hN/umrsNr10CV8eOAzqRCMOQV70=;
        b=tHz4qVImXJSw44ix7PkNJLpPXT9cB/ns98mZEirUEBuNj5aP/lzKoYOVppEePIm4Ey
         0iVsIJN1x8zO20EEl+V9sG/hgend/EOUoINR+qq5TEotIL5clwrVaNOx20zmghwPxzFf
         CBrYFvwYgnSo/fzvdkLVpsxReBsqRjAER66cSYuM8mOxwvcaC94h09FaQ8RT1ZSdG0jD
         eXKHneXHWOjkFTPcB0YAtFxvRANzfxEqUyDa5AIqA/anv9SBwiGhpLgAPu6/qoal3jMt
         m5m/uUXPiATtLObVA3c0dyfrmT9z20nprwEN5Mn7Zb53oyZsWfO4OFDgwCK10hoXrD+1
         O30Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/siEfisWfBJM0n73hN/umrsNr10CV8eOAzqRCMOQV70=;
        b=puzadosA/D+R4IEoYhi9xzeMAfr1p81wIC8mVJF3HQt1G1Hm+OlfdegF2E0k4lZE01
         zVvyBnnAJtoQST6iAWNMzoqbOXYy4sPd6hxFcOydanKxknK5fu4ZbsfXYdxRsfTF934x
         T8PCauNg5v3tBSplCzXKrkf6xozV+xKYDwKNF1WIrVXP76jjLmq2JJlDNP4/dubbl5Mw
         UXjLHzW8RkMkkxWAA//ZrLzBb7zivX0FGFkEpET/a/TVn1vv7Qw3LC1SlMap+hSid3Up
         4HMIbq5TiqAUKBR/Ou10QMUV/v3W3HmP0gQ664zcAFUc8K2rwFApW0ssUL/2Mb4eWUFO
         tNmQ==
X-Gm-Message-State: AOAM532IEtbnKB1CljVDBvTMygV5sdIUu5R3QDHQZr0OxE705DoR5JJW
        jfoJKJu268HoglntgeTf0OKTbQ==
X-Google-Smtp-Source: ABdhPJxx405bODF7L4idMIDItqAp6iCwVvXHGmuHWaLOHjAXU0qFlarx10b4GPxtSbwUE+1QqTFs+g==
X-Received: by 2002:aa7:860e:0:b029:28e:b4a9:297f with SMTP id p14-20020aa7860e0000b029028eb4a9297fmr994740pfn.46.1620250749520;
        Wed, 05 May 2021 14:39:09 -0700 (PDT)
Received: from localhost.localdomain.name ([223.235.141.68])
        by smtp.gmail.com with ESMTPSA id z26sm167031pfq.86.2021.05.05.14.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 14:39:09 -0700 (PDT)
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
Subject: [PATCH v2 11/17] crypto: qce: core: Make clocks optional
Date:   Thu,  6 May 2021 03:07:25 +0530
Message-Id: <20210505213731.538612-12-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210505213731.538612-1-bhupesh.sharma@linaro.org>
References: <20210505213731.538612-1-bhupesh.sharma@linaro.org>
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
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
[Make clock enablement optional only for qcom parts where
 firmware has already initialized them, using a bool variable]
Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 drivers/crypto/qce/core.c | 85 +++++++++++++++++++++++----------------
 drivers/crypto/qce/core.h |  2 +
 2 files changed, 53 insertions(+), 34 deletions(-)

diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
index f6032c303c8c..293d0bfe3aab 100644
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
@@ -184,12 +185,23 @@ static int qce_check_version(struct qce_device *qce)
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
 
+
 	qce = devm_kzalloc(dev, sizeof(*qce), GFP_KERNEL);
 	if (!qce)
 		return -ENOMEM;
@@ -209,39 +221,51 @@ static int qce_crypto_probe(struct platform_device *pdev)
 	if (IS_ERR(qce->mem_path))
 		return PTR_ERR(qce->mem_path);
 
-	qce->core = devm_clk_get(qce->dev, "core");
-	if (IS_ERR(qce->core)) {
-		ret = PTR_ERR(qce->core);
-		goto err_mem_path_put;
-	}
-
-	qce->iface = devm_clk_get(qce->dev, "iface");
-	if (IS_ERR(qce->iface)) {
-		ret = PTR_ERR(qce->iface);
-		goto err_mem_path_put;
-	}
-
-	qce->bus = devm_clk_get(qce->dev, "bus");
-	if (IS_ERR(qce->bus)) {
-		ret = PTR_ERR(qce->bus);
-		goto err_mem_path_put;
-	}
-
 	ret = icc_set_bw(qce->mem_path, QCE_DEFAULT_MEM_BANDWIDTH, QCE_DEFAULT_MEM_BANDWIDTH);
 	if (ret)
 		goto err_mem_path_put;
 
-	ret = clk_prepare_enable(qce->core);
-	if (ret)
-		goto err_mem_path_disable;
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
+			goto err_mem_path_put;
+		}
+
+		qce->iface = devm_clk_get(qce->dev, "iface");
+		if (IS_ERR(qce->iface)) {
+			ret = PTR_ERR(qce->iface);
+			goto err_mem_path_put;
+		}
+
+		qce->bus = devm_clk_get(qce->dev, "bus");
+		if (IS_ERR(qce->bus)) {
+			ret = PTR_ERR(qce->bus);
+			goto err_mem_path_put;
+		}
+
+		ret = clk_prepare_enable(qce->core);
+		if (ret)
+			goto err_mem_path_disable;
 
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
@@ -293,13 +317,6 @@ static int qce_crypto_remove(struct platform_device *pdev)
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
2.30.2

