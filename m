Return-Path: <dmaengine+bounces-11324-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id crVkGYvBJmoskAIAu9opvQ
	(envelope-from <dmaengine+bounces-11324-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 08 Jun 2026 15:20:11 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFCC6568C4
	for <lists+dmaengine@lfdr.de>; Mon, 08 Jun 2026 15:20:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=f0sXGvMY;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=JUCxNTka;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11324-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11324-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 40CBF30391CD
	for <lists+dmaengine@lfdr.de>; Mon,  8 Jun 2026 13:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E2F33D6F0;
	Mon,  8 Jun 2026 13:10:49 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0623431E7
	for <dmaengine@vger.kernel.org>; Mon,  8 Jun 2026 13:10:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780924249; cv=none; b=N42OW0T4C+2YP0g7tRlM46McVOKqFthI90ulEtto2Al88cNCngDBiNiO+pzO3Mp12T6jEvGPBG1mbvIW7EuxSP1ZuGKw81Gotk05vHvoKFTbqOodmHGK1zeskxpmrKV9SANnFNsQfk0I80Gwybk0LPO3iYdcH/6fbhBW27FFrk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780924249; c=relaxed/simple;
	bh=ue5t/Mkn+WXC92cP5D+ch+Xn4xQc5TBGd665tzA8pzc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NB6nRiv9szNI+9IDCiJv5nulwgfY9N+Tqj5WC2lIJ3J5oAr0Qsfe69HBBlYtyLEeExnW54Ho9Bsbc9q86iEYveRZJjVIh5TSYBoUlBMA9eSko31UKsmagByIM9bVpNRO2xwfZ5fWtNDUFG9pknbrIAvVMRNBlEvPsuJ4+WtT6V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f0sXGvMY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JUCxNTka; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658CnRJX3594833
	for <dmaengine@vger.kernel.org>; Mon, 8 Jun 2026 13:10:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Q48k7tN1w7wJ+iHjXC9qpbNvZsHt2Qv6AjglorJLZ/Q=; b=f0sXGvMYdBfdJ9yB
	rEQBGs2KLEhft8D6oOcL7tbyQ3vztZriItaqmWrn3LddIxVPGicA5WTIJddK2e/1
	OfFzZj5pJwbvAuK2TcUsevLNwkJ+J+oR6hwCYoQrQOxtyK1j1kaopxoB9wcgiC/Y
	vgq5sWRnIwhyYUrphmkSPoKnZfzMH09kpmBq7wdrBkOF/e8swWcUWg5YR2DB+Q64
	aozW5nQIz/45C2rgSj+BtLsW3ZTzF5HAUbxvs2XdujJnVDV0pM1qSe+m9asuVg2J
	Ifhqa4VezWkSqmj6KQc2RiB/nzH8zD5CD8YcMw0hVe9ZyBKD+Qkl+5rdjhW/uQAt
	Ei/GyQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enx2rr39x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 08 Jun 2026 13:10:47 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2bd04e4fe3dso61506625ad.3
        for <dmaengine@vger.kernel.org>; Mon, 08 Jun 2026 06:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780924246; x=1781529046; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q48k7tN1w7wJ+iHjXC9qpbNvZsHt2Qv6AjglorJLZ/Q=;
        b=JUCxNTkaOA1aUmUo1lPRJ8k0+buoGIENBfQ+IBPSsQ9gSNoF+JFNfqJZ6nBzheA1CH
         g4+UuCNS+96PBAlb2KXqv8e0tb0KkODRvuZy14dbl4XEH3kpmsrkFpBuizREQ//nQ9hq
         Ui6qSQd6cXpE+VqXfiN5Ia5F42jHkUQuqKGWsxmy2Y3iAWamxylo/fSy11ZtzeZII2qD
         amLkee7lOy7Wr2u9q7IiTxzOVxEHrttf9Kv3EmTuB7b4EMIzg/6A0ehhld0P2tpC4gCv
         gIqMx0X6DA+0ToGcLv8EzaA1uAlPwfFyAJRLe8O12kQ+JmH0kkCAklDekM4Sj1VAR2zw
         Qa8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780924246; x=1781529046;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q48k7tN1w7wJ+iHjXC9qpbNvZsHt2Qv6AjglorJLZ/Q=;
        b=nMB2LVTJ4SUt7+wsXaCRFaGVxzeF1hbswaMf3EqVde/TNLnZrRbsUJPp12x9P79N6E
         w/DwlpVFwmY7qKliTrS8vwjTn3kfOgCrNDGK3JyGfFwiMrchi1XHhyZfFyxJ8fyhBt9s
         PK7olVuQiQJQRvfBKxNBBHhKPwGLT8T3N2I22lo1BNEIZip6DiUzuC8z5y8WYL9zhz2k
         Dmtek9h3zdRzY6G9fBUVUEkzzlsFOWv7emzNwq+ruBv6MbPwU3YtLXmtDPhUeX53jlFA
         9bpsXdMKn/RxEoc/nMfgP9IknvbQ0BI7G5MnKT40qXaPHIRqkxPXeHOD+pBjIgGUFuEw
         GcqA==
X-Forwarded-Encrypted: i=1; AFNElJ+jg2qIJN8c/LQXGz0bGvHon5lZMdn8H+zk9yeVVSc0ZaAwaq6wj4PjAWQPhP6OWpanmtieLik6XzU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yygc/iFR+v77Anxt0ioqIrle8JYbbBmUFrAH9rqIXLB4UB6gjWS
	OD+sY5S03pR7vHyPlGFbUVJeDtwkBMGKWxZ87roSC4KYMZeN8NI0Of8h19uH37aEEMGw65Sx76S
	9TeHhdilKPAWxhExfUoHmD4fDsZNmeCqnYezp3jZSMLl2n9QoJe4VepD+dDvFD1Oefpo9vAk=
X-Gm-Gg: Acq92OHZb770aAgoJtFR0a4188y/SANKmO3r5ueiG3vlBSJrLLA1vyqhyDmcQEFUJRw
	p72rWaluQuR37oU6iCSiYXP+UPzuUwodyYA0ocHYdZly7IZX1iwCKIGaypHEnbCtmOGKpNjpNfA
	Cfq8fJ4bruI8Asn8xgGAFNJc3h4jucoscdf9ISE/0sBsb3w84jUX1P0XtbHMrIXkDdVfCIM9wlO
	b7Lrd7DjV+6MCoL8r+bfi2IMKOrjyNXxQzsw4D8/xA//oVhCcgVzpnNIbo5S3KG8XT1ZZHgL9Vp
	DXHZb3d1ZwCSdZTY6/jrIM+l7zQSOkGDUQS4YnvKJ7uqiszVcrxhVDUQlobzR6t84j/9YtXKMQ0
	DMKjXk+R6MWFAvYbyZnRJqZA7pUk2EGSGrX6gOC64itBvlbg=
X-Received: by 2002:a17:902:eb8b:b0:2c2:4ce4:c5d4 with SMTP id d9443c01a7336-2c24ce4cbe3mr74750395ad.17.1780924246245;
        Mon, 08 Jun 2026 06:10:46 -0700 (PDT)
X-Received: by 2002:a17:902:eb8b:b0:2c2:4ce4:c5d4 with SMTP id d9443c01a7336-2c24ce4cbe3mr74749995ad.17.1780924245869;
        Mon, 08 Jun 2026 06:10:45 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c1664ad172sm185235845ad.83.2026.06.08.06.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 06:10:45 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Mon, 08 Jun 2026 18:40:21 +0530
Subject: [PATCH v4 01/10] dt-bindings: dma: qcom,gpi: Document GPI DMA
 engine for Shikra SoC
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-shikra-dt-m1-v4-1-2114300594a6@oss.qualcomm.com>
References: <20260608-shikra-dt-m1-v4-0-2114300594a6@oss.qualcomm.com>
In-Reply-To: <20260608-shikra-dt-m1-v4-0-2114300594a6@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Komal Bajaj <komal.bajaj@oss.qualcomm.com>,
        Xueyao An <xueyao.an@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780924231; l=1050;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=siSRub+fQLM5lCWyMREXkIiIBlOosbQGbKhyD/VrTPA=;
 b=W10DtBgK7FWABUPtedxztsCQ/0oAfxE24Fa3aAckjl3CIA2i8EFpxUPo5r2As4NI3BL2z4jDK
 y1uXdp07n/mAZp5YTc46R4v2VRxxAMSldWE4yVkqIheCFiqNO+WDf7d
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-GUID: 3KbcNQ79N7bnCjvCkaCWojwXMqrsYY0S
X-Proofpoint-ORIG-GUID: 3KbcNQ79N7bnCjvCkaCWojwXMqrsYY0S
X-Authority-Analysis: v=2.4 cv=JdqMa0KV c=1 sm=1 tr=0 ts=6a26bf57 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=FVGO2dOrgB6TF-zC7f0A:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDEyNCBTYWx0ZWRfX6cBQ0pFu+mBC
 1VXgtbXTgxtWAsvaQG3mMB5l4injqqrsmIzBzhM7OiOFKHKDBwXF4uJXTwQBtJCQtZ5SP6Qizfv
 uRrC9eTKkDGzHYMVezchj/jr27CwlsDd1tkwPvDbE3HJs1l+JcLqPN2qShQ04Bxtd/b3okRa/m/
 eG6JOpfCIAhodClzqwpLX0Kiajgn/BpcfU0RfSyWoJ/YqhzU5NlRDqMQaVFxDLzdF9C/1l6moM3
 xBnkBNvf9aOKDi2eAAR46jcbQHapMZuHdQwh01MYeqh4ou5Q3um9Hh9CXpB/fqGIjeri+ADog0D
 f/ep1h9t/QsXuxK94I02FlKhMLey2v+zb516FRCKyUBKn6K4TxICS/Sdbamf/B1miTMOTpMPGP+
 obhSDcwJjdtEkTBj1b/7qQDDGmJBqRd3FvZGecZ8mY2LQmf2DQPvcV2W9P9C9Fu5yGpjy3ydvFB
 RnvzBucGKyivBv41h6Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080124
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11324-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:krzk@kernel.org,m:djakov@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:linux-arm-msm@vger.kernel.org,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pm@vger.kernel.org,m:komal.bajaj@oss.qualcomm.com,m:xueyao.an@oss.qualcomm.com,m:krzysztof.kozlowski@oss.qualcomm.com,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[komal.bajaj@oss.qualcomm.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[komal.bajaj@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1FFCC6568C4

From: Xueyao An <xueyao.an@oss.qualcomm.com>

Document the GPI DMA engine on Shikra platform.

It is fully compatible with the GPI DMA engine found on SM6350,
thus using qcom,sm6350-gpi-dma as fallback compatible.

Signed-off-by: Xueyao An <xueyao.an@oss.qualcomm.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/dma/qcom,gpi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
index 8f9a552fe30e..54dca623223d 100644
--- a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
+++ b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
@@ -37,6 +37,7 @@ properties:
               - qcom,sc7280-gpi-dma
               - qcom,sc8280xp-gpi-dma
               - qcom,sdx75-gpi-dma
+              - qcom,shikra-gpi-dma
               - qcom,sm6115-gpi-dma
               - qcom,sm6375-gpi-dma
               - qcom,sm8350-gpi-dma

-- 
2.34.1


