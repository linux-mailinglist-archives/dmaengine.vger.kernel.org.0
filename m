Return-Path: <dmaengine+bounces-2860-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 285AC952B7E
	for <lists+dmaengine@lfdr.de>; Thu, 15 Aug 2024 12:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BA28282D73
	for <lists+dmaengine@lfdr.de>; Thu, 15 Aug 2024 10:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F411D1738;
	Thu, 15 Aug 2024 08:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="K03kZdjQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3001C9EBB;
	Thu, 15 Aug 2024 08:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723712278; cv=none; b=HIXMNUgdamoKT/2WDZwJh2Vdw4/eH7C2rD29Awosu9GQkaHlsS0LtWXZL0X1wQlbnQ+HBL+jeuxCCeyuGqVQavK7+MzedD4W9LiVTG4PjI7Le4UV82yRwOkrzJd/Zee5PwVpNo9dLZikCJvWREVbX63uYtrVF1X2aaZ1wK93trw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723712278; c=relaxed/simple;
	bh=2yRMZCl2RljoEQN5hXEYOaWxKeYD2cbufrF78j4PKDY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rD0A9dZNaGWIK6VAwvEFCea1iEnysCa3UeorCjD+M0aDmGTgR2VP3WP5GQDt9G9g0ntcIFlI3cMwvjDQ3ThIsCNJPPt6s/oO601wBRl9F7Z1+F4cw4BDFIT+tvDZV9JIEAh6o6iNaQeliefHMwJseOxiJbuMB51b1uoQ9jDxiEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=K03kZdjQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47F7H4HA027983;
	Thu, 15 Aug 2024 08:57:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=l5/Sou69fVu
	Oc8aikx7562hWjh4VsmqAChQUaywmypk=; b=K03kZdjQYLx8R70THUb9M8Wkc1Y
	UVgTBdsQ9BDbya3KdIOr8H1YglOkvJJLTIaR3i48jGR/Rwk2LpXv1xCd6BR8/f9h
	fZhmqJ2cwEShMODZdRM8jEJ37899iWK7RmeT6fSgyg2Ndk8c2uSsPDFvHi4irzZO
	3FcKseA9CmF1DwWas8AfKgqB3UKO98thbia/TVIioVSju2m9RbmHT9M/TGEORugN
	MoJO1/XCncKBMl84DN9SJupffJVOwsvSCszfJp068nyVz4jbPf0R7jId6mQ1n6CS
	x05iUpTObOGn7Wa7PSjz+STIpWrtITb/wPCEvEeJPfX8hgaBkTXhDqlYsMg==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 411d5688pe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Aug 2024 08:57:34 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 47F8tDTj027535;
	Thu, 15 Aug 2024 08:57:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 40xkmhennr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Aug 2024 08:57:30 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 47F8vUBw029711;
	Thu, 15 Aug 2024 08:57:30 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-mdalam-blr.qualcomm.com [10.131.36.157])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 47F8vTvw029694
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Aug 2024 08:57:30 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 466583)
	id A5857417F0; Thu, 15 Aug 2024 14:27:27 +0530 (+0530)
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
Subject: [PATCH v2 07/16] crypto: qce - Convert register r/w for sha via BAM/DMA
Date: Thu, 15 Aug 2024 14:27:16 +0530
Message-Id: <20240815085725.2740390-8-quic_mdalam@quicinc.com>
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
X-Proofpoint-GUID: ii5zmbULCk8_n2aWUZ3JCupe2zD-y7nC
X-Proofpoint-ORIG-GUID: ii5zmbULCk8_n2aWUZ3JCupe2zD-y7nC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-15_01,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0
 suspectscore=0 bulkscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408150064

Convert register read/write for sha via BAM/DMA.
with this change all the crypto register configuration
will be done via BAM/DMA. This change will prepare command
descriptor for all register and write it once.

Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---

Change in [v2]

* No change

Change in [v1]

* Added initial support for register read/write via bam 
  for SHA

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


