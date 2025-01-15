Return-Path: <dmaengine+bounces-4123-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2354A11FA6
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jan 2025 11:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A59A91884450
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jan 2025 10:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7605284A7B;
	Wed, 15 Jan 2025 10:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mKsVVTdy"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E93246A3A;
	Wed, 15 Jan 2025 10:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736937079; cv=none; b=Ht0wEDYWzCN8T3sDfoaw151G4WusUtK2LmHaaRk9iYmo/sw9VmZ/bBCEmHTItJNGgeAkoxWMxRefEF70a715YVGJgYTr0X9MrlJM4JbJD2xJo+QzSgnJeDK8pHCrofIN2yOr+/rOmtMwMS2hT6aHhf2Pqpi9UupVbh5X2xSAGJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736937079; c=relaxed/simple;
	bh=clEWqIf/JrCoboyOwo8Bywr8er29so8f3iPPiRs/qzE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TQxALDshVj2A3MpFhvTv/YvQ96uHafmoTRSUA/xNWmg4qAA1DvrAI1LF/jnW7zb8UrHw3bnpyc4mLvIalUa+I4MpO3SUcZ07jHJHmXfs0+XuoRI0bvOvR6uqJAeA5LSQ5TzTmLARh29CC9WOmlXAH+IA7+C5YbsNHH8yiCA+y+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mKsVVTdy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50F1YweT008159;
	Wed, 15 Jan 2025 10:31:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IqZBdJNRyUCLIaaw33CPsa8ud3sctLg3PwRnkVMoL8A=; b=mKsVVTdyuKm3fI6w
	MSHEWpBlNz92QsNvr/dcZB171UYBpEVfUkNCt1mkpEMl0zq8drVQ/JeEqkrQOk5y
	43LYdmbO03OIwDh10DYm+3dYvIenHa3eOhNLKK9u5oXFGkl+et4o8GACoNPmvGp7
	q5vP1VTATd1VsiH16eQygpcv8c85Z3K79Hbo8IHJSySbhgvif8DIIR3Qe8i54xoh
	MFLW3QgJ7hiyoaIhgO6ETNxpQxBFQhsnx8aMdA0mQATzxjdh9ee5zVtlI3/k1Ql9
	sCMU8Er/a3hqMcOMl12hVULSAf8kZ6lz0You/Uq7VV+J4vZiE7KAeL7HPe5EPwH1
	BbpyVg==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4463frs7gb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 10:31:07 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50FAV6hH025794
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 10:31:06 GMT
Received: from hu-mdalam-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 15 Jan 2025 02:31:01 -0800
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: <vkoul@kernel.org>, <corbet@lwn.net>, <thara.gopinath@gmail.com>,
        <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <martin.petersen@oracle.com>, <enghua.yu@intel.com>,
        <u.kleine-koenig@baylibre.com>, <dmaengine@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
CC: <quic_mdalam@quicinc.com>, <quic_utiwari@quicinc.com>,
        <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>
Subject: [PATCH v6 07/12] crypto: qce - Convert register r/w for sha via BAM/DMA
Date: Wed, 15 Jan 2025 15:59:59 +0530
Message-ID: <20250115103004.3350561-8-quic_mdalam@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250115103004.3350561-1-quic_mdalam@quicinc.com>
References: <20250115103004.3350561-1-quic_mdalam@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 3WcVmeJWl8otRbX0dHTuWIgmgC7apVda
X-Proofpoint-GUID: 3WcVmeJWl8otRbX0dHTuWIgmgC7apVda
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_04,2025-01-15_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=999 spamscore=0 suspectscore=0 priorityscore=1501
 mlxscore=0 impostorscore=0 phishscore=0 adultscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501150079

Convert register read/write for sha via BAM/DMA.
with this change all the crypto register configuration
will be done via BAM/DMA. This change will prepare command
descriptor for all register and write it once.

Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---

Change in [v6]

* No change

Change in [v5]

* No change

Change in [v4]

* No change 
 
Change in [v3]

* No change

Change in [v2]

* Added initial support to read/write crypto
  register via BAM for SHA

Change in [v1]

* This patch was not included in [v1]

 drivers/crypto/qce/common.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/crypto/qce/common.c b/drivers/crypto/qce/common.c
index d1da6b1938f3..d485762a3fdc 100644
--- a/drivers/crypto/qce/common.c
+++ b/drivers/crypto/qce/common.c
@@ -157,17 +157,19 @@ static int qce_setup_regs_ahash(struct crypto_async_request *async_req)
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
-		qce_write(qce, REG_AUTH_SEG_CFG, 0);
-		qce_write(qce, REG_ENCR_SEG_CFG, 0);
-		qce_write(qce, REG_ENCR_SEG_SIZE, 0);
+		qce_write_reg_dma(qce, REG_AUTH_SEG_CFG, 0, 1);
+		qce_write_reg_dma(qce, REG_ENCR_SEG_CFG, 0, 1);
+		qce_write_reg_dma(qce, REG_ENCR_SEG_SIZE, 0, 1);
 		qce_clear_array(qce, REG_AUTH_IV0, 16);
 		qce_clear_array(qce, REG_AUTH_KEY0, 16);
 		qce_clear_array(qce, REG_AUTH_BYTECNT0, 4);
@@ -213,18 +215,24 @@ static int qce_setup_regs_ahash(struct crypto_async_request *async_req)
 		auth_cfg &= ~BIT(AUTH_FIRST_SHIFT);
 
 go_proc:
-	qce_write(qce, REG_AUTH_SEG_CFG, auth_cfg);
-	qce_write(qce, REG_AUTH_SEG_SIZE, req->nbytes);
-	qce_write(qce, REG_AUTH_SEG_START, 0);
-	qce_write(qce, REG_ENCR_SEG_CFG, 0);
-	qce_write(qce, REG_SEG_SIZE, req->nbytes);
+	qce_write_reg_dma(qce, REG_AUTH_SEG_CFG, auth_cfg, 1);
+	qce_write_reg_dma(qce, REG_AUTH_SEG_SIZE, req->nbytes, 1);
+	qce_write_reg_dma(qce, REG_AUTH_SEG_START, 0, 1);
+	qce_write_reg_dma(qce, REG_ENCR_SEG_CFG, 0, 1);
+	qce_write_reg_dma(qce, REG_SEG_SIZE, req->nbytes, 1);
 
 	/* get little endianness */
 	config = qce_config_reg(qce, 1);
-	qce_write(qce, REG_CONFIG, config);
+	qce_write_reg_dma(qce, REG_CONFIG, config, 1);
 
 	qce_crypto_go(qce, true);
 
+	ret = qce_submit_cmd_desc(qce, 0);
+	if (ret) {
+		dev_err(qce->dev, "Error in sha cmd descriptor\n");
+		return ret;
+	}
+
 	return 0;
 }
 #endif
-- 
2.34.1


