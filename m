Return-Path: <dmaengine+bounces-3106-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED83497137F
	for <lists+dmaengine@lfdr.de>; Mon,  9 Sep 2024 11:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E1EA1F22456
	for <lists+dmaengine@lfdr.de>; Mon,  9 Sep 2024 09:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5DF1B3748;
	Mon,  9 Sep 2024 09:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="g4tfDoxV"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B421B3F02;
	Mon,  9 Sep 2024 09:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725874068; cv=none; b=Hh+edk6ygMz5QfwQGS1ln42FWMvRduwT3jQxRgeW0VlO86WWKXiEVG4DhaJJHpC+P+xCeDLMfpqcbLUNERzTYldBD5ve9zX9S8zpISynWcIvVhYrwjT9GPIWy80brff0a6GUHiJEEbMk+7UlJHyY7AECdoyg2GSzGktCCEW8R8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725874068; c=relaxed/simple;
	bh=ijDGb/iFiwkfPY0y1G/sl5nkyAsYtHis57bHt0bUJ0Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n6t96e28Tunmg0pqq4I07SXwdkTdgWaLzjIt/X3Y38EEGvkJe8+bTDLyL/xSyqq1nk1gyVtryPDeYH61O2ue90Xe04N2kQT9265QgG6067ifsWQEmU7q6vkrJXO2iZhANl6M+DRTNmXSRBRRpE2FDDrTwhtbVBJlFE+WzgIY9eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=g4tfDoxV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4899JkEx029665;
	Mon, 9 Sep 2024 09:27:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sYeb5WYwKbFkHxsrm4VNrTUi8Q0SlSAPr/Um659Rt58=; b=g4tfDoxVcgzPEB9U
	ELCk5E/U0BQXKGMSPT8w+vG7SsdlItXFV7lutuyPKEoP+a2tlD3z1A3fKBnF/rLl
	dTcsO+Ki7B27vsASg8YrrKNrK6EET0Qo0WoYSJADYmKcJ/QT+HDJi9tLJdSeAmaB
	tl+7hKx2g7y1MznwTOOOqC6zGKBoIlHIu/9XqcwBHGOuwETVV8p6pe+Oc++rgGSR
	JGQWO2CIXjD5P+bbMD8vbn3gqvGuoxxkZ+oVM9cvJL1golTmyJTZ44O9Y9aUXRm6
	e2ne+QkCIQNQw+dkdsIe7c3BUi9djCvW3TulXcDe9ZWypGVf0UMmW1VP4llx62up
	bJfyxA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41gy72tbj5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Sep 2024 09:27:35 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4899RYCC001096
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 9 Sep 2024 09:27:34 GMT
Received: from hu-mdalam-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 9 Sep 2024 02:27:29 -0700
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: <thara.gopinath@gmail.com>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>, <vkoul@kernel.org>, <kees@kernel.org>,
        <robin.murphy@arm.com>, <fenghua.yu@intel.com>, <av2082000@gmail.com>,
        <u.kleine-koenig@pengutronix.d>, <linux-crypto@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <quic_varada@quicinc.com>,
        <quic_srichara@quicinc.com>
CC: <quic_mdalam@quicinc.com>
Subject: [PATCH v4 05/11] crypto: qce - Convert register r/w for skcipher via BAM/DMA
Date: Mon, 9 Sep 2024 14:56:26 +0530
Message-ID: <20240909092632.2776160-6-quic_mdalam@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240909092632.2776160-1-quic_mdalam@quicinc.com>
References: <20240909092632.2776160-1-quic_mdalam@quicinc.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: WjpE7RMNCtE85ABPhXjrU9NF7YgB7Uvm
X-Proofpoint-GUID: WjpE7RMNCtE85ABPhXjrU9NF7YgB7Uvm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2408220000 definitions=main-2409090074

Convert register read/write for skcipher via BAM/DMA.
with this change all the crypto register configuration
will be done via BAM/DMA. This change will prepare command
descriptor for all register and write it once.

Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---

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


