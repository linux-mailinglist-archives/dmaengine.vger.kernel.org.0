Return-Path: <dmaengine+bounces-6637-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 120D0B84ACE
	for <lists+dmaengine@lfdr.de>; Thu, 18 Sep 2025 14:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEF5B3A19D3
	for <lists+dmaengine@lfdr.de>; Thu, 18 Sep 2025 12:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1FE2F7462;
	Thu, 18 Sep 2025 12:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="K05nXNNE"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754C02FB622
	for <dmaengine@vger.kernel.org>; Thu, 18 Sep 2025 12:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758199807; cv=none; b=s0VFXmtX0GX49ItQR7ut13SEPkvWtN5hgO2+T0fADQ9/GBaJayTA7+IBJO8xq2Vo6ovntb6s31DyCg1KvVsqSag9DUUhvPCI3GrEm0oocaBsV6EPhUMozZU1mT6y5wera8dQWpYLuQOBKRQIl3QNNe4dnzNW+gy32uLWieAH9VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758199807; c=relaxed/simple;
	bh=8bH3fVLln3J48TzTAJv9MI99+H7ir7k5BxpHk2Gk6hw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i4qmLTfkUubu1dSKPXiCpEYiHc3ur8FrjWQE1aPBkRD+IrrvUG5Ff3XXP/kuQWAgW1mQOUv5KP5nAnsKxU/NkkgQN+nwa4/IJfl7tFHby5pr6bZwWMd1doA4ISOmjuIwkn1nhmwqZuNIjtdbBW+OsP5LT2lpt4RfVfLtXvRvqDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=K05nXNNE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IBFonn021452
	for <dmaengine@vger.kernel.org>; Thu, 18 Sep 2025 12:50:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ilz57mVIC+jhE/ORoZ8hQRAKB7gQfBSabaTReYEY6MU=; b=K05nXNNETfHhuJ4v
	wa/I0oDvbqWlMeCP+vY5ux7NaDAFMv1k28gJU/CbITklUAda5GryNVJ/DyqYmfZO
	+RSkscaURw1X3k4eeokphNHkITzd++PpJ0f0tTnabq2pkSb+mxoB7sCQ0F/KIJj4
	C6Ib/DviH0RDetuLVkjDgmg4c8BE5AgExO6nO80pw5u3kF4cLm0bJzfP26dAvrES
	QYoW5UKPe9kQGx5JRCAF6MORbaZLvoxu4khstolRwLoHvPxNxyMSMZ/XVRPud2P5
	5UVomkBMlqOOqpAqP7RVSatm+ZrGPKVSc/Oml/b4J/RNjI/908x25prW44nCKC/3
	i+HNEg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fy5ecrp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Thu, 18 Sep 2025 12:50:05 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b79d4154c9so4778531cf.3
        for <dmaengine@vger.kernel.org>; Thu, 18 Sep 2025 05:50:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758199804; x=1758804604;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ilz57mVIC+jhE/ORoZ8hQRAKB7gQfBSabaTReYEY6MU=;
        b=QZF/4+fqWJridppnqhuTf7cM+gV7JHYC3wBe8sfDKkhcxVGbYrN2gq/5ahyfww1ILq
         PTe4zjat1Y2dN/bUXbnh7Z29Wqj54lBp+plP6uznWr/+M/3LsE0hLQuQLgzNPQm42Gz0
         fWJNge3g72MBdJ5HStVcHDb3DlAGrB05Y+KcAUju1UQx6GQYmMmEwWcHdqzx3IV0SWZQ
         ROZM28RXcsJdzvemEa/dV9L6WqDWegN1Hz9fvg3LlnoaIAEv+xYwNzOXUW51l2vy6O06
         uZDzF88KIy8KnMDcGhfOszWfziX+jHE6kBwx5cSr4oowTJ6MjIPqNdVgI31hBxUmHzRr
         bybA==
X-Forwarded-Encrypted: i=1; AJvYcCVpYt3osZSTMsk5YAkacVhD85qQaXXvf/1Zw99xkhLgDNPlsUraSSjA/fSvcB4D6kCLasn4uxe+/fE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhymQKAc1jQs43mhomyBhC6UYl6WLHIS/TW9Q6mA4QFn5IYpKH
	5FIN8nWBM+dXHPOC8RN9w8HXpwb9igBV+7W8N3FtytRCMlakFztN+op2n2goAAljoKoGTjhlS/q
	wIaraGdPtwaiSyYEeE5CyqrvvWQonedl9x+IFlXCQmmBlIJDRyBNlkcHDFhAtoU8=
X-Gm-Gg: ASbGncviWemJwUlqCj5LivIjAOxYCA0n94AbdrlmOOQedb62zuOdytx7rYJmnavDqIf
	gIKGICRNXjMcxdz3aiPu7ZAznz7PVQs7K2K9X2y0+K8Q4iymU4u6P8I+uLRXKwHjCW5ag/l3aC+
	J0NYW8ZAEUyhop95qK/iFh/SnADSkIqTs1+d90uVIEcZOLcI2xihlsXkgC0CYhWAEbU8vvGrUJt
	GZRWnHFarkoLxxIshiLLTorZgg7f2b1PItZR/g/cQNgDteukLxVS7Q6KtdLpcAZTKYaXo0JC3mG
	uFpXvdf/R59WRE2hJekFOfD3OEKk9j/A44ykELmwCiULmarLos5s8t5HeSo9
X-Received: by 2002:ac8:7f4a:0:b0:4b5:d74e:d938 with SMTP id d75a77b69052e-4ba68be3203mr44152781cf.7.1758199804020;
        Thu, 18 Sep 2025 05:50:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRNHFzJzTMA3xkK272o1+K9461PXaGcz8hNcpg8txtT51Al8DimN2qgY98Hx45Cq2m8Q94tw==
X-Received: by 2002:ac8:7f4a:0:b0:4b5:d74e:d938 with SMTP id d75a77b69052e-4ba68be3203mr44152451cf.7.1758199803340;
        Thu, 18 Sep 2025 05:50:03 -0700 (PDT)
Received: from [192.168.149.223] ([78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1fc5f44fb5sm189444566b.16.2025.09.18.05.50.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 05:50:02 -0700 (PDT)
Message-ID: <824004f9-538e-42e1-b40e-dda22e081c4e@oss.qualcomm.com>
Date: Thu, 18 Sep 2025 14:49:56 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] arm64: dts: qcom: ipq5332: Enable QPIC SPI NAND
 support
To: Md Sadre Alam <quic_mdalam@quicinc.com>, broonie@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org, vkoul@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
Cc: quic_varada@quicinc.com
References: <20250918094017.3844338-1-quic_mdalam@quicinc.com>
 <20250918094017.3844338-8-quic_mdalam@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250918094017.3844338-8-quic_mdalam@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: NMIVxcRTMRhIIpDXyEdUp4-5J2p3V7wN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX/XtUIXzlwNLn
 SAYBsIyGgkQl4yA6rdgvzLjADAJWnUg4Mu8rwbdizENafx81V1MNy7B84/GskB+Kvarc2ggEY7y
 vMVrqBhSRqsfbOkNgN+ZDqsIT4EeBmBhg7Dr19NFBp148eZSYMR9BlP8DTQCBSLxkMzBYFPpBIq
 AdWQWupCt/tL3/qKNNi2wc3Ys+cnyWFEysJW9RYGlamPLD5SI9MIXKrLIFEeCXyFahKAif2/fjM
 SzKcBueAfeUlysJaduPuJFVauXRpsBwHKYWmDyv94N391XPK5Z9MIPxSOsUGcEjetbLtar+KV9/
 zfxJo6UOQy7V7gFftbpcUY/aBR4H0g9pV1By/KH88OfPFPb6Ssw2/M8D1c74WRLHs4otCfdzNIb
 /YLmyqjo
X-Authority-Analysis: v=2.4 cv=Y+f4sgeN c=1 sm=1 tr=0 ts=68cbfffd cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=t3lpBGeAFA5ev54tvH4A:9 a=QEXdDO2ut3YA:10 a=VXQMaQTvCj8A:10
 a=kacYvNCVWA4VmyqE58fU:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: NMIVxcRTMRhIIpDXyEdUp4-5J2p3V7wN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0
 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160202

On 9/18/25 11:40 AM, Md Sadre Alam wrote:
> Enable QPIC SPI NAND flash controller support on the IPQ5332 reference
> design platform.
> 
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

