Return-Path: <dmaengine+bounces-7134-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A44C4DE57
	for <lists+dmaengine@lfdr.de>; Tue, 11 Nov 2025 13:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7343718C3FE4
	for <lists+dmaengine@lfdr.de>; Tue, 11 Nov 2025 12:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBAD53711A4;
	Tue, 11 Nov 2025 12:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eSxsaPr6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZX3mXq1s"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C20C36E1A9
	for <dmaengine@vger.kernel.org>; Tue, 11 Nov 2025 12:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762864208; cv=none; b=tX/Q2lro9kYRpasA3fYbySuxHoOCuUHQ9IfGh3aoqZIHiA0cMBpy7V5X4tPX4xVY5TldO4ExTj8SX9ZUH8lo2kEmVTI/86DvTs/xJXFIbF4ekwKybixbA6VoofcVqURa1/dZ+qKUqABqh1KU/5I/lrKZiQNdE8g5F0hj0SE2A1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762864208; c=relaxed/simple;
	bh=dB8Ue9D/OJCd2P+B6eSyqNbmWDWbA3cTGphzjnIuCJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iuGwb1l9D9Hg2oVktPHs8QDv0jafZ+PkbpiNHlhxvKyPIGMsM+rjEItBZribtMPO7WgaOkndlTXOdGjgk68qV6KAY8xUf2pBlLQXwrmMxhEzLM+VY3VmMLBY8dRYlfGuOhT69C2aC3ZYaDN2Y7OGvF4VVQdWM1YTcSVQHFpDfiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eSxsaPr6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZX3mXq1s; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ABBGJvE2117350
	for <dmaengine@vger.kernel.org>; Tue, 11 Nov 2025 12:30:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=hBs6+xWoLI/U3b24rkOBpj2F
	X7NTpjk+sdbP859Hs0s=; b=eSxsaPr6WrcV5ySsbXB9AYitmCJYpQFggD+nREFQ
	pG2uX8DRL+X4TNu0TEJNH3G+Y5fIs/zXNu2GsVVsftljOFzfCI8q+xSN9ZVKt1cT
	AMDCAAHdDWd/Mxp6Sd55K0MV7R/lCekb+a/txYFISaZ+94e74VSkE53HZRFEp7cq
	qt+W2abJoVe9XYk9We8mvXHVJK1DjbzSk2RJlKWPCCv22CRu5Rgch/8QLMQflF/B
	1n0dSArA4TyMHwSIW6cxDBUBwEkQqzfSg4mPnd1nLaokUVQOdfvXxr15mFYEquou
	8Z0hfWV8uUOGrGUV5fmx5by/rgYi4TxCgnswYT5FUlljDQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abpy8jccr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Tue, 11 Nov 2025 12:30:06 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8a1c15daa69so1259731385a.1
        for <dmaengine@vger.kernel.org>; Tue, 11 Nov 2025 04:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762864205; x=1763469005; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hBs6+xWoLI/U3b24rkOBpj2FX7NTpjk+sdbP859Hs0s=;
        b=ZX3mXq1s0DJkp9fFjlm8DyhW4pOpe3tN7UuFNIFwkLdfPIqyPhGR+X1GWAuFeBCHqD
         bF9qPGtvYeP0ENNjRCe1XNU+yRAykCIajBgOIPRhdFYjS4/8p+eBAP3vqpUtQMxXLKjS
         9IRILIJX79hGq8jDtr5YtU2StzFJOmQ1rWYZ7vCdsN0we6nwr9h+o6y1fP2rd11HuE9o
         cVht0m9XQVd8LO6HMeusJQcyWhAXGBcjY3wSulaby3e2DKDKUyRniXaMNe0NdfnPHuzG
         p/wgy8j8yJasf5qZO0xenu+Rq9gt3h3PR420BsuMUq2e3s/ENy46/Ru3K7laD1wVLXlP
         MzOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762864205; x=1763469005;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hBs6+xWoLI/U3b24rkOBpj2FX7NTpjk+sdbP859Hs0s=;
        b=JTu4UGaaVSwgyVkC3lXUDMljMD35RJ2Ss+rYhvfr0b8ViZ+cjdw9rj0mEn92K31lVw
         i5HgMwCj2xReUCQR8rEeGq1Zz1wF85Qt0rFZJ8H1GAYohdZu1hGGX5xPPCXSy8E3GERx
         NAHfAqdZOk9mQMo9ILX4DF6wpXgheEDE/7854IcPTQja0XJhYACE6HGW6VBh3rgnFamM
         Nv2Z2wR++ZJ0kNkGwfN/8YQkTXjTIEZ6La3zZHb9hwmGDw85ASYfpaw6JQbIffmmMcVC
         Iu3YkF9kh3dcqOyvSTsTaZmMKmT+WYp902C4+FnzRyWfctKyeULL2eAffUSuOj/bSyRB
         og6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWTu1cZpLMxFS6h1Ir9XBT5oehXiHJtGaEqbQ8z4bvRGKSxvJ2LCZT9HXA0VsDufC82NIWfcw8bMTE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaNu5OGV7TMNVRi2yS9eugnmVm/UNq3kNUEmir3Y24qBCauC1C
	iCpksIe82kXkWqIUPNmkZQjx4nJJkUZwVTHqkkznaNt0vZNdqZaGydSnRAJXusDreosbz9NW90v
	ZXXUkflLB8ANQqmpaJZcFg/z6qRa/54MZ6IZjOXOYZVCkv+Xz7tjhBSNfHJowjRs=
X-Gm-Gg: ASbGnct/AR+fNMHaM6LFvMMeqAP2K0g/fFik2QzAPU4AZq5b/m+rKpB+DZEn24au6zy
	g7SR01p3KL+AKvCFte5jRCZKdEuB4sIGwF49iDMZUN8bMfDeoVHXCluFre3f88yKIqJoRvlqR9P
	IYy5j/8sdSsVGT9c6XJYESCpc97/kYDwY7RSeD7/ljpSt1skVYY1A4FLF/XF47yAulEgz2XBR3A
	ZQobdb8j5pQRh10Fhz1cd6DVp79j8kf6DCj5sQpN+OLFjI7xfm2Dm1lNLitf2xIB23FWyyhL3lA
	BOTcEXDlWMLgh41lm/Vr5UvE3JmSJEYbciieo4W5OMjG3/zJXt/e4HKvHC3Cf73kGDAGdpD3ruW
	z2GzTNuZNc5I9OmrSQPJvbrTrnAb+Bb+kn1E5+YuQZOTYLcDnExHntyMrlgMYnYAhQtFhY3WeF2
	N7fz5nsuNWu0Ch
X-Received: by 2002:ac8:5f94:0:b0:4ec:fb4d:105e with SMTP id d75a77b69052e-4eda4fe0a8bmr137123031cf.69.1762864205563;
        Tue, 11 Nov 2025 04:30:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF/wAmTt64QZYcRPu2yVc2CYacZ2Ql3aGNECWBHUNigTi3vj/RKjWKUB+wbah0KY0qbLTwsww==
X-Received: by 2002:ac8:5f94:0:b0:4ec:fb4d:105e with SMTP id d75a77b69052e-4eda4fe0a8bmr137122491cf.69.1762864204948;
        Tue, 11 Nov 2025 04:30:04 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-37a5f078765sm44935281fa.19.2025.11.11.04.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 04:30:04 -0800 (PST)
Date: Tue, 11 Nov 2025 14:30:02 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Vinod Koul <vkoul@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Udit Tiwari <quic_utiwari@quicinc.com>,
        Daniel Perez-Zoghbi <dperezzo@quicinc.com>,
        Md Sadre Alam <mdalam@qti.qualcomm.com>, dmaengine@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v8 01/11] dmaengine: Add DMA_PREP_LOCK/DMA_PREP_UNLOCK
 flags
Message-ID: <xozu7tlourkzuclx7brdgzzwomulrbznmejx5d4lr6dksasctd@zngg5ptmedej>
References: <20251106-qcom-qce-cmd-descr-v8-0-ecddca23ca26@linaro.org>
 <20251106-qcom-qce-cmd-descr-v8-1-ecddca23ca26@linaro.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106-qcom-qce-cmd-descr-v8-1-ecddca23ca26@linaro.org>
X-Proofpoint-ORIG-GUID: g3bwWaTuVJD8b1ISARgiFN4CGWgU-yUb
X-Authority-Analysis: v=2.4 cv=AYW83nXG c=1 sm=1 tr=0 ts=69132c4e cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=8Z5QE3b6LG9DqZ8cva8A:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDA5OSBTYWx0ZWRfX3UHWL/+/G5pO
 8LRS1EAWMqhMp7xE7YAKDscm/kY56dpUyQxIAFagOM/c11zMt+6mLP3u93JXNes68MP/R4eb8xS
 NZfsGs0chq1i44wMDWvfjBJ/0HMRHW00hwEVpqWL7wl/tbAyKByDcSTafNUt8YTfxdvTCKdMHUo
 pXU2awpOiruKSXAfo3UYi/ZftUpa52L4cObH7To975j+0HiNs6h3vV2L4z8BVAWauMDIeOpRkig
 4tP6dKlQ5KB10FnSUrqzbr3U7O1daWWtw6CFtpJDMtms7qRRJ2nM8UOqs19OyEHaPacudtc44vY
 aWPNCo3Er6qpxugfiIvufJ6HTpaJ1uPa8iApnyO5wcEmo5jgK/1CQafvnzB+wY+G8QvTUci/cBL
 /8dvNeKSWViHjJBXbxEt764iTRE5mg==
X-Proofpoint-GUID: g3bwWaTuVJD8b1ISARgiFN4CGWgU-yUb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_02,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511110099

On Thu, Nov 06, 2025 at 12:33:57PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Some DMA engines may be accessed from linux and the TrustZone
> simultaneously. In order to allow synchronization, add lock and unlock
> flags for the command descriptor that allow the caller to request the
> controller to be locked for the duration of the transaction in an
> implementation-dependent way.

What is the expected behaviour if Linux "locks" the engine and then TZ
tries to use it before Linux has a chance to unlock it.

> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  Documentation/driver-api/dmaengine/provider.rst | 9 +++++++++
>  include/linux/dmaengine.h                       | 6 ++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/Documentation/driver-api/dmaengine/provider.rst b/Documentation/driver-api/dmaengine/provider.rst
> index 1594598b331782e4dddcf992159c724111db9cf3..6428211405472dd1147e363f5786acc91d95ed43 100644
> --- a/Documentation/driver-api/dmaengine/provider.rst
> +++ b/Documentation/driver-api/dmaengine/provider.rst
> @@ -630,6 +630,15 @@ DMA_CTRL_REUSE
>    - This flag is only supported if the channel reports the DMA_LOAD_EOT
>      capability.
>  
> +- DMA_PREP_LOCK
> +
> +  - If set, the DMA controller will be locked for the duration of the current
> +    transaction.
> +
> +- DMA_PREP_UNLOCK
> +
> +  - If set, DMA will release he controller lock.
> +
>  General Design Notes
>  ====================
>  
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index 99efe2b9b4ea9844ca6161208362ef18ef111d96..c02be4bc8ac4c3db47c7c11751b949e3479e7cb8 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -200,6 +200,10 @@ struct dma_vec {
>   *  transaction is marked with DMA_PREP_REPEAT will cause the new transaction
>   *  to never be processed and stay in the issued queue forever. The flag is
>   *  ignored if the previous transaction is not a repeated transaction.
> + *  @DMA_PREP_LOCK: tell the driver that there is a lock bit set on command
> + *  descriptor.
> + *  @DMA_PREP_UNLOCK: tell the driver that there is a un-lock bit set on command
> + *  descriptor.
>   */
>  enum dma_ctrl_flags {
>  	DMA_PREP_INTERRUPT = (1 << 0),
> @@ -212,6 +216,8 @@ enum dma_ctrl_flags {
>  	DMA_PREP_CMD = (1 << 7),
>  	DMA_PREP_REPEAT = (1 << 8),
>  	DMA_PREP_LOAD_EOT = (1 << 9),
> +	DMA_PREP_LOCK = (1 << 10),
> +	DMA_PREP_UNLOCK = (1 << 11),
>  };
>  
>  /**
> 
> -- 
> 2.51.0
> 

-- 
With best wishes
Dmitry

