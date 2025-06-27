Return-Path: <dmaengine+bounces-5657-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF84AEB9F7
	for <lists+dmaengine@lfdr.de>; Fri, 27 Jun 2025 16:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 438804A489A
	for <lists+dmaengine@lfdr.de>; Fri, 27 Jun 2025 14:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D632E339B;
	Fri, 27 Jun 2025 14:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="g9kGyX0S"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B3113234
	for <dmaengine@vger.kernel.org>; Fri, 27 Jun 2025 14:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751034879; cv=none; b=StrHF0WLB9KKE0/+RP0LcgcWr6NlTDWwfHlygVM2HYaJEekoyEqrDVE3p55UurBJqzoHs/NIMsODQmfW6+gbC4F7Rrq/bncCmdExenTgkBBnBpge3wPr6M+aFD1x+EwYFOdPrdnpzPGTKVznyj74mvWg/d39/iJ87+Mvdyl7NuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751034879; c=relaxed/simple;
	bh=y8WWwQD7QAEbVl1ij6mKyN6rfl5lkj802t9FgCkxabI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jlgPOUQELaD60B5fWEbkMCXPntbGguJYoC1qz89k5I90zZWmXJxJrV8DqFW1gDfJvTogsKF5gZPfhk4cxrVypX317D+JCXQDIqmBV7Wv+kNJL+hCsZPp//CC7D6gsCJc3MQO/pb7Y9SvVYqNsQLQfX1lCdC3zdi3j327YdKilGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=g9kGyX0S; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55RBmOT8029871
	for <dmaengine@vger.kernel.org>; Fri, 27 Jun 2025 14:34:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1E10iKKXP8Jigq9QsX9VmVPYxg5Fdzb0t1IfPqsxsEI=; b=g9kGyX0SrxzJSgxU
	fMyEz0PRGbEHZKYpUIxtxM+1dkkupe9F8q5VSUopcAyD2dHWwX/T5DhqauMK5j3x
	rd79ABHBHMsyA66zZ93D2n0IDS/Vi5+0Pv7CPABsXYICoBio3GICBQqZwT4aR6lm
	h3aR21xuFGQaxn8dCCehwAy+4ZIttuZkbBknLk0BHFfhCrIobfeNZe+zEKFhyyN/
	lDX/eXmoE7heITzvXuG3KR5bfOT6tbv08U9sYw36rBvuYCKK4lPfl7WdqJBV5ZaN
	1WpGoI6JJ28uOcB1gMHM9dk1vdg1IBRlijSSB1FOYT3JmPQbuemcQ54DiSBko2Vj
	D/liPA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47esa50e8y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Fri, 27 Jun 2025 14:34:30 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7cfb7ee97c5so2401985a.1
        for <dmaengine@vger.kernel.org>; Fri, 27 Jun 2025 07:34:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751034869; x=1751639669;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1E10iKKXP8Jigq9QsX9VmVPYxg5Fdzb0t1IfPqsxsEI=;
        b=jDgjGHYjWGn6bxwj2SM6eR/M7+tIt3Oq4vaKoN/AMCFo20aivh2mNNY6SOwNMK6fmA
         zhy2Z87Th+T8U8veqZ/Hi/B1/RNL3Q/Nep2sGa+E6t199OXldF0KF4i6qUyXjcwaIyCz
         /koAkAwmAmL1Rels+nZeIDI+kamfUbYA8kK6WlzcJuUJUfaDn/VADfOmo6lHjz2UJuY6
         itdaLoqOXqGihZeIYbP0YBuZWsnP0EK4ReQYoNWX4YNCwh0+l9I/MkSDpscY0m3cGnXd
         65M04dcLxeTILrTYkuOLQceX2tVRjTPIxs1rsV6Nn0UID3WPV6VWMWvjzXrIXn/HL9kr
         yp+g==
X-Forwarded-Encrypted: i=1; AJvYcCUtunOKlL++QJIsqtmL5uwkbUbHpzJqzStR6B/+XH/guAORPGJpU53GB7Jqze5Mu4/MppwAbgnOLLg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKzgKNOZBTF7BdqzFoOjhBsXl1EdpbTkcEWlqKl5/UW/sFCnqx
	aqOH2zEHoTQ5AIhQmka9AvrYfaa21+FRzn3KXfWr/92VS9j4LX3DOhMuXx/AnVkAAFzteMLxxjJ
	p2yHFbVdbrHjU/sDxh06eNUlnxCfaMxVBHum6WAQEn0VQMhyB92ILRz+9kKhcipE=
X-Gm-Gg: ASbGncsEutUtAyGIixtVT3Mr1LxmZO4Wrq+eLP6Bzff9QgCq/tVnZvCPItgt1fdr7WT
	WTQa0txxNWhLQZ03UbqB5fyBYqTkfvSDhid+lsSka1iBxOFrz2zXrLpzuuBCXawMhLiJFSchA8l
	goMQk7VSpUm6YX28N2ra6QENY5idcR6hoy06m6wJK41vxc6lNOJKUOIbkh2fDVx6NMpNVaaOjzZ
	vjhbjpu2/Cy7P50r7d945F/o6oLwsaapZk1Wk0PlX9PTBVBXdDcM/AQ8W52yhdYzRX4YjXOqzZm
	z8UpJdqKi1cu/uzDWrWs+HmTrGAfEt+LHmrJe6BBDxkf6MysPWHAkYRPpFANo/A3hJ6Q+k645X/
	OpEQ=
X-Received: by 2002:a05:620a:684a:b0:7d3:c688:a590 with SMTP id af79cd13be357-7d4438f895dmr150830085a.4.1751034869361;
        Fri, 27 Jun 2025 07:34:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGL+0Argf/YR+lQnOb5qAOTTQjAM3ncoqVGAETIjGQblJ3e07wKcIT22ODvigY7oQFVVuPf0Q==
X-Received: by 2002:a05:620a:684a:b0:7d3:c688:a590 with SMTP id af79cd13be357-7d4438f895dmr150824885a.4.1751034868338;
        Fri, 27 Jun 2025 07:34:28 -0700 (PDT)
Received: from [192.168.143.225] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353c015c3sm132768266b.100.2025.06.27.07.34.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jun 2025 07:34:27 -0700 (PDT)
Message-ID: <6d4e77b3-0f92-44dd-b9b0-3129a5f3785b@oss.qualcomm.com>
Date: Fri, 27 Jun 2025 16:34:23 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/14] arm64: dts: qcom: Add The Fairphone (Gen. 6)
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
 <20250625-sm7635-fp6-initial-v1-14-d9cd322eac1b@fairphone.com>
 <4200b3b8-5669-4d5a-a509-d23f921b0449@oss.qualcomm.com>
 <DAXA7TKVM4GI.J6C7M3D1J1XF@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <DAXA7TKVM4GI.J6C7M3D1J1XF@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=eLYTjGp1 c=1 sm=1 tr=0 ts=685eabf6 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=Sqmq4kN4DPMvB5fHc-YA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: DW4NCne8PnlitUiQNUEKoLP26BiOEPu4
X-Proofpoint-ORIG-GUID: DW4NCne8PnlitUiQNUEKoLP26BiOEPu4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDExOSBTYWx0ZWRfX4ZEI6xbZ5tsR
 hD+6IWQ4ZcnyRFTQWVXMBl97WxcudCjTjsLOGPep6qnMuDKMLgP70x2bicH3VWVKPPUtvJ6vMkQ
 FqE5fcPn4fEdtE5eyugLLwDgxt4GznIerY9iYn3FAgbGsn43oMwnmOCAtg1dmvLcVxIyurdFxMn
 tMd0brj6TnGJo9D/BnCR+6oAWe9SevdYNnr1ZjQpK5uGzLxSAQL5yMZsDixD+SzyJeK+WgSIoAJ
 HKC8Omfnsl8aIs1cQHpvTeIX0MWzRr+x+LIpuLNUD3Q2E/cNCmIdbkIRPxhLLjaNsyskZ7KfsTT
 TylfJLLTBjt/SGdT4apgytPId4wyoYJZQFOaZTwF1nHguq29whXDaC+4giGBIztxWQQTazH8+BK
 hCrKDgWL3sGuGMaRTIXVMZIkKe3g4gNKqsxPtrfT8bWClHiQ/ekbIlwTGzW8OFnw0lpn+OSG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_04,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 mlxscore=0 clxscore=1015 mlxlogscore=999
 suspectscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506270119

On 6/27/25 1:33 PM, Luca Weiss wrote:
> On Wed Jun 25, 2025 at 4:38 PM CEST, Konrad Dybcio wrote:
>> On 6/25/25 11:23 AM, Luca Weiss wrote:
>>> Add a devicetree for The Fairphone (Gen. 6) smartphone, which is based
>>> on the SM7635 SoC.
>>
>> [...]
>>
>>> +	/* Dummy panel for simple-framebuffer dimension info */
>>> +	panel: panel {
>>> +		compatible = "boe,bj631jhm-t71-d900";
>>> +		width-mm = <65>;
>>> +		height-mm = <146>;
>>> +	};
>>
>> I haven't ran through all the prerequisite-xx-id, but have
>> you submitted a binding for this?
> 
> Actually not, kind of forgot about this. I believe I can create a
> (mostly?) complete binding for the panel, but this simple description
> for only width-mm & height-mm will differ from the final one, which will
> have the DSI port, pinctrl, reset-gpios and various supplies.
> 
> I think I'll just drop it from v2 and keep it locally only, to get the
> simpledrm scaling right.

Yeah I think that'd be best in general

> 
>>
>> [...]
>>
>>> +	reserved-memory {
>>> +		/*
>>> +		 * ABL is powering down display and controller if this node is
>>> +		 * not named exactly "splash_region".
>>> +		 */
>>> +		splash_region@e3940000 {
>>> +			reg = <0x0 0xe3940000 0x0 0x2b00000>;
>>> +			no-map;
>>> +		};
>>> +	};
>>
>> :/ maybe we can convince ABL not to do it..
> 
> Yes, we talked about that. I will look into getting "splash-region" and
> "splash" also into the ABL (edk2) build for the phone. Still won't
> resolve that for any other brand of devices.

Gotta start small! Maybe framebuffer@ would be more """idiomatic"""
but potayto/potahto

> 
>>
>> [...]
>>
>>> +		vreg_l12b: ldo12 {
>>> +			regulator-name = "vreg_l12b";
>>> +			/*
>>> +			 * Skip voltage voting for UFS VCC.
>>> +			 */
>>
>> Why so?
> 
> From downstream:
> 
> 		/*
> 		 * This is for UFS Peripheral,which supports 2 variants
> 		 * UFS 3.1 ,and UFS 2.2 both require different voltages.
> 		 * Hence preventing voltage voting as per previous targets.
> 		 */
> 
> I haven't (successfully) brought up UFS yet, so I haven't looked more
> into that.
> 
> The storage on FP6 is UFS 3.1 though fwiw.

Hm.. can you check what debugfs says about the voltage at runtime
(on downstream)? I'd assume you won't be shipping two kinds anyway

[...]

>>> +&pm8550vs_d {
>>> +	status = "disabled";
>>> +};
>>> +
>>> +&pm8550vs_e {
>>> +	status = "disabled";
>>> +};
>>> +
>>> +&pm8550vs_g {
>>> +	status = "disabled";
>>> +};
>>
>> Hm... perhaps we should disable these by deafult
> 
> Do you want me to do this in this patchset, or we clean this up later at
> some point? I'd prefer not adding even more dependencies to my patch
> collection right now.

I can totally hear that..

Let's include it in this patchset, right before SoC addition
I don't think there's any pm8550vs users trying to get merged in
parallel so it should be OK

[...]

>>> +&usb_1 {
>>> +	dr_mode = "otg";
>>> +
>>> +	/* USB 2.0 only */
>>
>> Because there's no usb3phy description yet, or due to hw design?
> 
> HW design. Funnily enough with clk_ignore_unused this property is not
> needed, and USB(2.0) works fine then. Just when (I assume) the USB3
> clock is turned off which the bootloader has enabled, USB stops working.

The USB controller has two possible clock sources: the PIPE_CLK that
the QMPPHY outputs, or the UTMI clock (qcom,select-utmi-as-pipe-clk).

Because you said there's no USB3, I'm assuming DP-over-Type-C won't
be a thing either? :(

Konrad

