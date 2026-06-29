Return-Path: <dmaengine+bounces-11865-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Z9AhLcBdQmov5gkAu9opvQ
	(envelope-from <dmaengine+bounces-11865-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 13:57:52 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0E16D9B64
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 13:57:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=Q3ZyL3k2;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=Nj+NuXqD;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11865-lists+dmaengine=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="dmaengine+bounces-11865-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1033F301020A
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 11:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9D23BADB1;
	Mon, 29 Jun 2026 11:40:43 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA09436827E
	for <dmaengine@vger.kernel.org>; Mon, 29 Jun 2026 11:40:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782733243; cv=none; b=jGQ5XZmreuejfqb2TxR3jz9S2tqlB/gjs3tBYRJfdqICm+xNLBLTE+R69wHIG0sosJBSzqveLc4ox1x8lKplfXbwXIIKPesI8RCe4oIxRq997sUChFtgo4jn238W8o9LkOCI4fGjzo+0CRM0ZfV/o4jdV7doBAdDA241snc3mNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782733243; c=relaxed/simple;
	bh=pT2FbtXMab7KSZer+kiCDmrPcL5DRuMS5wo2LZH31j4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MHT9fLcz+UpxUl4X/2RgVqbPQ2JOQJIDVj/mtWkpHeoxMkGhdpdPKVMyUwMQg+ujBTV5WaVZAtfYV4zEuWRih7z6+S5Pkvo+iGxi1YdvoiXBwex9GxBFt/0qD/CZ/liWmI68SQsP1RtwSy20nWe+MxK1KK9pUfAeSiMiArzhYhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q3ZyL3k2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Nj+NuXqD; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65TATEd62579108
	for <dmaengine@vger.kernel.org>; Mon, 29 Jun 2026 11:40:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ez0q+tEhJVuFVHEx3WYt03klVltmnKN+zNXS/TELhgs=; b=Q3ZyL3k2iIBe/RCQ
	rdTzKslkbIY5291q+y4nabYuc331IKvHSvWTnI2N0XLS7jgOiQaXGRoDrzQW2ift
	0eLjCRMen4ks4rh/7/WzPwQhyepF8u43Mdg01XXrIitXhlSnFr6mSGc1/QoI74Bl
	/c/hpRY+8Wa57anjBvkMuVsiOvdThu8qJA9Gxd2qgHbPXznxSTDIwJkHcDjzmNZN
	vvt6Kow1M5f3F0alBTwOHU5r/tksyZdSV/j/ExhpK9AJjx5ZQD4n+lsGlvOQCtoG
	NesfgWWu3Kp1k8maoZl6Uxo7xzVnNVTOPrLx59hJzM1sMdf0gHmfHQGu3euPSevW
	4XlV7Q==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3kp7h4ey-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 29 Jun 2026 11:40:41 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92a9777b04dso91566085a.2
        for <dmaengine@vger.kernel.org>; Mon, 29 Jun 2026 04:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782733240; x=1783338040; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ez0q+tEhJVuFVHEx3WYt03klVltmnKN+zNXS/TELhgs=;
        b=Nj+NuXqDBErVLkuu5xmLffWOCu/26W++pQHw7DCkJS6ogB6w3+MPlt8yEHHTqipcia
         aJ2KUWI27a0CzHL2Q0b0SQIeAbtmppgHHBv7xlBhlz9issGhYIv1a8WJ+AZSMqsXmQ7N
         tqGFnOhn7PrczXFJv6rnrLNnpKo1OKJZYQ0dW6i804clGG2d2D2zsur0hcI4tOhsQdD/
         CPwntXfeusDrNZ+LlBswD/VNp7U0KAyaeofSKynrGL0mnfRgd7xJ5LsU86W6V5Z75yrQ
         bywvqiA+gyPddNFr6QZ/emwP7DaM68msL6wPMnfXfPtaxnDj5JuvAkt3VBp5O0BeyHyI
         LFGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782733240; x=1783338040;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ez0q+tEhJVuFVHEx3WYt03klVltmnKN+zNXS/TELhgs=;
        b=Z6RFrFO31JqwzW3c+Pqrg2laNd4+ZhSOKsEtu+mDUJ1NYObXwyyNR9DVjeSkqN0flr
         pOQJvZu7uF2uH7mYJcqf5Fsf+i298euSuQasPIaZ+JlxyVYAD4XUGToiTCny1PVo1NHT
         oRX+d6zHMcCHR9G/E/Q6NV/1XzaDRxBHJ76EvaRA0reXci4o3gqp/aBFi2+DpUe/b5pN
         5Pr/3TRftT4zmaSuC9qOS4fJQ4wFKDKMXyCE5VZW4SB8HvOmfsfG9FP8CV8q+qeVut5J
         0PsZTaFZYKubWAXY1acjdCfD0yn8tecaoYCCuCCZBo4aLp+t7u3Eu+mKBCxWuTS69Ek6
         S0Dg==
X-Forwarded-Encrypted: i=1; AFNElJ9E3naPQyNvVU0+vUOf0ottzGNDpcy4usH2Vqw35SOpau5iodsFNCLoVAKoD/xcg7oTt/pd//YgJB4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYiw9DoIjAgYebsljce+0qJB7lVJhbcsgBVIYG6VtMr+vRWM+n
	PEkYUPdc1SIwu/7Ie+IBs8GuSE7a96PVeFUYvTBIaVmtGn20OrudONkncR2IyZFabVxdABPKt4W
	zEnxIdVFVUkPNuJZh9HRP/np7qPnAFJUB9b/hFKbCO7EnfP1jpzPGsJesC57SD6c=
X-Gm-Gg: AfdE7ckGBXlhhgHy+YCcAaXniL87PKzJJLzCSk50IjgCV5dgdOVwNprbOTWvSnkhVyj
	mA0+sNt959h89SwNEHct878Abr0SHa3i1QHL3OpdpjHdAUjhlRzzYdw+kLfp98TX9D+++D/19RZ
	jDxLc6h5YKh5ksw752bNMrWnNvDpDyn/mUuggIxals7liHf7tL3iUIj2pDNKKM+911fEMEjC/0A
	q6iAY5WacKj8xarzM3WNfYg6WqEeg9LWl4h0Zq0Zv45SXUbh0ge4p+6h2yTr1kC+Dav67Uj5+Z0
	EPfvNN8yqON11rYj3gTaGZJIfZbc8qG9bUaIObERd3sFnnA6l52XgTtwksOPMiQ/IHNFRrVnBs1
	cnNgqMKX5JW3fZ8yfj817FSFY583HEU54yss=
X-Received: by 2002:a05:620a:2684:b0:90d:11b2:80f3 with SMTP id af79cd13be357-9293ccd5b89mr1538020385a.7.1782733240102;
        Mon, 29 Jun 2026 04:40:40 -0700 (PDT)
X-Received: by 2002:a05:620a:2684:b0:90d:11b2:80f3 with SMTP id af79cd13be357-9293ccd5b89mr1538016185a.7.1782733239589;
        Mon, 29 Jun 2026 04:40:39 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1271803f92sm88937566b.44.2026.06.29.04.40.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2026 04:40:38 -0700 (PDT)
Message-ID: <46005937-c1a9-409b-89cf-4b8f592dc5d1@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 13:40:35 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] arm64: dts: qcom: shikra: Add ICE, TRNG and QCE nodes
To: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Frank Li <Frank.Li@kernel.org>, Andy Gross <agross@kernel.org>,
        Harshal Dev <harshal.dev@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
References: <20260521-shikra_crypto_changse-v1-0-0154cc9cc0de@oss.qualcomm.com>
 <20260521-shikra_crypto_changse-v1-5-0154cc9cc0de@oss.qualcomm.com>
 <enovafjkiuzr4bciu6bu6hh7h56wvnaq5fh7f46m4h7browyrd@7huwa5egaqaq>
 <55039d7e-34df-4f89-8188-fcb45fdea538@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <55039d7e-34df-4f89-8188-fcb45fdea538@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA5NSBTYWx0ZWRfX/93OqVmTTbEV
 0vzhnxdiamOhidNKwwBCxk4s6h0g5ixS+Ix4x+/hSW5yDXrthCuPAj8kXr74ZG8spR1OFHZmxlc
 jHkPPMXYMrw42+fvbRvc9P0QejFrjbA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA5NSBTYWx0ZWRfX2cpE6OSpfE0t
 mgeKFalPaIYL2qzKULaTXBmVxC51W6+JvNxdiogXyj9m6dR2TNb2AJZF7w3hRL2Wki/Va0D3TdR
 tNd0GuifAJh9ff719GTVQw2pXUutkqyGXiTRx+h1NVVvUg/+LhY2VMjyq/mBl+dW1gQb3UBWxN+
 6ZS+L3Pl0lWgEzMzpe2ERpJaO1kQuzmzwMyAyfoYdz/O/+QPBWgzeSdxCh0fh0Tzb73J7jlR+bp
 McZa43sUIOk63mOqQzlq3NtzQBt4PFUAd1iLZNjYlqM20JKB3PfJy6oRuNj5KUGCFl7T4lTky9c
 /hpz4RIApmLL50O8HxSazJrcud3WwA62S5hXEJCEqeJksa37APLN4MxYH0oT9EMU6aYDqFPLx4h
 4IT9MsA2Ml2N3d3hCcpH88daSHUnlL+F8yTV3dQRC4aU8k6hMRqvQrdqOoOGN4RM1wi8Sjex6tz
 u0EkShAb6OqWyPSgkQQ==
X-Proofpoint-ORIG-GUID: BTeJLsl3WSn1BfCviLr7qHkRwBn43uW9
X-Authority-Analysis: v=2.4 cv=MZJcfZ/f c=1 sm=1 tr=0 ts=6a4259b9 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=ofJj2r9Jeah5rOUhSeYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: BTeJLsl3WSn1BfCviLr7qHkRwBn43uW9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290095
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-11865-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuldeep.singh@oss.qualcomm.com,m:dmitry.baryshkov@oss.qualcomm.com,m:konradybcio@kernel.org,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:vkoul@kernel.org,m:thara.gopinath@gmail.com,m:Frank.Li@kernel.org,m:agross@kernel.org,m:harshal.dev@oss.qualcomm.com,m:linux-arm-msm@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dmaengine@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,m:tharagopinath@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[konrad.dybcio@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FREEMAIL_CC(0.00)[gondor.apana.org.au,davemloft.net,kernel.org,gmail.com,oss.qualcomm.com,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,qualcomm.com:dkim,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AF0E16D9B64

On 6/8/26 12:09 PM, Kuldeep Singh wrote:
>>> +		cryptobam: dma-controller@1b04000 {
>>> +			compatible = "qcom,bam-v1.7.4", "qcom,bam-v1.7.0";
>>> +			reg = <0x0 0x01b04000 0x0 0x24000>;
>>> +			interrupts = <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH 0>;
>>> +			#dma-cells = <1>;
>>> +			iommus = <&apps_smmu 0x84 0x0011>,
>>> +				 <&apps_smmu 0x86 0x0011>,
>>> +				 <&apps_smmu 0x92 0x0>,
>>> +				 <&apps_smmu 0x94 0x0011>,
>>
>> 0x84 / 0x0011 is exactly the same as 0x94 / 0x0011. Likewise 0x96
>> duplicates 0x86. Drop the duplicate IOMMU specifiers or explain in the
>> commit message why they are required.
> 
> +Konrad too as there was same discussion in past too.
> 
> 0x84/0x94 and 0x86/0x96 pairs are actually different even though
> resulting sid is same.
> Let me explain more.
> 
> From sid sheet,
> Description	   SID (hex)	MASK	RESULT_SID	S1 CB
> CE descriptors     0x84, 0x85	0x11	0x0084		S1_CRYPTO_KERNEL
> (for data pipe 4/5)
> CE descriptors	   0x86, 0x87	0x11	0x0086		S1_CRYPTO_USER
> (for data pipe 6/7)
> CE data pipe 4/5   0x94, 0x95	0x11	0x84(same)	S1_CRYPTO_KERNEL
> CE data pipe 6/7   0x96, 0x97	0x11	0x86(same)	S1_CRYPTO_USER
> 
> Qualcomm BAM DMA engine driving QCE has 2 major components here:
> * Descriptor pipe (0x84/0x86): This carries BAM command descriptors i,e
> key, algorithm, length etc. which tell crypto engine what to do.
> * Data pipe (0x94/0x96): This carries the actual data payload — the
> plaintext/ciphertext buffers being read/written.
> 
> The descriptor(SID 0x84) basically contain IOVA address that points to
> the data buffer. That same IOVA address is then used by the data pipe
> (SID 0x94) to actually DMA the data.
> 
> Since, Crypto engine descriptor and crypto engine data are part of same
> crypto operation and with the limited number of context banks, smmu
> provides an optimization to logically group and resolve them to same
> context bank/page tables.
> 
> Pipe 4/5 contain 2 SID(0x84/0x94) for kernel and pipe 6/7 contain
> sid(0x86/0x96) for user. Pipe 4/5 doesn't touch pipe6/7 buffers so both
> are safe.

I understand they are different from the hardware perspective. Are they
different as far as the OS is concerned? Will we ever need to separate
their data flows? (I guess that would require iommu-maps anyway since
currently they are bound to the same domain anyway)

Alternatively, if you'd like to keep this level of description, it would
be good to describe the iommus:items: in dt-bindings, so that one can
make sense out of it

Konrad

