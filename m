Return-Path: <dmaengine+bounces-11027-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mL0cEMZoGWpMwQgAu9opvQ
	(envelope-from <dmaengine+bounces-11027-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 29 May 2026 12:21:58 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 94771600B8C
	for <lists+dmaengine@lfdr.de>; Fri, 29 May 2026 12:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B33E301C165
	for <lists+dmaengine@lfdr.de>; Fri, 29 May 2026 10:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D063BCD3D;
	Fri, 29 May 2026 10:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BIqgbXkg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EaOoDM4c"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE8A363095
	for <dmaengine@vger.kernel.org>; Fri, 29 May 2026 10:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780049851; cv=none; b=RCnn+1cvtmNII3VXaTbWuVTKUZcx6l+rlmq2O2fYlHlMMbZQiX2pN6MKAw19EP5xoWgxx//omenbbxVPOirq1bdTUrug+qBVUWzpu2ahz5hdWSxFJCQsVkl6hkhhJpsAUjaPMkhvxBm1aR1MG/xII9DuZzntKEGJlMp9cly/Dd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780049851; c=relaxed/simple;
	bh=wsTTRuHUZyUK2eHffcCelXOtF0Eanqo2UbgT/sM+3MI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o4DCdgm+KPLsxF2nQTRzgp5ION2jdx4iiZHU7garwzRo0Wf2vXpQDpFp9YD5y5IA2lDCqXyvWMeRnlvv9atOjAJj1IdmHj9BOiw9WGzRvfrO1iAxJ0BvQ1qfMuSs9L7aGuhoynHqphVWZ0HKcGm+uqDpmed3eheV5JyV4ziH6Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BIqgbXkg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EaOoDM4c; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64T6OrC21370227
	for <dmaengine@vger.kernel.org>; Fri, 29 May 2026 10:17:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QlFPCdtZLGigc27wlhIiQC/YA2l7/69jHdSprQoVZBw=; b=BIqgbXkg22cpNPPU
	1pY0M8VNRN7Oh/5UUY+KY4rDi0rHJ5zM3AhUWS0ilyFhJVAKwzFCwikg54MO0lA1
	ZZwErYVBCuXb2AVwZx8i4j9Ff8B7Li56H4/0kVW0y5y9o6Ei+MBSzhQryga4CZba
	mqi80RoAbOYQLgOnyVtnU4xSFf6NZBZDbcblS2PjDw0yprxYs9JaSa+TNFA9RWCe
	0b5BhqB4JJhVQPRo3EMgUZnSUfeb0/gUUHFeFqtcwxVFGjjQ4dcPTA0X1DvS6OX9
	tJ2x4ztc7kyLEvWtTtJSMkMw/gTtlKloitSvx2D4Vvr1hjPFnYkzE3lHT0wmwvB0
	Fb8lrg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eety5up5s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Fri, 29 May 2026 10:17:26 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-837c4eb3bdfso8578506b3a.2
        for <dmaengine@vger.kernel.org>; Fri, 29 May 2026 03:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780049845; x=1780654645; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QlFPCdtZLGigc27wlhIiQC/YA2l7/69jHdSprQoVZBw=;
        b=EaOoDM4cIm/Nwax77CEjPXaXRTNolksC2fmv1EZefd0mmUGBoWEq4+X3nCfqfgpjvH
         KWgL3hklRSOX80C5an1AA1FtuC1u9hQ1IG7tNDtHCRBLUuG4x7P65a004gLCaJLdthGA
         Zh/OfT6CZ0RSz2yuIQbpEhRidcWnijwb9KQoXZ1v1r944P+/ybMWxvNOHrX7sJjWctVb
         dg4RnZIN525RykBzwj9xSiz4Rut7w037m4V/s3skOGeVoyQe/dK0O/i8mNZJbE5vUia3
         6wNXp7JqyGpa+Z3D7+R05VMAOb3WZwwbMj9RC2R7Fpib2s+2Xidd2Vq7FNovTxKkwkxS
         VP+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780049845; x=1780654645;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QlFPCdtZLGigc27wlhIiQC/YA2l7/69jHdSprQoVZBw=;
        b=gPQyVdyLaaOVT2nr0ta6mvywWYpsys6PSfpZspJDvVzptPmu1IpPD8BZ+pRMjXPKS6
         XoIGTqhGfjGWoe79B6A7NkXD+mgVYBnMB9QWYUPFQKxrtjl1eZm1JYB29Rc3RNvAV2eW
         Ewpo+pYYk4CWJCRlSG/3GXdY3omPV6U/0KPCsj0zjM+aqNbT6wP7STmZw7O/0Q16c4tm
         3vR0Gp9JV88hHKcasulCzJvC1n2NmZv1dAhK7zmcAQmbG/bHmiMchj6ePCbG66wvbZw6
         Hx/gZBVdnx38ahlNO/o5n79rT9/FdBb+pSyb9Gm635z9TwrTv5mt83uOTX+R03epyBZM
         zwEQ==
X-Forwarded-Encrypted: i=1; AFNElJ9WsArpcuJ+LUkA50NlRcWVQ+HzPgtT3NkGvGtR11J90la6VNMaaD0DEt4HUWIGqgNFCOxk9O1r4qc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbXXFWwuhFuROEHTBbEprU2kNQrXrTQUc337runsrIQuoZLjPQ
	FY4iVr9KR+ELog4y+HUSlLrK+uP3yF72UVVYn86Z36ZiMoYRO+9o1w9tAFcMuTO9HsCb4YhWTzp
	xWC/dIWZPPbwn/M1tmA2sxvxaKXlg8gU/jLpXhsvLK/olPwf2MHR6Q1IhSq/bgBg=
X-Gm-Gg: Acq92OGCwX32nEHHg2ibUqaWtRfGghuSd0QlrA6cga+qsYWRbHdmS36MGdA3JpAaFfg
	90uk17UQBUjtHibSbCFep7sQDEO6my1SyMLpm6hhIzIF8kNq/TdpiQhGmDam2c2RTAMwgzFHikW
	z78yWezQBZ5IVanXYPNtQNlRU0DPO90TpXsFa+Xg6BAu9zcBT9+rmpW1aveoQakRGB1oxWRPnk4
	BWZi2DAOin/GgTOFv0MffNmwxzloIxkvZVpOh39zB5SOu+2LJKKO3V90N31RFSd9nWoKlCXLg5Y
	x4AjlYaW/jv/97CTXwyVMSW2vKiQdFaibfo4/w6zg0kueIxbGLywERnTp3uiOUhptE8Kj29FvPv
	2cDXnj2dg23fraKGVVqJp0Xr89YjXMg9SBifqA1INHAgQQ38F7XOFhpvqeZw=
X-Received: by 2002:a05:6a00:3690:b0:82f:3828:a01d with SMTP id d2e1a72fcca58-84212d35431mr2340233b3a.29.1780049845187;
        Fri, 29 May 2026 03:17:25 -0700 (PDT)
X-Received: by 2002:a05:6a00:3690:b0:82f:3828:a01d with SMTP id d2e1a72fcca58-84212d35431mr2340201b3a.29.1780049844647;
        Fri, 29 May 2026 03:17:24 -0700 (PDT)
Received: from [10.219.57.29] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84214b307acsm1440342b3a.21.2026.05.29.03.17.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 03:17:24 -0700 (PDT)
Message-ID: <63794650-69d4-4ebd-91c4-89bce022c772@oss.qualcomm.com>
Date: Fri, 29 May 2026 15:47:17 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/16] arm64: dts: qcom: shikra-cqm: Enable CDSP, LPAICP
 and MPSS
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
        Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
References: <20260525-shikra-dt-m1-v1-0-f51a9838dbaa@oss.qualcomm.com>
 <20260525-shikra-dt-m1-v1-10-f51a9838dbaa@oss.qualcomm.com>
 <xq6vkeer7c32fmmofhu3yxnwxns4mn7umzwjf6k575m55s5mek@zrjiuo3eiq37>
Content-Language: en-US
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
In-Reply-To: <xq6vkeer7c32fmmofhu3yxnwxns4mn7umzwjf6k575m55s5mek@zrjiuo3eiq37>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: cLKTuDxivSxXSiTdY3ioTWKJxYxMItRf
X-Authority-Analysis: v=2.4 cv=TeqmcxQh c=1 sm=1 tr=0 ts=6a1967b6 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=S9tZMReaGwYLiO49R74A:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: cLKTuDxivSxXSiTdY3ioTWKJxYxMItRf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDEwMiBTYWx0ZWRfX+xhG8KL+Shpl
 G9o1Dc5FTlvtDu0e/m5SgSbVLRu3n8yCPEsT3r3DiyR6vk5xoxXioYyv90omLwpty9HV3M42lfA
 HmUFzfhSSr7BTA5c9hDTAlZa+f/CdflMbO8yUIIe9dY7qebVdpeyBLl502ct+favsjC0pJLcrc2
 JKd0kQ3A7lZGpkBMxYtXulA+EgFZNZjAhgxUbNyiOhEsw1vwMmALuqtLPO3R11NvFG8RzIjLX0L
 LKAzj0bEAdkxTEbOTB3+s9gn2PHTtVReeIREz2ttFn5A5lr2ewPh9PAPOSuRjpdpTGFjcXwQ/lc
 9Iop2FIivDAkfHNWAdHmUFPfN3EdLy4brFFw5feTXaBvLzjwK5VZUQ9DlKiN7kBPU0G96Oi+B1Z
 GFKa4dQ81OAKSCNlUX4jVmb+8Hj6AAYgkpjPaai24PX4opeZZTp0bGinM9p8z225k5I3krvmg+r
 VYxtLeKOHspSYNtHqMw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605290102
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-11027-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[komal.bajaj@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 94771600B8C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/25/2026 2:59 PM, Dmitry Baryshkov wrote:
> On Mon, May 25, 2026 at 01:19:14AM +0530, Komal Bajaj wrote:
>> From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
>>
>> Enable CDSP, LPAICP and MPSS for Qualcomm's Shikra CQM EVK board.
>>
>> Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
>> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
>> ---
>>   arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts | 19 +++++++++++++++++++
>>   1 file changed, 19 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
>> index 0a52ab9b7a4c..b112b21b1d79 100644
>> --- a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
>> +++ b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
>> @@ -23,6 +23,25 @@ chosen {
>>   	};
>>   };
>>   
>> +&remoteproc_cdsp {
>> +	firmware-name = "qcom/shikra/cdsp.mbn";
>> +
>> +	status = "okay";
>> +};
>> +
>> +&remoteproc_lpaicp {
>> +	firmware-name = "qcom/shikra/lpaicp.mbn",
>> +			"qcom/shikra/lpaicp_dtb.mbn";
> When can we expect modem and LPAICP firmware in linux-firmware?

It is anticipated to be updated in linux-firmware within next three weeks.

Thanks
Komal

>
>> +
>> +	status = "okay";
>> +};
>> +
>> +&remoteproc_mpss {
>> +	firmware-name = "qcom/shikra/cqm/qdsp6sw.mbn";
>> +
>> +	status = "okay";
>> +};
>> +
>>   &sdhc_1 {
>>   	vmmc-supply = <&pm4125_l20>;
>>   	vqmmc-supply = <&pm4125_l14>;
>>
>> -- 
>> 2.34.1
>>


