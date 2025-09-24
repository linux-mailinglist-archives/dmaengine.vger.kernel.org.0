Return-Path: <dmaengine+bounces-6703-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A543DB9CA99
	for <lists+dmaengine@lfdr.de>; Thu, 25 Sep 2025 01:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDF23327984
	for <lists+dmaengine@lfdr.de>; Wed, 24 Sep 2025 23:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C752C2BD5A7;
	Wed, 24 Sep 2025 23:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K6F2lSwb"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA3F28DB56
	for <dmaengine@vger.kernel.org>; Wed, 24 Sep 2025 23:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758757188; cv=none; b=i1J+oeM1LvGh23i1l2v9zmpTaU2C8GQt5HFv4VaAeidY+N0Lkuozg/hJT+tFdjn9GGYaATkIFvGpbbRWeyHYy+jbqyoPj1L5Y8cwZ3/rxIr06QCaj/CadYTqnZEnTyBPMxdFFwbGeh9T6d5TL6+70J9uErxlZkxnVYH/UWMdwWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758757188; c=relaxed/simple;
	bh=8eg+cFbUEqaa8C2+ywYwrps2m9GMnB3ORI9ICHtWuIM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=btKyYPZ4zVUux929OkRjLWnpd8HyhFhqyNDqqqTtwWAPdx5yoSXzLdgOlNAYSs7CjWS5yEdA6NzZhmgVWfZccpoJAG3OdlvnHO1+ooD4o9BPF7LMgk31UmDL4K20uyGm5n6nEIyhE/m08rJdRuYvcdCO/gCtomI4U5XCgHZoWWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K6F2lSwb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ODLLN3025133
	for <dmaengine@vger.kernel.org>; Wed, 24 Sep 2025 23:39:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=lO7q2RANT9ES5qL1pkzUDj
	0lrisGLmMonlVDVUcD5ZY=; b=K6F2lSwb9ptydWfM/GEgQdtIwjDpWbjdKf8eGi
	gOqgRzFaWjegp8ogQoDC93O8x9zhudGSDQOVcQMbo7C5z04ppknJn3MfE8mi9JIN
	z2u0zyI8xTfX0WZXEcEdCZLZX55rJXmEsAOgBFHOw5utFRr+NG6edGN/NwRqo3x7
	SdYqkDltigzjQLPsiRGEyGjaDM43Ua5vn9xNKySRSEoVR3a2zsjkfZD2tkBcHsib
	6wr6J6Uz6LK2Qao//wpBZLUdPdOrDm4Rj3Q6SoYS/Q++4e2/SsvO+Jfo7b8pZkNI
	yrCmkU/14QpjC+J7CWGezYD6rRCkPzb3U+YX58B361suLrCQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499kv1633a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Wed, 24 Sep 2025 23:39:46 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2445806b18aso3066645ad.1
        for <dmaengine@vger.kernel.org>; Wed, 24 Sep 2025 16:39:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758757185; x=1759361985;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lO7q2RANT9ES5qL1pkzUDj0lrisGLmMonlVDVUcD5ZY=;
        b=esq7QnNdVaBqBJq+F0KEkzpLKfoq1+G8QiSFod6+DNuRuH3EeXsFyJ68ooLMPr2xuR
         7ui8ldWP3d4rEZ3gvoax859Mxgo5RCOkI2SPH2gNDUpc6Zj/XnpkILCBe5gZGrNtYO5u
         5gPT3nWAnc3F6LF68cVhhNReQOeXNz25xDsLDDcMd8wMgzB50lj31PBiXqs1/GU3wyTc
         qufSA6FSiVIDqSG/APnEjO3QrGRJbD1aacb0/sY6QIxdOBDywxce4We4iXsqynzqlIWG
         f42HVGtDLLZ41PmVdvhaTEtIJxwQ1xM95umsqRPCOe35/j2axCCPbZrxST+fpFFtuWMp
         xmdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZqj6wXKgmRs4KP3NfTiL9TEAS0ql4/Hl0pKPedISgxgv8MJeUi57iRpw5DrFTrRWTJL0ASTXZXUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNWFgWKqH+1NpFSVQ9rMldHV49q3Vitjyw4b+Oo61f/F4BCFqj
	q0eo5uvfrfQ/MPwiDIVt4GRWgBgOl7hDBiq8OumOEjAX0pM9f0avSfhHUNnXkfcgpjzHcN8NTa3
	xzWAelM6zGoR7J9mDbf3n66RBT8bafXERhzyd+S5BV3F0sDtrbs0HIKr4aQzlTeo=
X-Gm-Gg: ASbGnctXqzbqSeAZvUzMdhdw7M4xMAFLbD1Rh6UKLIij9gXCtLV/J+KrtFuY+FR/y6g
	1QBhoEpcMuCsL985Z0mDPj4KGZMWnKryxV9zZwvkybu52oDqChQQzpmHiU54u9RduxfryGs/A8k
	w7qT3NyE+3HVi0Fsw4qmwd3D8J0fG+7cLkuzC+3dM+SMApyMOKEL9b+x9fMlhCZGNEaWH9J5eER
	h2pcZZzVsU8I5rKAlJyPvO/sQv9WW+s9KFZWq5wrUWjZSWce5uKtN1hKqW3vMoKfraOBLolM+bw
	BVWbDsfLP5R6bjSNMr+0rK2lLD2+yO9jPkmPVULcg32Q3znzRnBggYocmdvuoZdNN3zpOFgQ0gB
	GyFtyqj9PH9SoDSU=
X-Received: by 2002:a17:903:fb0:b0:264:b836:f192 with SMTP id d9443c01a7336-27ed4a2d511mr14977985ad.35.1758757184854;
        Wed, 24 Sep 2025 16:39:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGujwWV6tfUzBcIXoD7V5YBetQqmOFWFQHfV5bVrd9ni8278A6y08rnlQHTY7mPsWxSLm124w==
X-Received: by 2002:a17:903:fb0:b0:264:b836:f192 with SMTP id d9443c01a7336-27ed4a2d511mr14977815ad.35.1758757184427;
        Wed, 24 Sep 2025 16:39:44 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66d3acfsm4610045ad.20.2025.09.24.16.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 16:39:44 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Subject: [PATCH 0/2] Add support for crypto v6 BAM
Date: Wed, 24 Sep 2025 16:39:37 -0700
Message-Id: <20250924-knp-bam-v1-0-c991273ddf63@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADmB1GgC/x3M0QqDMAyF4VeRXC+gtSL1VcYu0i5qEDtJRATx3
 dft8oP/nAuMVdhgqC5QPsTkkwuaRwVppjwxyrsYXO26OjiHS94w0oqp5+A9hdikFkq9KY9y/p+
 er+JIxhiVcpp/+5VsZ4X7/gJ7DfKGcgAAAA==
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com,
        Gaurav Kashyap <gaurav.kashyap@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758757183; l=659;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=8eg+cFbUEqaa8C2+ywYwrps2m9GMnB3ORI9ICHtWuIM=;
 b=x94gWnO2PZ9XUBaMDycBf8LYB4ff8yEt2NCyz5lQCK9EKjoMLizUhLRyQuSaVmwuiH7fuwo5X
 FeIw9pWGKN1BYhdt9yG+VDtUuviQ9TAM9911G+GYKhPfmrReaz0M9R/
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-GUID: 0tibdT6WM60Qo08tFSDn4w0x2HHcgOaA
X-Authority-Analysis: v=2.4 cv=RO2zH5i+ c=1 sm=1 tr=0 ts=68d48142 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=czLK3_onmIaUr8cMAWMA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyNSBTYWx0ZWRfX8k4UVBlRv9kx
 ujPp8kOPzbJMBaieshvmtSYLJRjHc2KRFcevJEB7vQLHo2GWfC6D46RP738PEYNymjH3LbQohjb
 cJ7II16Z8rQDZ54z5V47P5SaFgj6DTJgpHoXzxFvLxM9kXSEq/6c3Jxtz8rmdFx9fgh0gNbTX24
 xdMUm2YHlv3H9IVwt2RdrYunLZKIxoaZpc+Bl2tQ6A6+v3YgJW1LqlJ26ppGQdTiZ4GmjajlsJE
 jQ85Vurw1nc55LkWKEe2209b2CxaUquI7sD4uqgaYx6ytcdZ6/5+EdO8U4di0P52jUGbuNFxU3A
 tX3MePIpvFFqykdO+OXKbixeTaitY6ddV2rta8Wx2WAsZ6mXE0i2HVTwrQGa9hduXz4gyk9uTAv
 OtqOvC9M
X-Proofpoint-ORIG-GUID: 0tibdT6WM60Qo08tFSDn4w0x2HHcgOaA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1011 suspectscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200025

Add document and driver for crypto BAM which is used by Qualcomm Crypto
Engine version 6 and above.

Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
Gaurav Kashyap (2):
      dt-bindings: dma: qcom-bam: Document crypto v6 BAM
      dmaengine: qcom: bam_dma: Add support for new crypto bam

 .../devicetree/bindings/dma/qcom,bam-dma.yaml      |  2 ++
 drivers/dma/qcom/bam_dma.c                         | 30 ++++++++++++++++++++++
 2 files changed, 32 insertions(+)
---
base-commit: ae2d20002576d2893ecaff25db3d7ef9190ac0b6
change-id: 20250922-knp-bam-c7e944a9b1c3

Best regards,
-- 
Jingyi Wang <jingyi.wang@oss.qualcomm.com>


