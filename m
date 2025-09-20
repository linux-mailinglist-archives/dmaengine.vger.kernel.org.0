Return-Path: <dmaengine+bounces-6663-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD55B8C927
	for <lists+dmaengine@lfdr.de>; Sat, 20 Sep 2025 15:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4194582DF2
	for <lists+dmaengine@lfdr.de>; Sat, 20 Sep 2025 13:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C862F25E8;
	Sat, 20 Sep 2025 13:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PFag8S1d"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9CB204F99
	for <dmaengine@vger.kernel.org>; Sat, 20 Sep 2025 13:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758375212; cv=none; b=DADgPzoN6VcpTKeaz+sR267QS70eR02i3t+DC5Hb0KibFp34U2Td7l17SYCfY2v3NS46VXKxxqh90eKTTf2m0RnsMxpp8LTPiF5BqSdXypKk2+o6RQS0tJm8PTT6DTyr4jPUSUYGagGpifEF7cTdBf0slBaPh3DNUsKOTn3fZe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758375212; c=relaxed/simple;
	bh=F9TNTcJ72Xy2VjV6mYwy+LXLtuaD1jREw8ipqjoUmO0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ot2r0Bo88scn74Cc7cJfOcFgRQJ1TWUi32kyZUfpzQsOXyJKtfglPX+/TYQ0EjRq1SRqqbX9/+DbiQxC6kSXcWGMRokU3gvxF1ALvB7BioeiJ3lT/8M51VW4xwXRsyKCIJMonoIJgocbujXlTFYzHRbgtduohRZ2RkYuzvf4XYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PFag8S1d; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58K3LLGK007587
	for <dmaengine@vger.kernel.org>; Sat, 20 Sep 2025 13:33:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=wQKOe8P2vr8uFWPix5zvIsvn3idrR/hD0KQ
	7uhrpj7c=; b=PFag8S1dtcbglqAqrkRrP2bzkibX+1yi0racELwU338xbW54JmB
	7J2aR93BTbKfFwm45AihfH0RSd/h7AYy0O4YTIHGjRxHMdwxO26dkqllIL/SSrKq
	H9+rvLV9IJBsw/yrAYLX9SQVrqTvsMNMcJBsRk/WIIEsPdPBFYQSVh7YNNAyf0im
	8mPvSa0iEkOmie7v01cLklRAO3VgJ5RtBRb/73K7i5haLl7FYbl0B815QpwE+2AN
	QO0VNUQ1gPt2cUp+4S9vLZuxo23cvjRM1o5qdtATUK/Q8Uf5MiwANb2/k6d5xOCx
	5q3p/ygq7Qt3S3Fdop0Z93KaEK8LXrxorrA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499k988unb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Sat, 20 Sep 2025 13:33:28 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-248d9301475so42117135ad.0
        for <dmaengine@vger.kernel.org>; Sat, 20 Sep 2025 06:33:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758375207; x=1758980007;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wQKOe8P2vr8uFWPix5zvIsvn3idrR/hD0KQ7uhrpj7c=;
        b=Y65FUj1x6WkgGXhnwkYka9jbyBDLcbsZj4tGFSvo0/XUvq54s8p2rZlAEoZZQNVidx
         ydP+kTQUQx03rwP88Kd1Vr174P++2OXSCUpB8oBqLj/CL9sOaaVMu8QGqmwdLoDPdiHL
         ZzVWLvZ/7mXLaE7L8L5xH3AjA08JGgKYlsHPqI9zzXnztGlmFQqGMTJl408pJBiithZb
         59bADCJPR2fPM6uhfE7hT/zMkgvI1d63WnJTPkNMmZKj0LNQLrQlSrksPKT1SvhoPij4
         h0yZoLSxWTz0WutMkYSHk9I1MI6Rpfio5lcuHePN8trZhUEMFXt4au/gqem19HflcCpa
         yVJA==
X-Forwarded-Encrypted: i=1; AJvYcCUY3GRkE4R6WLcjOoYmujD6nNCfEJ3oamGkgddL+ta92b9nG+yJttEBR0bxIyxFHECcIXOwjxNHPi8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDqBPQdbnE2gfy5DlC5PyiECbNCbpOYiWpPQsQlSlZAkTEV8yG
	EaVUEny6MOoIfsVquodkKqHj/eEispxCWziOvoReMhHFPwhVOBPkHceo61lXmq8d6aGOoMPAb3N
	lc5JSA6iqkjuEPrJdZDqD9i/qiGx3GSYrOLNo5CYMDEhDOdNDzLQWbXnYGWW5E2o=
X-Gm-Gg: ASbGnctY5T3lkosN+INuPgmsUOtgGsekgrxgnJHguGYq7vFx/EyhmLQNxxNYu5eMoTV
	xuNVpfbDZ07i/OyzMBPJxJyymWxyjzYlp65QMku+eRWY30j9PdZ7DMI600tyW6KGJBCjxiMY1JV
	QBz98K5tyIvNEqzrO6jl8Rw4rWR7YrqbTUlHbDnZR0+/qCsMG/uK5A7Y/5eJJ27XExGhvVU0Uqn
	egAjTS0IVauTpCXYGYldozCRCjMG0INMIqAbq2p5NXKx6mkKFn5J+NF9TM6Ncc+4g/HWVJ8LUFu
	xu09zMz6xQ51+gOJxDna9M63xuD4a7CwNHi/njoK/SeHxLZCDi3pqxk45t6m3bbRcRtQOxBdGIB
	6vsg/mLQyK/AJqKAsWfBbRjU+q8qj4E8S/QDhwqlHJwth19BiyrR1/86rklrW
X-Received: by 2002:a17:903:f86:b0:267:16ec:390 with SMTP id d9443c01a7336-269ba447e48mr101206495ad.17.1758375206964;
        Sat, 20 Sep 2025 06:33:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESKYfIbIXZygaF2oDpOFzQL0vr9vZbzkA5zah17knkO7iUUouvAhI2R+Ga4XBlOwc7OXlIyA==
X-Received: by 2002:a17:903:f86:b0:267:16ec:390 with SMTP id d9443c01a7336-269ba447e48mr101206145ad.17.1758375206492;
        Sat, 20 Sep 2025 06:33:26 -0700 (PDT)
Received: from hu-pankpati-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32fbb96f3afsm5375009a91.3.2025.09.20.06.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 06:33:25 -0700 (PDT)
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
To: vkoul@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: dma: qcom,gpi: Document the glymur GPI DMA engine
Date: Sat, 20 Sep 2025 19:03:05 +0530
Message-Id: <20250920133305.412974-1-pankaj.patil@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: YOMBtiOcE4n3g-hoLRpNJypDM_hHo27z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxOCBTYWx0ZWRfXxPSLLo4+ZmR3
 1sCRCcv77WQqkr2c0XMYibfC+BfOlPsGUX85wRBdtxHcwGVvW4Cpx9JFFZQ4CYtrgwkV8o6VrZZ
 RpQQ2ONjG/jVSgo+ngg2u6QZFOPtasBPyIaoYqC4qOv7uKA5u2sZIHvp0Vscd2xxEvBO5iK31vM
 rQBlYhWgTt93irCOo1tCsMTTSbSooLKtEv6fetH64LphpGklSr9aj6U7meAjCBkF7Cj21Q/5/bc
 zRRv0IO/tmBCAhvHU41vDeeSG3i7Gs3OIRqhS/U9a2KPOqSX+HihXFRHoN/dkziNslen1TLFoET
 qMkhlPJT9zn4b6ldr15LLq9HtGAIqNOy8aWOKTSxetAiFYEDkazFJ5Nj49O7MBTDYzNFM6xAeFE
 Fuge2rYT
X-Proofpoint-ORIG-GUID: YOMBtiOcE4n3g-hoLRpNJypDM_hHo27z
X-Authority-Analysis: v=2.4 cv=Dp1W+H/+ c=1 sm=1 tr=0 ts=68cead28 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=HaAzngDW_a_fOyBJVOMA:9
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-20_05,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1011 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200018

From: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>

Document the GPI DMA engine on the Glymur.

Signed-off-by: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/dma/qcom,gpi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
index bbe4da2a1105..d595edae4f44 100644
--- a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
+++ b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
@@ -24,6 +24,7 @@ properties:
           - qcom,sm6350-gpi-dma
       - items:
           - enum:
+              - qcom,glymur-gpi-dma
               - qcom,milos-gpi-dma
               - qcom,qcm2290-gpi-dma
               - qcom,qcs8300-gpi-dma
-- 
2.34.1


