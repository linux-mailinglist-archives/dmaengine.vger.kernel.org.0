Return-Path: <dmaengine+bounces-4122-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7EEDA11F9F
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jan 2025 11:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10E891882550
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jan 2025 10:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD45424168F;
	Wed, 15 Jan 2025 10:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JSAxMgGT"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C7824226F;
	Wed, 15 Jan 2025 10:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736937075; cv=none; b=Udo2lrgvdbfTpMRXglm3S0Q/NnXLUvcL3T39g48+lw9aYUnivVH1Jv7qxmQ/ubuqJL7Hbtu1ThTr+Sqbu3EGDex4ZEddKd+eYFDrjedvrKzhO9YacRcXCdgaaTQUD3xR3aRj2K1/wT6r45vhp3qKXBYfIf07RQJG89TDeaaypC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736937075; c=relaxed/simple;
	bh=mHvk0ICABKLRHTtE1CBdoBP/btzEkGPbvO7C/IZuOag=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qLyrXeV8FIcQAxAk9esKvsSiJ4/r4Gq4brZX8vrr6jL/2NPX8spyrI0yk/PHlQH5SbRymnwPUjk82cLUHSdzlAqXdpBGpI/r7sT9RmL2fDG6aQIrPlsgNbYKwBln6vh7kWUbkuhrru1QBUxGkWT/lLsdDbPGtDs2RMYttYG2RjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JSAxMgGT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50F7Fxb8030794;
	Wed, 15 Jan 2025 10:31:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vazNzXZZWfJdP4KhoBBmlG4nwzMYHmfxMofyK1Uk9qA=; b=JSAxMgGTovSYz39j
	yFNrgpT3MdRahhOL2Nks0kRHsWb777EPGOY12ErETPCFNERTkPWFoEpd2mueX00P
	kM6hWM503Ut8GuY+iQy9lbohtt7OScHplUVehD+CvUGfgSJ5CkbuDvxyY9JQQmtc
	OLpBUlFubzJIPmqs++nmeR9iIQLXrhTminGLR+IpVDx5XnMXdE6+SPCtTMSPpbxH
	mhYvvrDgvcaYYJXG4JEC2ZmErThcip+wLD8TcJaVdHuWDA2p+lDdKAzHBYIkEpPS
	rLeiXFQlvE0pzd5W+ipv7vD9BNGQBcCCN59LBJ7nTg0tAPCtnoNveDhJ43Ww4AQD
	0QaMaA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4468fs0fgr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 10:31:02 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50FAV146004587
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 10:31:01 GMT
Received: from hu-mdalam-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 15 Jan 2025 02:30:55 -0800
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: <vkoul@kernel.org>, <corbet@lwn.net>, <thara.gopinath@gmail.com>,
        <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <martin.petersen@oracle.com>, <enghua.yu@intel.com>,
        <u.kleine-koenig@baylibre.com>, <dmaengine@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
CC: <quic_mdalam@quicinc.com>, <quic_utiwari@quicinc.com>,
        <quic_srichara@quicinc.com>, <quic_varada@quicinc.com>
Subject: [PATCH v6 06/12] crypto: qce - Convert register r/w for skcipher via BAM/DMA
Date: Wed, 15 Jan 2025 15:59:58 +0530
Message-ID: <20250115103004.3350561-7-quic_mdalam@quicinc.com>
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
X-Proofpoint-GUID: rzckC6DTbwH6ds1zkg9JvJgQk94NboDA
X-Proofpoint-ORIG-GUID: rzckC6DTbwH6ds1zkg9JvJgQk94NboDA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_04,2025-01-15_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 priorityscore=1501
 mlxscore=0 spamscore=0 phishscore=0 clxscore=1011 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501150079

Convert register read/write for skcipher via BAM/DMA.
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


