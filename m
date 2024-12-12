Return-Path: <dmaengine+bounces-3955-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 703F39EDE40
	for <lists+dmaengine@lfdr.de>; Thu, 12 Dec 2024 05:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22DE3167DE3
	for <lists+dmaengine@lfdr.de>; Thu, 12 Dec 2024 04:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA85189B8D;
	Thu, 12 Dec 2024 04:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="m19NmgIA"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A4B188CD8;
	Thu, 12 Dec 2024 04:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733977069; cv=none; b=JT1BIWXfhoHBTtJZVxBuO1wHRWPmgn4we2eLdRwv9Oclv2MjqsswDF/Vn6QwZ0g3L/UQ8/WqfB6/ZzHQmEzAvxATyHt99rxWJUqCTCS7HzjID0hbMBp+RnLau3wkrIC9wB9ChntWPvV+uE+pOaJ6F239aUN94O02owXcSRFREiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733977069; c=relaxed/simple;
	bh=jNTxMcKaVo0UsXs4Ol3AqMCMeG/agzRdGJQwSOrX1HY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rVHSJPeqPRMdsiCHyCaWHo2TOKoxIhjxp3HLQRYS6IqO+wv/PanFEEpr4E6VqrKe3eEet+j30cnipR9vEBLJjX1GTZNODP6DvY8UwLAo3tProm7NP8ekdTVavTDSwvzeu3VsFnbOEHhsWPNBAfpu6j09pZLpfcH+Tfd8El0GMvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=m19NmgIA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BBHDgnh031003;
	Thu, 12 Dec 2024 04:17:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	o+6KzP7zOkOTUjbosDUIrSfiT2N+LFxav5/hHcRQpI8=; b=m19NmgIAokUq2cZt
	bNLSoE6WzW2cYvFF2+wkuRcyEoqS10D6XQaZuS9hBk+MrN5dPGmhwIRhwyr6PGR2
	kxrdwXQ5Qf5i1lBoUXWF0CBTqBbyYRI8xdha5Sc6IZUtAZl/hW8hSNL5AJAAoJSb
	9gbWNClRk+r2mIbAMM7PejPYafdioEenMCxib0wC7djSUuwYTQXqY3d465BRRNgN
	XVlkr9I8PV1npV9IHgnYcVzz7TPK+jSdOzLKufz+qLyetCrVGziu6vXWloJnSLzN
	R0iQeUlE6L8ar/fkUd6+8+nxndmF2V6pgxM66qaaBQiN9/lhm+MYSD8TetxXQ5X/
	mc3Mhg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43dxw4a24e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 04:17:39 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BC4Hc9l002387
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 04:17:38 GMT
Received: from hu-mdalam-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 11 Dec 2024 20:17:33 -0800
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: <vkoul@kernel.org>, <corbet@lwn.net>, <thara.gopinath@gmail.com>,
        <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <kees@kernel.org>, <dave.jiang@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
CC: <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>,
        <quic_mdalam@quicinc.com>, <quic_utiwari@quicinc.com>
Subject: [PATCH v5 08/12] crypto: qce - Convert register r/w for aead via BAM/DMA
Date: Thu, 12 Dec 2024 09:46:35 +0530
Message-ID: <20241212041639.4109039-9-quic_mdalam@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241212041639.4109039-1-quic_mdalam@quicinc.com>
References: <20241212041639.4109039-1-quic_mdalam@quicinc.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: d-emBqxDXpjwYU26PY4LRgPbRDABpCR9
X-Proofpoint-GUID: d-emBqxDXpjwYU26PY4LRgPbRDABpCR9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 adultscore=0 mlxlogscore=999
 clxscore=1015 spamscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412120028

Convert register read/write for aead via BAM/DMA.
with this change all the crypto register configuration
will be done via BAM/DMA. This change will prepare command
descriptor for all register and write it once.

Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---

Change in [v5]

* No change

Change in [v4]

* No change 
 
Change in [v3]

* No change

Change in [v2]

* Added initial support to read/write crypto
  register via BAM for aead

Change in [v1]

* This patch was not included in [v1]

 drivers/crypto/qce/common.c | 38 ++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/drivers/crypto/qce/common.c b/drivers/crypto/qce/common.c
index d485762a3fdc..ff96f6ba1fc5 100644
--- a/drivers/crypto/qce/common.c
+++ b/drivers/crypto/qce/common.c
@@ -454,7 +454,9 @@ static int qce_setup_regs_aead(struct crypto_async_request *async_req)
 	unsigned long flags = rctx->flags;
 	u32 encr_cfg, auth_cfg, config, totallen;
 	u32 iv_last_word;
+	int ret;
 
+	qce_clear_bam_transaction(qce);
 	qce_setup_config(qce);
 
 	/* Write encryption key */
@@ -467,12 +469,12 @@ static int qce_setup_regs_aead(struct crypto_async_request *async_req)
 
 	if (IS_CCM(rctx->flags)) {
 		iv_last_word = enciv[enciv_words - 1];
-		qce_write(qce, REG_CNTR3_IV3, iv_last_word + 1);
+		qce_write_reg_dma(qce, REG_CNTR3_IV3, iv_last_word + 1, 1);
 		qce_write_array(qce, REG_ENCR_CCM_INT_CNTR0, (u32 *)enciv, enciv_words);
-		qce_write(qce, REG_CNTR_MASK, ~0);
-		qce_write(qce, REG_CNTR_MASK0, ~0);
-		qce_write(qce, REG_CNTR_MASK1, ~0);
-		qce_write(qce, REG_CNTR_MASK2, ~0);
+		qce_write_reg_dma(qce, REG_CNTR_MASK, ~0, 1);
+		qce_write_reg_dma(qce, REG_CNTR_MASK0, ~0, 1);
+		qce_write_reg_dma(qce, REG_CNTR_MASK1, ~0, 1);
+		qce_write_reg_dma(qce, REG_CNTR_MASK2, ~0, 1);
 	}
 
 	/* Clear authentication IV and KEY registers of previous values */
@@ -508,7 +510,7 @@ static int qce_setup_regs_aead(struct crypto_async_request *async_req)
 	encr_cfg = qce_encr_cfg(flags, enc_keylen);
 	if (IS_ENCRYPT(flags))
 		encr_cfg |= BIT(ENCODE_SHIFT);
-	qce_write(qce, REG_ENCR_SEG_CFG, encr_cfg);
+	qce_write_reg_dma(qce, REG_ENCR_SEG_CFG, encr_cfg, 1);
 
 	/* Set up AUTH_SEG_CFG */
 	auth_cfg = qce_auth_cfg(rctx->flags, auth_keylen, ctx->authsize);
@@ -525,34 +527,40 @@ static int qce_setup_regs_aead(struct crypto_async_request *async_req)
 		else
 			auth_cfg |= AUTH_POS_BEFORE << AUTH_POS_SHIFT;
 	}
-	qce_write(qce, REG_AUTH_SEG_CFG, auth_cfg);
+	qce_write_reg_dma(qce, REG_AUTH_SEG_CFG, auth_cfg, 1);
 
 	totallen = rctx->cryptlen + rctx->assoclen;
 
 	/* Set the encryption size and start offset */
 	if (IS_CCM(rctx->flags) && IS_DECRYPT(rctx->flags))
-		qce_write(qce, REG_ENCR_SEG_SIZE, rctx->cryptlen + ctx->authsize);
+		qce_write_reg_dma(qce, REG_ENCR_SEG_SIZE, rctx->cryptlen + ctx->authsize, 1);
 	else
-		qce_write(qce, REG_ENCR_SEG_SIZE, rctx->cryptlen);
-	qce_write(qce, REG_ENCR_SEG_START, rctx->assoclen & 0xffff);
+		qce_write_reg_dma(qce, REG_ENCR_SEG_SIZE, rctx->cryptlen, 1);
+	qce_write_reg_dma(qce, REG_ENCR_SEG_START, rctx->assoclen & 0xffff, 1);
 
 	/* Set the authentication size and start offset */
-	qce_write(qce, REG_AUTH_SEG_SIZE, totallen);
-	qce_write(qce, REG_AUTH_SEG_START, 0);
+	qce_write_reg_dma(qce, REG_AUTH_SEG_SIZE, totallen, 1);
+	qce_write_reg_dma(qce, REG_AUTH_SEG_START, 0, 1);
 
 	/* Write total length */
 	if (IS_CCM(rctx->flags) && IS_DECRYPT(rctx->flags))
-		qce_write(qce, REG_SEG_SIZE, totallen + ctx->authsize);
+		qce_write_reg_dma(qce, REG_SEG_SIZE, totallen + ctx->authsize, 1);
 	else
-		qce_write(qce, REG_SEG_SIZE, totallen);
+		qce_write_reg_dma(qce, REG_SEG_SIZE, totallen, 1);
 
 	/* get little endianness */
 	config = qce_config_reg(qce, 1);
-	qce_write(qce, REG_CONFIG, config);
+	qce_write_reg_dma(qce, REG_CONFIG, config, 1);
 
 	/* Start the process */
 	qce_crypto_go(qce, !IS_CCM(flags));
 
+	ret = qce_submit_cmd_desc(qce, 0);
+	if (ret) {
+		dev_err(qce->dev, "Error in aead cmd descriptor\n");
+		return ret;
+	}
+
 	return 0;
 }
 #endif
-- 
2.34.1


