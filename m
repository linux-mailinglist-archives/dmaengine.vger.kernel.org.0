Return-Path: <dmaengine+bounces-11941-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id H2YNEOZ2RWrIAgsAu9opvQ
	(envelope-from <dmaengine+bounces-11941-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 01 Jul 2026 22:21:58 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C62816F16AE
	for <lists+dmaengine@lfdr.de>; Wed, 01 Jul 2026 22:21:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=LereSESi;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=RXC0VBbD;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11941-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11941-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 58D97307D6DA
	for <lists+dmaengine@lfdr.de>; Wed,  1 Jul 2026 20:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881433BCD29;
	Wed,  1 Jul 2026 20:18:13 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0843B6C11
	for <dmaengine@vger.kernel.org>; Wed,  1 Jul 2026 20:18:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782937093; cv=none; b=sPwcF1hZERCiRZ8Ka+LACGjp2L73L7Yr0nrJOtHfrlauOseyKzX57hLKlSZJLfYURXUwF+I7Kd1f9n/1em7lmGxZcdR8c7EG6HfyNfiu2gKC6i+EUJ8BEVYK8uOmDhIkLoOXoWdnuUaAg+p4cJTNTOpKtgGWl+4/sBnD615cooY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782937093; c=relaxed/simple;
	bh=e+VbQpfDYnB7JL1Lhq0maA2ZtMLt156FOqYWsbF9Js4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PJtgI6ITOq+G1CEsHzHe9ztmHY6jwv0q+N1HTaeUmYyAs9mHxNufcc93yTwtsFeKAP3LR+z8QZQw9wbjm4Mtcv8Bzqr8gPmnoUdw1eohq0BYsOZK0dNb1dX8zp5eeq8NdEBXSCQqCy4G3tzR8tIVodKRSQfIxOPbEH38m67Aktw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LereSESi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RXC0VBbD; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661GmorN1730837
	for <dmaengine@vger.kernel.org>; Wed, 1 Jul 2026 20:18:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	X+Nfpts9UfwfrC/VeFUnTh6LInzlakfP8YWFjpqBzAk=; b=LereSESiC4G0zUwM
	Fkm9wU4JZoCLFKZmYDBzTHC4+Px+zGA/hVWCh6Do4Br3SzrfRYIf3NN5MpmHsX6W
	49l47Cig6Sq7fch9OjQAHLMehBQCveiQ9hqjSkYz/cl6/fypwUOLYkwiGraB2Z0v
	YdkoR2oXrqyGh1zJCOu/86C0Io/KkgFRJtNYlrpah0wu7+9rX23U6x01caaUE/mt
	yOXjSpifjglbc+IQIn46jioejS6xeg5Uca4baU1kYchE6NNMMIrR6rvO8PRYtP3V
	A5URS2+FFLgzWl5oyjqIfZ9xfpVxvb78lQTk3vZBGknxSz9eiGrQUXwa6kFr4vNY
	D1DU+g==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f510ajfpw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Wed, 01 Jul 2026 20:18:11 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-37fe90ee192so1242821a91.3
        for <dmaengine@vger.kernel.org>; Wed, 01 Jul 2026 13:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782937091; x=1783541891; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X+Nfpts9UfwfrC/VeFUnTh6LInzlakfP8YWFjpqBzAk=;
        b=RXC0VBbDoD5LXVi4hD9mvsRQuoRl9ZOsnV8JCYco74DIzM62pCtdumx/BAyxWuiTnR
         Dc/cCbn9qKNHdgIeR3G0eLarUt65DEOfQGLaZkMXC5Dzix2GBUrjLFuCerwUzdwRbGYs
         LJC63ZkAHvhn7H4Ud5FWol+y4sr/i68t3fr4fEB/eIx2JOZ7VMazdIZWpyx+rHcEWOvU
         dwIiQvC6+sRsmTAsXOBpk/tOYhFoo+68GKMXg0QeofC6NMmdsXVPqhopHSHzCuZCg3Vi
         VL/ZR1Upx2afpTZVgPHs3vDBzTcbRPG61udM6u+OZw5hbe2zK8LjB4wOSI899WYfFoce
         XDJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782937091; x=1783541891;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=X+Nfpts9UfwfrC/VeFUnTh6LInzlakfP8YWFjpqBzAk=;
        b=N5OiAqrAl1rvjeOktms7l+FcihWbCbiXlGGou/ESM9WFSPYviY7NUbMuM+x50+Uk61
         dT1Oj0oUwm6X7ZqbEpe5I28mlA44Pv9tybkue9AkJzL4TWRUph28Q/MMf0SJIN9mZ5vs
         QlTLVG6ybJ9ngwajcDlESl6M0ZwZBx1zL69moocZtylXJUB7vlu1PuotnIOhYGf+huVV
         Y/kozidrVTBFq1k5J0vD6LqtWtK590Kld+XvU8W0I8yeAjGKjgRY5lL9l7NOK0MHHWo8
         H8cIEOsYi6Ql6NT9h8wTKdX/nfSlD76pOoBOdMClZZ0uAnLJarocZv+8X/8FnzGm+vkA
         n52w==
X-Forwarded-Encrypted: i=1; AHgh+Rqe5nIwgCaR2i775kYCxSO+RxPdBxqIbHnHr/9Fu/CYJDyzN+dbCHTeAtOg0mLY6VM6TAGtXRH83fs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH99UMKVf4SUK6+VLjMCb8EOBDIIAM8hy/287qV4mU28tshkcv
	ZoX99ZOKNtmJbVokwrEKv+FvEyo9qnP1apr5SXDivgIeJXbrpJShzl64y3+8azAnZofLrRkpfA0
	uISYAAPmfN9EYc60J48tnaP35fxmvxoGg1DnNY7LiWP75MfODp1oCzkN77W+xM9pSiQ+9u5A=
X-Gm-Gg: AfdE7ckQ3l4ywYKi7crjgvT6CgL3+eG5rm/+dSdm3b4zK8auUIugAAwY9ms+4+olKii
	1MBmz4LpFoQLhRO519PoELSknuz4wIlhLFCYmgRDGWR9EijqwMatYOpcEYaWSz7EuUWm6642xZ2
	cAm9M6RknR2ue0FVh350Au3FjxjLwBN+RMkRV4iVLeKMtDQtiBIQBPXq1AtJ/t1Y4ntGjZmy8P3
	fiC3vNigecW9ow1kdzKHbgpa8aaGSf1oj0Nms65DhBUQDhuD7FoQdLncGF20YTsfcfCPTpK/z4X
	W5pQClGzXAcZDIEzh1Rzr/kWAvcBXP8MCEk/NDJyJqwKploGd4kzcC48WPMpcYGoeJm9jCxerOl
	0kAVOUGHrhKmsnct7jQsEJKrK8L9LJwI2UbW4H5sovzZz
X-Received: by 2002:a17:90b:3f8f:b0:37f:db06:2299 with SMTP id 98e67ed59e1d1-380aa1cb0f6mr2989492a91.21.1782937090763;
        Wed, 01 Jul 2026 13:18:10 -0700 (PDT)
X-Received: by 2002:a17:90b:3f8f:b0:37f:db06:2299 with SMTP id 98e67ed59e1d1-380aa1cb0f6mr2989460a91.21.1782937090306;
        Wed, 01 Jul 2026 13:18:10 -0700 (PDT)
Received: from hu-kuldsing-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0bc79231sm948685eec.31.2026.07.01.13.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 13:18:09 -0700 (PDT)
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Date: Thu, 02 Jul 2026 01:47:16 +0530
Subject: [PATCH v2 6/6] arm64: dts: qcom: shikra: Add ICE, TRNG and QCE
 nodes
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-b4-shikra_crypto_changse-v2-6-66173f2f28b3@qti.qualcomm.com>
References: <20260702-b4-shikra_crypto_changse-v2-0-66173f2f28b3@qti.qualcomm.com>
In-Reply-To: <20260702-b4-shikra_crypto_changse-v2-0-66173f2f28b3@qti.qualcomm.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Harshal Dev <harshal.dev@oss.qualcomm.com>,
        Vinod Koul <vkoul@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Andy Gross <agross@kernel.org>
Cc: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
X-Mailer: b4 0.15.2
X-Proofpoint-GUID: ntalTsWXlVoPZ4E7uPj8yU2cDUdIwpbr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDIxNyBTYWx0ZWRfX+nwnI70DANN2
 KvN8iN/+Kjrl8adI+TYBR1XJmxU/TT/dZO3Tmcf3gYdvigrt6kRkYOHgu34EwbKVGpWUyqyeUk8
 npAy/P71aOvXyE9fpuInTzEyhMvZYSz7SPwVm+mS6Yab2MjSm6s5EsG47oaILGpxv4Muw6Akz6Y
 Owfp+xr8ktAHF6cbzkg4w8ANGe7aYyPukzFBrmaNJWI/kGedkUElypaC7z/klAMhl6zeN+L8S70
 DnePmZI6nwSshWiIrDGbf6Dvo3nrA0bDoNnpHoLap9HFj7hnMmvfyuyRfRWtn3xG9MNB8z0FzQy
 CDfozej+NSUsdA4CyE4U6uhT7m72mhrMHy33/TqPVKxSrtzs7Y9qYIYA8eo9/LBG85O6GVptUkz
 cUZ4DVwgZL5Gp5xxPwRazERUSGrSCLed2hDdI9vatJ1nyR6Xo7R6/JR6eZewxldCNBRCkKru5Fs
 0o+5vsZv8OpOTw2VnOQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDIxNyBTYWx0ZWRfXwpy1th6avEE4
 CNQTfQNgSCeRu6DE3TK6G+mC1qvit0lOUKBbletFz/ifKAvtSL4ogdDBUddUH1RzUnHH6DvwLJF
 LR3SnBRqd0uS86GZ6cTE/O5SwmWVVuY=
X-Authority-Analysis: v=2.4 cv=JpXBas4C c=1 sm=1 tr=0 ts=6a457603 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=UqF9ul3sJ95V4vUiljcA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: ntalTsWXlVoPZ4E7uPj8yU2cDUdIwpbr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010217
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11941-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qti.qualcomm.com:mid,oss.qualcomm.com:dkim,oss.qualcomm.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,qualcomm.com:dkim,qualcomm.com:email];
	FORGED_SENDER(0.00)[kuldeep.singh@oss.qualcomm.com,dmaengine@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_RECIPIENTS(0.00)[m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:harshal.dev@oss.qualcomm.com,m:vkoul@kernel.org,m:brgl@kernel.org,m:konradybcio@kernel.org,m:Frank.Li@kernel.org,m:agross@kernel.org,m:kuldeep.singh@oss.qualcomm.com,m:krzysztof.kozlowski@oss.qualcomm.com,m:linux-arm-msm@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dmaengine@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuldeep.singh@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C62816F16AE

Add device tree nodes describing the crypto hardware blocks present
on the Qualcomm Shikra platform:

- BAM DMA controller used by the Qualcomm crypto engine
- QCE (crypto) engine with DMA support
- TRNG hardware random number generator
- Inline crypto engine (ICE)

Also connect the SDHC controller to ICE via "qcom,ice" property to
support inline encryption.

On Shikra, different BAM pipe pairs (for example 0x84/0x94 and
0x86/0x96) may still resolve to the same resulting SID due SMMU-side
optimization. They are still distinct pipe pairs and therefore require
separate DT IOMMU entries.

Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra.dtsi | 52 ++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index 4e5bc9e17c8e..a95e2140416c 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -482,6 +482,41 @@ config_noc: interconnect@1900000 {
 			#interconnect-cells = <2>;
 		};
 
+		cryptobam: dma-controller@1b04000 {
+			compatible = "qcom,bam-v1.7.4", "qcom,bam-v1.7.0";
+			reg = <0x0 0x01b04000 0x0 0x24000>;
+			interrupts = <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH 0>;
+			#dma-cells = <1>;
+			iommus = <&apps_smmu 0x84 0x0011>,
+				 <&apps_smmu 0x86 0x0011>,
+				 <&apps_smmu 0x92 0x0>,
+				 <&apps_smmu 0x94 0x0011>,
+				 <&apps_smmu 0x96 0x0011>,
+				 <&apps_smmu 0x98 0x0001>,
+				 <&apps_smmu 0x9f 0x0>;
+			qcom,ee = <0>;
+			qcom,controlled-remotely;
+			num-channels = <16>;
+			qcom,num-ees = <4>;
+		};
+
+		crypto: crypto@1b3a000 {
+			compatible = "qcom,shikra-qce", "qcom,sm8150-qce", "qcom,qce";
+			reg = <0x0 0x01b3a000 0x0 0x6000>;
+			dmas = <&cryptobam 4>, <&cryptobam 5>;
+			dma-names = "rx", "tx";
+			iommus = <&apps_smmu 0x84 0x0011>,
+				 <&apps_smmu 0x86 0x0011>,
+				 <&apps_smmu 0x92 0x0>,
+				 <&apps_smmu 0x94 0x0011>,
+				 <&apps_smmu 0x96 0x0011>,
+				 <&apps_smmu 0x98 0x0001>,
+				 <&apps_smmu 0x9f 0x0>;
+			interconnects = <&system_noc MASTER_CRYPTO_CORE0 0
+					 &mc_virt SLAVE_EBI_CH0 0>;
+			interconnect-names = "memory";
+		};
+
 		qfprom: efuse@1b44000 {
 			compatible = "qcom,shikra-qfprom", "qcom,qfprom";
 			reg = <0x0 0x01b44000 0x0 0x3000>;
@@ -521,6 +556,11 @@ spmi_bus: spmi@1c40000 {
 			qcom,ee = <0>;
 		};
 
+		rng: rng@4454000 {
+			compatible = "qcom,shikra-trng", "qcom,trng";
+			reg = <0x0 0x04454000 0x0 0x1000>;
+		};
+
 		rpm_msg_ram: sram@45f0000 {
 			compatible = "qcom,rpm-msg-ram", "mmio-sram";
 			reg = <0x0 0x045f0000 0x0 0x7000>;
@@ -582,6 +622,7 @@ &mc_virt SLAVE_EBI_CH0 RPM_ALWAYS_TAG>,
 			mmc-hs400-enhanced-strobe;
 
 			resets = <&gcc GCC_SDCC1_BCR>;
+			qcom,ice = <&sdhc_ice>;
 
 			status = "disabled";
 
@@ -604,6 +645,17 @@ opp-384000000 {
 			};
 		};
 
+		sdhc_ice: crypto@4748000 {
+			compatible = "qcom,shikra-inline-crypto-engine",
+				     "qcom,inline-crypto-engine";
+			reg = <0x0 0x04748000 0x0 0x18000>;
+			clocks = <&gcc GCC_SDCC1_ICE_CORE_CLK>,
+				 <&gcc GCC_SDCC1_AHB_CLK>;
+			clock-names = "core",
+				      "iface";
+			power-domains = <&rpmpd RPMHPD_CX>;
+		};
+
 		qupv3_0: geniqup@4ac0000 {
 			compatible = "qcom,geni-se-qup";
 			reg = <0x0 0x04ac0000 0x0 0x2000>;

-- 
2.34.1


