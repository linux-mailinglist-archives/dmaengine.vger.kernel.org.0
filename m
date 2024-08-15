Return-Path: <dmaengine+bounces-2861-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2FF952B7F
	for <lists+dmaengine@lfdr.de>; Thu, 15 Aug 2024 12:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4031E1F21161
	for <lists+dmaengine@lfdr.de>; Thu, 15 Aug 2024 10:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377151D175E;
	Thu, 15 Aug 2024 08:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="A4xYLb0B"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3991C9EC6;
	Thu, 15 Aug 2024 08:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723712279; cv=none; b=ddyxB5VdLkUBIOnP+8vu5weYhNGpGf6A21IWeQ0yhtsqhEmMEU1e/5MmeUdfSiU1IxzhLzp+E0E1UcREpxGtlM6SQl2pqgMppiK/BYFcvndj7XLEYsjF1qoizDpApaFv08qkmsHE/Y+MECcqd/XE4VBi2tgCzV3urCCKnDuEHAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723712279; c=relaxed/simple;
	bh=7l6wGQ98HpBbyXQeXaA1zEMxmFdw15AbADVhA9ODIsI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NGOXjZF8SqTqCyZJVWSD/4E8GWfO5939idU95HrutPiQWnu6l9sNtSIIxi5RQFasEBU++aqTR3c/H/H/5WH1Fjlfj1uG9d5JpoZz5iHmldo9RtUmQGfW0ZCyCzvwktDi1HJmwRhSmjqWwiI+5EsZQBnK4mLkOjd7OLQPrNLwI34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=A4xYLb0B; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47EN9r1t027657;
	Thu, 15 Aug 2024 08:57:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=m7Xggm7ZIW4
	WehkFh4oxlkRKXpkz8aAItTBbl9RctsA=; b=A4xYLb0BOKKQ84FcGw6wikF53nO
	tGe5pzJrP6uQM2cWWRgosonBTd/q154ziowEeq5JB7LYJUSaTWKmsT9Cr54l/OzS
	S67/RWQeMcfwkwqyZlyAdKvayd3kcAURoUOS8OIZMOjWMC1n4zdwCwR0bpaN+5jI
	h7oZrM6t+doQCGgoZNxGW8AENCqKQM/vlTxXJM8LCMaHcYWoAfA6tOHpl6TCnYXv
	nYDZ5kja85rWZvy7Edvf/DuxFINqDKHVIog+pi+mVhEZlp4F3Fe+E9/flJdAVy/J
	2H3Nv9uVy0wSVVXS2B4Ropuq0uuRyCgtd6SwVMAvahdW751rOPY5aoDZHQw==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40x3etdq3v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Aug 2024 08:57:32 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 47F8u85x028275;
	Thu, 15 Aug 2024 08:57:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 40xkmhenmp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Aug 2024 08:57:29 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 47F8vSVu029647;
	Thu, 15 Aug 2024 08:57:28 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-mdalam-blr.qualcomm.com [10.131.36.157])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 47F8vSEm029640
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Aug 2024 08:57:28 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 466583)
	id 8F6CB411DA; Thu, 15 Aug 2024 14:27:27 +0530 (+0530)
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
Subject: [PATCH v2 01/16] dt-bindings: dma: qcom,bam: Add bam pipe lock
Date: Thu, 15 Aug 2024 14:27:10 +0530
Message-Id: <20240815085725.2740390-2-quic_mdalam@quicinc.com>
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
X-Proofpoint-GUID: dPzDTXje2zgTCvSf6rea3MW84dL_nyi4
X-Proofpoint-ORIG-GUID: dPzDTXje2zgTCvSf6rea3MW84dL_nyi4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-15_01,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 suspectscore=0 impostorscore=0 phishscore=0 clxscore=1015 mlxlogscore=999
 lowpriorityscore=0 priorityscore=1501 spamscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408150064

BAM having pipe locking mechanism. The Lock and Un-Lock bit
should be set on CMD descriptor only. Upon encountering a
descriptor with Lock bit set, the BAM will lock all other
pipes not related to the current pipe group, and keep
handling the current pipe only until it sees the Un-Lock
set.

Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---

Change in [v2]

* Added initial support for dt-binding

Change in [v1]

* This patch was not included in [v1]

 Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
index 3ad0d9b1fbc5..91cc2942aa62 100644
--- a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
+++ b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
@@ -77,6 +77,12 @@ properties:
       Indicates that the bam is powered up by a remote processor but must be
       initialized by the local processor.
 
+  qcom,bam_pipe_lock:
+    type: boolean
+    description:
+      Indicates that the bam pipe needs locking or not based on client driver
+      sending the LOCK or UNLOK bit set on command descriptor.
+
   reg:
     maxItems: 1
 
@@ -92,6 +98,8 @@ anyOf:
       - qcom,powered-remotely
   - required:
       - qcom,controlled-remotely
+  - required:
+      - qcom,bam_pipe_lock
   - required:
       - clocks
       - clock-names
-- 
2.34.1


