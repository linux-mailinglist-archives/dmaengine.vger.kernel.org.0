Return-Path: <dmaengine+bounces-11025-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6PusFNNjGWoBwAgAu9opvQ
	(envelope-from <dmaengine+bounces-11025-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 29 May 2026 12:00:51 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7093F600645
	for <lists+dmaengine@lfdr.de>; Fri, 29 May 2026 12:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 336C531A4547
	for <lists+dmaengine@lfdr.de>; Fri, 29 May 2026 09:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5EC3CC334;
	Fri, 29 May 2026 09:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UmKtrD/V";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DKXtChek"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FE33CB2DB
	for <dmaengine@vger.kernel.org>; Fri, 29 May 2026 09:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780048309; cv=none; b=AJmvwGUlhmodacAh5NNjA3s38y9hp8wFMdhIuLyzh+07lcIMM1qV4l4CZUp1kH+Lh43Qrgr4Okj3HtkAFV4M9FNlwkYtWPUPE5Ii0laEbW4rIfTztdIFdQo8BoqT5yay6leN4F5Cz7syWV5es2Kxv699579Wjg/2tk4qIGtFav4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780048309; c=relaxed/simple;
	bh=zoyilBfk5qDO8hOlBWwDvNYKqnHe5RN10J6n1BXF8tY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sR6uLUKdHPe0WStsQj2fxsfz41VgV33BDDl8U+OignGDn1zcpotSSYxhzYNP8lsCORlc5Lu9s/Cga14aDPO5G8AMpXHKPHGaKktjhpBgvGEEdjsQnzUUEm4IsYbZ6jkyTlf9+ybK6jTishLL2MJ+aQ+BGoS+Z0SvmAgoEiwEJ1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UmKtrD/V; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DKXtChek; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64T6bTOV3252897
	for <dmaengine@vger.kernel.org>; Fri, 29 May 2026 09:51:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kb/59PC5N1mTfolTJiRqjQBDqh2SUyjAiE2eqB+Z8IA=; b=UmKtrD/Vlb1grMgd
	5XI19AMj4izHqFDpeHpoNpUfqKZsP2XEM6zXaz5kX5EEZF9W82T/flTpVpJi3M/k
	ZMyp9SNWmhHFOBQFWjy8S0XPjzweWkxll0TddRmpds8ZA1nF6IRwJHGySClBrF4P
	2becXo2opzklkwMVO53N1Mblj97AqoDHPey+cqEBwgcTUjQz++roPthsURDNagdz
	SwwKejLMIWx/sqKW027P1C1TRGKOqhRyWS8p2+ty3dLfCCTepWpincXOz/w0cgAB
	WTkEVzAXxjRzipe07kX9kZnBkqkH8lJZ++MEMQRy3xjUP9uhiv80KezIvbFjGwu8
	mK5R5g==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eespn3ux7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Fri, 29 May 2026 09:51:47 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-36bcfce8a33so236670a91.1
        for <dmaengine@vger.kernel.org>; Fri, 29 May 2026 02:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780048307; x=1780653107; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kb/59PC5N1mTfolTJiRqjQBDqh2SUyjAiE2eqB+Z8IA=;
        b=DKXtCheknf6hFxeW7vRZGFB4gWQr5DKeP4nZPRquVajil4ikHUdQ6nUjkEUDaCHHF0
         /AauzyfwA9aTkyXZABdov2rF1c4wlzCQ+6zMAsMylQiAtmaAhDiQbW6hnKzl+DrrDEzP
         uUC2V/62cOilHrFpmogdHIeEND3ymu1JCCS3d7PiTMfJ+KVYs4zzqIYHLzW3PYOeY/nL
         LvTvtwctut2fA9e5/2psVlPkvXyF1ThP3YJYU64e65ch2pGzvNky5gDEAs28mx5yP71M
         ipqmB4Kn4Vy32NmuYwDkMx4FcirETFJsJrCPuFPCXjm1fhMHyVTOL5rBVYKLJ+dUbOm2
         TiQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780048307; x=1780653107;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kb/59PC5N1mTfolTJiRqjQBDqh2SUyjAiE2eqB+Z8IA=;
        b=cIIvkM4B8++VZgZ6X48uXF3HE+uJPBleab/qs7BpRE74nPxbSI9B35+Kv21IPJoZck
         cPTT+kJuaOQcDsWC1XECN1EPeOoU6VdAEMbkEgiSnVqbQsI1+WzutgUmykOfc1RrKL2d
         dl3ohNfXnWcvHB4a+VZZoNdRtwB/MjIN8nx9yh2lf4paktkY7JNuO+8+1oXr+IcqomFP
         Bw+NYZGI9hiRnti5jgUXlEd2iNRT7GT5ExTLSnJQJrmJc0CAlORLMi8i9E5rPfXafxu4
         F3t3y9z+H9DyvEX+QsCFtMrEHPHBOmMkUgXadHCUeQ0gTJjYofYRNmAC2bgjQsj1oswg
         Uskg==
X-Forwarded-Encrypted: i=1; AFNElJ+2TZYDh4Ex6XqdV7m9Gr7MOaohpQYTjT8M1C95n8Q+FrbLyJrazowBuVo2AKAiQ31JO2dgvKEyEcM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxadLHX8I6wsOA5vq8RgchVz/OvNZDJirg1GW5ezuLVX9oQcEDB
	7KtA/3BRJOle6IHmhYKpPtPucW4fQPKnzbKJ4EELlcrBQkKqmB1oGJXc0rKgrc77laWHPsqdVZm
	NSdqe1ShQYFlJKmZ0W3rCmrC3esJHzTylfChrQOm2jnjfnLrZCJEDH8Hdoc6+Spg=
X-Gm-Gg: Acq92OE6UOLqnit6I5hCUOUFuv1KbGglPH+yUdcs7Ux1kF39MDS3+wDxSj8dZnCzq82
	NFPqpmEGDPdd0LRp188lrIn6UF3A/ukv0uS6P9oknNgJJBQHQjkusVqCb4GYVfdIhNqoKtykFPu
	wTOoxhk3ynqsMM+8aNqs+cQp09zKe6U4WRX0r+iQbJL7cAgQ2MKIrYJrioIkSvowMKfoi/u0leC
	Tl99tiduwnhi5ZYE8NJsQcXOJA3irohgxNPYsjgCUh07idv8QBBk2qGZFgPcETmqYSleFb6SGOx
	rHCTk/l4ekBrEhqnowdMo6wlOrUC0XI0wZTL1b0LVjXrmfghYsqRiuFPDWdQw7C0Qfs9p5jZkv/
	FYNpmqXm/3OzqHZdDRV2EEGUH5spuT5gx8SPznX4HfzWusB+iQi9q8HvvAcM=
X-Received: by 2002:a17:90b:268b:b0:35f:b9f1:fded with SMTP id 98e67ed59e1d1-36bbeb52b1bmr1787548a91.12.1780048306637;
        Fri, 29 May 2026 02:51:46 -0700 (PDT)
X-Received: by 2002:a17:90b:268b:b0:35f:b9f1:fded with SMTP id 98e67ed59e1d1-36bbeb52b1bmr1787370a91.12.1780048305759;
        Fri, 29 May 2026 02:51:45 -0700 (PDT)
Received: from [10.219.57.29] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36bc0c3d44fsm1608825a91.17.2026.05.29.02.51.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 02:51:45 -0700 (PDT)
Message-ID: <924cbe51-2f70-4d62-ad8d-51a7cc7d1656@oss.qualcomm.com>
Date: Fri, 29 May 2026 15:21:38 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/16] arm64: dts: qcom: shikra: Add CPU OPP tables to
 scale DDR/L3
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
        Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>
References: <20260525-shikra-dt-m1-v1-0-f51a9838dbaa@oss.qualcomm.com>
 <20260525-shikra-dt-m1-v1-7-f51a9838dbaa@oss.qualcomm.com>
 <4ugjyb73ftcjypi6wfqz47j2vvvfxj3ljunsqlixzdzzajy72c@3gb2bnx7coy5>
Content-Language: en-US
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
In-Reply-To: <4ugjyb73ftcjypi6wfqz47j2vvvfxj3ljunsqlixzdzzajy72c@3gb2bnx7coy5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: toFhEcmTZ74XCiqBvXChmY4G71024KyW
X-Proofpoint-ORIG-GUID: toFhEcmTZ74XCiqBvXChmY4G71024KyW
X-Authority-Analysis: v=2.4 cv=auOCzyZV c=1 sm=1 tr=0 ts=6a1961b3 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=2PthHyxMAGplJbN0v-YA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDA5NiBTYWx0ZWRfX5rRl25VAICXH
 eqmZZ0sGnYEEUbpJqUuiZZbsCLakuwDyJ+baO59oLCqqxNoIadn8oOp+sTyZX4NDI97UDDuHg61
 euRMiicrN90fuQybHYAZNlqspK5zD2in1N1L69HEi49/7OfkObcmvZ52MDknLieJRv0FOs8BGqM
 KwvzzGbcEiutOHfcOfvpaAwp2Y9sf9lwcIUpfXYzb5z3woycRAsjm5Shv7cOMGsdocV2l+diLrE
 3tiIJsQal6pmYGc+XPmZSk1V5xo52AoTD8UoeOsk4H6sdcvHdg+myQAsNoGYVQeWlSQj8tUFk3R
 CR+I47yJ5x0AjldVheOTAEdv/m92YSCArlLf1jFT+UJfgKwp4TVfcQSvlQBxEjPDZvz2MBMo0Tx
 9uGeOeNFng+D2UFUOUIs/dYrrWPsyp2I4unD2Zsv9apjaf57bNbRwFgXRNbr+HhKRHRc7Tvn6Ua
 eAH1FLjdLKSchDXqxrA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 impostorscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290096
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-11025-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[komal.bajaj@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_PROHIBIT(0.00)[4.196.180.0:email];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7093F600645
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/25/2026 2:53 PM, Dmitry Baryshkov wrote:
> On Mon, May 25, 2026 at 01:19:11AM +0530, Komal Bajaj wrote:
>> From: Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>
>>
>> Add OPP tables required to scale DDR and L3 per freq-domain on
>> Shikra SoC.
>>
>> Signed-off-by: Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>
>> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
>> ---
>>   arch/arm64/boot/dts/qcom/shikra.dtsi | 84 ++++++++++++++++++++++++++++++++++++
>>   1 file changed, 84 insertions(+)
> Does it really make sense to split cpufreq_hw, EPSS and OPP tables into
> three separate patches?

Okay, I will squash these three into one commit in next series.

>
>> @@ -144,6 +164,70 @@ memory@80000000 {
>>   		/* We expect the bootloader to fill in the size */
>>   		reg = <0x0 0x80000000 0x0 0x0>;
>>   	};
>> +	cpu0_opp_table: opp-table-cpu0 {
> Missing empty line.

ACK.

>
>> +		compatible = "operating-points-v2";
>> +		opp-shared;
>> +
>> +		cpu0_opp_768mhz: opp-768000000 {
> Drop useless labels.

ACK.

Thanks
Komal

>
>> +			opp-hz = /bits/ 64 <768000000>;
>> +			opp-peak-kBps = <1200000 17817600>;
>> +		};


