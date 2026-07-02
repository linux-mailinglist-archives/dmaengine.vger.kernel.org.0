Return-Path: <dmaengine+bounces-11951-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WzmQFCo5RmptMAsAu9opvQ
	(envelope-from <dmaengine+bounces-11951-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 12:10:50 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F28D26F5ABE
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 12:10:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=SHzUaduf;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=GGBN+3t3;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11951-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11951-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AE020300B9D6
	for <lists+dmaengine@lfdr.de>; Thu,  2 Jul 2026 10:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172E34DBD93;
	Thu,  2 Jul 2026 09:51:31 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F254DC540
	for <dmaengine@vger.kernel.org>; Thu,  2 Jul 2026 09:51:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782985891; cv=none; b=LmcQtz8TbIeqI/YsxtFE4IRHF4bS5TJZBYeZrhTARThRc9RUqYpubhlpalbYBLFEgU3rk8ADIp+1LTbVlWcJm9vRLtnM3T2V61YuDRiEGZVoQTtc2BhYtalhy1+V8iJmtOSthXlt+8kIODMjLdEHcJ3nWCSwIZ+Fn4n1c40Qp74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782985891; c=relaxed/simple;
	bh=gGOcOClOufbjsAy34iXb++FNQ29HyxuzrB0+WRNoYEs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ptxw10MEtnvTdoU301kT4UeizXo7IapZAUffeTvElsyz6tDEK06GAYnpOXEeoK14kgwXFjjI96vqBzPLzoiCxBmgXeEoaFGvr5niBthGSTnj7auMe7f5GBLD0mo3vTjW22h+CQogQUXHIt0K5I1vC52//zzskM9CX+Eri2GrnJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SHzUaduf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GGBN+3t3; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6624iI5A3591717
	for <dmaengine@vger.kernel.org>; Thu, 2 Jul 2026 09:51:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yjX3LlHlsVHojRvPM71du9cKmTiXYa777UZyKZrMZ7g=; b=SHzUadufY/s3D6J5
	jYV4I9Fu33H4zp0ZZCkYnCHRML12YU1hBgI7kVCduna4xuof76W7U3UxH/U00jDM
	vMXRh99YrhEphKFxD3lUWzgrZKHrh01GtRg5rkmiM+ZwYXxP2jmfHjZLhGIcvzi/
	YjKYEw6L6Yqr6hGkwcKp5fvmy1dFT5Udfmc+aPbVsAZGA9A3clAc4NU7XxcVFCY7
	//AcTQczeLYauPfjCEZkmiOky0wJJ5cxMRt6RL3K6Rw0ifaPbs6ubjDkMi5bNW1d
	qJxRAGFY+5sNttft8JwDr5WYY8hiaLnUvwnpRz+RVbdLaSowBSnzDCd5HGqNo/TS
	65j3rg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5h7n94k6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Thu, 02 Jul 2026 09:51:28 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c9d5a5b63c5so1949436a12.1
        for <dmaengine@vger.kernel.org>; Thu, 02 Jul 2026 02:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782985888; x=1783590688; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yjX3LlHlsVHojRvPM71du9cKmTiXYa777UZyKZrMZ7g=;
        b=GGBN+3t3ldLB5PiUdSmYtWVGxNGl275sChXZPDJP8tz/RCp9w2Gp7hakWVkg0Kzq7Y
         u4RhKKo8+s4EHEDeptnT4BknolYG1ctRUsxQiwUebXABT4WzNM0V6SgnrK/8SQjFKF1r
         7qinWPrfbEMkp9k7s5ySASTguVMp0UlK3Hv0EBX5l3Y7Xt0lqYA3IcQIF12okCSxIhCH
         I8zZ3Ubjb5zI10nrmEc/st559otaaQ6tyWNviXokQjcDOL8u0oQeOc9EAcl5nPBD1YEd
         H/6dbTZnjCmtmkQ/YrVx6JaHZV9EkbzkV+VfdBvuv7WX5Lqb/hbY7HaTnKMmehoduKUl
         HOwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782985888; x=1783590688;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yjX3LlHlsVHojRvPM71du9cKmTiXYa777UZyKZrMZ7g=;
        b=HY6QorX16Gmfyqjp4XIKWboRdhoZTw9jFzHgvhtrhBmfgJVUNKpWysZuAyQX61nU4Q
         PSDG6TdsiNOlNVggJkcOEof5iRmAup64r+wMn5W5U+PlX7sszP7WwbLRwrW3gjlttfW8
         XBuwIpd6SPPRAdXXX++ex1T6GVmM3mhYiDUGyiMlhq+740cSh+AMTWUlelPl7FW7wuNm
         5SkQeyekdR4TVqKNQ3hQak9iyhgaKcuUG1WZnXS2HVurgFrf5wpaKnBeg//egDHu+xS3
         s9J/MiqoNw6m8KdiOha71JBfxkwuTeH3m2Rf8bFg0QosY3ibl/fFi0/LQndQ1g4t++So
         XSFg==
X-Forwarded-Encrypted: i=1; AHgh+RpPhhtM3iZEGaU41NDWGVgMijzv419oKUO1WuqqxGU4TBS9VvONlvUzN9+fqXxC1V4blTQoGeYIGaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVju0jSjD52zLdMCFgGIkJeiZ+6F3OBqnOzIgYWbyET9UN+TZN
	xaM5yZjmz54NIh2+5VqBccWHKl3QiwwSQUQ7bfrVITr0f7orKKcUbGPrbbYdxjeNMTuJ++9dMT0
	QptCUfdn/sCwr3dgb1MEUjk+X52Fnvq5KvwH1QRKigpksn3XwLryDXfFg2jM0iog=
X-Gm-Gg: AfdE7cnK5+ozg247a7M2D0ZCs9l1laosY/qjTuXj4JD1q+IZmqircmUg8AsdnUVk4yK
	oRHsmGGzJpZFin/XKlyKSkfrHh7NG8MOtLtli6QNMOOuZwjn3BmYtbWFSSqLrw5qvCCxIKFY8WV
	PlIhB4L/R5qDfYan56CNUU03hMlXCD0RImpgVwYkJRAzG+iDcjtFBzJqhiL0l2ESATCcOsOxQKM
	WT+6tspIPHF4NtFGZk678IgxtmNomSCQHQtTA5LF2Q3OXwSSysp0YIo+0FQU46UOXux09PWiB4h
	en849dlNIvdp7VMyOPkljfObeht3ZpkNJTPMAEiALoREFyN6n8VlIfjUgroCyJqi9pNfb5O/sjJ
	viq3VWksJVb90hc0VrsbewA17Bg==
X-Received: by 2002:a05:6a00:418b:b0:845:e41f:9696 with SMTP id d2e1a72fcca58-847c072cc3bmr5192817b3a.25.1782985888077;
        Thu, 02 Jul 2026 02:51:28 -0700 (PDT)
X-Received: by 2002:a05:6a00:418b:b0:845:e41f:9696 with SMTP id d2e1a72fcca58-847c072cc3bmr5192768b3a.25.1782985887424;
        Thu, 02 Jul 2026 02:51:27 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847cb78ee2esm1110051b3a.24.2026.07.02.02.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 02:51:27 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Thu, 02 Jul 2026 15:20:48 +0530
Subject: [PATCH v5 06/11] arm64: dts: qcom: shikra: Add CDSP, LPAICP, MPSS
 remoteproc PAS nodes
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-shikra-dt-m1-v5-6-f911ac92720c@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782985846; l=5353;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=cwo48c3pu62HWaDduZIiYL7P/xZdyoCCNEnXn+MP1vA=;
 b=DQcfBfjioB+NXsOP57cL5FsYtDNL2ufF6UUo2FFsmVFL4npp0oeQb6N/oMuvwfG52i3MmpC0n
 sG6Bx5MNDY7B3ThDXMW0PrqDIcYC9Lz9h5kPA6WI7ul6Sa1VfIPqPLZ
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDEwMSBTYWx0ZWRfX1NU3IwOgmWkE
 t7tTL1Wn+ioUD6NGs7wjHubUqXw59ikT/UpUyqmfQyiNndabRy0UM5H7SZcC3lUhH2b2ySO/z+w
 a41Wteon3J2U2gTqeKsdL46f5iBvFoG4hsZpJ7quUaiAv0wNgDO2bUFMAVZHfiIshXgSGyeN44n
 Jxa8hTlQAoLg4QRfL/5Yhs3EL05rB3FhdyrQ4Bqfyq2liI3AWhNQeaRuoR/7J8td3IrxeOw8tgC
 TXSG59priScY/iTKBxNvlbMfieEANw9Ft/TDGzhrck71hUXAOwONMvTHowrMZ03wyUM6XkLDJZb
 bmJBBl0TPyntSBI6cB/VkEHe1nsWcasibTasykgOBx5bGzj8m12NlRHjQMfNOvJFf51FFvvvWHf
 WuzWd4lWlvsE2Q5XkLjU4dTCWPPvUzLf51aWdQIfiIPRqesam9lfX0+oDMkgkNXEkFEb2cfOaos
 f5EgdzIbk6iUL5CwkiA==
X-Proofpoint-ORIG-GUID: naTNXDGnf-ESioyAdz15Ow5H1lgf8aTY
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDEwMSBTYWx0ZWRfXzou2JI6B2jqR
 iAM2iuFU3BHkgOtdUpceNBCZ1TbFOVfUPXqpiDxRVW+pm25exLYpv3Rre8Tt3qCIhtmAeiCIWOg
 uIl+EbKKCV+8bWuAWTHnHQf4gXRy2Mc=
X-Proofpoint-GUID: naTNXDGnf-ESioyAdz15Ow5H1lgf8aTY
X-Authority-Analysis: v=2.4 cv=WMBPmHsR c=1 sm=1 tr=0 ts=6a4634a0 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=PL06LPxOd80rETEQ2XQA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 adultscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020101
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11951-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:krzk@kernel.org,m:djakov@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:linux-arm-msm@vger.kernel.org,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pm@vger.kernel.org,m:komal.bajaj@oss.qualcomm.com,m:bibek.patro@oss.qualcomm.com,m:konrad.dybcio@oss.qualcomm.com,m:dmitry.baryshkov@oss.qualcomm.com,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[komal.bajaj@oss.qualcomm.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,qualcomm.com:dkim,qualcomm.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[komal.bajaj@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F28D26F5ABE

From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>

Add nodes for remoteproc PAS loader for CDSP, LPAICP, MPSS subsystem.

Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra.dtsi | 164 +++++++++++++++++++++++++++++++++++
 1 file changed, 164 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index 53dddf35963e..12e4281f7b35 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -1813,6 +1813,170 @@ &clk_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
 			};
 		};
 
+		remoteproc_mpss: remoteproc@6080000 {
+			compatible = "qcom,shikra-mpss-pas";
+			reg = <0x0 0x06080000 0x0 0x100>;
+
+			interrupts-extended = <&intc GIC_SPI 307 IRQ_TYPE_EDGE_RISING 0>,
+					      <&modem_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+					      <&modem_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
+					      <&modem_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
+					      <&modem_smp2p_in 3 IRQ_TYPE_EDGE_RISING>,
+					      <&modem_smp2p_in 7 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "wdog",
+					  "fatal",
+					  "ready",
+					  "handover",
+					  "stop-ack",
+					  "shutdown-ack";
+
+			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>;
+			clock-names = "xo";
+
+			interconnects = <&mem_noc MASTER_AMPSS_M0 RPM_ALWAYS_TAG
+					 &mc_virt SLAVE_EBI_CH0 RPM_ALWAYS_TAG>;
+
+			power-domains = <&rpmpd RPMHPD_CX>;
+
+			memory-region = <&mpss_wlan_mem>;
+
+			qcom,smem-states = <&modem_smp2p_out 0>;
+			qcom,smem-state-names = "stop";
+
+			status = "disabled";
+
+			glink-edge {
+				interrupts = <GIC_SPI 68 IRQ_TYPE_EDGE_RISING 0>;
+				mboxes = <&apcs_glb 12>;
+				qcom,remote-pid = <1>;
+				label = "mpss";
+			};
+		};
+
+		remoteproc_cdsp: remoteproc@b300000 {
+			compatible = "qcom,shikra-cdsp-pas";
+			reg = <0x0 0x0b300000 0x0 0x100000>;
+
+			interrupts-extended = <&intc GIC_SPI 265 IRQ_TYPE_EDGE_RISING 0>,
+					      <&cdsp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+					      <&cdsp_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
+					      <&cdsp_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
+					      <&cdsp_smp2p_in 3 IRQ_TYPE_EDGE_RISING>,
+					      <&cdsp_smp2p_in 7 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "wdog",
+					  "fatal",
+					  "ready",
+					  "handover",
+					  "stop-ack",
+					  "shutdown-ack";
+
+			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>;
+			clock-names = "xo";
+
+			interconnects = <&mem_noc MASTER_AMPSS_M0 RPM_ALWAYS_TAG
+					 &mc_virt SLAVE_EBI_CH0 RPM_ALWAYS_TAG>;
+
+			power-domains = <&rpmpd RPMHPD_CX>;
+
+			memory-region = <&cdsp_mem>;
+
+			qcom,smem-states = <&cdsp_smp2p_out 0>;
+			qcom,smem-state-names = "stop";
+
+			status = "disabled";
+
+			glink-edge {
+				interrupts = <GIC_SPI 261 IRQ_TYPE_EDGE_RISING 0>;
+				mboxes = <&apcs_glb 4>;
+				qcom,remote-pid = <5>;
+				label = "cdsp";
+
+				fastrpc {
+					compatible = "qcom,fastrpc";
+					#address-cells = <1>;
+					#size-cells = <0>;
+					label = "cdsp";
+					qcom,glink-channels = "fastrpcglink-apps-dsp";
+
+					compute-cb@1 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <1>;
+						iommus = <&apps_smmu 0x0201 0x0000>;
+					};
+
+					compute-cb@2 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <2>;
+						iommus = <&apps_smmu 0x0202 0x0000>;
+					};
+
+					compute-cb@3 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <3>;
+						iommus = <&apps_smmu 0x0203 0x0000>;
+					};
+
+					compute-cb@4 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <4>;
+						iommus = <&apps_smmu 0x0204 0x0000>;
+					};
+
+					compute-cb@5 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <5>;
+						iommus = <&apps_smmu 0x0205 0x0000>;
+					};
+
+					compute-cb@6 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <6>;
+						iommus = <&apps_smmu 0x0206 0x0000>;
+					};
+
+					compute-cb@9 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <9>;
+						iommus = <&apps_smmu 0x0209 0x0000>;
+					};
+				};
+			};
+		};
+
+		remoteproc_lpaicp: remoteproc@b800000 {
+			compatible = "qcom,shikra-lpaicp-pas";
+			reg = <0x0 0x0b800000 0x0 0x200000>;
+
+			interrupts-extended = <&intc GIC_SPI 257 IRQ_TYPE_EDGE_RISING 0>,
+					      <&lmcu_smp2p_in 0 IRQ_TYPE_NONE>,
+					      <&lmcu_smp2p_in 1 IRQ_TYPE_NONE>,
+					      <&lmcu_smp2p_in 2 IRQ_TYPE_NONE>,
+					      <&lmcu_smp2p_in 3 IRQ_TYPE_NONE>;
+
+			interrupt-names = "wdog",
+					  "fatal",
+					  "ready",
+					  "handover",
+					  "stop-ack";
+
+			clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>;
+			clock-names = "xo";
+
+			memory-region = <&lmcu_mem &lmcu_dtb_mem>;
+
+			qcom,smem-states = <&lmcu_smp2p_out 0>;
+			qcom,smem-state-names = "stop";
+
+			status = "disabled";
+
+			glink-edge {
+				interrupts = <GIC_SPI 286 IRQ_TYPE_EDGE_RISING 0>;
+				mboxes = <&apcs_glb 9>;
+				qcom,remote-pid = <26>;
+				label = "lpaicp";
+			};
+		};
+
 		sram@c11e000 {
 			compatible = "qcom,shikra-imem", "mmio-sram";
 			reg = <0x0 0x0c11e000 0x0 0x1000>;

-- 
2.34.1


