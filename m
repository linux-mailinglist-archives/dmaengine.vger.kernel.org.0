Return-Path: <dmaengine+bounces-6814-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9294BD1FD1
	for <lists+dmaengine@lfdr.de>; Mon, 13 Oct 2025 10:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 026091898DC2
	for <lists+dmaengine@lfdr.de>; Mon, 13 Oct 2025 08:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD4E2F49E0;
	Mon, 13 Oct 2025 08:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="V6L3jrBT"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624232F28F0
	for <dmaengine@vger.kernel.org>; Mon, 13 Oct 2025 08:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760343552; cv=none; b=T8WO6hPEaZSg0IJt7/6nJ+xzgqe91xIM674rxWEOyXLTrhMv5auEdaSunuH347+TeKoA/orsqUBNWalJQP+PDJt1hNDzqh0vGykB11C6UbUSok/7orwPWBhpK7a9QZYzfJUm/OEC5gVPUFf7ro9lmZ6KapqTQ8ugUbjxHJvIXwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760343552; c=relaxed/simple;
	bh=l71zOi8Iii2rT5j9IBt2SrlxYshazF9y0u6uvVNTzAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DuNWx28HOkUHf0EzFtjHc9LzA9KcOo7+e2dQhcYc+NfCiwLlj7hIWTPWk1esSk59KJq7FDN/TwAKZR5Kee5CINwlqWl/qpF6hkAfIgjrmy8zJQvGxRNjKXf7AFoRB1nugRSTO0+6xWbHwZP9BHKjAaZr1SpzYQROf/NeB5kfVdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=V6L3jrBT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59D2nEBr011036
	for <dmaengine@vger.kernel.org>; Mon, 13 Oct 2025 08:19:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CnjUTiX3FGPPzQybFpvUaFsk3SaXgmCmOsQbRYEOBOo=; b=V6L3jrBTbTvHHEKo
	qD5U4eFHTxnbpsqXc4cOpzkuMCTQ5epNY9DjJjkGLJL1qr6r0S4OFd5EdlW4yKCJ
	WAgbjSG5zqOQzCbAlZaLfx2fgKrZnyWU+pe1FW+xPMm7zYUVcOgdInhv2VqIb1YE
	/8spKAq0l2LlOD9R/8xSGLcz+mrsa40WnUDOPuUFFaQf3Ot9tdR7CKRQMlJm9mEn
	F1LJmDAFnsYKeaU2FFa4xBj5MdtSGdU9dDsVNnLbD8CdNcWqDqVuiSzP0gCs0uuZ
	bJhuaktE8ndnYcXHi0xu6Klfu6NXf7VeX39SjgEj+cfOzKXJfxzJcj7ggFw+6AUZ
	TM5Rlg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qg0bur2f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 13 Oct 2025 08:19:08 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8643fb24cafso182567785a.1
        for <dmaengine@vger.kernel.org>; Mon, 13 Oct 2025 01:19:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760343547; x=1760948347;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CnjUTiX3FGPPzQybFpvUaFsk3SaXgmCmOsQbRYEOBOo=;
        b=d2S8u43eGdc5IybWhouTEzXkYg3kU0vKYShsRE/PJsCWvkkLq4uuic9mrJZxtK5iUY
         v6+tSUIAgkctUsTps38WMFCaRyp5egbkzFny4cchbxo5p6hCy90rS5eU0YFRGwFgB5a/
         9igozeTq4CLLGVwPgt761t45cUrDYjd/g2+J6/headEmv3giyEVtWkuOA3t5lXDKZCoN
         ktBnIhQAD456FRuV33yq6zDaDGKeFe4kjt3MsdWN+GFtZ79rrpEDE8O4bFD425rmxoA/
         VnUuPI9SQstkaSu9GfsTb3KH+uKaVKeVQ8/B+R2m2HMlp3q6WOq24uf4hIwAhai62NX9
         d2nQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBVEHreoQxbeh3m7A40jt8haIUZIZeJybB0koFIRXQLN5J1i8kad1XmUCIIGbF8o0v5hkmT5OjV5E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPPEmdK9mFRDQN6INceYkTlNDpGaD+F+ue/Dq2F6QqEGWJ/N8W
	pO5bkSatKJmsAXKI+6TgsAtgibMiFP+CMBOx6qvKfxFhnCVDtbCULUyhWfibPKBuN41ua2wccgy
	4xqf5sk0GoR7hk9sfD8O6yWcPFVH/q/5k1wkrTDGkIPu/fAxXyPhjPSOb94EbXiM=
X-Gm-Gg: ASbGnctndnX+A+CZNi3QnynHC6uxHThhpA21AS7wFxJp4hTQ05zCsopNqg74dpZD9TP
	LUEnqoCb7Wmgd5hIK+frLRzl8b8cLfHR3WBtD/sjSAg6YOms361pdIdpM5ZXXEP0bJqof7TzJCe
	Wqcl9sNh8YTL/rWjmbPF9bhlX+4QobEx44aM0C0o4GkNKRFO3gMKPY/RUt+JG5Hi8Qk4ERM8NBu
	RJ8kWOxrqrUvazmC1IavUYtiZBgWj+CHnVBtmghAj7wdGRzSFmL5igdZKMKdPJWoox25kajJOiI
	o+KnkZVguBb76TgcGMV2vbTuAKOmGQMbFGuLcFDgAfX1x1axxREE+luIrx8VwfZZseb8/eoYPVr
	V5r9nzaZSn2vEsetJ0PBGIg==
X-Received: by 2002:a05:620a:711c:b0:85f:a278:78bf with SMTP id af79cd13be357-8834ff909f1mr2008313385a.3.1760343547279;
        Mon, 13 Oct 2025 01:19:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4znKrO6qzvVeWk9uZKKfQVBsm8qhDDyjnyj9kOQFewTkZRDPaivS5qv0Ack9eGJHz4piu7Q==
X-Received: by 2002:a05:620a:711c:b0:85f:a278:78bf with SMTP id af79cd13be357-8834ff909f1mr2008311885a.3.1760343546780;
        Mon, 13 Oct 2025 01:19:06 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d67d5c2bsm873147966b.37.2025.10.13.01.19.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 01:19:06 -0700 (PDT)
Message-ID: <01122bf2-7f8c-4d93-9557-c625b4eac631@oss.qualcomm.com>
Date: Mon, 13 Oct 2025 10:19:03 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/9] arm64: dts: qcom: ipq5424: Add QPIC SPI NAND
 controller support
To: Md Sadre Alam <quic_mdalam@quicinc.com>, broonie@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org, vkoul@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
Cc: quic_varada@quicinc.com
References: <20251008090413.458791-1-quic_mdalam@quicinc.com>
 <20251008090413.458791-5-quic_mdalam@quicinc.com>
 <c7848ee9-dc00-48c1-a9b9-a0650238e3a1@oss.qualcomm.com>
 <911ee444-25a9-a645-d14f-72fc239e5eb7@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <911ee444-25a9-a645-d14f-72fc239e5eb7@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: P-f1VjI2GqUNgWGO1xSHoERAeWHe_SJ6
X-Proofpoint-ORIG-GUID: P-f1VjI2GqUNgWGO1xSHoERAeWHe_SJ6
X-Authority-Analysis: v=2.4 cv=eaIwvrEH c=1 sm=1 tr=0 ts=68ecb5fc cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=COk6AnOGAAAA:8 a=OlpJZY4RW8OWQeam8GsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyMiBTYWx0ZWRfX/JgR8L5Vy94o
 Je16W3W/3VWzqRnxKsMGvRGmWHEsDNQ9oGusnG8fhbraP60HkpywXY+kZ6//EazGzKjrqwODncZ
 keNxZUtfcBbZQz3H/NYT3FUN2zQKioThU4ug/KtZ600Qaxj60l6RYgyPAY+hu54rawaX3OUt9u2
 GlNmtdV+PxXE+qTJYKH+ewtwMb3fWm0P2IHcS1HhAO6KuTY2D5YHwiQJEHS3lDYaWxcEG5elEZp
 XtXTDuikbdbj0mWlzmZyIczD9AeXysAppwvUiGJ3g5bBGnmQTpezz/OtkmvP6IIiczewXfQ0ZF7
 mCeyNuZmslIFQ9N/zWtyL5u+x4qeiAXOL3NGbkdcFwyp4gw7d+IaXrJ4xJPSbrRoleubkVtUrX3
 KjXbWvOHBYF1QOUaqiDGBKOq/MxRfQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 spamscore=0 impostorscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110022

On 10/13/25 8:10 AM, Md Sadre Alam wrote:
> 
> 
> On 10/8/2025 6:00 PM, Konrad Dybcio wrote:
>> On 10/8/25 11:04 AM, Md Sadre Alam wrote:
>>> Add device tree nodes for QPIC SPI NAND flash controller support
>>> on IPQ5424 SoC.
>>>
>>> The IPQ5424 SoC includes a QPIC controller that supports SPI NAND flash
>>> devices with hardware ECC capabilities and DMA support through BAM
>>> (Bus Access Manager).
>>>
>>> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
>>> ---

[...]

>>
>>> +            dmas = <&qpic_bam 0>,
>>> +                   <&qpic_bam 1>,
>>> +                   <&qpic_bam 2>;
>>> +            dma-names = "tx", "rx", "cmd";
>>> +            status = "disabled";
>>
>> Is there anything preventing us from enabling both these nodes by
>> default on all boards (maybe secure configuration or required
>> regulators)?
> We can't enable NAND by default in the common DTSI because the GPIOs are shared between eMMC and NAND.The decision to enable NAND must be made at the board-specific level, depending on the flash type used on that
> particular board or RDP.Enabling it globally could lead to conflicts on platforms where eMMC is present.

Right, thanks

Konrad

