Return-Path: <dmaengine+bounces-11935-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zZIaAax3RWr6AgsAu9opvQ
	(envelope-from <dmaengine+bounces-11935-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 01 Jul 2026 22:25:16 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56AF16F173D
	for <lists+dmaengine@lfdr.de>; Wed, 01 Jul 2026 22:25:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b="FK0/mAWg";
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=GIGFXpkU;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11935-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11935-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB0D93068791
	for <lists+dmaengine@lfdr.de>; Wed,  1 Jul 2026 20:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC0A3B895E;
	Wed,  1 Jul 2026 20:17:32 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4F237700A
	for <dmaengine@vger.kernel.org>; Wed,  1 Jul 2026 20:17:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782937052; cv=none; b=WBCl1cHSz0yJfllck3m+1HeW/jQs0jERe/MzIyM1rbVu5j6iEv3oQgtiQedgTcSeS+EZTlyAFkn0TCyTigPackqHzBIw5RWW3BsEh0G6V/V8vyuQ4mc5x6WLTiBHUyBx4dbxDwp22IlUy0VWvnrJjm1alWSTNuEjmFkKXEx3wzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782937052; c=relaxed/simple;
	bh=/kt2kc2jbmuzKZ4McYNdX0AxlRXrEDLuEDhXarOS6Z4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UgdMhb7dELGQ6o7tKsQREFl4xEpSq7GA1KA6+Qv/jzfpBHKt1aC49HriWZxrTgbrlNjLrC6s1OJEtkXXFwuT9Vk5U/RBRmpumg+OMG4LVPlVMnDfUniiO8Vyd0CmBx9UHHSqEFTnJ5eeLD3T0sv6MfERh2Kq/lAuLsB523pX09s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FK0/mAWg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GIGFXpkU; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661GmrfB1730938
	for <dmaengine@vger.kernel.org>; Wed, 1 Jul 2026 20:17:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Td6g8hWIX0u7vVaqxIzSNW
	VPp5ms54iIRYivzwTSa5E=; b=FK0/mAWgoxbLlxXZmSkFi49rmaMGa2IOel+VXV
	rllUlrSiUx+JUNdUl4c/eAGvJdj+eQDLOQtJXXyeyk8+mXTxSslNmvL3hZalQRV9
	DFeqcg+D+cbUPfWf0nTq7OjeYTkTnkyGA2zpVdY3ZAeLFV7vyW7Ny/EA768Xu6L1
	ZNlkVPWa9o+uED0h847l+NawAlnEhFE5MHFsMd6A2e3kyBnj0Z9vJnf357HQoLod
	MLFRBt0oian7szrUAiwkZlJne+E/g1TzENAY2j004VlGVh5SxEHuRYT/oBHvgHeJ
	NyVSmhgVM0MHqoHpuSTNHNVa9FIkUnVnFDwf6yDOtgHTAsHw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f510ajfm1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Wed, 01 Jul 2026 20:17:29 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-37fd8d36025so1041772a91.2
        for <dmaengine@vger.kernel.org>; Wed, 01 Jul 2026 13:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782937048; x=1783541848; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Td6g8hWIX0u7vVaqxIzSNWVPp5ms54iIRYivzwTSa5E=;
        b=GIGFXpkUf4BpXyflKLsEdX8hJ40bfFG6pd71mTfwznOwzJVZzASWOrQjhwwrW4nTXK
         PFZA8NFuOpkUtq8vNA5TefJ+Ze3LyqorBLYqkqXBbHIoAdWQN1sVP7spKQa3sJ11bo3u
         vq24EdV4yjz6lupJ9TlP6zohTQdOZL2yZ3pxIJA2oT+w2NKbtIx3EdwTRxbr/2K6uyLP
         oxg9Sj6D6sdevFngBp45MqeTZPVT5lZe7NoU3sH8NM/JerEVznTpfS1vuFmtlWwrPvFU
         cctw+/SSshmcfY1TDac/zBZ5uqv5Xs6REDvVCpFP7yYVHfIat7BFbWX+lW9dYvFMAMFp
         LmMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782937048; x=1783541848;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Td6g8hWIX0u7vVaqxIzSNWVPp5ms54iIRYivzwTSa5E=;
        b=nhoeAt7JUocX1TIIocMelOKvs2GquGxO5xLhCxzuJrg50SU2Wczp1Fhp+5IOY3oSWW
         Yf9sbDgi4gLte8Tho9zT+h1AnzRm/8aL2TeihHc2UhHid+zPQ26YIy3KqTjenuFQNTnX
         LrjT2ne6Yub6TMsx1LXn6WyKLyq5q4vGmI5jZnTJqILSld4w1GkaO3XDpLMjsRCBHaIX
         ZtBl4Yl8/zxO5ylRNGy19/j6U6ZgzO2PWzJnZDSH49P+gOnBn9OJBonN+rQpq4+1kOIa
         akINkKptv26J8ffgRU/b/veiwM6ykL8WQWhNmLK2Xy8C7vlddUdK55C3rUNPA8cfoJr5
         G/QA==
X-Forwarded-Encrypted: i=1; AHgh+RpQ8ccIbsPY9Dw8dtq1C4MaE7mMJwbE9621p3UwVa4iaHVPh9tYcF+ePseUjHv7m4b+tiYy5Gb4thY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcJm4rLNk/NqK2KzbPPZM2N17lvBD76sAfHAsAdqMSAP+gvWGX
	PmIHt8gJMaPsWnWO8UJTmsOh4mV8pSGtx+SR5bnIuEBVNHiKHH4tDFnFML0s4TuShad4q7s4vBe
	oVBfR11sut3fqval1DU6suqiMg3g9LLMF8N7T9Cmaja1y+66440tUI2rz94+nMRNB4HeQX/E=
X-Gm-Gg: AfdE7cmHONml5KaZyPEzmUPj5m4UkhBI2DOYEhyAa/NECN35qxJ/N55gz7zHAnwpYHN
	4C90M0rY4uXrb+hRdM/2rYyZI6Da+06l/ui05Dk/yUCYxYM0Omi5ECvW/T7rUcvcPRkQ4ncJGo9
	ntwzl5WVPct6sUTEV90k3yKTxQaIrZGbIke4/U6mqe75eQsERy3dglXE+jTC2zEQbXOLV1UI7YF
	Fj2b8iH4Z8/yX8ze9Suv2sWf7TLF1Tx3yGe/yPq9TMdPEqAEQIKRiWdYJtZjB3rNbCeMjWyWjOd
	3kk0OjtQgD6dyooeK6zsjtzGflWV2Iky320qa16Wo6NVuAJFZP1uUuYrYQZpZvzW4g6CaO6m/VB
	EXuER0HAchMdXJlNipl3psnS0hY3DNZ0yuHCr/e72ZZec
X-Received: by 2002:a17:90a:d647:b0:369:a359:b181 with SMTP id 98e67ed59e1d1-380aa221bf1mr2879502a91.23.1782937048233;
        Wed, 01 Jul 2026 13:17:28 -0700 (PDT)
X-Received: by 2002:a17:90a:d647:b0:369:a359:b181 with SMTP id 98e67ed59e1d1-380aa221bf1mr2879454a91.23.1782937047700;
        Wed, 01 Jul 2026 13:17:27 -0700 (PDT)
Received: from hu-kuldsing-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0bc79231sm948685eec.31.2026.07.01.13.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 13:17:27 -0700 (PDT)
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Subject: [PATCH v2 0/6] Shikra: Add DT support for ICE, RNG and QCE
Date: Thu, 02 Jul 2026 01:47:10 +0530
Message-Id: <20260702-b4-shikra_crypto_changse-v2-0-66173f2f28b3@qti.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMd1RWoC/3WPy27DIBBFf8ViXSIgvBxVVf+jiiwYxg1tHTtgW
 42i/Hux3V3TDdKgO+fMvZGMKWImh+pGEs4xx/5cBvFUETi58zvSGMpMBBOaGcaplzSf4mdyDaT
 rMPbNGstIWxF0UL5l0itS1oeEbfxe0W/Hbc6T/0AYF96SOMU89um6ume+5DaNEvwfx8wpo4wrC
 VADsICvfc67y+S+oO+6XXnI8b65El6m0mbcDiAd5uzWNofqebVoLn4tNIx01oWsvQavbPDSmD/
 kl+XkBxhR0wjYYNdBk6dh6FOh2ULjTmjkhhtv1WOad6XT8hPHQ1U7sHIvZdhrqQyo2lqmWxMsB
 r7XtbOegQKpSsP7D7NHPxy3AQAA
X-Change-ID: 20260701-b4-shikra_crypto_changse-f2d6d5bf04b5
To: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Harshal Dev <harshal.dev@oss.qualcomm.com>,
        Vinod Koul <vkoul@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Andy Gross <agross@kernel.org>
Cc: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
X-Mailer: b4 0.15.2
X-Proofpoint-GUID: 7HvNNAFn3xrBw1tOT19m3RLn6IIAE8Hl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDIxNiBTYWx0ZWRfXyDz/mFJADM+Y
 DfaE1g5zyi3wzhe7+gAFM1cLDrEjD6nKAO3VPI6BwskoL5Eoc2/I1vgr0uWdRlavYv6OwweNmQW
 Grq2xLjdYBGDKrZ9A0mUnTXZh9r7iTxJe9NIkGydP6ZWbATY2rltsW9W0PMcFpyDEUCIylVZs6y
 uTcBhqom3JMd6A5bcwnXgEO3ZaMoR6hIVnCtn6b6AGwQWegrOVDQby3vVw3uln3zAQIqA+G8hV9
 kobWiWC7v7WMy5MPzBvrDWxSaRWmt45GOEMb0yG+p8g1EFxWOyfouLZEjhj3V8wbRlOkSFXr4OY
 HuOapohVtqk/jm/Mdnj/WMFBmJ4akpiic9La49nBp4awiAN+IYwJN6DHsWi5SVzkFe0MuplmkNu
 vLdQiC3aNxiTxScCCmU1oAozm7JM6vibCHFYBwu3Y/TnOWDTiwTA5Qr3L1/EZ9EwYk2/WrQKPFr
 ZJI28TDLpDo8PqE8kVA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDIxNiBTYWx0ZWRfX++ADYeNRNz/L
 LTzwlEr2QUnc+aMG0xLIVHzS9Ffxxf/85AcboME5vb8qkSm5Pq9ZE98B2JoiWs4VyINjzind+YY
 0sMvYzVop4GTN+00wVxypn+V3hPyCAA=
X-Authority-Analysis: v=2.4 cv=JpXBas4C c=1 sm=1 tr=0 ts=6a4575d9 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=bC-a23v3AAAA:8 a=FNyBlpCuAAAA:8
 a=J1Y8HTJGAAAA:8 a=psUvNacZHcIMRI98aYkA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=FO4_E8m0qiDe52t0p3_H:22 a=RlW-AWeGUCXs_Nkyno-6:22
 a=y1Q9-5lHfBjTkpIzbSAN:22
X-Proofpoint-ORIG-GUID: 7HvNNAFn3xrBw1tOT19m3RLn6IIAE8Hl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010216
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11935-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_SENDER(0.00)[kuldeep.singh@oss.qualcomm.com,dmaengine@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_RECIPIENTS(0.00)[m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:harshal.dev@oss.qualcomm.com,m:vkoul@kernel.org,m:brgl@kernel.org,m:konradybcio@kernel.org,m:Frank.Li@kernel.org,m:agross@kernel.org,m:kuldeep.singh@oss.qualcomm.com,m:krzysztof.kozlowski@oss.qualcomm.com,m:linux-arm-msm@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dmaengine@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuldeep.singh@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 56AF16F173D

This patch series enables SDHC ICE, RNG and QCE support on Shikra,
aligned with how similar support is modeled on other Qualcomm platforms.

These DT and dt-bindings updates were previously posted as three
separate series. Based on review feedback, they are grouped here as one
crypto-focused series.

Previous threads:
QCE: https://lore.kernel.org/lkml/20260515-shikra_qcrypto-v1-0-80f07b345c29@oss.qualcomm.com/
RNG: https://lore.kernel.org/lkml/20260514-shikra_rng-v1-0-4ea721a1429a@oss.qualcomm.com/
ICE: https://lore.kernel.org/lkml/20260515-shikra_ice_ufs-v2-0-2724a54339db@oss.qualcomm.com/

Prerequisite series:
- https://lore.kernel.org/all/20260612-shikra-dt-v6-0-6b6cb58db477@oss.qualcomm.com/
- https://lore.kernel.org/lkml/20260629-ice_emmc_support-v8-0-1a26e1717b85@oss.qualcomm.com/,

Validation:
- ICE: driver probe at boot
- QCE: kcapi tests and driver probe
- RNG: validated using rngutils
- DT: validated shikra-cqs-evk.dtb with dt_binding_check and CHECK_DTBS=y

Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
---
Changes in v2:
- Add fix in ice bindings to specify 2 clocks defauly for non-legacy Soc
  compatibles.
- Update commit messages.
- Link to v1: https://patch.msgid.link/20260521-shikra_crypto_changse-v1-0-0154cc9cc0de@oss.qualcomm.com/

To: Herbert Xu <herbert@gondor.apana.org.au>
To: "David S. Miller" <davem@davemloft.net>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
To: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
To: Harshal Dev <harshal.dev@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>
To: Bartosz Golaszewski <brgl@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>
To: Frank Li <Frank.Li@kernel.org>
To: Andy Gross <agross@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-crypto@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: dmaengine@vger.kernel.org

---
Kuldeep Singh (6):
      dt-bindings: crypto: qcom,inline-crypto-engine: Fix legacy/new SoC strictness split
      dt-bindings: crypto: qcom,inline-crypto-engine: Document Shikra ICE
      dt-bindings: crypto: qcom,prng: Document Shikra TRNG
      dt-bindings: crypto: qcom-qce: Document the Shikra crypto engine
      dt-bindings: dma: qcom,bam-dma: Increase iommus maxItems to seven
      arm64: dts: qcom: shikra: Add ICE, TRNG and QCE nodes

 .../bindings/crypto/qcom,inline-crypto-engine.yaml | 24 +++++++---
 .../devicetree/bindings/crypto/qcom,prng.yaml      |  1 +
 .../devicetree/bindings/crypto/qcom-qce.yaml       |  1 +
 .../devicetree/bindings/dma/qcom,bam-dma.yaml      |  2 +-
 arch/arm64/boot/dts/qcom/shikra.dtsi               | 52 ++++++++++++++++++++++
 5 files changed, 73 insertions(+), 7 deletions(-)
---
base-commit: 9ac84344d36457c598806f7d8ed1369a8b0c5c45
change-id: 20260701-b4-shikra_crypto_changse-f2d6d5bf04b5
prerequisite-message-id: <20260612-shikra-dt-v6-0-6b6cb58db477@oss.qualcomm.com>
prerequisite-patch-id: 3a689e8dda5fd2755b689d94d095806b3f2e6eed
prerequisite-patch-id: ac83151a889855498d36288ddd36216d451340c8
prerequisite-patch-id: 2357cac636e019eaf14d6a493a1c72bca56fe405
prerequisite-patch-id: 2885f299e711582da312ca9d13983d296a3dd5dc
prerequisite-patch-id: 91af5f3c01e766a53ce8de69aa21847a2d6bbbf8
prerequisite-message-id: <20260629-ice_emmc_support-v8-0-1a26e1717b85@oss.qualcomm.com>
prerequisite-patch-id: 0118397958b85e4297b47d6553ba4bf5b84024bb
prerequisite-patch-id: b6724798e8b73fb2182d11bda2a7aaa58976c7ea
prerequisite-patch-id: 4101033ee8eb0bc79c8dbc4a6c636cd527bf3bd0

Best regards,
--  
Kuldeep Singh <kuldsing@qti.qualcomm.com>


