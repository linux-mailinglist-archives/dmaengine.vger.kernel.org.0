Return-Path: <dmaengine+bounces-9810-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gIt4FwkUzWmMZwYAu9opvQ
	(envelope-from <dmaengine+bounces-9810-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 01 Apr 2026 14:48:09 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE94D37AB59
	for <lists+dmaengine@lfdr.de>; Wed, 01 Apr 2026 14:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DD4603097020
	for <lists+dmaengine@lfdr.de>; Wed,  1 Apr 2026 12:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20AA140757F;
	Wed,  1 Apr 2026 12:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hMirwWpC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cu0TziGF"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71DA406273
	for <dmaengine@vger.kernel.org>; Wed,  1 Apr 2026 12:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775047240; cv=none; b=Apf3wuTsH7PPUqU32wJRiKvBD7W4czzRjC1TVsCn/WW3nikgEK+/xaer9T+9I9z3ZStDRCK/vXZTVpsWicA8zRH8hAds/cNrrIoug3KsBNUuGyfRNwrbRMD6hhBjJJ8kpo7vlxrKxCCoVZIxPx2/9rPFXE0/xw6nor8QBuCB2gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775047240; c=relaxed/simple;
	bh=V5Q62nK0Vbbku4OtnNMe64D85IWZhZmt3X/PMujd7b8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qjrNMK/afYwYzuMOjaroJZQ+zLmmvO+UZizO6hPnn+nGhB3y0qYhldnvYqMAP3XbFygryyDe8pS4C5bQmsOnSNQmrbln/NYWc5WNVcL6CfVWYMb7OaiCBtH5fp04419hY+IPEqvSMWOV3wFGum2ux3NLslRQLcao2H91z4Gg3h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hMirwWpC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cu0TziGF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6319Ttei1579389
	for <dmaengine@vger.kernel.org>; Wed, 1 Apr 2026 12:40:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=jt5F0jmqoE4+JGiWZ53i58ADF2Fia+zsItp
	8jaoXLWM=; b=hMirwWpCfXpZ8fgkE/tHCqq1EmTzdzMNyMgb427m+/i+9g+67kB
	jzFG04BU8ccZ/GFaZBg+n6ksqH2YPqQDUcbOs0t/CEo3nCJlk3PsLwzCOQIkcwtm
	2G94EQL1ij4N2XXioZcdlsQ5rtv5kdsFLR9dyVdHYDTwC5bKrQJaXgEv231VwbAX
	ugavsjq73bh0FQbZGzH/57/H9KJSmh1VkA643+Tk/5k5WEaRWWWPwQgmXlBUhrqg
	L3YZh7J+LnUdwe2pgRWpIjm3HI3+LBX0Egk5U+Q2ywHFd2FzgWOwn/0A5WfeAH3L
	wOCcO0LoRGVS3tTUncJKzcGaFVgxiLDb6NA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8mr2ukdu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Wed, 01 Apr 2026 12:40:37 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-35678f99c6eso4997721a91.1
        for <dmaengine@vger.kernel.org>; Wed, 01 Apr 2026 05:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775047237; x=1775652037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jt5F0jmqoE4+JGiWZ53i58ADF2Fia+zsItp8jaoXLWM=;
        b=cu0TziGF8CmsAQ3VAZM4MSsRqHwWpkZRQ519NiYQPB5OEK2Y9wvUfh+reqwZW4+WfS
         BmsF124moxRAmz8Lx+F2yT4Y4ofwZUzLnj2P7pMFXPNSlRkf5zFxtr6qR4PVuV8KRgVd
         ztEWXBHED0+JBLYFiQhdN8mgsrJcIol1ZBg5kW4t7n3XSv4E8qtCTnGhvzfztwX8OZ6q
         KBA7OKOvdjlnoTQuS2+4AX+PdLTNXDJCRuJzPkWjgeKoj1y3Dh3KehWB6bREgJM42tQ9
         GNovK49y+3SxARnFzCGoftiXQfgZqGARfj1Ztw6lEEgyg769pfj/a1Tc00G1a0ZeNQrf
         C9Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775047237; x=1775652037;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jt5F0jmqoE4+JGiWZ53i58ADF2Fia+zsItp8jaoXLWM=;
        b=r+KAaa9u7Hqe4IFsGRJEjWS+rYg/SWVgGksrngQ2kmcE3RDQ/OBK1cKjCfMvKO6ejy
         qr9uJ8OTTLGxkoqV7P1vePZZbqs4xvmsMlOD8mXTWX0XyYkdeMC7Z8en+KK/dLPYwHth
         NGBbGLjyhT4KWRgYl4xOrbC0ZwNBCuwSVX9W9fn+NmmMiM5GM11YdXPlmKbqzmQ06i6t
         3Ilh+aTPnwaZO0os3cp5Xe/xo8iZbbQF725tx1BjqugCbL72HA3DNyy7j9CBjmOgtRt1
         a2b2ZHALEy+h0xLqfzxsrYS1F9tE8Tu560o7km1PTqJDkY3F7fL/cmpFwGTLzzezCXvQ
         JVYA==
X-Forwarded-Encrypted: i=1; AJvYcCUcCRO73Rr7/BiZ1bJaiBp0ENDR4+B8z41q0pZwtdsvZKjIVRcZCKQZ7iOSUCsEJkjNXDwTT14ilsQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1z4iuEx6YamtIDJJITIukWaHmGq1evkNyf17IjbHRgpY+NDVv
	lYz/DL8RLZM+NrI32hyB0Tzoh3LURtnp0rDBURJgqdxnUO5OXU1iMmG9m/WrmmYncsfaMtKDfBE
	DK3eu4im4JYH9prXkStJR7Zo7ptEyURe4bYtCdFWOWV96yliwIsMa+A7p7S92AqI=
X-Gm-Gg: ATEYQzzVrGTaxDilT4uyzUanO/SHTlcZ+Rz6AAjBgmOqsSu6Nse0ZWfD6FY/QKthwFF
	Q10Cqny2KKjp5We8fqqCrWyw0a1rIpHG5Jbirec8pr6MkVXubxrPcnbbkKWC47oYBI7ZaE+LE/7
	qLSKw0yluhGlN1IiKfnrvN5lAOvV1c32pfSLsAyf6SBo9wlPi2vJTCn0wpJ0pMAuBvdOL6CdK3E
	XZdRKvNQNswJUwGaok36qa9o4cdrKISPjaQQPPK02J2fTMslYXOkc6dEuO3Zet5o8x0QUkyNHHq
	LAdf/55isRkE65qjor7C48FIfUXrxgXnw4cIWXAl2wLXNtXsYR4CrbSxMKnAc9Mgm7+zPpwcFIk
	GDYbQW5zr9PPLe7horw0SftYc89OLnR+6ysgjQgYUuftqdzUG
X-Received: by 2002:a17:90b:5868:b0:35b:96bb:47b9 with SMTP id 98e67ed59e1d1-35dc6f7aaf0mr3154331a91.19.1775047236606;
        Wed, 01 Apr 2026 05:40:36 -0700 (PDT)
X-Received: by 2002:a17:90b:5868:b0:35b:96bb:47b9 with SMTP id 98e67ed59e1d1-35dc6f7aaf0mr3154293a91.19.1775047236029;
        Wed, 01 Apr 2026 05:40:36 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbb74aa3bsm3558171a91.1.2026.04.01.05.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 05:40:35 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: Frank Li <Frank.Li@kernel.org>, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xueyao An <xueyao.an@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Subject: [PATCH] dt-bindings: dma: qcom,gpi: Document GPI DMA engine for Hawi SoC
Date: Wed,  1 Apr 2026 18:10:28 +0530
Message-ID: <20260401124028.589931-1-mukesh.ojha@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=B+O0EetM c=1 sm=1 tr=0 ts=69cd1245 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=Kwsw5yc_4_qMWDLpIgMA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: UVeYKLAiD-s06FKC7gKcGWJ_-J3h0Opv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDExNSBTYWx0ZWRfX86nODTH4zSNQ
 9u7b2iA4WoDL/mqFTTS4AB4yjcTzfmQuT0ESU54+83FPZO91HDzk1hq7kD/YPhkpcIM0Fvhl7Oj
 WkWd7xhkpglA9bVoIPZ+10cHPHZujL9fXE3mEW7JSDMpLB1hlLse3RppmxgPOVDSQUns4pOEeB3
 UDRSQixYt56vozRDzlbFgBqRSq9bkw/x+XUKOK7U5pBAPB1rdknX1bvYstg/6aFpWWAnBx07BIR
 CdVuMWPtWYg1Eo8YOoc7xsa0zaBU9mbhy5SiZRZEK/j1GWRZRFSWUjPlbfvCRE1RG4Gft8POdmr
 IINBlbo6Er9DXeEdK7GdavesvJYbfu0CB+4M9jk1JJpKSSD9xvsOQM6AZLrxBRzvhRyEDts2IP9
 HXEXUAbnfhq1DLCrYlOJ8bsoETvNf2EQWtEeKNo6FgD3iMoP3CCDQTnQGDk9xJKOyGqaXxk06B/
 /igGxx4uVlzqyOyRafQ==
X-Proofpoint-GUID: UVeYKLAiD-s06FKC7gKcGWJ_-J3h0Opv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_04,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 clxscore=1011 suspectscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604010115
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9810-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_NEQ_ENVFROM(0.00)[mukesh.ojha@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: BE94D37AB59
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Xueyao An <xueyao.an@oss.qualcomm.com>

The Hawi GPI DMA engine follows the same programming model and
register interface as previous generation of Qualcomm SoCs like
kaanapali, glymur, and is fully compatible with earlier GPI DMA
implementations.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Xueyao An <xueyao.an@oss.qualcomm.com>
Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/dma/qcom,gpi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
index fde1df035ad1..caa2ef90d8f2 100644
--- a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
+++ b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
@@ -25,6 +25,7 @@ properties:
       - items:
           - enum:
               - qcom,glymur-gpi-dma
+              - qcom,hawi-gpi-dma
               - qcom,kaanapali-gpi-dma
               - qcom,milos-gpi-dma
               - qcom,qcm2290-gpi-dma
-- 
2.53.0


