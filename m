Return-Path: <dmaengine+bounces-10107-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJ43DnVV62mmLQAAu9opvQ
	(envelope-from <dmaengine+bounces-10107-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 24 Apr 2026 13:35:17 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D59FE45DC5B
	for <lists+dmaengine@lfdr.de>; Fri, 24 Apr 2026 13:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7A3353019CAA
	for <lists+dmaengine@lfdr.de>; Fri, 24 Apr 2026 11:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16AD73BAD82;
	Fri, 24 Apr 2026 11:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZAr/WtJ9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JgprYFTg"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1553264CC
	for <dmaengine@vger.kernel.org>; Fri, 24 Apr 2026 11:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777030497; cv=none; b=sJTMu8eCiA+qerW4IsSQGy+7TZ5TPWTJSmkge6EwZSlO8i0GiDYBArbttsKNSB3DCBwvuf7YkyuFrxtlGaNpbjceq9rkN0eY6eGmVnKe1UP3K2j85A5n34c4+16xGxhxuvcjoQVppbdkTCBDo3oicLEE1FCmNV8XigU/U4KP+cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777030497; c=relaxed/simple;
	bh=pV/xWBmtxbC5Bjs1MVGttr+VN/mHay4tmnTxfAeRJiQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fV2YcE9ZKsGyFPSSUHynYljv8sVjNdvd1pN/ozfCBIEQLbDM8Mo8z4RvYre0DJ0WCsF5S/2GX4IzF/2vICcoXbhKmu85ZL8mpUYXExPSxOS50BtNkG8ciYDDcl0GTJXj9SLJIbJvKGvTDY1exUE7rizShH13R2OnYqAjWD1Z+LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZAr/WtJ9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JgprYFTg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63O7HhnH1888411
	for <dmaengine@vger.kernel.org>; Fri, 24 Apr 2026 11:34:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Q0z4uO9nAxPTmzYAcglDOc
	jQVHzgrGVGDZ4MAZW9Blk=; b=ZAr/WtJ9+XQucsALWcM3xW170HQtCc7/wqku5W
	tOvQi+dZfDc1s5vkkBw+yZnaDc7IPjDrE829O0WAaXQ3CGXuJjVTHcNJOO6m5Lk3
	ZJ5H25t4G00HjXJVHO06zFYrw6x7J2KSwOU837KnODJnnTIg66eHHJp05YHfjKQB
	ShVKakHeALaqiHBkVvR4NA2256rqmlal8djklLsYk+6XXAqYhnrZ39MXKYGKTTmg
	ZlYTOEJdPOLx771F2ZX3x+lAO/6rPbb95D92k2wDjqkPFzI6pdL6Jsql+l+K+Ehs
	4RrHFd64KOmBTV/lIQUrN+oIul25b0wgtCT3r85WS8v4jdmg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dqp9dvcnj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Fri, 24 Apr 2026 11:34:52 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-362eb03240bso643271a91.3
        for <dmaengine@vger.kernel.org>; Fri, 24 Apr 2026 04:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777030491; x=1777635291; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q0z4uO9nAxPTmzYAcglDOcjQVHzgrGVGDZ4MAZW9Blk=;
        b=JgprYFTgZ4Yhb291MUXP13Ldl4ehsylH2j+Cy3lT5slkFCZYc5oCFfUuQs9zrUZ8G9
         P+m+4xbRhljbFOrgI76wpRvc3GYq+CQcCU9o0fzUIooauv9vwHcAPz5Tm1cLfdPv2Wab
         dd54e+6NK0viXikKkD06W0hTNbnDrzWaY4/tuS/gTi0l0m7CFC8eBGX9kDDg9uQ2J/zB
         CP6TrZRiV8kUjgKTe6BMWKHQsPyFv6wkXtx0DIl1TpwZlxDYbfN1AZ1oJ9kylrq++p+B
         4EIPcZoMQYcpefYEKMNukb8WrZnr0wJRJM8OkDcg6Fpgrpv6IYu1/WiL+KvKyVcmjfmm
         V4pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777030491; x=1777635291;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q0z4uO9nAxPTmzYAcglDOcjQVHzgrGVGDZ4MAZW9Blk=;
        b=jpWdgF8reUiX92epcI8zhgDG7Yd3cwL9X4LzPry6zM2XSzP5svDcjKXi2R9IyzoS9g
         9dr5Ys3/ZOmOulSEYj+H7PMyEFTnQ8b1ranqOkGrA9QPSk+2hUA+s5kSi10PK6fCydUb
         IWW0p0Wud7OtdHeISwruV/XW2hTO9J4f3Anbfx9yQaI1vm726sVd0eXnczTPwN9GGggI
         jhvfXAz1pFuqCM2VcY6+3HWQFP52+uSau3H12AmVB7VPeRtYyttjKbmee+x+9nruqcFW
         VM35QMxfjzJVOIV0E3vgM7ehute4m1qmCbAovZyDPuG+jRAUp+ulu9wTEKx1cIATZetk
         8V6g==
X-Forwarded-Encrypted: i=1; AFNElJ+JJ8grAILG83dcZLO7Ld40MWlwXlkQIMTV0M3q7kiBA05OwpngBcSnt2GghBtZnV6op/mm6EfYEqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YziScpr8y/UcL524mOWDMnPlaDrbb4IhD9vXWJinqPDxqrrWGM7
	kW3poPYzYc38F89oTq3ZH21+n7U5HUNGRknwlWcN80oRXjRnfdBPdm+xQYKB0rtgBJxhe1NGGzx
	pMfWH+DjS4C7kA99MEld3XHlykrb/1WpPimeI5WenRakC0X6JFOEQBkiSdH45BQuH4G03y9E=
X-Gm-Gg: AeBDiesK0KgCZWvozXHbP9vwJ+YnUxUu/OYquyHw+/UG0+x3KnqGxWITQhIYtEzO63w
	ptq0Q32znrx3eVwGHP4tenYt/AXXHjEmGqqvMs3CIb5Q3APwkWxO63LmRNWZnnO8cdYIveQAFWx
	+5WaPvMj0n/8cxv85nD2RwILMt9L6+hzLu4P6P3erYnPnIF/BOC3hqPB1OAqY5+dcjIQ+qheMj0
	PiekstdSN8FDpq0DjrfNmCg9m7UdUcUcd+zdDu7+z+nDe85SGA2H3iyVsPgbhHo7F6/0UjV0/Vn
	vLTZlvGTFKfWQH2IyZOowRZqxVxOcVl7lFCbL6ISoHFWMYPIolwKtlpzj+VVoEYYHvyRqkMIK5I
	/Nm/rp70g+lXZDDZC8GWJ1OVBovyYkTq71TOtNtTaPZ76WCytfE82XnUKd1Z6GTpYEg==
X-Received: by 2002:a17:90a:74f:b0:361:4720:af84 with SMTP id 98e67ed59e1d1-3614720b0e4mr20437847a91.20.1777030491150;
        Fri, 24 Apr 2026 04:34:51 -0700 (PDT)
X-Received: by 2002:a17:90a:74f:b0:361:4720:af84 with SMTP id 98e67ed59e1d1-3614720b0e4mr20437811a91.20.1777030490665;
        Fri, 24 Apr 2026 04:34:50 -0700 (PDT)
Received: from hu-kuldsing-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3614186adddsm24204734a91.2.2026.04.24.04.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 04:34:50 -0700 (PDT)
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Subject: [PATCH 0/3] Add support for qcrypto in kaanapali
Date: Fri, 24 Apr 2026 17:04:14 +0530
Message-Id: <20260424-knp_qce-v1-0-813e18f8f355@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADZV62kC/yXM4QpAMBSG4VvR+W11bFLciiTmjEMNG1Jy74afT
 73fd4Enx+ShiC5wdLDn2QYkcQR6aGxPgrtgkCgzTGUqJrvUqyaBaPLOKJKocgj14sjw+T2V1W+
 /tyPp7Z3DfT+KaLKAawAAAA==
X-Change-ID: 20260424-knp_qce-00f9df3e2039
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Harshal Dev <harshal.dev@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
X-Mailer: b4 0.15.1
X-Proofpoint-ORIG-GUID: b-YdqJEO2d9bwWR9X-QMG50i0KGpR-uz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDExMCBTYWx0ZWRfX6q6VLU7065l0
 3X9Ah1Q7XerNOxGyvXty+uPuYNuqm0LskDjTX1WIx28N14dyIoXtuXK3NCPpsPI0hz4J+bwWcI+
 ey/C3NxG0yKN0/J3BI1AMv9IJQPcJ20Ws0F4WL10fd/Jr5MlRzfedclwh+WAJ8cwt3OsFkyrBvF
 XKxE4wQnQI5vMMHrIMjwwZAqxuiV4MDaumCuRfgyrBP+/ymnTLwPK8Im6YexVmAr2dmMLX86o2x
 52PK05EiU1tvogDZjUY9BcGmVGacLdt3zRJvqgfjkXQUckd/V3K+PIJHNsul0rO9GRW4L/1DM3d
 XD9LNR7VdlltEvTbZDTGpi1qFLGpqMCHAXZAP9IKFENZbVCS3VAP1NmRX6hmJvej8Pu0pzEKsVw
 Un0RLyBOlTePxcUGf+zbc9qNXDxUScE1Y5EaMm1fzzf+a299hxgP23cll0C82Oq3lc+dPAjk9D2
 JOhQj2HsFumK2fyw1LA==
X-Authority-Analysis: v=2.4 cv=fP4JG5ae c=1 sm=1 tr=0 ts=69eb555c cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=hpg_QQ1ef3WCVlx-FDkA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: b-YdqJEO2d9bwWR9X-QMG50i0KGpR-uz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1011 priorityscore=1501 adultscore=0 suspectscore=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604240110
X-Rspamd-Queue-Id: D59FE45DC5B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-10107-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuldeep.singh@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

Add qcrypto and cryptobam DT nodes for enabling qcrypto on kaanapali.
Validations:
- make ARCH=arm64 DT_CHECKER_FLAGS=-m DT_SCHEMA_FILES=Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml dt_binding_check
- make ARCH=arm64 qcom/kaanapali-mtp.dtb CHECK_DTBS=1 DT_SCHEMA_FILES=Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
- cryptobam and crypto driver probe
- kcapi test

Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
---
Kuldeep Singh (3):
      dt-bindings: dma: qcom: bam-dma: Add support for kaanapali BAM v2.0.0
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


