Return-Path: <dmaengine+bounces-6623-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B01B2B83D95
	for <lists+dmaengine@lfdr.de>; Thu, 18 Sep 2025 11:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71DA01BC39EE
	for <lists+dmaengine@lfdr.de>; Thu, 18 Sep 2025 09:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42D42F39C5;
	Thu, 18 Sep 2025 09:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Dv0nvMyr"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89E22C0263;
	Thu, 18 Sep 2025 09:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758188477; cv=none; b=Y7sY2GSJ8brf/A5nEQ83LGft7iULDShmX/pXrCyqQR/uknpu1kYJNdr3IEQHDUkdw9FKCAyzBOsLXz6t0hiCOnv+lGqfS54k71kSq7M1lArbrSwWh9PmqiJQTbiA1rJld0Wa2pLnFyyUD4v4TsHJqs29zj8kH5Iyo24itLMRYv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758188477; c=relaxed/simple;
	bh=+LHqx+sEcHOkQ0UhQV1ABT9IsBumPaXoc6QGbl6ZUhc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CWX2dXR3P6OrRZ1hb/6Cge5DzjKnpjOkv2Q1FmRII5buNr+TugQDChNmpaZqKmbYP089CKfJ2CHL5m5HliPBf3LKFdu867a9zYLRU9vucU++6EKROS4PvL3XCvF030NNbgPgeR2Fbn/bXnLC+GXVCzGgr02dJXeN+ugJAS29K4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Dv0nvMyr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I8aTcC003337;
	Thu, 18 Sep 2025 09:41:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Iy9vkma+4fqtsOLvCV8LwMyUFXZFRNjX0pvtc56K4eo=; b=Dv0nvMyrkpXTnOWy
	qTTkPcPn60nsbNE7SjI9R8klE3+g7p6sjWaRssIun0rCcbvme/SNlRMjnD8kUzwm
	0GqinDA2fC7uYOwppTbDYrYan7qukM9J+Xm8+sdNWkQ9LoUXJXIEOO0s/TUMVtxd
	AatbjoLwOjsIkpnHchPLRkhzjypd45RE10XWR7Znc7PwsLmZhZf1nxPjPnGeefjA
	tsQhMdJYnSR2VEe2mGFFh3Aakyy6xhYJct95Ns2K1nqNOcIKWa0egPLP1efvpfRx
	98uORGfBgC8eU8/OhOBsuasuf3u/T/I+jd0cUMeK02bhIC/jfi+ADL6t73sp3V/7
	lxYN3g==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497wqgubt2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 09:41:09 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 58I9f8gg029124
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 09:41:08 GMT
Received: from hu-mdalam-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Thu, 18 Sep 2025 02:40:38 -0700
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <vkoul@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>
CC: <quic_varada@quicinc.com>, <quic_mdalam@quicinc.com>
Subject: [PATCH 1/9] spi: dt-bindings: spi-qpic-snand: Add IPQ5424 compatible
Date: Thu, 18 Sep 2025 15:10:09 +0530
Message-ID: <20250918094017.3844338-2-quic_mdalam@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918094017.3844338-1-quic_mdalam@quicinc.com>
References: <20250918094017.3844338-1-quic_mdalam@quicinc.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: P8KtmjzLytOjTKRv1wQsWib2jH5lHl_x
X-Authority-Analysis: v=2.4 cv=HITDFptv c=1 sm=1 tr=0 ts=68cbd3b6 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=xHbhbzFCDHVFC9Sw49wA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: P8KtmjzLytOjTKRv1wQsWib2jH5lHl_x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE3MDEyOCBTYWx0ZWRfX6E64E/LB35/c
 VzQ4XEH/NCGrmjUaLhYuL1As/guNEsZCwy/1rNMKei89ah1VD7veltdOu+SHfn3YcN6hsZistCG
 iNQkF3b+TadtMy5HOQxqrgNnft+IbXUQfhqJDYgHP20A4VU20jcrJzLGBsnEYOs+TIsHJymlAcq
 7cxiBhX+QDRqOsgfa3wXvweDeBL2dtmCsMgAwEaWn9q1LVROP+MvOBp7ZtfdtbxZPqND8JSXZrZ
 IAX0wHW3JolIDeT3aYQBnmtRm1EZfj3I4kBOOBCWRzpxJoNZ1ddBIovGFxIY3l2pThkqE8eGkJC
 JuroOWGFyxs71VdMhd945DyfljPypTUrNQSoreJqNI6Y6Dzt8SMxZzDAgD5AdKv1to34N1mdZJ0
 MWSnh9LY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509170128

IPQ5424 contains the QPIC-SPI-NAND flash controller which is the same as
the one found in IPQ9574. So let's document the IPQ5424 compatible and
use IPQ9574 as the fallback.

Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---
 Documentation/devicetree/bindings/spi/qcom,spi-qpic-snand.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/qcom,spi-qpic-snand.yaml b/Documentation/devicetree/bindings/spi/qcom,spi-qpic-snand.yaml
index cb1f15224b45..39e086ced891 100644
--- a/Documentation/devicetree/bindings/spi/qcom,spi-qpic-snand.yaml
+++ b/Documentation/devicetree/bindings/spi/qcom,spi-qpic-snand.yaml
@@ -25,6 +25,7 @@ properties:
       - items:
           - enum:
               - qcom,ipq5018-snand
+              - qcom,ipq5424-snand
           - const: qcom,ipq9574-snand
       - const: qcom,ipq9574-snand
 
-- 
2.34.1


