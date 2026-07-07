Return-Path: <dmaengine+bounces-12075-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0CfrGhsrTWpPwAEAu9opvQ
	(envelope-from <dmaengine+bounces-12075-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 07 Jul 2026 18:36:43 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A71971DE8C
	for <lists+dmaengine@lfdr.de>; Tue, 07 Jul 2026 18:36:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=V83Lk7Ef;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=FxCtv8Rf;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12075-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12075-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 270D1300721F
	for <lists+dmaengine@lfdr.de>; Tue,  7 Jul 2026 16:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94A5435AA4;
	Tue,  7 Jul 2026 16:36:16 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4294A372049
	for <dmaengine@vger.kernel.org>; Tue,  7 Jul 2026 16:36:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783442176; cv=none; b=Bqhr8QKmR/m8Ih8fb7LqoHVYMp5cs6fPxczW4t6cjz6FBkaoS1knT4HUebr9ZnwwocaFIAN7CtOjkW3pi88ID/dJGmpZ3XiP90JNiP4PuYN1qQ7Iw7J3IMHMRRBkPYviCskZx0hH32fg8rcSbBAv1us+qAxkMdSzbqvEFxbEZbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783442176; c=relaxed/simple;
	bh=jD7vMq40BtjbLgY2tK+JEwoLI6ZCP6ExRZNtAmmlxYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d9tvXha9F4u9I/6HEgCeiuFI3XpcDbSXFgRoauavTTA/mInwzIQa1DOjur9BF50m2mqGljMUukFarjcf5vLmZuRpX8hHt+/3y5Pk1j8FHf04h3wynoQDI3hrCPGMSQdYNG142dNmiwG3qSSQSbdIlkVoLvxUsf2DyHS10fH0IrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=V83Lk7Ef; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FxCtv8Rf; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 667FT2qv045829
	for <dmaengine@vger.kernel.org>; Tue, 7 Jul 2026 16:36:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rOfu/YSWSoVJ9+8gOLnE9/D8lneB3OTBsZ8QT6Zknbs=; b=V83Lk7EfjAfcIHfd
	bkLPBHZ7XgqzFQ9jyOKPYHyMkGKzP7+6Qr/7y1Y10nxHQOmGEnfiYcdrtZj8vJVe
	huf+LH3EXGxlwQ5Zc6gyIpLVJkcFUXPxNu1Lub0lZrhHU5Incyp/bl7LulZNGj3T
	1adSCkhBFLXP5OqmCWI4hBid86sdntPa/eAK3cAbrPHA5OuiOjKkVbwzloPyitAD
	Br7JeOHWzbXFwR+BUvgbDap8qMW3pwVx4gZLZ9Y3ERe/oNl2kWYD8GydLMJK/bfb
	TTLhMaPXC5iX7SptJ/yL4LOhOzXFNvsXketDXDOrDheXo5ZHJij0XomcMZ3TOSuH
	XJlWpA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8w11t8b6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Tue, 07 Jul 2026 16:36:14 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2c804e38c65so87710855ad.2
        for <dmaengine@vger.kernel.org>; Tue, 07 Jul 2026 09:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783442174; x=1784046974; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rOfu/YSWSoVJ9+8gOLnE9/D8lneB3OTBsZ8QT6Zknbs=;
        b=FxCtv8Rf8Uekvi4+/jnXVNMxDJq6E+bhmfoiK/LBmEBqQPcuEF4gKhTrQWzNy19KTx
         eu+gopMGpfMo7VlB0IJ9F/9I2FN6fcf2/cxB8ew0NY7z3sGpN9sQASia5lxGreFhizkx
         bb0z1GiXWDl6fY8oCahECnFyzWf/PxEXNVOxJVwCC+fvQ1RbCw5aXdxIAkK/H6pASCq2
         x6O8Q36WiOx3fP1twVisOdhPM9BvrOu1wyosFXII/JTUSjXLDtkOJOPNSiaZGv02jpvr
         /TShSUUZyfaSvymSMOYS8Q7pg/AHzQ/+PrmoCRCnYhS6A1V4lEG0ixZ9YjVqW0Rz4GtM
         alAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783442174; x=1784046974;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rOfu/YSWSoVJ9+8gOLnE9/D8lneB3OTBsZ8QT6Zknbs=;
        b=OfhR8VaTePcZRuHRhMn/SA58jDSx4YUbOM4cflIhWx8s0YiRpp7IuSalTbEWwrwaWn
         fvgPFPTE0ffbNNioWAvLI7AMNjO5odVuxst4HsYStxbPAuld5qXMJara7566KPBHS64z
         L5JDEugwoRjG0OR51AlEeRH85/zSf542gwrelq1f82ZuVXQN97h09l5ijV8xpGlSWX3U
         d2Uyp+Qzc9bgTbeyJ3LuJXGIPNfjPaX7XqoQnUFqrN5un7cVhUaSQouAhccj1MYnll5K
         BOnNoAnFw2MWGIzuelbJ6mSPoxktnyDPsIS4qbBQVQg8hSSmrJw2ZfGzdpSDnAUTGdMX
         qy5A==
X-Forwarded-Encrypted: i=1; AHgh+RpfXmIrLPZC7ouFvC4z0SbyE8/i4cRT8mbZgUFdJib6hQiqxawoa9PxVei4BxGzbdA9iIiK0MsTfgs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGqwirhewbc5LmlvxrC5hBePgsKR87V4+5u1aZ4JLFYSl73W3S
	q3IVdR7upxd20gIuQPC9YOO5Hk+wBWZKDw7Q5XbWw0ynMp9Pl+ZmKM3fd4OKCokpB2JEaTb02FN
	vZMc03C0bRq50JSo2PWSj2VUjSvojt9WN5lWoc1Wr1Q9fwEZ7KKdx5xAc6XF2sEg=
X-Gm-Gg: AfdE7cnqnjG1ArbqE3+lk1CQgA5U20mf2vfeicHx4j+yxwI8xH0v+CEJqRYEc9oBaG4
	GiH5shVLTXxzLKAQXq1k3gUSD6qxm/8xqcDVJQsilNSSI2pqwPmCKPUHh6v274csCggrQhgreQr
	BLYgJkqvj1uCRjyKIQRpOz3A1DK/srWtl9pXrUgAQTn9ngC7me6q3kWgSsYrIqyXt1tPKqlOvl1
	l/V5IyB/oU6SvMzD8pHmaKX0KSd7/QzUhBnh9Bsb994tN6EuNycjd6Y1bD5dzcQ5nWe4O8o/RDS
	5mQ8s27aF6FXOAThjVWGguJ28UF4RwouQslZvaXbqdrjqHDQlIYEhzLj9dX+xgFHft8iX/yLjmK
	7L1dbdCKeBZLnLwOaTkf7Lyixl51xoDE6+7BT+VlfwA==
X-Received: by 2002:a17:90b:4ec5:b0:37e:1609:b304 with SMTP id 98e67ed59e1d1-38756801500mr5684092a91.1.1783442173918;
        Tue, 07 Jul 2026 09:36:13 -0700 (PDT)
X-Received: by 2002:a17:90b:4ec5:b0:37e:1609:b304 with SMTP id 98e67ed59e1d1-38756801500mr5684047a91.1.1783442173406;
        Tue, 07 Jul 2026 09:36:13 -0700 (PDT)
Received: from [192.168.29.166] ([49.43.234.127])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3118389d9bcsm2524489eec.20.2026.07.07.09.36.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2026 09:36:12 -0700 (PDT)
Message-ID: <97b205e8-5ab7-4205-b1dc-cbcb0497987d@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 22:06:05 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/11] arm64: dts: qcom: shikra: Add
 gpio-reserved-ranges to tlmm
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
        linux-pm@vger.kernel.org, Anurag Pateriya <apateriy@qti.qualcomm.com>
References: <20260702-shikra-dt-m1-v5-0-f911ac92720c@oss.qualcomm.com>
 <20260702-shikra-dt-m1-v5-11-f911ac92720c@oss.qualcomm.com>
 <9c1aab59-14b2-4811-b778-8e96645bd65b@oss.qualcomm.com>
Content-Language: en-US
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
In-Reply-To: <9c1aab59-14b2-4811-b778-8e96645bd65b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=DMe/JSNb c=1 sm=1 tr=0 ts=6a4d2afe cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fIivk1FRtaL8gRNK6azaIA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=TqdALn-mf9RdMn6JgEsA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: JhHds-Stt3hUpjcHBk7IpUZWba9zYLJX
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDE2MiBTYWx0ZWRfX5D8q/1lho4GG
 x1iVLSQ429w0gNzFn3PfUx/kDO2xHt/x0g9NayBfw3S+72K91iCX1ylqQaDMvRvYen3h33rsRbi
 /ItXM/czSRiZ+ueH/3HQ27reVi1/hJk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDE2MiBTYWx0ZWRfX6QiYjYHiQIVh
 1c2WgaIZIA9iQPcJDZ/6uHpxDOjp5mFEddfQQfilc2Jc3HAF3U3Y/9V9d6R0QJh0DA+HYHLz0C6
 BSWROERXYm3YVBENs+si5cnhK/xr8AoD0t1Tk8yylrp0cBuCV5WSZBYm+t2iHwemFh/okE+SxiJ
 XGhKtyLc+kNrjE8EN7lXahuAa60S8DDHDns07q90TxopT3vf+D3kc+X2aLgvvobF1VTJx4iGecU
 BLToIhF0xPE3oBy5Qpm94Z4tWKSBnv0loH5y5SGsZuv1qTFxU3EQZ5BZb9EcMRORcUEV700U+Bd
 P5uM0keH3cP/KJmM7U+BG06OC3CtOiuKcvg2+wfPpc8Fhfsb5cyErDO8u8DeAMeN41/ScewnnAM
 +xB2g9Kn9qwPxmxTGDChfzQ4Bjq3okQBGibtck5yTSqpGx6T3k2r6stZbDoogA+A1jQYCSixDPF
 oJgw7thRg19B6a0dFWQ==
X-Proofpoint-ORIG-GUID: JhHds-Stt3hUpjcHBk7IpUZWba9zYLJX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_04,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070162
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12075-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qualcomm.com:dkim];
	FORGED_SENDER(0.00)[komal.bajaj@oss.qualcomm.com,dmaengine@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_RECIPIENTS(0.00)[m:konrad.dybcio@oss.qualcomm.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:krzk@kernel.org,m:djakov@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:linux-arm-msm@vger.kernel.org,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pm@vger.kernel.org,m:apateriy@qti.qualcomm.com,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[komal.bajaj@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6A71971DE8C

On 7/2/2026 4:25 PM, Konrad Dybcio wrote:
> On 7/2/26 11:50 AM, Komal Bajaj wrote:
>> Add gpio-reserved-ranges property to the tlmm node for all three
>> Shikra EVK variants (CQM, CQS, IQS) to mark GPIOs used by the
>> SoC internally and not available for general use.
> These are generally added to prevent non-secure access upon TLMM
> probe, i.e. the board won't boot if some of them are not protected.
>
> I assume the proposed set contains both ones that are _absolutely
> forbidden_ for Linux to touch, but also ones that are dedicated to
> some specific purpose that Linux _shouldn't_ touch.

Yes, some GPIOs are reserved for secure-world use and are therefore not 
accessible from the non-secure world.
I will update the commit message accordingly.

>
> Please add comments, like in glymur-crd.dtsi:
>
>          gpio-reserved-ranges = <4 4>, /* EC TZ Secure I3C */
>                                 <10 2>, /* OOB UART */
>                                 <44 4>; /* Security SPI (TPM) */
>
> explaining what these pins are.

Sure, will add this info.

Thanks
Komal

>
> If any of them are boot-critical, squash this into the introductory
> change
>
> Konrad


