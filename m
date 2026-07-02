Return-Path: <dmaengine+bounces-11952-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id En/5OaVARmpcMwsAu9opvQ
	(envelope-from <dmaengine+bounces-11952-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 12:42:45 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 371C36F613B
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 12:42:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b="mt/FVJP/";
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=CeDH0FFA;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11952-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11952-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AFF1D312966A
	for <lists+dmaengine@lfdr.de>; Thu,  2 Jul 2026 10:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADEF47ECF0;
	Thu,  2 Jul 2026 09:51:36 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66664DC54C
	for <dmaengine@vger.kernel.org>; Thu,  2 Jul 2026 09:51:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782985896; cv=none; b=g87J3WGMR2sWu7QGzDo+SC7UdbnkgzEZH2jzmZ5tQJlzyTiwvArFORExLjCFYd6QTpzkq6yDzzbsFoyVcE/KiB5D+tfnTTYe0e3jGnqdnWanSipDO9P4bhrE4gbxq0WYhOQWrqNilUAwWeFk1fN6XWTDq1ENYq7qMWZ+w4HuKso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782985896; c=relaxed/simple;
	bh=W+J47DLyzKHe2QopLDHxTslHmL997c14k/yofWkF6Fo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ri5ZLNKTFrejNqHI+Mg80bzqNr2EO4su1QjZnoT27Xy+9wg4N2zgPZw7CblUSiCkNb9YNahEVJ46lLmXtOkIj0URJG8VVE9tIk0pMNuVmeNUKZAR0fnu350hMLoXow7g3zYn0i8yehOPjJa3BG9cl3W/rwujBagvU6XzwyKnAbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mt/FVJP/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CeDH0FFA; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6629KfOY4115963
	for <dmaengine@vger.kernel.org>; Thu, 2 Jul 2026 09:51:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Y5q6T1WOr2wk4M+dKBh9beKBFr4ByevQ7VYwHg8nO/E=; b=mt/FVJP/tJ5BWdlV
	MFtSrp87h2XL4XjVlr8vGd+hkcnvXtHPGqIcL1k6a3eXrZ++8LtRL6SRaNh9vGt/
	9Jd7JO0BmAt8Lsr2ehIbSPs8tVV9R08C7E2rQx1dga+xwEtUcK8MmCOJ60wQ2ZY7
	efglepwEIW3wXOlyMWuGm4YmXVrAvyCfGVzeQX1OyeK2X5swe6aJQQqkMqXnc0a1
	8SKd86sJsX6XGVEAZ4mZ6YQzqynSLwK5Te/ZGDNPF0RnhctWixIR7m8PTT/30vAe
	6Xtr2KMHPi8tYHpJTSjCDYg4dNNvAZknosHC3ddQT88g8ho5MxTrcGaysMMSvPo3
	JSud6w==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5n9403t6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Thu, 02 Jul 2026 09:51:34 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8478423e020so2328564b3a.0
        for <dmaengine@vger.kernel.org>; Thu, 02 Jul 2026 02:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782985893; x=1783590693; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y5q6T1WOr2wk4M+dKBh9beKBFr4ByevQ7VYwHg8nO/E=;
        b=CeDH0FFA73I30fLjUvzJnK4ltZ+N+PRTH6S4+KRFvw0uSRdgFumkJeCzbC7M5Gqlyn
         uTt+6fKWEEeMEYo81vJ9YPaLt5imuLR5CGAEA/Y345zbmXZjqoQM+VsGjKD9UkYMYCsL
         cr+mvLY/SpXHf/UalSMw2JZllMy0wIZSoWLOFrXA9SRR9OF0nzMD+euluHDdg1+5UGgM
         RQGYCdvIPAR6IlHApl0+dFHiB40yGI0kmMEKsI1P/I0ICiBA1ade/RA8dtTNimyvhXVn
         WZjzIWkhsgM5UaNeVOXEfVKHfNDjNwfsaVVn7BEApoLTE9o8fzNISTGm0i0qpz8jdu5B
         K8yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782985893; x=1783590693;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y5q6T1WOr2wk4M+dKBh9beKBFr4ByevQ7VYwHg8nO/E=;
        b=g0vAwDKiC387NQyw82GFD03XWWHmjDQ8ivO38+wagjjp8sVSmJPJT8kGlbBM2U6u1n
         jx8EEJSVIxcyYtZDuuEcB3pvkZ1g8vCH5L1ccAiPHwhCFPPu5KxXZTrK6YN74i+Q15eG
         6KX/dCdvUm1akbRgwk6d6ejplaw91wRPYSa1V5ol3o0hXuXZf+sTcwCFGz+0YSDR3nbj
         qYh6ZBrAjSF/MSUVDPhE2aEH7UTARhxpnLbgZt+PVIIVw2agnMuLjEZN9DOvbaqoj718
         4iNbrG4RAlOsvYDHd/BGY16mi83AdM51tFYPpco8J3i2dHnzkn9tKKSU5l6rtfpAwZ+8
         kylw==
X-Forwarded-Encrypted: i=1; AHgh+RrjyA5TT/xptvsvUz8BplR3SV8xl9K0N0f0mHP7Cm1pgfG698ql3OwtnmsO41yXq8yWurFbfCFyX6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzCV3KjAYtNpos6kC+K2OzuXeFY1mB0zy56fn8IDPJLFFGPOLc
	+1Cgqk81dwPDV8w8VZpeVSsvPINDPsP3gFupX+RPMgh8jP5BkjJh0qqHkKHQhkbqWzMOjF2ueKL
	mo89wmASH93oPBQL2K1ZQmSipMvMGIIayenRa5svMlO9z1mriDuYKMhI1hahMt24=
X-Gm-Gg: AfdE7cksNa9/VH6cO1AOddlYRccfibSSFEKxrQiJQ0PuW9r9i6B8BSPvhuJaC/jqn9i
	qqtnIA85Nc2hMcbnJrWc9+yAzs6FZFFdmsx/Q4VfImJ5imcjD55q2mQNN1LuOI44OIf7mFs5qc0
	sCLS/XbCquIawcGSYB8UavdLw40tMBHrk8+jv32N+cDPmj8o931mR8C/VmbBW3WGUyBgEUa8RxU
	+B+lttYr7Xcs/p8clCSVW+AY/duytTKUNVTEx+sZ5bjoMnDcjj5cCJokkXJ29iuJCpyp6k7lLdS
	9/4al8GpfU/YGPujPsq6OF+9CisRemHgWTtg1Guu9jZsdAhyGL2Q6kLORYtWB7VXbYLFC7YMiek
	t8EpGXNXEZW5nO0JLpe7mUaDq6Q==
X-Received: by 2002:a05:6a00:4194:b0:847:87c6:486c with SMTP id d2e1a72fcca58-847c08d16a0mr5329778b3a.51.1782985893502;
        Thu, 02 Jul 2026 02:51:33 -0700 (PDT)
X-Received: by 2002:a05:6a00:4194:b0:847:87c6:486c with SMTP id d2e1a72fcca58-847c08d16a0mr5329576b3a.51.1782985892939;
        Thu, 02 Jul 2026 02:51:32 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847cb78ee2esm1110051b3a.24.2026.07.02.02.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 02:51:32 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Thu, 02 Jul 2026 15:20:49 +0530
Subject: [PATCH v5 07/11] arm64: dts: qcom: shikra: Enable CDSP, LPAICP and
 MPSS on EVK boards
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-shikra-dt-m1-v5-7-f911ac92720c@oss.qualcomm.com>
References: <20260702-shikra-dt-m1-v5-0-f911ac92720c@oss.qualcomm.com>
In-Reply-To: <20260702-shikra-dt-m1-v5-0-f911ac92720c@oss.qualcomm.com>
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
        Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782985846; l=2699;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=B2Dpn2axDYIMHLk1wigFR9Q2p/KX8LBdfSSHhm53znE=;
 b=C01sg74303YfJrG1IZIvaMytNKmgM29upDf3ZU2cIOxelbs66nkDIIxIKa4ICb5StnUkXqH5J
 jKy0yJGGe3mCj8WKPgr/6jlJGeltSEHJm5fbGOiIOP9OloNeKbjNPVS
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDEwMSBTYWx0ZWRfXyqsKD+voqzm9
 rurgp93ErLEQDFDd0NdN54L5dn42ht3ljg+vnlt57qsm6KtQF5ThknEGOxV5o78cVBDq7sV4se3
 sKqNT7IcTg3+BjzZ2wC5chGs85N+a4pta6kP3PwEgEuGszkaiqAJ1PB2j1kMCxyPkd3pERb1DZw
 b1P7LdA3QjMINT2X59l6g6RcIK9VBX6LB6Se2P0E0odoZ1UtQqCHGV1x7emjSmKJBoRtLIZ0DHc
 X9Ez9SEsIpN/olqyvIRYuPk30VAMLsrZX/RgGHgTZpD46VRNyU+obtpWdp6wIQBZGj+zJnAWLUm
 MdFaokrVyk4Gi4vCIhZx3eYfmgq96/E8Q5K/wUIkiGZ43wq4A1nGaz8F4L+5xENb3L+x8N0knfp
 Jfj5ohSoeCg409mAdiID1qcHN0dZdERNdXBRoblINlF2CBAFEkZlhzmXFqH4BR4TNJG1GIuCpWb
 miHN3Wtffdh1CXBuH7Q==
X-Authority-Analysis: v=2.4 cv=Lv+iDHdc c=1 sm=1 tr=0 ts=6a4634a6 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=nu3v8zf0uA-Bo5sjUnsA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: Pd1rUB76EnnXAzCLjgReFnE_MLGBmVa2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDEwMSBTYWx0ZWRfXx5+ZDbl4leFG
 sktgnlf5gdVTGZWO4JxQknLx8sYv5d44oxGNiq+9kaeCNSLamLV4qja03CpcUfHGK5vhmiVP2Di
 taokDCrPMLS6dGbuhDkIt8/Cr5QcGLE=
X-Proofpoint-GUID: Pd1rUB76EnnXAzCLjgReFnE_MLGBmVa2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020101
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11952-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:krzk@kernel.org,m:djakov@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:linux-arm-msm@vger.kernel.org,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pm@vger.kernel.org,m:komal.bajaj@oss.qualcomm.com,m:bibek.patro@oss.qualcomm.com,m:konrad.dybcio@oss.qualcomm.com,m:dmitry.baryshkov@oss.qualcomm.com,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[komal.bajaj@oss.qualcomm.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,vger.kernel.org:from_smtp,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
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
X-Rspamd-Queue-Id: 371C36F613B

From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>

Enable CDSP, LPAICP and MPSS for Qualcomm's Shikra CQM, CQS and
IQS EVK board.

Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts | 19 +++++++++++++++++++
 arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts | 19 +++++++++++++++++++
 arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts | 19 +++++++++++++++++++
 3 files changed, 57 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
index 0a52ab9b7a4c..b112b21b1d79 100644
--- a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
+++ b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
@@ -23,6 +23,25 @@ chosen {
 	};
 };
 
+&remoteproc_cdsp {
+	firmware-name = "qcom/shikra/cdsp.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_lpaicp {
+	firmware-name = "qcom/shikra/lpaicp.mbn",
+			"qcom/shikra/lpaicp_dtb.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_mpss {
+	firmware-name = "qcom/shikra/cqm/qdsp6sw.mbn";
+
+	status = "okay";
+};
+
 &sdhc_1 {
 	vmmc-supply = <&pm4125_l20>;
 	vqmmc-supply = <&pm4125_l14>;
diff --git a/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts b/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
index b3f19a64d7ae..e62ba5aef71f 100644
--- a/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
+++ b/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
@@ -23,6 +23,25 @@ chosen {
 	};
 };
 
+&remoteproc_cdsp {
+	firmware-name = "qcom/shikra/cdsp.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_lpaicp {
+	firmware-name = "qcom/shikra/lpaicp.mbn",
+			"qcom/shikra/lpaicp_dtb.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_mpss {
+	firmware-name = "qcom/shikra/cqs/qdsp6sw.mbn";
+
+	status = "okay";
+};
+
 &sdhc_1 {
 	vmmc-supply = <&pm4125_l20>;
 	vqmmc-supply = <&pm4125_l14>;
diff --git a/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts b/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
index 3003a47bd759..727809430fd1 100644
--- a/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
+++ b/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
@@ -23,6 +23,25 @@ chosen {
 	};
 };
 
+&remoteproc_cdsp {
+	firmware-name = "qcom/shikra/cdsp.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_lpaicp {
+	firmware-name = "qcom/shikra/lpaicp.mbn",
+			"qcom/shikra/lpaicp_dtb.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_mpss {
+	firmware-name = "qcom/shikra/cqs/qdsp6sw.mbn";
+
+	status = "okay";
+};
+
 &sdhc_1 {
 	vmmc-supply = <&pm8150_l17>;
 	vqmmc-supply = <&pm8150_s4>;

-- 
2.34.1


