Return-Path: <dmaengine+bounces-11095-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGmzM12BHWpZbQkAu9opvQ
	(envelope-from <dmaengine+bounces-11095-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 01 Jun 2026 14:55:57 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C29A61FA2D
	for <lists+dmaengine@lfdr.de>; Mon, 01 Jun 2026 14:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CA09C3034A37
	for <lists+dmaengine@lfdr.de>; Mon,  1 Jun 2026 12:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F9337DEBE;
	Mon,  1 Jun 2026 12:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l3W2EEyw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dg8DhFxu"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AC337DE8B
	for <dmaengine@vger.kernel.org>; Mon,  1 Jun 2026 12:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780318527; cv=none; b=CMYX4hSY4ARZ9AYgU0Zqnvi01fz491bRgZsWlf2baBaJRtLWmQZieHgergKwrMzyiSUpLkNUJ0ahiMudkVIgasVrYFeRexZUFnms4JKTKnzqhLvTVuCLTLwyvrPAiKDvpOB/cT4Evyij/oKCprrL5gagoUClOJS2ORSLt3YICEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780318527; c=relaxed/simple;
	bh=mjrd/5WRTtizVxAileTEcsI3Pcwm5BCTvACtsLVlxwI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hx6D35aIRqrX8i7l/vomdNfGnZ8DLhzuevELUnTRCipw/hyzGXR813yoCTqsoybMCVC70HaHGrjlJQLyAn+RsrEjwt0W86pSSWc7mUPmthWakOZamz8YqMUWkQH4oixZie37miGyOe5L6R1YGbYtd8G3hI/ispO4ae9DPUD7ImI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l3W2EEyw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dg8DhFxu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6518dl9f4110371
	for <dmaengine@vger.kernel.org>; Mon, 1 Jun 2026 12:55:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kf8GN87yWQbNdh+TSO3Lk6k7qhp0/6Kg3q6wFbgg+3o=; b=l3W2EEywH4eumlFf
	+JtME6yhCjU88SpknDnysTzaxerik8WioEnysNT3e4pIOKqOO88e7GY5JOrGfakQ
	feMtEeGBE0dGgQWNRVMwjbPjnmjA8TwS2LxMfm74TD0oQNnOhgBreGZRloguEz9V
	EDahYCUOf8jIheSpdrosz7n3yw0WCvhPRq+df/dnd78Ds1CZDv9fh3d2+SsQdMrz
	J81QxeSIVRLYqWRDOZpyjlWrU3BDLEGwPqha9OX4Xv0FqDX0yRwnxedAVfRwMBpA
	clPDuw3rHkZ+fd84LxPRtJoWgmjAhP0Rf88Z0j6iLPTZDe8iw/Mediv7Kh1Dgw93
	dyBO7w==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eh6s3s01f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 01 Jun 2026 12:55:25 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2c0c32faa62so25025325ad.2
        for <dmaengine@vger.kernel.org>; Mon, 01 Jun 2026 05:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780318525; x=1780923325; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kf8GN87yWQbNdh+TSO3Lk6k7qhp0/6Kg3q6wFbgg+3o=;
        b=dg8DhFxuHiVtj+Vtaqc20hopSbe8OaCbHZJ5BQGxja3waT2srMdCpG3c4Ru4XqRSC4
         lmbMJ7yjyx+xAv9XROYT6k0WFcRFwJa3FnHGutQ/ZwpTtethDeZJ1u4/Fh+PIx7mT3Hi
         bek4NX2h99/iwt5UFcQYdM339KZRAEK0R/Hq92396b+rELMy4Nyg0CStgtIVOSa8TkJt
         laHqAye29xyaOzUWpkS+5JJMa0EIjwPzoJRfv9Ve11aM/HR81WfRtLyqypJ5Jm1rxdFT
         s8/pyuPd4H7z3mgszadljxislt2epJ0I2Y5G6rY/DEKToyCly7WQgkB9aerRqiqNv6Wz
         YX5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780318525; x=1780923325;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kf8GN87yWQbNdh+TSO3Lk6k7qhp0/6Kg3q6wFbgg+3o=;
        b=F+5KFo3q4eaO9eQvecCwJhTKk38YhPYoiGbPjre4JYD20weUX7/nrM5HUob5eWmeIw
         HxRvEoIbzsXTFiktF8Q3Fbh1Pdv+Hr+ps4RXLJPda1kW+RWQfAEJrfoxdxErVKv04kvT
         nnd5DPsiRCT6v3AY73NKQd6vWSNPyQQIWbhYvKmUQkU25dU0P1r70yqg02WRt8BXkQvY
         Wci7q5M9aHE1NkhraJWG39MZhKdJX8Azrn7kPwA4qhap4fqotbEK8fJTi6Aa5dLmAAm4
         P7ArxD9czNebqlu2UDFkFVtXpM7uZC9FoNtm/DUtZ8gHJcEl/75fStXKTO3Fig3NBXRG
         YgbQ==
X-Forwarded-Encrypted: i=1; AFNElJ98yUUeb1/UUvpuYa/PRdtsjF31v1I6XSNjKIt4qJsjAc+b2PG30cAaM9z0ezhAd4G9l+4inq5ybQw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaLCGAFkLpHKrnEyrGTrCdW/KdaytQhH1RFYorEsJ5/95JhJ3D
	6FCBY+38NCT/xli3MA+BWL0n0yi9vfFMo5JH2vD4vZeu5bGavGYBk2IDMt5wrJ5qWF/4GjCx6Sd
	lXkfg7I978KN8Uq6dBnzsa9NCdHFAlViEtmZUO0im5CW3JB7OSbN4v5f1xk7Fv3sFjMO3lXs=
X-Gm-Gg: Acq92OHhLuo+DXRdWcQBuMmhD348B1i0ma5XpCiVJC0UFLsN8Z4aqYxUPNtKXCKQzKw
	J6GCrZnK3CBg5bP8j9x4w2r3E0YdGb+U88bhwyEDiLGs/8IYnPCTfhNUbArGglsFGl+iN1ljLkM
	VXheA9rm3ULNiDV22gqpi41r/hG8HD7x8FK1Z3ZltPsYHFFlmnPilfHWGkhHBNgTyTa69Uf1/jA
	fGx0ZZyIFH6rJSOpscZ5vzB3wVrDsTWexwyLBPrIn8jwngWviPkQpO889TH9WtWNq6WcFui2E/c
	j2T8gPRt+TqZv7pwVPgtucHYNqM8KEEMBtKXxZKjj1WtrvisAkqTLw8Qej/OE1qiMmEc4dILusS
	EFBABX+qWWEYHaAIuGcJ9ftmCXb2aeebJIP3G5kxcsT9nN0Y=
X-Received: by 2002:a17:902:ecca:b0:2bc:f1ef:2e65 with SMTP id d9443c01a7336-2bf367dbbc6mr131391905ad.17.1780318524716;
        Mon, 01 Jun 2026 05:55:24 -0700 (PDT)
X-Received: by 2002:a17:902:ecca:b0:2bc:f1ef:2e65 with SMTP id d9443c01a7336-2bf367dbbc6mr131391395ad.17.1780318524257;
        Mon, 01 Jun 2026 05:55:24 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23a21f0bsm98584135ad.34.2026.06.01.05.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 05:55:23 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Mon, 01 Jun 2026 18:25:03 +0530
Subject: [PATCH v3 01/10] dt-bindings: dma: qcom,gpi: Document GPI DMA
 engine for Shikra SoC
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-shikra-dt-m1-v3-1-0fe3f8d9ec48@oss.qualcomm.com>
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
        Xueyao An <xueyao.an@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780318512; l=857;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=JRwNa7gj/V38SNuXulP2MlFnweDp961hhJdbueICCwE=;
 b=PJGykc/8otHeCXe9kKzIIFTmtdyPt3eYq+7eAlJXMGu5cmG26SuwKenbdaF6UjwkpDxwV1StS
 s6lxCjxsHJRBZ/4THsyhk17175p4NnSgUAKdIJ0BAlve9s0LF3dcNTb
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Authority-Analysis: v=2.4 cv=AP3YypGC c=1 sm=1 tr=0 ts=6a1d813d cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=jyTGefxJr8I4-3Pae4IA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDEyOSBTYWx0ZWRfXycKRCj8kAF5w
 41XFyIDEO1ictpmIScxmY7r7CCY0ezrd1qJHtUaSoVncsr4boHdIaieQww2Zk+TNoK2DVqTVEOB
 RUygQMCJ9zvv16ZdZKt6LL7xKxudrV6AZJkYYn4CK/qgKMmU5BMqY3zTf2ZHi9YU7Vap4ARonsj
 /+kt25/LBpdIqzZykyrLvVNjSFsMNQErnbSxL3gNC961/vNBHB82w3QCQAvmCbNVl8n/EbSpp9F
 U4SY3/0OHklQd6NEO2b5KhsuMP3LqN1nxYb0ltBo7gLz/8om9C0tNDd1vqIzT+U1bJEvUn3Kbsk
 ypjbrwImTOwqv4lSYzizr1YG3z3d1TIbEulRswtPrcv56quvzll6wth3tFO0x+K/1XaUKrbvCxR
 Bof+neIUFrEFIZhm//MGFqqye9ULbaNEOXvqTsPKEqZg9zUmAXuyBpea5V1hl/BSn4k0JYog6L+
 p/aPIjlFQma5jGtJA4g==
X-Proofpoint-GUID: VDfxhsBqXYrf5gPFJntX_4sW0louatrt
X-Proofpoint-ORIG-GUID: VDfxhsBqXYrf5gPFJntX_4sW0louatrt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010129
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-11095-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[komal.bajaj@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 5C29A61FA2D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Xueyao An <xueyao.an@oss.qualcomm.com>

Document the GPI DMA engine on Shikra platform.

Signed-off-by: Xueyao An <xueyao.an@oss.qualcomm.com>
Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/dma/qcom,gpi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
index 8f9a552fe30e..54dca623223d 100644
--- a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
+++ b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
@@ -37,6 +37,7 @@ properties:
               - qcom,sc7280-gpi-dma
               - qcom,sc8280xp-gpi-dma
               - qcom,sdx75-gpi-dma
+              - qcom,shikra-gpi-dma
               - qcom,sm6115-gpi-dma
               - qcom,sm6375-gpi-dma
               - qcom,sm8350-gpi-dma

-- 
2.34.1


