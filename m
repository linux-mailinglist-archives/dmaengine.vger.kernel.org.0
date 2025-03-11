Return-Path: <dmaengine+bounces-4699-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 694F2A5BC34
	for <lists+dmaengine@lfdr.de>; Tue, 11 Mar 2025 10:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E6E2174421
	for <lists+dmaengine@lfdr.de>; Tue, 11 Mar 2025 09:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A172376E7;
	Tue, 11 Mar 2025 09:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Sz273Ldv"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7F32356D4
	for <dmaengine@vger.kernel.org>; Tue, 11 Mar 2025 09:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741685156; cv=none; b=jGBpWnWC48/SphNjLkn/rIqTdzG7Oa3M/D56M06xwdqWK+dXiaSMgLF/g5gWCPa6Eyy/Gro0Mpfxd3e+tMIyvCxj0l1Q2cnf+2hW9XMDwk1idi1+ZtuvhwUwo05tCbjlwRMTwjwdWoHz8UqlHhXTY6HLTru36LM+1pSGdzsbOgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741685156; c=relaxed/simple;
	bh=cK1k4sh2qG8eQn/caRKPL/VXSlWxPvIeIglcX9PU3Kc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aqd+rS92nKC1/g3+MnXfmshuAKRJiFuWvXZ9Sx0ohpJXHAcvpcxQvtqI0Ob1SsxdBBgghzsml2q6VOKL48YuorPBwBhymCuSwBWultWJEnPddatX5kHX4FbW20RQTNiS4rbVYyrD7pqDCZs0l4TR4NGLIeFLC3rGARlQMY898EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Sz273Ldv; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cf3192f3bso20395795e9.1
        for <dmaengine@vger.kernel.org>; Tue, 11 Mar 2025 02:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1741685152; x=1742289952; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DFzjrdJVdhcaqoN3b3hO0MWmJrj0YtyTO+Uc8+EDm/4=;
        b=Sz273Ldv2kzVVir/fnhubiqJlHNmMnpV8p2zVPCGMCtMNY227BT7jWQR2biFqsFila
         jGu4jzoVrMqKoVih+okHLrxW9OUAZUrNMTUlkTrWR2bN92gk0qHQzogU1Tbyl/PfhWjP
         5ALANSXJE+KH2TZhfpsAMY2b2FcHU+wA38/4E40IF6cax6XoKUS0FbjHPEqPclBPbU3W
         Bz+BoJHFhCjnidqy6sr1sYPTGYP/dSwwKtmarcpy3engX/Gp4C6ks93b04X+hyOhow+C
         bdJ7SjPbRnT1muLB8YTnan7+UQn6QAXvjx+8wwe3AbI+m67UHwRm+CesuzS5Wlf3OUc/
         tjEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741685152; x=1742289952;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DFzjrdJVdhcaqoN3b3hO0MWmJrj0YtyTO+Uc8+EDm/4=;
        b=KONaxwb+lmlnyhJiz7whQ7m1yYMiB4gWkT9AXAQi3TIIVyKgKEY2UCT7YHP8i73nkB
         7PeJagyqeJP0bYZspfa/Br+GKoaDkVp7kkoJRdsOJYu5rBR4sKzcErZHbQ1zuhOA7PJs
         0Whzdioxv1/zc5wa1mc7I6pIh1CWCuJDp8hEq8oi88mmImcuEmtm5ye0YHwi06ri+p9z
         nQ+Iz4EymzAnYc9/sJBAfqt2+2AzE2B+jSZLdayXCAEHwN1BSQiRtwFlbqj4oMqQV4+f
         uwH9zyBUACrkok8y8DNj8fBuS9KSdmTvhDhzlfohWZZX8mj8K9iIwBey571qoKox+OSI
         HKAg==
X-Forwarded-Encrypted: i=1; AJvYcCX7upOQ8LYzClqZewH+foBahJyBC9n8UtxjdUTvRqmXUVPUDz0EqtRP6cpTUjDAmpwM7Q8m2AW9YMw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+8Zy69tQemeyiZih8hgCi1a/gAk8lwY3Jnzi4Q9l5MB0PZg1F
	x42q079gt5ZYSmDEzxDAK4TA0jmmCjAu2cLVyFb4+U5ra579hLi3frhqhvXJUy4=
X-Gm-Gg: ASbGncsNvlDbnvuczDazU3MOJdOTN1YqSifVYqOX63SuV1apDFnKp7sBgAiqc3N9pKX
	oGFJ3h6mhxPxYG+9aRR4qHTgJomhERIOfphhoE84N5Yk4T2mPa5l23Eb96gXVLO1NzYlntTCCB+
	9tMkn8MLJE9fx4MCv3TrNCIVh1WNJTxk+XxV/lpMJm87ADN+v8iF5QTRM7ncOCBp1sZuWCf9lG1
	6N/rpeAS2rPdbSUhlGaDhgvX2hT3SonIArBzNkQiRY7aDcSDBICdlr1oQ5h/v3+a7+ym84IlRf5
	Aag/FIpXtx3DhJqlfj9N0YW19U8xibzeuEMn
X-Google-Smtp-Source: AGHT+IHmwlWwHkyGbRf0kUFOnpDYY6MK9iS/MkX793T4hldQUCYJCOh2qGczT2He4Qzduj5pX0z+pg==
X-Received: by 2002:a05:600c:1c9d:b0:439:643a:c8d5 with SMTP id 5b1f17b1804b1-43c549dcc0amr147894295e9.0.1741685151930;
        Tue, 11 Mar 2025 02:25:51 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:5946:3143:114d:3f3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43cea8076fcsm107436465e9.15.2025.03.11.02.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 02:25:50 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 11 Mar 2025 10:25:38 +0100
Subject: [PATCH v7 7/8] crypto: qce - Switch to using DMA
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-qce-cmd-descr-v7-7-db613f5d9c9f@linaro.org>
References: <20250311-qce-cmd-descr-v7-0-db613f5d9c9f@linaro.org>
In-Reply-To: <20250311-qce-cmd-descr-v7-0-db613f5d9c9f@linaro.org>
To: Thara Gopinath <thara.gopinath@gmail.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, Vinod Koul <vkoul@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Md Sadre Alam <quic_mdalam@quicinc.com>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-crypto@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, 
 linux-doc@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4727;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=Ummz+nuGMXPRajfLduo+chy+xyXsFEfhI+3un0WGWII=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBn0AGWBpep/bMxzHaVQ/LP3izEIuA5yaLo/RFaG
 4AmPWJibzmJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ9ABlgAKCRARpy6gFHHX
 co0pEADKnxz86ATPO90pb6sb4gzp0jyiY6t5PhpXJGqPeBK/X06TiIWtC7rnot42QQM0qPTWcJj
 yLF7pvYjPv7xO3cT0FmAkur+HvME67DfwS0OxXi4fm8XMDXRFywJv627WlaZldp/iUMMSMXURA0
 o5M3ogaNrksZjI/M+x/RTeV6xRQbGS4UJ2CfBbs9936nqo3IvX9vQM65E5HjwUvRAQhe1g4zcdn
 knCnAsF6Ountz7kYwmgF4SXfsWhRpYi3jX+c4Sjc71bNqhCM58hrRQZjEDYRcdG8+3ADHnpV5DL
 eosMm7hM3ikdy8TEKxFyQK3sE0PApTGW5wK7K7AajDbglSpLCZCYRo/TC6kSt6ohHg6HQQL9aqE
 deTLkw1jJfPE4ZUR4ADxzAj7rxSIOqCJNjoTo2pVgT0av3VsGNmZeO8P5CU4+9sQMrCXYYmOwii
 n+ugme68vbrv5lx/R6hN4csW0cYaAUueu9gOe0aQw+i/KVSaPjHGzNaQzNBu6wBRMfqbcvb0j16
 WmdKpRY/DTsqzqv/FMEZ2uAXlbVeuLO4VfC+tpeh8mGxen2yG6lUdZVBkGjcKGl/RS8em/L4+Ko
 NMPqRWVfahE6OfVHvK5kXuk5+iM2PciONT2DXkobzz+R9+4v35b/AI6ggGbe3mGqp9ROpEjLu/e
 4c8QR4FQM9xnIvw==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Replace the qce_write() implementation with one that uses DMA. Convert
all algorithm implementations to use command descriptors. This makes the
driver use BAM DMA exclusively instead of register read/writes.

Co-developed-by: Md Sadre Alam <quic_mdalam@quicinc.com>
Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/crypto/qce/common.c | 17 +++++++++--------
 drivers/crypto/qce/common.h |  1 +
 drivers/crypto/qce/dma.c    | 13 ++++++++++---
 3 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/crypto/qce/common.c b/drivers/crypto/qce/common.c
index 04253a8d3340..80984e853454 100644
--- a/drivers/crypto/qce/common.c
+++ b/drivers/crypto/qce/common.c
@@ -23,11 +23,6 @@ static inline u32 qce_read(struct qce_device *qce, u32 offset)
 	return readl(qce->base + offset);
 }
 
-static inline void qce_write(struct qce_device *qce, u32 offset, u32 val)
-{
-	writel(val, qce->base + offset);
-}
-
 static inline void qce_write_array(struct qce_device *qce, u32 offset,
 				   const u32 *val, unsigned int len)
 {
@@ -157,11 +152,13 @@ static int qce_setup_regs_ahash(struct crypto_async_request *async_req)
 	__be32 mackey[QCE_SHA_HMAC_KEY_SIZE / sizeof(__be32)] = {0};
 	u32 auth_cfg = 0, config;
 	unsigned int iv_words;
+	int ret;
 
 	/* if not the last, the size has to be on the block boundary */
 	if (!rctx->last_blk && req->nbytes % blocksize)
 		return -EINVAL;
 
+	qce_clear_bam_transaction(qce);
 	qce_setup_config(qce);
 
 	if (IS_CMAC(rctx->flags)) {
@@ -225,7 +222,7 @@ static int qce_setup_regs_ahash(struct crypto_async_request *async_req)
 
 	qce_crypto_go(qce, true);
 
-	return 0;
+	return qce_submit_cmd_desc(qce, 0);
 }
 #endif
 
@@ -325,7 +322,9 @@ static int qce_setup_regs_skcipher(struct crypto_async_request *async_req)
 	u32 encr_cfg = 0, auth_cfg = 0, config;
 	unsigned int ivsize = rctx->ivsize;
 	unsigned long flags = rctx->flags;
+	int ret;
 
+	qce_clear_bam_transaction(qce);
 	qce_setup_config(qce);
 
 	if (IS_XTS(flags))
@@ -388,7 +387,7 @@ static int qce_setup_regs_skcipher(struct crypto_async_request *async_req)
 
 	qce_crypto_go(qce, true);
 
-	return 0;
+	return qce_submit_cmd_desc(qce, 0);
 }
 #endif
 
@@ -438,7 +437,9 @@ static int qce_setup_regs_aead(struct crypto_async_request *async_req)
 	unsigned long flags = rctx->flags;
 	u32 encr_cfg, auth_cfg, config, totallen;
 	u32 iv_last_word;
+	int ret;
 
+	qce_clear_bam_transaction(qce);
 	qce_setup_config(qce);
 
 	/* Write encryption key */
@@ -537,7 +538,7 @@ static int qce_setup_regs_aead(struct crypto_async_request *async_req)
 	/* Start the process */
 	qce_crypto_go(qce, !IS_CCM(flags));
 
-	return 0;
+	return qce_submit_cmd_desc(qce, 0);
 }
 #endif
 
diff --git a/drivers/crypto/qce/common.h b/drivers/crypto/qce/common.h
index 02e63ad9f245..ec58c1b6aa36 100644
--- a/drivers/crypto/qce/common.h
+++ b/drivers/crypto/qce/common.h
@@ -100,5 +100,6 @@ void qce_cpu_to_be32p_array(__be32 *dst, const u8 *src, unsigned int len);
 int qce_check_status(struct qce_device *qce, u32 *status);
 void qce_get_version(struct qce_device *qce, u32 *major, u32 *minor, u32 *step);
 int qce_start(struct crypto_async_request *async_req, u32 type);
+void qce_write(struct qce_device *qce, unsigned int offset, u32 val);
 
 #endif /* _COMMON_H_ */
diff --git a/drivers/crypto/qce/dma.c b/drivers/crypto/qce/dma.c
index 71b191944e3f..b8b305fc1b6a 100644
--- a/drivers/crypto/qce/dma.c
+++ b/drivers/crypto/qce/dma.c
@@ -8,6 +8,7 @@
 #include <linux/dma-mapping.h>
 #include <crypto/scatterwalk.h>
 
+#include "common.h"
 #include "core.h"
 #include "dma.h"
 
@@ -106,9 +107,9 @@ int qce_submit_cmd_desc(struct qce_device *qce, unsigned long flags)
 	return ret;
 }
 
-static __maybe_unused void
-qce_prep_dma_command_desc(struct qce_device *qce, struct qce_dma_data *dma,
-			  unsigned int addr, void *buff)
+static void qce_prep_dma_command_desc(struct qce_device *qce,
+				      struct qce_dma_data *dma,
+				      unsigned int addr, void *buff)
 {
 	struct qce_bam_transaction *qce_bam_txn = dma->qce_bam_txn;
 	struct bam_cmd_element *qce_bam_ce_buffer;
@@ -134,6 +135,12 @@ qce_prep_dma_command_desc(struct qce_device *qce, struct qce_dma_data *dma,
 	qce_bam_txn->qce_pre_bam_ce_index = qce_bam_txn->qce_bam_ce_index;
 }
 
+void qce_write(struct qce_device *qce, unsigned int offset, u32 val)
+{
+	qce_prep_dma_command_desc(qce, &qce->dma, (qce->base_dma + offset),
+				  &val);
+}
+
 static void qce_dma_release(void *data)
 {
 	struct qce_dma_data *dma = data;

-- 
2.45.2


