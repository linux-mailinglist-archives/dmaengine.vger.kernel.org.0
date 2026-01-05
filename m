Return-Path: <dmaengine+bounces-8007-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C29CF21BA
	for <lists+dmaengine@lfdr.de>; Mon, 05 Jan 2026 07:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E06D43014A03
	for <lists+dmaengine@lfdr.de>; Mon,  5 Jan 2026 06:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1BC22BEFE8;
	Mon,  5 Jan 2026 06:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="m2F1stD0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hcIUjAma"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FFC1E3DF7
	for <dmaengine@vger.kernel.org>; Mon,  5 Jan 2026 06:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767596354; cv=none; b=KPIRz0iT63nWCEQBzW2zublQ4r4TjtPHkyNK89gRMTBQ9BFpLzC0S7njrJld1yoI/ethBRv1KOxEB+pzVIU+N6ovdLSyN7R49x0ojZnlKmk4mru32dyDbAhhyeraNhcCd8sCDroXSQldt95UZq7F/mrlaN+fCX5FLRbZ2uteLdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767596354; c=relaxed/simple;
	bh=9tg6cmKni91qJeyOldDk53vFd5fa/7dVnS38WnIDGlA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AR5Kf7icA6/h9BoBocH37ETtzvk/1smD99I0Z1WEwv1/6hwDY4Qvkj5rk98sb4C5tp2HqoMEgp6DphWlz8Xhj2wLHtgFgznIJDxV+lGLOikwiRlPek4rfMc23pGA6NYbwZWt0mxklGk2qBswQOHZ3qSHp6YHeugYbYKpI5Yh6Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=m2F1stD0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hcIUjAma; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6052oVc7091901
	for <dmaengine@vger.kernel.org>; Mon, 5 Jan 2026 06:59:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9tg6cmKni91qJeyOldDk53vFd5fa/7dVnS38WnIDGlA=; b=m2F1stD0/By+ujgp
	+1atQorc9QlE33XuZYONDgdHpdciwjEhMShzJH7wtGOJzncDChbQAqXWLWpXC6mz
	d9MAFs7ywFlBjfXLRmdIJYvPwQGTzqklrWwKE6ohB/+ppn3+G10qlZ1F9t4yQh7B
	8n+8Nf2vo0bRNN5vrVTsm9BScAMkJ37FY337bntaOMyyzBKWxS3ACGh5N67LGdKn
	tDSgRpV1vp16mHUnpjZwfbxGaU/lx8uRHVxEM+LHFTCozUi08Lxc+NmfaAReNEuP
	OuXxga02CYodVdQDs1eW01FpA0THvwAdLOBThOtYxBVPmF682GHdNHQjbzJu4yGs
	gXdS5A==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bg4v60jke-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 05 Jan 2026 06:59:11 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a0f4822f77so373872125ad.2
        for <dmaengine@vger.kernel.org>; Sun, 04 Jan 2026 22:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767596351; x=1768201151; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9tg6cmKni91qJeyOldDk53vFd5fa/7dVnS38WnIDGlA=;
        b=hcIUjAmadqkIkxRushwP3VY1raWj2BC33yNo0dFwYVvMidP3sJPopjwjT6NhZH/vMb
         3mtgnZABmwi4DiMq8KdVzcYPEx0ZSMXssnBamTjII/IL8Ri527ZHA6LEzl6D2tYqbcqN
         Bc6eV3Ri09se1vtAxuwNaEOJjNcUyDw5GmOIXB5+O80cQF0Si28qbf5jSAod7nRTV8dZ
         D4XG/YLYxiHAM0KUhaMuK2HByKhn8YyF8wjoPRGbDOsEqEaUOf4p5TOl6WdOsXet6J+0
         dImanIiT9xsO0gfBboGRIwGjWiSvYENHJ6jUCG58bjSlkwnMbXXqe0O0TttzR9v2izwm
         CDzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767596351; x=1768201151;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9tg6cmKni91qJeyOldDk53vFd5fa/7dVnS38WnIDGlA=;
        b=KZbzarr9hAnjYYnGat3FbRdMUZORZx6A4CY1MEwZovSUpQ81ZCfFwfgzahsN/SMOy8
         2vntzjH7fgLoYBNLGsNUtemuMSIoYSnk55uF6yYhRML6E79tKuDrMIla8RKT1R1BCStm
         F5tUPjPYLjOQotb6zJirRoL3J+s2taVUY145w5Vq/XC8TaCilNIlI/uCuqRI6XHUo8f4
         S9MXJWL9iVBzWDVja64slEpE73e4/ahqwAh8NDEF+ziijwkMG1r1wFkajeiyse9KkKau
         EkEFAG/E3YfEVAnbQpBsTnKwj1/Vr88a6qOUurr/NOyDB7Znw1kI8JUx6O0WZ6waAhNR
         q/BQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3pTy4bzmEgVnvtT5aJNKrFkfPrm/LMObGEnap6maiKM77FjAqePbwnOPgLodDQ7TE3RUsTo9FANI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd/brdanF1e58pMF9/44OHrz2AEuL4U5fqxlrhX+Vfn3b7QcEb
	RTfiqGMWSfWaCQMrzQ5ADZBJtDAdBUxT1hV7qw8l2bbwSCWIsz5FC4Jp3WDoX4CxjV3gUd7NdDD
	rXkpVbAmSB/Hyj2xCMNYQWwOM5kzKaGYMVQy4oN4wq3LTv+wi1RIIMOt6l9ve+Xs=
X-Gm-Gg: AY/fxX6PluM6dvZIcsKLB656sGHJjLqjdtAMtTK2RnzyUqrw4DoOjm8rrJfUaISqNnO
	HLlIPL3gqNCK8+vvrFduXgMCFAvgUwz+CG5eyFNIJBba8NxzCJhR0qGyDVM+EP+0p2279ja59d8
	KYX6dNtT7k+iW2NZ7zfyATVN+AMrykKTB/Slv64gWfSrVaTexACLkX131rtVTuZEKdJstGNWg+C
	d3uskM7WZpcvDzM48SvqFS96UFz21Gw65uiQBMvQHdZknb+EUMX86wn1BvqAaYFyyKPOqgWqsIc
	MxcFABknQ6MsnbFRimM8R1t/2Ai0qxjT+5koXnJ3qds/6sqb8qcX4ID+jDrlkSesEOZxtryRsmV
	y/NISscxX4e/9HuDj4kiyEExOcdqKqsGn2/b/kvhzZhW7Hgy5WlaR2H6wOqiB1M/cSQXRm1FPLI
	aOdmxw2q7pFCEF+LZQCoeIxYMG6R4=
X-Received: by 2002:a17:903:24d:b0:29b:5c78:8bea with SMTP id d9443c01a7336-2a2f2836c2fmr461162135ad.33.1767596350861;
        Sun, 04 Jan 2026 22:59:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHy6WPBIrh6wcO/7G4RNW3FnXx5uWBjdvCAxC7e7PK5eXaK1UAHb7zE2ir/D7QOj7klabh3MA==
X-Received: by 2002:a17:903:24d:b0:29b:5c78:8bea with SMTP id d9443c01a7336-2a2f2836c2fmr461161905ad.33.1767596350339;
        Sun, 04 Jan 2026 22:59:10 -0800 (PST)
Received: from [10.190.201.90] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d4d87fsm435726525ad.46.2026.01.04.22.59.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jan 2026 22:59:09 -0800 (PST)
Message-ID: <aa62b769-4be2-4e6b-b2ca-52104391a757@oss.qualcomm.com>
Date: Mon, 5 Jan 2026 12:29:06 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: dma: qcom,gpi: Update max interrupts lines
 to 16
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: vkoul@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sibi.sankar@oss.qualcomm.com
References: <20251231133114.2752822-1-pankaj.patil@oss.qualcomm.com>
 <20260102-fiery-simple-emu-be34ee@quoll>
Content-Language: en-US
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
In-Reply-To: <20260102-fiery-simple-emu-be34ee@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDA2MiBTYWx0ZWRfXwA317m+V8o5L
 ufmzTmN2rsTU359kCsDwWLoiGZBqkosYKNRW4Xh1ym2z5CZloZOCLsj8mnuyEB7D/RKyepdGghE
 Zsimi0uxA4FTGHljRGa2yPAjagH9h77WSNi919ffRuqBWDT/XlyqevGUgubV4A0h9pxHIYtZJ4w
 UhBnnWQWIe2Yc8oFh/d22aEtkKRYWGIy8Fz8WyL+oc/9LN/4faV087rgZ32Qu1JbnFvXn68DaOi
 CYLRDXiTyP1y/e4TxdKtiKAPieMBP6DqtZl67OqhbXz5Cli5wcakBn/4TehV8/9lNs00hWWuf8W
 GPxX1ozy1X1tfpKjO3Hbsooa97jWs5DLhnejaLChAkJimkPckl2QslITBACU8+6dnm3SfJUcEpn
 He1qaERGgg2Te9ePizpNLeFBXrOrZcHCDMlu/I8rldScm94JiLjikG2jYRaQaTrt9rcx81s6vQq
 xyE6mLFO+1PMeQrL33Q==
X-Proofpoint-ORIG-GUID: jIQFxfuI9XEKMfcIzC-lrr762c4Db5HK
X-Authority-Analysis: v=2.4 cv=c4ymgB9l c=1 sm=1 tr=0 ts=695b613f cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=i01SU5i697ricP_RhYIA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: jIQFxfuI9XEKMfcIzC-lrr762c4Db5HK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_01,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601050062

On 1/2/2026 5:57 PM, Krzysztof Kozlowski wrote:
> On Wed, Dec 31, 2025 at 07:01:14PM +0530, Pankaj Patil wrote:
>> Update interrupt maxItems to 16 from 13 per GPI instance to support
>> Glymur, Qualcomm's latest gen SoC
> This has to be added with the compatible.
>
> Best regards,
> Krzysztof
>
@Vinod can take a call on squashing, the glymur bindings
have been applied to vkoul/dmaengine next tree.
Let me know if I should resend.
Lore Link- https://lore.kernel.org/all/176648931260.697163.17256012300799003526.b4-ty@kernel.org/
SHA- b729eed5b74eeda36d51d6499f1a06ecc974f31a


