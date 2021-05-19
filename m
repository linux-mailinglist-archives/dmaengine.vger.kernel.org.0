Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8FB5389165
	for <lists+dmaengine@lfdr.de>; Wed, 19 May 2021 16:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354290AbhESOkk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 19 May 2021 10:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354421AbhESOk3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 19 May 2021 10:40:29 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878A7C061358
        for <dmaengine@vger.kernel.org>; Wed, 19 May 2021 07:38:39 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id f22so1672155pfn.0
        for <dmaengine@vger.kernel.org>; Wed, 19 May 2021 07:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PDydCz783kyI7jNgitJR8zCb8Ar4M6klN2ivXhhgevM=;
        b=xDVjMuiRG+d9R+s0Ow2ozpu7fxVX8osnVwDuOOGFE6+KOKHFHn80dJ9O3D/srtj9tt
         Y/vxjISnx0tJWa46kTz2RgQbTunHkYtgCOiDdooJcqG/Q/c7g5gQqBiS6ceFRW+8o4rh
         Mzw2j7C3UZe6KTz4lUHFZ0yAOVBJC8ZuQyZ2gHQSeA8LEF9yzG9j1HkAi0cXi107FefI
         V9TXvX9DscVK1U5isYPGdkNacJdfNLP3xW3ASNpH//ZSsPaAgtolhsx7PMH/OhhRLaaE
         +ZkkWCNz6A6syvJcrCVwXx1iOQuXSNiuue/fdXBKW6PfmFKMZmjmX7gR9VcTceeGNz/b
         vqmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PDydCz783kyI7jNgitJR8zCb8Ar4M6klN2ivXhhgevM=;
        b=XGTSBgeIZWaOyYXylg2Ro0aocL637/JUwUTRgVHbAX9DvM9A1284mdZZNzgx3BF1Zn
         4Yqv5bBC5S2TZ3/czddQ4q6gLQXXaaAmuASgMDlbfaeq9b0LVnbK+lZk0aVzX4zd9VYk
         W6wS8DrYleUyYiCnsVoYvpFpu9FvWaOw9QuVNKwB5ZIoojz8K90wGepR1wnmj/6Ah65n
         FLDIbu2Q8zwrG41ZoqD9YDZ4DMU0ZoZaHp//hPqRvscf3LlpEeiiAsapjumxUVcjDMB6
         yTiC/Lc4LnNgmpuZmNOEFLguDY9mnRRS6u3yBHcEJPGT81VjIPr3tC/IhqjSxNZWr7A0
         Hj4w==
X-Gm-Message-State: AOAM5313jdlEkEdlcCXPQqST9xV4g14eKjnIFKaook3EcRyYRoujFYgn
        9hd/RxAnzbgw1FpU8PkcD75ETQ==
X-Google-Smtp-Source: ABdhPJzi8Amq8flun5ibZBTC1dsU+cOEzeRB7P2E+0T3I4Y6DU5ElvMH2rUatAGvb+DKw7pP2K0KKA==
X-Received: by 2002:aa7:8809:0:b029:2de:3b94:487e with SMTP id c9-20020aa788090000b02902de3b94487emr9467646pfo.33.1621435119088;
        Wed, 19 May 2021 07:38:39 -0700 (PDT)
Received: from localhost.localdomain.name ([122.177.135.250])
        by smtp.gmail.com with ESMTPSA id o24sm9239515pgl.55.2021.05.19.07.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 07:38:38 -0700 (PDT)
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
Subject: [PATCH v3 11/17] crypto: qce: core: Add support to initialize interconnect path
Date:   Wed, 19 May 2021 20:06:54 +0530
Message-Id: <20210519143700.27392-12-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210519143700.27392-1-bhupesh.sharma@linaro.org>
References: <20210519143700.27392-1-bhupesh.sharma@linaro.org>
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
Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
[ bhupesh.sharma@linaro.org: Make header file inclusion alphabetical and use devm_of_icc_get() ]
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 drivers/crypto/qce/core.c | 12 ++++++++++++
 drivers/crypto/qce/core.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
index 80b75085c265..89a17b677607 100644
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
@@ -202,6 +205,11 @@ static int qce_crypto_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
+	qce->mem_path = devm_of_icc_get(qce->dev, "memory");
+	if (IS_ERR(qce->mem_path))
+		return dev_err_probe(dev, PTR_ERR(qce->mem_path),
+				     "Failed to get mem path\n");
+
 	qce->core = devm_clk_get(qce->dev, "core");
 	if (IS_ERR(qce->core))
 		return PTR_ERR(qce->core);
@@ -214,6 +222,10 @@ static int qce_crypto_probe(struct platform_device *pdev)
 	if (IS_ERR(qce->bus))
 		return PTR_ERR(qce->bus);
 
+	ret = icc_set_bw(qce->mem_path, QCE_DEFAULT_MEM_BANDWIDTH, QCE_DEFAULT_MEM_BANDWIDTH);
+	if (ret)
+		return ret;
+
 	ret = clk_prepare_enable(qce->core);
 	if (ret)
 		return ret;
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
2.31.1

