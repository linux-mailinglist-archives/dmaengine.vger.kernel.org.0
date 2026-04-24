Return-Path: <dmaengine+bounces-10109-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +P9nHb5V62nkKwAAu9opvQ
	(envelope-from <dmaengine+bounces-10109-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 24 Apr 2026 13:36:30 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E54DF45DCF4
	for <lists+dmaengine@lfdr.de>; Fri, 24 Apr 2026 13:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4DC61302BE3D
	for <lists+dmaengine@lfdr.de>; Fri, 24 Apr 2026 11:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE0D3BD25D;
	Fri, 24 Apr 2026 11:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FxV9bM07";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZwmgZq2G"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB553BBA04
	for <dmaengine@vger.kernel.org>; Fri, 24 Apr 2026 11:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777030508; cv=none; b=uo6UAmDKhac7jwpfctkuM1kzlfpHe5QXtcKKtXPHTVwEU5TkysM03Mk00plAJMPh1imnYwJ7j7KgOjWSyyUkttZE000/kz3f/MvVrqj510q+NhiFA8TaZT4/Mdad3O1sLqAPe6ROxiSiHm/mDRxROBqcSIXH11pIZJUnJe4Xy9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777030508; c=relaxed/simple;
	bh=9Gkee+QP2+V4ReA/loQuXxXG0CE57ytfvEg2Yf6qXv8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H9EsXYDN0my6UksZ+oX/bbp1x5hfN0oM6qoS618z7pIJPeJedqPNt9itS4tDLW9DbHxH7xRLlzS1WHWjob/4nuXm4SPqONYuGOuzvVnwEp97q0SSFdDtyQ6ZNu3Pnypa1TO9dsJs0iLwy7Pj3xNkCQ7akQwqVobjl8K0JCNJOzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FxV9bM07; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZwmgZq2G; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63O9bAo22710107
	for <dmaengine@vger.kernel.org>; Fri, 24 Apr 2026 11:35:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+QszlMTZItoe5FUvSv42KsYrYRjBIOCJwkVqRW4SyTA=; b=FxV9bM07QgXDVZw9
	D0xZG6SfITOrDYHkmAKGf6wbpEhqOxlK3zG3Mto/xVu4Knba8qjbSk4Er323ASsQ
	ZUfJSBA9NUFAlgA/iiFVrUdYtyzBP2kfiqTgSf1p0POPJiCm7WcCFOxgbcCfvgcG
	7b+7HJ7vVL2uaqq6VTPgn0uryfq78+6OPTcmOO8Di6Vz+nld+LXX0vIxblIxIRPC
	POOMMEbohO0PZAVfOHgRW2zKmxO5JTIU2QQWbcGz5k/lcwKWYAuTUp4v0WrS4f03
	64CYRverlYI299rgDjelPjuhxZn8pnA70T7dVmpWKOj0mujfM0O2c50FnUPsW4rU
	rLxgiQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dqqu9uwbv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Fri, 24 Apr 2026 11:35:01 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-354c44bf176so9274835a91.0
        for <dmaengine@vger.kernel.org>; Fri, 24 Apr 2026 04:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777030501; x=1777635301; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+QszlMTZItoe5FUvSv42KsYrYRjBIOCJwkVqRW4SyTA=;
        b=ZwmgZq2GOlzXp5Uus2w+VURbQePwC/EJ1kW6HW+y/71+LRVIoSgHDCNFoPp7zowTAF
         FYsePKHpr5Vs2g4OlRHTtu5xwSrOwwmma5dXKE23St+x86rftTHvg/bXUKb5II94uFQ1
         Z2fcl6J28ZSWnL+21uT2NkrglFgXzcVsBKWDuHoqd0z/wlbvX3NzUWgOYwi3krapBcbe
         59vLOsouw750PPf7Rcc3Evv2hoLfqhHwfIHmvHv9O9TbTjQd8xAU1ccjKUwf4Eu468jn
         1mIldjff473kjYmFAZUQh3qy2oeW7L3jzFeXEmBEXwFmCo5jFl/Dvs1/3OjMdWdsg91C
         LkQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777030501; x=1777635301;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+QszlMTZItoe5FUvSv42KsYrYRjBIOCJwkVqRW4SyTA=;
        b=AsK9sT2WVpbdGiNMu3vp8ScfiTJM8YtnhpPu9EHUGBqRfurEjVePMGYV37g9psnciK
         wondQn6fTdMgClYtYqgnE3SDcr40/HUcu3g9jN3eIMtv4eMUTOM1qdf62pMNzPhMmTQd
         l2C0puBuGf9QWuOBgaLKJ05KYVlcjHtn/YPqXkkTd7YsmZ9ZO/42z5vXJHMkaPD9/LRY
         hSbUvLUi/foju+RPtC9iWpd0QywsFoQzZ9kf7SRqAU+E9cRE+dbsswmtGCbgVPY/kUDS
         Snh0+tOXrKEGoNa46L08oe6jJDqqUYc2AchA6d5JAK3E4Tmo/hocYFO4XSKXieLBbp+u
         xSeg==
X-Forwarded-Encrypted: i=1; AFNElJ+7qzWKbjwEwIgLOhw57dj+NyUiO/CF9IMwFe959KZZIb5PghtzmhZAZUh1qKOfcihi8soZkwcJDxc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL8kJ7SCu55flgIR/p9xV0vhEGGzNUeJIj71soxik+cQL9QNV7
	dJb4p5Z93Gei0CZj++cE2AzSU3VzPRGNJLQg9TR0fqKGN5FvB7c5Mm/EThyFk56lmdMYoK8SkgO
	Nnbh6h44qxthfK2BFA9mrVOQWKvYMlOdvOj6dEJkLprDovucEib4dki12veu0xFU=
X-Gm-Gg: AeBDiev25VX3Z+7x26jpyA+nZdmgwrvIvXNeWtMBzVqQ3pUiLV6xJVn+YZiK5ObMhuI
	1FgkcUtLB9Q7doS961CEsknf75AgmU3Gqi8vJOZk9yCIlyhnahHKOBYBoZ2ag9UFHUvb4Qte4TB
	Fo+tDl4nr3+S/O6kO+9NbKmdJBlMt9W0fa5Emx8SjMzY1Bx9BnY0Wb7X1IKVhIRPIEL41orQeh/
	ncZJuN7lbxkpD/cpRIQE7f/2jtYC0tvx4WnMtiqw9TxQ2jxfpAflop/LxoF2PWKjQxekR+/0e7x
	BPT6VBjqJyDv6ss8HkzmgMVvjH2wjp5a9d6fnW9qVEwmjPbU/T32FWdvRgNpfTI3Xk+Dv/0G+fn
	DRiGGwDeWOHaR4Qq84rVK7OXW4nVtoAt/HxUC+TmBsq9mz3svmQo2z6IPLInUInO14Q==
X-Received: by 2002:a17:90b:5890:b0:35e:5723:85e3 with SMTP id 98e67ed59e1d1-361403f12ddmr32763129a91.9.1777030500616;
        Fri, 24 Apr 2026 04:35:00 -0700 (PDT)
X-Received: by 2002:a17:90b:5890:b0:35e:5723:85e3 with SMTP id 98e67ed59e1d1-361403f12ddmr32763084a91.9.1777030500150;
        Fri, 24 Apr 2026 04:35:00 -0700 (PDT)
Received: from hu-kuldsing-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3614186adddsm24204734a91.2.2026.04.24.04.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 04:34:59 -0700 (PDT)
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Date: Fri, 24 Apr 2026 17:04:16 +0530
Subject: [PATCH 2/3] dmaengine: qcom: bam_dma: Add support for BAM v2.0.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260424-knp_qce-v1-2-813e18f8f355@oss.qualcomm.com>
References: <20260424-knp_qce-v1-0-813e18f8f355@oss.qualcomm.com>
In-Reply-To: <20260424-knp_qce-v1-0-813e18f8f355@oss.qualcomm.com>
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
X-Proofpoint-GUID: 0ccjkn13yHgc6ek4HYwqdPJSzizTzQY3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDExMCBTYWx0ZWRfXzb8+gxIOA/dZ
 SOlnMseq8TJ1FXpjA0wKLbovf3vnvqvfavBnQgp4TXJxRRCNldoJVIjqRF8w/oamLsmM5T2M6wr
 y0ZzUb4WpN94z+qwdfrl35CvhtHzK0ETlwjmnjmqUhGJufOWD4GidqxuqWYYtHqUV8J4UPUnpPK
 rgFvN2SEifbk/fYGJozyJDY8UkOT9VTDMQmZf2C2tMhNNTBWy6ewKivUUUv6V6dGz6Vasc0LFWV
 cA75YWRhjPZf0pSVUWfCUZFj4VgExxCxByY/J3x4bSqQblEozbdZSOa64+qzJl47udWrQfaX+ik
 dhNau/vD/aKfDfmAeAw9Ncrfwtw3hZH6YWs3sdpoCNsSiPFDPKTLwoZwB44MxAYs6vHOd0hc9Su
 Ai+eDU4s4Vp/HGTsod48I1tia4FD232HeLamAchgCtyMyu56PvmdqSQt/rFAWcM6zJEJKhjT0n6
 2Scpo+iNn1qHjGBxE/Q==
X-Proofpoint-ORIG-GUID: 0ccjkn13yHgc6ek4HYwqdPJSzizTzQY3
X-Authority-Analysis: v=2.4 cv=QJNYgALL c=1 sm=1 tr=0 ts=69eb5565 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=RYeHZzZGa2Tlkre8v9EA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0
 impostorscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604240110
X-Rspamd-Queue-Id: E54DF45DCF4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-10109-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuldeep.singh@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

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


