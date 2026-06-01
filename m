Return-Path: <dmaengine+bounces-11096-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4CYHBliBHWpZbQkAu9opvQ
	(envelope-from <dmaengine+bounces-11096-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 01 Jun 2026 14:55:52 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F0261FA25
	for <lists+dmaengine@lfdr.de>; Mon, 01 Jun 2026 14:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 082CD3014178
	for <lists+dmaengine@lfdr.de>; Mon,  1 Jun 2026 12:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F25037F75D;
	Mon,  1 Jun 2026 12:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OJIMoIjx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LuqIeDS1"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE73437CD31
	for <dmaengine@vger.kernel.org>; Mon,  1 Jun 2026 12:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780318533; cv=none; b=dTze48/S22ypjx0Pab23dmb5qXceysG3zlwe13tFy+SIvmfSBrQMLai32NXRdWlSSWzKSBJ3CetY9G7BN9XqMpUvQCG57SJ06NrngTR/ULqx7cqLyVj2O3ae1hD/N2n7B0A0R6yfSABKxam9pmAXY4V5abuDIUkgu3XsOyVMdl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780318533; c=relaxed/simple;
	bh=xt8fdY5E19585IRxlf2tv2dOaGtOy/UcGSJMOtFMvaY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mcibKxM85eG/Zk37sIJvc5k4W2eU1C55vn3gdL7jLAp3wkMY8LU75cN0BrODUkialJWm4su+KywSz+J44CmcdAR257HMEcEsQSKecvbC+zSyqrak0ZRNwODYGa8jpPvGLNFs7Uocol0g3GgoKC6TtKa9UQMqqjrGZMQefj1HPK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OJIMoIjx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LuqIeDS1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 651Cc0pv599894
	for <dmaengine@vger.kernel.org>; Mon, 1 Jun 2026 12:55:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KOu0AHZCj/AqL2PiuNRn2hpGRFubVPT4lIfFRQyrc2M=; b=OJIMoIjxIzA/L4sB
	97/pa2iikyaBV4O8xPnn05rYy0pJ00F5uOeoN4VBJZ3t240iq9gRZx0krIr4SDi/
	1YmR8jjC1ZFXnEceT3RXGQBDzC9hzxmbGEnRbX5PYH6px7KOfBWeG5XICx4Aetz7
	LOwfcs8Ld3eaM36BC2aeAhsH5GbGYz2aFxSaKn4W4/o/d5L9Xaif9rThLMXRYt5p
	aaMrMTbFAQa0Quc1HFSCJ9nWrwgUzE0PscrANgbCzZ7GDebFBIfGejcbFfMsa3qn
	DubYsV8JU20isDF+a3CxrsbgzWT5i2eU7plSgaCrDtk5uA6Lnzb1yoJ3lwhU/sMr
	IzQlag==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eha8r81qn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 01 Jun 2026 12:55:30 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-36d99333358so1258417a91.3
        for <dmaengine@vger.kernel.org>; Mon, 01 Jun 2026 05:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780318530; x=1780923330; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KOu0AHZCj/AqL2PiuNRn2hpGRFubVPT4lIfFRQyrc2M=;
        b=LuqIeDS1fe+tOtvoE9yzkSMg5Wr2x3g3Ndqzu7A8pTVIH9KLHd1vZqI473eZqSloV1
         7YZ3OgIh+gCuR5iukFm5ZSt65yjFJfGpSJ7l1AVwbyGB45JWHrBJUF+pb7F7qAuNnwoJ
         vcYDiTuyTLgCYM+ld11ssShVy9hEXGFTpmpM/Au7U70jILefApiD+MJZl5OjPDmJzGTe
         vpX8/VfWER7lTsyWtdqbMhcIC4EalO0dmUEPDOXrQpQBWK7tf8+v69Nex61I9Q2jwgwp
         uapt89XMqBDJw7ZsHQfhq/K78EBXsP4f+cqszDJNLFankLZUlCTxc7xlqTJu4rifmaae
         V/hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780318530; x=1780923330;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KOu0AHZCj/AqL2PiuNRn2hpGRFubVPT4lIfFRQyrc2M=;
        b=MYg+BzW7Lx9E84qJbsjhj8slG9xe0pTu5hkyngLqsXBjp9qsUG1ibGSeyXF42Ln66Z
         o88jueZg2PfrRWQQUKz9QKiW/Mrg1DMWURWcO8F7oc/5EyAF/+3zTcl4LWwU14BbR2Eg
         xuGYB7UmrFptEjB1QSI3e+4y7Fp9FsxrCZZouYLx5g7yglRYMWjQiyimBN8QsbblizJd
         jKov+FCUue4tzJW0nhigx/4qofESMQb3CBHCZaUu/+Idy8aMBvSp+ToNWcgZ3qVL4w5o
         eb1EVX4dIU+BkAsr6jDx1+bqPgM6PPRfhmno3Jovvd6BYL0zJWujRhZTxDgDr/UNUCR0
         JYiA==
X-Forwarded-Encrypted: i=1; AFNElJ/9Wut9q9rET6nUrrYXI5mX3JxY2PYo2t7C3Ge+lSxIvOysJ5Un4O2Xmn2Kme+MRjXbSD8RCIaAsD8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRVgz8ahHs0WsXnL++n2AR6H4LQte0RiWUaLSsFiot6Nj/m5JU
	v4fFcDc/awp3nzlOjeR1SwfjDo+pL195UMgk31t68YgsklnTiNsAEZHz1gsjAqh2u2ZqK8y5jT1
	w2bwPFxtngdVSOmUIKf0/dhcJ9GB6VXoMmINey1AibbSD9dxTBcPXuSlqzqIJLBYLYW+O8M0=
X-Gm-Gg: Acq92OEm6wuKpMDZLhFERWIfvwBCbSdhreWkr0S7nDWDSkYViHK9mBbkl/iQsx7Ob+f
	3wgGTVoG9FgvyD3oyhnBMPgLMlT3Wjz4WXSkJuo3svW7NHP2bfi8lxvZzVKICU1hUYGPswM5oNf
	HRuVP2brkrZIr9F+GBzDW/OAVEOrFN0XJPIomC1z/OIkw2FhfMcJhttPzy5N6LIQcZpoZEeJe5e
	qy2RlBftK9/ab1MECH+CJ0Y04DX0AWckNGSfBCV5CmYe1oGuYzhirjnRAZ8+5AFv9hAvOiRY25/
	u35ko36HahuxCiY5fOU1YqH8cLJbcvbqKBmUFUi4uzza/kLTr+aD804jkFmlDZaNgm5VhpD4vZT
	u8CHnVnILws+lf3pufRxifjbrneLyC6LRtQ6xY6/W1Iz67cE=
X-Received: by 2002:a17:90a:d2cf:b0:36d:649b:ea46 with SMTP id 98e67ed59e1d1-36d649beaffmr8911264a91.2.1780318529581;
        Mon, 01 Jun 2026 05:55:29 -0700 (PDT)
X-Received: by 2002:a17:90a:d2cf:b0:36d:649b:ea46 with SMTP id 98e67ed59e1d1-36d649beaffmr8911221a91.2.1780318529159;
        Mon, 01 Jun 2026 05:55:29 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23a21f0bsm98584135ad.34.2026.06.01.05.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 05:55:28 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Mon, 01 Jun 2026 18:25:04 +0530
Subject: [PATCH v3 02/10] dt-bindings: interconnect: qcom-bwmon: Add Shikra
 cpu-bwmon compatible
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-shikra-dt-m1-v3-2-0fe3f8d9ec48@oss.qualcomm.com>
References: <20260601-shikra-dt-m1-v3-0-0fe3f8d9ec48@oss.qualcomm.com>
In-Reply-To: <20260601-shikra-dt-m1-v3-0-0fe3f8d9ec48@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Komal Bajaj <komal.bajaj@oss.qualcomm.com>,
        Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780318512; l=1062;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=MfVD9NAJt+YvcfkJInifeQ/jWKYZMhdr3T/JUeWSDbk=;
 b=Uh7PrrReCvRpFeh/qvXNKGwe7u/r50mXMD1tIfFec/rxJuCMqrUOlwaHmejsbTKAshqYyokLu
 FVl2tlCbJ6xC+UQA0MDuG6T3pp2l4Y+6jSWsMQY4Yvvj+S5pnHSfhWu
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Authority-Analysis: v=2.4 cv=aKnAb79m c=1 sm=1 tr=0 ts=6a1d8142 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=s2Q_muabT7T23weRVv8A:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: US0eyPRjJWfMFVhymzaooRmBivPBOYSN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDEyOSBTYWx0ZWRfX6e5ZHdvIxpqN
 VOkCA8BzQKN79XJzjwVntaw/VuxcGUtyLy43BUCEfFQpU84DAlGEWbkkS9HfyKlRGEcoI5LPtIm
 LG3Yy0ghFG5EskVay511ZdhxqmGfFakJ7bEJjUuBDbUeyJ/KfOQAuNJztgRkhRgFZUC7cDEaz59
 UQS9FvU5RauSa7Sm3D5Rof3srq/IxqSo9uXgUAoufIdiiYAYC4q9ILFKz1yVoiQHwftaNJCcF2G
 2pxjhVuFHBrxlZvJnoN1NdIz8aJqzHG1aelGqPebU+uCaX52G423qv6VUXme2m2yXoT4fPwRR/L
 T3dIqTVVwxia1veE14Att1p8DQnVuvILT+gU58Pdm6JOZKwXF9DdJ7ObjpsorAZiImLYBebd3pp
 kNP75YgQZFhaDaFJzn6ZK2ovZhenSYhxNNSRcn6n08Kr1xQ396cZd5OPEELEIE69veYqE6RnjWy
 i13xMxWr1PtJIg+rLKg==
X-Proofpoint-ORIG-GUID: US0eyPRjJWfMFVhymzaooRmBivPBOYSN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010129
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-11096-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[komal.bajaj@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D6F0261FA25
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>

Add the Qualcomm Shikra SoC compatible string for the CPU-to-DDR
bandwidth monitor. Shikra has a BWMONv5 for CPU.

Signed-off-by: Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>
Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
index ff64225e8281..8f6c937e44ce 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
@@ -52,6 +52,7 @@ properties:
               - qcom,sa8775p-llcc-bwmon
               - qcom,sc7180-llcc-bwmon
               - qcom,sc8280xp-llcc-bwmon
+              - qcom,shikra-cpu-bwmon
               - qcom,sm6350-cpu-bwmon
               - qcom,sm8250-llcc-bwmon
               - qcom,sm8550-llcc-bwmon

-- 
2.34.1


