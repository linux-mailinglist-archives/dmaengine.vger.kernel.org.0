Return-Path: <dmaengine+bounces-7383-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC18C9208C
	for <lists+dmaengine@lfdr.de>; Fri, 28 Nov 2025 13:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BE873A79AD
	for <lists+dmaengine@lfdr.de>; Fri, 28 Nov 2025 12:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA5332B982;
	Fri, 28 Nov 2025 12:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lk/Wrfxj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JgWp7+CQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D7D32ABDB
	for <dmaengine@vger.kernel.org>; Fri, 28 Nov 2025 12:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764334645; cv=none; b=bcYOuI2L2bkz8Xf3XVN9xouOWA9u11Io4oHKSxnLRBCIYR+HExuetLupdlCT1rYnWH92wX6bl8dFLCzeejrQkhbyXbAgqCl0F6QQ6w9YXDVctzgcNLwuM4IKdwQpxfXax/W8h7GW4Sqor4EsGPeT/MMnV6d15I5casbDfjo87Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764334645; c=relaxed/simple;
	bh=Phg6H+8nPm5k0Q558yIc97aSgJoiWcWIP+LnfjeaZ+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JfQjW82h8h+AipaVSrXYqDEWV5Fs+a+1Iea3kEZb2RiWBiaF7E7ehdWX/3UZlEi1kW0/N+1asjDSnRUMIxz2AfXG42YiFTRRC3d9k/3s1ScYbu9tIVhBGF7SKZ5OBLCNQ7MROpuqWvRBld3vB7ZAXjxb07YJuP0KH+NV4v3kvXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lk/Wrfxj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JgWp7+CQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AS8rf6e3989598
	for <dmaengine@vger.kernel.org>; Fri, 28 Nov 2025 12:57:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	T4+S1KsCR+oTu8smc9oP0UxTPmQjSIc96c8vpuCaAbo=; b=lk/WrfxjzDy5T8LV
	+Pz4WMjA0eeMW2573oRzz4R2Dxggzi5ipotdOi+Z6DfUzMAOlURK3D2obZTqAsPy
	xfxrmwOsL2tK/PXd/iGqw9ED1QbtX8tYu9uxaQn7TWkQ7Uypa8A5Az+DeJOMfM4D
	VKhcFCim3pQB5c1LDR1/Z3pXqT20GaAZtHjrD+f6XOhXZuFC2o/Q5iWDgx48BCi7
	BmABnK07rjDZv5kLK34v3tWUtkZLSnJwLAeIHULokd53Kyox2TkJnMWeUp9zqI84
	W2ScLTPeOdsuQraiut1iXppI8B9rhhEBhBZ5aULFRvEKMArMDwv5yJIEDBwnVzm4
	jQXUuw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4aq8mm8n4k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Fri, 28 Nov 2025 12:57:22 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8b222111167so32614185a.1
        for <dmaengine@vger.kernel.org>; Fri, 28 Nov 2025 04:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1764334642; x=1764939442; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T4+S1KsCR+oTu8smc9oP0UxTPmQjSIc96c8vpuCaAbo=;
        b=JgWp7+CQuQi9510LBSSqAXaVqVCALIkRAuwopHTwMQYQ7RrXiq6MDA6SQsDaAhUsZ/
         lq47uEMkQFHvJU28EGmZgc9QPKyx+90zVcoRH7zh3Wd93AgMpcWI/tYkYP45mKw2Hr80
         0/qCZIiX+86RlHDEvVJolzuQ8vN/qw5mTir7OkovmHfVWm6EL897sejKgEc3fd1K4I71
         w3nmIMdmsdpwpsocw6lxq+G1loOR0gC8oYzkCrY5kI9DLQQUj9B/jg23mtYLCJuy10eY
         0D4NWrGGnydN2h+ez5KnQ8BbgpnojuOE45lY6KAZl3S+dTdqd07xInjvy28zJxkOTP6K
         IDhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764334642; x=1764939442;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T4+S1KsCR+oTu8smc9oP0UxTPmQjSIc96c8vpuCaAbo=;
        b=XKuGHtnm01gNC75PIK0Biv6B9dU81wAkoyXt66FiShROjMtJHv6k2OGy2Yh7Qr1tOZ
         6lzJouqaSlQp1oH+WiV/Qd6JmOuOwHN5oDohQacWrD41w/+vFZSc5IkzYAeFAh8ZOCEc
         Yyd4JXb0Vw/LTCrMf1sh8bsJKAPyxl4gakr5KT8vliLqL/ksfhGCjyfnHB7wXlCHxsfU
         /EpAC3vMnL7SAFHXbIpZtbYTNVZylgmfM9ypq+RQdC+TKyTPJtlTtBhFcuBQK7qWc1X5
         v3apxmbOVi2dHEj+QIalZp7sC1mtsaamgBq9lAa0c99UFTQvnXQhUsdXF2v6C/OixtfI
         tQCQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0sh7vnNh7Q+39Unu3DspwwvoYJnHFkyNDan6IF+akUxefkCOl2CFICGR/2iBhZ0ieENJQtfF8TIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPWWVOBPu9hBxC2372hSSB32SxTCTNNGlOArOeqlKefPTu9RIJ
	Y3L0WfvFe5OA8CALELDjyHyYop9ECJz+1OPUVHvF5YsBnK1HSkQ0JRMFYJYTAE8qjH7m7rbDsN9
	Br55tcdvJXndQyxNLc2/LYglI5UtvVjr/xf1daeSWrikPHZyinKUsyVqekaAFH7U=
X-Gm-Gg: ASbGncvfQLNldoSZn35xUb80VU+8f7gc7Rj0prdRCCkocSthpc5dRk4Ca6ReQmYamEN
	w7wDvoxtr4Z4JM2sPrJJ1RbBp1Te76EoHy8UWZLyiBCOBtimt/j55ILWUM7eGOLVycm8exfAV/n
	5oh23415rNxmhFOa1y0nMhYaS8ekFKtQBHTfq8F1rJE7e9sMyaFDSAdtHI9wOS4q99U8+hXwFsF
	FFg3DWXbNwna4FELgrBGIlwiATc71RDpQ0tDkM2oEFkAEU5HUfFh4S8diwaGBEUVPuTrbXwluw1
	QidQ9JKZZu3LMAuJwxJYiEZFARiqnlxteO3kItBEHQb306gxHqilIAm9H5q+ANRQ7lKr1R7a6VB
	sEuQj7zmmmK5KN35PkyyXQWC2UaNBcRawaSFK4nwjxQeFgkDapCzbQL+G8u3t1RumNtA=
X-Received: by 2002:a05:622a:211:b0:4ee:1588:6186 with SMTP id d75a77b69052e-4ee5b7badc4mr265850311cf.11.1764334642330;
        Fri, 28 Nov 2025 04:57:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFDeoOKipkkD6z6uDYBWbGsDCociwucSXrzeeVHv4vzgh2zwyR3EFUyJx41RNOHudMy5Znk+Q==
X-Received: by 2002:a05:622a:211:b0:4ee:1588:6186 with SMTP id d75a77b69052e-4ee5b7badc4mr265850031cf.11.1764334641913;
        Fri, 28 Nov 2025 04:57:21 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-647510615c0sm4352008a12.30.2025.11.28.04.57.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Nov 2025 04:57:21 -0800 (PST)
Message-ID: <183b845c-5fd0-44b9-8133-9741acc94cd3@oss.qualcomm.com>
Date: Fri, 28 Nov 2025 13:57:18 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 11/11] crypto: qce - Switch to using BAM DMA for crypto
 I/O
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Udit Tiwari <quic_utiwari@quicinc.com>,
        Daniel Perez-Zoghbi <dperezzo@quicinc.com>,
        Md Sadre Alam <mdalam@qti.qualcomm.com>,
        Dmitry Baryshkov
 <lumag@kernel.org>, dmaengine@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20251128-qcom-qce-cmd-descr-v9-0-9a5f72b89722@linaro.org>
 <20251128-qcom-qce-cmd-descr-v9-11-9a5f72b89722@linaro.org>
 <afde1841-f809-4eb2-a024-6965539fcb94@oss.qualcomm.com>
 <CAMRc=Mefy=6XDzA2bqe6g_AZS3bbdNEKoq4Z9hV8VwSq5mYBSw@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <CAMRc=Mefy=6XDzA2bqe6g_AZS3bbdNEKoq4Z9hV8VwSq5mYBSw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: XekKdWDgZwHykypgHFbd7d9C8KlKSA2s
X-Proofpoint-GUID: XekKdWDgZwHykypgHFbd7d9C8KlKSA2s
X-Authority-Analysis: v=2.4 cv=Cvqys34D c=1 sm=1 tr=0 ts=69299c33 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=LOu_IrZLGVboqkKOeDoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI4MDA5NCBTYWx0ZWRfX98cfrWZqr5WC
 z1tWFlj8JG/3fxNMER6IFUDRemZRrFWWxbIMCqn29B6qBYhIwzIgKRZv2VtugQWFU/sdkieGs2p
 sn2mo1PGMD0s2TinxhrMcBYYdnmyd6hh4gwd67lXGyup6kRmF6VO9RaCoOdcDhblWb9Lsj7uOlE
 PUtjZOqnLBcsawaxe2BAEzBTPYDo9S+jYRMjuTDQN/SK44vzIcEyHdoRyaGwYy949tN7/Wd8HN0
 A6Z9ou8ZLgJ7gLyXBrEd71Rkz0COrAHwB27bWwJcdmiu6/AplUdW9OXBnMf5QQ1+/Nh+vXpaSvp
 s8Z/RYZf/A0bGrbMmTqFACkr0eYmzrY57GctWzvpbn93bgYrBCugZmstUT59U20FUZZLctUtgx8
 7K90hSDWsLS9yvg8HqsZh0UFx0H0iA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_03,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511280094

On 11/28/25 1:11 PM, Bartosz Golaszewski wrote:
> On Fri, Nov 28, 2025 at 1:08 PM Konrad Dybcio
> <konrad.dybcio@oss.qualcomm.com> wrote:
>>
>> On 11/28/25 12:44 PM, Bartosz Golaszewski wrote:
>>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>
>>> With everything else in place, we can now switch to actually using the
>>> BAM DMA for register I/O with DMA engine locking.
>>>
>>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>> ---
>>
>> [...]
>>
>>> @@ -25,7 +26,7 @@ static inline u32 qce_read(struct qce_device *qce, u32 offset)
>>>
>>>  static inline void qce_write(struct qce_device *qce, u32 offset, u32 val)
>>>  {
>>> -     writel(val, qce->base + offset);
>>> +     qce_write_dma(qce, offset, val);
>>>  }
>>
>> qce_write() seems no longer useful now
>>
> 
> I prefer to leave it like this if there are no strong objections. It
> reduces the size of the final patch and also - if for any reason in
> the future - we need to go back to supporting both DMA and CPU, we
> could handle it here.

alright

Konrad

