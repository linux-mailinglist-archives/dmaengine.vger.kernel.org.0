Return-Path: <dmaengine+bounces-10430-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDIzG4nIBGodOgIAu9opvQ
	(envelope-from <dmaengine+bounces-10430-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 20:52:57 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 15286539523
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 20:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 65DFF300B195
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 18:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71C13ACF18;
	Wed, 13 May 2026 18:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CQ6Fxbs1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YYQkq9KC"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D3C3F4112
	for <dmaengine@vger.kernel.org>; Wed, 13 May 2026 18:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778698362; cv=none; b=RQW4AUdF40Hn/ozy0Ans1mxx8XiyQ5GKFtfXTDthnDSZp+e1tqPVf9/hwhH4hnmanlGW4/05kJ9B2kX33rKYqpmfbsYqksz2X/G6/Ni0GCx2jHSFkKTsDPnaaQTDn4/5UZF7AP34rWZmelsZeyWmzV2aERojDuZWTDNFiUi9dX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778698362; c=relaxed/simple;
	bh=i2kboZU5dt/R+5mvW/st3FZKJQa6BawWFhBJ4V/bm/Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YiwPxbyoxXrepxXOV7Xy7suc0+Spxzlki2+eHpvG5lt+ebIhYrLaaCroIF5WXoaJhRqDWZ1pdka2RVJt2cfWbQAhoupIjyF/aQCE8YpYOVT/BvJuafbeGmmYyUOdNWk3TJdBVIDlZq86o/cJ1Qv+W4DByDHcQaLpqr+a0FsuIAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CQ6Fxbs1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YYQkq9KC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64DGAvY72524346
	for <dmaengine@vger.kernel.org>; Wed, 13 May 2026 18:52:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=WHOT/4paRhmqMIJlArz9f+
	jJSRMrFl3T1rv/TsK5ZY4=; b=CQ6Fxbs1SOJNNwC2TdOMReCMGAi1Hq/eUG829Q
	XjuFbYSX6oCCtbNkONJvK8oHwn6aUPca+nh4hapXU941hb8ni5NpCSLozKyx+fb0
	sBq7LirrJ3VKSWqHUlBG5rlC2pKD08cW+6SekcJUT45h/3pQEfnMNboIbvV2BOwm
	Ms2J4I9GcYKbjxgkOqKZDgT7FaoX80XE6GJCQyk7FEQgfVOVYcJs2qFZfl6XR6qk
	17dPF/EjeHSEtPSir9Zi0PImglHh/BPSP7lCGNIbLb/SqHTaJeDWtYGPFCV5D8/6
	VqiE9v+IpIwKkBoDEq1F9t+AWA3eN469VRQtQXJcjWoTvcsA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4vkjgptn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Wed, 13 May 2026 18:52:40 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-369166fe5e3so585001a91.3
        for <dmaengine@vger.kernel.org>; Wed, 13 May 2026 11:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778698359; x=1779303159; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WHOT/4paRhmqMIJlArz9f+jJSRMrFl3T1rv/TsK5ZY4=;
        b=YYQkq9KCkWcRfI8r3xzbDLYMMX806yN5FxVaOoLRkV20WdWhDbnq3DVfBxS8HaZOET
         B7Kd0ukEpgYURWDjHPA6s4NqYrK8wAjBqw8RlzmFgQfyVM9YLiVi4eE0rScsxrVnmhdW
         BOkjAcBMCCcY++vNoEdefPfmDE1Cwwr4PW9Befcb42Hab0i8QD4EHwJ5N/Nyrj2qgEom
         qvXN0TNoKDb/YEhxBZ6X0CeCCY16vvXJWGxrTAOc8IX/DQxQNC15Inj7mqcuQ9yphfln
         6KLYsBKHKg1HwQIOC+Vc+X100glcQpXycKBdrvfXpmNr3U7slOnWB4rleljrrxDFJkVS
         wHfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778698359; x=1779303159;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WHOT/4paRhmqMIJlArz9f+jJSRMrFl3T1rv/TsK5ZY4=;
        b=QtkE4AwXC4Ao9JePb9DjPo0PhrG0j3d6h4a0fv77Cdc9gt89q/Zd/a3HhnlSLWCnKu
         L662b+IzlJtg1y+N2lwul6SnT+Wqw37p5o2mXqGCC+b2gjkb1bliZGrKmeogeIaHV5T0
         RuGWtpiKhFmwM9HDEvXA3fW40HhJpJvcdTMpOSpWfLZ9NiN6BHZlXNDRoD+6ARJt0zlj
         XqIO03cJMJqBzQzQQ4Vk5ApLMGsKoFLzrXMEoB4eWgdKMmSyARJ+E7PtttetDWsbGbuU
         N+PilVN5LIkFDZAYsWVDRkFy6T1X8enyNq4swp3ZXMuvO1E1vEBxyJpP058lybF4yrso
         A41w==
X-Forwarded-Encrypted: i=1; AFNElJ91rvHYAkSRANCNd2aYqojj2XJnJmko7lRpCCrY+vYhI9h/xYSUMv++D0iE2XeoQaRLZrYR+2w71zg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM1kYudhlT37maAVyeSw6SJExQTmU5Bwd0m/qSwRAxM2VNxILj
	4QJPWeL1jcWC30xgbHp5y4d0JPa1jFnkNPkd9lRBtv+6eVeb84TAw/YojGNWuv5LdqOu+0Uw6Wj
	k8xyBOMhx+CJ6sRQmqp0vO5a/NUjokl0qfRx00dAiQ8XxZdcPT5WtkwesuATcxuQ=
X-Gm-Gg: Acq92OGcXsk0Lu/EI6FEJHJuQWFWKxX+ufyaD/a/8wfhRrZ/fjKmVFPTjrpeE03+Z1J
	PZMnIxfOJY8pRPvZLOy34KBItrM1SjGPRS+riw4HGSH8tBBSX4lb2/wQblYtBoxH8DNlPKRefdj
	Fjtdr7WLbunKZoNAjtLUGO5mweSXv+CAYBOvT60rSYzOMM08AGHRJSdiBdHAJ4YX2b0p4jiO3uF
	cz8SFTnTP30vUmlGLiLRcEq4EcQM6RfknLAaoWjBUSKHJ7TSEgfTv5JDUVe4qRgZmTdKLf4ifJk
	ENIwbyZ0fXlpKtR2wunrYvK6WKQqI5ElaHhYRTIDV5UbSUwbk/caVNHwHhe1hlBaM3QCZTSR4BN
	e5fuHuXsjyxHvdpdssoffkjIR6YzeV/c95Fz2LQipziUOhkXqV8MTwNg=
X-Received: by 2002:a17:90b:5883:b0:368:f0a:1c48 with SMTP id 98e67ed59e1d1-368f2dcd468mr4923179a91.0.1778698359186;
        Wed, 13 May 2026 11:52:39 -0700 (PDT)
X-Received: by 2002:a17:90b:5883:b0:368:f0a:1c48 with SMTP id 98e67ed59e1d1-368f2dcd468mr4923156a91.0.1778698358696;
        Wed, 13 May 2026 11:52:38 -0700 (PDT)
Received: from hu-kuldsing-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-368ee626a04sm3660219a91.14.2026.05.13.11.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 11:52:38 -0700 (PDT)
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Subject: [PATCH v2 0/3] Add support for qcrypto in kaanapali
Date: Thu, 14 May 2026 00:22:19 +0530
Message-Id: <20260514-knp_qce-v2-0-890e3372eef8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGPIBGoC/0WNQQ6CMBBFr0JmbclQwIgr7mGIgXaQqlDoANEQ7
 m6BhZtJXvL+mwWYnCGGa7CAo9mwsZ0HeQpANWX3IGG0Z5Aoz5jIRLy6/j4oEoh1puuYJMYZeLt
 3VJvPXroVB/NUPUmN23wzGsOjdd/91Rxt3lFNo391jgQKpEqXKrtQiiq3zOEwlW9l2zb0B4p1X
 X8S9cCMtwAAAA==
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
X-Proofpoint-GUID: DWyL2b13ta2bLkiCZBcyD44FWG-QEf6X
X-Proofpoint-ORIG-GUID: DWyL2b13ta2bLkiCZBcyD44FWG-QEf6X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE4NiBTYWx0ZWRfX3BOyEvu0VSF7
 N+5yboCDEFa66nEMWsNg5b65ShW73OVg8apP+DQ5bxTqQavvAhlOJvIV006u94vG/BMXDSrOBXk
 +CegWgwl8K7NwOmkmNY4SOSCUP3taECRkbce3JCfz+gYy9X3ZkZZA05E2qz95EsWaWFcI8cHcox
 auxM3/hY9MFEFtOCCdRtwlPF3WVs/q0u21zDXCVPI0qsSAyhURwj9Nl0XbaHLCNHzbLViwAMLI9
 PKXGDkDqIOuVFU5CfHR6BEes8E+Spk0gwWu7W8Qwzt8Qz1miPf7p5QHjatFAZ+y1W3vbGD7CJlu
 Ct61ia3SIPD5pSGADIEXXcX0cNy69477ybx5jmHNIqBtlezZQ7oQFgQWdrKHz9sTDaWH+U6Ct8o
 qnBOVZDS5IiYSv6+T36iLK3pKhZrHlPSYD6zNpFLTvys4qRXdgZHviC5/hdZM7TSw2UTX9h4v8r
 taHEpuVrbwkrh13vb7Q==
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a04c878 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=hpg_QQ1ef3WCVlx-FDkA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 malwarescore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605130186
X-Rspamd-Queue-Id: 15286539523
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
	TAGGED_FROM(0.00)[bounces-10430-lists,dmaengine=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
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
- Rebase to latest linux-next/master.
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


