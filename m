Return-Path: <dmaengine+bounces-11322-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sDp9Oam+JmrUcAIAu9opvQ
	(envelope-from <dmaengine+bounces-11322-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 08 Jun 2026 15:07:53 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8031865671F
	for <lists+dmaengine@lfdr.de>; Mon, 08 Jun 2026 15:07:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=THJYMksA;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=Pl0dBQTs;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11322-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11322-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6DEC9306A34B
	for <lists+dmaengine@lfdr.de>; Mon,  8 Jun 2026 13:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C052E6CC0;
	Mon,  8 Jun 2026 13:00:46 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07E12857EA
	for <dmaengine@vger.kernel.org>; Mon,  8 Jun 2026 13:00:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780923646; cv=none; b=Iyg2kxbRYiFLYnZidlDa6kFpH/ya1X0ZThmh7VQkHHvlsXTr3Mjf85Fh614dRzoDZVH7ouWcuF8rtHHciCearLqnPKr8I89cS/wvzaodseRTL5OgrE4oVn+WgNxql9Tnzdp41BzS/qjVvGdKrw+qaokv2Nfzo0UrgF0k48RN90A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780923646; c=relaxed/simple;
	bh=5CPeWiybnuarQX89JSsnELL5gZi36koS7oxDYutM69w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iOn8cj86sExiOGy2kW450H1EIE5yhFQKysNKpS1MalVCGHW9aMo25qWGt3RhXICtFHFrVhpZDAkwMdnIJMXEbBJ+ZishL97KnyCdOTNUB9drobaTo3E+hdEdhXLjqNT2HmsRxoHjGV+EMWCg+jGxwkbBkP2ULkUaYHYj86lKOhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=THJYMksA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Pl0dBQTs; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658Bkjbj3115759
	for <dmaengine@vger.kernel.org>; Mon, 8 Jun 2026 13:00:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sz10LbxlxIzFGKgPz2INDQUt6FN8Eaw4+BxLG+zT1cU=; b=THJYMksAV9Qad3zc
	bfkabOoTb0K9nC2fiQ6yyMBL2F7Vq9KzW7u1MJDstSDyJYIKEMjWL97r42OmntNN
	zWs950gwiJLot0/mTyjIMAzDgGSU3wTb4RF21GIi/FC4Zew0iLxw4MF/7GptVzrf
	6NNdvKfyI77KVEbCRqgmP+31slhuN+xh3ODSBBh1y7VqaVASfyv7I1bh8XLaDkRV
	UP88jfBBBH38g911SSZ5oBLNp3NTZvp54HjDQDYGKxSsXqw2BlDQk3+3F2TEqRYG
	vKc17PYpCWqQkLNxh60gp862shrLf+ufT6Uf8XH5KYDGeZODF3WvPlpAT14Cujho
	KA8OVg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enw5m09j7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 08 Jun 2026 13:00:44 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2bf0b7425bbso86200745ad.0
        for <dmaengine@vger.kernel.org>; Mon, 08 Jun 2026 06:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780923643; x=1781528443; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sz10LbxlxIzFGKgPz2INDQUt6FN8Eaw4+BxLG+zT1cU=;
        b=Pl0dBQTsILC9YNrn2AbFsoG+krL4n5+JKnwwjwlVTJ2QLs0r4jfaRjZ5z7LbDZqvYS
         hPQoLlSw2EvV1E7EFD0XvkQ0XffuU5O8YrIBQcc4Hex92KicYRM6KFHL4U+D1pUsOFUq
         IG9U3Neal5EL8/d874qfQwmCMqQHzzBBy1tgYlWpftdkrwdnCfuN21YoLQ8FL7XNs2PM
         XzaFE/hCYrzMPViSLiCT653wwLNdHaWjMFEY0f8cbeR4LvQfRTQIBIgZ6GkfL/yu4TBq
         MXUCJGUA6ZAIFsDjb20qwZFdwoVttAKr25V+l8rGWYI6nAElNJIP9lC7bq8qwcSIJooM
         NrlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780923643; x=1781528443;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sz10LbxlxIzFGKgPz2INDQUt6FN8Eaw4+BxLG+zT1cU=;
        b=TizezyMY8cvfb9RQA0t0TC2vnBKBZxGw+gJ7drx1Z7565Numga3dOh/aJUG/ifigcr
         9XPnXvxZNuXXH10anvYGW4mnsD6CRCILtrhytrGlRjJI7/PUbzvYjT94PHxaPvtzxrgH
         eL3qXRrkKhVgjCOeityzgX5zv5b5/YqWWxt4yKgnbeh2oTbpmRgn9tiUgIkwRwIm/wb9
         ABkE+D43ChiCJiCfPixFRKVG0MAB1pn0+ISaiMxTk+i5tIKmhhdUc6tAMLNyaqnqbzg8
         QHso+igcJMoW6t8bgNtGH7bjqzmYHqCIPw5oBcnJs6+x6T/B05UWQPBmcljyeqOPNK8i
         L8PA==
X-Forwarded-Encrypted: i=1; AFNElJ9HOtthK409B5l46zCQs4cobez2pNeC2sL/0v5zFFU/1YhPpxLrjLTOmLC/Rj05GZjntSpDWhNNY1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUTNOtKTE8dYY7atrSijlb9JhpzTPoNBj9t2Pnl8NOqacOMkP8
	TWss7bVJO1/83HbLxcLBF3Bw9yIEP1e0VIytqAtjT2GZp+oEaYvVyb9I/GUOwHCipR8jd0PN/qO
	/Q2O8B5y305DypRD7D/6ASarDbfppjNh+60uEjS/tlSzONgB1/7oh+TlotOF1vlA=
X-Gm-Gg: Acq92OE4Oo6Go8ZrKHOxqMKZOTOtp60TJk0b2TneKCBERtImo+dbSOESh0knl8bSgRa
	SjCJ3e5WF6Up8JVLuNyNn2BojSoDZH9p/WabFiS43ahvQfKn9UDd/Dm869hKGvXXLQL1VZYP17g
	K2U1bcCFe5+GSsbqdkZK2FsWqgvRJdk2mh3EHKzTjQw1x7PiEJloSIlpZ+496btarvYYlm75blX
	d3wGDzdaCFFEZJoK51B4xypXH9jGuVwRmsktOBcVUOjTftWs4DrGad+ErU5R3SJ+YhyW138yKYV
	V/Zxo68JrCRQ5eqFfPPasvs5MypBxXw7x37U/81q0hnk8mvuyo/h40I6Cc9USyskCNv5otS8Nc1
	GDA9Xiy6G0PpXAgrj3EnT2l7o8aAQYFCo1nKWyGv/EjrwRvpg0Td7mxg9x+O8
X-Received: by 2002:a17:903:248:b0:2c1:564b:4f49 with SMTP id d9443c01a7336-2c1e7b35a10mr172173805ad.6.1780923643019;
        Mon, 08 Jun 2026 06:00:43 -0700 (PDT)
X-Received: by 2002:a17:903:248:b0:2c1:564b:4f49 with SMTP id d9443c01a7336-2c1e7b35a10mr172173015ad.6.1780923642286;
        Mon, 08 Jun 2026 06:00:42 -0700 (PDT)
Received: from [10.219.56.230] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6cea3sm177993205ad.7.2026.06.08.06.00.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 06:00:41 -0700 (PDT)
Message-ID: <19df2647-309c-4345-896d-b4cebec07e97@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 18:30:35 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/10] arm64: dts: qcom: shikra: Enable Bluetooth and
 WiFi on EVK boards
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
References: <20260601-shikra-dt-m1-v3-0-0fe3f8d9ec48@oss.qualcomm.com>
 <20260601-shikra-dt-m1-v3-10-0fe3f8d9ec48@oss.qualcomm.com>
 <j2l7ijr56b33uru53wiyhjkd66pxusxopr4c7xmztlqfnztha3@xp6ciwnngcv2>
Content-Language: en-US
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
In-Reply-To: <j2l7ijr56b33uru53wiyhjkd66pxusxopr4c7xmztlqfnztha3@xp6ciwnngcv2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDEyMyBTYWx0ZWRfX+yvfqF7affCW
 I0jn8478r0qwCubrbtEAG+dWCuWEfl8JEwu+PtFIqplQVf+zAMxpqXXepdNoV5hO1yMFlH0Udpp
 SxUmVjNapYLw0Qp4aYrl/ZKf8zRUo4pGo3Lg8qJ4FmHVrmx7P4SJ3axi0Okk7EBcsdn9im/oofl
 2VhFeyE2GU17b9yxcyYxyF43zPaf31+iAEhZBC9nePl3IHTVbsopgPI4bsEXdDxIoy/p7JG7xr5
 XKf+7NbaUrAwbKfCvmFMtvmeC3EidIxwL7S2DlXFqcL9TN1pSAUrKRDGa/zXsErKgGW99UJCfTg
 0NzjA1IyIvRfPsQlbtQgiYTdTQHqcZIV8yI95L6Cu7qIDNRsvWE1ExXLdzjKiHvJ8TwnV+Kt3kw
 KaQxrIAQUf45RF+CgAUwJmNk8VrQV033R/qxIgeFbRE7SDI2qUQJ4vjKz8NUVfqX5JUEpEq5YhB
 TrzVSJ5Bu1pC4qa23Iw==
X-Proofpoint-ORIG-GUID: wBUwVwG3gOOvdN5kwUAQnd17d8smjFsr
X-Authority-Analysis: v=2.4 cv=UptT8ewB c=1 sm=1 tr=0 ts=6a26bcfc cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=DXfNKwVoJAfSTobcJs4A:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: wBUwVwG3gOOvdN5kwUAQnd17d8smjFsr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 clxscore=1015 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080123
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11322-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dmitry.baryshkov@oss.qualcomm.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:krzk@kernel.org,m:djakov@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:linux-arm-msm@vger.kernel.org,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pm@vger.kernel.org,m:yepuri.siddu@oss.qualcomm.com,m:miaoqing.pan@oss.qualcomm.com,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[komal.bajaj@oss.qualcomm.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[komal.bajaj@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8031865671F


On 6/6/2026 6:15 PM, Dmitry Baryshkov wrote:
> On Mon, Jun 01, 2026 at 06:25:12PM +0530, Komal Bajaj wrote:
>> Enable Bluetooth and WiFi connectivity on Shikra CQM, CQS and IQS
>> EVK boards using the WCN3988 combo chip.
>>
>> For Bluetooth, enable uart8 and add WCN3988 Bluetooth node with
>> board-specific regulator supplies across CQM, CQS and IQS Shikra
>> EVK boards.
>>
>> For WiFi, introduce the wcn3990-wifi hardware node in shikra.dtsi
>> with register space, interrupts, IOMMU configuration and reserved
>> memory. The node is kept disabled by default and enabled per-board
>> with the appropriate PMIC supply connections and calibration variant
>> selection.
>>
>> Co-developed-by: Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>
>> Signed-off-by: Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>
>> Co-developed-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
>> Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
>> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
>> ---
>>   arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts | 59 +++++++++++++++++++++++++
>>   arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts | 59 +++++++++++++++++++++++++
>>   arch/arm64/boot/dts/qcom/shikra-evk.dtsi    | 15 +++++++
>>   arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts | 67 +++++++++++++++++++++++++++++
>>   arch/arm64/boot/dts/qcom/shikra.dtsi        | 23 ++++++++++
>>   5 files changed, 223 insertions(+)
>>
>> +
>> +&wifi {
>> +	vdd-0.8-cx-mx-supply = <&pm4125_l7>;
>> +	vdd-1.8-xo-supply = <&vreg_pmu_xo>;
>> +	vdd-1.3-rfa-supply = <&vreg_pmu_rf>;
>> +	vdd-3.3-ch0-supply = <&vreg_pmu_ch0>;
>> +	qcom,calibration-variant = "Shikra_EVK";
>> +	firmware-name = "cq2390";
> firmware-name = "shikra";

ACK. I will update the name in next revision.

>
>> +
>> +	status = "okay";
>> +};
>> +
> [...]
>
>> +&wifi {
>> +	vdd-0.8-cx-mx-supply = <&pm4125_l7>;
>> +	vdd-1.8-xo-supply = <&vreg_pmu_xo>;
>> +	vdd-1.3-rfa-supply = <&vreg_pmu_rf>;
>> +	vdd-3.3-ch0-supply = <&vreg_pmu_ch0>;
>> +	qcom,calibration-variant = "Shikra_EVK";
> I hope this means that calibration files are common across the boards.

Yes, it is.

Thanks
Komal

>
>> +	firmware-name = "cq2390";
> firmware-name = "shikra";
>
>> +
>> +	status = "okay";
>> +};
>
> [...]
>
>> +
>> +&wifi {
>> +	vdd-0.8-cx-mx-supply = <&pm8150_s4>;
>> +	vdd-1.8-xo-supply = <&vreg_pmu_xo>;
>> +	vdd-1.3-rfa-supply = <&vreg_pmu_rf>;
>> +	vdd-3.3-ch0-supply = <&vreg_pmu_ch0>;
>> +	qcom,calibration-variant = "Shikra_EVK";
>> +	firmware-name = "cq2390";
> firmware-name = "shikra";
>> +
>> +	status = "okay";
>> +};


