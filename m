Return-Path: <dmaengine+bounces-10974-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KO+nHYLzFmo6ygcAu9opvQ
	(envelope-from <dmaengine+bounces-10974-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 27 May 2026 15:37:06 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5055E511F
	for <lists+dmaengine@lfdr.de>; Wed, 27 May 2026 15:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1A830308C41D
	for <lists+dmaengine@lfdr.de>; Wed, 27 May 2026 13:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0641A40DFC4;
	Wed, 27 May 2026 13:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Wt6ZH/uI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MKACRtdU"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFF93DC4CB
	for <dmaengine@vger.kernel.org>; Wed, 27 May 2026 13:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779888236; cv=none; b=GsxGXPWWPHecv/gyRCfJ54wqQ38/KqLBHeduLh4MFJSKUxpBZWyrl0UdEhDXVjq08yFBabok6GX6GOOJUx2p0CwBcWkd00fXAyLmyQfcygBqfzuFDB9i+cDWPEsAzKJWd7/uzwYINazQkQbc9M7OTtedkelAyRJfIbD2+GY8fuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779888236; c=relaxed/simple;
	bh=fZEirdPhsiXXXgzeCpAJ/Yl+U0Bn3pFVopZz2C1bxzU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rvh+84DcunN+JhK4kvg5jdztd3B6RSb0fqHmY2ycuXeis5nsF5gJjV1/D2VBYEoZhkBzZJPUblNsyFmbPz3poVwxXeX6rjYk0hxy+Npqrqu18ljq+aIa2L2r29VpFhGg9OQl3y/faAur0OyeJgqqNSjVK/8L3q59VrZM75cPzqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Wt6ZH/uI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MKACRtdU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64RAWNpb150061
	for <dmaengine@vger.kernel.org>; Wed, 27 May 2026 13:23:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	U/gnMR6HFXrUp4eDo7X8GSCD7DZCtPox7sItISbE2X4=; b=Wt6ZH/uImYVEEPcG
	Ip6vnNXu9AsxYJG9KYAe1Y3hvhVVk2+u9tO1pofDCEobgLXyrPNaox5XcmDQ8P00
	nn+d1kTmbcCqPo2vqKymZTtlzxybHVBMh6tq/ymwP646AIGHvDFEKa4iwMWcm095
	iChib0AoEqsDk+GFOD3ZkWeXnZFd47KmMjE9nKkxzbohtZe387Lqql4VMekdownc
	6OxemKIzy7qBMxJ/85wKxY1mNhRoAate3tsArGbRB/vcYvjjltXSMD2U2qVVh2Gb
	unm4EMQZaecDHkc/Bv3V9cVwtebidNuQbPByR1v9XUtlYgMqCriMujGrBJKmaUGJ
	yLoB1g==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4edxxvrj69-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Wed, 27 May 2026 13:23:54 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-83544d05c5aso5993525b3a.2
        for <dmaengine@vger.kernel.org>; Wed, 27 May 2026 06:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779888234; x=1780493034; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U/gnMR6HFXrUp4eDo7X8GSCD7DZCtPox7sItISbE2X4=;
        b=MKACRtdUWE/spmo/p2MBYBD1gebfF0XEjj5GJJuuQ88aquT8HorKi4JuJW4pZj4fYB
         2G4D9G59zWAzkbZe11QGbBHSh2nK3ZmvC2gDz8P62dGsMyEskkcbrM950ubY164h6mgU
         ZmrdHp8GzFBLoW/zEad4pAz35lSTyehQLNL3RrEzBAE3KhCrekvEY/bcIHDAhOvz8yje
         G10yu1GDSbabG0ZvMbrUgD//DqW6o11zaGEdlN31WoK4/LXWx4GI5WM5UHp4E3XlRCUP
         Fzv5ERNqWj2YdC3YrAuKjIKUnhFfPKUT5NMt5A5hWqqtzOXRofoccWKLEETyfFzfjIK5
         bskg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779888234; x=1780493034;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U/gnMR6HFXrUp4eDo7X8GSCD7DZCtPox7sItISbE2X4=;
        b=iJvzyntjfb+tAZ3vDzne/If+prWSEXMSFnaCe/y2ZbcjcqWl9GBT59mzLN13ym0aY5
         rOHgq2QVIKXDPefw4qDg9gYUB47VHQS+KDAcxGvJl39f0PTjCYv7Gyg61kXQYFdGGJAY
         0HOitMjCS4Tg0427aAsjb+3m3alttQBB/3avaOnffXLZb3vR7P5TY3bgTureoT+fHMkH
         6+TpOTF9kWt7ZQjiPrnrNktypS6zTPFQd159Fzf/Q9kOuULPG8o436tTkTCxs3MdqyvL
         Q6TJ6w46jxhaL70lZD33OFb2ri6etL/+HFoj2k2nV4XX8piSSb6VA3UAQYxQWEhrVi/h
         dpLg==
X-Forwarded-Encrypted: i=1; AFNElJ81KBmxO9+gBZ4J2yAoGnbebtCtL4KA4vILuiQlaHfG6ejXhSZPgFrUkpKphhRGSwZ4obsFs+KumYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXR7mAtB6vVG/k2EZgzdSk6ctFFQyLbQjhtOB97/MbWGFHkmbT
	TXkUc1xE9yD9IEEuukhwvdc3tf2ZeHtwbQ0je7PpQ5kl8miJNtkx3vEY2tLR75itI2v1mIiX3xd
	gWsrRKwvnnjz6k122aPhlNQW4KGlalCFBWx0mSbHBwBxDEPTqAXl8AOm1y33+vyI=
X-Gm-Gg: Acq92OG7lLDrgRIWq+6MfgE6K102TwI+xFNv5o1a1kLRT6TvHMHDdTMTaq8+xne9XTk
	+hUhLyfLZ8UU+/PCB7kq2S3oIvxbxuUMV2wMy17b9/K8ql28lJjbzgcknikq+iawn58S2gJQewj
	7SWTDipBwZT7GdwhZzqKi37Lo2nBAVyX3rQWK1bWLxSPUMU4KzptPf6MhczX+2aZYTiXaB/t1aJ
	uyNKU2etEQ/Kp6rshjRAimu+Nj12RArkc7gIrSCneDRiqOLaGNWufJ4t6+a6yMUCfBD7FvufH/0
	eEHZ4kcaGusZ+s/F4x9jgbwdlhyBKZXUT3Itq5vUBsnwKjUCDLbF63lJzUOIWT9pXSRKZ86HFn7
	tP3n8Vg+rl9IMoXo+I7bP5K+2YOO+B9kwNrCdS7HonxVvNwx44sSl9OuMbFv9
X-Received: by 2002:a05:6a00:194f:b0:82a:f02:7355 with SMTP id d2e1a72fcca58-8415f307755mr21996046b3a.32.1779888233800;
        Wed, 27 May 2026 06:23:53 -0700 (PDT)
X-Received: by 2002:a05:6a00:194f:b0:82a:f02:7355 with SMTP id d2e1a72fcca58-8415f307755mr21996009b3a.32.1779888233257;
        Wed, 27 May 2026 06:23:53 -0700 (PDT)
Received: from [10.219.1.106] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841d6eb0313sm3374638b3a.13.2026.05.27.06.23.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2026 06:23:52 -0700 (PDT)
Message-ID: <30a33da1-6424-47f3-9e7e-a09ca61a1234@oss.qualcomm.com>
Date: Wed, 27 May 2026 18:53:30 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/16] arm64: dts: qcom: shikra: Enable BT support on EVK
 boards
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
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Yepuri Siddu <ysiddu@qti.qualcomm.com>, hbandi@qti.qualcomm.com,
        rahul.samana@oss.qualcomm.com
References: <20260525-shikra-dt-m1-v1-0-f51a9838dbaa@oss.qualcomm.com>
 <20260525-shikra-dt-m1-v1-14-f51a9838dbaa@oss.qualcomm.com>
 <rbu5oub4uc4rubdlfth7undrirlyfwbnst5clgyvm63fde3tcw@fulet3k3a4sf>
Content-Language: en-US
From: Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>
In-Reply-To: <rbu5oub4uc4rubdlfth7undrirlyfwbnst5clgyvm63fde3tcw@fulet3k3a4sf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 2ISZRVaWWktXDMilusw5BKyh7J3RBSjE
X-Authority-Analysis: v=2.4 cv=bJAm5v+Z c=1 sm=1 tr=0 ts=6a16f06a cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=GjFf7XSWKEao_LXfqQMA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDEzMCBTYWx0ZWRfX4CoEsdDwwCp8
 wRMKUCi0MX0ypSjE1ykkk3ufcQbpCigAmZ7u9tZOTB0eekJPUYknNjwD1TeNJ6Kveaa2HL9UUV/
 DhmmAa73dfSSndFVBt9F6P/OboFFVuaCa3Fcffzrar9yEphQGb9gG4xG+jFExOgbq7zUjBM7Wjh
 fzk9KO3pyn6TId6boNPPA/gYCyAgenIGLdwsASDax5uRCSbIhrRFQ91EJjDvWoiYiFEVPwNAuXU
 IuCwkvrJUKwx6z7hYUFlrM2x58LVoHMS+6GNHy4b8TAxuVKA5znpQsmywawN/Qt8Xa0zgXB9pbK
 o4EICdidBzqDsu/15/XrNqmiV+7gWXNGHXR4tc8RKyb0BFUN+6leZnbA6oG09TcKEGrnOJi7t9a
 wrbjWuu++jHSifYBx3YJTqPaCmligUz2lP3M4SC7AufGFr2nCAWj8P7ZOryctHm5vdUHeDJv4+m
 DRjOmEr33ohOTh3YEAQ==
X-Proofpoint-GUID: 2ISZRVaWWktXDMilusw5BKyh7J3RBSjE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_02,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0 adultscore=0 spamscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605270130
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-10974-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[4aa4000:email,qualcomm.com:email,qualcomm.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yepuri.siddu@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6B5055E511F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/25/2026 3:01 PM, Dmitry Baryshkov wrote:
> On Mon, May 25, 2026 at 01:19:18AM +0530, Komal Bajaj wrote:
>> From: Yepuri Siddu <ysiddu@qti.qualcomm.com>
>>
>> Enable uart8 and add WCN3988 Bluetooth node with board-specific regulator
>> supplies across CQM, CQS and IQS Shikra EVK boards.
>>
>> Signed-off-by: Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>
>> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
>> ---
>>   arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts | 12 ++++++++++++
>>   arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts | 12 ++++++++++++
>>   arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts | 20 ++++++++++++++++++++
>>   arch/arm64/boot/dts/qcom/shikra.dtsi        |  7 +++++++
>>   4 files changed, 51 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
>> index b112b21b1d79..259032bd20af 100644
>> --- a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
>> +++ b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
>> @@ -16,6 +16,7 @@ / {
>>   	aliases {
>>   		mmc0 = &sdhc_1;
>>   		serial0 = &uart0;
>> +		serial1 = &uart8;
>>   	};
>>   
>>   	chosen {
>> @@ -57,3 +58,14 @@ &sdhc_1 {
>>   
>>   	status = "okay";
>>   };
>> +
>> +&uart8 {
>> +	status = "okay";
>> +
>> +	bluetooth {
>> +		vddio-supply = <&pm4125_l7>;
>> +		vddxo-supply = <&pm4125_l13>;
>> +		vddrf-supply = <&pm4125_l10>;
>> +		vddch0-supply = <&pm4125_l22>;
> 
> Use the modern (PMU) bindings. Also please add WiFi.
The modern PMU support for the WCN39xx family is currently not available 
in hci qca driver, that is why we have defined the regulators directly 
within the Bluetooth node.
> 
>> +	};
>> +};
>> diff --git a/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts b/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
>> index e62ba5aef71f..142cc8da53ce 100644
>> --- a/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
>> +++ b/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
>> @@ -16,6 +16,7 @@ / {
>>   	aliases {
>>   		mmc0 = &sdhc_1;
>>   		serial0 = &uart0;
>> +		serial1 = &uart8;
>>   	};
>>   
>>   	chosen {
>> @@ -57,3 +58,14 @@ &sdhc_1 {
>>   
>>   	status = "okay";
>>   };
>> +
>> +&uart8 {
>> +	status = "okay";
>> +
>> +	bluetooth {
>> +		vddio-supply = <&pm4125_l7>;
>> +		vddxo-supply = <&pm4125_l13>;
>> +		vddrf-supply = <&pm4125_l10>;
>> +		vddch0-supply = <&pm4125_l22>;
>> +	};
>> +};
>> diff --git a/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts b/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
>> index 727809430fd1..9bf52030bcc5 100644
>> --- a/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
>> +++ b/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
>> @@ -16,11 +16,20 @@ / {
>>   	aliases {
>>   		mmc0 = &sdhc_1;
>>   		serial0 = &uart0;
>> +		serial1 = &uart8;
>>   	};
>>   
>>   	chosen {
>>   		stdout-path = "serial0:115200n8";
>>   	};
>> +
>> +	vreg_bt_3p3_dummy: regulator-bt-3p3-dummy {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "bt_3p3_dummy";
>> +		regulator-min-microvolt = <3300000>;
>> +		regulator-max-microvolt = <3300000>;
>> +		regulator-always-on;
>> +	};
>>   };
>>   
>>   &remoteproc_cdsp {
>> @@ -57,3 +66,14 @@ &sdhc_1 {
>>   
>>   	status = "okay";
>>   };
>> +
>> +&uart8 {
>> +	status = "okay";
>> +
>> +	bluetooth {
>> +		vddio-supply = <&pm8150_s4>;
>> +		vddxo-supply = <&pm8150_l12>;
>> +		vddrf-supply = <&pm8150_l8>;
>> +		vddch0-supply = <&vreg_bt_3p3_dummy>;
>> +	};
>> +};
>> diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
>> index 124d0f05538d..73681bf0e3ea 100644
>> --- a/arch/arm64/boot/dts/qcom/shikra.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
>> @@ -1753,6 +1753,13 @@ &clk_virt SLAVE_QUP_CORE_0 RPM_ALWAYS_TAG>,
>>   				pinctrl-names = "default";
>>   
>>   				status = "disabled";
>> +
>> +				bluetooth {
>> +					compatible = "qcom,wcn3988-bt";
> 
> No, it's not a part of the SoC. Move it to the board files.
I will move the node from the SoC DTSI to the board-specific files in 
the next revision.
> 
>> +					enable-gpios = <&tlmm 88 GPIO_ACTIVE_HIGH>;
>> +					max-speed = <3200000>;
>> +				};
>> +
>>   			};
>>   
>>   			i2c9: i2c@4aa4000 {
>>
>> -- 
>> 2.34.1
>>
> 


