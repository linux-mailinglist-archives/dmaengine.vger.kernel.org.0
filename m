Return-Path: <dmaengine+bounces-5628-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE6BAE823E
	for <lists+dmaengine@lfdr.de>; Wed, 25 Jun 2025 14:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D1DA3A8D1B
	for <lists+dmaengine@lfdr.de>; Wed, 25 Jun 2025 11:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A9525F980;
	Wed, 25 Jun 2025 11:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gcAy36CW"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A6525D1F1
	for <dmaengine@vger.kernel.org>; Wed, 25 Jun 2025 11:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750852616; cv=none; b=ZCiH2Zt7hEkFMdySW0U4NWn79tCoa6gdYxnzL41mHoYlQAPOA0/DSeaW1LfEz7BUoCQto7gCbNqWYnQ6d4GxdL9JhhWTCF3B7CrTMm+tlq+N0c8MNV9to/6Y97FGxlIUT3NRh6PaHH6H6twmnFRA4MR+3kZ1EtVaLLsO0ZtJ2ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750852616; c=relaxed/simple;
	bh=BVCdK3npxOuJY1EA2b0sv4BUq030Q9+u3iWzgAMxjkg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FtAxWRGrKrRYD//s+XHtXNmOPRKu+A6tUvcnGnZeJ4M6OpAWKmFuFYnHK/kxOVEpYFG3mkcg3hftQvivBJOOiqVCvMBh1wIqfq5vK0zA3ufMAzPU3S8tWHwAYiLN4r9X4FrS0hYr0jAmmwsih7vOqq6B8+hfe9z58dCoLCicCPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gcAy36CW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55P43vBc028706
	for <dmaengine@vger.kernel.org>; Wed, 25 Jun 2025 11:56:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qtf2LIek4hpLZ54vWooJjQr0lr5Bw40aXqP1yVThXvQ=; b=gcAy36CWTbjZXPo4
	LTSwKhbDedrFZlz2r+vLYTqGQbV/ntVaxiyCSbTWhGgbB4wiL4cFf4RcpxTeukyW
	Z0lUSg7KCMvc5YZyB20FRHLHELnUuDX76MW+Ff5cAnAtskiBNIMufa1fhKxduvjW
	gHpIWW9JY4YOBptfCCSpG9K90osox1ZM/Rb66n+jwJ+O8q2kAZwvwE0hdKiM8oL/
	VGI6Ao8ka2NnGxon+VNonHGnDYpVqFSwKr68tZ6/5EK1kwAgXj8RxJdBKOJdo+gt
	OfsE4gxhBaJrm38QaywRixi3s9AUIk36u4Y/mgV3Q8tLahgjHdQcgtNZuTHthVAz
	pnNLrQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47esa4ryfy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Wed, 25 Jun 2025 11:56:53 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7d3ea727700so95752085a.3
        for <dmaengine@vger.kernel.org>; Wed, 25 Jun 2025 04:56:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750852612; x=1751457412;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qtf2LIek4hpLZ54vWooJjQr0lr5Bw40aXqP1yVThXvQ=;
        b=fLheb2V0YTpnR/9QVPYGUejx2XzG06xDSXYAxruTQT3NdUY0NxyVblmiNgEeB58YmY
         xqfR5n5MeJaKpbmb0qXlktWwWnlN9EpWeDUngX60qBI7nj/rDueTB2H8LvbSmn4qqIXg
         pWU+LhgVv94xs12dK36AljIsDQ+m6c/aHOKZpbV9xlg4Y9Yen/+CDjZr+hKUYvVuaJaB
         jXMHmxMCzGUBdlRhx06mqTCIwLsDT+cRFMY29WdWu8io6pxorbLmKXhKkS5bL+WhZt2l
         FpjyFM+IxxWPd23t1x6BI6GVrMzA1ysJGgUHqcmV+sNgzl3kJpCNabbiNlhGhre1SUDX
         Sh6w==
X-Forwarded-Encrypted: i=1; AJvYcCUlvZVQugfVf2Ic/6VLARD1ZLp+bZIMLg6obl222zZaq97El8WVMuDFIdphalF9CyYOI19CT5GBaOU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwzV8/Ea4/Ew/wujJyeiQzYue9cM2b+NcVoJGzRb3l37SE4D61
	d28WVY+7LziD24fsvVwFfSvkVARRO0CV3Zs0Obpl7/LO+hTOX1O6WWcp+jlDAVh5r5+52k0E0rj
	KqPd/O5I62zw77ushAu7x/rI3qeTR9BdHRM33I1AV0Ep1Gj4Uo9DWFHWb35n+ZR0=
X-Gm-Gg: ASbGncvVRRkexIzx1JP3ixDh+Li9Imt/RXKdDv6ssT+NaIRhK7TaRyFvsFOTgqgUcu7
	3OcvrI2CYms8aI1QNJf288peD5snSx7ydO4oNGnd32kVAiYe43/MoH4lfJZStkGS1FFdjuFohtT
	w1OcoU8S1fBgRsuvMavBbjFbYqzeao5YBV94vRnOQtl/fask79njd/23kKsp0TKDP9Rvudzm7Cy
	kWW2jgHrR02oIZ3sSm3jnsXWXoqq51PeWEdRB/3ihY1tC5oWQQTohOCs6XuZMbmbhXRYJ8EM5I8
	9XKlbv1WUFoKzJF+YFFFBMCxa5eosTcHkrzuM+g61xyzX6gtMFd8Gl8M+RWLKA/MHZsuy4azzXe
	oLA0=
X-Received: by 2002:a05:620a:2949:b0:7cd:4bd2:6d5a with SMTP id af79cd13be357-7d4296db1e0mr156157985a.5.1750852611665;
        Wed, 25 Jun 2025 04:56:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbNAdmHcL/ohxdpxrFhw+P+cQf12Kd+1+opwn8szOOQKrMRERAl3ZBXjt2J5pp3lvClg9lMA==
X-Received: by 2002:a05:620a:2949:b0:7cd:4bd2:6d5a with SMTP id af79cd13be357-7d4296db1e0mr156154785a.5.1750852611039;
        Wed, 25 Jun 2025 04:56:51 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c2f4842e9sm2431839a12.61.2025.06.25.04.56.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jun 2025 04:56:50 -0700 (PDT)
Message-ID: <b98d305b-247f-415b-8675-50d073452feb@oss.qualcomm.com>
Date: Wed, 25 Jun 2025 13:56:46 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/14] Various dt-bindings for SM7635 and The Fairphone
 (Gen. 6) addition
To: Luca Weiss <luca.weiss@fairphone.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>,
        Thomas Gleixner
 <tglx@linutronix.de>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-mmc@vger.kernel.org
References: <20250625-sm7635-fp6-initial-v1-0-d9cd322eac1b@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250625-sm7635-fp6-initial-v1-0-d9cd322eac1b@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=eLYTjGp1 c=1 sm=1 tr=0 ts=685be405 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=6H0WHjuAAAAA:8 a=PtzdWR5wS_Xl21Jse7IA:9
 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10 a=zZCYzV9kfG8A:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-GUID: AxqU4U2Jhi4c_7Q3PyLNfwGbiISj_cNd
X-Proofpoint-ORIG-GUID: AxqU4U2Jhi4c_7Q3PyLNfwGbiISj_cNd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDA4OCBTYWx0ZWRfXxIGswGjfTuG0
 RwId/jNvpCY35dB8ZMR8eqRngSabbaxAlGtGExh652BOAmug1Xr3z9/vf8cAH6QoeT6VO3ukHSJ
 +kS0StgoOGYTiVuFEpt1lvFQ3D0Tso+F8sKe0Fzlkl+8OPbgqrBg+b+OAu6tlOEnfQHSGig6T+6
 gdeTEsOyCorNzM9OMDnqkDMLaYYL3YvdTRKrtrcgfGNa5FAmQsKAoc05SsXEKRQaMkvLxEqw96a
 TEnfwBKvw9you4j2LI7RZ17VZFJp3Iq+GBVf/q1Kmd+Jbn6V2jxZdbZGaBhF5rFfPzLBntcEN/i
 Ysfx0SbpgW7R/7tOgFFQvM9ESNlv+chtC4/lF/SCKWTs+bgSGCmbDzflb9cDApK09Le1vbaFMIt
 IWZqWQuw5rq9kjeYECqZBnOwAqxHpSC3+Rs73xAZ3SyCv/fWpNAhdYrdzuWEAKm3m8YFnFPJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_03,2025-06-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 mlxscore=0 clxscore=1015 mlxlogscore=999
 suspectscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506250088

On 6/25/25 11:22 AM, Luca Weiss wrote:
> Document various bits of the SM7635 SoC in the dt-bindings, which don't
> really need any other changes.
> 
> Then we can add the dtsi for the SM7635 SoC and finally add a dts for
> the newly announced The Fairphone (Gen. 6) smartphone.
> 
> Dependencies:
> * The dt-bindings should not have any dependencies on any other patches.
> * The qcom dts bits depend on most other SM7635 patchsets I have sent in
>   conjuction with this one. The exact ones are specified in the b4 deps.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---

DT/subsystem maintainers, please hold off a day or two with picking up
these dt-bindings oneliners, we're having some internal naming discussions
and want to avoid potential big revert-redo patch sprees, I'll try to
post a decision whether we're good to go with these ASAP

Konrad

