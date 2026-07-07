Return-Path: <dmaengine+bounces-12066-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kTl3HyAFTWpktgEAu9opvQ
	(envelope-from <dmaengine+bounces-12066-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 07 Jul 2026 15:54:40 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B421C71C2A0
	for <lists+dmaengine@lfdr.de>; Tue, 07 Jul 2026 15:54:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=LPYkXHvG;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=D79YbOn2;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12066-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-12066-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8297A318062A
	for <lists+dmaengine@lfdr.de>; Tue,  7 Jul 2026 13:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B919A41DEC9;
	Tue,  7 Jul 2026 13:43:25 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB2C41D4FC
	for <dmaengine@vger.kernel.org>; Tue,  7 Jul 2026 13:43:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783431805; cv=none; b=JYI0hR9WfrWoXHqE9/RKvYe0DrHE7RlrlZr4UhxB+XjYzuAvZ35wJBuP87kvItqnxDixXzzR/89CauyCHe/h5/1feTRFq2gRhFvkHYWKIS/vG5WgFeWGuOZMtqMBiyWDIxr2jKw+qhX6BSIESCtroH16bEQj0fQIGjz86WPZOBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783431805; c=relaxed/simple;
	bh=gxUSNck89gYwBMqUdYKokKwDKQcNQfZ3Hv0Ejt/slvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JP3+ad6opmaFPvN3P7dRB2tB/DWheR4hx8dQjtWye955vzGQCMW8kw6Wnnyt5JX3XsKtA0+8hzWcuX0WqkPj68TKOxzD6btaDvxj83YgZppqqqcB8qH5fSuM+X92TVK8qUcAfU9+xSluuIcBSbs1lYJ5LW0ReOgJLfLgHPE3x9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LPYkXHvG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=D79YbOn2; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 667C8g2c3616596
	for <dmaengine@vger.kernel.org>; Tue, 7 Jul 2026 13:43:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	M7QEyPtVfMKyZk5fDZPPH8A31rfGPkH+xRl0G+FLYR8=; b=LPYkXHvGDrjDuFeb
	WCjQwoOxFUfzbx5qjIgqsEVZNsZWMGva84hBLfsvR4u9GX7KnljOqWNxOD0zjfGD
	JJzMIoZ+FiNeAje6JbMcb5fMMO3yR/SuYeUpvgTggdovlvjs8cc2mtTNuDHWebgU
	rHkH6L+Rl+xEPLL5O2D107bTZtD9Z0Rmg1qNUv4MS0FP6cx0NrB1NK7EX2AgOSs8
	Kdnz8weCHHG9zhsWaJH2kbpemx0FcJhbTAOJDrQH7vne3tX69rSSULkKa2qMyaEE
	zYXUf+mDE3U7mo1YeYLgFINrbKmPaJin66t4iQBKZNTQkG2YaHPGpB/86eXYxHmy
	YS3ZTQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8vun1h9d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Tue, 07 Jul 2026 13:43:23 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-845ea8fd3easo9839002b3a.0
        for <dmaengine@vger.kernel.org>; Tue, 07 Jul 2026 06:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783431803; x=1784036603; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M7QEyPtVfMKyZk5fDZPPH8A31rfGPkH+xRl0G+FLYR8=;
        b=D79YbOn2LEZ+N4urrfi1nqwyLIcP1C/DI1t8R6Q3qqlwpF4ZiEq58JrYL/KVjn+8gR
         rtl49gqWkg26hhxO21dqCqeTZX0OMGwMgjabdN0+U5DYYhMUm1w8RuPoWKs4JysKAnvd
         fxZWuqI8w0PXJg9aMdAjQ6ZWJkK5ggs+6oac+VJBFYCTItkmIikhExcIPgHcpbvDGw6k
         6vaykvds23x/IE+c1lucRcPM8XLIo+rWAGeg9eegIWvbwzJ0xs/s+Ji1hgsCWYM5RhBb
         He+tt7y7KrSdLyoTvOynInQ7bzrn9+HJnuglWJuMC0thkxZOSF86UJ/esFut70WDLuj7
         UZig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783431803; x=1784036603;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M7QEyPtVfMKyZk5fDZPPH8A31rfGPkH+xRl0G+FLYR8=;
        b=jzYLrez2dPlPtmCV3afhQM9VzTTS4ezHrqu0qy7zfDF7B8Cpq94MtA0qo/c5DV+W21
         8i49J02rfKnRoqcrQUmvBJVUMQ/UOS4iFdHlT1OW16fKVs0NHYPjuAdbBW8zp+ZVvR7j
         oXujZzshvddRkAwXBUrlLe7S4MjK8Po72kfYB3VpluG5IRyfPUPsi+7zpmvErq0wJcny
         /5nY3BNoc8JKLxS7h/40GyX1lm0usIXnoBwtN54v2bKzkw6je5jmsPjrcIwEduFh9Agn
         x636uXmZJdWd/kqs+bfKDYGshUURqY6621f4XhhhhsjiMoEu0396MSvNj8hPTXqOXIYp
         nB+g==
X-Forwarded-Encrypted: i=1; AHgh+RqHNw5b1JukfwAMQW3FrYnX7LGNTStRJ/G6yncbEj15QMUuVsU3kYj/wCJmXfMzDheUJ1Nvuow16To=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWrQVrYLcqulz5pAC46bdMC6Zwcxm8Lzvxdhx0Tr+GEihFqY2+
	L1QyAkvgq7y7g9WMcdj5xsitpED0ePZS3R6FHj8QHa2fziwtMO05CNej7D3bd33JmWvetXDOcQL
	zu9UZuXR7mdbHvJAvdpnRbrgiK92rECWAbSOrQR8OzBNjpDshnnPm1MTUFEBOUX4=
X-Gm-Gg: AfdE7cnQwYkn7ZYrs6hS2/yvoxO3kUDyoDisaDdyGjHPxWN4HsLcEXFvQ6BAwad92Xd
	a01nqXgWmDFefpuV+x8dErh6W5L1pH4MqfhNh4C/L7sA2iHYfMrcd6l5OY63uNjLnk6221w8ctL
	z4fcdsk3FaHDU267Klz5UdO1iYqJgkk/N5WRqJjh9DA/y2AoVqvvMXoNTrXcyzyNX33Tv1FNpYu
	0sWRMMGzN2/PQib4O184+KtbLs+O35zu2DFr9kqR5grwDyD+BWPq9DkTEkz8NRwreYHXyaaj4a2
	GQnQWELzBjKeuFqXWUFuy8tJlmhu36shDnMwOZATCA0yFQv/jI1EppMeacuPbefImPLbU9X61hN
	64Kh1jcJGNBuXXx7+1514Qdx/94mHPIA4aHh+Cl0=
X-Received: by 2002:a05:6a00:3288:b0:847:893f:2d0c with SMTP id d2e1a72fcca58-84826c1edeamr5401114b3a.5.1783431802988;
        Tue, 07 Jul 2026 06:43:22 -0700 (PDT)
X-Received: by 2002:a05:6a00:3288:b0:847:893f:2d0c with SMTP id d2e1a72fcca58-84826c1edeamr5401067b3a.5.1783431802456;
        Tue, 07 Jul 2026 06:43:22 -0700 (PDT)
Received: from [10.219.57.117] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6d498adsm5372916b3a.32.2026.07.07.06.43.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2026 06:43:21 -0700 (PDT)
Message-ID: <ca657be0-72c0-40a6-86e2-9a34f763d24b@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 19:13:15 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/11] arm64: dts: qcom: shikra: Enable Bluetooth and
 WiFi on EVK boards
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260702-shikra-dt-m1-v5-0-f911ac92720c@oss.qualcomm.com>
 <20260702-shikra-dt-m1-v5-10-f911ac92720c@oss.qualcomm.com>
 <0ac50f09-8a62-4735-99e3-b8e632621ed5@oss.qualcomm.com>
Content-Language: en-US
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
In-Reply-To: <0ac50f09-8a62-4735-99e3-b8e632621ed5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDEzNCBTYWx0ZWRfX/bzMcJ9PjN81
 yLbpD9yPRrSf6aefmY626HyzEV5+0q9DKjijih40SmXspZNvc5kSejHfBTjZH8BNxP8Mn2d2xL5
 e526RgHY7NC2cJnY0AvSGXI2KjggvzI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDEzNCBTYWx0ZWRfX5HC+D/RTh4Tk
 LSd3smcBa1010gKtuRyhwpZ9YFiaMYRB1DRVcE07IJAJAGTOa9IAF50tTJcTALpyICRci+XX4Cj
 3cYWGlM0jvhqWUZayNG+TRhJNydE/W1Sb5TExaTq5JbOSN40qFyQrvo9Y3MTdqROyG1lj2PsvMw
 JbqWmwMW+k+FrzpqfUsYZCIZNEI8QZCl9UkDWlisBLilx7Yz5y4zKvUzqmSWxGbG3GmT4EUtONk
 MjErCozywo6Izs1aoYnfmUiknDsgAOiw8YBLIiN0a//cNFA1ktkdFKXVNgAPZFUv6W+KL+8PCbP
 p5Mjonltm5jgg/BcDi690ahQ3vxuRGlziDyWp4h/ZZ/AoRtPCmCL2ottX+nFGAEc9eEDxjCCMma
 pRBd40Fit85emJA7TEQ+FSBDRtn4SWmROQcwUOA32ezLOLreTYzAaB3JXZtFzdwK9vkRu3DyUae
 ExA3hq8QuZACIjj+iig==
X-Proofpoint-GUID: SGbyR65OuV70OfcR8Nk0PU5yG0TZBMdh
X-Authority-Analysis: v=2.4 cv=N+IZ0W9B c=1 sm=1 tr=0 ts=6a4d027b cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=6-GiX-wp50tAbMgTt0EA:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: SGbyR65OuV70OfcR8Nk0PU5yG0TZBMdh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070134
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12066-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:konrad.dybcio@oss.qualcomm.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:krzk@kernel.org,m:djakov@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:linux-arm-msm@vger.kernel.org,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pm@vger.kernel.org,m:yepuri.siddu@oss.qualcomm.com,m:miaoqing.pan@oss.qualcomm.com,m:dmitry.baryshkov@oss.qualcomm.com,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[komal.bajaj@oss.qualcomm.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,vger.kernel.org:from_smtp];
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
X-Rspamd-Queue-Id: B421C71C2A0

On 7/2/2026 4:29 PM, Konrad Dybcio wrote:
> On 7/2/26 11:50 AM, Komal Bajaj wrote:
>> Enable Bluetooth and WiFi connectivity on Shikra CQM, CQS and IQS
>> EVK boards using the WCN3988 combo chip.
>>
>> For Bluetooth, enable uart8 and add WCN3988 Bluetooth node with
>> board-specific regulator supplies across CQM, CQS and IQS Shikra
>> EVK boards.
>>
>> For WiFi, enable per-board with the appropriate PMIC supply
>> connections and calibration variant selection.
> [...]
>
>> +	wcn3988-pmu {
> Override by label, this works but it's super fragile.

WCN3988 is present on SoM. In next revision, I will move this node to 
SoM DTSI, so there is no need to add a label here.

>
> [...]
>
>> +&uart8 {
>> +	status = "okay";
>> +};
>> +
>> +&wifi {
>> +	vdd-0.8-cx-mx-supply = <&pm4125_l7>;
>> +
>> +	status = "okay";
>> +};
> Since the module is on the EVK board itself, push the enablement of
> these nodes there too

As explained above, I'll move these to the SoM DTS.

Thanks
Komal

>
> Konrad


