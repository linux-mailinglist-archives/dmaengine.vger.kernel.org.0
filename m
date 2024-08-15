Return-Path: <dmaengine+bounces-2867-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57198952BB3
	for <lists+dmaengine@lfdr.de>; Thu, 15 Aug 2024 12:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E773F2837FD
	for <lists+dmaengine@lfdr.de>; Thu, 15 Aug 2024 10:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C0F1D362B;
	Thu, 15 Aug 2024 08:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pxBLBTDJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9921D0DE2;
	Thu, 15 Aug 2024 08:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723712280; cv=none; b=GBXozdqodsxYt2vb+SAy5wTGnKHxHKNZ1MxpxxR/qM1QXPkdJZ1OlK7vzAhuvkZ9YZLilAZgCgvx0kj5gXBfrcquVZob3VZroZ+xYuj/odqpPwaiLveL62lTDycf7SHUH2kWxkYERw2tyLzQLv23sPmD0a7jzNnYMgRNKa8gPf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723712280; c=relaxed/simple;
	bh=0ngC/alJ+J1Sxb6tXL7vn3OkkPEwCyv6JsExc8TbW0w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HfpbF1bKmsq/hB4E14CRDqepIePnNT9aUztp/gcmtwADFkUdHJoXy/NFiO5suqRBq6kHPEXUe7CMgh/2kB5fX9Fm+FCKfvY6KPeWFjJOC2LGuHdgLPWZ6fEfeq12oCal22lRAnC1oD8sW7a+CFyPnXhJfaFEE4DWhG+52IwGXIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pxBLBTDJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47F7GioX027115;
	Thu, 15 Aug 2024 08:57:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=x4Xm1vn22af
	ZxHExhEhC/0zPsxUObxVsPJM5mAj68ro=; b=pxBLBTDJ2OH2ABmNHjt5YmBA5sA
	P0jXs/9MPxw24f63xkTZ/rX2Wf+gAi2Y2aFMxPRNCM6gux+66h/suTDBdKUFEZoT
	nV0WvIrRzEA5BEZcQrYQsA7R/iFBbWja83Yob+bGqlgwaV0fImw/wf99wHBsbqft
	HK7Nxo0+KyP5nhMTe7v9ElEd3eJhOvvz0n8Ic/Di2pSjKoA8+oMq34fca8gyef56
	LhbiWmF7vvDMnPcc6cdDWdL/HaL2vCovGHSbrga8yLrTrC3CuIo5Qgkf5SYhfDNE
	3OfePWBmla0OJ9qHXOUnD47rxN+pT7X6p1uzoaS0ZRZEsFT4Tzq3HIRiJmA==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 411d5688p9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Aug 2024 08:57:32 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 47F8rhVj024223;
	Thu, 15 Aug 2024 08:57:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 40xkmhenmn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Aug 2024 08:57:29 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 47F8vSF4029646;
	Thu, 15 Aug 2024 08:57:28 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-mdalam-blr.qualcomm.com [10.131.36.157])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 47F8vSe4029644
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Aug 2024 08:57:28 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 466583)
	id 932D3411EE; Thu, 15 Aug 2024 14:27:27 +0530 (+0530)
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
Subject: [PATCH v2 02/16] dmaengine: qcom: bam_dma: add bam_pipe_lock dt property
Date: Thu, 15 Aug 2024 14:27:11 +0530
Message-Id: <20240815085725.2740390-3-quic_mdalam@quicinc.com>
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
X-Proofpoint-GUID: CkHHe18vFuWjsd4YAquZKZTbAof_vVln
X-Proofpoint-ORIG-GUID: CkHHe18vFuWjsd4YAquZKZTbAof_vVln
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-15_01,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0
 suspectscore=0 bulkscore=0 clxscore=1011 phishscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408150064

bam having locking and unlocking mechanism of bam pipes.
Upon encountering a descriptor with Lock bit set, the
BAM will lock all other pipes not related to the current
pipe group, and keep handling the current pipe only until
it sees the Un-Lock set , then it will release all locked
pipes. The actual locking is done on the new descriptor
fetching for publishing, i.e. locked pipe will not fetch
new descriptors even if it got event/events adding more
descriptors for this pipe.

Adding the bam_pipe_lock flag in bam driver to handle
Lock and Un-Lock bit set on command descriptor.

Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---

Change in [v2]

* Added bam_pipe_lock dt property

Change in [v1]

* This patch was not included in [v1]

 drivers/dma/qcom/bam_dma.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index 5e7d332731e0..1ac7e250bdaa 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -389,6 +389,7 @@ struct bam_device {
 	u32 ee;
 	bool controlled_remotely;
 	bool powered_remotely;
+	bool bam_pipe_lock;
 	u32 active_channels;
 
 	const struct reg_offset_data *layout;
@@ -1272,6 +1273,9 @@ static int bam_dma_probe(struct platform_device *pdev)
 	bdev->powered_remotely = of_property_read_bool(pdev->dev.of_node,
 						"qcom,powered-remotely");
 
+	bdev->bam_pipe_lock = of_property_read_bool(pdev->dev.of_node,
+						    "qcom,bam_pipe_lock");
+
 	if (bdev->controlled_remotely || bdev->powered_remotely)
 		bdev->bamclk = devm_clk_get_optional(bdev->dev, "bam_clk");
 	else
-- 
2.34.1


