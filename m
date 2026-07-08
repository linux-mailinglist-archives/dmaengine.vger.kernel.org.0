Return-Path: <dmaengine+bounces-12105-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IiT7Nj73TWpVAwIAu9opvQ
	(envelope-from <dmaengine+bounces-12105-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 09:07:42 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B49722791
	for <lists+dmaengine@lfdr.de>; Wed, 08 Jul 2026 09:07:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=hUfo+VjG;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=gfo8RB9s;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12105-lists+dmaengine=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="dmaengine+bounces-12105-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6E6E13012746
	for <lists+dmaengine@lfdr.de>; Wed,  8 Jul 2026 07:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59BF23E9F96;
	Wed,  8 Jul 2026 07:06:44 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214FD3E5EF0
	for <dmaengine@vger.kernel.org>; Wed,  8 Jul 2026 07:06:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783494402; cv=none; b=OCzjyM/mb0QmlVFtX0iZPBENIwVvSDxz8gmOL1E+uTVzSp3OkWo9P3CPLKh9Qq22mn9/5RiynCayBYnG7VCB+XrxXc66vg6I4wZQUOEA6O9aDlsVJfKiWiUhDpaeSNVo0E1xhZo8xxsy+L5+LIeeY0hsUg93WY2+bXUdz54z2Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783494402; c=relaxed/simple;
	bh=KsY/Jzd6sqCes8KP9dBLhmzdqd9FLJpumSOrdFVcJlA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ajYwAR+fm4JbfyWRfs/Lz5+PoSJLxu+B8TfKMuBLwjrxZIXEGalHF31gILGKYmly6BevaiVbGKiFiU9X38D3BH3Gda1/3ptLc3uiSxUc4MFOTjuJz3ggtrj8sTAvIn9Y3FxgOyzhKy6CrhKX/C6zbBwn5AFjMQfBFaEANw3QGJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hUfo+VjG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gfo8RB9s; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6685E37e1819306
	for <dmaengine@vger.kernel.org>; Wed, 8 Jul 2026 07:06:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=qdLP4nhBveoly+Cr5TP4Fr
	k9KAJFIX+cboR8a25H/hg=; b=hUfo+VjGTZgAv7FGwWz9koShyRUPABu5xWg/ew
	6fEeZZv3+Qs+u2yAd7/EDRzlzWRoAFBR9l9pQ8Dcr6XEEny+t61LFGLsOseUMH3V
	F/MUZgbmgBPTK+a4BNr4zRUSxeA0/fMaM+ghSuAYfW7X161nUywvwf4dn4dzex4A
	IjSYq1YBa84uXBB4yJKAJS8aJcqneCsj1Zi7o4Qw0KKS9hwZs4LY7i7Appa5wt/k
	eEdJ9vO29kMkdBSWs87VejQR4wDKh+T9zFXyd9Duql+7ryYf2DCyZBwLM5AKeEzD
	92Bf/Z1C57XNsiOxUZ+q0pUAw94ETVpASIPkIUulqSIyxjxQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9g7hgd6s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Wed, 08 Jul 2026 07:06:21 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8478ff5d801so877284b3a.2
        for <dmaengine@vger.kernel.org>; Wed, 08 Jul 2026 00:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783494381; x=1784099181; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qdLP4nhBveoly+Cr5TP4Frk9KAJFIX+cboR8a25H/hg=;
        b=gfo8RB9s8svEHR/gdh2kFxTSYRBg9Ok9N0R83YqTeLdgb9C0/dLpzMcotKpfGEczDI
         OaI8S835elWnUXJUyK3TcszD7GFEd1SY6vvD4p+9ICAG/buKJJ4qcFEwLL15Uc6fl/hB
         E1RmpYDHcQpN6dJ+erP99BdJUSEGMIhr9Lk6UviZJNsvVmIZKVr/r8Cis07umtvc0EtF
         8w4suc72jf/w+vXykiSw7lBJSix1os8VtqRahkSGL0KzB7GrWhOhitEpfLYG9MrJO9kY
         cjWTtSO/abog/7O+9lQKVKyMpP7MSzNNlB9TsP0o3lJhOMiqy/4jiB/dHoh/w24y0KqD
         u8SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783494381; x=1784099181;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qdLP4nhBveoly+Cr5TP4Frk9KAJFIX+cboR8a25H/hg=;
        b=TSwDTNdhjXRohBsKNsrCFr/JrF5CP0XnCzrrKaclAVw37bjQwVGtIGw0UljvSwKF5R
         HppMtNbnN939fubgdg8M9AhhU8V44ml0IykMS2XTI+xOJkWtb+W+l/8MeSSmMX4l9iWx
         lfTZbHexG91HCLOmuJVQ5ntfx5rU2Ebns7E/m5RkeO5KZ9QLdZ67r3pwQKUM6emg5JoS
         B+1UKlNoJRbO1EI70/NRcSLtY+mSo6uiCiEIyvODIWHvH7k3bZAkDWw+GHmde3O9h3+j
         w+Ya3Qk+FaqWu+Zq+P4mzfPrWhPoZoETkYRaDPQD7rWtfzxdP5ufn1GrzqhSxdk+Br8c
         x14g==
X-Forwarded-Encrypted: i=1; AHgh+RpyCatRj1Bo0clC2zNchrQMWjOdZZzdou0N1wc4w5bGnkQnAX4xHxG9pf7QBf9CAf0lcTN4QqVzM2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHz0phxMvAI8bPE+GQOVkt2LjoDlRZREDFtMxWVLLOq9ed1wDB
	t1gkfd6l/YwjIWbi5K034U3zFmw/DukyIiNTE6KbN8uTM0Y14iWs1/5a8/34mgKVmce3trH+K6B
	lb6DKJPrBD7YtThHzNeMYKswL+Ob9Jx3H5O2GmBNUCCPsl3wx24GEqzydr8/RzEo=
X-Gm-Gg: AfdE7cm1Ed4b4WzP1RNmaGgEx/x7FJEkvGFfngH7AEHotjSOvt7O1vzVdAQHqro2IH2
	oCFc0aYWN4FWuYrijgkTGM+y3F1P+MuRxGvf4Tr7TtQaSu3DeD5ha2Qmi1KzRDUyXPS6hQJ2Kc3
	WPhR7Dbzl2XJ6Jup+P7Q3DmIY2jLJ+mrOt8XY5yWw2XdcyDCZmuwnMRUWC/81S/XMOF/i5/DggL
	y2oOfvc2muyOs2Zc7THuU8dKiclxGez00bzNqYrsK5MJ4SwpAia3lrCUZ8z1gmhKakYPzuimvb0
	C/AuqGuXxRTG7LJB76wtg6KRA8zgIMi87rfKdKgW1ov/fZF3W55FXEliorFqygn29s6R70whxTe
	NPwRi0ZVMOK5JAhLHrZdNBSKvMjjpd+1xBRONGTxAZK6R6g==
X-Received: by 2002:a05:6a00:2ea4:b0:845:e8cf:139e with SMTP id d2e1a72fcca58-84843452ed7mr1381001b3a.59.1783494379780;
        Wed, 08 Jul 2026 00:06:19 -0700 (PDT)
X-Received: by 2002:a05:6a00:2ea4:b0:845:e8cf:139e with SMTP id d2e1a72fcca58-84843452ed7mr1380964b3a.59.1783494379232;
        Wed, 08 Jul 2026 00:06:19 -0700 (PDT)
Received: from hu-jseerapu-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6d85c04sm6829148b3a.50.2026.07.08.00.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 00:06:18 -0700 (PDT)
From: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
Date: Wed, 08 Jul 2026 12:35:38 +0530
Subject: [PATCH v1] dt-bindings: dma: qcom,gpi: Document GPI DMA engine for
 Maili
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-maili_upstream_gpi_binding-v1-1-e48cb7e216e3@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAMH2TWoC/yXMQQqDMBBA0avIrBtIgqj0KqWEiRnTKTUNGZWCe
 PfGdvn/4u0gVJgErs0OhTYWfqca5tLA+MAUSXGoDVbbTvd6UDPyi92aZSmEs4uZnecUOEUV0AS
 LU2t8P0AFcqGJPz/8BpuB+//J6p80LqcKx/EF3b6KeoIAAAA=
X-Change-ID: 20260708-maili_upstream_gpi_binding-da1d2af41b78
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783494375; l=1004;
 i=jyothi.seerapu@oss.qualcomm.com; h=from:subject:message-id;
 bh=KsY/Jzd6sqCes8KP9dBLhmzdqd9FLJpumSOrdFVcJlA=;
 b=frOtO7U06hjqcljeD48PFcGu/9sGsVTQK9cTU2Udk1bNUTvCySKGVfCc4p5kaqIl0ZC1N611s
 4zRFiDMIK54Df4L6yd8AbLEmA5dYF9T9oaeWLDzD8H9x3lGihs+f97p
X-Developer-Key: i=jyothi.seerapu@oss.qualcomm.com; a=ed25519;
 pk=9vafyYsia0OnBKWSEwhmWe3hPVQfI2T1xOs5dPaFvEo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDA2NiBTYWx0ZWRfX753KC19hOgZ+
 NM28xGek5ECDVdqXFS9QLio89B45gh9p/HXM4c8GkJTHx0dqjcOeme07jqixdJg8RXRH8SamZN5
 KGef7cKKlitdzJ4BdAJu1Ik3TxQbtQgLsFnS4WxJSYC1DeqUduan05COnIcxZy3zrTh9AGOJa6I
 pEOp/QcGxGIgS0sFBWLVEcdd25fGoO/eg2UiQ2PN3TI6RmU8SPT/25JQUx+si6CqKetTG/7Mbdy
 hlO5+ga0ROyX77o9iT7JrQBC7qhk470oT8WLse4vpe9tUNzjsNYLS3ucrKtyh+o2xIqVlzHqjFU
 4NYjkNApUZCAcDvxpENQJOzMGLRgpATeUDRUIYIKunPLZVh2ThJ2oDxGOYd/jhglCS8WvNIfmRo
 lKasGfVCpGZ7ak22+2UIzJrNTi94c1Uu2k1zqlYmYrvXwZwOvRtvnd+w6hPqBkeYLk3l0YPs4Rx
 j0cgsMD9nJ78yW9m+Rg==
X-Proofpoint-GUID: ML0fOaako5UrxfQnmGBqRoqByYFUqB5p
X-Authority-Analysis: v=2.4 cv=TMp1jVla c=1 sm=1 tr=0 ts=6a4df6ed cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=Tqk0DnLf0ofBf8r947gA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDA2NiBTYWx0ZWRfX+DqfBzy4bbrb
 mKRVeT6aAuQN4cjob4AMd7CJAh/fUW/3TLnfwaClzm/WQYiJvexY7PS8rDKHrTKnUesLtsTB9Bf
 zp/kCIY8ZnEruGbd5P7XUTu9FRpjXHg=
X-Proofpoint-ORIG-GUID: ML0fOaako5UrxfQnmGBqRoqByYFUqB5p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_06,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0 spamscore=0
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607080066
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-12105-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jyothi.seerapu@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:linux-arm-msm@vger.kernel.org,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jyothi.seerapu@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jyothi.seerapu@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D4B49722791

Document the GPI DMA engine on the Maili platform.

Signed-off-by: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/dma/qcom,gpi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
index 54dca623223d..dfc4a3054b5d 100644
--- a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
+++ b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
@@ -28,6 +28,7 @@ properties:
               - qcom,glymur-gpi-dma
               - qcom,hawi-gpi-dma
               - qcom,kaanapali-gpi-dma
+              - qcom,maili-gpi-dma
               - qcom,milos-gpi-dma
               - qcom,qcm2290-gpi-dma
               - qcom,qcs8300-gpi-dma

---
base-commit: 598c7067dd8b65b93f3ccada47e9014a13137f1b
change-id: 20260708-maili_upstream_gpi_binding-da1d2af41b78

Best regards,
--  
Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>


