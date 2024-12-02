Return-Path: <dmaengine+bounces-3848-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6101C9E0452
	for <lists+dmaengine@lfdr.de>; Mon,  2 Dec 2024 15:05:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22EBC2823CA
	for <lists+dmaengine@lfdr.de>; Mon,  2 Dec 2024 14:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612C32036E3;
	Mon,  2 Dec 2024 14:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jIQhBeZ8"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F2B202F7B
	for <dmaengine@vger.kernel.org>; Mon,  2 Dec 2024 14:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733148299; cv=none; b=Zmt4kBqsOEIpjIrQljvaAs63/mWtQ4F73WEZCQxVoBNSUJ4xyy9+mRJuE6NAIZW7yT1PagBieaODYkvK2gMmvEJygtgJxWNrbBI1alV/t6W74u6Ic2VevDPPHm3KPSU5zhfrSP580LCNVVaMbLW7anljEQoTP7lso0M+q84Qrw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733148299; c=relaxed/simple;
	bh=aCYEkOOpOjkMmGmDP1MwOlRPzT0/3YQQiUfyUisKajQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aLHgja0QtG9DVHxn1K4BtWxPVyfnQfsjnj45jO0MSzoPXUHf9erwPVbaNXXy4YdnZzuPgjp01TCSqbY19Y1osqdv0COH58p2DBLbsp/lOBHLRNurisGy/KfgrpKVACzjPBP/4nkUiU7SoXRWYUhUni1tVs/jcpUOC5Dl/H5G6LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jIQhBeZ8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B29SMjl021814
	for <dmaengine@vger.kernel.org>; Mon, 2 Dec 2024 14:04:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	obaOPszO5mGm/TOqEFLd2+ypX1a+TNEXvHr7XvUqJ7E=; b=jIQhBeZ8H2dDtMVf
	P7Kyqn6cy62AuXpsil62QSHvcfgIJ1S6nKJ6/tMk2uBDZyBq5Uy56+Tkfi6x05ne
	T5NEuTOKHslTq5ar6lKhsmzQKKs0G33w1DCW71BlTlZIbr4hzm0tvWmZOiPc1xOm
	E85bOxD8/ogLbbCykmzhPnvWzR6sGusHHNlAKeNHBzDoDDqNcY6JyGO/PTx6kkO2
	ZviRNau3d5wEDrb53Y4q7glL6pqMVUUIV9SM0cZl1TFt6p7yxSoq7hLDftOoYB9k
	xJt/HgRzlV3qFMXZ9zE0cc28lVQtZE1vEGSvigc8PDu0HLOopyKDzZF7iV6dJk7n
	Tgu/ug==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 437uvjvupq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 02 Dec 2024 14:04:56 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-466cbd99b11so4942521cf.1
        for <dmaengine@vger.kernel.org>; Mon, 02 Dec 2024 06:04:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733148295; x=1733753095;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=obaOPszO5mGm/TOqEFLd2+ypX1a+TNEXvHr7XvUqJ7E=;
        b=ezQX1zyujLifTlclIBDXuwqCmm0ahgWPnc2RVn15cMom9zRz3a1uuPDXj9/5pXuzr7
         q2K7XpU853pRCuruQGXae/HUVLAOW9XiF4dB17b/l1oe45O/PE6fDlVAiNQW8VMEm2XD
         6G/KG2otLDKenawmwuQfLQYLxRGAonAbVlkRAfNDO1TBbJ87lrpxyt7FJCp+CC/Ze0jk
         hR4K9GQkmR2+XcdXd2VqJGhcmMSLSOYqsPL8ZhX/uSy6Qk82cQ9+VDeYjXMDMBTyQUcZ
         9EIOqpfai5ctRNAcz//hFlbklWYNmh3lBZhbtVs+HZ/EHf0rpGmT5Xzp9Jst4iYGZQr7
         Qjhg==
X-Forwarded-Encrypted: i=1; AJvYcCVe4r9hk+D4YJZn0pES/fEo5YifYRogZHQjXowIom/ikRMhsECORKerUDoLkHF+/NXwgCU7IxNAPsw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIMSxMXDV4fzVUvCdlXj3/E3uoOQwo8RoZYMVZBnvwUzRnyeK6
	XKste5QvE00khItNMfhARMiiljcDcKL45gubyOG85fZf9R1cLDksVc5I6PVYUsEQnjTm/t1R9Wj
	0h5Dg4cO9gKhqqTm58ZfkXXCXjuLJ7BnbD6g6QF0coPnJFxVAXp7ow+EtDYM=
X-Gm-Gg: ASbGncskEA4SFLo1vjqTnP+3SL7ocyAm5OIgK+KPYuzvMdTr1vaWtAQ/BFgIbtYoBvS
	QBomRDIN+VAN1OIGWMn7M5HVzt2pd6uaWs8QhdqFYznmzCejOFmwv94fG86xCL775BTsOMD5Yuh
	ogC2vkptWK6R6T2YbrhkVkULZ4/PCLSceQiA++LC2bldm4ErDEWlKkerSTFXPo5CUhRa5FEOl8j
	BCRn3AR+7xyNXixKBxfkkGSwTlnON9cn7NZsh0Uc3tazNmCfmoGFtjjQiIFqtcX07uFErJUGFtR
	ylnFjJUoAk3UpFUAEUODIj+9UUCPWk4=
X-Received: by 2002:a05:622a:5792:b0:461:1fc9:61a3 with SMTP id d75a77b69052e-466b35d760amr125683991cf.9.1733148295167;
        Mon, 02 Dec 2024 06:04:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHcZ81mFmkrUNeLqEFEbFVMmp5vJUXLKK5kw3UAW0/7jWrcoiWhxK7YAGq7iyqIpT1YBAn9qA==
X-Received: by 2002:a05:622a:5792:b0:461:1fc9:61a3 with SMTP id d75a77b69052e-466b35d760amr125683631cf.9.1733148294536;
        Mon, 02 Dec 2024 06:04:54 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5998e6dadsm513906866b.132.2024.12.02.06.04.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 06:04:54 -0800 (PST)
Message-ID: <a7186553-d8f6-46d4-88da-d042a4a340e2@oss.qualcomm.com>
Date: Mon, 2 Dec 2024 15:04:50 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/4] dt-bindindgs: i2c: qcom,i2c-geni: Document shared
 flag
To: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, konrad.dybcio@linaro.org,
        andersson@kernel.org, andi.shyti@kernel.org,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        conor+dt@kernel.org, agross@kernel.org, devicetree@vger.kernel.org,
        vkoul@kernel.org, linux@treblig.org, dan.carpenter@linaro.org,
        Frank.Li@nxp.com, konradybcio@kernel.org, bryan.odonoghue@linaro.org,
        krzk+dt@kernel.org, robh@kernel.org
Cc: quic_vdadhani@quicinc.com
References: <20241129144357.2008465-1-quic_msavaliy@quicinc.com>
 <20241129144357.2008465-2-quic_msavaliy@quicinc.com>
 <db428697-a9dc-46e1-abbe-73341306403f@kernel.org>
 <a8b1ccd2-c37b-4a6f-b592-caf1a53be02c@quicinc.com>
 <fc33c4ed-32e5-46cc-87d6-921f2e58b4ff@kernel.org>
 <75f2cc08-e3ab-41fb-aa94-22963c4ffd82@quicinc.com>
 <904ae8ea-d970-4b4b-a30a-cd1b65296a9b@kernel.org>
 <da2ba3df-eb47-4b55-a0c9-e038a3b9da30@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <da2ba3df-eb47-4b55-a0c9-e038a3b9da30@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: bddDJWiqX7EYts95lyRwwEoohq_nPD75
X-Proofpoint-ORIG-GUID: bddDJWiqX7EYts95lyRwwEoohq_nPD75
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 impostorscore=0 adultscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412020121

On 2.12.2024 1:55 PM, Mukesh Kumar Savaliya wrote:
> 
> 
> On 12/2/2024 4:34 PM, Krzysztof Kozlowski wrote:
>> On 02/12/2024 11:38, Mukesh Kumar Savaliya wrote:
>>>>
>>>> Come with one flag or enum, if needed, covering all your cases like this.
>>>>
>>> Let me explain, this feature is one of the additional software case
>>> adding on base protocol support. if we dont have more than one usecase
>>> or repurposing this feature, why do we need to add enums ? I see one
>>> flag gpi_mode but it's internal to driver not exposed to user or expose
>>> any usecase/feature.
>>>
>>> Below was our earlier context, just wanted to add for clarity.
>>> -- 
>>>   > Is sharing of IP blocks going to be also for other devices? If yes, then
>>>   > this should be one property for all Qualcomm devices. If not, then be
>>>   > sure that this is the case because I will bring it up if you come with
>>>   > one more solution for something else.
>>
>>
>> You keep repeating the same. You won't receive any other answer.
>>
> So far i was in context to SEs. I am not sure in qualcomm SOC all cores supporting this feature and if it at all it supports, it may have it's own mechanism then what is followed in SE IP. I was probably thinking on my owned IP core hence i was revolving around.
> 
> Hope this dt-binding i can conclude somewhere by seeking answer from other IP core owners within qualcomm.
>>>   >
>>> IP blocks like SE can be shared. Here we are talking about I2C sharing.
>>> In future it can be SPI sharing. But design wise it fits better to add
>>> flag per SE node. Same we shall be adding for SPI too in future.
>>
>>
>> How flag per SE node is relevant? I did not ask to move the property.
>>
>>>
>>> Please let me know your further suggestions.
>> We do not talk about I2C or SPI here only. We talk about entire SoC.
>> Since beginning. Find other patch proposals and align with rest of
>> Qualcomm developers so that you come with only one definition for this
>> feature/characteristic. Or do you want to say that I am free to NAK all
>> further properties duplicating this one?

I'm not sure a single property name+description can fit all possible
cases here. The hardware being "shared" can mean a number of different
things, with some blocks having hardware provisions for that, while
others may have totally none and rely on external mechanisms (e.g.
a shared memory buffer) to indicate whether an external entity
manages power to them.

Even here, I'm not particularly sure whether dt is the right place.
Maybe we could think about checking for clock_is_enabled()? That's
just an idea, as it may fall apart if CCF gets a .sync_state impl.

Konrad

