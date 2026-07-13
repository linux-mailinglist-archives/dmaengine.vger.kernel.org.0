Return-Path: <dmaengine+bounces-12435-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OwDhOKs+VWrclwAAu9opvQ
	(envelope-from <dmaengine+bounces-12435-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 21:38:19 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6A674EC2F
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 21:38:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=MFsTExGo;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=bK+Z7fuY;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12435-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12435-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 824F4300D4F1
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 19:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE891DED5B;
	Mon, 13 Jul 2026 19:38:11 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9892357CF3
	for <dmaengine@vger.kernel.org>; Mon, 13 Jul 2026 19:38:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783971491; cv=none; b=q/siLsHpcBmtbUZ9QhVs9mU3xd0ulvNtjXivSUWaYVPQ0l+OD4lqpK/Br4e+Gb9aSL46QQqXd1Im+jI9bf6Jn0bf4JqouhW7Fxm6ssx6BBSXGiduX1Y5VCy1RCeHyEAyjdZYMnZsbAnt7zqwJq1YaR/jBd1Spsr99RNRLwPc2Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783971491; c=relaxed/simple;
	bh=+7jXao5QdK2z2eXaysNpqQ6Z74zwWUjbRQglo8sfutw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E4NR3iE/Cz//sb6SI5OVW5KsXeHUqGZWTGgcAS9/EaXiT2aEBW9Y9C8ynjEmO2qyojvPDB0boEEdikStju9IlZi6jksTlhARSADI4DgX+R0jyJk8rqa2mxytNKzwZrVKWUVPBOujQKvS0QjFsHiUwtAl37UvtgxpYOIFiIJv4LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MFsTExGo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bK+Z7fuY; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DJ9Qc62247857
	for <dmaengine@vger.kernel.org>; Mon, 13 Jul 2026 19:38:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SKwU9QhOKN6x8v4UcbaTA/MBFjwqaAwujUYoMVqaSrI=; b=MFsTExGo+Ip+A+7h
	vjqGlAd4i4c0Z6su4OzGsKOVtxH7w0ydAQd7NYw9KiS/8EXee26aj90zpqj+1Z76
	xUr64/sfZ9uCWx3jH2t48fdF2z8vhuaSIk9ma2tLvW+oibddvGbJAZ4p18o+I1KD
	Ixib7eBvXTcVYlBVREQjuJ22U7xPz+WACNw/DDX9LjT+Gf2RBmTtgcFkBAv+ysSG
	JNMWiPWEOpfbtVnGRu2mf3/kcdh3FNOiOzJyuOTGdbYbUxr5y8gL+37ekTqDdLa6
	RdLjh8KFsNXxnrTOGff5cDmYXpG/Gn66UoY/sj40M+iY2Qm9HmljM1ckqUYw69e4
	vBSC+A==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcwk3jc7g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 13 Jul 2026 19:38:08 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38827cee19eso3519544a91.3
        for <dmaengine@vger.kernel.org>; Mon, 13 Jul 2026 12:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783971488; x=1784576288; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SKwU9QhOKN6x8v4UcbaTA/MBFjwqaAwujUYoMVqaSrI=;
        b=bK+Z7fuYxA9d1mQ849KmJjkGnvFW1zZwGQgAxV4LZfYZlifU0RKyk4MEIQJLp5crNr
         914/7CKHWWJUFieecAgPo2sfgxifVGq7OXpaWNyp9Ph8hhH5Li3ZF8Cd0gQGKmUpYH0L
         WxDy0UjKX17uA8m3SurZ+g3a6NnBhKblaf09tT1OdchSzxbwqxvUJgBufH8LB86fSLtW
         VdXPrstFcuDDSmLiYFkMB/HfNZ5TKJBaUCPp8qnAOM26iskXN/RkcWFaa8uFY7lw4jM7
         yu3Z6vO5SYk0ktIHNkfUM63f2sTzvE+z5bdm4rJVJXiSTVpDfUw1QMQVAIY/wGz1txdg
         hyvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783971488; x=1784576288;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SKwU9QhOKN6x8v4UcbaTA/MBFjwqaAwujUYoMVqaSrI=;
        b=U8MIByCsyo2iHQ3sxY2DGQqDWB4zTh0vKCbfbUVNL7LsRVQoxxQDYnQpd8PlJ6G+s3
         7mGmv+Giw/hrt3BuGOFdwVG0Gk80yO2ieFB43B21xJ4Gt/q39zWTuBgLT0vjXzAT8r6M
         EVcy0bxSybYMPTPcmXQSUZxv1o0IX3h9kKEk97uTjHtV+4kfkUYlXzMQmT9LT+gezbVn
         p9O0/QnTcrn3EPL8CQpN9rzD5Yuykli8RvecdEEA6MqHy/5QOBtgU1PtY4BuK4CQ+6eD
         1V5HVL1/r6dbr0zsLA9cOVGYsfTFj4k5lKkbApmYPCK4ADU9CXxCm17FRTSudxbCfknX
         LWqg==
X-Forwarded-Encrypted: i=1; AHgh+Rr+RXUKKXEyFsElIki2cC7dPcPbiMDKY1urapT7rVE9rH5VPgV4ry2W8kV7sF58hxdkZuvdiMjkT4o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIKUjN9cvCBP3WHkY8dVwUZUi0SXsF4CEleJs/+K06anlWnQmq
	vKI2ZXrodO22LpWq7mhPxPUCahGZ0nhfPV90zVFaO9SECfHHHf836ecrwrtiAdGUmwwqi4g6/0j
	IZlIOsZlZYLQUbZQBqvyTzB23xlT7st2wDnKlwupMEbB5/+V3gNgJtGjIMAE9udw=
X-Gm-Gg: AfdE7ck0M/+hmFZBWRaSUzrZgKqaRK9uhMFZgybkCefHE/U9nLaekNrtxt83C3J8RsQ
	8TxHH36PsxlSlNkhgGcT4NuK+9oTG1bybGfFdtdpbI+VI7lfXt7IZlCGcZgYYUjUrE7rYtLcnUC
	wbJxR22ld1u2EwAaXnGfcF9wyh/Ec9kYjqArSDjpFBg/p22xmoPEsQxyTVjvQvazM+7RH06i8kd
	ALFpFURhuUsci9aIDUECXOtTAQTgvbfZcVf6c0LMP/l/OY8D5N9gsIOXVDFqIEvgoDwwevF6oLK
	ir9Dt8NcvzJ+45+j4xoprSIqRiC0Bh6SfO+DTH8bgmyh9RAsB/MEi9Pvenk7l7vS+wsDWT57rHZ
	bEPlC9x7N/rSuTqfzTudzllwmgg==
X-Received: by 2002:a17:90b:5384:b0:389:8f6c:4d58 with SMTP id 98e67ed59e1d1-38dc777c40cmr10073049a91.34.1783971488408;
        Mon, 13 Jul 2026 12:38:08 -0700 (PDT)
X-Received: by 2002:a17:90b:5384:b0:389:8f6c:4d58 with SMTP id 98e67ed59e1d1-38dc777c40cmr10073028a91.34.1783971487975;
        Mon, 13 Jul 2026 12:38:07 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-313f3ea883asm207540eec.29.2026.07.13.12.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 12:38:07 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 01:06:59 +0530
Subject: [PATCH v6 10/11] arm64: dts: qcom: shikra: Enable WiFi/BT on SoMs
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-shikra-dt-m1-v6-10-bee265d3499b@oss.qualcomm.com>
References: <20260714-shikra-dt-m1-v6-0-bee265d3499b@oss.qualcomm.com>
In-Reply-To: <20260714-shikra-dt-m1-v6-0-bee265d3499b@oss.qualcomm.com>
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
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783971418; l=4938;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=+7jXao5QdK2z2eXaysNpqQ6Z74zwWUjbRQglo8sfutw=;
 b=U4p1S42eMk4DYtvOyUp1vR7XP0JO7iQHpuCYY6lILIQaElTzxjT27Io2ZhUhpXcDnbzPTtTZS
 uMXUJbntRXPAuogNgvUXZV2Hfx+RJh/AaAIJ4YTlBo3I38CyB7Lb9pA
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-ORIG-GUID: gydy3VGXMMf4v0RB6Lg7FXrjJqtEaJKd
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDIwMyBTYWx0ZWRfXyjOEl5sTM/12
 hUSAmkb+m31utXCzTM8KyF0DYDqGskjbEiAwcnni/jsph4P8NAQx9Thu2lejLVu4SCdnQK2K9hd
 KetofEra7LCWQ9R8VPdsC+Tl6pS3hYg=
X-Authority-Analysis: v=2.4 cv=e6c2j6p/ c=1 sm=1 tr=0 ts=6a553ea1 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=4qNR6o1dbhOseOkXa0AA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDIwMyBTYWx0ZWRfX28I7nN/EsG11
 VDzKSfUIiaPPYBjg95JtEqwZFGvPAfhYBbuweqXOpwnYwms+olr5oTHN/5FTjWmt9GD+zTMghWQ
 DNHZMRIXUgVMO0PNfqt9qzljx2r5B2Rr1zYI83prpafSr2S0BJ1Z6GO8iTW5XQ0kSUzv0HlLT0E
 f0ZFV7cft3qOABh3z2oFGU79WFmTbwghCyhphG7UZzDb8odToFj1oE4+rb4OO73AlQUEhmlRGk3
 IrrKOxh+j3DqwXEdAD4N1P4p2XU1OHhg9n+riEi2n+hjxoFEP8s8TAB6/OIqBECNhV3OE9y85bG
 ArNrJ1j1U3xd0Azr+uANHFtL06mBl8zj/Bu0HA1MLpJCc3f33xXWPkaslBiIl0A5TMWLSC3hwHe
 5AIT4JF3eR9vtHD4OQ9sRmn/m1eck1ASJvSwMS7v0C7J5wr3p/h60lWIY9IHxlEFRkDvMW3TiME
 vSbeXcn7QmINcWgCSLw==
X-Proofpoint-GUID: gydy3VGXMMf4v0RB6Lg7FXrjJqtEaJKd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 phishscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130203
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12435-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:krzk@kernel.org,m:djakov@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:linux-arm-msm@vger.kernel.org,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pm@vger.kernel.org,m:komal.bajaj@oss.qualcomm.com,m:yepuri.siddu@oss.qualcomm.com,m:miaoqing.pan@oss.qualcomm.com,m:dmitry.baryshkov@oss.qualcomm.com,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[komal.bajaj@oss.qualcomm.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:email,qualcomm.com:dkim];
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
X-Rspamd-Queue-Id: 9C6A674EC2F

Shikra SoM cards include WCN3988 WiFi/Bluetooth chip, with supplies
provided by on-card PMICs. Enable both interfaces and provide the
required supply and calibration data.

Co-developed-by: Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>
Signed-off-by: Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>
Co-developed-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra-cqm-som.dtsi | 74 +++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/shikra-iqs-som.dtsi | 82 ++++++++++++++++++++++++++++
 2 files changed, 156 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra-cqm-som.dtsi b/arch/arm64/boot/dts/qcom/shikra-cqm-som.dtsi
index dc3861489f64..8e30d451ab41 100644
--- a/arch/arm64/boot/dts/qcom/shikra-cqm-som.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra-cqm-som.dtsi
@@ -11,6 +11,10 @@
 #include "pm8005.dtsi"
 
 / {
+	aliases {
+		serial1 = &uart8;
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys";
 		label = "gpio-keys";
@@ -27,6 +31,42 @@ key-volume-up {
 			linux,can-disable;
 		};
 	};
+
+	wcn3988-pmu {
+		compatible = "qcom,wcn3988-pmu";
+
+		pinctrl-0 = <&sw_ctrl_default>;
+		pinctrl-names = "default";
+
+		swctrl-gpios = <&tlmm 88 GPIO_ACTIVE_HIGH>;
+
+		vddio-supply = <&pm4125_l7>;
+		vddxo-supply = <&pm4125_l13>;
+		vddrf-supply = <&pm4125_l10>;
+		vddch0-supply = <&pm4125_l22>;
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
 
 &pm4125_gpios {
@@ -154,3 +194,37 @@ pm4125_l22: l22 {
 		};
 	};
 };
+
+&tlmm {
+	sw_ctrl_default: sw-ctrl-default-state {
+	pins = "gpio88";
+	function = "gpio";
+	bias-pull-down;
+	};
+};
+
+&uart8 {
+	status = "okay";
+
+	bluetooth {
+		compatible = "qcom,wcn3988-bt";
+		max-speed = <3200000>;
+
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
+
+	qcom,calibration-variant = "Shikra_EVK";
+	firmware-name = "shikra";
+
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/qcom/shikra-iqs-som.dtsi b/arch/arm64/boot/dts/qcom/shikra-iqs-som.dtsi
index 73945bf42112..62e37409ac8f 100644
--- a/arch/arm64/boot/dts/qcom/shikra-iqs-som.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra-iqs-som.dtsi
@@ -10,6 +10,10 @@
 #include "pm8150.dtsi"
 
 / {
+	aliases {
+		serial1 = &uart8;
+	};
+
 	gpio-key {
 		compatible = "gpio-keys";
 		label = "gpio-keys";
@@ -26,6 +30,50 @@ key-volume-up {
 			linux,can-disable;
 		};
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
+		swctrl-gpios = <&tlmm 88 GPIO_ACTIVE_HIGH>;
+
+		vddio-supply = <&pm8150_s4>;
+		vddxo-supply = <&pm8150_l12>;
+		vddrf-supply = <&pm8150_l8>;
+		vddch0-supply = <&vreg_wcn_3p3>;
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
 
 &pm8150_gpios {
@@ -168,3 +216,37 @@ pm8150_l18: l18 {
 		};
 	};
 };
+
+&tlmm {
+	sw_ctrl_default: sw-ctrl-default-state {
+	pins = "gpio88";
+	function = "gpio";
+	bias-pull-down;
+	};
+};
+
+&uart8 {
+	status = "okay";
+
+	bluetooth {
+		compatible = "qcom,wcn3988-bt";
+		max-speed = <3200000>;
+
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
+
+	qcom,calibration-variant = "Shikra_EVK";
+	firmware-name = "shikra";
+
+	status = "okay";
+};

-- 
2.34.1


