Return-Path: <dmaengine+bounces-12426-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8I4wE3k+VWrBlwAAu9opvQ
	(envelope-from <dmaengine+bounces-12426-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 21:37:29 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EB19374EBE9
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 21:37:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b="EJSZ1r/A";
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=jlWbMlrA;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12426-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-12426-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 90B75301D4CA
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 19:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B14B355F49;
	Mon, 13 Jul 2026 19:37:17 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EC235677D
	for <dmaengine@vger.kernel.org>; Mon, 13 Jul 2026 19:37:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783971437; cv=none; b=F0ye5rBxv7fXn33iIA+5IX42P4MfG2u2++RAi1VGwVm4CxaVCP1TQs9gKSS35y8G67+Q6YM+qUHncT9cKGJbaWes/E++9nNDy/O/XhgdCVgnFcuZf7LfgTT10Ox3AvHae+OMCFExQ/PLWUIk5KyhvZ5Vh0OXEPOLWrypuXTzMhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783971437; c=relaxed/simple;
	bh=7PXb6tONCWiJcT15/yOyr3WnjDDS6peuFjileV+wB2I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fJe17bzaORvnQjHGRqSuBOT8VPhgAchHjZdFBgTPvoBpXbDGZOxDC7JySnTZROj/eADEJc/hvzCGENWbq95nCsVZJh9FZPdBVSPigRnAidZQ9HDoVmXkZlc3vNQPMDHlTmu3rl9U0ImRL/9/4FLEhUgkvHQeF1jdzBFXKVNIqbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EJSZ1r/A; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jlWbMlrA; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DJ9T7x2409687
	for <dmaengine@vger.kernel.org>; Mon, 13 Jul 2026 19:37:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XvecEd/wRZ6RX60LThPvAmUEWLJBuucyCsoY96VS+rI=; b=EJSZ1r/AesPK4O8p
	VJY96MT8i2e/b0Ym2cjWZM4+j5esJ/P/CqoJ/wbDW6tyEKlFJh4xJgVjvrqvrV2m
	rC0F7jRwjF2bxA8CZ/W2H1psiPThlIoSN5X6/pk5//behP4/w0yUQYihTRPFx8tY
	huGnJAScCfw+ck58tuDlPjbxbKrOconGK9tgAy8RxgINKywHAhpSwcNhsmKhQEOd
	i7b13SNPCymgdQL5E4oIME7NxGj2Gj47oy+GlwD1oq0pYIq0rtHP89VW1AZyFQGT
	McZLOFzjkyYNsNBHUdwfvbu6zuDN92fpdkmHbp6RlPrABn2G2N8WkiS5lPzHAR3E
	ohTAGg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcuj02wqu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 13 Jul 2026 19:37:14 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38dc8d877eeso3283025a91.1
        for <dmaengine@vger.kernel.org>; Mon, 13 Jul 2026 12:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783971434; x=1784576234; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XvecEd/wRZ6RX60LThPvAmUEWLJBuucyCsoY96VS+rI=;
        b=jlWbMlrA0Akqa5L3P6jp64op++9af5kRcMwZarXgopa01ujfVI/j3G3ljI7z0vGm36
         epccUdWq1J/2O8eLYGZiuwOJgoKpeNWArSjNwarhFfmetpLQCJuXSILgrOetW1l/RMQd
         vhvP8BX5T//qBoifa7X3UPKV99tb8+bsLPKkZwzAep0UMU10eJgemmA7WAx7sQnbT1q4
         NQftk7x9gdDfcPb4O3sppqkrnJF7NA+KRrDAvn7VJmbZC43hvOrleyHwcBP8OIxtvjLu
         lPpsUxjcRgOwEwHJ0YdApZWKARhR8OSYE6JpAhhAVppvGHriWWa3oc4zUXB9fwya7PJn
         1sbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783971434; x=1784576234;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XvecEd/wRZ6RX60LThPvAmUEWLJBuucyCsoY96VS+rI=;
        b=pfvtfZfPvUG6YIiZ1BAAZ9LePDB8jKX5ELf8Cq2PFuNdLuSuTQFoVMSHUSe9yLRBv9
         F69et0rWQa5/uZUeDdcc3YZq7P5jep1ke3COIu9CGlhpVKjxmR+t4yKhiii06R/48LzA
         WHAqLm52GLsPS2DhkGhcf0OmUdbYqNTmoOtHTNCY/RDoLfYzSqYfSP1FSZmn2MbzCP50
         AFow/eI9XKNj4JTIaU/pMWnAvRnhxz2nC4WON7PhgzdHVHx474VaDdYlkLDfHWIcO6wK
         aGRCgPgV8QqU+fjy1lIVa+Gq/pcbK41AhUyPKZa6P8qNtX7/8GerLnOcPn65+rMkEk+w
         NHyg==
X-Forwarded-Encrypted: i=1; AHgh+RpEX2FWHeJ7X0jFKAY3TvtRVLdLJ1HsFbyiKMuP8lgno0gvHzRf0gE6gbur0XtwR2KOZo7GXQjWteA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7j+qvDin138Cz3oiPx7tEDCYLLPG34difTrRX3BbWiBwONeWe
	ab3c6Ew1DttD0QGUSn/7ociI7v1ujdECVKjvZyRQBNlBSCfaeReB92m9cCXAFWw43Lke3gy9I2X
	knGFeRznVSXIE9OCdpkqFF2wINOn1ZYhi9QpjBC3xkqy3oMtj3ZwyvA62xqiWRjk=
X-Gm-Gg: AfdE7cm8m6YpMUTttvt4ZKgnbAn85qvOl3qB19Kp04hUFKqA7zB46bLMf0MjrRU0AAN
	3+0N8V/GGrn6rDHG4yiMQpqAhMk39/ohT4TuE/X5NWwoMB4oDi3t7nxNR+fK5hQBzSpIvF8oA9o
	2dsiT/JLNrBjD+o1uozDodOihLMPk/DKzBn3oPJN/FFKoVwczX6ong5xJH0hZsUQJ62lFNJwewo
	XWXTMLc1/fTf4EpjngG5vAE5pDKhdmA5s7bB7qvJq2bpKQ6xwxSIz0MGq6SXYSj32ss3t+yfaBG
	iYd3zzWNowkpFur0alz9dIXNMMirrKTxxrVFvVMTIpF1dxoB7XAum+RiMCrZKeSC7NUnCYYj16q
	BO20zgJuVX/V8FSGYjmEnfbOZTw==
X-Received: by 2002:a17:90b:3911:b0:37f:9cdf:f0b1 with SMTP id 98e67ed59e1d1-38e17e859aamr339879a91.32.1783971433946;
        Mon, 13 Jul 2026 12:37:13 -0700 (PDT)
X-Received: by 2002:a17:90b:3911:b0:37f:9cdf:f0b1 with SMTP id 98e67ed59e1d1-38e17e859aamr339864a91.32.1783971433488;
        Mon, 13 Jul 2026 12:37:13 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-313f3ea883asm207540eec.29.2026.07.13.12.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 12:37:13 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 01:06:50 +0530
Subject: [PATCH v6 01/11] dt-bindings: interconnect: qcom-bwmon: Add Shikra
 cpu-bwmon compatible
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-shikra-dt-m1-v6-1-bee265d3499b@oss.qualcomm.com>
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
        Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783971418; l=1132;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=Uv6ZvEASOaSSEeDU/bFl4MtSdU2PqpdvHwxUksopvic=;
 b=yrHF/i37zl1zmdrt3gs9W1sLUEm408c6jGIwoKDK6OzwLsIe01Vofd75p4l3joycXpAFUNsTI
 F9MV/qV2ySBAMDG7uOw765odE4zaf8YB3PwAfZy5FB6VHe0+UYgWP+t
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDIwMiBTYWx0ZWRfXwT5XpYJGi8fE
 VJ4BDT1WrfT6gud3ERuiF/iDwLEKzVRj2XJxoLn3EGqInfpht08rfgJHXCNe9GOLbPa67S4dsmK
 Tfakz1EZfsWCLulMeQ1D3ylmdoUFJTU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDIwMiBTYWx0ZWRfXyj8tweOB37Cl
 P5o7Q/KIMXr2nHD2W0pCydh4zoccnRkDlhiYm3KNOHI6qTD+o5nXd2jkEGqb/Az4TZ88NGKaua+
 EC6Hf3jr2f3DpxBBsfrtHGQXKPjsImMOcZJhYyIQPfKqOWD3NHJVK1uPIPMOjB3ba/Se2fsyThW
 iNdcrcGNYGFjJQx/AihLb9Jqj0UtnE3gdhHZcdoyGGe+nKiT63yCmfptRpWvwuXgwlt0Xd7AM9E
 vjjswCz3gjV/+LXniK9Kz13qki+8r9dkSvHruHwdIXFMWx21M1axmbffmJHaQ9BQ64OBATspYoy
 aTK9CzOvc+7Km+dHl3d1ciZ7krskH3cxlNkEpxeWsnvA+Fp6MoOZV/Smt6zTYZweSXw8plbTOcY
 0Yicmy4H4RDrXAtTDQKqHd41gkdr72XFy8Gq3RAxKprpIuiZRteMfgQsEu5Yv2ShH7NP3Xi37Wj
 PJYHkMbnHTPLlfwXcRA==
X-Proofpoint-ORIG-GUID: Clk8jVjw2L3xNTuiwWNDIHdNEqbNeVir
X-Authority-Analysis: v=2.4 cv=DbcnbPtW c=1 sm=1 tr=0 ts=6a553e6a cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=xRFGNxSSmkLZXw3MVBAA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: Clk8jVjw2L3xNTuiwWNDIHdNEqbNeVir
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607130202
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12426-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:krzk@kernel.org,m:djakov@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:linux-arm-msm@vger.kernel.org,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pm@vger.kernel.org,m:komal.bajaj@oss.qualcomm.com,m:sayantan.chakraborty@oss.qualcomm.com,m:krzysztof.kozlowski@oss.qualcomm.com,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[komal.bajaj@oss.qualcomm.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[komal.bajaj@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EB19374EBE9

From: Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>

Add the Qualcomm Shikra SoC compatible string for the CPU-to-DDR
bandwidth monitor. Shikra has a BWMONv5 for CPU.

Signed-off-by: Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
index e002e70580f9..7474193c59cd 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
@@ -52,6 +52,7 @@ properties:
               - qcom,sa8775p-llcc-bwmon
               - qcom,sc7180-llcc-bwmon
               - qcom,sc8280xp-llcc-bwmon
+              - qcom,shikra-cpu-bwmon
               - qcom,sm6350-cpu-bwmon
               - qcom,sm8250-llcc-bwmon
               - qcom,sm8550-llcc-bwmon

-- 
2.34.1


