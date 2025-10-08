Return-Path: <dmaengine+bounces-6786-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3B8BC493E
	for <lists+dmaengine@lfdr.de>; Wed, 08 Oct 2025 13:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4C0F18824BF
	for <lists+dmaengine@lfdr.de>; Wed,  8 Oct 2025 11:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEEC52EB878;
	Wed,  8 Oct 2025 11:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pQOFmVmO"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2979925B1CE
	for <dmaengine@vger.kernel.org>; Wed,  8 Oct 2025 11:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759923360; cv=none; b=mg8KKZGJTIYlwT+QzkR2yE0Ogbh70lX/djKCD2VaPqXNVfuxAQNEWtaDRkOaRM9Ub9IslIlw30SueVfpJEM4qy6cB9tdXrveV8ybuj6w3vGZqfvzAbIMf3+bIX9G9naT5C7HY27F9Q0XuQGtpJ8xjcOWUnYFXgYPxFzns9yezLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759923360; c=relaxed/simple;
	bh=5Y1g8IlsAUsUyZg4rL9NNl2CE/y+DiX7jrFayofh7Go=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FTKX1dfvCdQVgNmfN9mrlWoQBDBSHh4V/on26ZDGiMfsxSH+YQ3Ikp+cDCL95tkP8UkIN1YX0ngXe7fZcW6GHjaE393vUwsbzzaw9j4H+eC5A9X/aRo8UQFQgUGcQa4eIDF2zxT2gT3JOkGFZU5TWoS3FIEz0ycsqtKDS57kKHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pQOFmVmO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59890PmY011898
	for <dmaengine@vger.kernel.org>; Wed, 8 Oct 2025 11:35:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UcxtLcFi/NHIwxXXVTKMaEEjGDe7tRYGlHaZ/t/nCmw=; b=pQOFmVmO4VUYyJUR
	WsJp1Alph3OVUyni6JKCB8fp03H/V6aPEbFeV7wwvucNFgmZYHRXgg3qM8DaCZ+g
	Iw9dqWVVJz7Ea5BUNina3v7Cmc8/wupTeEJU2d9SpJ4AWcyrgSpn6LNzLx9x0QYY
	BhPtQTEfy3Z+pkxhLt03iZIWi2bMfsqZsVYeHb/C+Kr1i4zfZd1LMrBSZ2bzinLy
	ugIFRORtuZ2Ylct0NjedOlXc04Z/qccVTwkysrSOwgRfbfYxkJSw5OpK6Vzm6CN3
	cx54w1U+gU0o3ZgxL5gXGCQys3tlN1Yk6V7wWZekmEBn9dTsKgYzUgZZy2jlJzKy
	sWVwoA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49mnkpw3n4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Wed, 08 Oct 2025 11:35:58 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-85db8cb38ccso217445585a.0
        for <dmaengine@vger.kernel.org>; Wed, 08 Oct 2025 04:35:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759923357; x=1760528157;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UcxtLcFi/NHIwxXXVTKMaEEjGDe7tRYGlHaZ/t/nCmw=;
        b=ZbSoTrGPcFKRxAk1+Oain8VRa2852rllyEkxtL+2BnLWepB49DscLIGEu/3RNepicb
         c8Xywm5Qk3OEAuu9YMaQvcsYk4jlXk6LFZL7uYHAay8vl2UDQN16dIfAj3IWt1jXpUGk
         FaL8MPA58A83YAzPQnqjJCX/ZAeC+UNwhYgt/y/PShMIr607vSyim7RMxw1qYXHii9+1
         uTCuhEZYnlwY8QuuY9qZp3wHvs6CCK869J++mGmsG9T8nZJLbdkdfOSNQO2dNVdlIdFm
         7eRZMBp0om3psMBUy2Lf+u4bT9AZRhLq1JQZLYBesxBT9dOVfq80T8f+/wUGG9WF3+FH
         QL5A==
X-Forwarded-Encrypted: i=1; AJvYcCXZ/mAeyfj6pPv43/yrae69ks7NuCET+7WH4nzTOlsj/kMSBOHair0s9B+2r0SitC3Q32mn2sj9KPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YytP+dNKOMte+SioeiDi1t+8vib4pWKxR7QIFrLiTpSIcMTRB/W
	yPng6GKgfynIeRRIGOtZtKziwCmPs1a0qm8aOoAWLHcFMHrOwBREJ2dTUGe+t8KJLmDf2EMfYzQ
	GjxR5Wykt+UecEUZZqg+js8xm3eO4h+WCn8yWzVzHVp6jS14SZs09UltHWXqStxY=
X-Gm-Gg: ASbGncuFjIG4oPR+t39ZYHVp/hzh/j4gBvBVuLv34v2167mTqSCjsumkzzhj8/67wDF
	hYt9M+PMBty8bzVdGdGqwtM2CHTKR8cepNPXyUNK+4omuQAzXcD1sqhayfx8HQ1Jca7RD9fUEjn
	L8AVzG/tGwTFUoNXrzM+3pJTIRz6VhjvVdyKItL0RdsyMJuvgmTgGuzkfVMbAAOZ9d0HCHxBkcr
	gXkl70C040rWLZIYjbYCwqP72vq1obKhr0lqNeZfZRnM0mr8BJOUqRvuEZ/1WCBFQH/mP3c/Rbn
	O+fTUJXkMhX0gq9N3xzLOv8m2c3T5pdhIOaoUD31tj04iRCW8mpWOHglPPuFxom7D22T0br8Wux
	NhjhQdvv8hHc1NiN2k/W3MwAoJz4=
X-Received: by 2002:a05:620a:17a7:b0:812:81c6:266c with SMTP id af79cd13be357-8835420965cmr273036985a.9.1759923356958;
        Wed, 08 Oct 2025 04:35:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEt/p9KWaL1e9SZdVmnvmGbbEbWOxiPEBK7bXd20TZj+ydCuPVXuNpIcjVWSXqwKTr1FFN+RA==
X-Received: by 2002:a05:620a:17a7:b0:812:81c6:266c with SMTP id af79cd13be357-8835420965cmr273034785a.9.1759923356368;
        Wed, 08 Oct 2025 04:35:56 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486970b0c7sm1705829566b.57.2025.10.08.04.35.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 04:35:55 -0700 (PDT)
Message-ID: <aa06df81-e594-469a-85ee-9dd1e192e2f4@oss.qualcomm.com>
Date: Wed, 8 Oct 2025 13:35:53 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] dma: qcom: bam_dma: Fix command element mask field
 for BAM v1.6.0+
To: Md Sadre Alam <quic_mdalam@quicinc.com>, broonie@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org, vkoul@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
Cc: quic_varada@quicinc.com
References: <20250918094017.3844338-1-quic_mdalam@quicinc.com>
 <20250918094017.3844338-4-quic_mdalam@quicinc.com>
 <c5d5c026-3240-4828-b9b3-455f057fb041@oss.qualcomm.com>
 <2394e63f-1df7-764e-5489-3567065707a1@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <2394e63f-1df7-764e-5489-3567065707a1@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: VsMwFuR5bblZSV3NP9_QGL295q5_TiCD
X-Proofpoint-ORIG-GUID: VsMwFuR5bblZSV3NP9_QGL295q5_TiCD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA2MDE2OCBTYWx0ZWRfX9L4sm90NjOEQ
 trBWV0loMIjiWx+KctKspOS9JfhOUDCyzsrHZZsmFUzeZ3lOQmhUFxu8Am47759BYv+eChJnA/6
 UZHwwARHJ/ZmN/YYd3ktLMbO12J3/DD9TRT6wtQJf3D62ozxcryNo4CFudX3gnp3lZ9ybkLDSeS
 uDTF1Scj4jcIcJev2ngF9kn1OopL/p5fZNhgiFVLcromm7SMSjhePmWHMP+C+XPBjuFOgfI0aFq
 iEmf2aXOeZ+22L1dZ2T1i92vY13XOvxPIEHl6cBgBRfOieWD3kGO11sbrpvRJgRyPGKbOgAY846
 IKDIBC/SoSW+gcPQYKfgIUKwvizOPeTl/AM5pQbWl0hOmMHYfGZ9LDlWDRxZe72ac1w6QDuchqD
 TZUUtysDLtIRFnQOVXV5evglmGuocw==
X-Authority-Analysis: v=2.4 cv=BuCQAIX5 c=1 sm=1 tr=0 ts=68e64c9e cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=W9ArKkagtRzJc8iw_qMA:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510060168

On 9/19/25 7:56 AM, Md Sadre Alam wrote:
> 
> 
> On 9/18/2025 3:57 PM, Konrad Dybcio wrote:
>> On 9/18/25 11:40 AM, Md Sadre Alam wrote:
>>> BAM version 1.6.0 and later changed the behavior of the mask field in
>>> command elements for read operations. In newer BAM versions, the mask
>>> field for read commands contains the upper 4 bits of the destination
>>> address to support 36-bit addressing, while for write commands it
>>> continues to function as a traditional write mask.
>>
>> So the hardware can read from higher addresses but not write to them?
> No,
> Write Operations: Can target any 32-bit address in the peripheral address space (up to 4GB)
> 
> Read Operations: Can read from any 32-bit peripheral address and
> place the data into 36-bit memory addresses (up to 64GB) starting
> from BAM v1.6.0

OK I misread your commit message

[...]

> For Read Commands:
> - BAM < v1.6.0: 3rd Dword completely ignored by hardware
> - BAM >= v1.6.0: 3rd Dword[3:0] contains upper 4 bits of destination
> address

This is important to point out. With that, the change looks sane indeed

Konrad

