Return-Path: <dmaengine+bounces-11024-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBdCH/cpGWp/rQgAu9opvQ
	(envelope-from <dmaengine+bounces-11024-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 29 May 2026 07:53:59 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D415A5FDA4E
	for <lists+dmaengine@lfdr.de>; Fri, 29 May 2026 07:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 003B7301C14E
	for <lists+dmaengine@lfdr.de>; Fri, 29 May 2026 05:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E04D318BA6;
	Fri, 29 May 2026 05:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FasfBma5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cvfMJzb4"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929553A543D
	for <dmaengine@vger.kernel.org>; Fri, 29 May 2026 05:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780033754; cv=none; b=uN/LaaaTi8ga8KBC51pgD/IzBqJ7y6WnHGNqx7pLv+YKgLg9F0MSf9/Tgu30EMYpcAOY+ZkrainowkTnpfLf+8JcaIdPDSrmBcPircweOG2kj/l71QwrS690Pol03UGeVo9zkU+ZDsRigs+rx799TA/btlsltF9JN1zc2tH27Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780033754; c=relaxed/simple;
	bh=tYZePMpCGaJ+dVgmzUM0MImFSqwW7e8yccJKslZhe94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i4DcediSV7JWKNf1Co/9FHy+0oRTeuxl3o1vuTzcgY2Vwoz4hFBstP07buYjDZmeoDJro9gerhFVyOIT+YbtwSavaYFM0HwTVwWMyZ8VVycXYcx3QhqZSeDlsSj2+9aVp9YQ/TeDxO68JxrwPGOw5j6mV1NJ47ue9nF71DhOCT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FasfBma5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cvfMJzb4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64T5KNPm1248208
	for <dmaengine@vger.kernel.org>; Fri, 29 May 2026 05:49:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	srDM5VhRCyyRRsRBH7zxAS69uDyeKrznoeTqCStR/fE=; b=FasfBma5Sybsz2d0
	nvw0mgjgrUj8toLwVUc0fxdMMMjPCuPChZpjhe2MgFvwolCLIroyjMkU4ZYRYmiC
	whYz0N7CzBFNgBGlPzldslIqS51LudL0s/zYZAJUwwUzZNMwy6eut0gYaL01Bg2e
	NpQ6+cSRCrStpxQ6ldW/YT+rYKzyD4Y1StuQw9Ii4M6d1c8gpB7hicioysINwslv
	VGOifOznDheBGBv2LED5JvZp3wPlJ5OXlL4/e3TZzul9W9Avw21zZX2UnoMl4Rm9
	++Vv9JOJcHKzT6E47NgL/kVhtAhYfw34KI2eqDAqGpIifRfWnLXYxVTYGhkIMCIr
	ULF4kA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ef4jj0331-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Fri, 29 May 2026 05:49:11 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-36b808bedfaso2329572a91.1
        for <dmaengine@vger.kernel.org>; Thu, 28 May 2026 22:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780033750; x=1780638550; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=srDM5VhRCyyRRsRBH7zxAS69uDyeKrznoeTqCStR/fE=;
        b=cvfMJzb4TD9EF2jG0sLw8xjrZmBFR3RP9asf0emqXa9ZlqiV63p2Ba8Wt+23T0EoVB
         ImE049LA5oPgUyWAh6S7lgk2cS5/DTpq1FsPV8UAtsDA9lJGWtYYwekSOiSXY3Xsdhft
         QqFZOJsb+6028rqaeqk4ecr7nNXCHGfN6/moilvjAl4KQsq2QVODTQyRXcEvEmhSU5mQ
         ibB0afrxzBUk7y5pGmXfanASaUhtEjegX+8WQ7iTakim1Mf2TIQfY7avvtaLTdkfi4hc
         klZKayen4/9tm/7yf69uXc3wpkOOl+7HEOYbr9jhvBLBWYVRomwCCj4dz1qyPLzy/vx9
         T/ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780033750; x=1780638550;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=srDM5VhRCyyRRsRBH7zxAS69uDyeKrznoeTqCStR/fE=;
        b=RBRUa1nFDLgbnnLa7FeT5zlI+SVQegjsSOry/3+kqzMfAmxgHXmsxhNVuqW00O3JTY
         rI3YLC3hpwJVHNLCPrmpX9GYJN35DNLHArR+tC0VfEtI1FgEl2SNdiMQbPw3rDcZzCLS
         dShStu+ycUmoksaPpt+SkCtUpn+LqjT8NS23jT51uV9cQVPR38xiGAzSTkk7XYGq7FV/
         KPyKLpMzTRD7SC31qxzRoTx01IahveKS5q/cLuhWiBgfxhGfLahaxrpG+DDSxGoCyKBp
         LQwPJPKlAZ9sZ0e4p3xHlUelahXXgQBKpkDHHWhu8MOUocLB+8CBvHugZFh0aIWN9NI3
         6KXQ==
X-Forwarded-Encrypted: i=1; AFNElJ8LdjXPdyCB//IT1auEbhzhCaNDShh1IaE2OpDS0OcN5aAxCNKMhiJGduJxFszsOvitMU7PNqzG0JA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxggeIZ0Av8YEkbxRnpkhB1eOBvQymJ+kdVn0pg4Jx3QXgj/7Q/
	hrRg2YTdHITq9Pd2aWa75GT+mgGRpK/LZrxwo+MVZ+NTbzw3pWTy+4jG6DrQ4zjLi0/i2ztUfnU
	jImUQPmPmr8Mxtcw4cmmTrVS88psITDBDDlZSjx3EusYTzXCMjsfhA2JNlr4oXJs=
X-Gm-Gg: Acq92OE48xsf/qDTPH3S2yoQe8PgsLU9bVEkq1xc6Ymx9820+/yEOeOaSFBGRE62nsB
	VZ6McgTMEZ4yIj9daZCpnIlCtX4BmcsjUBGPO1bWCMgD5QVieKb9esLOL45oSZ+jAFFtIvflNyL
	cz8AycrARdlg7YTywO4jDme3tRf1zWHquCogoaVDvPlOCosl09v0IIEa979QTrmSx/wkXHqaWKM
	fVp3F1LkyF5VbB3150ecLye+KPGJi6vgMkXBghBW9CT2ra0guy1JakDIUEnBiXYoIdLc8B3TtVI
	wAo+NQXvSawLB+hxPCUd2sTxKrVCFhyRsy8I6YmOKDHMO6NmRg1xYteibpKUkJI/GUUhoApj+k6
	bE7Pdhis6iLYGHVDdwGTfn0vUR4/mZdrqGH59F18rsFpoYMdSTEPpir4q1K4QmljrcYHNUEPYhR
	Woer56kMrRq/dMcN+48zJ+js8Nmwk=
X-Received: by 2002:a17:90b:6c4:b0:35c:30a8:330 with SMTP id 98e67ed59e1d1-36bbc58e632mr1843340a91.0.1780033750393;
        Thu, 28 May 2026 22:49:10 -0700 (PDT)
X-Received: by 2002:a17:90b:6c4:b0:35c:30a8:330 with SMTP id 98e67ed59e1d1-36bbc58e632mr1843296a91.0.1780033749938;
        Thu, 28 May 2026 22:49:09 -0700 (PDT)
Received: from [10.133.33.19] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36bc6a340b7sm600950a91.11.2026.05.28.22.49.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2026 22:49:09 -0700 (PDT)
Message-ID: <57f8c593-11b7-47bc-8e11-7ec1b97210f6@oss.qualcomm.com>
Date: Fri, 29 May 2026 13:49:03 +0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/16] arm64: dts: qcom: shikra: enable WiFi on EVK boards
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20260525-shikra-dt-m1-v1-0-f51a9838dbaa@oss.qualcomm.com>
 <20260525-shikra-dt-m1-v1-16-f51a9838dbaa@oss.qualcomm.com>
 <qhm4zgn3yiahv6dfucisu7uwcxddty4fvl3wwx6gk2zm5ggzlr@n3nqcpkkwxps>
Content-Language: en-US
From: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
In-Reply-To: <qhm4zgn3yiahv6dfucisu7uwcxddty4fvl3wwx6gk2zm5ggzlr@n3nqcpkkwxps>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDA1NCBTYWx0ZWRfX6+Rj341qf0zu
 Ri8UqXFCWmk7mOYaPWUYvGKFmr8w9iUtMLTmD8sjuo3whJrR15eqAzAo9a2oyaSlf/i02rRgTXJ
 HZTkMWqRxTrunPr1O1qIqfTTdzN/zJiy09mydrcYbR1F1OAimQ0KKeOlCm5j6zedeFTITXGKeaS
 CTwOJ6OLnpk/97r2Pd3p6MvA8znTFiSknEc+0D/JDvua25V6eZA0+9jdkoHZ6HTxY4Qv9khgTOl
 jf0YvMJBRVKoUBRFabfr6yY72YYuAQ6MRxLpO/eA6hJVDdO8arxjPYZussMOCXm6iFANeXh0ffx
 U4CvDakNHe53pVyoplEZNw+y7lyvtE57O/y3u4ZHPfa44/dUPj1pe2/myP95IQeww6ZBKlEqbmR
 EXSL2H8WmiNuKBYxdJ1KeUB6ROq2fP7IxaFUxPQV5HWI00u6F1L/QNytY58Mt7GiuW7unWieo+G
 6PtSdxPkyQxKYbeNKpw==
X-Proofpoint-ORIG-GUID: 8_rnTBdVn2PF_1qXdVIdfKNn3y_Xlu0H
X-Authority-Analysis: v=2.4 cv=Tt7WQjXh c=1 sm=1 tr=0 ts=6a1928d7 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=ahI4HeskZtu-GeTpWRYA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: 8_rnTBdVn2PF_1qXdVIdfKNn3y_Xlu0H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1011 impostorscore=0 bulkscore=0
 adultscore=0 malwarescore=0 phishscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290054
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	URIBL_MULTI_FAIL(0.00)[sea.lore.kernel.org:server fail,oss.qualcomm.com:server fail,qualcomm.com:server fail];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-11024-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miaoqing.pan@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D415A5FDA4E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/25/2026 5:34 PM, Dmitry Baryshkov wrote:
> On Mon, May 25, 2026 at 01:19:20AM +0530, Komal Bajaj wrote:
>> From: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
>>
>> Enable WiFi support on Shikra CQS, CQM and IQS EVK variants.
>>
>> Provide board-specific WiFi configuration, including power supply
>> connections and calibration variant selection. The WiFi node is
>> enabled on each EVK according to the corresponding PMIC and board
>> design.
>>
>> Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
>> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
>> ---
>>   arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts | 11 +++++++++++
>>   arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts | 11 +++++++++++
>>   arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts | 19 +++++++++++++++++++
> It makes me wonder... You've added DSPs in three patches, one per board,
> but BT and WiFi go together. Where is the logiic?
>
>>   3 files changed, 41 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
>> index 259032bd20af..15208e1abff6 100644
>> --- a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
>> +++ b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
>> @@ -69,3 +69,14 @@ bluetooth {
>>   		vddch0-supply = <&pm4125_l22>;
>>   	};
>>   };
>> +
>> +&wifi {
>> +	vdd-0.8-cx-mx-supply = <&pm4125_l7>;
>> +	vdd-1.8-xo-supply = <&pm4125_l13>;
>> +	vdd-1.3-rfa-supply = <&pm4125_l10>;
>> +	vdd-3.3-ch0-supply = <&pm4125_l22>;
> Squash with the BT changes. Use the PMU-based bindings. Don't forget the
> swctrl GPIO.
WCN3990 does not rely on the PMU module; it is managed directly by 
ath10k, so the swctrl GPIO is not needed. The details are described in 
qcom,ath10k.yaml.


>
>> +	qcom,calibration-variant = "Shikra_EVK";
> Was this submitted to ath10k-firmware?
Not yet.

>
>> +	firmware-name = "cq2390";
>> +
>> +	status = "okay";
>> +};
>> diff --git a/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts b/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
>> index 142cc8da53ce..51267c1a86b3 100644
>> --- a/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
>> +++ b/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
>> @@ -69,3 +69,14 @@ bluetooth {
>>   		vddch0-supply = <&pm4125_l22>;
>>   	};
>>   };
>> +
>> +&wifi {
>> +	vdd-0.8-cx-mx-supply = <&pm4125_l7>;
>> +	vdd-1.8-xo-supply = <&pm4125_l13>;
>> +	vdd-1.3-rfa-supply = <&pm4125_l10>;
>> +	vdd-3.3-ch0-supply = <&pm4125_l22>;
>> +	qcom,calibration-variant = "Shikra_EVK";
>> +	firmware-name = "cq2390";
>> +
>> +	status = "okay";
>> +};
>> diff --git a/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts b/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
>> index 9bf52030bcc5..f4e93cfb77e3 100644
>> --- a/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
>> +++ b/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
>> @@ -30,6 +30,14 @@ vreg_bt_3p3_dummy: regulator-bt-3p3-dummy {
>>   		regulator-max-microvolt = <3300000>;
>>   		regulator-always-on;
>>   	};
>> +
>> +	vreg_wlan_3p3_dummy: regulator-wlan-3p3-dummy {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "wlan_3p3_dummy";
>> +		regulator-min-microvolt = <3300000>;
>> +		regulator-max-microvolt = <3300000>;
>> +		regulator-always-on;
> Why is it dummy? Is there no regulator on the board?

WCN3950_3P3_CHAIN0 :is powered by on Board 3rd Party Buck which is always ON, VREG_SYS is always on once the device is powered up.

>
>> +	};
>>   };
>>   
>>   &remoteproc_cdsp {
>> @@ -77,3 +85,14 @@ bluetooth {
>>   		vddch0-supply = <&vreg_bt_3p3_dummy>;
>>   	};
>>   };
>> +
>> +&wifi {
>> +	vdd-0.8-cx-mx-supply = <&pm8150_s4>;
>> +	vdd-1.8-xo-supply = <&pm8150_l12>;
>> +	vdd-1.3-rfa-supply = <&pm8150_l8>;
>> +	vdd-3.3-ch0-supply = <&vreg_wlan_3p3_dummy>;
>> +	qcom,calibration-variant = "Shikra_EVK";
>> +	firmware-name = "cq2390";
>> +
>> +	status = "okay";
>> +};
>>
>> -- 
>> 2.34.1
>>


