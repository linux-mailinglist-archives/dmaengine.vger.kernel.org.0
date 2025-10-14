Return-Path: <dmaengine+bounces-6835-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8E6BD8E52
	for <lists+dmaengine@lfdr.de>; Tue, 14 Oct 2025 13:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 924BF1892260
	for <lists+dmaengine@lfdr.de>; Tue, 14 Oct 2025 11:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD8D2FD1A1;
	Tue, 14 Oct 2025 11:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="b93A4kPm"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0841E306497;
	Tue, 14 Oct 2025 11:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760439968; cv=none; b=nlVMXGPaN/mUmpTMcPHR1sfnXLBL/DBC00NvAyw2xVS7RjusLvOcrlb4gsw/BmYD60HDMwkhrxe5oOYvUMTUtBQJ4X6vKGJY5iabxZ6U2piuv3/dN3ZIeUX3t0u5LLFeSnBzjKHNmIovVSLr8Srmjbf6gF5NHbeLMldz9GS696I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760439968; c=relaxed/simple;
	bh=Vjzqty5KvmANOaZQP5dl+ZrbAa0wpdf0DE6D6GZjWUs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fN+jkuFcLbMZ3g837F1D19DubVsSpvX1xgMyeTaxti60D6mMiVsK1xI/Oo6YBHMDXb73jife3Bfo89m9n8mcTB+8wKF1sr8699SZqXYr+nb+gteCVS+GvAkv+kiLjOjZZXJUcPQnb4pz0hBgbIZEsv0buW7PD/SL4DG2OoKHdS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=b93A4kPm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59E87JZk025684;
	Tue, 14 Oct 2025 11:06:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zsJo+iDMWp0SnAErS7vcq6T17Sz4ZU29b4PbQx9zgeA=; b=b93A4kPmC3b/1g1a
	VwwVhUSd5flNsEd2yg6AKzkl5n1ONGq6x4FTuiFq+wxGNfW+vtskXGlq03JvF2F6
	MqnBLLn+HIAeqWuQgNrv+rMO93c88pusMd6QgK0G8Inkd1X1rlfzAA4eiqRl6oaF
	3Z16gqYy6NbRPyPew3rQyOyctznftB8Cd5JqEkSIhcS5cLbZ9maOHyZPWr+0FMiF
	lnOQeMaEoGY/yFaTFoOhzJWhxfKj6KpyVwmhhZF34wNZXUCplryFD1kpt8zGNSuF
	LpNO+WpLoocpmMbK2APCZtFVjT/rUeP2Vvzc61si7lkyC97WvVLkUXNNiIp0KR85
	W18uKw==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qgdg026g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Oct 2025 11:06:04 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 59EB63V2027549
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Oct 2025 11:06:03 GMT
Received: from hu-mdalam-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Tue, 14 Oct 2025 04:05:59 -0700
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <vkoul@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>
CC: <quic_varada@quicinc.com>, <quic_mdalam@quicinc.com>
Subject: [PATCH v3 2/9] spi: dt-bindings: spi-qpic-snand: Add IPQ5332 compatible
Date: Tue, 14 Oct 2025 16:35:27 +0530
Message-ID: <20251014110534.480518-3-quic_mdalam@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251014110534.480518-1-quic_mdalam@quicinc.com>
References: <20251014110534.480518-1-quic_mdalam@quicinc.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyNSBTYWx0ZWRfXxUgkWxkb+aD/
 v/irqcCYsmr3wywSkTc/8aTWfNEgnavI3VINqcuvRpJcSUqPu6SEr2rtGPd2kn2rqU0APwMpd3+
 BuVF3Hxn4dcN514qJX/tvS+4YhLRiNHP4k5e3vQ/ssHBe77hfMAVAk/dpFLHIaPVXa02zQjqbVp
 oQREMTSrNWovHkKtH3ZpFjAsxU3HEBvbAPUVkWJJdM3ZH+Gt4oId4wsrLz18Y4OwqzXzVqy9CF/
 SNPXN/FxVo+SelD4rkb84+2HxCpAfWJCkJcSoONt5OuF7BUhwjMfSpHt0khsq8P6wu9bGALpJCi
 TZmGjnkBLuZ1NpmKDmM6enpBAv038d11vfXMKT5gmBR2rioMkNAZGt/980G2+TVsARZUXhqhMoF
 Yw3H+DRGmHlN9PU/nAzCOTeUkgUclQ==
X-Proofpoint-GUID: hQcdscKzV3AThLBfFm5u9GubPe0SonyH
X-Proofpoint-ORIG-GUID: hQcdscKzV3AThLBfFm5u9GubPe0SonyH
X-Authority-Analysis: v=2.4 cv=J4ynLQnS c=1 sm=1 tr=0 ts=68ee2e9c cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=3fGssgp5lnXtaUVRsVgA:9
 a=TjNXssC_j7lpFel5tvFf:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 bulkscore=0 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110025

IPQ5332 contains the QPIC-SPI-NAND flash controller which is the same as
the one found in IPQ9574. So let's document the IPQ5332 compatible and
use IPQ9574 as the fallback.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---

Change in [v3]

* No Change

Change in [v2]

* Added Acked-by tag

Change in [v1]

* Added support for qcom,ipq5332-snand compatible string to the device
  tree bindings.

 Documentation/devicetree/bindings/spi/qcom,spi-qpic-snand.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/qcom,spi-qpic-snand.yaml b/Documentation/devicetree/bindings/spi/qcom,spi-qpic-snand.yaml
index 39e086ced891..7d0571feb46d 100644
--- a/Documentation/devicetree/bindings/spi/qcom,spi-qpic-snand.yaml
+++ b/Documentation/devicetree/bindings/spi/qcom,spi-qpic-snand.yaml
@@ -25,6 +25,7 @@ properties:
       - items:
           - enum:
               - qcom,ipq5018-snand
+              - qcom,ipq5332-snand
               - qcom,ipq5424-snand
           - const: qcom,ipq9574-snand
       - const: qcom,ipq9574-snand
-- 
2.34.1


