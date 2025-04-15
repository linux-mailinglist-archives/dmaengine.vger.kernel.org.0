Return-Path: <dmaengine+bounces-4897-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E2CA898B6
	for <lists+dmaengine@lfdr.de>; Tue, 15 Apr 2025 11:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36BE5189ECDE
	for <lists+dmaengine@lfdr.de>; Tue, 15 Apr 2025 09:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C2328936A;
	Tue, 15 Apr 2025 09:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o7Rsj/zA"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DC1284686
	for <dmaengine@vger.kernel.org>; Tue, 15 Apr 2025 09:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744710838; cv=none; b=FG3oIK9yi5ra+RUGg3F3H9V8OTlEhmIVOUJ01lGdTbqn5TXBw/ZM+mLL8idzc27XwRAbZbdqPi5BQCm7hLsgLn9ioRhRg5fHcVN6E/r34sjm4nYUKTiulg2Z2eIL2jNLZTUGcQyCjW6fbW/3WxxNtjTUnN7oooSz7AJ0aJBJNmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744710838; c=relaxed/simple;
	bh=nfB4gqLyqc0cGgmDvW8mT61CF98kw+LFnPgIxUoqozQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U1+CUn6AxhFMyoXSIHty8CDaEBMDtaFyY+MYBtFmq6DuT6goDTZZmeSVg4WGbEIB8YgB/3el7fa02TeFGLSTOQH1Y19zaKWAgYyhXpsOXsKQA8NaDjJ6LaYnjm1O87IHIdJOJ8vro19vWs99t0NE+v+brRGxHlxrEgLG2xy402I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o7Rsj/zA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53F8tB8r025041
	for <dmaengine@vger.kernel.org>; Tue, 15 Apr 2025 09:53:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qxeuE2eVL5Eoo29xjyLgJecbYqVi8+nNdiHJPQLgII4=; b=o7Rsj/zAPhupkj9v
	IGCH94/ff7yFpwjI2gpAfE8QGpx3kwHZDwAS5MXs/SXf0DpFAxaTjzM0oLBVgMq2
	ptXqv4ku56/vrPfk0xRA1LH/NSdEA7Un30R1sBs1dHdLBAcIPE2zP9faNY+7zvG7
	lFOsezFz5NG7J6fXs9lrLhtTpDRcArRxfPfekByzCw9k1md2DlkA0DL76H2E7Qhz
	YAkZLxDWldSx0HdYEYp9GP+upHc14UTKK+DpX5BrEHqddo4NpTJckqO938Dv4CSl
	gB0ussQi7u3O9XF6NJJpEytyWt4U42J/btVyx3tXhGY1I/EmdnZVDmIInlqa3uS9
	G/MLCw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45yg8wfjwn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Tue, 15 Apr 2025 09:53:55 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6eeb8a269a7so16614776d6.0
        for <dmaengine@vger.kernel.org>; Tue, 15 Apr 2025 02:53:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744710834; x=1745315634;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qxeuE2eVL5Eoo29xjyLgJecbYqVi8+nNdiHJPQLgII4=;
        b=oot1FnD6qzE6+1oxL9tegpQFrQEsfjhcNLcFY9MjTO+OLmIfM6XTdOnZHO829SLGT/
         lIOUKEqARwT4pYyqzLtnMDxvdvNnwq82a6CywrDmS46k5QY/R7iZvhXxCGjDhlDQKnkv
         su6Z7EsWOjJ+pGrmMBQlD7cmw6XPP9Ynk+QWCfQgiwtKI/1mv3Y5gj2Dh6BzXXZlgrWO
         moeBwp6ua6dI7+FoDqBhs/WIJRGGiGL3nkBZXF/f+PkMtmrnA8ylkbIApfeGEXtYZhHa
         N6z6cnX+yGC+tmiqQbw3wcndDUibLQXSNu41qiSSR4Lq65uIX6uOOHOOvA6C8o/qcvRP
         c0MQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaqY7S3wFx6wSsBJp6rEdIj/RFoRK0YV7qV7stOaleuY3mz6NQxYGa9hq10sl2z0ES27lySMvup2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBUjlMshao5U/YFQIzwforaDtrNPwDlPXFps3u3kUKOM1EBp5X
	juNoHPJnN2RRBfv9YzsALPGkmRnojtGbsFPI1c+urrxpvE27thHey/vKRNoKtmlF41+S2aeiao6
	vBAjxM7lQYX8wyrsM6FhGyDZ8rbeY+nzfjS2hegUx1rkbhbAyeqg3P7+87CI=
X-Gm-Gg: ASbGncsxgkJNn2NBi6gs6UlmhlbaSt9a1hAQTzmVi6vkK/4QQM8Tps1fSva6c81ch7w
	N7Y8GyCL5PQAjKGRD/R4zRy0DyzZFrsayQ9dStjf6iVDtS4LFN8ToFuRosHGrz72X4Zfj+4IaAO
	VfVGesXGZUGtSpTraUg5IcX8OrUPwTLI5ja6x3W+YdomWJe2xXM6pTWHCQRfVnWJXxtd1URgDQr
	lz+rreg2kCGBHQ+eoHecZnICsQyuz1Ah1vSNL4B/bvm8A1U4y4Nawh/rGZymTSbswKsrXSJcjSv
	iR7/dQx6VOPxAyAnQ/yXLpu1fORDPyUYJtNWHDxiOLUP8s5rQNbq5q9KfTXePxQEMmg=
X-Received: by 2002:a05:6214:20cc:b0:6e8:f019:af59 with SMTP id 6a1803df08f44-6f230cb9754mr96287826d6.1.1744710834371;
        Tue, 15 Apr 2025 02:53:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgaJX2J+7JlHuueBHmISXlo1aK9U92F4gsipjLZi1j7TSnpCxzm7LQz4Rmzpb9J06CEF1Qug==
X-Received: by 2002:a05:6214:20cc:b0:6e8:f019:af59 with SMTP id 6a1803df08f44-6f230cb9754mr96287716d6.1.1744710834041;
        Tue, 15 Apr 2025 02:53:54 -0700 (PDT)
Received: from [192.168.65.246] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1bb3120sm1049550566b.1.2025.04.15.02.53.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 02:53:53 -0700 (PDT)
Message-ID: <4c57a98f-045f-4487-8354-807b647b2040@oss.qualcomm.com>
Date: Tue, 15 Apr 2025 11:53:51 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] arm64: dts: qcom: sdx75: Add QPIC NAND support
To: Kaushal Kumar <quic_kaushalk@quicinc.com>, vkoul@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        manivannan.sadhasivam@linaro.org, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, andersson@kernel.org,
        konradybcio@kernel.org, agross@kernel.org
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
References: <20250415072756.20046-1-quic_kaushalk@quicinc.com>
 <20250415072756.20046-5-quic_kaushalk@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250415072756.20046-5-quic_kaushalk@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=E9TNpbdl c=1 sm=1 tr=0 ts=67fe2cb3 cx=c_pps a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=HfTDXfZYWx141HAPJAYA:9 a=QEXdDO2ut3YA:10
 a=-9l76b1btMQA:10 a=OIgjcC2v60KrkQgK7BGD:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: ffwdEq4aJNFc4w0qubtQm4Cbq_7M8jfS
X-Proofpoint-GUID: ffwdEq4aJNFc4w0qubtQm4Cbq_7M8jfS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_04,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 mlxscore=0 bulkscore=0 clxscore=1011 phishscore=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=738 spamscore=0 priorityscore=1501
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504150069

On 4/15/25 9:27 AM, Kaushal Kumar wrote:
> Add devicetree node to enable support for QPIC NAND controller on Qualcomm
> SDX75 platform.
> 
> Signed-off-by: Kaushal Kumar <quic_kaushalk@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

