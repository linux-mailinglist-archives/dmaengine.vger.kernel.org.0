Return-Path: <dmaengine+bounces-4455-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C88A7A33257
	for <lists+dmaengine@lfdr.de>; Wed, 12 Feb 2025 23:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F410188B900
	for <lists+dmaengine@lfdr.de>; Wed, 12 Feb 2025 22:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47190202C50;
	Wed, 12 Feb 2025 22:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gwn3f6J/"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330951FF1D6
	for <dmaengine@vger.kernel.org>; Wed, 12 Feb 2025 22:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739398759; cv=none; b=Qy+UAjGpcI2e0/3z65QtJc+7nNIifNFNVIPTVqOfDpJI0aAtYdwJM1OwsGzxDkt9BemVs1z5LN+gNHXrL92sCu058oS5Iyy0sPRoFO1Vo1WSqqdGcJhKjyDK4uYHeg4TCb2cNyz/frmeEcMtziMpHgJ5tqA0Xn60M7bhttSpucE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739398759; c=relaxed/simple;
	bh=yT1WThL1jBPrtugQr7EiuZsrp6TpMNWAICvvKnpVO3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eK44AoHVNxSgYQCTdAcc+twQ7GYqLgF/9cULn/B0BHWGQuWe9HkZDStLf13zJXI3M4AKKCLmOOvQVJ85CjoFcddL+HBn+13yzyFJrGwGxV+my/t1AJteksDzJO/M1mTLoamMhDPaMNCYthpvelGx53OjQWovKlaK/T7qwR4viIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gwn3f6J/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51CLMkkj023023
	for <dmaengine@vger.kernel.org>; Wed, 12 Feb 2025 22:19:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4HSI5ASZ9NS3VrXEUw0edbnKWJTKfnfNBpv34oiqKVg=; b=gwn3f6J/hc8jAOFb
	gOixYwhjRvLJ/C4/Zc6kF5j6KSueL184g6MVJoGbBo3u7YeZdnidQl4sh8jDM9Bl
	mTxSOkyh/HtvgD2nt67PJngnNIPlQgmmXr3+W2m5esTG5r1U9WaxZQjEHe8prDZk
	xDQdOAil7Z8ElJJNBT3VMl2Fpi1xB/TyBFd6qm/1pIa9KNhgbOj/pyqqsogiqf4+
	A7ykpd2USb6tQvPx4zoaDMzv8sP40OwPAqQ3pa7va1ZB6o2iFCDdEldC4V7lmwJC
	ZQZgA4wtARelaFPKKyeelyMWPOzPNlcCZY5TBsTHxOZHsRFoIzSWjwpVVoFxRsxh
	mxTsvA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44qe5n0v0x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Wed, 12 Feb 2025 22:19:14 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6e422f1ceadso797816d6.0
        for <dmaengine@vger.kernel.org>; Wed, 12 Feb 2025 14:19:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739398754; x=1740003554;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4HSI5ASZ9NS3VrXEUw0edbnKWJTKfnfNBpv34oiqKVg=;
        b=DI+V+i1bD4InmEotilNg61LVzNUjd1QoekXWbIWmF6uaroTCHumn4n8kHBhXd+EDx0
         poayLniV01ub/xXwTvNw0XHHgZzc8xZ3DHYDj8dSWQLnSHTrcyEGXg/tgXvWanTC7JR3
         73IjuLUJ15ZPvLghkAKFcioI+5sSUCGpIjn3z778cUXf+gp0mgC6VWP8c0IiTGCWcCGT
         1Hnf3wSRxeRF7hti9Vxwic3AxfT6CQ383Kt7/7JxRzYGTXIVHm03plBVc/yQckOxFI1M
         En1rIcEhKKRGqF2TyzSOfjuNE4GxXCf+02l9vfKRLyFjbIhMGeEh6MyflaHFgV2V8i00
         fiig==
X-Forwarded-Encrypted: i=1; AJvYcCWyz/FikoPiFSw90b89xNRa1Dx2Vj0cIndp1R5xyef6AtcfA7vBgmIFylFgpuHcqLY2AYTMFJvdVcU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDDPgME2tepE3Da5H6cUdafdgUS6TpsiG1W8+SyLlAwXjJWJ2H
	RZnKhaMnghsktO5K+GlAntJKxdjKTB18M17peCgQ0ka3r6RnTxk6N87klA/hupHXPafaQ1YNI5c
	Sg2bxQ+CXjc8v7Qdmyjp5vCjBg6QPOwuJu1tjsy1aKo4ULZOKfZ633ZaeCGw=
X-Gm-Gg: ASbGncsGlU7VH1dAOUds4LC98Vvttht+rjIbn8vSt6jMwju7rYjP3fD/KGpgSuO4v7f
	86kwlVa1bWmx41JRAFjH7NnGoMo5ewjpGsvuUHDtzYWEw/PkafjY5J7V5Kiu5wtrlzyrkwQXfQ8
	QG+Xk+PW3hGymJyNGzvFDEKy+9d9Q8Ft9dnvPjezF7VJCNIbX1FzDURfvM9GKBdW1Bbk2VtMqTc
	5NMIzELqb6dedZAGxDDrBe2Z50RdFGMYqvZyV7gkN/j34GRXWmdjPkH9WKd6B3LptUNSJ24CCfN
	NOclMYdAAQrrXqm3PjzYp1WiyL6HqBGboW958UxU/7jDlsJcbEih25NKgsw=
X-Received: by 2002:ac8:59ce:0:b0:467:6bbf:c1ab with SMTP id d75a77b69052e-471afdf1d29mr30712981cf.3.1739398753962;
        Wed, 12 Feb 2025 14:19:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGK6Ge4ebchMzt0HUQfcJ6HYI/Xh1Ud54kYJSjBnEpQ0vQMeGzVjf5lSNzNOHaDSn8ZJvY5bg==
X-Received: by 2002:ac8:59ce:0:b0:467:6bbf:c1ab with SMTP id d75a77b69052e-471afdf1d29mr30712721cf.3.1739398753478;
        Wed, 12 Feb 2025 14:19:13 -0800 (PST)
Received: from [192.168.65.90] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba5337653fsm3419966b.102.2025.02.12.14.19.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 14:19:13 -0800 (PST)
Message-ID: <a967c354-cb33-402a-8be5-2a89a5108946@oss.qualcomm.com>
Date: Wed, 12 Feb 2025 23:19:10 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] dmaengine: qcom: bam_dma: Fix DT error handling for
 num-channels/ees
To: Stephan Gerhold <stephan.gerhold@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Yuvaraj Ranganathan <quic_yrangana@quicinc.com>,
        Anusha Rao <quic_anusha@quicinc.com>,
        Md Sadre Alam
 <quic_mdalam@quicinc.com>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>
References: <20250212-bam-dma-fixes-v1-0-f560889e65d8@linaro.org>
 <20250212-bam-dma-fixes-v1-8-f560889e65d8@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250212-bam-dma-fixes-v1-8-f560889e65d8@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: apnXHh5RdJtQwLV8SK6FCyHayb8eohsn
X-Proofpoint-ORIG-GUID: apnXHh5RdJtQwLV8SK6FCyHayb8eohsn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_07,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 clxscore=1015 suspectscore=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2502120158

On 12.02.2025 6:03 PM, Stephan Gerhold wrote:
> When we don't have a clock specified in the device tree, we have no way to
> ensure the BAM is on. This is often the case for remotely-controlled or
> remotely-powered BAM instances. In this case, we need to read num-channels
> from the DT to have all the necessary information to complete probing.
> 
> However, at the moment invalid device trees without clock and without
> num-channels still continue probing, because the error handling is missing
> return statements. The driver will then later try to read the number of
> channels from the registers. This is unsafe, because it relies on boot
> firmware and lucky timing to succeed. Unfortunately, the lack of proper
> error handling here has been abused for several Qualcomm SoCs upstream,
> causing early boot crashes in several situations [1, 2].
> 
> Avoid these early crashes by erroring out when any of the required DT
> properties are missing. Note that this will break some of the existing DTs
> upstream (mainly BAM instances related to the crypto engine). However,
> clearly these DTs have never been tested properly, since the error in the
> kernel log was just ignored. It's safer to disable the crypto engine for
> these broken DTBs.
> 
> [1]: https://lore.kernel.org/r/CY01EKQVWE36.B9X5TDXAREPF@fairphone.com/
> [2]: https://lore.kernel.org/r/20230626145959.646747-1-krzysztof.kozlowski@linaro.org/
> 
> Cc: stable@vger.kernel.org
> Fixes: 48d163b1aa6e ("dmaengine: qcom: bam_dma: get num-channels and num-ees from dt")
> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> ---
>  drivers/dma/qcom/bam_dma.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
> index c14557efd577046adc74fa83fd45eb239977b5fa..a2f1f8902c7f88398a5412e8673e24b3c10bb86f 100644
> --- a/drivers/dma/qcom/bam_dma.c
> +++ b/drivers/dma/qcom/bam_dma.c
> @@ -1291,13 +1291,17 @@ static int bam_dma_probe(struct platform_device *pdev)
>  	if (!bdev->bamclk) {
>  		ret = of_property_read_u32(pdev->dev.of_node, "num-channels",
>  					   &bdev->num_channels);
> -		if (ret)
> +		if (ret) {
>  			dev_err(bdev->dev, "num-channels unspecified in dt\n");
> +			return ret;
> +		}
>  
>  		ret = of_property_read_u32(pdev->dev.of_node, "qcom,num-ees",
>  					   &bdev->num_ees);
> -		if (ret)
> +		if (ret) {
>  			dev_err(bdev->dev, "num-ees unspecified in dt\n");
> +			return ret;
> +		}

I like dev_err_probe, but this works too

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

