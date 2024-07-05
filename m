Return-Path: <dmaengine+bounces-2632-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5EB928A34
	for <lists+dmaengine@lfdr.de>; Fri,  5 Jul 2024 15:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EE8F1F229AD
	for <lists+dmaengine@lfdr.de>; Fri,  5 Jul 2024 13:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981EE156227;
	Fri,  5 Jul 2024 13:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Pzb/0vwI"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD57B1459E8;
	Fri,  5 Jul 2024 13:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720187748; cv=none; b=OnDLHzLCPUHaBsXM94nS2tWECfOemXvTxCi0sGc0KeBQJHANcTj/JL8nfPVbBFMDawm+zQ/w1b0XLyOgoh9XFeajEu0taarZO5cYDXBwK1NxDz/ccePrxwRbz43Yj+kJileT9pJf/hV0dDS2E8e6lijkJd8enlVkQ5EhJUroHwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720187748; c=relaxed/simple;
	bh=2GtyDYiumgocbV0k0KJwyssg+IUPuxXvh+oveXpe29I=;
	h=From:To:Cc:Subject:Date:Message-Id; b=q+1muz6hDxHLBnRHMVmt9hA6oe8i0+pRqLXsWTf3bzJ7RV3rwWBA9Se70qJKBNK8HuibnB7c/nui8Vji+7PiKJvore87qf31jhdLQDhnvDSqFJskw5BcnJT1a6DFfnavactm3XkZaWzx5fHR2U1cu8XikHN0nIWP7C/PC10rlKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Pzb/0vwI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 465BGY5T011649;
	Fri, 5 Jul 2024 13:55:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:date:from:message-id:subject:to; s=qcppdkim1; bh=4IEXmRQWMzUA
	0qFO7X/W1K+lHS8lisstFRYAcBoTS7M=; b=Pzb/0vwI+FCnirVPKF8jbA0PwLum
	bq6T1yqBZsk87ZJDN6DdDVmKvz742cBVKx8RTtoUdUIY4JRVEFiWWOGuPiudqAs1
	GWzJCoUZcxsqUQcX59TxXQRY8GuGyCmUR2wJnb/knAbowZjt1aql4MS2vOclnYbd
	6ZOuYNVxGpZ+n9mReiCfXhF8iuC/ZPQz4gD+VH5wyUUzmfjFfhdcceoZOdleMsdL
	K0Ts8KebulErmtSbQZ8aHd6sBzZR8GKuAQSAY5K8bhNeJDh9FeVWLLqWoaFxFX9t
	02TW6SXSl8AALmgLmW/tw3r30vJsWF45yMRrVHY2Xr0jJizIg9L6pHWoUA==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 402996xg5f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jul 2024 13:55:42 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTP id 465DtclV001986;
	Fri, 5 Jul 2024 13:55:38 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 402bbm4nnj-1;
	Fri, 05 Jul 2024 13:55:38 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 465DtcG4001981;
	Fri, 5 Jul 2024 13:55:38 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-msarkar-hyd.qualcomm.com [10.213.111.194])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 465DtcEx001980;
	Fri, 05 Jul 2024 13:55:38 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3891782)
	id 692A0DA0; Fri,  5 Jul 2024 19:25:37 +0530 (+0530)
From: Mrinmay Sarkar <quic_msarkar@quicinc.com>
To: manivannan.sadhasivam@linaro.org, fancer.lancer@gmail.com,
        vkoul@kernel.org
Cc: quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
        quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
        Mrinmay Sarkar <quic_msarkar@quicinc.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] Fix unmasking interrupt bit and remove watermark interrupt enablement 
Date: Fri,  5 Jul 2024 19:25:31 +0530
Message-Id: <1720187733-5380-1-git-send-email-quic_msarkar@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vA6QavletGmcoGhVd5583M8bxidqUXOl
X-Proofpoint-ORIG-GUID: vA6QavletGmcoGhVd5583M8bxidqUXOl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-05_09,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 mlxscore=0 malwarescore=0 clxscore=1011 mlxlogscore=574
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2407050099
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>

This patch series reset STOP_INT_MASK and ABORT_INT_MASK bit and unmask
these interrupt for HDMA.

and also remove enablement of local watermark interrupt enable(LWIE)
and remote watermarek interrupt enable(RWIE) bit to avoid unnecessary
watermark interrupt event.

Testing
-------

Tested on Qualcomm SA8775P Platform.

Mrinmay Sarkar (2):
  dmaengine: dw-edma: Add fix to unmask the interrupt bit for HDMA
  dmaengine: dw-edma: Add change to remove watermark interrupt
    enablement

 drivers/dma/dw-edma/dw-hdma-v0-core.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

-- 
2.7.4


