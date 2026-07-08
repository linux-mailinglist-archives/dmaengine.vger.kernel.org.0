Return-Path: <dmaengine+bounces-12094-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Yg3oFT/cTWoH/QEAu9opvQ
	(envelope-from <dmaengine+bounces-12094-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 07:12:31 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE3F721B8C
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 07:12:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=JBPN+QwQ;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12094-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12094-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8FCD9300B132
	for <lists+dmaengine@lfdr.de>; Wed,  8 Jul 2026 05:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C824B3B52EE;
	Wed,  8 Jul 2026 05:11:00 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1D51F03DE;
	Wed,  8 Jul 2026 05:10:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783487460; cv=none; b=bLhOMHMz6vEoODEy+wvk7QOMyqkqqSrGjW+Bx/u6h9ZdV819yf5KKC9bstcodIkAeenOxRnuM8NVVLQ3g3+8HNxUMNPJJIf27iCNK/gFig4MHVO5aUlGACXko2onLgrhGlwDLU7zGltS+b6Jmax3NCKs1jbEq5HE9/16kWnwKJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783487460; c=relaxed/simple;
	bh=6bQCbcIY+Asx/0DnCv5CXfqby5VEXYj0Uiz/RsRGhQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=alO7qjDn+L1d8KJXkMHiwEPuWpSrXkAJuvFNIquglweiTQcKxQdAU0MQ1WEM1GCC86ePujgytirCdPR5xI7jvxqFSoeDunBb00VNgJwOIziaJf9EWi+CyokC0vD8ZUnSWnCHcSYdUu4G0ZhWL9p1hQg4mxME41ke9E1vRAh7CRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JBPN+QwQ; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66842kdt1491932;
	Wed, 8 Jul 2026 05:10:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=pZoyey6z+gl
	rWL/OFOqkRTCq+cb8aKTyCA2INl2lfDs=; b=JBPN+QwQVnLEpalz3vd3LZHdomf
	O/i49DmTR72N2l2HWGdnU81ckKUz5JGZYih5uEaOJ1MPd7jFjHmnGQhl6NG2v4iL
	cBAENhpmit1YYyEnbNa9rnzlLV1idOf6dtRleW1ukOpkeg/iRhdFLED1/g8cFP1v
	7symQRdY9R6/OyV9tqsQ2YDaBK8jVgwwXr7qVR1oNjLJEVFNjhnhmdT1rx5/QTG1
	VKcCD7l98Li4souuDTNbso1YyDrY49lRsORxqLnwrpu5GdNz0WR9i8EG6wLoVHb5
	RJ3OP4hMmnkUIFkMzrOMHSKhlK1woq/Wk7m93piiB3reNqETHtZmPPISDsw==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9b5g91qe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 05:10:52 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 6685AniZ016077;
	Wed, 8 Jul 2026 05:10:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4f6u8kcrxm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 05:10:49 +0000 (GMT)
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 6685AnIX016070;
	Wed, 8 Jul 2026 05:10:49 GMT
Received: from hu-devc-hyd-u24-a.qualcomm.com (hu-msavaliy-hyd.qualcomm.com [10.147.246.140])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 6685Amxo016065
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jul 2026 05:10:49 +0000 (GMT)
Received: by hu-devc-hyd-u24-a.qualcomm.com (Postfix, from userid 429934)
	id F060C2181C; Wed,  8 Jul 2026 10:40:47 +0530 (+0530)
From: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
To: viken.dadhaniya@oss.qualcomm.com, andi.shyti@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, vkoul@kernel.org,
        Frank.Li@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, linmq006@gmail.com,
        quic_jseerapu@quicinc.com, zhengxingda@iscas.ac.cn, kees@kernel.org,
        agross@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Cc: krzysztof.kozlowski@oss.qualcomm.com, bartosz.golaszewski@oss.qualcomm.com,
        bjorn.andersson@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Subject: [PATCH v8 1/4] dt-bindings: i2c: qcom,i2c-geni: Document multi-owner controller support
Date: Wed,  8 Jul 2026 10:40:07 +0530
Message-ID: <20260708051023.2872304-2-mukesh.savaliya@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260708051023.2872304-1-mukesh.savaliya@oss.qualcomm.com>
References: <20260708051023.2872304-1-mukesh.savaliya@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDA0NiBTYWx0ZWRfX0BlUIiAMk4WW
 v+56s3W0Fuv7Tr/EC3O8NBW3VYiBMVm2s5qDsVoIOpisifLh9zaKmufrwpEBj4iMsNi0BU6aPUi
 ogcGiM/wFKAjon+zPDAppgCu/CJ8luc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDA0NiBTYWx0ZWRfX07NSATUamlJ1
 IybpQndRRpTlazXXWW5p1xweJjmOFABs4L0oi3nLUZwuACIBx0SKYV1rPgOIMDFYJTLitrMZDP1
 3PB4jj7wAJqom7+q4uBYP5TAFUOXWM3vEAZlS5n8OJalt93YdRUcJ2yAAbn/W0ZYdlmA3iLx+fL
 dCI8Sb7cxpssfTyxdWKZSgSY1ces/LYAY32mb09TnPGs6TNIRtQ7ZK5ucIa9HJClqE1HGVskn8y
 +cquedb612RbmqjbFaYvk+wHxraAS9PDiGonu+1ybVDIQIrGmtkyH5UD8LT/3+a+wb7IbEQOy6A
 bXZMUaAhl5uqyhQFPsMF841kfxJI7LfkFfuR1lm7lQ8PGlFGl+KMBedjWoQirdjuIQqWGDk3zrz
 nOs8pK4DdodSuat4kzauNWzFz0Es6n2/qhS/kqOh4AZkN8JsvN92x6eVmUgIOIIFvR+JTe59HGF
 cEaTHAxAA+Loy9tT88w==
X-Proofpoint-ORIG-GUID: f_WXl0O6i-xgVW3Yg67V6ujwceZ8mV8Z
X-Authority-Analysis: v=2.4 cv=JLULdcKb c=1 sm=1 tr=0 ts=6a4ddbdc cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=yG_STSell-aZfaz4LqIA:9
X-Proofpoint-GUID: f_WXl0O6i-xgVW3Yg67V6ujwceZ8mV8Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_06,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 suspectscore=0 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080046
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12094-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[25];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,gmail.com,quicinc.com,iscas.ac.cn,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:viken.dadhaniya@oss.qualcomm.com,m:andi.shyti@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:dmitry.baryshkov@oss.qualcomm.com,m:linmq006@gmail.com,m:quic_jseerapu@quicinc.com,m:zhengxingda@iscas.ac.cn,m:kees@kernel.org,m:agross@kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-i2c@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dmaengine@vger.kernel.org,m:krzysztof.kozlowski@oss.qualcomm.com,m:bartosz.golaszewski@oss.qualcomm.com,m:bjorn.andersson@oss.qualcomm.com,m:konrad.dybcio@oss.qualcomm.com,m:mukesh.savaliya@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[mukesh.savaliya@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mukesh.savaliya@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,qualcomm.com:email,qualcomm.com:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AEE3F721B8C

Document a DeviceTree property to describe QUP-based I2C controllers that
are shared with one or more other system processors.

On some Qualcomm platforms, a QUP-based I2C controller may be accessed by
multiple system processors (for example, APPS and DSP). In such
configurations, the operating system must not assume exclusive ownership
of the controller or its associated hardware resources.

The new qcom,qup-multi-owner property indicates that the controller is
externally shared and that the operating system must avoid operations
which rely on sole control of the hardware.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
---
 .../bindings/i2c/qcom,i2c-geni-qcom.yaml         | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml b/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml
index 51534953a69c..ed9b029603fd 100644
--- a/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml
+++ b/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml
@@ -60,6 +60,22 @@ properties:
   power-domains:
     maxItems: 1
 
+  qcom,qup-multi-owner:
+    type: boolean
+    description:
+      Indicates that the QUP-based controller is shared with one or more
+      other system processors and must not be assumed to have exclusive
+      ownership by the operating system.
+
+      The associated GPIOs must not be reconfigured into a sleep state
+      during runtime suspend, as doing so may disrupt transactions
+      initiated by another owner of the controller.
+
+      Each owner is responsible for maintaining any resource votes
+      required for operation of the shared controller (for example clocks,
+      power domains, interconnect bandwidth, or other platform-specific
+      resources)
+
   reg:
     maxItems: 1
 
-- 
2.43.0


