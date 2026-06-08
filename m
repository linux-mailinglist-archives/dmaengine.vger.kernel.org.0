Return-Path: <dmaengine+bounces-11333-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KoA6MoPCJmqFkAIAu9opvQ
	(envelope-from <dmaengine+bounces-11333-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 08 Jun 2026 15:24:19 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA13656996
	for <lists+dmaengine@lfdr.de>; Mon, 08 Jun 2026 15:24:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=TqQU2Fud;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=DlamZLU1;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11333-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11333-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 360EE303A105
	for <lists+dmaengine@lfdr.de>; Mon,  8 Jun 2026 13:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A0C3AF677;
	Mon,  8 Jun 2026 13:11:45 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07C837F72D
	for <dmaengine@vger.kernel.org>; Mon,  8 Jun 2026 13:11:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780924305; cv=none; b=DBGqTqBDx1S08S0qkvHIh7oTC7RQDitaxFdRAfLl5x16r8h/hsXVJG7UNSZISAphR6OXcG237Z7GLEqsPSzMShihYLeQSoP5s7hVAOaZMkqDLWFwxIffpNRzwY5EIXCtleQ43bDPvBM9LIttdKn7O+PulNvBZO4oLgSRCWs++SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780924305; c=relaxed/simple;
	bh=UpWiNiWvCfhK/+y47/tOe6slWfWCxIGegP01oA/xlhE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bLQ/5/x/kvjdPEaWXzpShuk7ou0X5j+IRfKFFTISyZ2Xofk+ova/uuYUXRikHpbK0DO3EOx3Bpq5+nB0ASiKye7Yf9Lptk2uPRMac+LCk+7rRujD8Nc/6bCzeL7BydOKdrpE7DoAGYOnl7Sqx9WAfKRisrKslmBp0bfwdQBnhe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TqQU2Fud; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DlamZLU1; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658Cn49i3593907
	for <dmaengine@vger.kernel.org>; Mon, 8 Jun 2026 13:11:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VodMmaqfta7JuQJ97oMrgxEPcqL/4x3SLmYvObaaxkM=; b=TqQU2FudxTKxVz6G
	W6A4vjXsN56ymtL4VZGyOlZ7Cdm0a1zamUEXoXuOwbJhv50p5pNF8+Djm3NVSJR6
	ITd5TohAdU2AnReDfMTYwg2mjfY7gZOJpWxSgfsCufRoUZoR2iWdOG1dS9h8cXBV
	Q2B3JbE6w94yr1ngPS9H6qeuGWei1Fa14pjfr3UclRBXSBiOxZ3RYZ6yQq1EE00v
	02qUu9QQ621CEIxcroR+Y1VFwOg9JI6FMOSN95YCi5ioAMFwUrmzWxxMNOtewUi8
	+MdB2dDPtvBh5ugk6X44Y9LIupduc5/RXR73eQYuunX7ex8deSkTPEZXIqFO0kKy
	kJGEAw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enx2rr3fe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 08 Jun 2026 13:11:42 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2bf32259e0eso58231985ad.0
        for <dmaengine@vger.kernel.org>; Mon, 08 Jun 2026 06:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780924302; x=1781529102; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VodMmaqfta7JuQJ97oMrgxEPcqL/4x3SLmYvObaaxkM=;
        b=DlamZLU1Xc7ytNCN18Eg95L8JyzzvHxQDGfyob2KdKS8te181mlsXt43GKiv3Gmu0T
         qqzZLK45xoWsBKPC0HucGse/AXHNkbgPQhery+zychLerxMs4jj/vQH64IwyM/4VCv9C
         H77Q8AYv8lwE43m6bwG2gKqyrWKmjfmc+QVzwYiK2aG6AL1NIvuuqOcepOoPH8iCnlqs
         HhuTYU9e102J2rOiaoT/g3DVDPD7e3uuE4wZRTuO4n0n5fQyfLqmAaZOCT0ir2KBmEqt
         ePEPaaV/LXtRC7/rOBdib3iRa0z3sV73HdksYhGZJdTMbRe6S923nTiYxGWkqmZvHbn2
         nXvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780924302; x=1781529102;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VodMmaqfta7JuQJ97oMrgxEPcqL/4x3SLmYvObaaxkM=;
        b=mPffo/y2IkvSYMxMWE2cYU9Bvu/9mO18VlMDknPKiwwjgp1OTSA8g7ij5RGgS02rTY
         uVsH1kSlQZH1FpkgHk7XHPTsx0tiJuPZRUTGOFdLnb0Mdgwp3I3lZFguVpOYHWwUzMIX
         nP9hFSSHvStFo2uB8jic5ApT5tt0CzSLgSTewQyGE1HutkNCmbVkflea6y8FbmNzCJmu
         sgqMuEgxCEROvLeYEM5p7sEuYMP0pH7uAtPHw7j7SPPJBydHxMRfL7KD/2QVlvvQIwFH
         h2zGN7NMCy9DP+UyjYSkIFhq9XnBrANX8OR5VxaVQPUc/7/Tjv4zhz6+qtqpViG76bNj
         aFcg==
X-Forwarded-Encrypted: i=1; AFNElJ/FebrdQBH7ViWAfIFfzfQL3mhHI98tA8+TZM2mMeupkP+MlGWJ9kKyHwuax97MbFT4l+YBIhDrSXo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8KUaF+hFUfoUdvdXF72gedgWAaiz01i/lkYWySDQdu+f8fJfI
	9yI62/fykiYe+oB4gijpd7kzMrt/PqJFYB5ikh5anu9hA10tsX3sq9dVS8pqaA6UooIvgCuAmIz
	tcgupHm+E/R596tOxrfrNvxK2V27WoMHYuAs28ovcBO5wZit+w6/S82cs1DPE4eo=
X-Gm-Gg: Acq92OEXVtqyzX08wHoh4cbTHakhiICstzTSMgdn099Ykxjc/Qwedfo8pyAZ2DQ/spT
	+xX2So5wctMSduHZz+0FFs77bnmYwthBSTVyDFNGV7L+Bp2+IeqnKjPUwczL00+tfJ+IhujVpmT
	PPSGa72VMJFI8v4von0+6Pvnza3iQxXy47cR0tdSoddvZK367YvzYLsClY6yjFrN2PRE853BvSg
	nwCvYYlxfCnwHwQjqO/5WTXHeLDwsG+v7itO712cvndkvHDNm7Fox2Q+T0UepZPY4F2zm+tRZ5p
	rmT8l4sA8zuRQ+pxuqSjRYoOCbJo+tziULSVpvcV5GLTyUsj3LV6N5oRYaPAdMY90RhZozClpV+
	0M+VUeXde9nDl0ezSuKYKXWanifiU4PD6bWIUJqJm2dQxsX0=
X-Received: by 2002:a17:903:1b43:b0:2c0:a360:45e9 with SMTP id d9443c01a7336-2c1e85aad69mr180110995ad.29.1780924301544;
        Mon, 08 Jun 2026 06:11:41 -0700 (PDT)
X-Received: by 2002:a17:903:1b43:b0:2c0:a360:45e9 with SMTP id d9443c01a7336-2c1e85aad69mr180110305ad.29.1780924301033;
        Mon, 08 Jun 2026 06:11:41 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c1664ad172sm185235845ad.83.2026.06.08.06.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 06:11:40 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Mon, 08 Jun 2026 18:40:30 +0530
Subject: [PATCH v4 10/10] arm64: dts: qcom: shikra: Enable Bluetooth and
 WiFi on EVK boards
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-shikra-dt-m1-v4-10-2114300594a6@oss.qualcomm.com>
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
        Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780924231; l=8452;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=UpWiNiWvCfhK/+y47/tOe6slWfWCxIGegP01oA/xlhE=;
 b=GHxQLKYvkE3nSrVSY4+OCTeKQs7zY1hXAL2zERAWQMMWBnsiy1mTgRB9eM3y9Pv92y4LBiZca
 89QoD9p3eywCxRIzz6uTDDkypNkDsOnK5oTyjtdlWDeapyDF4DCWVOr
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-GUID: y9hRt3vaMkgRW2y-6YJcdtdQFIAFWys5
X-Proofpoint-ORIG-GUID: y9hRt3vaMkgRW2y-6YJcdtdQFIAFWys5
X-Authority-Analysis: v=2.4 cv=JdqMa0KV c=1 sm=1 tr=0 ts=6a26bf8e cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=0EpCGlkTwZhbVQC-sXkA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDEyNCBTYWx0ZWRfX2BxbX3iyIysS
 0cqo5reyzArK+q9alD/gnj6EaJRoAnyihlh/Qoe+t4lQtJKvr+6QefaUjCF1VA3t/bNkqJhkpt2
 t8AryHFP8cKBXhHjDQv8LVmUZTVKuUBLDz9wTrFmPwUd8a93uXRw8uFoWiWMJ9pkN//KWjQCvww
 wQqz7JAN/6pF8aMd2OS3+uUnjyREtwR6gy1cysOScdkW5gYMqQ4hGIw9R6qwq0PCnRsRQRyMcA5
 ToRrRFKnNu2uH3u+MduxEsuGTgxBBoy5qD3EYLFdeSUv89DYZQPVbuQ9NBmWXR4O4tc5sRzNBld
 7t25bORtP8bf9uMrhgspGyboRGzGBw/6uAD+oRvmvqDT7bbUYEcuud3XwpL0KVlsf7vY5AKpRP0
 I3qVbdTn4KhKrdMx66E+0MYp21kO8reKlbGFMPd4t+l+RLL6+Xd1cCCZJcfeLIpzgFtkSLtn+4t
 gE4IaXq4lelvkB9a+OQ==
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11333-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:krzk@kernel.org,m:djakov@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:linux-arm-msm@vger.kernel.org,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pm@vger.kernel.org,m:komal.bajaj@oss.qualcomm.com,m:yepuri.siddu@oss.qualcomm.com,m:miaoqing.pan@oss.qualcomm.com,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[komal.bajaj@oss.qualcomm.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[komal.bajaj@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1DA13656996

Enable Bluetooth and WiFi connectivity on Shikra CQM, CQS and IQS
EVK boards using the WCN3988 combo chip.

For Bluetooth, enable uart8 and add WCN3988 Bluetooth node with
board-specific regulator supplies across CQM, CQS and IQS Shikra
EVK boards.

For WiFi, introduce the wcn3990-wifi hardware node in shikra.dtsi
with register space, interrupts, IOMMU configuration and reserved
memory. The node is kept disabled by default and enabled per-board
with the appropriate PMIC supply connections and calibration variant
selection.

Co-developed-by: Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>
Signed-off-by: Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>
Co-developed-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts | 59 +++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts | 59 +++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/shikra-evk.dtsi    | 15 +++++++
 arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts | 67 +++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/shikra.dtsi        | 23 ++++++++++
 5 files changed, 223 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
index b112b21b1d79..683b5245923b 100644
--- a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
+++ b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
@@ -16,11 +16,48 @@ / {
 	aliases {
 		mmc0 = &sdhc_1;
 		serial0 = &uart0;
+		serial1 = &uart8;
 	};
 
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
+
+	wcn3988-pmu {
+		compatible = "qcom,wcn3988-pmu";
+
+		pinctrl-0 = <&sw_ctrl_default>;
+		pinctrl-names = "default";
+
+		vddio-supply = <&pm4125_l7>;
+		vddxo-supply = <&pm4125_l13>;
+		vddrf-supply = <&pm4125_l10>;
+		vddch0-supply = <&pm4125_l22>;
+
+		swctrl-gpios = <&tlmm 88 GPIO_ACTIVE_HIGH>;
+
+		regulators {
+			vreg_pmu_io: ldo0 {
+				regulator-name = "vreg_pmu_io";
+			};
+
+			vreg_pmu_xo: ldo1 {
+				regulator-name = "vreg_pmu_xo";
+			};
+
+			vreg_pmu_rf: ldo2 {
+				regulator-name = "vreg_pmu_rf";
+			};
+
+			vreg_pmu_ch0: ldo3 {
+				regulator-name = "vreg_pmu_ch0";
+			};
+
+			vreg_pmu_ch1: ldo4 {
+				regulator-name = "vreg_pmu_ch1";
+			};
+		};
+	};
 };
 
 &remoteproc_cdsp {
@@ -57,3 +94,25 @@ &sdhc_1 {
 
 	status = "okay";
 };
+
+&uart8 {
+	status = "okay";
+
+	bluetooth {
+		vddio-supply = <&vreg_pmu_io>;
+		vddxo-supply = <&vreg_pmu_xo>;
+		vddrf-supply = <&vreg_pmu_rf>;
+		vddch0-supply = <&vreg_pmu_ch0>;
+	};
+};
+
+&wifi {
+	vdd-0.8-cx-mx-supply = <&pm4125_l7>;
+	vdd-1.8-xo-supply = <&vreg_pmu_xo>;
+	vdd-1.3-rfa-supply = <&vreg_pmu_rf>;
+	vdd-3.3-ch0-supply = <&vreg_pmu_ch0>;
+	qcom,calibration-variant = "Shikra_EVK";
+	firmware-name = "shikra";
+
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts b/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
index e62ba5aef71f..26ff8007a819 100644
--- a/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
+++ b/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
@@ -16,11 +16,48 @@ / {
 	aliases {
 		mmc0 = &sdhc_1;
 		serial0 = &uart0;
+		serial1 = &uart8;
 	};
 
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
+
+	wcn3988-pmu {
+		compatible = "qcom,wcn3988-pmu";
+
+		pinctrl-0 = <&sw_ctrl_default>;
+		pinctrl-names = "default";
+
+		vddio-supply = <&pm4125_l7>;
+		vddxo-supply = <&pm4125_l13>;
+		vddrf-supply = <&pm4125_l10>;
+		vddch0-supply = <&pm4125_l22>;
+
+		swctrl-gpios = <&tlmm 88 GPIO_ACTIVE_HIGH>;
+
+		regulators {
+			vreg_pmu_io: ldo0 {
+				regulator-name = "vreg_pmu_io";
+			};
+
+			vreg_pmu_xo: ldo1 {
+				regulator-name = "vreg_pmu_xo";
+			};
+
+			vreg_pmu_rf: ldo2 {
+				regulator-name = "vreg_pmu_rf";
+			};
+
+			vreg_pmu_ch0: ldo3 {
+				regulator-name = "vreg_pmu_ch0";
+			};
+
+			vreg_pmu_ch1: ldo4 {
+				regulator-name = "vreg_pmu_ch1";
+			};
+		};
+	};
 };
 
 &remoteproc_cdsp {
@@ -57,3 +94,25 @@ &sdhc_1 {
 
 	status = "okay";
 };
+
+&uart8 {
+	status = "okay";
+
+	bluetooth {
+		vddio-supply = <&vreg_pmu_io>;
+		vddxo-supply = <&vreg_pmu_xo>;
+		vddrf-supply = <&vreg_pmu_rf>;
+		vddch0-supply = <&vreg_pmu_ch0>;
+	};
+};
+
+&wifi {
+	vdd-0.8-cx-mx-supply = <&pm4125_l7>;
+	vdd-1.8-xo-supply = <&vreg_pmu_xo>;
+	vdd-1.3-rfa-supply = <&vreg_pmu_rf>;
+	vdd-3.3-ch0-supply = <&vreg_pmu_ch0>;
+	qcom,calibration-variant = "Shikra_EVK";
+	firmware-name = "shikra";
+
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/qcom/shikra-evk.dtsi b/arch/arm64/boot/dts/qcom/shikra-evk.dtsi
index 8b03d4eafa6d..a79f44aff968 100644
--- a/arch/arm64/boot/dts/qcom/shikra-evk.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra-evk.dtsi
@@ -8,7 +8,22 @@ &qupv3_0 {
 	status = "okay";
 };
 
+&tlmm {
+	sw_ctrl_default: sw-ctrl-default-state {
+		pins = "gpio88";
+		function = "gpio";
+		bias-pull-down;
+	};
+};
+
 &uart0 {
 	status = "okay";
 };
 
+&uart8 {
+	bluetooth {
+		compatible = "qcom,wcn3988-bt";
+		max-speed = <3200000>;
+	};
+};
+
diff --git a/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts b/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
index 727809430fd1..fd691d53a0fa 100644
--- a/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
+++ b/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
@@ -16,11 +16,56 @@ / {
 	aliases {
 		mmc0 = &sdhc_1;
 		serial0 = &uart0;
+		serial1 = &uart8;
 	};
 
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
+
+	vreg_wcn_3p3: regulator-wcn-3p3 {
+		compatible = "regulator-fixed";
+		regulator-name = "wcn_3p3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
+	wcn3988-pmu {
+		compatible = "qcom,wcn3988-pmu";
+
+		pinctrl-0 = <&sw_ctrl_default>;
+		pinctrl-names = "default";
+
+		vddio-supply = <&pm8150_s4>;
+		vddxo-supply = <&pm8150_l12>;
+		vddrf-supply = <&pm8150_l8>;
+		vddch0-supply = <&vreg_wcn_3p3>;
+
+		swctrl-gpios = <&tlmm 88 GPIO_ACTIVE_HIGH>;
+
+		regulators {
+			vreg_pmu_io: ldo0 {
+				regulator-name = "vreg_pmu_io";
+			};
+
+			vreg_pmu_xo: ldo1 {
+				regulator-name = "vreg_pmu_xo";
+			};
+
+			vreg_pmu_rf: ldo2 {
+				regulator-name = "vreg_pmu_rf";
+			};
+
+			vreg_pmu_ch0: ldo3 {
+				regulator-name = "vreg_pmu_ch0";
+			};
+
+			vreg_pmu_ch1: ldo4 {
+				regulator-name = "vreg_pmu_ch1";
+			};
+		};
+	};
 };
 
 &remoteproc_cdsp {
@@ -57,3 +102,25 @@ &sdhc_1 {
 
 	status = "okay";
 };
+
+&uart8 {
+	status = "okay";
+
+	bluetooth {
+		vddio-supply = <&vreg_pmu_io>;
+		vddxo-supply = <&vreg_pmu_xo>;
+		vddrf-supply = <&vreg_pmu_rf>;
+		vddch0-supply = <&vreg_pmu_ch0>;
+	};
+};
+
+&wifi {
+	vdd-0.8-cx-mx-supply = <&pm8150_s4>;
+	vdd-1.8-xo-supply = <&vreg_pmu_xo>;
+	vdd-1.3-rfa-supply = <&vreg_pmu_rf>;
+	vdd-3.3-ch0-supply = <&vreg_pmu_ch0>;
+	qcom,calibration-variant = "Shikra_EVK";
+	firmware-name = "shikra";
+
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index c1f25ce89bb1..6bac6ebac8da 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -2064,6 +2064,29 @@ apps_smmu: iommu@c600000 {
 				     <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH 0>;
 		};
 
+		wifi: wifi@c800000 {
+			compatible = "qcom,wcn3990-wifi";
+			reg = <0x0 0x0c800000 0x0 0x800000>;
+			reg-names = "membase";
+			memory-region = <&wlan_mem>;
+			interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 359 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 360 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 361 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 362 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 363 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 364 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 365 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 366 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 367 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 368 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 369 IRQ_TYPE_LEVEL_HIGH 0>;
+			iommus = <&apps_smmu 0x1a0 0x1>;
+			qcom,msa-fixed-perm;
+
+			status = "disabled";
+		};
+
 		intc: interrupt-controller@f200000 {
 			compatible = "arm,gic-v3";
 			reg = <0x0 0xf200000 0x0 0x10000>,

-- 
2.34.1


