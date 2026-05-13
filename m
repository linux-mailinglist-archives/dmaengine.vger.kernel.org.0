Return-Path: <dmaengine+bounces-10426-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLdGI4XGBGrdNwIAu9opvQ
	(envelope-from <dmaengine+bounces-10426-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 20:44:21 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4005392D8
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 20:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 93DFC3033F43
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 18:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C52333727;
	Wed, 13 May 2026 18:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZdLZmDAi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MWcBhPUK"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767B33A963E
	for <dmaengine@vger.kernel.org>; Wed, 13 May 2026 18:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778697623; cv=none; b=Jx8cALDrtZKX+weQysV8K3pSRTKH4fNptHQPYagzmR81ldiSbYMWYg7zm0qD8wrUYOQsG8Nxm+9ZvNfUCtM/qAmkgH3qKqVcb56pfclBTAkebl3HhjuYTjUB2NxZqoqqx6LEgQ2iMxGAyxP8p1gahwf+oVMXrkvO6b6oCcTVr4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778697623; c=relaxed/simple;
	bh=kf3Hgwh2s4MVLGoLj2tEoIQ2lhKAbAAQDj6ClnbpYUQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=C3KStvnQp5/zGow0I3JVjFj7JTCKMhPyO6UYQ6m+pvZxpXapG+o3uqPqysuRWSgBUuuzaE1MTEGqFz33Exqgiz95cIh9NpA+nTvRg2QD1AdrFwjzoT6P/98D0GpPXoTc/bNRCfGZ0v8NuuofwTnumrBkDe61dLFbRBYPHuXlLkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZdLZmDAi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MWcBhPUK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64DC4g223324691
	for <dmaengine@vger.kernel.org>; Wed, 13 May 2026 18:40:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=hKvXM/fR5rULUyFLi80lbd
	szGP+PMtyMohq0PyR2w0k=; b=ZdLZmDAiz1mkbWJ5kSBCJsHR+4BNNJ06iIV8su
	RA4kQP3uS3skR8JZD3P8Xat83JG601EHiYIoWQljdBuTrIEPpbcJwGcELX7pRzsF
	vkjyg8y2SPk0ad4jdM2fWhEdipo57UcT7Soz+uuDIvmaIOU/Pmstwc24GTcYj0f0
	vHoWWs65buW6t5Ny3H3/phhoNmy48q/UbICqtw0vx/q2xy979S/aDlhQbjcaolJ9
	p/29YOJDvfuzzx7K7BI1W2nP2HfRenKQJmOUMzwbAHiAZlRPCQBJbz/OLqTeCd5v
	vbFlzUZzO6Y6BhuJvmxpg/xs1ZC6Eq5awIiaOvY8URAbqT6g==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4kvdb0u1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Wed, 13 May 2026 18:40:21 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c827b1f222bso2783604a12.3
        for <dmaengine@vger.kernel.org>; Wed, 13 May 2026 11:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778697620; x=1779302420; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hKvXM/fR5rULUyFLi80lbdszGP+PMtyMohq0PyR2w0k=;
        b=MWcBhPUK218JpjNGNmmcPAQVxv0530D2SQ3CRXWwHVfHnQ3vdW3L5EPa3/QO1TTxTA
         sNBMw8FqxfmAByMWx5QujgaYzJHYGlxEWsz+ptbhs9JoKqX4WbnumRhMfvq5YB07QWVQ
         1d4qF/QLlSkynZ0UOuLHcqHJ+WnrT9HTW89RKbY0maUl/dnZsOEVEVUIPyt6J2CAyzq3
         jsPy9WSelW3lcYMIdiqTROjUqsOZIC6Ff6tELl1O2pyWT0dcaMhthsCBmnfUixH8oiIt
         wjwfRsHEWxtIWxkQajfC1xOXPVC/13I/xR4kr0xxjHCXfdJ7Lt0vZQ64brEPYpbjREG4
         pieQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778697620; x=1779302420;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hKvXM/fR5rULUyFLi80lbdszGP+PMtyMohq0PyR2w0k=;
        b=R1WqaC1TyLyl+wn1AWWgycdJ2WmJL/Qk19sZIIE7yaeLa1UN890+eD572zG5iKOzeA
         5+PaFNVGRVws5I3w+fiC5ba23MS+1t84viZDE1I9VhkW4GrKejRh5lxK/05vEwi7DIj7
         JCt65zt553FWOT20HhwLCt5XAFwr2N0KCqprgYGJDn2zywgwcegtmD9QT+dZqbPBV58t
         P1HMsbdZ+GOUDDlp2CiKBu4XGjCZo9c4RD7iiTyir4x7UBB1pdvZwEenUCtR5MtNZF8t
         OYEVknfwzP8QT0ELWMhrOUg0Z964phFeFOJm1u6H7YpAPCLe5ERx5XuS7ADoVl9LzpFH
         LJ+Q==
X-Forwarded-Encrypted: i=1; AFNElJ8Haej6d9cKnvAZFMEZ0LrQziOdpANEMJKUjOWODoQbPnrZn4ktRjAr8cE+uSCzC5emC8sLzeaAygM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbk+EV6TddLMXiDHJZ3KZXkV3c1kWJZG9A1VHeWnlRKewNWAWG
	o4CLrwdBAPtn9KBfWn1mM/1GHcx3igZVKqgD7hFObrMyxCo+vyyL7QJmpJERZTZ6XTIo89TRTRf
	i1VbYriKtuNf/ES5nvezjtbr/OLg/ipfk4+91Lpj+bTQa9IMgmAOHDiocN8uV+LA=
X-Gm-Gg: Acq92OEZzlDVI1v+2CZj5NXmG6cdYz3AI3rDNLnN3biSyzSi9kvY8OWvCUyenx56zTF
	0ssMyxeiGvieQWChQzQItwgCLmXPZde2/Oid0C4DH3Er/S9cYCF9K7bwY0n4NxFgNfXEktUW5um
	VkwAoLNqrg4YDeIi2GcLk+Enxhx0gRpKbd4YIKT3Lf/bu2B+/UBFkxi1pFNwNgvNQR0IAlLwSMa
	2e5nfYKIPMJ9J3zVOygvGtp3QqYNmxJWDLSty3U1EeQKQrMvySE/CNc7fAaWGVrvKexu6CrKQXx
	hg2Bb5wekEuTtYkcdPpq6uLN1ar/POpT67Fo2o1S8Ap+71m5bOHyv2J2foKTGWlmcbLwjTHpExs
	wb4Vm8PwgGCPYzC6W8RZQRFDT2xwSrzx8vFsGXsWUgqHXwE46GCDHNi8=
X-Received: by 2002:a05:6a20:72a3:b0:3a2:f14a:4290 with SMTP id adf61e73a8af0-3afb002d051mr4704736637.38.1778697620180;
        Wed, 13 May 2026 11:40:20 -0700 (PDT)
X-Received: by 2002:a05:6a20:72a3:b0:3a2:f14a:4290 with SMTP id adf61e73a8af0-3afb002d051mr4704707637.38.1778697619700;
        Wed, 13 May 2026 11:40:19 -0700 (PDT)
Received: from hu-kuldsing-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c826771a8a1sm15271009a12.24.2026.05.13.11.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 11:40:19 -0700 (PDT)
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Subject: [PATCH 0/3] Add support for qcrypto in kaanapali
Date: Thu, 14 May 2026 00:10:02 +0530
Message-Id: <20260514-knp_qce-v1-0-0ebdac98e50c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAILFBGoC/yXM4QpAMBSG4VvR+W11bFLciiTmjEMNG1Jy74afT
 73fd4Enx+ShiC5wdLDn2QYkcQR6aGxPgrtgkCgzTGUqJrvUqyaBaPLOKJKocgj14sjw+T2V1W+
 /tyPp7Z3DfT+KaLKAawAAAA==
X-Change-ID: 20260424-knp_qce-00f9df3e2039
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Harshal Dev <harshal.dev@oss.qualcomm.com>,
        Arun Neelakantam <aneelaka@qti.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.1
X-Proofpoint-GUID: i7M46mUHGc5Bvj7879X-3RGCqi3CtycC
X-Proofpoint-ORIG-GUID: i7M46mUHGc5Bvj7879X-3RGCqi3CtycC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE4NCBTYWx0ZWRfX5dwAucQNCxjA
 n2ljR0PoQBDcBhVWEVKPSY8NOmvXXyqbRaufRV3VA9N3zCxTMy7i0/iMfsiTblKqDI70SXwP/lQ
 DOGeJ3i1jN+05FhS2yfUA3BuKbT/0thrToClU26JHa4ozEl2Eu8mQ+yY90pSV3nipnO6G6Ci6qO
 qNv1Hiv/5vsFs/f0jhov8C8gAUfoolL+8gTDxHS9y4HlvqxYzA28eOQ2c4zwbK7C0h1HFiFHgzX
 ESddx/fWmc48p7cHzcTQEfvoWM7aDd0zI97meoxK6Cbc9AWHffWyMboQgLUTmEW00QTgh0G/wAV
 UwbWgo8homO6e+rPAsFQT1fuQ8Um2/Rwffq9ZL+3UogCSj3XIOhbuAM3RvIhMDc49sp0KVhTyip
 1YFdAhSmHgJJeW9e7Nz8E5kMPYiYbMTRPe8ItA4lQdfMNov/SLNCn1hccoR9hWvechu/XdkzUoA
 cfGYUAV2lgA11FTI1DQ==
X-Authority-Analysis: v=2.4 cv=Iu0utr/g c=1 sm=1 tr=0 ts=6a04c595 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=hpg_QQ1ef3WCVlx-FDkA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 adultscore=0 impostorscore=0
 bulkscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130184
X-Rspamd-Queue-Id: 2A4005392D8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10426-lists,dmaengine=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuldeep.singh@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Add qcrypto and cryptobam DT nodes for enabling qcrypto on kaanapali.
Validations:
- make ARCH=arm64 DT_CHECKER_FLAGS=-m DT_SCHEMA_FILES=Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml dt_binding_check
- make ARCH=arm64 qcom/kaanapali-mtp.dtb CHECK_DTBS=1 DT_SCHEMA_FILES=Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
- cryptobam and crypto driver probe
- kcapi test

Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
---
Changes in v2:
- Update commit message for patch 1/3 as suggested by Krzysztof.
- Collect reviewed-by tags.
- Link to v1: https://lore.kernel.org/linux-arm-msm/20260424-knp_qce-v1-0-813e18f8f355@oss.qualcomm.com

---
Kuldeep Singh (3):
      dt-bindings: dma: qcom,bam-dma: Document BAM v2.0.0 compatible
      dmaengine: qcom: bam_dma: Add support for BAM v2.0.0
      arm64: dts: qcom: kaanapali: Add qcrypto node support

 .../devicetree/bindings/dma/qcom,bam-dma.yaml      | 21 +++++++++++++++
 arch/arm64/boot/dts/qcom/kaanapali.dtsi            | 25 ++++++++++++++++++
 drivers/dma/qcom/bam_dma.c                         | 30 ++++++++++++++++++++++
 3 files changed, 76 insertions(+)
---
base-commit: 4c406406070d57dbefeaad149181785330c23f92
change-id: 20260424-knp_qce-00f9df3e2039

Best regards,
--  
Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>


