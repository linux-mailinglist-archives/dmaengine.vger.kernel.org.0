Return-Path: <dmaengine+bounces-12553-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 70ClIIGPV2o2XAAAu9opvQ
	(envelope-from <dmaengine+bounces-12553-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jul 2026 15:47:45 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B34675EEAA
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jul 2026 15:47:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=aY+PmiaR;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=K4E4R846;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12553-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-12553-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77A773045A8D
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jul 2026 13:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A7E2E88A4;
	Wed, 15 Jul 2026 13:41:16 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656A32EEE8C
	for <dmaengine@vger.kernel.org>; Wed, 15 Jul 2026 13:41:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784122876; cv=none; b=ObexEwOJPKz2k8lXicYb6i/xhiLjO0RJP0LLvkfxNuNJKNZCG6rI9vwyMiPYCS88nN6c5jSFjp1ekgowMOuF8zRNEH3xlxqf6Fnl+sVd+4FzWggyUyzIekg5dBpUXV7l7WmIv1XwD6MWpYEWvwMfFLZSbP7Dtd+9LUTtd5zQ2RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784122876; c=relaxed/simple;
	bh=pz2SYwnFXEo45x3poxgyvBRBbqKCYUxUb17sAp4CMLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j8Bd3y9OJdE1C2tXjz4bkfOvEyFW+3sTdftK7aYCDImB2Pj9tvgEkEMj7HnY0jHZD0LKjk4UKaer6MJnH6Q1IKAC/yTK+c3EZD6Rz80DQ5fq5hTNBdbW6QRfrlkQvo3dTUkRW2jLd68iNGb3XWif/BxXOaKUUllXQzout92TCUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aY+PmiaR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=K4E4R846; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66FBdrwZ3601156
	for <dmaengine@vger.kernel.org>; Wed, 15 Jul 2026 13:41:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pz2SYwnFXEo45x3poxgyvBRBbqKCYUxUb17sAp4CMLU=; b=aY+PmiaRg48/HlSe
	vRnBgSuzHMhSstyNa8a/9mrzriUVMu+7ckJvNBKVeZMoppt64ss9KhWTesJPe9Ur
	Qrkm1F580Zqe5AHf47PbGDjrAr16DJC3M0uTSSw8wpjCr5uteZemAYFTOyMvxZK9
	1f4C8zsyQx7i+mV8GVwBmI/dBYnvO9laS7zMMng9v+LF+hgtLhexOP8EVkfBj5bC
	KmVbqQnVyciR1ACCgYhd2K2U5T75ZgrNDY0zbgudulXPhDjWsv/1urnOCRoCzGNS
	FwIhohpIrcDI2qLby7C3O4pUOf+OMdW2htV2w+WQwqkDgFWSoZL+MLEicfNPK2l/
	nS4llg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fe7q60whf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Wed, 15 Jul 2026 13:41:14 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8ef18406878so96993966d6.2
        for <dmaengine@vger.kernel.org>; Wed, 15 Jul 2026 06:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784122874; x=1784727674; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pz2SYwnFXEo45x3poxgyvBRBbqKCYUxUb17sAp4CMLU=;
        b=K4E4R846Uhr0Plywh1igSz6qVhwy4vJ49lI+C1kLgyQNpZUbLh+dsLhE47jFHiJw3v
         DNrEO220byKyiJOxBFXqpjNFzLhuYtqnsLFnl0ks4FoNhlFaQ/WjVBY7z3yRZiB3xxac
         6c0a8/59uUkPlnCPMYZDDUrTmTDZp7cAfB6XQuGVF9scv7ulPuEszJykjPJDwz4xGzyv
         kUMyPBo7pkqpZr1oo24DaihnUdfaEc63bjaryE8McOLYkgNBn4s7E9euHnaIKWNIYOJR
         6Vah++oRTnn73SlVAGyVpP3mFdUSdNPzuiJ0PZgs9p3NubK+ldSoP3AO8Q/eROfpEEb3
         DqtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784122874; x=1784727674;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pz2SYwnFXEo45x3poxgyvBRBbqKCYUxUb17sAp4CMLU=;
        b=fKW9MfV1iQBpTMhBdznm2wzv8CPQXx7/mbH5NbQWjkhMbcvw6tefIm5k1NsEbROnXT
         HqHO+XNaVKUN7XgxWplY0wT1lu4IWhR43JJYnAJn1gIPaSlfTZD05/AbktT2mUu8KTFH
         hmCsZGXTghiaF8r8dkrODMDG6VVjKxwtzh2/AHhmeAapMoppJdVGIsTbN7Kos+RhEopN
         i/6bDxKSgScfvkRSqsAo/DzppBedbjA6lE3OQZ3ap+wrdtRpK5+kLtYMfCmPQK9oMO1Z
         rr7iho/DAwnZQJUDv9VQAbWizEJOcoZPbFhxl5WF4EBhH/elNcMBigMgmtl6rOzRDO9p
         CDFQ==
X-Forwarded-Encrypted: i=1; AHgh+RoDLCDa9XxXkrVyPIk8XXt9ZJw983l4sorsc5iY9tgwZd3ebPdRv++nspr4kGtt8ZdenzFQbOBiqcY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWLDJVz6/nq/55c9s0XL9P5BeFxef8PmhQGGtg3vslUEOxw17q
	zkWiKNx1/U5Nm8VaYdzXAkR0jloQOmQc6XoXvDNOc/dLuSxCMUWHNxwApui1oroInOP6f/de7jV
	VF10TyTPfm3qHIZ+32Raw6K7kvByEpOWu89RnzKzNPBT79VnF6sFAqHqvquJxZVY=
X-Gm-Gg: AfdE7ck0unamijaVr9o/1SPxZ7kBZ1Xtc8z6XVUU0zuE6sDXypBN0vmI3Dg9/b0xkh4
	EcQ7oCb6n6/0U+P2UIBiuqtpaU91vMDkXMPlrlwydg99sNfuSdqIxzjOar13fW6iEXqY9YtvMN5
	K3tWtye8WgMHuVhaGANs5AgAOc7yxx4yEp8qkBJ9nxhoxBri2XqgGRQQ07kUKAuMoBwjX1tGDVh
	GxtelYuzPUkG/J/Tzv5YZK6rBVr/kQXrRGwxSPQ6CvZ7nI9vcIPUSh/H0xq7Xs2lRet249441Bi
	9uBsCVWCQo5Ph0bsDJhF3sdrg6FI62mrpG8VZLvUfRtrX9VWBhCAhDmRiIzZJrMp/3qgZ+brjN4
	Q5ACAF6E5s9XP32kQFXxHXB8W6QuU5QFTLrnuMg==
X-Received: by 2002:a05:6214:488f:b0:902:be55:9f2 with SMTP id 6a1803df08f44-9074c826a7emr78194966d6.32.1784122873624;
        Wed, 15 Jul 2026 06:41:13 -0700 (PDT)
X-Received: by 2002:a05:6214:488f:b0:902:be55:9f2 with SMTP id 6a1803df08f44-9074c826a7emr78194556d6.32.1784122873043;
        Wed, 15 Jul 2026 06:41:13 -0700 (PDT)
Received: from [10.218.18.44] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd87c9500sm193023346d6.46.2026.07.15.06.41.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2026 06:41:12 -0700 (PDT)
Message-ID: <4f641f13-a278-4465-8033-670c7279a7e3@oss.qualcomm.com>
Date: Wed, 15 Jul 2026 19:11:01 +0530
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
 <97b205e8-5ab7-4205-b1dc-cbcb0497987d@oss.qualcomm.com>
 <986da1da-db2e-4d4a-b9d0-70482adaf4bd@oss.qualcomm.com>
Content-Language: en-US
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
In-Reply-To: <986da1da-db2e-4d4a-b9d0-70482adaf4bd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDEzNiBTYWx0ZWRfXzbw7B6V8PMOf
 pkG8QmT919RR7pJ6n9DKDatYJFTmWJydrq41ShKPJCtJPlizZMEYWU1IdjbJzkiNPRySgV88d+C
 PSY4gr5riDxSJpl1rAkhbUvh24qorh0=
X-Proofpoint-ORIG-GUID: r6Dem0NkJULKZg7y048iMMxcjSe5lysT
X-Proofpoint-GUID: r6Dem0NkJULKZg7y048iMMxcjSe5lysT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDEzNiBTYWx0ZWRfX8bwdOjXpQfXd
 U9tv0dlrsWsqHGo4WN9vkzYLTRBcskqAPTf+uBmWnoauNiI9WogKeHwNQdAq/lH8QASrjYKiaLI
 Tn50czCH1njQN7iB4Bqiy6XYmeiAWeytbYB75X90qv8KyFUOGpX/NsBmhdRi2vurcKGqIBv7D55
 rP1/O9Rc0dJSVsssd2+8piQO246Oc6jBkTHRvUeAVRPhsmYGQunNsPTvD8mzH0VRkpaWURgsztY
 FqaPK/pgWy+x5DcX+0IoOVX49DEsS1dEVYPs17ngsbNMP+ei+Qa3ikhW9695j1dHVMNGmpybo36
 Tett82/L4gRrNfjopT2GfH2uU2W7PhhM4v04dAt8kEmVON4OnWQDbGUoXUtUTCdVqzZFRSbJU89
 v+FsvAHWk4k0GB0Dzp6VlY1K/e4OtNl9LHTmnXYEZq57m1GHrIwwnso+Vh9C/I/Wfo26/PYEZyH
 TfsKQE7+krX6jdypDew==
X-Authority-Analysis: v=2.4 cv=BajoFLt2 c=1 sm=1 tr=0 ts=6a578dfa cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=29Tt0ABisfwxuJ5Aca0A:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 impostorscore=0 adultscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607150136
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12553-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	FORGED_SENDER(0.00)[komal.bajaj@oss.qualcomm.com,dmaengine@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_RECIPIENTS(0.00)[m:konrad.dybcio@oss.qualcomm.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:krzk@kernel.org,m:djakov@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:linux-arm-msm@vger.kernel.org,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pm@vger.kernel.org,m:apateriy@qti.qualcomm.com,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: 1B34675EEAA
X-Rspamd-Action: no action




On 7/15/2026 3:57 PM, Konrad Dybcio wrote:
> On 7/7/26 6:36 PM, Komal Bajaj wrote:
>> On 7/2/2026 4:25 PM, Konrad Dybcio wrote:
>>> On 7/2/26 11:50 AM, Komal Bajaj wrote:
>>>> Add gpio-reserved-ranges property to the tlmm node for all three
>>>> Shikra EVK variants (CQM, CQS, IQS) to mark GPIOs used by the
>>>> SoC internally and not available for general use.
>>> These are generally added to prevent non-secure access upon TLMM
>>> probe, i.e. the board won't boot if some of them are not protected.
>>>
>>> I assume the proposed set contains both ones that are _absolutely
>>> forbidden_ for Linux to touch, but also ones that are dedicated to
>>> some specific purpose that Linux _shouldn't_ touch.
>> Yes, some GPIOs are reserved for secure-world use and are therefore not accessible from the non-secure world.
>> I will update the commit message accordingly.
> I'm not sure how to read your response. In other words - is this
> patch boot-critical?

Yes, with Access Policy enabled, it becomes boot-critical.

Thanks
Komal

