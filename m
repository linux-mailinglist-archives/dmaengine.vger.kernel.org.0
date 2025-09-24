Return-Path: <dmaengine+bounces-6704-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B630B9CA9D
	for <lists+dmaengine@lfdr.de>; Thu, 25 Sep 2025 01:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 186A7327E97
	for <lists+dmaengine@lfdr.de>; Wed, 24 Sep 2025 23:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632832C0286;
	Wed, 24 Sep 2025 23:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="khB5Nh+g"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A25A29D270
	for <dmaengine@vger.kernel.org>; Wed, 24 Sep 2025 23:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758757190; cv=none; b=FOdkFSEulle6TgVwIbC/O6xUCx2H1BtuGo26Px4hu+tqDiRXxmN1qt5wnYHcK82cHjCwKb75bkQz3o995vnYUmb1V1X9xYdjHSZ3Dn9MXFU2ZzBWuH2PPWOLfJ3uE/oieOS6UVFVJJDWK62VWTgJbQ0Bb59jmyNoSAd4Mes3Klw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758757190; c=relaxed/simple;
	bh=A0IksIjbcV0zYC0LFQhpwq6alcHDLrjcQTDZDZhCGQk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GDJDHh8r3YUeIeRTzgBYvrA7Do2lfT1ClrSEtFDJ3KYr/e8IY0zQNao/l9BItm09ALmQ+jGMVjg0+hxaQ565hDtlTi0qZP/p1OGvNGyDTLA8Iv7NqkJoWiNAA86JxskYJIC9RE0hIzQLf94gk9qfc5EuXSSywLtarpLyg/el5dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=khB5Nh+g; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ONH7iv025243
	for <dmaengine@vger.kernel.org>; Wed, 24 Sep 2025 23:39:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hPC1lm76vlDPdXNi79JkDIdLpoOcxK4RxJ7uEiMhDGI=; b=khB5Nh+gtJ+6IWFB
	trztuYY8qkUN7zsVBUrVNz4NskdevCUOmptVWraOUcLtUf6vT76AK7/E2Ce/LXX0
	hz03m8YH/SSTwROkY37UfV6WLmui+7lHd64mGMpB8E94QDfEHzvOriRmv1XIXPRL
	x3puyNboZ70HPcZeAYVDk9MWwtdACHzrbDPxM2gPVUFDqfiJPA9+U6RP09EVRsI4
	9JANdWHZhXyKqLpRJrVwAkd8/9/vYN0sDllN8UZjfTq24GNnEWv+uLkx+w+CT2hH
	Z+i/cdh2FDR9Cdh0LwooOnrmaZ/U0AllwRKpY3br7EpvwhpK2Bok17yCzO1OdtNV
	x4Hm6Q==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499kv1633d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Wed, 24 Sep 2025 23:39:47 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b552f91033cso451359a12.1
        for <dmaengine@vger.kernel.org>; Wed, 24 Sep 2025 16:39:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758757186; x=1759361986;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hPC1lm76vlDPdXNi79JkDIdLpoOcxK4RxJ7uEiMhDGI=;
        b=d/TfzHYtTYby7hrXfmAHzGZ7SOcsTmeMYVdTS8zJJ4kqjCBNtXwajqCW/XbslOpPOP
         xLV9Z5Ms/PBKm8zouRXuEXfmj1vLyQVhNCaspO+NGSStUbGgIcCYMmpukgMd0mMmWDcr
         kRzWIaEITIqacIaDqVv6eOVRaD5gXbmgO63lSzWzXx4SWVRBrqICip4wPOfG7YYWMbhB
         xGBzLszlxdk8cno7STA+3Heiz9An8E098FTnASWZaG73vAhoKOyBjhn5o/Vz/p94qhF+
         Rkk2EuhQpju+RPMDVT+rN/xjSifZnPcM1CtRV49pPAcHliwTOPnUwvubis4WYrtWRAOT
         6meQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjMTXoO11luRHwA4C0ejeFVpiPpUoaVsV8m/LrFRwKlTTUxdyHk63RCijVMmnlm9pSoaBlbGhISHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5GVUd+GPmgTNQKDEhNLPKHFlw8glgtRmZb62gh9EmarUW2x9p
	MrKfDeZxmgZf05h+69LiWjo9JZyvw2gefsjHS6t9Go3ZWS2HNJsUpF5GII3Up7DUjassocHqxBl
	PNLNb8EDnqyb6CXqd5J6DHfuQSV2aSD701TWZmD74E4UbGO7IQ4TY67kYOG+vNs8=
X-Gm-Gg: ASbGncsARpo9uuXUn3vEssHapQK9P9E5xJ0sKf8nOJN+TIXVS0du1+WJzURAZ+vGspP
	86g0s8SL1n5x3YXGXi/mOlftAXhVdwzTazN6IqFhlI/4o8jvy6s08fCU8VbM5nFZGtLk3fEt5Zt
	SZtR2eH6uonvQmTUlDtG5k0Zw3HEBo8gT1EABgGjrusQyW9sAzAPnLvCRaXvy+5CZnqFk3drwom
	6+k0VvY4RIz/iJFqF0XvG6LZhQhJHUardXLPT7ng7FDCnHQD/PZ7yJSmmJ4UQGfkA4Mg87SZDNO
	H2gpH+XRJVI1T5CUXUql/S1ZGnXUQnqjsLJY+vUkXP4qAUudmMk9wJcv7h8lhiuBquiK9Fj8X3j
	yLoVAhyY4ZiTFtKE=
X-Received: by 2002:a17:902:c40e:b0:275:4d5d:23c5 with SMTP id d9443c01a7336-27ed49dda8fmr15255525ad.14.1758757186212;
        Wed, 24 Sep 2025 16:39:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKPq3eUwx1CZEeKNquC21jVZ0PQXxU9D92BBNxZRWSMVH82129V619yOCTouhs8MsUysDjXw==
X-Received: by 2002:a17:902:c40e:b0:275:4d5d:23c5 with SMTP id d9443c01a7336-27ed49dda8fmr15255175ad.14.1758757185714;
        Wed, 24 Sep 2025 16:39:45 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66d3acfsm4610045ad.20.2025.09.24.16.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 16:39:45 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 16:39:38 -0700
Subject: [PATCH 1/2] dt-bindings: dma: qcom-bam: Document crypto v6 BAM
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-knp-bam-v1-1-c991273ddf63@oss.qualcomm.com>
References: <20250924-knp-bam-v1-0-c991273ddf63@oss.qualcomm.com>
In-Reply-To: <20250924-knp-bam-v1-0-c991273ddf63@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758757183; l=893;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=lQGY04TW6hNZ4zPeN5WzUrPiJMNqGmAVWl+dWR5SKJo=;
 b=GpR2MIqO5vd4S3PaZFQjY4Fnf+ZIiYb36sfUK5UY5cGR/b97pk4ALaZpsryM2TPl94/mh6NKv
 cqYKn60G45sD59Y5ij5PVCQotxN0WLQj/4JKm2YhMufKEl3MwpTfIon
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-GUID: 0IAxcMRqw9wUmei306S5d8wR3f-orN9Q
X-Authority-Analysis: v=2.4 cv=RO2zH5i+ c=1 sm=1 tr=0 ts=68d48143 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=s6VSgM3AptX_uwP4r18A:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyNSBTYWx0ZWRfX5OTnf5iOXbL9
 sXxC9GW9EkTaC6j3afqvt4qfIWxqD0s+Q39N+lVMR0a5jjM/7WqpOqY6nZVe+GJ0WXFl+LAZnCC
 1+ZVkH4OH5iApnVBdrPaH8NB3ZhzujasGxmuTBXHMHIaI8B18mj30fIXNmzO5EyXBQOqZu2wnKt
 ThPhEEAUZ3mgVCcFbfrv9VHsdpxY/tKVODR4A/90q41mcu0Zd/4aMPmu6F/6m80pBgL/UEVw7Nf
 1/VMrKeCm5Jx86E4BH7Kqjer8VeSydfBxMXvmRHm9HJpp/u7nwfp/yI+BqbWijYbPn/uSJdQBr7
 qergn4jBzrUbo8Y7wKPI+O0E9he0j1vFwafHZddwyMJxFVUW8Pe42CsHZFYCV16k7ixSzc8w9iy
 Wd4l0Yoa
X-Proofpoint-ORIG-GUID: 0IAxcMRqw9wUmei306S5d8wR3f-orN9Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1011 suspectscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200025

From: Gaurav Kashyap <gaurav.kashyap@oss.qualcomm.com>

Document the new BAM compatible which is used by
QCE (Qualcomm Crypto Engine) versions 6 and above.

Signed-off-by: Gaurav Kashyap <gaurav.kashyap@oss.qualcomm.com>
Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
index 6493a6968bb4..4e5b6675af7c 100644
--- a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
+++ b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
@@ -17,6 +17,8 @@ properties:
   compatible:
     oneOf:
       - enum:
+          # Kaanapali
+          - qcom,bam-crypto-v6
           # APQ8064, IPQ8064 and MSM8960
           - qcom,bam-v1.3.0
           # MSM8974, APQ8074 and APQ8084

-- 
2.25.1


