Return-Path: <dmaengine+bounces-11956-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CgUuMlM5Rmp/MAsAu9opvQ
	(envelope-from <dmaengine+bounces-11956-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 12:11:31 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 758136F5AE3
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 12:11:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=jpRsmq4t;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=gbQgrRFI;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11956-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-11956-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7F668307A762
	for <lists+dmaengine@lfdr.de>; Thu,  2 Jul 2026 10:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EEAD4E379F;
	Thu,  2 Jul 2026 09:51:57 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7F04E3796
	for <dmaengine@vger.kernel.org>; Thu,  2 Jul 2026 09:51:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782985917; cv=none; b=BGTOn1R0YdSdRYJXYYCwRk6q6LHSsyoo4ebwkdt+6e+H1YdXqJw9Tvo0sor+Bnpnbb3f5qgZ1pJmVruChcJ9gSSAcf/3dx9PxhEVW/ba48AjEM9XnxhHV8SpcU1z/dEBW6UeLFo77oOc8qrnlgGGqkUTw1AhPvsKcfJQOYBFhuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782985917; c=relaxed/simple;
	bh=zrxJFa4VPwsYcw8XwQGDYVBpixFGlco1FfRkuJ8EAgA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EsEveJB12aGJhtiBmokxGiU1rKpcQ7DlWoxOEvDYf7ruLC7wwguYcTOVu9OmLGX0M7e5ktgcK8osd04IhaEX3YLEeBbS+ARbedfJrnd7bP9FQAx+up6KIlYg8KaUDq1tlNoAZbNe1xG/RtY+g94CS/3w3ciN48rwhO/0Gklog3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jpRsmq4t; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gbQgrRFI; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6628cWMD3050485
	for <dmaengine@vger.kernel.org>; Thu, 2 Jul 2026 09:51:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	755Kmru2NNLSqWs38B8De3HgJThqhmh0GCRqXzxW0lM=; b=jpRsmq4t/cp/kxQK
	HLI/vN1cBYfP5j7CzPNM4KXL5hC7zTh4lIKd+OSTRA8WxYrnLcsGCTG/BiUdyhG8
	Fhgyb43+jZn7VggmFRfBZbsbE4yrW74emmSa0Y/uh9Tpi3Leg9/+m2LJsx6wiQag
	ycynclZHqPY3U7qzJBOVmFUuewvHGeOlh86UgbQ1RF4oDQ+zAbu1EsUeVJfwHQHz
	fNRTP2F+GVliIZxw+CLGAuLK9zcehya5UuDrZT7RvAgR1SyFI2+jBueuKt5PMc5g
	8QgWqIakNWbgr+DgNgsCvYG2rOEyY+pYK1dZfWP5Ks4ELUyYiO5/xSBnQZIkkDuE
	lvejkg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f56gpuduk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Thu, 02 Jul 2026 09:51:55 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-845ea8fd3easo3467009b3a.0
        for <dmaengine@vger.kernel.org>; Thu, 02 Jul 2026 02:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782985914; x=1783590714; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=755Kmru2NNLSqWs38B8De3HgJThqhmh0GCRqXzxW0lM=;
        b=gbQgrRFI3rWC15tX3zo9DLL8qmPPP+UwuvOstRl4V1sVgvXq2P+EvzLGYhfdaryqeQ
         eRA/DwJOropQYS3kSf+T1Y3gp132ztfbBb+5YpxAqSIBW7PJ2okYFom5AL8kZrTHMCC1
         nNfWSDSxEXzVGYJ+nsvrkwPekGoeKzj/XF/vOttgpsb1K5K+q9U5L1g+TmlNl7EMR3q2
         I64lu8tbpR3Uki7d6i69/t+uRTOvi4TN0uDIDJdwyn2k7ilOfaoshKcM2Qkk7WRZpbI3
         IEShsojwl9V+UldIZ+eivtMSNAP2QxqhBQNkj8X4T9ElIPFpfYTSHWQMRVlnzrmNHmqb
         IXmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782985914; x=1783590714;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=755Kmru2NNLSqWs38B8De3HgJThqhmh0GCRqXzxW0lM=;
        b=bp3hqtA3DLwZvJgY2rDZ1JVbmIJNaCTmp6BYmXmvs7v8idaeElhULVnNeBwHvn20vB
         Wn9oVFhXa1glVhlE5pl/AxH3HhU91bkDxWu9yrVz7LTfLCX6alXcxPNGH5PPCAZ5UdJU
         IZRQb5amw0VB81YBG5Dn1fcKwO0dWeN9hUDrnAP5QkoaGfcy9r2x+xCahdr6YXV2JmwZ
         hgEUTepTQ2FjGUrgzaatWsoX36B4So8uzG62iwA82HIjExCcBTV8Rw8ZOTgcnDxfKQ68
         MtHWwncjFtzW2Xh6l/5UlbpfrKXl8wK0nyFxjrALd+DQNEXrUsn3QNnNGi7z5gWR93NT
         XI3g==
X-Forwarded-Encrypted: i=1; AFNElJ+UbDzkEp9oL7eoDt49DcT4+BiayiB0MNNi33huiaMj0GTZMuNJuwAiGO1nEwJ92tcQJ2VEgMihR/w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/R4HPdiJgPdL1YQhipTV9BoMS1/XWyPDZ5xlwTHWEqIYsgVxk
	yCtgoi1gfZ1jlZYYkZ4bltJBl58Leu1u7QUpg3BlsEbg89NuTT298mp4dyoU5ggZ8Ve9hgIhOuN
	suS/LPny847uuR2bTyegjDPUcoXNKG0OLteUzgb8/Wu9htT3jqaihzDokufuypEk=
X-Gm-Gg: AfdE7cnDqcSQCowkBn51kuEooZP+pT4i4D0I0/pUphLnpZT0TLUYGekL85/gmJCvhDq
	r8pg9ULvUvfr/4yyvAUltQzUkvTxNr6H0xURnVjjZcLfabIj9uSRVCgO4gVUbGdLiGyuAznewLl
	Sdwoe8t49xlmCw2jXqaq1m1M5YpF/M/LSc6scjS/tJ09h0Xpg2ppbtieQSsxAEVUgzapnNyEN8f
	lNzGNN7Qmd4GeQWA19ABuBO4bzqaSae01EUc/vFhrsPFS0GEI565FygYlPl+zS0xTr6v/WT7NKq
	IdM4HbStwJgMYs5AEnkvx+Du0JrJbgxs+pl+/zJMd5i8Q5guKn3xtKkeXGmTUWZtHPo+OPj9+mq
	/yv9+YgHi/zbbzIXN/duaJVTO0Q==
X-Received: by 2002:a05:6a00:908c:b0:847:752e:3631 with SMTP id d2e1a72fcca58-847c5168793mr4391060b3a.46.1782985914509;
        Thu, 02 Jul 2026 02:51:54 -0700 (PDT)
X-Received: by 2002:a05:6a00:908c:b0:847:752e:3631 with SMTP id d2e1a72fcca58-847c5168793mr4391012b3a.46.1782985913936;
        Thu, 02 Jul 2026 02:51:53 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847cb78ee2esm1110051b3a.24.2026.07.02.02.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 02:51:53 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Thu, 02 Jul 2026 15:20:53 +0530
Subject: [PATCH v5 11/11] arm64: dts: qcom: shikra: Add
 gpio-reserved-ranges to tlmm
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-shikra-dt-m1-v5-11-f911ac92720c@oss.qualcomm.com>
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
        Anurag Pateriya <apateriy@qti.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782985846; l=1832;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=zrxJFa4VPwsYcw8XwQGDYVBpixFGlco1FfRkuJ8EAgA=;
 b=I5ZZiEPU5ocYeFh6TIaMz/FgAsPVoIRMynonz30ynq7Dr+IIy9F9bKY74X0pIfNiKV7EWueOq
 aJGqc0zwFjNATrCR14kATNFy8eVmtsN+hrbza266iZXRgLbeHHwdbQc
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDEwMSBTYWx0ZWRfX1EO9QGPApCWP
 Pv39oodIh3GfQSqeW7rYlkA9MMDU3o7NCTQYyMQZQY2wypKTumHZxj8sKdIj1cDWcdixXPiWQZh
 i+VRhPXFlfFkQ7IRO+jU8afmUdc85K4=
X-Proofpoint-GUID: Npew_36D0JURTXY8Ud6wClx19DtdE3Qv
X-Proofpoint-ORIG-GUID: Npew_36D0JURTXY8Ud6wClx19DtdE3Qv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDEwMSBTYWx0ZWRfX7SMkMlHl/yq8
 pm9sTZb63tgtlOoYaeCrMkkXVPA1I1PAlStulS0CgNzuwW/1EdIqWeChaUE6x4I+z2n+mY8JXv4
 i2n9TfhCtjpnckp5A24PYwVJcYtxQMhQ3qjvtay4XxKB/4bhg1xnJjVStihGG83gD7fz5gHbHmc
 KfC9700EnCRyti67YIM12Dw+4bGoH376AFhQBj6oCE6OzQs19CZa+BLp20BywtOgq42uGl/R+X/
 8NEdkybCusFepxsEPqB6BWJ/KQjp5uS9aOF2H6ZpGTodETmmn/nNFtia7jCaYae/8bOrZAtZEzT
 p43CceG3nn37xT8XJEOnzOXsEOCFEUepiGsJaozWnj3d7t9LAjg4Aoy+2iqJ0ZLdcaxjB8mS+oz
 aKueQ4gx1G6vxk1UBaud2yQ+hxsRKIYVb25BPa/PR0v1xeYcBN9ibLvFc+NPvwMmZzyu2FC/nqS
 JWeJ5zFJzEI9xiTE2qg==
X-Authority-Analysis: v=2.4 cv=K9oS2SWI c=1 sm=1 tr=0 ts=6a4634bb cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=wm8cDCIBuLkz8hnEg_gA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 adultscore=0 impostorscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020101
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11956-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime];
	FORGED_SENDER(0.00)[komal.bajaj@oss.qualcomm.com,dmaengine@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:krzk@kernel.org,m:djakov@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:linux-arm-msm@vger.kernel.org,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pm@vger.kernel.org,m:komal.bajaj@oss.qualcomm.com,m:apateriy@qti.qualcomm.com,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[komal.bajaj@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 758136F5AE3

Add gpio-reserved-ranges property to the tlmm node for all three
Shikra EVK variants (CQM, CQS, IQS) to mark GPIOs used by the
SoC internally and not available for general use.

Signed-off-by: Anurag Pateriya <apateriy@qti.qualcomm.com>
Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts | 4 ++++
 arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts | 4 ++++
 arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts | 4 ++++
 3 files changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
index c9409ab0a3f1..269e11bd44f6 100644
--- a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
+++ b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
@@ -66,6 +66,10 @@ &sdhc_1 {
 	status = "okay";
 };
 
+&tlmm {
+	gpio-reserved-ranges = <6 4>, <14 4>, <30 2>, <115 2>, <138 1>, <155 11>;
+};
+
 &uart8 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts b/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
index 58fed6cc5925..ccf8f856e994 100644
--- a/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
+++ b/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
@@ -66,6 +66,10 @@ &sdhc_1 {
 	status = "okay";
 };
 
+&tlmm {
+	gpio-reserved-ranges = <6 4>, <14 4>, <30 2>, <115 2>, <138 1>, <155 11>;
+};
+
 &uart8 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts b/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
index 864c0d2636e6..743979b5ed5e 100644
--- a/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
+++ b/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
@@ -74,6 +74,10 @@ &sdhc_1 {
 	status = "okay";
 };
 
+&tlmm {
+	gpio-reserved-ranges = <6 4>, <14 4>, <30 2>, <115 2>, <138 1>, <155 11>;
+};
+
 &uart8 {
 	status = "okay";
 };

-- 
2.34.1


