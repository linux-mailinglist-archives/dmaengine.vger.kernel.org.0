Return-Path: <dmaengine+bounces-11947-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vgwjLr88RmojMgsAu9opvQ
	(envelope-from <dmaengine+bounces-11947-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 12:26:07 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F3F6F5DF8
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 12:26:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=hyKLBZuL;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=Pf4AmYvH;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11947-lists+dmaengine=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="dmaengine+bounces-11947-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2F8F13296490
	for <lists+dmaengine@lfdr.de>; Thu,  2 Jul 2026 10:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424084A2E1D;
	Thu,  2 Jul 2026 09:51:10 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33914A2E14
	for <dmaengine@vger.kernel.org>; Thu,  2 Jul 2026 09:51:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782985870; cv=none; b=SCUk1nk1Ka6y2s9S4pZxVuBadg/vIYlVbH7WpBEc8XelZTJBrMPNskL6IP4o2RTacc3VkkbsIPfWK2QBFyjfF0dPJcY1mlGqV8rJZpFc03JZQnK0JeiCifZvHVcOw4ntyixvOl9Po6s8LqnFrseeUuBwtQIecv9ZS7qRQ7mFuG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782985870; c=relaxed/simple;
	bh=rVgzIxKVDlWQ13u4i2gzEYGJgzh5Hi2uUmdMIpiQxHc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UmBJ9/Lgsmc2L6yF2+mVUi/VEFCmsFwNREyS99GSkbPkpibDD6pftxyoL5QMHWs6Z28J8WAEn91Wnl6bgGNzoPRoIPwt2N10lP8dqzPPOjVymDr5YaLzXtBDtRm1EA/1F5UzqDihKxPAV3BEu4k31XS7WhweZZ7rNNWg/mOCsCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hyKLBZuL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Pf4AmYvH; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6627TsK23964230
	for <dmaengine@vger.kernel.org>; Thu, 2 Jul 2026 09:51:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2rSNyFbPW6uyVZ18SRbJHmWO36wPUW/VLmaaRDBzHus=; b=hyKLBZuLZvZnUUQl
	cGniLXVF3gNRPDs+oG4c7ZKOslbhLHwgSf54r9xFIxRpo+AE6W4MXCJ90uDxmIoM
	qxA7X7PvOxPVTFr1iTJoWIuTW24V3H4sZPnfn7H8OkfNDWejrBouvOqG+r75mIrW
	Ran+NVCBIhdv1CsZ8bb3lAxEgZ0VfC0czqDstfJamuzX7D/W3UcmzbLSU522XXmi
	qeEHCqQmJGq54Jd9OIjDRLjxAWIcaohZ0f874basNCkqi0Lr6rLefXMcUp4Bq5Pl
	6GYQgMa1S8bUus+BLGa2Aopk7BCtw4uMTJ9EEgoU3clVryb6UvU0WxT0/AxQBVLG
	rYV4cA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5knc0jdx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Thu, 02 Jul 2026 09:51:06 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-845317fa7e6so2491782b3a.3
        for <dmaengine@vger.kernel.org>; Thu, 02 Jul 2026 02:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782985866; x=1783590666; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2rSNyFbPW6uyVZ18SRbJHmWO36wPUW/VLmaaRDBzHus=;
        b=Pf4AmYvHBdI9mjWGQwl8m0IPATcMfghZjPpvxsoIKJbX00XANNHQFZMV96iaPdBJQg
         g6Ds3aJKeIBvGX0okmU6BHFPYSfg1lN2TE4Yfds3tEuJHDzuFIktIsTYAMjycT/0iBd2
         nKlxCBP38DhPP69Wsn5SH25FurJkVdm02Db1CR/D5rUpIbChpHPSnBze3x/3agv4+8Pe
         mAWu/m/O1v4V1/fjqJnXuB9HKqf3goqRcE/vbJmRuG4DfeN81DyagDsgZ1WSJSAn+omv
         m+QcDG0nNPimvv49TSNGsMPPW48o62bYPiloul3HBNQIcBhU1zdMtzDx0JAsL6Xl1ROE
         0Gpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782985866; x=1783590666;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2rSNyFbPW6uyVZ18SRbJHmWO36wPUW/VLmaaRDBzHus=;
        b=LzCF+tSVQ1pYyU9Jtn7ByWw2FTSbQzchOk8IR2mxOHlQ2ygNHyWoZ9ablt8Fs7s307
         EBdPXbOyN1mL9ilOLhtWVi+RdUmIyw694WpiOzc5SjwIAw+2DRJ0JhoIZiIjQDSWqKCC
         Ok1QWlXT37b+7dwuNCoXinp+kf65S9jaY5nFonbBcmZWjtVUvO0N9xIVWFb5pCLjavIJ
         yzVvrdat2Q9svfMGglyEsVSankdT5Dy8IJycNYa9xIVyJ3scPa/jMXCvwPckULV4vePs
         arkU+m0SE+Xs862UpKRbIX7LtgNKcCUKj1W8NLS5HOOnD08bTdU8f90WhvDAdLHmMwB6
         iL6w==
X-Forwarded-Encrypted: i=1; AHgh+Ro4aQXWNutS5IJqIX0ODKIoUP5TfHdkxIOfIQQNONGUnyS/FyW9Gq3HNJ+sbXcj/aJPeJgD1B2sHjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFByyyTeNbJ53YUALiJ+zig7yvnyZBCirJJUFFpp6WPQUm8I+6
	QTNMmT0SpbVgVN8rR0SinBT/CSiyGEwzSeo+ejdpkKqgqTqnq16jmveYkN7+xaGqKkIB+VmWCxZ
	PLRQqp1h03ivSCw8mgz7OnmIJXXkqU26x8c0u6QSPoutrlS6+xKLvHMZRife4L/o=
X-Gm-Gg: AfdE7cmohGzCAiSNkO0UK/AesrpwUnDgu4jnBXPm0CVdmfqbcqX+ifak48qRZUrZveJ
	9VEefCN45j+HgNVBtaUK/zrGlss2A7xyeKR/2qPNWyiCTBFsUcp8g2M4NMrzPDJPBgfHTDtZBW6
	KF7hXflXoXpixQ5KtT2ugRtFM0v008QmPYuTO+q4Hi7xSqGX4kQYS3hLSqNU5mVWYSrlyJEscyn
	KUoZ0a7eO657WD4AA16sTXUrenxYTjh55WDsyLcJ/PWt1DXwT39dPKnenH6kWl0bHVxS12Lnbof
	0m7OglcBw4be1S/ZL4/cdkVrins7izFSjd5Y8GiQGQydr3EwDpwP1lgIk8/CjYn3k+GA7xjtKk4
	4NtPE1NzCPkXuQLWQDsoSIW2ihQ==
X-Received: by 2002:a05:6a00:bd0e:b0:847:7f6a:c56d with SMTP id d2e1a72fcca58-847c096d1e1mr5421799b3a.30.1782985865447;
        Thu, 02 Jul 2026 02:51:05 -0700 (PDT)
X-Received: by 2002:a05:6a00:bd0e:b0:847:7f6a:c56d with SMTP id d2e1a72fcca58-847c096d1e1mr5421762b3a.30.1782985864788;
        Thu, 02 Jul 2026 02:51:04 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847cb78ee2esm1110051b3a.24.2026.07.02.02.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 02:51:04 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Thu, 02 Jul 2026 15:20:44 +0530
Subject: [PATCH v5 02/11] arm64: dts: qcom: Add QUPv3 configuration for
 Shikra
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-shikra-dt-m1-v5-2-f911ac92720c@oss.qualcomm.com>
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
        Xueyao An <xueyao.an@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782985846; l=28783;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=5mXIsm6X6kTdBK8thvJgMOPG10vm2AQoPgBvXs8nML0=;
 b=ewwC7Orkx1a7JfL9MDeh5FZqWFexTN5QhYIdSFuwYONEYv1nC4Swe3BeDLcylb2Laj4EBoCvM
 yugdhTivtH5D+tjhYcIoVicm+3+B1EA4e66NKX3qpKeHUJYImdUxwgL
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-ORIG-GUID: Ww4OtNtmrdQ-pdQycOC45CWsI55RKqI8
X-Authority-Analysis: v=2.4 cv=a4kAM0SF c=1 sm=1 tr=0 ts=6a46348a cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=lZImzISf86lFr0hzVWMA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDEwMSBTYWx0ZWRfX+YgCn+dSMK+g
 8RnTilDOsP0HZbtQsXbfUIPTtPxdHlQsLX/WLZvwFdbprSvvBIV1jA7CLVTtGNrMaMWaWSntQqa
 t/O5H3chjxJOykQ7mrjQ4JnQaEQz3TaemAR3Db0Qn5Aw+l6fE8JUEzCHtAFjBXKzyQqbo/4yjhM
 gGh571sEEsErX3Mp0fhY/L6wLIcuMsKFkcBnZrmVcCRCtg82RL87jY81wlsRCaNymU91Zs1RtEk
 Fwu8XYUQeYxvDoGttXjeKs+/tXHvhjxEF7ZWwaG1SpZ1sW3sGGHZFPdI09QAAXEdT1ZEhHsuAEk
 vupQyrdJDIbEXe212lymAHDOrc4bl9V2PfpJonRkXjVWcbZO9ch0itoVbb1kZHhYsGXYkrmTFo9
 KAgo1Ai+oudEDC6/I9xrbYRZueSoWvgoD/z3Uk+tUlWzsO4ZKDoRTU4+s5qmnOeVWnEWqkZE/Bf
 qbG6biSzQXd5w2l/cEA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDEwMSBTYWx0ZWRfX3tgEBQLm/DYH
 b05licm553hLQxo3PenySf5z42IOXDA9Vq8Oghdtj05noyQaiI1K99bcmzQwFERVjBNmJQ7hSc3
 GYqUZ1h41IAVWuCl1ltNRGSYzxYCQjU=
X-Proofpoint-GUID: Ww4OtNtmrdQ-pdQycOC45CWsI55RKqI8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020101
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-11947-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:krzk@kernel.org,m:djakov@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:linux-arm-msm@vger.kernel.org,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pm@vger.kernel.org,m:komal.bajaj@oss.qualcomm.com,m:xueyao.an@oss.qualcomm.com,m:dmitry.baryshkov@oss.qualcomm.com,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[komal.bajaj@oss.qualcomm.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,qualcomm.com:dkim,qualcomm.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[komal.bajaj@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[104.64.211.4:from];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 07F3F6F5DF8

From: Xueyao An <xueyao.an@oss.qualcomm.com>

Add device tree support for QUPv3 serial engine protocols on Shikra.
Shikra has 10 QUP serial engines under a single QUP wrapper, all with
support of GPI DMA engines.

Signed-off-by: Xueyao An <xueyao.an@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra.dtsi | 951 +++++++++++++++++++++++++++++++++++
 1 file changed, 951 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index 4e5bc9e17c8e..f0fb55b9deb9 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -6,6 +6,7 @@
 #include <dt-bindings/clock/qcom,rpmcc.h>
 #include <dt-bindings/clock/qcom,shikra-gcc.h>
 #include <dt-bindings/interconnect/qcom,icc.h>
+#include <dt-bindings/dma/qcom-gpi.h>
 #include <dt-bindings/interconnect/qcom,rpm-icc.h>
 #include <dt-bindings/interconnect/qcom,shikra.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
@@ -348,6 +349,161 @@ tlmm: pinctrl@500000 {
 			gpio-ranges = <&tlmm 0 0 165>;
 			wakeup-parent = <&mpm>;
 
+			qup_i2c0_data_clk: qup-i2c0-data-clk-state {
+				/* SDA, SCL */
+				pins = "gpio2", "gpio3";
+				function = "qup0_se0";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			qup_i2c1_data_clk: qup-i2c1-data-clk-state {
+				/* SDA, SCL */
+				pins = "gpio4", "gpio5";
+				function = "qup0_se1_01";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			qup_i2c2_data_clk: qup-i2c2-data-clk-state {
+				/* SDA, SCL */
+				pins = "gpio6", "gpio7";
+				function = "qup0_se2";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			qup_i2c3_data_clk: qup-i2c3-data-clk-state {
+				/* SDA, SCL */
+				pins = "gpio10", "gpio11";
+				function = "qup0_se3_01";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			qup_i2c4_data_clk: qup-i2c4-data-clk-state {
+				/* SDA, SCL */
+				pins = "gpio12", "gpio13";
+				function = "qup0_se4_01";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			qup_i2c5_data_clk: qup-i2c5-data-clk-state {
+				/* SDA, SCL */
+				pins = "gpio14", "gpio15";
+				function = "qup0_se5";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			qup_i2c6_data_clk: qup-i2c6-data-clk-state {
+				/* SDA, SCL */
+				pins = "gpio18", "gpio19";
+				function = "qup0_se6";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			qup_i2c7_data_clk: qup-i2c7-data-clk-state {
+				/* SDA, SCL */
+				pins = "gpio20", "gpio21";
+				function = "qup0_se7_01";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			qup_i2c8_data_clk: qup-i2c8-data-clk-state {
+				/* SDA, SCL */
+				pins = "gpio22", "gpio23";
+				function = "qup0_se8";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			qup_i2c9_data_clk: qup-i2c9-data-clk-state {
+				/* SDA, SCL */
+				pins = "gpio27", "gpio26";
+				function = "qup0_se9_01";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			qup_spi0_cs: qup-spi0-cs-state {
+				pins = "gpio1";
+				function = "qup0_se0";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
+			qup_spi0_data_clk: qup-spi0-data-clk-state {
+				/* MISO, MOSI, CLK */
+				pins = "gpio2", "gpio3", "gpio0";
+				function = "qup0_se0";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
+			qup_spi2_cs: qup-spi2-cs-state {
+				pins = "gpio9";
+				function = "qup0_se2";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
+			qup_spi2_data_clk: qup-spi2-data-clk-state {
+				/* MISO, MOSI, CLK */
+				pins = "gpio6", "gpio7", "gpio8";
+				function = "qup0_se2";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
+			qup_spi5_cs: qup-spi5-cs-state {
+				pins = "gpio17";
+				function = "qup0_se5";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
+			qup_spi5_data_clk: qup-spi5-data-clk-state {
+				/* MISO, MOSI, CLK */
+				pins = "gpio14", "gpio15", "gpio16";
+				function = "qup0_se5";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
+			qup_spi6_cs: qup-spi6-cs-state {
+				pins = "gpio29";
+				function = "qup0_se6";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
+			qup_spi6_data_clk: qup-spi6-data-clk-state {
+				/* MISO, MOSI, CLK */
+				pins = "gpio18", "gpio19", "gpio28";
+				function = "qup0_se6";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
+			qup_spi8_cs: qup-spi8-cs-state {
+				pins = "gpio25";
+				function = "qup0_se8";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
+			qup_spi8_data_clk: qup-spi8-data-clk-state {
+				/* MISO, MOSI, CLK */
+				pins = "gpio22", "gpio23", "gpio24";
+				function = "qup0_se8";
+				drive-strength = <6>;
+				bias-disable;
+			};
+
 			qup_uart0_default: qup-uart0-default-state {
 				pins = "gpio0", "gpio1";
 				function = "qup0_se0";
@@ -355,6 +511,105 @@ qup_uart0_default: qup-uart0-default-state {
 				bias-disable;
 			};
 
+			qup_uart1_default: qup-uart1-default-state {
+				pins = "gpio4", "gpio5";
+				function = "qup0_se1_23";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			qup_uart2_default: qup-uart2-default-state {
+				/* TX, RX */
+				pins = "gpio8", "gpio9";
+				function = "qup0_se2";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			qup_uart2_cts_rts: qup-uart2-cts-rts-state {
+				/* CTS, RTS */
+				pins = "gpio6", "gpio7";
+				function = "qup0_se2";
+				drive-strength = <2>;
+				bias-pull-down;
+			};
+
+			qup_uart3_default: qup-uart3-default-state {
+				pins = "gpio10", "gpio11";
+				function = "qup0_se3_23";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			qup_uart4_default: qup-uart4-default-state {
+				pins = "gpio12", "gpio13";
+				function = "qup0_se4_23";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			qup_uart5_default: qup-uart5-default-state {
+				/* TX, RX */
+				pins = "gpio16", "gpio17";
+				function = "qup0_se5";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			qup_uart5_cts_rts: qup-uart5-cts-rts-state {
+				/* CTS, RTS */
+				pins = "gpio14", "gpio15";
+				function = "qup0_se5";
+				drive-strength = <2>;
+				bias-pull-down;
+			};
+
+			qup_uart6_default: qup-uart6-default-state {
+				/* TX, RX */
+				pins = "gpio28", "gpio29";
+				function = "qup0_se6";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			qup_uart6_cts_rts: qup-uart6-cts-rts-state {
+				/* CTS, RTS */
+				pins = "gpio18", "gpio19";
+				function = "qup0_se6";
+				drive-strength = <2>;
+				bias-pull-down;
+			};
+
+			qup_uart7_default: qup-uart7-default-state {
+				pins = "gpio20", "gpio21";
+				function = "qup0_se7_23";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			qup_uart8_default: qup-uart8-default-state {
+				/* TX, RX */
+				pins = "gpio24", "gpio25";
+				function = "qup0_se8";
+				drive-strength = <2>;
+				bias-pull-up;
+			};
+
+			qup_uart8_cts_rts: qup-uart8-cts-rts-state {
+				/* CTS, RTS */
+				pins = "gpio22", "gpio23";
+				function = "qup0_se8";
+				drive-strength = <2>;
+				bias-pull-down;
+			};
+
+			qup_uart9_default: qup-uart9-default-state {
+				pins = "gpio26", "gpio27";
+				function = "qup0_se9_23";
+				drive-strength = <2>;
+				bias-disable;
+			};
+
 			sdc1_state_on: sdc1-on-state {
 				clk-pins {
 					pins = "sdc1_clk";
@@ -604,6 +859,34 @@ opp-384000000 {
 			};
 		};
 
+		gpi_dma0: dma-controller@4a00000 {
+			compatible = "qcom,shikra-gpi-dma", "qcom,sm6350-gpi-dma";
+			reg = <0x0 0x04a00000 0x0 0x60000>;
+
+			interrupts = <GIC_SPI 511 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 512 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 513 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 514 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 515 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 516 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 517 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 518 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 519 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 520 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 521 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 522 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 523 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 524 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 525 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 526 IRQ_TYPE_LEVEL_HIGH 0>;
+
+			dma-channels = <16>;
+			dma-channel-mask = <0xff>;
+			#dma-cells = <3>;
+
+			iommus = <&apps_smmu 0xf6 0x0>;
+		};
+
 		qupv3_0: geniqup@4ac0000 {
 			compatible = "qcom,geni-se-qup";
 			reg = <0x0 0x04ac0000 0x0 0x2000>;
@@ -613,10 +896,75 @@ qupv3_0: geniqup@4ac0000 {
 			clock-names = "m-ahb",
 				      "s-ahb";
 
+			iommus = <&apps_smmu 0xe3 0x0>;
+
 			#address-cells = <2>;
 			#size-cells = <2>;
 			ranges;
 
+			status = "disabled";
+
+			i2c0: i2c@4a80000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0x0 0x4a80000 0x0 0x4000>;
+
+				interrupts = <GIC_SPI 527 IRQ_TYPE_LEVEL_HIGH 0>;
+
+				clocks = <&gcc GCC_QUPV3_WRAP0_S0_CLK>;
+				clock-names = "se";
+
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
+						 &clk_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
+						<&mem_noc MASTER_AMPSS_M0 RPM_ALWAYS_TAG
+						 &config_noc SLAVE_QUP_0 RPM_ALWAYS_TAG>,
+						<&system_noc MASTER_QUP_0 RPM_ALWAYS_TAG
+						 &mc_virt SLAVE_EBI_CH0 RPM_ALWAYS_TAG>;
+				interconnect-names = "qup-core",
+						     "qup-config",
+						     "qup-memory";
+
+				dmas = <&gpi_dma0 0 0 QCOM_GPI_I2C>,
+				       <&gpi_dma0 1 0 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
+
+				pinctrl-0 = <&qup_i2c0_data_clk>;
+				pinctrl-names = "default";
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				status = "disabled";
+			};
+
+			spi0: spi@4a80000 {
+				compatible = "qcom,geni-spi";
+				reg = <0x0 0x4a80000 0x0 0x4000>;
+
+				interrupts = <GIC_SPI 527 IRQ_TYPE_LEVEL_HIGH 0>;
+
+				clocks = <&gcc GCC_QUPV3_WRAP0_S0_CLK>;
+				clock-names = "se";
+
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
+						 &clk_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
+						<&mem_noc MASTER_AMPSS_M0 RPM_ALWAYS_TAG
+						 &config_noc SLAVE_QUP_0 RPM_ALWAYS_TAG>;
+				interconnect-names = "qup-core",
+						     "qup-config";
+
+				dmas = <&gpi_dma0 0 0 QCOM_GPI_SPI>,
+				       <&gpi_dma0 1 0 QCOM_GPI_SPI>;
+				dma-names = "tx", "rx";
+
+				pinctrl-0 = <&qup_spi0_data_clk>, <&qup_spi0_cs>;
+				pinctrl-names = "default";
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				status = "disabled";
+			};
+
 			uart0: serial@4a80000 {
 				compatible = "qcom,geni-debug-uart";
 				reg = <0x0 0x04a80000 0x0 0x4000>;
@@ -638,6 +986,609 @@ &clk_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
 
 				status = "disabled";
 			};
+
+			i2c1: i2c@4a84000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0x0 0x4a84000 0x0 0x4000>;
+
+				interrupts = <GIC_SPI 528 IRQ_TYPE_LEVEL_HIGH 0>;
+
+				clocks = <&gcc GCC_QUPV3_WRAP0_S1_CLK>;
+				clock-names = "se";
+
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
+						 &clk_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
+						<&mem_noc MASTER_AMPSS_M0 RPM_ALWAYS_TAG
+						 &config_noc SLAVE_QUP_0 RPM_ALWAYS_TAG>,
+						<&system_noc MASTER_QUP_0 RPM_ALWAYS_TAG
+						 &mc_virt SLAVE_EBI_CH0 RPM_ALWAYS_TAG>;
+				interconnect-names = "qup-core",
+						     "qup-config",
+						     "qup-memory";
+
+				dmas = <&gpi_dma0 0 1 QCOM_GPI_I2C>,
+				       <&gpi_dma0 1 1 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
+
+				pinctrl-0 = <&qup_i2c1_data_clk>;
+				pinctrl-names = "default";
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				status = "disabled";
+			};
+
+			uart1: serial@4a84000 {
+				compatible = "qcom,geni-uart";
+				reg = <0x0 0x04a84000 0x0 0x4000>;
+
+				interrupts = <GIC_SPI 528 IRQ_TYPE_LEVEL_HIGH 0>;
+
+				clocks = <&gcc GCC_QUPV3_WRAP0_S1_CLK>;
+				clock-names = "se";
+
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
+						 &clk_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
+						<&mem_noc MASTER_AMPSS_M0 RPM_ALWAYS_TAG
+						 &config_noc SLAVE_QUP_0 RPM_ALWAYS_TAG>;
+				interconnect-names = "qup-core",
+						     "qup-config";
+
+				pinctrl-0 = <&qup_uart1_default>;
+				pinctrl-names = "default";
+
+				status = "disabled";
+			};
+
+			i2c2: i2c@4a88000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0x0 0x4a88000 0x0 0x4000>;
+
+				interrupts = <GIC_SPI 529 IRQ_TYPE_LEVEL_HIGH 0>;
+
+				clocks = <&gcc GCC_QUPV3_WRAP0_S2_CLK>;
+				clock-names = "se";
+
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
+						 &clk_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
+						<&mem_noc MASTER_AMPSS_M0 RPM_ALWAYS_TAG
+						 &config_noc SLAVE_QUP_0 RPM_ALWAYS_TAG>,
+						<&system_noc MASTER_QUP_0 RPM_ALWAYS_TAG
+						 &mc_virt SLAVE_EBI_CH0 RPM_ALWAYS_TAG>;
+				interconnect-names = "qup-core",
+						     "qup-config",
+						     "qup-memory";
+
+				pinctrl-0 = <&qup_i2c2_data_clk>;
+				pinctrl-names = "default";
+
+				dmas = <&gpi_dma0 0 2 QCOM_GPI_I2C>,
+				       <&gpi_dma0 1 2 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				status = "disabled";
+			};
+
+			spi2: spi@4a88000 {
+				compatible = "qcom,geni-spi";
+				reg = <0x0 0x4a88000 0x0 0x4000>;
+
+				interrupts = <GIC_SPI 529 IRQ_TYPE_LEVEL_HIGH 0>;
+
+				clocks = <&gcc GCC_QUPV3_WRAP0_S2_CLK>;
+				clock-names = "se";
+
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
+						 &clk_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
+						<&mem_noc MASTER_AMPSS_M0 RPM_ALWAYS_TAG
+						 &config_noc SLAVE_QUP_0 RPM_ALWAYS_TAG>;
+				interconnect-names = "qup-core",
+						     "qup-config";
+
+				dmas = <&gpi_dma0 0 2 QCOM_GPI_SPI>,
+				       <&gpi_dma0 1 2 QCOM_GPI_SPI>;
+				dma-names = "tx", "rx";
+
+				pinctrl-0 = <&qup_spi2_data_clk>, <&qup_spi2_cs>;
+				pinctrl-names = "default";
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				status = "disabled";
+			};
+
+			uart2: serial@4a88000 {
+				compatible = "qcom,geni-uart";
+				reg = <0x0 0x04a88000 0x0 0x4000>;
+
+				interrupts-extended = <&intc GIC_SPI 529 IRQ_TYPE_LEVEL_HIGH 0>,
+						      <&tlmm 9 IRQ_TYPE_LEVEL_HIGH>;
+
+				clocks = <&gcc GCC_QUPV3_WRAP0_S2_CLK>;
+				clock-names = "se";
+
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
+						 &clk_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
+						<&mem_noc MASTER_AMPSS_M0 RPM_ALWAYS_TAG
+						 &config_noc SLAVE_QUP_0 RPM_ALWAYS_TAG>;
+				interconnect-names = "qup-core",
+						     "qup-config";
+
+				pinctrl-0 = <&qup_uart2_default>, <&qup_uart2_cts_rts>;
+				pinctrl-names = "default";
+
+				status = "disabled";
+			};
+
+			i2c3: i2c@4a8c000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0x0 0x4a8c000 0x0 0x4000>;
+
+				interrupts = <GIC_SPI 530 IRQ_TYPE_LEVEL_HIGH 0>;
+
+				clocks = <&gcc GCC_QUPV3_WRAP0_S3_CLK>;
+				clock-names = "se";
+
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
+						 &clk_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
+						<&mem_noc MASTER_AMPSS_M0 RPM_ALWAYS_TAG
+						 &config_noc SLAVE_QUP_0 RPM_ALWAYS_TAG>,
+						<&system_noc MASTER_QUP_0 RPM_ALWAYS_TAG
+						 &mc_virt SLAVE_EBI_CH0 RPM_ALWAYS_TAG>;
+				interconnect-names = "qup-core",
+						     "qup-config",
+						     "qup-memory";
+
+				dmas = <&gpi_dma0 0 3 QCOM_GPI_I2C>,
+				       <&gpi_dma0 1 3 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
+
+				pinctrl-0 = <&qup_i2c3_data_clk>;
+				pinctrl-names = "default";
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				status = "disabled";
+			};
+
+			uart3: serial@4a8c000 {
+				compatible = "qcom,geni-uart";
+				reg = <0x0 0x04a8c000 0x0 0x4000>;
+
+				interrupts = <GIC_SPI 530 IRQ_TYPE_LEVEL_HIGH 0>;
+
+				clocks = <&gcc GCC_QUPV3_WRAP0_S3_CLK>;
+				clock-names = "se";
+
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
+						 &clk_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
+						<&mem_noc MASTER_AMPSS_M0 RPM_ALWAYS_TAG
+						 &config_noc SLAVE_QUP_0 RPM_ALWAYS_TAG>;
+				interconnect-names = "qup-core",
+						     "qup-config";
+
+				pinctrl-0 = <&qup_uart3_default>;
+				pinctrl-names = "default";
+
+				status = "disabled";
+			};
+
+			i2c4: i2c@4a90000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0x0 0x4a90000 0x0 0x4000>;
+
+				interrupts = <GIC_SPI 531 IRQ_TYPE_LEVEL_HIGH 0>;
+
+				clocks = <&gcc GCC_QUPV3_WRAP0_S4_CLK>;
+				clock-names = "se";
+
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
+						 &clk_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
+						<&mem_noc MASTER_AMPSS_M0 RPM_ALWAYS_TAG
+						 &config_noc SLAVE_QUP_0 RPM_ALWAYS_TAG>,
+						<&system_noc MASTER_QUP_0 RPM_ALWAYS_TAG
+						 &mc_virt SLAVE_EBI_CH0 RPM_ALWAYS_TAG>;
+				interconnect-names = "qup-core",
+						     "qup-config",
+						     "qup-memory";
+
+				dmas = <&gpi_dma0 0 4 QCOM_GPI_I2C>,
+				       <&gpi_dma0 1 4 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
+
+				pinctrl-0 = <&qup_i2c4_data_clk>;
+				pinctrl-names = "default";
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				status = "disabled";
+			};
+
+			uart4: serial@4a90000 {
+				compatible = "qcom,geni-uart";
+				reg = <0x0 0x04a90000 0x0 0x4000>;
+
+				interrupts = <GIC_SPI 531 IRQ_TYPE_LEVEL_HIGH 0>;
+
+				clocks = <&gcc GCC_QUPV3_WRAP0_S4_CLK>;
+				clock-names = "se";
+
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
+						 &clk_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
+						<&mem_noc MASTER_AMPSS_M0 RPM_ALWAYS_TAG
+						 &config_noc SLAVE_QUP_0 RPM_ALWAYS_TAG>;
+				interconnect-names = "qup-core",
+						     "qup-config";
+
+				pinctrl-0 = <&qup_uart4_default>;
+				pinctrl-names = "default";
+
+				status = "disabled";
+			};
+
+			i2c5: i2c@4a94000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0x0 0x4a94000 0x0 0x4000>;
+
+				interrupts = <GIC_SPI 532 IRQ_TYPE_LEVEL_HIGH 0>;
+
+				clocks = <&gcc GCC_QUPV3_WRAP0_S5_CLK>;
+				clock-names = "se";
+
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
+						 &clk_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
+						<&mem_noc MASTER_AMPSS_M0 RPM_ALWAYS_TAG
+						 &config_noc SLAVE_QUP_0 RPM_ALWAYS_TAG>,
+						<&system_noc MASTER_QUP_0 RPM_ALWAYS_TAG
+						 &mc_virt SLAVE_EBI_CH0 RPM_ALWAYS_TAG>;
+				interconnect-names = "qup-core",
+						     "qup-config",
+						     "qup-memory";
+
+				dmas = <&gpi_dma0 0 5 QCOM_GPI_I2C>,
+				       <&gpi_dma0 1 5 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
+
+				pinctrl-0 = <&qup_i2c5_data_clk>;
+				pinctrl-names = "default";
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				status = "disabled";
+			};
+
+			spi5: spi@4a94000 {
+				compatible = "qcom,geni-spi";
+				reg = <0x0 0x4a94000 0x0 0x4000>;
+
+				interrupts = <GIC_SPI 532 IRQ_TYPE_LEVEL_HIGH 0>;
+
+				clocks = <&gcc GCC_QUPV3_WRAP0_S5_CLK>;
+				clock-names = "se";
+
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
+						 &clk_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
+						<&mem_noc MASTER_AMPSS_M0 RPM_ALWAYS_TAG
+						 &config_noc SLAVE_QUP_0 RPM_ALWAYS_TAG>;
+				interconnect-names = "qup-core",
+						     "qup-config";
+
+				dmas = <&gpi_dma0 0 5 QCOM_GPI_SPI>,
+				       <&gpi_dma0 1 5 QCOM_GPI_SPI>;
+				dma-names = "tx", "rx";
+
+				pinctrl-0 = <&qup_spi5_data_clk>, <&qup_spi5_cs>;
+				pinctrl-names = "default";
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				status = "disabled";
+			};
+
+			uart5: serial@4a94000 {
+				compatible = "qcom,geni-uart";
+				reg = <0x0 0x04a94000 0x0 0x4000>;
+
+				interrupts = <GIC_SPI 532 IRQ_TYPE_LEVEL_HIGH 0>;
+
+				clocks = <&gcc GCC_QUPV3_WRAP0_S5_CLK>;
+				clock-names = "se";
+
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
+						 &clk_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
+						<&mem_noc MASTER_AMPSS_M0 RPM_ALWAYS_TAG
+						 &config_noc SLAVE_QUP_0 RPM_ALWAYS_TAG>;
+				interconnect-names = "qup-core",
+						     "qup-config";
+
+				pinctrl-0 = <&qup_uart5_default>, <&qup_uart5_cts_rts>;
+				pinctrl-names = "default";
+
+				status = "disabled";
+			};
+
+			i2c6: i2c@4a98000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0x0 0x4a98000 0x0 0x4000>;
+
+				interrupts = <GIC_SPI 533 IRQ_TYPE_LEVEL_HIGH 0>;
+
+				clocks = <&gcc GCC_QUPV3_WRAP0_S6_CLK>;
+				clock-names = "se";
+
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
+						 &clk_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
+						<&mem_noc MASTER_AMPSS_M0 RPM_ALWAYS_TAG
+						 &config_noc SLAVE_QUP_0 RPM_ALWAYS_TAG>,
+						<&system_noc MASTER_QUP_0 RPM_ALWAYS_TAG
+						 &mc_virt SLAVE_EBI_CH0 RPM_ALWAYS_TAG>;
+				interconnect-names = "qup-core",
+						     "qup-config",
+						     "qup-memory";
+
+				dmas = <&gpi_dma0 0 6 QCOM_GPI_I2C>,
+				       <&gpi_dma0 1 6 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
+
+				pinctrl-0 = <&qup_i2c6_data_clk>;
+				pinctrl-names = "default";
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				status = "disabled";
+			};
+
+			spi6: spi@4a98000 {
+				compatible = "qcom,geni-spi";
+				reg = <0x0 0x4a98000 0x0 0x4000>;
+
+				interrupts = <GIC_SPI 533 IRQ_TYPE_LEVEL_HIGH 0>;
+
+				clocks = <&gcc GCC_QUPV3_WRAP0_S6_CLK>;
+				clock-names = "se";
+
+				interconnects =	<&clk_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
+						 &clk_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
+						<&mem_noc MASTER_AMPSS_M0 RPM_ALWAYS_TAG
+						 &config_noc SLAVE_QUP_0 RPM_ALWAYS_TAG>;
+				interconnect-names = "qup-core",
+						     "qup-config";
+
+				dmas = <&gpi_dma0 0 6 QCOM_GPI_SPI>,
+				       <&gpi_dma0 1 6 QCOM_GPI_SPI>;
+				dma-names = "tx", "rx";
+
+				pinctrl-0 = <&qup_spi6_data_clk>, <&qup_spi6_cs>;
+				pinctrl-names = "default";
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				status = "disabled";
+			};
+
+			uart6: serial@4a98000 {
+				compatible = "qcom,geni-uart";
+				reg = <0x0 0x04a98000 0x0 0x4000>;
+
+				interrupts = <GIC_SPI 533 IRQ_TYPE_LEVEL_HIGH 0>;
+
+				clocks = <&gcc GCC_QUPV3_WRAP0_S6_CLK>;
+				clock-names = "se";
+
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
+						 &clk_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
+						<&mem_noc MASTER_AMPSS_M0 RPM_ALWAYS_TAG
+						 &config_noc SLAVE_QUP_0 RPM_ALWAYS_TAG>;
+				interconnect-names = "qup-core",
+						     "qup-config";
+
+				pinctrl-0 = <&qup_uart6_default>, <&qup_uart6_cts_rts>;
+				pinctrl-names = "default";
+
+				status = "disabled";
+			};
+
+			i2c7: i2c@4a9c000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0x0 0x4a9c000 0x0 0x4000>;
+
+				interrupts = <GIC_SPI 534 IRQ_TYPE_LEVEL_HIGH 0>;
+
+				clocks = <&gcc GCC_QUPV3_WRAP0_S7_CLK>;
+				clock-names = "se";
+
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
+						 &clk_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
+						<&mem_noc MASTER_AMPSS_M0 RPM_ALWAYS_TAG
+						 &config_noc SLAVE_QUP_0 RPM_ALWAYS_TAG>,
+						<&system_noc MASTER_QUP_0 RPM_ALWAYS_TAG
+						 &mc_virt SLAVE_EBI_CH0 RPM_ALWAYS_TAG>;
+				interconnect-names = "qup-core",
+						     "qup-config",
+						     "qup-memory";
+
+				dmas = <&gpi_dma0 0 7 QCOM_GPI_I2C>,
+				       <&gpi_dma0 1 7 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
+
+				pinctrl-0 = <&qup_i2c7_data_clk>;
+				pinctrl-names = "default";
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				status = "disabled";
+			};
+
+			uart7: serial@4a9c000 {
+				compatible = "qcom,geni-uart";
+				reg = <0x0 0x04a9c000 0x0 0x4000>;
+
+				interrupts = <GIC_SPI 534 IRQ_TYPE_LEVEL_HIGH 0>;
+
+				clocks = <&gcc GCC_QUPV3_WRAP0_S7_CLK>;
+				clock-names = "se";
+
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
+						 &clk_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
+						<&mem_noc MASTER_AMPSS_M0 RPM_ALWAYS_TAG
+						 &config_noc SLAVE_QUP_0 RPM_ALWAYS_TAG>;
+				interconnect-names = "qup-core",
+						     "qup-config";
+
+				pinctrl-0 = <&qup_uart7_default>;
+				pinctrl-names = "default";
+
+				status = "disabled";
+			};
+
+			i2c8: i2c@4aa0000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0x0 0x4aa0000 0x0 0x4000>;
+
+				interrupts = <GIC_SPI 535 IRQ_TYPE_LEVEL_HIGH 0>;
+
+				clocks = <&gcc GCC_QUPV3_WRAP0_S8_CLK>;
+				clock-names = "se";
+
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
+						 &clk_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
+						<&mem_noc MASTER_AMPSS_M0 RPM_ALWAYS_TAG
+						 &config_noc SLAVE_QUP_0 RPM_ALWAYS_TAG>,
+						<&system_noc MASTER_QUP_0 RPM_ALWAYS_TAG
+						 &mc_virt SLAVE_EBI_CH0 RPM_ALWAYS_TAG>;
+				interconnect-names = "qup-core",
+						     "qup-config",
+						     "qup-memory";
+
+				dmas = <&gpi_dma0 0 8 QCOM_GPI_I2C>,
+				       <&gpi_dma0 1 8 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
+
+				pinctrl-0 = <&qup_i2c8_data_clk>;
+				pinctrl-names = "default";
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				status = "disabled";
+			};
+
+			spi8: spi@4aa0000 {
+				compatible = "qcom,geni-spi";
+				reg = <0x0 0x4aa0000 0x0 0x4000>;
+
+				interrupts = <GIC_SPI 535 IRQ_TYPE_LEVEL_HIGH 0>;
+
+				clocks = <&gcc GCC_QUPV3_WRAP0_S8_CLK>;
+				clock-names = "se";
+
+				interconnects =	<&clk_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
+						 &clk_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
+						<&mem_noc MASTER_AMPSS_M0 RPM_ALWAYS_TAG
+						 &config_noc SLAVE_QUP_0 RPM_ALWAYS_TAG>;
+				interconnect-names = "qup-core",
+						     "qup-config";
+
+				dmas = <&gpi_dma0 0 8 QCOM_GPI_SPI>,
+				       <&gpi_dma0 1 8 QCOM_GPI_SPI>;
+				dma-names = "tx", "rx";
+
+				pinctrl-0 = <&qup_spi8_data_clk>, <&qup_spi8_cs>;
+				pinctrl-names = "default";
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				status = "disabled";
+			};
+
+			uart8: serial@4aa0000 {
+				compatible = "qcom,geni-uart";
+				reg = <0x0 0x04aa0000 0x0 0x4000>;
+
+				interrupts = <GIC_SPI 535 IRQ_TYPE_LEVEL_HIGH 0>;
+
+				clocks = <&gcc GCC_QUPV3_WRAP0_S8_CLK>;
+				clock-names = "se";
+
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
+						 &clk_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
+						<&mem_noc MASTER_AMPSS_M0 RPM_ALWAYS_TAG
+						 &config_noc SLAVE_QUP_0 RPM_ALWAYS_TAG>;
+				interconnect-names = "qup-core",
+						     "qup-config";
+
+				pinctrl-0 = <&qup_uart8_default>, <&qup_uart8_cts_rts>;
+				pinctrl-names = "default";
+
+				status = "disabled";
+			};
+
+			i2c9: i2c@4aa4000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0x0 0x4aa4000 0x0 0x4000>;
+
+				interrupts = <GIC_SPI 536 IRQ_TYPE_LEVEL_HIGH 0>;
+
+				clocks = <&gcc GCC_QUPV3_WRAP0_S9_CLK>;
+				clock-names = "se";
+
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
+						 &clk_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
+						<&mem_noc MASTER_AMPSS_M0 RPM_ALWAYS_TAG
+						 &config_noc SLAVE_QUP_0 RPM_ALWAYS_TAG>,
+						<&system_noc MASTER_QUP_0 RPM_ALWAYS_TAG
+						 &mc_virt SLAVE_EBI_CH0 RPM_ALWAYS_TAG>;
+				interconnect-names = "qup-core",
+						     "qup-config",
+						     "qup-memory";
+
+				dmas = <&gpi_dma0 0 9 QCOM_GPI_I2C>,
+				       <&gpi_dma0 1 9 QCOM_GPI_I2C>;
+				dma-names = "tx", "rx";
+
+				pinctrl-0 = <&qup_i2c9_data_clk>;
+				pinctrl-names = "default";
+
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				status = "disabled";
+			};
+
+			uart9: serial@4aa4000 {
+				compatible = "qcom,geni-uart";
+				reg = <0x0 0x04aa4000 0x0 0x4000>;
+
+				interrupts = <GIC_SPI 536 IRQ_TYPE_LEVEL_HIGH 0>;
+
+				clocks = <&gcc GCC_QUPV3_WRAP0_S9_CLK>;
+				clock-names = "se";
+
+				interconnects = <&clk_virt MASTER_QUP_CORE_0 RPM_ALWAYS_TAG
+						 &clk_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
+						<&mem_noc MASTER_AMPSS_M0 RPM_ALWAYS_TAG
+						 &config_noc SLAVE_QUP_0 RPM_ALWAYS_TAG>;
+				interconnect-names = "qup-core",
+						     "qup-config";
+
+				pinctrl-0 = <&qup_uart9_default>;
+				pinctrl-names = "default";
+
+				status = "disabled";
+			};
 		};
 
 		sram@c11e000 {

-- 
2.34.1


