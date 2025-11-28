Return-Path: <dmaengine+bounces-7378-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D89C3C91F14
	for <lists+dmaengine@lfdr.de>; Fri, 28 Nov 2025 13:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1C293A4AEB
	for <lists+dmaengine@lfdr.de>; Fri, 28 Nov 2025 12:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C990E327BE6;
	Fri, 28 Nov 2025 12:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dXsj2XWp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GwJlR3aK"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659FC327BED
	for <dmaengine@vger.kernel.org>; Fri, 28 Nov 2025 12:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764331400; cv=none; b=rG/8jZWkn/LGCvuEAOlh7bp+mixW58DEEcqnRePM8ue03zXm4p1Yeov6bKr6dBwQ1y4qbGJKnM4c145uTDNtdjQoRd6EiiuaPcZrqZK+qlYLpWy/Ky5rjdPPqXra6Bhzc3XmlWmfQ93GJRg0v55pbyMKMdxxhZ38sG4DtatT8h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764331400; c=relaxed/simple;
	bh=gI9TZ0qesYpRchQnmCsWfJle0T2gVsum9dhWtazzYhc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XU+ILgkXzJ0deT0rOl2WeM+ALXSg7hY0430rnzithusShVnhwTQxdDTI2wL/m8fpVWyL2TAbp3ar9qv9EWHVGVV2zf7/uc5AryaEX5dmvgQd/Zsg9WuPzdiULYIGpCBM3q9QdZoLwdBPRII+seDF1i42BxEmN7o0EB1ey6Sn4FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dXsj2XWp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GwJlR3aK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AS8rgvG3989693
	for <dmaengine@vger.kernel.org>; Fri, 28 Nov 2025 12:03:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	g1rbYwToiy6vrEo3cBORYpLqQ5be7RIQVsuKG8oVUHA=; b=dXsj2XWpXgQOXeLa
	aAqQVWaY21Pn6MvDMbQE4/PLTC0WNqOghHZGX48heSclJ/JiBVu6QEVk6txrBAz6
	ub6qEg8B5JCIBqAuO1mmavE7DUl8xT5gPk252snPtL/8eSOP8kAXOdVH5qVsr63B
	NmgGMH8vRxNuiFw1IfkypQRVkcAgaVqREEXWj4TnY6y9lKPW37iXRBxPhi0HJ+7I
	JHXl/cAKQfmkdO9L+Q4+4QHit7oQ9ROkATSAv8/95s/NeWxUFuDqBDjo4fP+pSyO
	hgbl1Z+vpQ/EKzEYQ/bUGECnHlrGmg3gRyk6GTlVlEC2jONoWRBTsT0S3Q89d7a3
	T7vzwQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4aq8mm8gw2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Fri, 28 Nov 2025 12:03:16 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ee00f2b7d7so4795151cf.0
        for <dmaengine@vger.kernel.org>; Fri, 28 Nov 2025 04:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764331395; x=1764936195; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g1rbYwToiy6vrEo3cBORYpLqQ5be7RIQVsuKG8oVUHA=;
        b=GwJlR3aKT/6ajh9GXicIegiVJJ3ZmwfzVl1JQkvYvKZUnkFCNDeVsI7glDevZ/uV5G
         9tm2mYo5hjQydFACPsv62klJg5BQGh0bzViJSv2O6tzcuVVGgBxUxwQmOtZRldo83luy
         wjCAwRQnWvI6JJftv8ivFBN+HOXLNz0DyG85BoJ9wuGoN2P9psDBQR/WeSR6cw0ykfuB
         0IIjUpNzXyiY6NTEBTsX2oROYvMsU4BMh6Kb70uW5UZqQf362UrTDIQzQCH8bJAJvk3M
         ze/3QquFEn70Qe1/g+XYfF3HIeXSeFd37i7GMh92rGURTI3VKTCFwgsaRneeTjZhb0wc
         Qwgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764331395; x=1764936195;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g1rbYwToiy6vrEo3cBORYpLqQ5be7RIQVsuKG8oVUHA=;
        b=s44eHCjM56zWsjeVPB0qqbSSK4hFj0xkM5pxWAQwmvF7Faz8B/rCRRBlibCCZScMxL
         mtB3rANcK8AoOlZIEr6riSx8ydTZdUo5i4w20cblUEwpJTSYeX+Lft2Km82Ak/9h2MuS
         TGSTT2qIfCKMhOQ84vSS3W4Z29mBjiB+VivfSfoTPKXyVumW8gvCwXKPRkkYNsfbvoNl
         W1aSYfyg+7djEb12AnYaJUZiilqNq1n/gKp8Qr+E3cJ+oZCwIyknuP1sz80H/PfySTDu
         1J7M9azNHmCb1b9HNarzEM7hNuE6HsxS7s9043EOf6eDcLUCQF0LQrKobV77JI9V/G5J
         2DbA==
X-Gm-Message-State: AOJu0YxeVkHq4SLc9ZizhxrIkIATsgyw4SxoIN2HSam2p/Mdfd12R0a5
	cceqx9wrUSQQKE2apFxZQWUEj795B5KwyYmmLx3s9uZo+chYnC8RMTW9PzcrAGsucXvJSKixyIk
	XZqvFjEjmr02Z8aq0QP5oI/gd1silBu1WtIzY7n8Q8BYkmu/1sb3nACPwqSVCj34=
X-Gm-Gg: ASbGncuEuQt7hCmWGasGdFA1trDJdfXnQn8XEr9BDFLOvK/fwye9WeiukQiqTbEdLye
	n2ZSM2HxnOSCnjnUtEyiY/kwzDlkWNgqiF3x7UcHqjjAeFrH84KWG6YtqJG9Dl4ivkkEK6qJHvO
	h6C6D6iw+DLWRT+0F7adDukHaiGBwLKdZUrXH5+PWXXIH+7TSuBn8m/wqUP6JZxUmCNPrK+rrWp
	+VBMPDyJ9eutI/ngQuk95GJZCIuT/aARUvQoCeqLG6e6nulWG8/r1pBK1jZHIVD06hoHX4OOiWB
	xjZY78z7tWYGOUA16IVBD6MfwJ1Wa7ZFgjxxTz3vS/7ivFfwV9zAXONO/k4rpQpgfxbdSG9bQkZ
	Czzf3vHO0yUkG8WL4blO/cmUXg6nAs+zBJ3wv5rBSrGdVtb5yLvTncTQBGcapV2dsnps=
X-Received: by 2002:a05:622a:c3:b0:4ee:2580:9bc5 with SMTP id d75a77b69052e-4ee5883ae04mr293260321cf.2.1764331395430;
        Fri, 28 Nov 2025 04:03:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHpz0IsBfLxHZyIJ3r4cJaVCTuzbtrQbveyDFdAcyfDdx1RZCSL9CU2KkChwNM2o3JuZNqE+g==
X-Received: by 2002:a05:622a:c3:b0:4ee:2580:9bc5 with SMTP id d75a77b69052e-4ee5883ae04mr293259601cf.2.1764331394940;
        Fri, 28 Nov 2025 04:03:14 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64751035c24sm4149349a12.22.2025.11.28.04.03.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Nov 2025 04:03:14 -0800 (PST)
Message-ID: <22a4ede2-2d9c-4067-b908-a95d3390573d@oss.qualcomm.com>
Date: Fri, 28 Nov 2025 13:03:11 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 07/11] crypto: qce - Use existing devres APIs in
 devm_qce_dma_request()
To: Bartosz Golaszewski <brgl@bgdev.pl>, Vinod Koul <vkoul@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Udit Tiwari <quic_utiwari@quicinc.com>,
        Daniel Perez-Zoghbi <dperezzo@quicinc.com>,
        Md Sadre Alam <mdalam@qti.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-crypto@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20251128-qcom-qce-cmd-descr-v9-0-9a5f72b89722@linaro.org>
 <20251128-qcom-qce-cmd-descr-v9-7-9a5f72b89722@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251128-qcom-qce-cmd-descr-v9-7-9a5f72b89722@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 6MxS-U-uo7LHIJBHuEhSaZCeAyjX8Nq-
X-Proofpoint-GUID: 6MxS-U-uo7LHIJBHuEhSaZCeAyjX8Nq-
X-Authority-Analysis: v=2.4 cv=Cvqys34D c=1 sm=1 tr=0 ts=69298f84 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=wXQIig4NBtMv4ZYXLh4A:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI4MDA4OCBTYWx0ZWRfX4QqLxoFZhEKP
 1rkqcv5om6/YfNsIPXqv6NumfOK1t5aqc0fLR4RH6erJQIUW/rcXxjMk8A7ysc/sbDNdqC2yizA
 uysncj/GS0KAkr6cdB8PaIO8MbgH6ILctGG2ARFOMqXipm2OqF96N2/sVJmDKuwkJLkKG5TEYOh
 ZdUOmiRdSrSs4pj3q140n+TY0M2Najd+3OeIl61agadlOYVOHNAXmsEprcQPGulJ2yWxBsQuEfQ
 fTEsJzeObwlmAjUZBnZQBB1BIpURGgLpBXDiPi9H4N+ydb3DxFes1powjFvhX5xsYMKnoiifjjv
 N+vw+ByuaH3CyXIL9XQNsY0eiHtriSU5WHuyi9hU22OWJ7gp7bfxL2JV+8ie9XQRLGXnfZDRPva
 BzkZMQ7hKoIwoBnyodIVviux2uFofA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_03,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511280088

On 11/28/25 12:44 PM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Switch to devm_kmalloc() and devm_dma_alloc_chan() in
> devm_qce_dma_request(). This allows us to drop two labels and shrink the
> function.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

