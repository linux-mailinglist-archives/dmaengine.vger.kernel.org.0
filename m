Return-Path: <dmaengine+bounces-10473-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eF0TElghBmodfgIAu9opvQ
	(envelope-from <dmaengine+bounces-10473-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 14 May 2026 21:24:08 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F3654653D
	for <lists+dmaengine@lfdr.de>; Thu, 14 May 2026 21:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5BA7C301D680
	for <lists+dmaengine@lfdr.de>; Thu, 14 May 2026 19:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6B43AF657;
	Thu, 14 May 2026 19:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ANQTRXlN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KVEUprMA"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB61F3A2E0C
	for <dmaengine@vger.kernel.org>; Thu, 14 May 2026 19:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778786642; cv=none; b=Nxu2XnQdEnmrFuCEXwN+Z1sHX2GU28SJCZmgzLnAi5D05tU0an/i8C/DnUUUXx9mKytIs8BmjR+A20v5YYL70glAttR1i6W/Kfm3pUidvD8w0N/UJiaSLRwfznYuukhRYMQkhBFTJkU2bVsLc0VTo1WPSErkD0I0Xya53sUYLqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778786642; c=relaxed/simple;
	bh=9LHKkuPjIGbAag0Gr5ZhBlMR4hP04+zuByF059wsxsQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I6jm3RqHXPPq4eKjfc/m7d1lA0KAVlsxKY/Yqw/+qhB/imbiGkUOYXfVSfIqydirSO1uAPwi4ZUqWHmAG/uYC0aKUgS+tT2jYuJ0JkgusRn1Ecqnko54LtqT4ekaeV6jQGHBbCj0lN2NJBdMFaGGbRyGdhkvDZpdNi7ayxjQuB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ANQTRXlN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KVEUprMA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64EIpSKq655515
	for <dmaengine@vger.kernel.org>; Thu, 14 May 2026 19:24:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CiWOrn7rZILw07irq93/F/Sq8L4fIVklfmaSat301H8=; b=ANQTRXlNQPKI06co
	3TQ6L9DvfJdCIOgUBTILk02Dg7xCJPB/Z7MVWMNSW/POZZN+lX3X+/JnEzMX6mzE
	nNxRISl8zk6CPM3RkT6bM8vHgcfGkKCbUG6yh42gCufZLj7wljU44iaCVZZDZ10d
	OvH+xsnINc6gbzzMf3vuVRnZD4NnA8eV7FaONG6CtGaqmLnnCYWaHx0s3JNR1gyR
	kF0Q1iohqbcDBa9qMt2IpfeZoUpQCvD8ZOXr4ppbd6sN5jZmzAnMYuBS42JmxKZc
	UgVmdO4LBAE/P6c9jLaiNqF7ldozNz9+UBEFqCzJ/AiKJm3QpDLr9lSZ3v08Shnn
	Xcm07g==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1pr3u8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Thu, 14 May 2026 19:24:00 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2bd6aeb3637so16006645ad.2
        for <dmaengine@vger.kernel.org>; Thu, 14 May 2026 12:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778786639; x=1779391439; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CiWOrn7rZILw07irq93/F/Sq8L4fIVklfmaSat301H8=;
        b=KVEUprMA//syhepRuidKQGOEZcUaA9m0EUl5VZwT0wucBqBIAd4QfqYhnet6Fcvv+p
         waAXbNdpcJ2hl2494XFFbKnnMQgi1MkRuZ7ZsnYIjcvdIa8CVgFpRLOn0bgN1+s8nXo2
         5XXISwR29qPUxWoqS3BCQKiooi8YKhbU2wgciY7suoFCgRgPzRNbWFxdj1l2vnYzMfoz
         Vq7oY+6c27VuSYKrbVqNaA0wkyOlumWrP2C8XH9HxBqVSlqdAxtRJvZcOexW83yRkwcu
         zgUk5gOwS+ZwanS1/i7lgHyGQHCF8tlffELQAwTVwfk8pBL6DGWntF99dJ4Fpcf0a5Yz
         sRVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778786639; x=1779391439;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CiWOrn7rZILw07irq93/F/Sq8L4fIVklfmaSat301H8=;
        b=qc84v03Bvr5rDzQwQD+3QGQTQJmwZ32mIEP72/7Ekn9x/M4+RH6MhlD87nSjuIkN/7
         B3ZxbXJPoB57+ATKsC0dYfeHu7XtL4fN1TEFMwc96PlcvW/jYLtclfurnr7rEtsK5wll
         0x9ZvtllWKHW38H6tQmJrKNfhCxroj/o+SwV2oFmYNGXMuriPJibkYvS9Ijkl+pSYNUZ
         Q212PL6eWXTc6xhdPTxypPY4tJfnZs2NeNU4wqJVIQYvrqQx1Cul5U1Y1zSOv1Ao+WzX
         mhmJ4zxvioWujpJd6WACZWKTrd+8ILlM7RfI7mwyxcrGW2JGFDzi3OtiVVxsTtUoS7yf
         M7pg==
X-Forwarded-Encrypted: i=1; AFNElJ/SR2NGshD9TUuVtSszkl8WAQG9QcmtVY7setqUBEYE9mu3tDwKThCd7v38NnM24jx8Ec6iw6wVdmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhFIQRxg4ox+JotLH++R8JqfnU1zUDa3tUTZY8P3yNVU5QdD1o
	3ZB1CFTHWBfrxsFtLfLPy/LRXxiABmp8yzTvtQa7kj4KPLxn2AknlwU5b3zasl9robSieUL3xOp
	SdSwBZoa6yOVaUx3Kj5+QCwkIUUAs5760KT1NijiGJ2GOlqyHW96Sw3YlAOqXHwhCeGtsaW4=
X-Gm-Gg: Acq92OGofU52+B+WMDmqwz3Igsw9L2FNmceTbR+X3oryQi+EPe1Lz2nm1YDnzS1OmaL
	fcul7iAjtJesYhQSIpsJVZ/Zyp9iQm8ujhRRbY3dg5bY2s59KZkbBp3LNx2htvTlyRY13hfRuvu
	f+uMX9I73Ns7fo1+jO+ndzQdSUy79xEmmx2sW6YhYHa8uUYIeTVktqG6pFpcIM2m9+csqkoC/W/
	tQ+2o/JGKACDV8joa60dIVC045MSWf4ShKKgXM+44I79WX2o7vQMpbSEzfHe/Iv5HwKLuuNYBBK
	5yiW8sLuGNEW4HAdJ1Xq56mcUvqUSMrl9VE+bDSlTFy00enE/+ZNS5EfoQMm1JXuhAdPR/Ua6jq
	nLZ4yWpBiDufVozRc5BuFMz4tD80FPUdZU9CRA54OaSe7NuObUdiQjVM=
X-Received: by 2002:a17:902:f38e:b0:2b2:4d36:7aa with SMTP id d9443c01a7336-2bd7e8cbc80mr7251485ad.35.1778786639393;
        Thu, 14 May 2026 12:23:59 -0700 (PDT)
X-Received: by 2002:a17:902:f38e:b0:2b2:4d36:7aa with SMTP id d9443c01a7336-2bd7e8cbc80mr7251275ad.35.1778786638895;
        Thu, 14 May 2026 12:23:58 -0700 (PDT)
Received: from hu-kuldsing-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5bd5f291sm35506535ad.15.2026.05.14.12.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 12:23:58 -0700 (PDT)
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Date: Fri, 15 May 2026 00:53:36 +0530
Subject: [PATCH 1/3] dt-bindings: crypto: qcom-qce: Document the Shikra
 crypto engine
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-shikra_qcrypto-v1-1-80f07b345c29@oss.qualcomm.com>
References: <20260515-shikra_qcrypto-v1-0-80f07b345c29@oss.qualcomm.com>
In-Reply-To: <20260515-shikra_qcrypto-v1-0-80f07b345c29@oss.qualcomm.com>
To: Thara Gopinath <thara.gopinath@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Frank Li <Frank.Li@kernel.org>, Andy Gross <agross@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org,
        Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
X-Mailer: b4 0.15.1
X-Proofpoint-GUID: VcO4hK1_HdjbVMGquJ-ZO9Vy5UdTxsdc
X-Proofpoint-ORIG-GUID: VcO4hK1_HdjbVMGquJ-ZO9Vy5UdTxsdc
X-Authority-Analysis: v=2.4 cv=GrhyPE1C c=1 sm=1 tr=0 ts=6a062150 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=pQ6rRVY8thx0fpBeU8cA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDE5MyBTYWx0ZWRfX0MnHDekzHdGo
 hsw7FN39vy07xDTETQG69iCMOpo00/6f51Yl5LNigAWyi1ubXYYn7hVG4graxcL//j+MdYFdT4g
 DK5uzo/mQ3Drpzq5+Y4j3oGTYtli9c9tGuRhcaExGSfpRSdIY4VI+yscE1IvLIxzDwv+SB1GdY5
 5JC7S2sEkmH7hUNiJzqnZgXmNMpb8ixm1PONJZaZtaioK1c8l8+sUqFIR1r1P4jAGd6+IfmMUTz
 4GDUJtC/MQ7Jnt7zFVOdFKtLaYdhyw3W8xyYsaEbTJvGu4O5oq1Xcy6kwi+Kw1NIL6d9GVWxucs
 9CO+/Uz0p3t4NFHcCc/+rplFCv8KRx/jFWyv/VDPj3a6CdRogfVjV0HNCIkYJR/heKvapdw8/vU
 LADhNL55+/vel+JLwoZ143Vv+ntlnyNUULcQ6bai1GtKYyRo3EypH6rersnxz1k7XXXJA5J9+3i
 IkIxEvMI24IqnF4aV2Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_05,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 adultscore=0 bulkscore=0
 spamscore=0 suspectscore=0 impostorscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605140193
X-Rspamd-Queue-Id: 23F3654653D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10473-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	FREEMAIL_TO(0.00)[gmail.com,gondor.apana.org.au,davemloft.net,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuldeep.singh@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Document the crypto engine on the Shikra platform.

Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/crypto/qcom-qce.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/crypto/qcom-qce.yaml b/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
index 69101cead3bc..ad0e1cd3a76a 100644
--- a/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
+++ b/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
@@ -53,6 +53,7 @@ properties:
               - qcom,qcs8300-qce
               - qcom,sa8775p-qce
               - qcom,sc7280-qce
+              - qcom,shikra-qce
               - qcom,sm6350-qce
               - qcom,sm8250-qce
               - qcom,sm8350-qce

-- 
2.34.1


