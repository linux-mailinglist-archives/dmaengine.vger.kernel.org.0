Return-Path: <dmaengine+bounces-11948-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mPRzCmE6RmpFMQsAu9opvQ
	(envelope-from <dmaengine+bounces-11948-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 12:16:01 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 706A56F5BA7
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 12:16:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=BmdhPhnQ;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=he1YoIv7;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11948-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11948-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88FB030315F9
	for <lists+dmaengine@lfdr.de>; Thu,  2 Jul 2026 10:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69874C901D;
	Thu,  2 Jul 2026 09:51:14 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4834A2E2D
	for <dmaengine@vger.kernel.org>; Thu,  2 Jul 2026 09:51:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782985874; cv=none; b=EY2D6pf8jx3PwI1DfQXMH21nEg+YAEduhbPPQUoy//QRUTKC38ioM1aSQrb/Q98u4GZS1//UISpLrCrgU7sKxVM8qH5oRiUGOT2o3L9bf6lb4vG8TTKiYoDVKkIUY8gaSp2cUE/+obfaxZHM2oDs+6YRzmU3i9fjciAKMsX8X5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782985874; c=relaxed/simple;
	bh=MG3sAgTxM2yS2k98bs7iCxw+/UEc3/K3gbnTW3sIzdo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HpNTOfv6ZiKbUxjvTnS/MNPY1ZFDzioCg85LMm9/CHm3BbzqNfhxbWL19avK3nK2/WkD+vo9sFte8cOULxgmg5qK+P79fQrZtM1NX87qWg+ZzZBAoa8/9zM4i+0HSULxPQLTRMGMjYix1TKYajAdY+jwur8hRv+XGmdWzOwreXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BmdhPhnQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=he1YoIv7; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6628YYCX3046367
	for <dmaengine@vger.kernel.org>; Thu, 2 Jul 2026 09:51:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	s+HSBk7qe7sm/8M8mPnhytls3w5+cC3ur32RaFcr0Zw=; b=BmdhPhnQusx/1XjK
	I5UvSa4b1T87XegwtC468GWx2FpAHaxBfJqgmSLY6XJbcmHLUP4Cxqm0ybfpl6jH
	fS5wWwOdh/YYqmiAxvo9Haeigt0wTk+H8xYuoZUTzAdjcygMDrK2V3m+ftA5BLnJ
	vmXGgq2/l3khI7h2QHpsIP5F7bz6pL6RTaNOiWN9t0vCMZFM+WcshMrKRJ7DdzqJ
	vuNy8K7n9orBQ8b3/vFXGLVM3abRb7Tf+PeRBMvUmCSDcCIKUSDp5XcWe6/OVhth
	JSJT6WhBFNtJzH5NyBv8FdKUMGrxqIURRcGu+BBM1FBfMgVIve0MCjxENggLuLY7
	igtOdA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f58k3awap-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Thu, 02 Jul 2026 09:51:12 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-845317fa7e6so2491941b3a.3
        for <dmaengine@vger.kernel.org>; Thu, 02 Jul 2026 02:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782985871; x=1783590671; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s+HSBk7qe7sm/8M8mPnhytls3w5+cC3ur32RaFcr0Zw=;
        b=he1YoIv7EHv528NdSkvaVMbj8LNhLhKWoklwWr170cIVu5hjBNujvnMmfzVy8pKzRu
         Cp/324lnuzrNQk4BDlUuK5EQ2/ScIHpJAzXQAQNG6ZCyPqP8Kcy++1pLj5J/YjYCPRj7
         a0had4rPo+GrQocidLYkGunKYhEtPZ8qtQeRDLFnSSOIWlvFdekExJDqlvmlTpHZIef8
         HXBI3ZWzQ48N1gynIP5SKh3cs9sKVGnYyQHYXrDL1OSUGHRvjPCBKQYU3s1N6wrdve7J
         rqwBVANaTbGU2Oo79sifWhGtGeswE6uMZPdA9M88gt0e3Ot/kh2JpqpGalkb5hwPSgvp
         xeRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782985871; x=1783590671;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s+HSBk7qe7sm/8M8mPnhytls3w5+cC3ur32RaFcr0Zw=;
        b=hsa+fRhAAzRBHxz6pvmVCjCIDZrEV1pmpLXVMd0rAkExs2dnVaEt597FfL7qMlyHnq
         T8HPunYojmPQP2zwXpJ9saWq90ROl3sxtVpL068+i5bW5Zf4BzXpwT1b78QgpTRJPc+r
         J3dTwXpNv47zthM05bRqqYDHTLRFfmt8En3rdzSEnBGM3i9yPIWQkY8CXwo1vTcgDbwk
         Ode7zYMRh90Jyb9qdE2X8NwZQZ4X8uzO1vYnoApHSoRLG2cyAAiULNZHhno+BnAje8n0
         98KhorDu35yWdlplUjzPOWz6+NNE5t3c3V+L2cVBIQjMI34ymkE5TR1vWC6eaL9ja8hd
         RPRg==
X-Forwarded-Encrypted: i=1; AHgh+Rr65Un7ktNQevTSKJPcxrDBB2nOoa0QSP65gGmdk2fSgxgdkgtQosWbZwjWwWfocrEBqtiyDRfYJFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS0kx3D1cQu++YqJpj8ganWegjKDaCYo+H5Z0kN+Uzqy5hQhfi
	GDQYDtcwKGJ4tzicwG/HQ7oZBE5oxvOtcBiB4iXxtKqbAE5PhowCNpEx/RKxXxHQhQCy6xXWn3m
	43sPgMV7XW2IOhZ7hkYiMSzv7st5+SKcCf4iTtM07WPvVllKK3vC7dIHmWfoU+70=
X-Gm-Gg: AfdE7cnORR47pOJxwv7R/iKVct9e+1dUDt1pHHzQSMnB0wxtCiWpt3Kn6p98oFiCC28
	fIwQCNnzW30yOzd+NzoY19SpQD0FGxtwWBRzEGLAE+N8ewlJfx+1ycaJpoGRfMWeJh0jyKfoyio
	BCWuD82BpU00ttIMB7GyuPSBdTBIldWBkE84K1Kgs9HwdL9bufVaPqJvOVQ4bEMYOAnN0LXOQCW
	Xu40TzNi7Brm4NtnxGZN7C5X4Y0b8Yydi7WdW62OEMLNqB5voZjc3din9LTMeSgEsg8ayL/aEq1
	ytHRutgMy+DLwr4cX1qTYptqbgFvF/d1R+inJPZqwANhIT5ha8j9+dQkw9szBOrZU5Pan+17ZG6
	Sj3py+KrQb0wilingYn1XWNuEcw==
X-Received: by 2002:a05:6a00:6ca7:b0:845:e0ee:29ec with SMTP id d2e1a72fcca58-847c096d0d7mr5173781b3a.35.1782985871152;
        Thu, 02 Jul 2026 02:51:11 -0700 (PDT)
X-Received: by 2002:a05:6a00:6ca7:b0:845:e0ee:29ec with SMTP id d2e1a72fcca58-847c096d0d7mr5173743b3a.35.1782985870246;
        Thu, 02 Jul 2026 02:51:10 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847cb78ee2esm1110051b3a.24.2026.07.02.02.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 02:51:09 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Thu, 02 Jul 2026 15:20:45 +0530
Subject: [PATCH v5 03/11] arm64: dts: qcom: shikra: Add DDR BWMON support
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-shikra-dt-m1-v5-3-f911ac92720c@oss.qualcomm.com>
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
        Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782985846; l=1830;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=FgXZj7vad2zgvA0RfnbjlrO8hgDk3pUjpoRSx0IOZh0=;
 b=t9FPDceZlfvNHbbzM0xKA4qbpZi1OETvyq/t2FF7ThWRzfT4PoB2mWMNrJFnS1zY6k5B14AHY
 AUua33tvB5sDpUPT/uzoDAfpTt1KKH9TkT8+23HepTkq37wyP5Cxw6s
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDEwMSBTYWx0ZWRfXwRJc/98F+c2Y
 0RjwBGlWRuVKxL15UgPgljLeyIot639Gab6gUD8lkcqftJSVgCx7gARFPJARoJvSw+sV8T4JdsM
 0q9sq6pUUT0L7HQcXwVGGk9Qs6/pa066Vf7WdzP5l2X+nfWAFzeTUTiuAGjhwGizMm5yjmOp9xj
 3hNpYYJE24jndHShEDcAkrXRPetT5mDZziyPAqegoKuuHDmIrHt+5WRgJrBOso9PO1cGKxFAoAl
 ieAwJ+Sb+hb8LM7RD5qQgOD0Gsi+TZdhul3iXGylb/UP1pIapAXhqhV+B6ggubFLomMFkWOLgLh
 V7QYt2LWzlTkaPbwfrlCp2D6erdll2boRrSCVDy6b+RjOmpKJC+lOgt9p8O/nBRwkcggaa6Wp2s
 YOU6yf0QA+sTfUPflfk6eFFiRNAs6VavF/sjiRxfQguEPUJNGaPyo9N1sQpxmwDhOCWWret0qHk
 rXDtLw4fv4M7mVaRuQg==
X-Authority-Analysis: v=2.4 cv=SuGgLvO0 c=1 sm=1 tr=0 ts=6a463490 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=iYP2JlN40lpobhLRj-8A:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDEwMSBTYWx0ZWRfX3IytO/CuxpxO
 H4Js7jF/SQ7utka1THJV6mg756sDQNq6GnV4LWZfbK09/jyYOrLzl7M/IZhuALjLjR7foJJSgD0
 qXCjWQjY/ztZqL9WXjxHyvvqE9qZbKA=
X-Proofpoint-ORIG-GUID: qK1-TToR-lk9wF-N7Qxg2HrVk5VblgM6
X-Proofpoint-GUID: qK1-TToR-lk9wF-N7Qxg2HrVk5VblgM6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 impostorscore=0 phishscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020101
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11948-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:krzk@kernel.org,m:djakov@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:linux-arm-msm@vger.kernel.org,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pm@vger.kernel.org,m:komal.bajaj@oss.qualcomm.com,m:sayantan.chakraborty@oss.qualcomm.com,m:konrad.dybcio@oss.qualcomm.com,m:dmitry.baryshkov@oss.qualcomm.com,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[komal.bajaj@oss.qualcomm.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,qualcomm.com:dkim,qualcomm.com:email];
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
X-Rspamd-Queue-Id: 706A56F5BA7

From: Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>

Add CPU-to-DDR BWMON nodes and their corresponding opp tables for
Shikra SoC. This is necessary to enable power management and optimize
system performance from the perspective of dynamically changing DDR
frequencies.

Signed-off-by: Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra.dtsi | 40 ++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index f0fb55b9deb9..d66b97dea319 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -661,6 +661,46 @@ rclk-pins {
 			};
 		};
 
+		pmu@c91000 {
+			compatible = "qcom,shikra-cpu-bwmon", "qcom,sc7280-llcc-bwmon";
+			reg = <0x0 0x00c91000 0x0 0x1000>;
+
+			interrupts = <GIC_SPI 468 IRQ_TYPE_LEVEL_HIGH 0>;
+
+			interconnects = <&mem_noc MASTER_AMPSS_M0 RPM_ACTIVE_TAG
+					 &mc_virt SLAVE_EBI_CH0 RPM_ACTIVE_TAG>;
+
+			operating-points-v2 = <&cpu_bwmon_opp_table>;
+
+			cpu_bwmon_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-0 {
+					opp-peak-kBps = <1200000>;
+				};
+
+				opp-1 {
+					opp-peak-kBps = <2188000>;
+				};
+
+				opp-2 {
+					opp-peak-kBps = <3072000>;
+				};
+
+				opp-3 {
+					opp-peak-kBps = <4068000>;
+				};
+
+				opp-4 {
+					opp-peak-kBps = <6220000>;
+				};
+
+				opp-5 {
+					opp-peak-kBps = <7216000>;
+				};
+			};
+		};
+
 		mem_noc: interconnect@d00000 {
 			compatible = "qcom,shikra-mem-noc-core";
 			reg = <0x0 0x00d00000 0x0 0x43080>;

-- 
2.34.1


