Return-Path: <dmaengine+bounces-10091-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKrjNsQz6mkCwwIAu9opvQ
	(envelope-from <dmaengine+bounces-10091-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 23 Apr 2026 16:59:16 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63722453FF1
	for <lists+dmaengine@lfdr.de>; Thu, 23 Apr 2026 16:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 09D18308FA35
	for <lists+dmaengine@lfdr.de>; Thu, 23 Apr 2026 14:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A5D35AC15;
	Thu, 23 Apr 2026 14:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o0upl1Sy"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF09135CB89;
	Thu, 23 Apr 2026 14:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776956249; cv=none; b=rBV+RN/bRtuty/oPzKqnXQr4mYGvjlWHI9vcj9KT1Q3HkNneFXLukRS6wahwX+gsqD1qkV74MEGeDY8L4lOP4K6sa0rKCbVFn09+EZjRQxTlnkxpZdu4IrCHpt59Jb3mpo4U9t63GDUhblzYVYs6wxauO01Q0hgCZ6d0s0CPBEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776956249; c=relaxed/simple;
	bh=1lCxQiOyX8NlNUlBXXqPzc/TAeshReaRt3/gRTPwcmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OpQ2vYPZQx3ZWNY52RVPaAEHcDvrFf2tSexlcYJ9mHooIy31CWqzK/OVhHUn4tkwlBIo1YeQC/ei0kkJ22d6avmvHy4bpchPY407VfK7uT46JqBEkgTL+pHub3ZFgzMM4GHYzszNCYo/zZEMFy6RrCYvH5xTtZG/JyuxB9dXA4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o0upl1Sy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63N8uN7A1565720;
	Thu, 23 Apr 2026 14:57:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=rM7GAu+3vsO
	6bUBWuQYh1+164AM80heJ0y1xmJjvzEI=; b=o0upl1Sywc8TbG4FGc5It00u9I7
	dYNlbQY/xwkUXTQhqFSQKQWLyy/NzsMOh2tFAGHWNXLsppKlXMPQ+0qk76EeSYzP
	9htqkjG4ppaOxX1wkJpmmmcWBOzVK0uxWyVdRJUvai6umHbGzqhy9t5QjhnJQjb/
	0Q6d7Si8p0kquohs52vohsmtuFOWA/DRs8cKSRXGWy9v/dAy/dtyiTaxWPaI+Pqe
	tGpZ0NXk4O3xjFdoV1l41Ne0aaZd/JczJHzRYGzS+uSpWxu2NaBIQQEv0a95H32q
	YlNqkNU1Zey2OrbSOcJE7OlM8ptdgXdovF+4EZ7pr0FXRIACiHpwFwEVDyQ==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dq16wvkfx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 14:57:23 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 63NEvJTJ010858;
	Thu, 23 Apr 2026 14:57:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4dm31k24a9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 14:57:20 +0000 (GMT)
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 63NEvJsU010851;
	Thu, 23 Apr 2026 14:57:19 GMT
Received: from hu-devc-hyd-u24-a.qualcomm.com (hu-msavaliy-hyd.qualcomm.com [10.147.246.140])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 63NEvJX7010848
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 14:57:19 +0000 (GMT)
Received: by hu-devc-hyd-u24-a.qualcomm.com (Postfix, from userid 429934)
	id 1B59721C47; Thu, 23 Apr 2026 20:27:18 +0530 (+0530)
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
Subject: [PATCH v7 1/4] dt-bindings: i2c: qcom,i2c-geni: Document multi-owner controller support
Date: Thu, 23 Apr 2026 20:25:48 +0530
Message-ID: <20260423145705.545552-2-mukesh.savaliya@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260423145705.545552-1-mukesh.savaliya@oss.qualcomm.com>
References: <20260423145705.545552-1-mukesh.savaliya@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDE0OSBTYWx0ZWRfXwVSasqSQacK2
 vBhkENQd7WCXaAws6RAP9WjY8kG2w8hliA0dQm5rcUrM76fNh8McDy/2yvr8dMJC+qnX5G0pqdD
 95xy2svL2pPAewtEL8PhZYxc+e3+yt3zuUS4DRnkNCNeT5NUN68P0KRukbKyWAQwiToKKFCH9lJ
 lkR2D/qVbyYRQ6REy4wBzOXQSRjJBwMLlBUiTbvhfaF0Z6mj7elab3+ZExtGQBTdCjM3bR83Adb
 sWCPYhNkIhsO1MCC7I3zKv4KXXq610doimtvgZUNezZ0YJUpN4/fQWDaSw7+d6nNpoWt/zjxj75
 W40L0cCk8HN8OY1i3vz5/zEekgAYWOPdYBlAotj7Cggysxd36Ie3j/KrEMQA2RsbSF+5Nb7jY1V
 NS4Onwv+6pQjpYkHrUM1Mn/2Ipi5FmXOA9PBpfr8he3mdjPzNRgVpscjjvvSdrura977F6OPbII
 lC0YJK5SAxe4GHX45+A==
X-Authority-Analysis: v=2.4 cv=dL+WXuZb c=1 sm=1 tr=0 ts=69ea3354 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=yG_STSell-aZfaz4LqIA:9
X-Proofpoint-GUID: AvTQKP4MHy-e4Uh3TqYYgjxSt41jbgqH
X-Proofpoint-ORIG-GUID: AvTQKP4MHy-e4Uh3TqYYgjxSt41jbgqH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604230149
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,gmail.com,quicinc.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10091-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mukesh.savaliya@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 63722453FF1
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

Acked-by: Rob Herring (Arm) <robh@kernel.org>
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
2.43.0


