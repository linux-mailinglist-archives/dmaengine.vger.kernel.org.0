Return-Path: <dmaengine+bounces-3961-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 087B19EDE64
	for <lists+dmaengine@lfdr.de>; Thu, 12 Dec 2024 05:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9BF2168130
	for <lists+dmaengine@lfdr.de>; Thu, 12 Dec 2024 04:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84CFE1420A8;
	Thu, 12 Dec 2024 04:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="U2BEkK0W"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECAC14EC7E;
	Thu, 12 Dec 2024 04:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733977362; cv=none; b=gse153bIhgV8kPV22JD20PviBKZi5WpADHIZiaoKBeMjgVhQ92MUnVSYqNtPrjQtKzdPXguduoYUuG2euDIzddagKniZavMO69R64y776JjynWFaoMDOqCRacU06uQHvd6kagQU9crlbCByxRaSIgAF+88I1TUqqHZPWQSHy6sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733977362; c=relaxed/simple;
	bh=JkMtpFzqF4zidLZ24qjhE2vsydxW4L/IfB3tUY4/674=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ipS4KuUtGVIsq82W4iLDHIDqabbDEq4q69ZBPh40TWIjCJdh0HndiI6ZNl7YPv4zQG3gj00bBYiRbYeRlYMww7m0YS9h19rNfdsC7SGxwOWikH3wQypwoVCOmUf3o+iWvNxeN4uq7XdPagaih+8ChhDKIfkN7T38QfaqEAAGT/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=U2BEkK0W; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BBHDGP4002304;
	Thu, 12 Dec 2024 04:17:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VYMkhxhQdgI3UK6GhEAmMzJHmo36esqvhXDY//UFXMU=; b=U2BEkK0WZFYqZu9Q
	e1OuL3gIs881Lab04RtYXrv2uHPwf8JPQ6QAxwPhWl5N9o50Qv1SEtRzCOiq+8Q+
	XANpAOjiTS8GQuimaLrgt6HHDN5D45zfd4nsCU7gfCJAF2taFxi015IwbFraG1gv
	Vh4RPj/BV9m3DTNNfOc8UU1eeV1b//sCkhFxqkenr8QqXHiSxrs202NL0+iXmLnZ
	wd8niC8gd95/5RaYmColUQDshi9vl8UQCzky55q+YyXwPyNE8OBirCuVfCcpQxRA
	pU1rt9SjMzmDr04kwZZ8R3+dkqduHQ8vP65P7Mez879urDevb6vlRwu+NjiHnJny
	NhEyAw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43eyg646gf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 04:17:29 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BC4HSlY011795
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 04:17:28 GMT
Received: from hu-mdalam-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 11 Dec 2024 20:17:23 -0800
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: <vkoul@kernel.org>, <corbet@lwn.net>, <thara.gopinath@gmail.com>,
        <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <kees@kernel.org>, <dave.jiang@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
CC: <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>,
        <quic_mdalam@quicinc.com>, <quic_utiwari@quicinc.com>
Subject: [PATCH v5 06/12] crypto: qce - Convert register r/w for skcipher via BAM/DMA
Date: Thu, 12 Dec 2024 09:46:33 +0530
Message-ID: <20241212041639.4109039-7-quic_mdalam@quicinc.com>
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
X-Proofpoint-GUID: z-wnswFRrxE_CVkVJ_nQmqewyuO2HSLN
X-Proofpoint-ORIG-GUID: z-wnswFRrxE_CVkVJ_nQmqewyuO2HSLN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0 clxscore=1011
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412120028

Convert register read/write for skcipher via BAM/DMA.
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
  register via BAM for skcipher

Change in [v1]

* This patch was not included in [v1]

 drivers/crypto/qce/common.c | 42 ++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/drivers/crypto/qce/common.c b/drivers/crypto/qce/common.c
index 04253a8d3340..d1da6b1938f3 100644
--- a/drivers/crypto/qce/common.c
+++ b/drivers/crypto/qce/common.c
@@ -34,7 +34,7 @@ static inline void qce_write_array(struct qce_device *qce, u32 offset,
 	int i;
 
 	for (i = 0; i < len; i++)
-		qce_write(qce, offset + i * sizeof(u32), val[i]);
+		qce_write_reg_dma(qce, offset + i * sizeof(u32), val[i], 1);
 }
 
 static inline void
@@ -43,7 +43,7 @@ qce_clear_array(struct qce_device *qce, u32 offset, unsigned int len)
 	int i;
 
 	for (i = 0; i < len; i++)
-		qce_write(qce, offset + i * sizeof(u32), 0);
+		qce_write_reg_dma(qce, offset + i * sizeof(u32), 0, 1);
 }
 
 static u32 qce_config_reg(struct qce_device *qce, int little)
@@ -86,16 +86,16 @@ static void qce_setup_config(struct qce_device *qce)
 	config = qce_config_reg(qce, 0);
 
 	/* clear status */
-	qce_write(qce, REG_STATUS, 0);
-	qce_write(qce, REG_CONFIG, config);
+	qce_write_reg_dma(qce, REG_STATUS, 0, 1);
+	qce_write_reg_dma(qce, REG_CONFIG, config, 1);
 }
 
 static inline void qce_crypto_go(struct qce_device *qce, bool result_dump)
 {
 	if (result_dump)
-		qce_write(qce, REG_GOPROC, BIT(GO_SHIFT) | BIT(RESULTS_DUMP_SHIFT));
+		qce_write_reg_dma(qce, REG_GOPROC, BIT(GO_SHIFT) | BIT(RESULTS_DUMP_SHIFT), 1);
 	else
-		qce_write(qce, REG_GOPROC, BIT(GO_SHIFT));
+		qce_write_reg_dma(qce, REG_GOPROC, BIT(GO_SHIFT), 1);
 }
 
 #if defined(CONFIG_CRYPTO_DEV_QCE_SHA) || defined(CONFIG_CRYPTO_DEV_QCE_AEAD)
@@ -308,7 +308,7 @@ static void qce_xtskey(struct qce_device *qce, const u8 *enckey,
 	/* Set data unit size to cryptlen. Anything else causes
 	 * crypto engine to return back incorrect results.
 	 */
-	qce_write(qce, REG_ENCR_XTS_DU_SIZE, cryptlen);
+	qce_write_reg_dma(qce, REG_ENCR_XTS_DU_SIZE, cryptlen, 1);
 }
 
 static int qce_setup_regs_skcipher(struct crypto_async_request *async_req)
@@ -325,7 +325,9 @@ static int qce_setup_regs_skcipher(struct crypto_async_request *async_req)
 	u32 encr_cfg = 0, auth_cfg = 0, config;
 	unsigned int ivsize = rctx->ivsize;
 	unsigned long flags = rctx->flags;
+	int ret;
 
+	qce_clear_bam_transaction(qce);
 	qce_setup_config(qce);
 
 	if (IS_XTS(flags))
@@ -336,7 +338,7 @@ static int qce_setup_regs_skcipher(struct crypto_async_request *async_req)
 	qce_cpu_to_be32p_array(enckey, ctx->enc_key, keylen);
 	enckey_words = keylen / sizeof(u32);
 
-	qce_write(qce, REG_AUTH_SEG_CFG, auth_cfg);
+	qce_write_reg_dma(qce, REG_AUTH_SEG_CFG, auth_cfg, 1);
 
 	encr_cfg = qce_encr_cfg(flags, keylen);
 
@@ -369,25 +371,31 @@ static int qce_setup_regs_skcipher(struct crypto_async_request *async_req)
 	if (IS_ENCRYPT(flags))
 		encr_cfg |= BIT(ENCODE_SHIFT);
 
-	qce_write(qce, REG_ENCR_SEG_CFG, encr_cfg);
-	qce_write(qce, REG_ENCR_SEG_SIZE, rctx->cryptlen);
-	qce_write(qce, REG_ENCR_SEG_START, 0);
+	qce_write_reg_dma(qce, REG_ENCR_SEG_CFG, encr_cfg, 1);
+	qce_write_reg_dma(qce, REG_ENCR_SEG_SIZE, rctx->cryptlen, 1);
+	qce_write_reg_dma(qce, REG_ENCR_SEG_START, 0, 1);
 
 	if (IS_CTR(flags)) {
-		qce_write(qce, REG_CNTR_MASK, ~0);
-		qce_write(qce, REG_CNTR_MASK0, ~0);
-		qce_write(qce, REG_CNTR_MASK1, ~0);
-		qce_write(qce, REG_CNTR_MASK2, ~0);
+		qce_write_reg_dma(qce, REG_CNTR_MASK, ~0, 1);
+		qce_write_reg_dma(qce, REG_CNTR_MASK0, ~0, 1);
+		qce_write_reg_dma(qce, REG_CNTR_MASK1, ~0, 1);
+		qce_write_reg_dma(qce, REG_CNTR_MASK2, ~0, 1);
 	}
 
-	qce_write(qce, REG_SEG_SIZE, rctx->cryptlen);
+	qce_write_reg_dma(qce, REG_SEG_SIZE, rctx->cryptlen, 1);
 
 	/* get little endianness */
 	config = qce_config_reg(qce, 1);
-	qce_write(qce, REG_CONFIG, config);
+	qce_write_reg_dma(qce, REG_CONFIG, config, 1);
 
 	qce_crypto_go(qce, true);
 
+	ret = qce_submit_cmd_desc(qce, 0);
+	if (ret) {
+		dev_err(qce->dev, "Error in skcipher cmd descriptor\n");
+		return ret;
+	}
+
 	return 0;
 }
 #endif
-- 
2.34.1


