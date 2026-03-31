Return-Path: <dmaengine+bounces-9774-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JOABxi2y2kpKAYAu9opvQ
	(envelope-from <dmaengine+bounces-9774-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 13:55:04 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC48636926E
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 13:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0535F308E07F
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 11:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DFD13B4E8A;
	Tue, 31 Mar 2026 11:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EWJprRRQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600743D8902;
	Tue, 31 Mar 2026 11:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774957704; cv=none; b=GdwSCYuurmRn9YMrleGs29wkmkuNt8xtmZ6K6rflOYRUSP3iYlS3EBCOIv+9K1GGzqTv2jciCRr7wK9TMkkJOuFSiDUl6uCzDyWoaX0qahVZLeZFxLoj8Bv7tgZWS8wf4wZZtV/581kE9XbomnMBEWNXbWR+RxaOlprlM4fHQsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774957704; c=relaxed/simple;
	bh=m+uRGhPBEOfp+IpOfd/XXZEZRO+dGdaEhbkYruM7RzE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DQVb3bcIk9q+xej/4dOysgy+nTYcg7fD/qcxV0x1Z0irN/7NMrGqp+evoscLoOifoBcbIc3x5F9Ju7HuDs+8dym+ss+IN1MwBjJznnfxrwTFzagGtqKHbxLofpqUOda75J+KyJsCt9nXlUFB2iABDxZMNRHFPAjwoOauzIU8xns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EWJprRRQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62VBCb1V2410022;
	Tue, 31 Mar 2026 11:48:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=zWHa+iO6k06
	enwJlTngz6ZYA95T+FaPrG6C2u68Vhjs=; b=EWJprRRQ7WAtTarp1FCHsCxo4ES
	KS0tXylS+0/QLc4XTW46I7KUN8st/7/pUl7OedGihEOkv+ymWsZkRnLCku2KL+ae
	SZuZoOJgVCR3zZx7EPfODKqlKdRMY1DtEviRmYuohQAhA2jg/cGc3izozISOkzZF
	JzuXeOXkdcw2lmArOBGkCncK3N+i2aBuYu8SwHKxwqOxBRS0E6zZemVxhr3lRKUG
	lI4n0KfRwNoE3i0y4GWLKb5JgZjqWhiHHY+fgh4Wt2OJUkwtXDCGjH+wuSbHsIgN
	Lss1GABuokWs62iMQg0IUksJgqcqC6ombec9DWbgMI7WZs8fPfd1kQrBo3g==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d80hetw87-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 11:48:18 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 62VBmFuQ011228;
	Tue, 31 Mar 2026 11:48:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4d6qk1vekn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 11:48:15 +0000 (GMT)
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 62VBmE0e011155;
	Tue, 31 Mar 2026 11:48:14 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-msavaliy-hyd.qualcomm.com [10.213.110.207])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 62VBmEv0010985
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 11:48:14 +0000 (GMT)
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 429934)
	id A945C2579A; Tue, 31 Mar 2026 17:18:13 +0530 (+0530)
From: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
To: viken.dadhaniya@oss.qualcomm.com, andi.shyti@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, vkoul@kernel.org,
        Frank.Li@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, linmq006@gmail.com,
        quic_jseerapu@quicinc.com, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
Cc: krzysztof.kozlowski@oss.qualcomm.com, bartosz.golaszewski@oss.qualcomm.com,
        bjorn.andersson@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Subject: [PATCH v6 1/4] dt-bindings: i2c: qcom,i2c-geni: Document multi-owner controller support
Date: Tue, 31 Mar 2026 17:17:39 +0530
Message-Id: <20260331114742.2896317-2-mukesh.savaliya@oss.qualcomm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260331114742.2896317-1-mukesh.savaliya@oss.qualcomm.com>
References: <20260331114742.2896317-1-mukesh.savaliya@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Authority-Analysis: v=2.4 cv=Gb0aXAXL c=1 sm=1 tr=0 ts=69cbb482 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8 a=yG_STSell-aZfaz4LqIA:9
X-Proofpoint-GUID: fvKn87JGnxHO6R0Qh3itb7V7UD8TLolr
X-Proofpoint-ORIG-GUID: fvKn87JGnxHO6R0Qh3itb7V7UD8TLolr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDExNCBTYWx0ZWRfXzPE6b78ybPpw
 emIuVwJt/t1+VBpOd5a7dvOnzUBZEJwPPSsSOZ+X6yGRv7ACbAurQr+tTU8D7UbO1zxDlwB5uZA
 7Ji+g0xtTRFHkXVASvz96hr9y7TsUc2Xu/N9ur6evSm/Gl84p5Fo86PwPMBsfd3/E3XVneG4vpY
 Z2BCTnIKFnhe/o4X2kxXVvizzknj09Iy1iuOPLoBELRrsGhVN+m8a4xAjgtTXLxQizftME/0M/+
 KDaUntrqYnOogBF8ZyyjUuP/M+rWPC92Ypxn1f9Y4qCQdshBmKUUgB0FWP8GUVRdNzVwGIVy0WR
 ZTwPKhHk6TRvaofqT6bnPpX3mAxCq9Xwh/7Fna9+Jb7RLjz4lvB9FxmMaHQtFKh+EvIPuklArSY
 bqIWP5pLWS9UksB6kpsxM4u5DNfoav5WZd59h604e5obsCMtO0Db2/N8tWEuv6QS/iKpMpeKpGL
 aNO4elWuMOQJScWzVwg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_02,2026-03-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 spamscore=0 bulkscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603310114
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,gmail.com,quicinc.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9774-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mukesh.savaliya@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: CC48636926E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Document a DeviceTree property to describe QUP-based I2C controllers that
are shared with one or more other system processors.

On some Qualcomm platforms, a QUP-based I2C controller may be accessed by
multiple system processors (for example, APPS and DSP). In such
configurations, the operating system must not assume exclusive ownership
of the controller or its associated hardware resources.

The new qcom,qup-multi-owner property indicates that the controller is
externally shared and that the operating system must avoid operations
which rely on sole control of the hardware.

Signed-off-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
---
 .../devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml        | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml b/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml
index 51534953a69c..9401dc2d5052 100644
--- a/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml
+++ b/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml
@@ -60,6 +60,13 @@ properties:
   power-domains:
     maxItems: 1
 
+  qcom,qup-multi-owner:
+    type: boolean
+    description:
+      Indicates that the QUP-based controller is shared with one or more
+      other system processors and must not be assumed to have exclusive
+      ownership by the operating system.
+
   reg:
     maxItems: 1
 
-- 
2.25.1


