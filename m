Return-Path: <dmaengine+bounces-2052-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20DF08C846F
	for <lists+dmaengine@lfdr.de>; Fri, 17 May 2024 12:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAE6F2824A6
	for <lists+dmaengine@lfdr.de>; Fri, 17 May 2024 10:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3AA1364BE;
	Fri, 17 May 2024 10:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="c/KJLzlG"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DB13613C;
	Fri, 17 May 2024 10:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715940279; cv=none; b=AJJzQu5+f1GAG778U8SQkKamfEMd2H1H+hdfm4qIBVmTkmw0Lo6PInBzAAdXRt57bl4E97FE8F0wl/+gorQH9dlOvFokK2cKUerCHxDAMj+dicE/MLuKbYNyL/yPIdXqb3hJVQMyO9RJ8uGdRTKbrFlElgRXLDp8vn9rSGdewoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715940279; c=relaxed/simple;
	bh=i2Ko9ORoSKjnrXURrVqIHdMn1HVNtmQcFRnigKsq7iE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MjljN98KbapPY6LCLUgavtQruul4/vCRQM8yQKvKlSFFS7jzg+yI5Bc+/7HLGaXC1qWq5PFtYgRS8uv3/QF3WL5ExM60IFtbsgN7vnnSmck6mJ1cndtSBRkSuxMldcNFP0Io8b1lAMzYhXtNbmIUDvWyNQauIvZA0OPIOr9KlaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=c/KJLzlG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44H8dS11032415;
	Fri, 17 May 2024 10:04:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=qcppdkim1; bh=tVp8bsWEpuhHxgS2NAe5
	YYR6/PtkD7hf9+9a8rGzYDI=; b=c/KJLzlGA2CbmuXOX59GDmTlcRBVIjNN/Iro
	qSEDgatmBJdniQb8o/PauAEZQ04DZA0gCrKWhq0ljTi0/lurzpaADbzmnY5Oobdw
	XrQX5USBZgiEKhIgutQ2t1WKPUdvdYO8ICFqbwhINGGZwRQifk2WAmnVEtFBOc91
	Td5cZM8kGeCHiAvIQX5OvZpS/D7KvmkxpMHrP+OKlW72Xo2I1vaJ5aP1nIDe8bky
	BBOJ+Nf0AMqRgrlzadaQy/NE5LIwaLSLRhBaShd3mTAsNkzrjaAhy+Tav8u+YTff
	YvufHO/FdFdXrFsJS2ot0BQdwtH3i1dcmvMaXU6Wi2KgIiMB6Q==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y2125p4m8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 May 2024 10:04:30 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 44HA4QWe007985;
	Fri, 17 May 2024 10:04:26 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3y5k8ap6c5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 May 2024 10:04:26 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44HA4PtQ007975;
	Fri, 17 May 2024 10:04:25 GMT
Received: from hu-devc-hyd-u20-c-new.qualcomm.com (hu-rohiagar-hyd.qualcomm.com [10.147.246.70])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 44HA4Pn6007972
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 May 2024 10:04:25 +0000
Received: by hu-devc-hyd-u20-c-new.qualcomm.com (Postfix, from userid 3970568)
	id A28BE21015; Fri, 17 May 2024 15:34:24 +0530 (+0530)
From: Rohit Agarwal <quic_rohiagar@quicinc.com>
To: vkoul@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH 0/2] Add I2C and SPI busses for SDX75
Date: Fri, 17 May 2024 15:34:21 +0530
Message-Id: <20240517100423.2006022-1-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.25.1
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
X-Proofpoint-GUID: D-bLCE5EGkZvujdjKhdNKaqTT8mbiryy
X-Proofpoint-ORIG-GUID: D-bLCE5EGkZvujdjKhdNKaqTT8mbiryy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-17_03,2024-05-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 mlxlogscore=605 clxscore=1011 bulkscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405170080

Hi,

This series adds the I2C and SPI busses found on the Qcom's
SoC SDX75.

Thanks,
Rohit.

Rohit Agarwal (2):
  dt-bindings: dma: qcom,gpi: document the SDX75 GPI DMA Engine
  arm64: dts: qcom: sdx75: Support for I2C and SPI

 .../devicetree/bindings/dma/qcom,gpi.yaml     |   1 +
 arch/arm64/boot/dts/qcom/sdx75.dtsi           | 431 ++++++++++++++++++
 2 files changed, 432 insertions(+)

-- 
2.25.1


