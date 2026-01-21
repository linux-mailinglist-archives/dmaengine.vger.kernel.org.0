Return-Path: <dmaengine+bounces-8425-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHxmHj61cGndZAAAu9opvQ
	(envelope-from <dmaengine+bounces-8425-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 12:15:10 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2195155D44
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 12:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7687452A122
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 11:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA65E3E8C76;
	Wed, 21 Jan 2026 11:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="joYaf2n1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fim8HzB+"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7396B2D8DDD
	for <dmaengine@vger.kernel.org>; Wed, 21 Jan 2026 11:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768993729; cv=none; b=AyzGaQQimDAd4UZlSzBqsPBF8AFd73x6Z3kzzRKzDl6duXNEdn2X5SvNmXx5WX28YUFFd3/W86BVKfXdjzXq9tTCRjBS7l52ZQqvSO/Qgy+xsCPbjG/Lx1I0VsYciucvy3npvb0Na8poxcFVIjKJHIAar1SSdpl2BYxPxJDAkY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768993729; c=relaxed/simple;
	bh=ttuuT4a/yce/hPwLos4F6FaJOgKfFvjfty/guaeo2rU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Sm23+DM8c9Uv3BN7AJYT/hM8p+daBw82BopO/cYtcViqTk3l8+qF+NcAf8ECZfvFbUrLVzTdzSiZEbpVtRfA0VbWlBtpae+0zZX+fSeibOlgDAZl+SccOJMEnVVsQaQN/MI+G597KERnM2LdPDPlNigffNix1/zPiSjrwYfggUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=joYaf2n1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fim8HzB+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60L9fngm3991329
	for <dmaengine@vger.kernel.org>; Wed, 21 Jan 2026 11:08:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=rqxtMdegpYHYw32YRg3oTU8jud9UIt7Jz7U
	y2WsI7vo=; b=joYaf2n1I6RHD6BrSYOOGLveaD/gwN+poHv3cj6vjJXNp1CD4eU
	Fz5TPuiiOv9BGhdvrAzxObJmZRZhGta4G3nvwbcVBxGHuiBHDk3Y42iVvJMFTPKg
	jmtHwtfa92VlolG2BztubCoMYeB9JlyYbaa+86IVLv8IIlAUj+c63WWhXinwYdk3
	LJ/pXQLR4ABnHKzWRzcWiCV0fzQZCzjN9TVuHFnc3wEvg8vtcmhiB3oREm3Q0e96
	69E/quqtP7QiSCzOkwPSr+VHozMAcl3794tTKz6fGwpUkVCUIHdxcYQNNb4fBf+A
	69qH+temF6Q7AZpS6O/CPPlF+vJP54B7Q3Q==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4btpm41vwn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Wed, 21 Jan 2026 11:08:46 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-81e9d0c656fso10802351b3a.0
        for <dmaengine@vger.kernel.org>; Wed, 21 Jan 2026 03:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768993726; x=1769598526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rqxtMdegpYHYw32YRg3oTU8jud9UIt7Jz7Uy2WsI7vo=;
        b=fim8HzB+PjOcVH7E5lxY6sF2+pnmI+qqq/ujOErIka0iwPVnzNhRecI2tu64PIEchg
         2lg1zJS7HhtRfUYtC5ZvKoj1WU9gBqShoRJZf3sNk5TtqG0qdvJAaNazCjf5gF3W/m2h
         fbcSquBCMDXd+E3tDbGz+4ojCaEcCOqu511fHXuAj/jmeG7tFblHD4LMxEl7DwFEtKiK
         Giqdw5H2qchTyAmYglEKOTNCJ0mNbZWHFcNPSiZFlDYc8nHkFtLoNY6oMgefIgXn/bOB
         IJvpMXHqo9LPvMppvfuZnztdFT0MIM4dOHRALD9CZbUOIlhc7Lh75RYY2L1zOlWv0ewo
         OLFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768993726; x=1769598526;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rqxtMdegpYHYw32YRg3oTU8jud9UIt7Jz7Uy2WsI7vo=;
        b=vTMtDGVnVokJFfiPYdvBTmBx0XSXpNjM/X7cbmqid9NEd1duPbAPaN42QcXaz3k4OL
         l9NP+sbwIUMT8MsWOsiJmpoLNqb2V9G3cwO+t/P1DgcwYJAb90iA8L99VhRGJsqsIRsF
         kzE7/SxIPQYwWaCoAMlylYHlZivQry5+c0pPxpCxPKuGXwbUimBkPZxOn8oYvuyMKQ+1
         Kh3dU2ZRdf+ynQi1g8nv5CV55eJrR2zwITj8HkB6mJ7nOeVn9Ok9vNJ6rZdQ29s2k4sP
         SXR7XvGwIjG8VIVpprugwt1ZDQOXIbJRezJbrzSvzbu7ImSYsL62VU4kZw6dsHaQ2pck
         XRDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdnFtAfVUuyMCqaNj9K9Ph+g+Jf1HnhJB6JYjrJf+w0tGx0j1x8k9jLQcglGatMEqwe9mG/abSWdc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr5QchqsPQiuMVrgs/gxe7hXYFlKX7n7Drfs3riYscdfElGlcM
	TpHAf/LdZIK1yHyT5ttJQsvH2MojuXhIO9dN6lHqMimb8DZWP1V4JVah466uYBcgIjvMKRNdrZl
	MJCJHhSk+ANyFSsHzSP5qxp5JYkOVRMGdm0k5CKA2/4gKksaxrXDWdW/8QEvOHCLNmRiTx/A=
X-Gm-Gg: AZuq6aJJotVHFwR4yVpRb6O2P+rC7rfe8kisseeDkiwkUUvzqDI2WQV/gZFDS3kvzMs
	3RUf0k4ZfuX8N/luCDyh2QHuOZDWg1puP1NInlWfU6zJdyLFdJTb5+566VjABQdO+sLCWqg40n7
	FkNpn1V3oUQ3aGT82PsrFiX6tH9+SP45EvchYkT9FmV7hCXyk45GfnUrwW1yfHND9CMH13JtoH/
	Cuht1T688/hHvRph+/TN76QjcF8LV6NZxT4z6+amW2IMpgl4rJVnnWQUkh/iw+e6dmaTBqNTyJv
	r3je09hmNrY+z7P3InyfDM6hl3dWKzmn7MyHsR6SIY9KrcOUwS5zbn0TfevW6KuJunVG4U8kXuA
	hoThp+3xWnioaVGNH05wT4V5ZPhov/4IAGNkoXCM+8SS6/IrezfCDCmNBm4CRt18w14B48/u1sq
	rCxBuniOS6WaDaOr58prDLmGrpBM+RGQ==
X-Received: by 2002:a05:6a00:4299:b0:81f:4a06:702 with SMTP id d2e1a72fcca58-81fa036a8fcmr14849566b3a.40.1768993725974;
        Wed, 21 Jan 2026 03:08:45 -0800 (PST)
X-Received: by 2002:a05:6a00:4299:b0:81f:4a06:702 with SMTP id d2e1a72fcca58-81fa036a8fcmr14849527b3a.40.1768993724828;
        Wed, 21 Jan 2026 03:08:44 -0800 (PST)
Received: from hu-pankpati-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fddd12fcasm6511788b3a.0.2026.01.21.03.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 03:08:44 -0800 (PST)
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
To: vkoul@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sibi.sankar@oss.qualcomm.com
Subject: [PATCH v2] dt-bindings: dma: qcom,gpi: Update max interrupt lines to 16
Date: Wed, 21 Jan 2026 16:38:28 +0530
Message-Id: <20260121110828.2267061-1-pankaj.patil@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768993708; l=1046; i=pankaj.patil@oss.qualcomm.com; s=20251121; h=from:subject; bh=ttuuT4a/yce/hPwLos4F6FaJOgKfFvjfty/guaeo2rU=; b=S5bWQ4+twbQlCFWR9QTl+iQPLNv3ciPUN+kcDCA2ER7x+ku1Q11XZ/4oJhKQalFs0fDAsaoD2 60RqhWVlwRqCVXjYFaGTSocz0TYkIB1XduluSbDUdtbqh8sXNj71WND
X-Developer-Key: i=pankaj.patil@oss.qualcomm.com; a=ed25519; pk=pWpEq/tlX6TaKH1UQolvxjRD+Vdib/sEkb8bH8AL6gc=
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Jv38bc4C c=1 sm=1 tr=0 ts=6970b3be cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=9a_DUlnzXuJTuH-cha4A:9
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: d_m3mwHNYE4mfSI6XwXNqbi6KlEPMYmG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDA5MyBTYWx0ZWRfXxTTx4e+/ziCl
 pEAtX/Et9EpAvviTILltBd0I/7WI+Rszl6ssQM7HRucEto3Jy01vrH+cRiortrKAvES01qGW443
 H61JOZjp6l8NMXabTxKS3rT23MN/OAFrsDgNh40YBh+o7wPjpe1Z4gXW+pkcwGmascII2rW8CEc
 v6iGHLRi2zhL02Sbri+EbtJZhC4M5I1iIMhtxU6uQy3BSXLm//1Ivc3qLtaIDK4BvOmHw+UeYvL
 cNjxwcFbXYxIOQirMxB93FMBowwe34woqcHYMJ4qyrnaBZ7HkWSrsIEGPxYhEJ4x/jcoMxWeW+5
 FPfllq4ez5g5aM/TBicUz0lUAvmqP5K8htVDN0a4qiqxAvsHtveE/AmoYwPK12gsDnFIdvT85cZ
 D3/66i51yeb4WEosnnyJeM72UMUlsBvz1A64vvrKBXHvFu/GS+gWb8JlbdDp2eCe0b6YlsZojB6
 91zgbekN+bJFod9mu0A==
X-Proofpoint-ORIG-GUID: d_m3mwHNYE4mfSI6XwXNqbi6KlEPMYmG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 clxscore=1011 spamscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601210093
X-Spamd-Result: default: False [-0.46 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DMARC_POLICY_ALLOW(0.00)[qualcomm.com,reject];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8425-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pankaj.patil@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2195155D44
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Update interrupt maxItems to 16 from 13 per GPI instance to support
Glymur

Fixes: b729eed5b74ee ("dt-bindings: dma: qcom,gpi: Document GPI DMA engine for Kaanapali and Glymur SoCs")
Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
---
Changes in v2:
- Added Fixes tag
- Link to v1: https://lore.kernel.org/all/20251231133114.2752822-1-pankaj.patil@oss.qualcomm.com/

Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/dma/qcom,gpi.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
index 4cd867854a5f..fde1df035ad1 100644
--- a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
+++ b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
@@ -60,7 +60,7 @@ properties:
     description:
       Interrupt lines for each GPI instance
     minItems: 1
-    maxItems: 13
+    maxItems: 16
 
   "#dma-cells":
     const: 3
-- 
2.34.1


