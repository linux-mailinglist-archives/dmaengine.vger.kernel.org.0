Return-Path: <dmaengine+bounces-6778-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B122FBC4146
	for <lists+dmaengine@lfdr.de>; Wed, 08 Oct 2025 11:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 33BD4352CD2
	for <lists+dmaengine@lfdr.de>; Wed,  8 Oct 2025 09:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4775F2F28E0;
	Wed,  8 Oct 2025 09:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JQV9EfnI"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CD52F5496;
	Wed,  8 Oct 2025 09:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759914289; cv=none; b=K6yuVinfXqFV3cWTiJzuI3ktoCMkDBLTBC7R+qxxMSGwRX6eA+evogI3UrsZMbTqdQY4/QUGbmza5atAfSt8B+mZNZY4z8bQDrXC/7oouzaNEySSdxDhmV4A9MpNmj5sOV9f4b9c2+kex6uz1a7jpYSkU7x0vqXwL8d9lZVOUqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759914289; c=relaxed/simple;
	bh=JP3fK/zh0A1343UQm5aDeGPvycY9lBKw3cWpqrrZz8c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wsw/mGC5jqDIJjSm3GwDbU5r9pg6xpdaZ+iiR4Dso+5tNC3/8Qk3trMPsWo7e2ezdNe9ePjsKHo2JjIiEO+iZf7LFpld96Um3yimwcZVnOiYv+aX2mqQ/rCZPZGsmOKaN9NTMbuFHxW9z093yCFY7pf7Ef/iUEDeZUifvsA6qTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JQV9EfnI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59890ecH002274;
	Wed, 8 Oct 2025 09:04:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	REEOMpsVR8aBd2/9+r1jHs2jFXwzZn51gCJSnTbdWdg=; b=JQV9EfnI+MJ4Nkfw
	gVngYtTTgpSKMSi40ia7zUBLK0FfncUx3xDEHpAVwvuQ2f2nzD6Yi7V2ILT5kSFl
	nieCSc01O4cMORndJ7N44HSLZ9D0OCZbOIXmSMsxpU+WpSg24jHezUrTcwF8w2r/
	2YvaBpIt1Om4/upLJoyoB7RtT1y6nif+YXf79MH5t6Ee0ocGK5vmeLjc2BQDqsF5
	EWXOa6OwxPDacNtYer17hdiJvY9TUwpsbXsM2uz6txeVJcbCU+xfkGkUHm1Qyjp7
	roRDsZZBNdBdpt/o9F/Jxiusotdh4wMlkDnokKNh7qISm70eAoH07rUue7oG+Ejq
	kzkeXg==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49juy71vfc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Oct 2025 09:04:44 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 59894hnb002541
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 8 Oct 2025 09:04:43 GMT
Received: from hu-mdalam-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.24; Wed, 8 Oct 2025 02:04:38 -0700
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <andersson@kernel.org>,
        <konradybcio@kernel.org>, <vkoul@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>
CC: <quic_varada@quicinc.com>, <quic_mdalam@quicinc.com>
Subject: [PATCH v2 2/9] spi: dt-bindings: spi-qpic-snand: Add IPQ5332 compatible
Date: Wed, 8 Oct 2025 14:34:06 +0530
Message-ID: <20251008090413.458791-3-quic_mdalam@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251008090413.458791-1-quic_mdalam@quicinc.com>
References: <20251008090413.458791-1-quic_mdalam@quicinc.com>
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
X-Authority-Analysis: v=2.4 cv=IrITsb/g c=1 sm=1 tr=0 ts=68e6292c cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8
 a=3fGssgp5lnXtaUVRsVgA:9 a=TjNXssC_j7lpFel5tvFf:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: r2UpmPFwEPnQMhlSPuG16fKchisQ5r51
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAyOSBTYWx0ZWRfX7Den846HjTUB
 9fyQuwgKJfdVTlbpeOibxPUFOYnm94TzQzWDvm0emDQ4Gw9bK1MMnB6Tz4kkphYmoSxb1zOu4/P
 Qpc12/3mC/G2siYFSglu2phdq6fjMI+hrGiA7H3cKpM8T9Mh/jfoB0HDjd/UoQgG1IUNErUTIYv
 hAxzjq+uTycKwQ3qqezt0ZZUZhVTWLM6nRXtDVG93J2LqHPHu8TNadN9UAZ7cfRk97lJulT4CFj
 hkl9m+qInZF1dARMNsVEzajr5UwTaIwPMsaONl04XZgGQ3M+SZBw+DDgOhSIT58cEiK6Z7zFWBi
 PeJ6U2kikZqmSq6JYJ7mKGtPJA1re8yPENB2yZd9TFj4x0EY9ZZkul9HpL//RCvr3aMh3yptBtW
 mmCh17uyj5uMGAUqUGvaQgq+LEZnyA==
X-Proofpoint-ORIG-GUID: r2UpmPFwEPnQMhlSPuG16fKchisQ5r51
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 malwarescore=0
 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040029

IPQ5332 contains the QPIC-SPI-NAND flash controller which is the same as
the one found in IPQ9574. So let's document the IPQ5332 compatible and
use IPQ9574 as the fallback.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---

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


