Return-Path: <dmaengine+bounces-2862-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B9F952B83
	for <lists+dmaengine@lfdr.de>; Thu, 15 Aug 2024 12:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D14F21F2157E
	for <lists+dmaengine@lfdr.de>; Thu, 15 Aug 2024 10:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4901D1F75;
	Thu, 15 Aug 2024 08:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MmQy/tZ5"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2B01BB698;
	Thu, 15 Aug 2024 08:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723712279; cv=none; b=Xp260x12HsgUt/GfEUQDmvZlou/ucw5ENYnK5N6BHFY8OLimvHhx51tgL5KoymAbX8N6UAi43CbRD2bp0iDzBz7CTFkdNz3sa542jFhqO2j2eOV9LW9u6VfSYQPwuKe+CVNMiRb+v4N0b0PHw+r0kG23/UzcjwE1wwx4FlbuImk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723712279; c=relaxed/simple;
	bh=PHOqtyKbmBusl7egA3xoMemSBFA9/t04wTp2QcxKP24=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VU5t+c6DGecOR/oGNCCj/j8VSNJisH9nrjKzH+Yl3NaWpsQcCGEpUoYEpjHsTMEmIxXhYozAHVDuzthblB5fENwuFKbsa5vYN+U9usmjE75RS4+QhLbElevUc9QC3dYuwLhGm6UKpfR18W+ENgn24TYxO4oqaqQ28hi/LgipHmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MmQy/tZ5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47ENBsqx027591;
	Thu, 15 Aug 2024 08:57:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=xRdyMW3l8LB
	NMV4txZ7rIFHVybiYltWd1qVEgHQBIxA=; b=MmQy/tZ5rZLNU9JYamzUvSbDkv0
	a8C2yIGVGkNhHF60J6C0qW+SnFcPrlmEMexJ0gm3sH1uMtNDVvE1CXlwClyoa73H
	a+V3adM8L2Wx8D6rz56zIHlO11cvfPlX/Fev4GbnnbtzJHZa87qzPLIf6eVd6uCV
	wgSX/PWtLxqy/KuNdjlSWaQsD5aBL0XVX07zO/sbm86ldm6cj3kmaNfFkZRNCDLP
	KPMQXxMhhX7OMOi16tjFV2sld3frkLI+gBUdBZX49ZpRRTvjPWZjauxbZn4zFkga
	/QeFEvEirkAO8EOXn91RLk2hyRCHz/d9IzM3wj/NHyxJN9UJ4BLXZoee5Vg==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40x3etdq40-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Aug 2024 08:57:33 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 47F8vSvE029673;
	Thu, 15 Aug 2024 08:57:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 40xkmhennq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Aug 2024 08:57:30 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 47F8vUxI029708;
	Thu, 15 Aug 2024 08:57:30 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-mdalam-blr.qualcomm.com [10.131.36.157])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 47F8vTg7029698
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Aug 2024 08:57:30 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 466583)
	id AC27A417F7; Thu, 15 Aug 2024 14:27:27 +0530 (+0530)
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
Subject: [PATCH v2 09/16] crypto: qce - Add LOCK and UNLOCK flag support
Date: Thu, 15 Aug 2024 14:27:18 +0530
Message-Id: <20240815085725.2740390-10-quic_mdalam@quicinc.com>
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
X-Proofpoint-GUID: u6rFz-1kcwrVF-bUzY_5784bz7lk605l
X-Proofpoint-ORIG-GUID: u6rFz-1kcwrVF-bUzY_5784bz7lk605l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-15_01,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 suspectscore=0 impostorscore=0 phishscore=0 clxscore=1015 mlxlogscore=999
 lowpriorityscore=0 priorityscore=1501 spamscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408150064

Add LOCK and UNLOCK flag support while preapring
command descriptor for writing crypto register.

Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---

Change in [v2]

* No change

Change in [v1]

* Added initial support for lock/un-lock flag

 drivers/crypto/qce/dma.c | 7 ++++++-
 drivers/crypto/qce/dma.h | 2 ++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/qce/dma.c b/drivers/crypto/qce/dma.c
index e4e672d65302..93d455d1d5b4 100644
--- a/drivers/crypto/qce/dma.c
+++ b/drivers/crypto/qce/dma.c
@@ -72,7 +72,12 @@ int qce_submit_cmd_desc(struct qce_device *qce, unsigned long flags)
 	unsigned long desc_flags;
 	int ret = 0;
 
-	desc_flags = DMA_PREP_CMD;
+	if (flags & QCE_DMA_DESC_FLAG_LOCK)
+		desc_flags = DMA_PREP_CMD | DMA_PREP_LOCK;
+	else if (flags & QCE_DMA_DESC_FLAG_UNLOCK)
+		desc_flags = DMA_PREP_CMD | DMA_PREP_UNLOCK;
+	else
+		desc_flags = DMA_PREP_CMD;
 
 	/* For command descriptor always use consumer pipe
 	 * it recomended as per HPG
diff --git a/drivers/crypto/qce/dma.h b/drivers/crypto/qce/dma.h
index f10991590b3f..ad8a18a720b1 100644
--- a/drivers/crypto/qce/dma.h
+++ b/drivers/crypto/qce/dma.h
@@ -19,6 +19,8 @@
 #define QCE_BAM_CMD_ELEMENT_SIZE       64
 #define QCE_DMA_DESC_FLAG_BAM_NWD      (0x0004)
 #define QCE_MAX_REG_READ               8
+#define QCE_DMA_DESC_FLAG_LOCK          (0x0002)
+#define QCE_DMA_DESC_FLAG_UNLOCK        (0x0001)
 
 struct qce_result_dump {
 	u32 auth_iv[QCE_AUTHIV_REGS_CNT];
-- 
2.34.1


