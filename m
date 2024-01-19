Return-Path: <dmaengine+bounces-760-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3FD8329E3
	for <lists+dmaengine@lfdr.de>; Fri, 19 Jan 2024 14:01:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BCF51C222D6
	for <lists+dmaengine@lfdr.de>; Fri, 19 Jan 2024 13:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0629B524D3;
	Fri, 19 Jan 2024 13:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AklFT0or"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A8B524A2;
	Fri, 19 Jan 2024 13:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705669257; cv=none; b=rZ+eUiWAUwGrzDQ57HKxAZdOFXrLa80ymo5s54BHEKumrEet0P6bm/hmaqi9XpMTjKH+zjf1FdVc8d5vI+1lWaZA54LNqRp+pfruF232ComAV38iaUdFsec1VurZsJIhSDvLVlbxE7TcHjK92YKF2AYapFnPPAXydvY1Rmw8sIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705669257; c=relaxed/simple;
	bh=rjihEl0PPCpJTaosRQlidZuXrEBnlcGLGWWWHhGU7Z0=;
	h=From:To:Cc:Subject:Date:Message-Id; b=KroC3GOlBkIUh+f5UVVVfbgn4539X2FLW0zatfcveTRenOHoQ5GCmW8IKIqdnMkp6RMg3sEiPw3eUBILuOPA4Q/Gv3v6Z3ZBAehHR1Le0+7g/zwa08WyvCEtEtWDSonoo0g+yB8R+PP63VZ8lgvfYhTdBbiIMK0KPaaKyHqoiPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AklFT0or; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40JCU8R2022916;
	Fri, 19 Jan 2024 13:00:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id; s=qcppdkim1; bh=TmGjiCctrlSu
	utJGDhSLxkxmIhS8B4TTbbnE2BeZiu4=; b=AklFT0orPGE7KNb3OgiqVtecA+l8
	edCv3BQL+o5F4Nleqba4GYg+2zsuGSuSANxQ3mDi1EW7YNc1kFCLLA9tVnHW8VLq
	I9pJwCeEopTz2BKs/d8d7Y+l4KR828pFugHSt/FRWpJW9rI2uZ9WyTcRocwLTs6N
	CBQSwYhPdFyqoJ38KNPfS8YtgkByuUq3uEojun4dIbz8uty2yu+QqmWsRGKTakyo
	D5WR1NcrYKQAcbCHiSE/mQUh+i8NCuC0Ro6mz6LHhxz0x7CFWIdF3mIuo4xs3kJN
	8hKSLmeilpCEzfaR1JW42Le2GxG1EDh0IEz5FnelyMjveDPlTwOHj2Pg3Q==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vqn89ghm8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jan 2024 13:00:36 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 40JD0Wfg023730;
	Fri, 19 Jan 2024 13:00:32 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3vkkkmtgqt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 19 Jan 2024 13:00:32 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40JD0WkR023724;
	Fri, 19 Jan 2024 13:00:32 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-msarkar-hyd.qualcomm.com [10.213.111.194])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 40JD0V8t023713;
	Fri, 19 Jan 2024 13:00:32 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3891782)
	id 0D608273A; Fri, 19 Jan 2024 18:30:31 +0530 (+0530)
From: Mrinmay Sarkar <quic_msarkar@quicinc.com>
To: vkoul@kernel.org, jingoohan1@gmail.com, conor+dt@kernel.org,
        konrad.dybcio@linaro.org, manivannan.sadhasivam@linaro.org,
        robh+dt@kernel.org
Cc: quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
        quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
        dmitry.baryshkov@linaro.org, quic_krichai@quicinc.com,
        quic_vbadigan@quicinc.com, quic_parass@quicinc.com,
        quic_schintav@quicinc.com, quic_shijjose@quicinc.com,
        Mrinmay Sarkar <quic_msarkar@quicinc.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev
Subject: [PATCH v1 0/6] Add Change to integrate HDMA with dwc ep driver
Date: Fri, 19 Jan 2024 18:30:16 +0530
Message-Id: <1705669223-5655-1-git-send-email-quic_msarkar@quicinc.com>
X-Mailer: git-send-email 2.7.4
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: epo6p-1FcXSHNkhTjx5fREvGlbo5I4XY
X-Proofpoint-ORIG-GUID: epo6p-1FcXSHNkhTjx5fREvGlbo5I4XY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-19_07,2024-01-19_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=581 clxscore=1011
 suspectscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 mlxscore=0 malwarescore=0 impostorscore=0 adultscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401190065
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>

Hyper DMA (HDMA) is already supported by the dw-edma dmaengine driver.
Unlike it's predecessor Embedded DMA (eDMA), HDMA supports only the
unrolled mapping format. This patch series is to integrate HDMA with
dwc ep driver.

Add change to provide a valid base address of the CSRs from the
platform driver and also provides read/write channels count from
platform driver since there is no standard way to auto detect the
number of available read/write channels in a platform and set the
mapping format in platform driver for HDMA.

This series passes 'struct dw_edma_chip' to irq_vector() as it needs
to access that particular structure and fix to get the eDMA/HDMA
max channel count. Also move the HDMA max channel definition to edma.h
to maintain uniformity with eDMA.

Dependency
----------
Depends on:
https://lore.kernel.org/dmaengine/20231117-b4-feature_hdma_mainline-v6-0-ebf7aa0e40d7@bootlin.com/
https://lore.kernel.org/all/1701432377-16899-1-git-send-email-quic_msarkar@quicinc.com/

Manivannan Sadhasivam (4):
  dmaengine: dw-edma: Pass 'struct dw_edma_chip' to irq_vector()
  dmaengine: dw-edma: Introduce helpers for getting the eDMA/HDMA max
    channel count
  PCI: dwc: Add HDMA support
  dmaengine: dw-edma: Move HDMA_V0_MAX_NR_CH definition to edma.h

Mrinmay Sarkar (2):
  PCI: qcom-ep: Provide number of read/write channel for HDMA
  PCI: epf-mhi: Add flag to enable HDMA for SA8775P

 drivers/dma/dw-edma/dw-edma-core.c           | 29 ++++++++++---
 drivers/dma/dw-edma/dw-edma-pcie.c           |  4 +-
 drivers/dma/dw-edma/dw-hdma-v0-core.c        |  4 +-
 drivers/dma/dw-edma/dw-hdma-v0-regs.h        |  3 +-
 drivers/pci/controller/dwc/pcie-designware.c | 63 ++++++++++++++++++++++------
 drivers/pci/controller/dwc/pcie-qcom-ep.c    | 19 ++++++++-
 drivers/pci/endpoint/functions/pci-epf-mhi.c |  1 +
 include/linux/dma/edma.h                     | 18 +++++++-
 8 files changed, 115 insertions(+), 26 deletions(-)

-- 
2.7.4


