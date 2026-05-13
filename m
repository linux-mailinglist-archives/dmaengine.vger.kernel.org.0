Return-Path: <dmaengine+bounces-10428-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGOwAY/IBGqnOgIAu9opvQ
	(envelope-from <dmaengine+bounces-10428-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 20:53:03 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 564F753952A
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 20:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0673301F5DE
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 18:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F643AD51C;
	Wed, 13 May 2026 18:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WoXSvpLi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dX0CGrbD"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989F43ACF00
	for <dmaengine@vger.kernel.org>; Wed, 13 May 2026 18:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778697634; cv=none; b=lfChixlxDMPNk5OkIQwCl8gQojyIt4iVQtkkELQk8LuSO73zMI5MxUcejLTRjhJkTj/XMMXdROJBYVGIbFa6FpIdUXVZnvsZcK7wgVhAH06EhWx4iE5nk0WSIohNZkn5ZAi0kpaVYMxRsffd4Z3ZDIlYuWHLzGpdUJnJlxIC4NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778697634; c=relaxed/simple;
	bh=9Gkee+QP2+V4ReA/loQuXxXG0CE57ytfvEg2Yf6qXv8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XiG9PZm6zHopXDdbDEPV+1zNTXhG56Cq5Epp5HNbEJ9kylKea+bQziU/QD1clrKZMQOTjGXPX28l9ltLJMXJ/MsgKflD0bby0GXU+yoq0bV4bFNHJg//HcgVRXwzVo6KGU2wZFy1pcEli1jP+ubMP7NiKk8j6RH2QRiVsDsF/IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WoXSvpLi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dX0CGrbD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64DBqFBB3324658
	for <dmaengine@vger.kernel.org>; Wed, 13 May 2026 18:40:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+QszlMTZItoe5FUvSv42KsYrYRjBIOCJwkVqRW4SyTA=; b=WoXSvpLie+rdms6A
	0VpLLmFqs7mvX7yt9chtzKIQu7i4kg8CFzdCkIIFI2UwwRlP4puzL65A52tBfyIE
	2vBEh77TJIH+b/4Eg5EWaGaxJIw77V+JLo7xj3e5OhU43cc2Zz1wOlbcnQQpygXO
	MxzWk1k5tfr0qqw9ZKIsCoNnE9vnRMVK96q3kmh14kF8ZI+Jz6Z2ENreCdt3pYWT
	olTfZuW4SACGEn+uVygOhkS4GP0IBz9GsPSAeNviQ3KJYiHH/p0lRN2LYEHATH3j
	QyunJUtKCiMcs4hPPAKsbkSGH2dOdBRhwyoBq2mb3CPHX702nC6TFAUWaLaIetTJ
	IQsd2g==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4kvdb0v0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Wed, 13 May 2026 18:40:31 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c802545ae0eso4208004a12.2
        for <dmaengine@vger.kernel.org>; Wed, 13 May 2026 11:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778697630; x=1779302430; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+QszlMTZItoe5FUvSv42KsYrYRjBIOCJwkVqRW4SyTA=;
        b=dX0CGrbDTXxJMER/2yWDZ2HaIDA8uhOdg5Z6a87EU3EHUKZrjdgQS4/GvgszSQRQkm
         tCUfFGlP/hj4ynQpM3AxrJK7JjjtO05SEEVnJhvStjG4525cNFDXU/hSMzOjfbeoKcPK
         aV5nd6zxcPlgobERiy70gMpfPYctKPcQAzqU5hXkpNiCtj7+QrSYjlQjWMk2PStn43nJ
         Xo1Qtz8OKQhyVMBqq80XwQ2dQXISIeKxBUBaSI77NN7v2uE6UtPIAgUFsPLyVHzKuvkx
         mYCbe4MH+9ar8kEovm9Y980YsYxJp4OOm52RuV/MXbW0hw9CopgX6cDRxUh+jXKRWDfT
         ao0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778697630; x=1779302430;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+QszlMTZItoe5FUvSv42KsYrYRjBIOCJwkVqRW4SyTA=;
        b=SO9ex+VfwCrrDfmHLCVprHQKWm5Qo0jRxTNC6tkYYvX7GudmIEXuThCKw/TYJa9+qH
         fqaV59+FiRkSN6vdqK3cXsp37T4BtYZrMamfixIqgSlOoHcQXg8voz1iYEl4fGTPpzEV
         Wg4ibwcPpdRO4wAL5gvSIz5sZDGWyG+6U/NEf33zot+ty2HwKNMQE4BkUJFMV+dgRGCa
         FRg51GlukJuhEGJ7wfycHnrGg5rlsYC8M4l6NDXqD3tSMOEmNwxaBMst/iTHs8cKcZlx
         QWjNujrUIQ/XqceiYvgTraTWCt0sRC40w/TindC2zs7Y7Mv1/+UXf3XE/m8WA+y9T1zm
         T04A==
X-Forwarded-Encrypted: i=1; AFNElJ/1tBA13sh+Z3z69oB5cRKU7ZFdSJFTqY9DM1UWHNcPA/gX5KkzXBi7Ul1mcMSVgJPQ5M9TIHGgv3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPAS2XDEaETyfg+NF8K4FDIhdYMUYUX+zvEqKez+ns/O+lsoQm
	0kDt2PCtiizeH5nnVEleJP+5wPhlKyO7wD8urM9VblPkWusVOsHAyNFJ8Xd26iv3hUiI1/Ka9WU
	t2FD1y7lZIttZe3D8FhuBvK32uuSc4emdPVuNnmRs++5qGJoZ0r1sYVBoTMyoEZc=
X-Gm-Gg: Acq92OENA95b10C69EVHm+GqNeYiiTkNRwX2wvXH4f0qGROwhf/Q9W5SSiHZAoi3YDQ
	w4GUHRR9nyH/XDI3XQ3hDaOe69lubT2o3TB7XGCkFI6Xemre4t2o4fxVP3C2tUBBCs4yqFJTbop
	DTNN+AXhamwidP4x7v5N8aDJaSkpY2qb2NLLS1sQWLTPT6m/QybW6YacSfFJC1dd/pyXl24DFHM
	q52mYWkFiGqoP9HohVQqODzjo6B7xiKGsky8aKoEDJhBaeYjeFHwT/gxsj3nc7EEmM93XxXwMjS
	M5X/cI5frqDciR45baw+CWFyZFYGLww7eVzHDejAsUpAqyFy0V4LpprpYsX5PNehOqwcXPci5Mh
	aYxfmgHGyfXm/NCNJ+hl5QMnWWD3dozxGCwDV5Vra/YcHYByEZIqjB6wuixygIM0yog==
X-Received: by 2002:a05:6a20:7f98:b0:39b:e321:67ea with SMTP id adf61e73a8af0-3af83380189mr5293484637.45.1778697630546;
        Wed, 13 May 2026 11:40:30 -0700 (PDT)
X-Received: by 2002:a05:6a20:7f98:b0:39b:e321:67ea with SMTP id adf61e73a8af0-3af83380189mr5293440637.45.1778697630054;
        Wed, 13 May 2026 11:40:30 -0700 (PDT)
Received: from hu-kuldsing-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c826771a8a1sm15271009a12.24.2026.05.13.11.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 11:40:29 -0700 (PDT)
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Date: Thu, 14 May 2026 00:10:04 +0530
Subject: [PATCH 2/3] dmaengine: qcom: bam_dma: Add support for BAM v2.0.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-knp_qce-v1-2-0ebdac98e50c@oss.qualcomm.com>
References: <20260514-knp_qce-v1-0-0ebdac98e50c@oss.qualcomm.com>
In-Reply-To: <20260514-knp_qce-v1-0-0ebdac98e50c@oss.qualcomm.com>
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
X-Proofpoint-GUID: 1CQ94S8AFeiD2XVbnKV5NrGbuPvEgmoH
X-Proofpoint-ORIG-GUID: 1CQ94S8AFeiD2XVbnKV5NrGbuPvEgmoH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE4NCBTYWx0ZWRfX0oZjFhJO5VAm
 9sZn71s7NhuGDIn4+GSqYiDmXHPp7YnfrtSQI+rSHXwnviX/c/qnDE0eWNhm/4JE2C94O3F8S2m
 HGJC7sM8SqNLEYEudhVt01TaeJNgPjwNkytVSj3AnrLRhDUPPoeJ5YqTxZFx13/vaGXLyBrPA83
 SB37C9id97Ej5YBJT3JYsyIXOwfceslrTI4X/ZevMIsyPsxhOjqPTIbYu1No1FLCO78jNE4w3zq
 7wH0nRGzcMLmdkzsRFq9GGBMS9Ve5hM2YQHnI80mpLvhAEZfhsRLPgQfpyTDhMkl27D8mWErlYW
 uR3/Gif1IFZwYOMKtRFuKdaLNibehwqhKPuMepg15+2PVaFtlNAp0TPbtpAaeaEES6DS3gFKzvY
 yTjOj9JtmGW2wKGYGEFH2HKU4Nirnr/e83COowVHmVBIGlBNrRCu50IRTHH+CeA0fD5fvS/GSbQ
 JAFoOnbHfImTlZOjOKA==
X-Authority-Analysis: v=2.4 cv=Iu0utr/g c=1 sm=1 tr=0 ts=6a04c59f cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=RYeHZzZGa2Tlkre8v9EA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 spamscore=0 adultscore=0 impostorscore=0
 bulkscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130184
X-Rspamd-Queue-Id: 564F753952A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10428-lists,dmaengine=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
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


