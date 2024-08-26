Return-Path: <dmaengine+bounces-2963-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8401695F107
	for <lists+dmaengine@lfdr.de>; Mon, 26 Aug 2024 14:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED512B224BF
	for <lists+dmaengine@lfdr.de>; Mon, 26 Aug 2024 12:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBE9172BDF;
	Mon, 26 Aug 2024 12:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jtHkaRCd"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C7813BACE;
	Mon, 26 Aug 2024 12:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724674277; cv=none; b=SUFsYoj5i//wmrPxrKRmObYCPAnAJ5owkbk8TMUaI7orFGqICB9j6Z6tEWHiBEpS089Gt1O3BJCSag/vIH9y9WMLccnbu5GLFqXzX5Ob2uuN8MUDCS1q7vdDkf2SPTjZGOPWpDUGAs0PWDyDdavL4/IVfzsB8fTRCmif0MfEAA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724674277; c=relaxed/simple;
	bh=z5x+2ob88XAhjdq4AQjLbg9FAiYcZ+CxNXR5LsRuqoE=;
	h=From:To:Cc:Subject:Date:Message-Id; b=dupxbFLo6lnTmUk79mQ5fw+/4fgCailnqMFXUbwMXfym0QD4rrSdiuTC11ZY5PPA4srYo8+o8IUrN6qkEPbArboRWRrHxtPxTXmiwGGUCMsbrqiSQhkzwnW7SGx7ohWmGzstzu2DQ6vHyj5KIVakCHUjwnukxAIQ9lyrH41gysM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jtHkaRCd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47Q8MVZR028093;
	Mon, 26 Aug 2024 12:11:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:date:from:message-id:subject:to; s=qcppdkim1; bh=C1H3D6HfkOd6
	5y8Ain1dJTfueYdn6s2djjyr5it6lMA=; b=jtHkaRCdD6qXoPLwQyw4DfpJiKw8
	WKqkrPj5Nrlra2dvA2F/tMGPEQgCAIsZ8QWD5rnesR3I+He3AckFJjZSMPMEL3pV
	boNJkhrYA9PCVU8l1f7hSpjXqBP6vOhbiUaTbY8PWOd7FjnPhfTO0A6/HO3ullIp
	dEU/zyrUcdosXiTfRQRH/6fNXGUlQB5dbJZ1yWkrAAaL2c4GkCj/ve09Vh7nFw+K
	X8msS1vwaIY+CisG8P12gWySV1Xs0BclJQY4CKYZA0KXew0PeliIiIepfzrsdKzP
	7dSYNpVCzSWTz9yjTVe17PyvereXdPViLNMRpKBWJLAJ96a3IbHcsTRueQ==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4179duuhrm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Aug 2024 12:11:08 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 47QCB5c0023371;
	Mon, 26 Aug 2024 12:11:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4178kkjamn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 26 Aug 2024 12:11:05 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 47QCB48A023364;
	Mon, 26 Aug 2024 12:11:04 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-msarkar-hyd.qualcomm.com [10.213.111.194])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 47QCB4D2023362;
	Mon, 26 Aug 2024 12:11:04 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3891782)
	id C8234B63; Mon, 26 Aug 2024 17:41:03 +0530 (+0530)
From: Mrinmay Sarkar <quic_msarkar@quicinc.com>
To: manivannan.sadhasivam@linaro.org, fancer.lancer@gmail.com,
        vkoul@kernel.org
Cc: quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
        quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
        Mrinmay Sarkar <quic_msarkar@quicinc.com>,
        Cai Huoqing <cai.huoqing@linux.dev>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] Fix unmasking interrupt bit and remove watermark interrupt enablement
Date: Mon, 26 Aug 2024 17:40:59 +0530
Message-Id: <1724674261-3144-1-git-send-email-quic_msarkar@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: c4qIG7jNNNTp8Chbe6vPlqVGnUEfMhzr
X-Proofpoint-ORIG-GUID: c4qIG7jNNNTp8Chbe6vPlqVGnUEfMhzr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-26_08,2024-08-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=687
 impostorscore=0 adultscore=0 priorityscore=1501 phishscore=0 mlxscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408260095
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

V3 -> V4:
- convert IRQs unmasking in a clearer way as suggested by Serge.

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


