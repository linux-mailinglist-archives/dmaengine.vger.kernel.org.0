Return-Path: <dmaengine+bounces-2868-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27828952BA0
	for <lists+dmaengine@lfdr.de>; Thu, 15 Aug 2024 12:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3CEC281D94
	for <lists+dmaengine@lfdr.de>; Thu, 15 Aug 2024 10:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A9B1D4145;
	Thu, 15 Aug 2024 08:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EY5jpxYP"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C6E1CB30E;
	Thu, 15 Aug 2024 08:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723712281; cv=none; b=a4BNw7HSt2YhHrx5pjS4MpeIAj4QWGwrtYud30UoF0YjrUmdfIPfNWNy1MtJz+F8pES1DLRNMugoCjTvx4qHZiMzlDfCgvxkN5a3/d6hQn7vDHmcJaODvoU2BdRoZQLLXGi9iaZHWjgFuo8+T1a/+a3BMeebgSWF3Wcn0mkR8NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723712281; c=relaxed/simple;
	bh=FiMqY+C++aXg96e2Fw7GLilzSRRqIzJL0gMkv3twsH8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BpWCGI9HbqIpOpmjobF17041GjrvSGT5UKbRv+m4reXcW7OOuUiBTI5s2BWnB63RNzoLCY1Vdm5o4c90ew4i4UgIJ+RhZGsHqcswjLl2epl33WBo/YnN6VSHRsHmoOLUx9bZyfspIvEJu1Iitz7dYmL3HudFa5g6Ncp/AGFLbrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EY5jpxYP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47ENiTWE028639;
	Thu, 15 Aug 2024 08:57:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=r8NQD3j/58d
	5gs24RlXy24Tv2tdBXfIG5mvUWcIKRUI=; b=EY5jpxYPlBoP+40Eq0fYML+qTyH
	xDE2t3TiqTVXqMNTP6i3mrzOgyO+L7JGYNn8IknSWRDGD/E4MvwoEHHVjVu7WOZn
	ppgwWRJZIa1OuCSoh0O0//Pz6iQQcD4SX83pruWl2UrYNhsN9Ud7gcQiVwpZLI4d
	tOek+MuaPa6VstiotyM6kxrH1zrT8n9Bp85CupEuEvocTe6nHvIdonA8Z8FvGMtR
	pRj5P6/nfPECH+78w/7V9AIfJvfhWe3Iu9J/w1EGVb0Flqe7IatzEQsie76yGUVf
	SbHq4g4fWuHLuFIB35UJhuZUgASMyY6KqaClQ0jh6mvS9l37+2Yn4+ev/Pg==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4116h5ryn7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Aug 2024 08:57:33 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 47F8sTd2025235;
	Thu, 15 Aug 2024 08:57:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 40xkmhennp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Aug 2024 08:57:30 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 47F8un7C028821;
	Thu, 15 Aug 2024 08:57:30 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-mdalam-blr.qualcomm.com [10.131.36.157])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 47F8vTPd029703
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Aug 2024 08:57:30 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 466583)
	id A1F97417EE; Thu, 15 Aug 2024 14:27:27 +0530 (+0530)
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: vkoul@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org, thara.gopinath@gmail.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        gustavoars@kernel.org, u.kleine-koenig@pengutronix.de, kees@kernel.org,
        agross@kernel.org, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Cc: quic_srichara@quicinc.com, quic_varada@quicinc.com,
        quic_mdalam@quicinc.com, quic_utiwari@quicinc.com
Subject: [PATCH v2 06/16] crypto: qce - Convert register r/w for skcipher via BAM/DMA
Date: Thu, 15 Aug 2024 14:27:15 +0530
Message-Id: <20240815085725.2740390-7-quic_mdalam@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815085725.2740390-1-quic_mdalam@quicinc.com>
References: <20240815085725.2740390-1-quic_mdalam@quicinc.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: NdfFiAGVqSls7NaIJQV8GvOXel00747L
X-Proofpoint-ORIG-GUID: NdfFiAGVqSls7NaIJQV8GvOXel00747L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-15_01,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 impostorscore=0 clxscore=1015 malwarescore=0 phishscore=0
 mlxscore=0 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408150064

Convert register read/write for skcipher via BAM/DMA.
with this change all the crypto register configuration
will be done via BAM/DMA. This change will prepare command
descriptor for all register and write it once.

Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---
Change in [v2]

* No change

Change in [v1]

* Added crypto register read/write via bam for skcipher

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


