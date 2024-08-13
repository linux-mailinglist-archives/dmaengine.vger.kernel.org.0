Return-Path: <dmaengine+bounces-2853-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE031950634
	for <lists+dmaengine@lfdr.de>; Tue, 13 Aug 2024 15:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFDE4B21DB7
	for <lists+dmaengine@lfdr.de>; Tue, 13 Aug 2024 13:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B433319ADBE;
	Tue, 13 Aug 2024 13:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ItxTVPde"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CC81E4B0;
	Tue, 13 Aug 2024 13:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723554954; cv=none; b=o/6pEmR1ild1WpflhHn9/KjD39x2kQL2n/hyqTwSz12G60VItULnXZ54KPGsJbZbZ7/V1VdFKSFAHYIG+x8sl8TQ6oOuyvku9nAMgNyp6XsFo0Ohu4EhjdRXdnft70aH1T4aI7gajbMxz5dbr9AUMSASzuViyOk4WNOOywEqDO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723554954; c=relaxed/simple;
	bh=Mdycd1eS9y93fMkr5/9R8CQIoS4nOXiruKbQugDTSdM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=dwR4m9HmwS4Ah404KNrVMJLG1DlUBzCYEskXzbMx2Bn1CMLYTNxy2qPwMyADWpuQ31Spr+V5Wq5EYaJ8a6x+w8XJZUlje2L63ueLa7CroRxgdZ9LZbFiKqB2ri4wMOkDuXHF3ecgQXEt6YdVubnbusJ3r8QQudfHKXh9yATIBbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ItxTVPde; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47DD9RZd003196;
	Tue, 13 Aug 2024 13:15:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:date:from:message-id:subject:to; s=qcppdkim1; bh=FGFfEt5ED8G3
	qTcKyq7rXJTVRVuqCzYS+3UZI8QrzHw=; b=ItxTVPdeapMf++rFFwkNlJWHDgwQ
	nWlogqQMc9Xkv4lpxE+K75ePcWxp9h/vbQF3cqPoSU+GPS21iDdZtAL8n4o+HJT8
	uSDHoSx1R0JeGbdMi33mXb3er3aJnaU979sIPR+UszPNrJqY0oOPiBIgq2T1V9as
	kwlO90G+37SORIKY5WrgARyuTwwQPv83alKk2KvX/SuPehupT7vtWrNa+RelhYx5
	USTaYFo37zy7fIUmibJQrX+60Ae8JEmk0YSBkGmAD/ta+TS6sZOaHhzRc66iP5bk
	efsrUSWHGt0C7qHq/y71wL2rNvMy/8qT+ZdvN5lPnkx6MD+9NOX1MhRIjw==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40x167ysyn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 13:15:45 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 47DDFf5O001335;
	Tue, 13 Aug 2024 13:15:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 40xkmgxsyf-1;
	Tue, 13 Aug 2024 13:15:41 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 47DDFf6w001330;
	Tue, 13 Aug 2024 13:15:41 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-msarkar-hyd.qualcomm.com [10.213.111.194])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 47DDFfJJ001329;
	Tue, 13 Aug 2024 13:15:41 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3891782)
	id 95482974; Tue, 13 Aug 2024 18:45:40 +0530 (+0530)
From: Mrinmay Sarkar <quic_msarkar@quicinc.com>
To: manivannan.sadhasivam@linaro.org, fancer.lancer@gmail.com,
        vkoul@kernel.org
Cc: quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
        quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
        Mrinmay Sarkar <quic_msarkar@quicinc.com>,
        Cai Huoqing <cai.huoqing@linux.dev>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] Fix unmasking interrupt bit and remove watermark interrupt enablement
Date: Tue, 13 Aug 2024 18:45:36 +0530
Message-Id: <1723554938-23852-1-git-send-email-quic_msarkar@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: PkLbcdi0WS_q6OctLvVBXbpxjF5c--MH
X-Proofpoint-ORIG-GUID: PkLbcdi0WS_q6OctLvVBXbpxjF5c--MH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-13_04,2024-08-13_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 suspectscore=0 mlxlogscore=660 impostorscore=0 malwarescore=0 spamscore=0
 mlxscore=0 priorityscore=1501 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408130096
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

V2 -> V3:
- convert 'STOP, ABORT' to 'stop, abort' as suggested by Serge
- Added Reviewed-by tag

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


