Return-Path: <dmaengine+bounces-10432-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Di5HbLIBGodOgIAu9opvQ
	(envelope-from <dmaengine+bounces-10432-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 20:53:38 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3924F539583
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 20:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 16E57302CBF4
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 18:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5B53AEF34;
	Wed, 13 May 2026 18:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I7oDIk4c";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aZqYxCre"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C773E3ACA71
	for <dmaengine@vger.kernel.org>; Wed, 13 May 2026 18:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778698373; cv=none; b=fhIEQqCP3GBXekSZoyKdo1HNX2N3Mqt/mw8ByJPnxriOig/Oz0WfmeKhrqzSRSFtr01nh8LJFtMXMfTfxw0HF1zpDpTjqQg0O5OGiiKZuamgnHk8rqJKCHyG5FQqjLdFnntbdC3tuLYs7mmljRPB4N5IVO8sa7PbmdPt2EUqp6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778698373; c=relaxed/simple;
	bh=9Gkee+QP2+V4ReA/loQuXxXG0CE57ytfvEg2Yf6qXv8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aq82c9axbaZLdofKZQrEIQ4IMRgJ19OSblfs7DosPATbYGoln1sVJ4qZvfe3ga4aeqtF4b61hELhEKSwrCquj9TlXbpKDEkW2+vYG1u7u5ivIAd4/KIPXLJaX4j+CBaeHGMUIe3mO0cgOwPDlPeMIXwmlqSqS9YBKz8b0YYj5Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I7oDIk4c; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aZqYxCre; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64DGvEJZ3997611
	for <dmaengine@vger.kernel.org>; Wed, 13 May 2026 18:52:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+QszlMTZItoe5FUvSv42KsYrYRjBIOCJwkVqRW4SyTA=; b=I7oDIk4cPbo9t8i/
	3ZXIU3L2PWuhdzgYSUqbKiddfDNZdYigOL/idUBKA7aKfeucZlIXbamu52srRVtD
	DyHrUzZMqhmo2DGiEP7umvO4JN1+Fgrfd4D0Gwkdevgw8APOCVjlYJ3F3SJRQCaz
	qN9L7FiZygrCmyfFimWmic4XOljid4ikdcFtCvonYCyhgkvbZQE+Yr9mfoYa2x0a
	CLp1e5CGbIrknsuI1ex8e6G/jpef5VlLq988r82OZKwBjZ5mLEMwjysVsLQFBxkO
	fnsNAyUbtsgb7IKO6k0ynWyN1W5ecGE7ZWq1BsJOE7aK4drmH4RKbiBLYOhE8k/a
	A0nIdg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4w8urgjd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Wed, 13 May 2026 18:52:50 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-367bb9caa54so6232403a91.2
        for <dmaengine@vger.kernel.org>; Wed, 13 May 2026 11:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778698369; x=1779303169; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+QszlMTZItoe5FUvSv42KsYrYRjBIOCJwkVqRW4SyTA=;
        b=aZqYxCreq/0OqaCq11knMntZnol/JyxcEI33iGgmWN5/Yq/C+FnK1Hv3kmcvx77kCs
         0Vv++hrDoAz15REiDNHyyYubjusTH7IF7ZCz8pODAJoA6Pza6QRuD9v/yaIFJ5t7OmLF
         PBXHvdC1jn1rnRYrHteuUZOZcKtScXKvH7ed78b5Dr5TTVVyTRmdB+Rv3NRbX4TLm1iy
         YnUVArfMQDfjORBVrOBcfuvVMJ3TIAjbLI2Wm5gffdLG/gndIBdrvIkh+/5/OG5SfvZe
         41jazeRxl+/Ka472Im/NtfNDH/oGzBEsi9hoq/hwdI4M7EtLdS4XT9UVvyMKQZt5D2+A
         Wi3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778698369; x=1779303169;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+QszlMTZItoe5FUvSv42KsYrYRjBIOCJwkVqRW4SyTA=;
        b=ipUMfD9HvWSRO7VOKQIlWRxu6eNs8xAiqKAUsWG6/j1/+3N+RSPXO/hPHPnv2sijfM
         VLDOweP7nH+RkPuElyCktf4emRA/HqAzMVx7kQ3ncj1s6tO+A8HuzSuhWBvtddu4iTTq
         PyGBLCx5L93UswZlhpuc//HxHoOKvH9J4wtj1nNSJXxc9h6LCM9+j0GQ4g/LN1Q/3MwC
         6T3fNHEuYGTVE4y9w4xyHf3sxOKvgE/i18q4aPgjvpCZi8RpY4SGr+ZzR6gKzxp1lgQm
         PiY7XRN4y8bxTxdPExCzHAawLMzOILhq3W9H7sz0OOlq7ujO0c+SKPCptVw/ghsP2yQL
         2alw==
X-Forwarded-Encrypted: i=1; AFNElJ/jKWKm2McXVOx1cdF74uP8Pqfo5vZACt6qRlq2sV4lhGLPkYzkEkauK3FuIcIbITmFq9BDdsSIsws=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHBD/uF1L1xJkMewJDHwYpamy0TiaajHifFMH+DA+24gzk1JOr
	yon/NFw7SeN+XMTgFfOv45YwZx6EvfZlLCG9zDkkRvI6Rd1ublN1NmmSzSl64PoU6TEHMq2erJ2
	VlTSnIxgZJEkOEPzcFSBJr7y/O7fV6zJr8ayTeZkpA5EC2hjPBJ6+FiOUbrXySNE=
X-Gm-Gg: Acq92OFxg7IX2JzG6nYoDZZfCbxBMMTsq5qUnYRFZBjoCtTcwVXDvVPjueKQbFgmLUU
	RPPdAMAzQsK5UNTK6wrHBQy0UPfYX+4OSpcr1Rq4sEuU5EmUKa9csLAdvr444KgrRtwOcQpzDWP
	gIapX+TXDOpzZaDLFEt4O6N75tkhQZclJaCrdG1oTAjOyu1G+tw29uURHfp2JAhx0eMCEAgnrL/
	pOEDaajnKfOPRTFu5kyNt/L0EnIAgzpyDeRTur3NV4a4Sv6JuKWGWafZ3ktbuls7Cl624wwd6w0
	ZFtyhFbOId4/CUBaVenVbnS/Ckrcw8OLd4FJNnkFiedzvkEGlcCQaZlIECIxXYcAVgbJhnvGBh9
	LtVhS79DMHUXwfHs1b4mqL10G4GjEpQA19pAIDUzYffMinoNs0hRU41E=
X-Received: by 2002:a17:90b:3a46:b0:367:b9ed:dec4 with SMTP id 98e67ed59e1d1-368f3e7c1acmr5328848a91.27.1778698369484;
        Wed, 13 May 2026 11:52:49 -0700 (PDT)
X-Received: by 2002:a17:90b:3a46:b0:367:b9ed:dec4 with SMTP id 98e67ed59e1d1-368f3e7c1acmr5328831a91.27.1778698368955;
        Wed, 13 May 2026 11:52:48 -0700 (PDT)
Received: from hu-kuldsing-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-368ee626a04sm3660219a91.14.2026.05.13.11.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 11:52:48 -0700 (PDT)
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Date: Thu, 14 May 2026 00:22:21 +0530
Subject: [PATCH v2 2/3] dmaengine: qcom: bam_dma: Add support for BAM
 v2.0.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-knp_qce-v2-2-890e3372eef8@oss.qualcomm.com>
References: <20260514-knp_qce-v2-0-890e3372eef8@oss.qualcomm.com>
In-Reply-To: <20260514-knp_qce-v2-0-890e3372eef8@oss.qualcomm.com>
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
        Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
X-Mailer: b4 0.15.1
X-Authority-Analysis: v=2.4 cv=WP1PmHsR c=1 sm=1 tr=0 ts=6a04c882 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=RYeHZzZGa2Tlkre8v9EA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: Sm983jFPLJke5y1ICodSPSvvvIPfqw-N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE4NiBTYWx0ZWRfXzy6lLc+ev6r1
 s1qVHx72dCEr0R0lp09K7tf9BkuWV0FDrO7ebWPt7pkqk37jO6xc+Be/4Nq+u7gMaVhMZ76EqUM
 3tU4x1np8LyGQbiV1CjkZpz2/9YjM/svueeCzl/CnmDiFOBYNfyvn0XFiVC7OZHLzGlW4bknabr
 EyCW1NkJTJS2AN/S3nz0r6/RetVdCtJS+kmYFld6l2gVV71p4r2XsIp9jGanSWHgK2bWz4tCbae
 E7UDe1hQx/cD9jKr9HEhtlpe6TtTa9/DzNOOy5IiGjzLSTegLj4ad9X0CPOo+6HBXcQN30zmqLL
 Ei/KyPYd2rBJYMpFBYFW6P2f+HDEnAUCKwQi2ZOjLnVdUMe5fRB87wEZ8ZwuYhWig7hyTl4E4Qg
 D8VnLgxbek945S6HF2ZBengYiCcCtSiUfgyk9lrCKXDp336VGVUf/2j4uoCdGR9hPoAYmmOrFvZ
 S97PMeXxSb4Cai3CEug==
X-Proofpoint-ORIG-GUID: Sm983jFPLJke5y1ICodSPSvvvIPfqw-N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 bulkscore=0 spamscore=0 impostorscore=0 suspectscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605130186
X-Rspamd-Queue-Id: 3924F539583
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10432-lists,dmaengine=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuldeep.singh@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Add register offset table entry for bam v2.0.0 version found on
kaanapali.

Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
---
 drivers/dma/qcom/bam_dma.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index 19116295f832..1bb26af0405f 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -199,6 +199,35 @@ static const struct reg_offset_data bam_v1_7_reg_info[] = {
 	[BAM_P_FIFO_SIZES]	= { 0x13820, 0x00, 0x1000, 0x00 },
 };
 
+static const struct reg_offset_data bam_v2_0_reg_info[] = {
+	[BAM_CTRL]		= { 0x0000, 0x00, 0x00, 0x00 },
+	[BAM_REVISION]		= { 0x1000, 0x00, 0x00, 0x00 },
+	[BAM_NUM_PIPES]		= { 0x1008, 0x00, 0x00, 0x00 },
+	[BAM_DESC_CNT_TRSHLD]	= { 0x0008, 0x00, 0x00, 0x00 },
+	[BAM_IRQ_SRCS]		= { 0x3010, 0x00, 0x00, 0x00 },
+	[BAM_IRQ_SRCS_MSK]	= { 0x3014, 0x00, 0x00, 0x00 },
+	[BAM_IRQ_SRCS_UNMASKED]	= { 0x3018, 0x00, 0x00, 0x00 },
+	[BAM_IRQ_STTS]		= { 0x0014, 0x00, 0x00, 0x00 },
+	[BAM_IRQ_CLR]		= { 0x0018, 0x00, 0x00, 0x00 },
+	[BAM_IRQ_EN]		= { 0x001C, 0x00, 0x00, 0x00 },
+	[BAM_CNFG_BITS]		= { 0x007C, 0x00, 0x00, 0x00 },
+	[BAM_IRQ_SRCS_EE]	= { 0x3000, 0x00, 0x00, 0x1000 },
+	[BAM_IRQ_SRCS_MSK_EE]	= { 0x3004, 0x00, 0x00, 0x1000 },
+	[BAM_P_CTRL]		= { 0xC000, 0x1000, 0x00, 0x00 },
+	[BAM_P_RST]		= { 0xC004, 0x1000, 0x00, 0x00 },
+	[BAM_P_HALT]		= { 0xC008, 0x1000, 0x00, 0x00 },
+	[BAM_P_IRQ_STTS]	= { 0xC010, 0x1000, 0x00, 0x00 },
+	[BAM_P_IRQ_CLR]		= { 0xC014, 0x1000, 0x00, 0x00 },
+	[BAM_P_IRQ_EN]		= { 0xC018, 0x1000, 0x00, 0x00 },
+	[BAM_P_EVNT_DEST_ADDR]	= { 0xC82C, 0x00, 0x1000, 0x00 },
+	[BAM_P_EVNT_REG]	= { 0xC818, 0x00, 0x1000, 0x00 },
+	[BAM_P_SW_OFSTS]	= { 0xC800, 0x00, 0x1000, 0x00 },
+	[BAM_P_DATA_FIFO_ADDR]	= { 0xC824, 0x00, 0x1000, 0x00 },
+	[BAM_P_DESC_FIFO_ADDR]	= { 0xC81C, 0x00, 0x1000, 0x00 },
+	[BAM_P_EVNT_GEN_TRSHLD]	= { 0xC828, 0x00, 0x1000, 0x00 },
+	[BAM_P_FIFO_SIZES]	= { 0xC820, 0x00, 0x1000, 0x00 },
+};
+
 /* BAM CTRL */
 #define BAM_SW_RST			BIT(0)
 #define BAM_EN				BIT(1)
@@ -1208,6 +1237,7 @@ static const struct of_device_id bam_of_match[] = {
 	{ .compatible = "qcom,bam-v1.3.0", .data = &bam_v1_3_reg_info },
 	{ .compatible = "qcom,bam-v1.4.0", .data = &bam_v1_4_reg_info },
 	{ .compatible = "qcom,bam-v1.7.0", .data = &bam_v1_7_reg_info },
+	{ .compatible = "qcom,bam-v2.0.0", .data = &bam_v2_0_reg_info },
 	{}
 };
 

-- 
2.34.1


