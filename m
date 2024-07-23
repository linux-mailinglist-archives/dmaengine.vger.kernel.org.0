Return-Path: <dmaengine+bounces-2726-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A41F93A132
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jul 2024 15:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14BD2B22AFE
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jul 2024 13:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D920C153820;
	Tue, 23 Jul 2024 13:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="A8yPBQh0"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229E3153801;
	Tue, 23 Jul 2024 13:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721740795; cv=none; b=bSwMhzrBbLafabjf5eQie8WSR8tknqGRahUJiZ51mZNQmU7a5mYdKOLJ03KVhSk/XIKGWEc09LPSGNZJ+UeV7vTZyi/3DCI6fgMxO0m6YZ7o8eO2LjECHFKaho2ihAjaMrOJePzN9DUVxBthkdV1TQayl7wUyDKR+8VHD+fsOcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721740795; c=relaxed/simple;
	bh=xz4L1sbhgOcRzELu9E5Vr7uDJUMbsmxducek2Ulvejk=;
	h=From:To:Cc:Subject:Date:Message-Id; b=VJ82j5/Sn/otoekjKTdTHkltBf5jFcw0oFe/Hnr92XdockJMHRN9N1jbS2xofR3ChTHq2qRTauQlr4709r180MQDJ89CeQalyL/1XvbdZiRTJIx8ucujnft9s+KeIiiyMNXfKTUOJrwBcCHxPigk+NlNugZ2BN3H7iSEOCEXAdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=A8yPBQh0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46N9Q47I011183;
	Tue, 23 Jul 2024 13:19:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:date:from:message-id:subject:to; s=qcppdkim1; bh=5Yc1CSNOs4hY
	izM/hpiJO4CShIbAdMUfCCSdu8qXe5k=; b=A8yPBQh0R3VH5TkPcWG2RXVPSzxO
	uDaKb/ZNl56Q7x8I8C0GmRR23BDK8e2DkA5Z7MKWtNjaLv+QQnFNNhbdXzOd2fOl
	pAiCQtC6pnl0JsLeT5Ce80xddpFkcYX32YuyCyM9HmeTeOQ6Lr6NC28p6X+a6ohM
	JBpEGiDIy+vkOyNpO6Cf1eUn26oZr2OTy61xfni/aj/YfgDAI4GnEvqh88EE9VIO
	bOgjVZLE8/cKe8CZel7kidsxxftgFTEWrzuTvh1vSpm2MdbRSw8im+I+QJPj1Skk
	Cz891lkZa1KjkBJbVXbdsZU4wMPBZSpna5NDda3a7SPhextvw5p+UVnlsw==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40g2kmy38d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 13:19:39 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTP id 46NDJZ8h019981;
	Tue, 23 Jul 2024 13:19:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 40g6akuxr4-1;
	Tue, 23 Jul 2024 13:19:35 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 46NDJZkY019976;
	Tue, 23 Jul 2024 13:19:35 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-msarkar-hyd.qualcomm.com [10.213.111.194])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 46NDJZwx019975;
	Tue, 23 Jul 2024 13:19:35 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3891782)
	id A384B1534; Tue, 23 Jul 2024 18:49:34 +0530 (+0530)
From: Mrinmay Sarkar <quic_msarkar@quicinc.com>
To: manivannan.sadhasivam@linaro.org, fancer.lancer@gmail.com,
        vkoul@kernel.org
Cc: quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
        quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
        stable@vger.kernel.org, Mrinmay Sarkar <quic_msarkar@quicinc.com>,
        Cai Huoqing <cai.huoqing@linux.dev>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Fix unmasking interrupt bit and remove watermark interrupt enablement 
Date: Tue, 23 Jul 2024 18:49:30 +0530
Message-Id: <1721740773-23181-1-git-send-email-quic_msarkar@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: HJoSgzLkdrXszdsJ8aAGNZAc5ZDl5Nxo
X-Proofpoint-GUID: HJoSgzLkdrXszdsJ8aAGNZAc5ZDl5Nxo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-23_02,2024-07-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 spamscore=0 mlxscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 adultscore=0 clxscore=1011 mlxlogscore=595 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407230095
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

V1 -> V2:
- Modified commit message and added Fixes, CC tag as suggested by Mani
- reanme done to STOP
- rename DW_HDMA_V0_LIE -> DW_HDMA_V0_LWIE and DW_HDMA_V0_RIE -> DW_HDMA_V0_RWIE

Mrinmay Sarkar (2):
  dmaengine: dw-edma: Fix unmasking STOP and ABORT interrupts for HDMA
  dmaengine: dw-edma: Do not enable watermark interrupts for HDMA

 drivers/dma/dw-edma/dw-hdma-v0-core.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

-- 
2.7.4


