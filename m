Return-Path: <dmaengine+bounces-10123-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNjgNf8i72lV7gAAu9opvQ
	(envelope-from <dmaengine+bounces-10123-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2026 10:49:03 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8060346F612
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2026 10:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 790A43015887
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2026 08:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6E33A0B1D;
	Mon, 27 Apr 2026 08:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="olxaidGi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Th27HDD0"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C3E39A7F9
	for <dmaengine@vger.kernel.org>; Mon, 27 Apr 2026 08:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777279693; cv=none; b=STAqy+H1+BV89YcUkqXhk0+ZMfsRUdGYdj6pVDMSO3x+YA10rYrCj+5yT5JHco2gK5qgOHr6VSaq9XRFvvxN62NhdQjeLJxUxG+mD5i2ckQQR4t589lEI7pR+GVpyxGS8K4PGJMBD9zjq5Hvr7pcLlss6yfYHF6EF8Cxt9NsxpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777279693; c=relaxed/simple;
	bh=D3vD2kVlYGXS1I5T4J9SraaRD97GJBtR1DS4oNt52qg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Emf/SKpLt/x48jycDTbVnR/kjQD8W5lZEH3yaPTiY2ZKiLhnSA1J6V2Tw4XmrUjBIeQ0D1rUi+6IvMlm9Twc9bf9dMvsgVnDiDyFg40B2MtYV6P0oJMwWbZuCVw80R7PaGgkngOBjN0JoWcCSoRIFOfM7WwvHzUYziDJr2bWACs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=olxaidGi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Th27HDD0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63R8TCac4054507
	for <dmaengine@vger.kernel.org>; Mon, 27 Apr 2026 08:48:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ui/p8UniljFrVfKElakgGeiO2AnZtZXK9CfVIOCmzz4=; b=olxaidGiIzavpjiD
	dMFTZZe0WqHE5PiGpP5459XPD1OaqHVZJGwHbeMMWetVBum2Z98k5ABvLPhXi9FG
	o7edD4Lzq997AvdTaOH/THoL9NWSCqk/t1tzYNuNkdIE81CG3sUIjoCGbwg4aRHa
	zcf9I47J+D9UhWEpNdbLmQ/4EHLcaLzJk6AaJ2bsJ15JRBGHQZE0QlUugRTSlsp/
	b95FA36/dMCSbdoPaDl2cY6VK3nOdOJ5dY/9hKExcewAr+VtdD+rG5OqjygGLYDu
	XOqsXsq6VSmKDq60Zc+b5ZrGG+G5RELKj4XMxKdPTba2v4vy2AkgIvrr+BDhk5F5
	D2bOxA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4drnkxd8ue-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 27 Apr 2026 08:48:11 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-35d9278587bso11992322a91.2
        for <dmaengine@vger.kernel.org>; Mon, 27 Apr 2026 01:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777279690; x=1777884490; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ui/p8UniljFrVfKElakgGeiO2AnZtZXK9CfVIOCmzz4=;
        b=Th27HDD0dRXr3tBld32vUxLwHVu5NN9hocXfvWagm9jIDxpzwu6D4VXhkW/Lzokkp0
         ebET3h+MzAcutf8ieuKdDcOTiLCTR4roSY1BdETsX60vtjNx7twKDjnfuG1HnAzyKtF0
         Ard7TeOQL8ewmOEoDysSuRlRD7iF2bgZbYCP/Sn+tY8vjJqLqE68CRsHo8PHK/mSESAW
         y0T/72pBFGijmViGpnwVGxae3ZqadKeA7/ThJncYCXDRhwPgVT55aA/1cryxsmXsvM+W
         ZgwLW9mVKG/GRj/njqw1lOXKVs46DFnY3+mGa0rneoDhDt3OA0OnEwgSyGkY/83yoUZl
         gO0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777279690; x=1777884490;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ui/p8UniljFrVfKElakgGeiO2AnZtZXK9CfVIOCmzz4=;
        b=QHvYWe3sJv05Z9LKsu0pvEiy4bwXondrHBO87Wg2I5cnULf5CLaMXlmv1H/6+r+JBE
         PxcYC4QyueRVCovhR2wJDmrUgtnrX/x1SyVZJrsGkiIhR0j074KJLY7v2pjlgP46cAhg
         n32feGFxv6Ggn+db+hrrW8kJjpnws//2fHcGP833hEYLDq86S4EGCdJWR7CorrllKWHj
         wNnabql5k7moGFwdOITvkL/Rs1zvoxwQDUav5mjytjAc8YR/vEfOaFU/7meg2MbJIOLk
         1VzBWAY0RzAt7IBfQjCHV8ncaLcSBI7LgnDl4PgRI0/81pEfeEkb+a8GbTUjW21OUsPa
         DLyw==
X-Forwarded-Encrypted: i=1; AFNElJ/cCf2tdceY4W1pCsgxlkBp53Pb4HdjG9FvqCFNvR+cVJsBHedDNjkI6fismTbHbEVdZbyT0CWrno8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAyes0WkUr2d3YVr6Xl6hnx3p9Hrur4FNMwkkKx9MxSUKnn42k
	SuGFEPOKbb/BzK2F6DPHKmMD55i7CHkXehnoFslWBVsCkFmluXnAvgLzfjWTPBoNQ0KC3OwQ/6o
	r2WBwunew9VLGC59ioitIv52ExaAqKXxSnz8rSIFPsQQ1dLjIbxA/N6jD2PkExy0=
X-Gm-Gg: AeBDievxiLtL6A/BUjmXfFOVtVBSDPR2g9mP345WGxqK8fkR0EuZ7R4/H3V2ZYToicK
	eWijVj5VW1BFA2SPzHwJ7ohrC9gzjA73DAfHEdIEFFbjOSKG0JZ5wxgvSNRw1F1PUcoMFRLgwWs
	Vv2qibALtSenWgKTXmKODZuY5gS+AWpIakD1Bfd3xLwrCh10ClqbEV4gENTi+AezYK9deaiaxOc
	u9X0jFq3A88M/zU/Vno69rwoPXSLKr00ow5I6QMEbNbyOIZO5FPYQxvuPF2JFAmbVkbePWme6aX
	52D10eZqvv38Kc4q0Se9YYw/8oubJoHfjNTD/JNlX0iH1q4LwOvmM7CKS56RcTXdWC5frYssCY2
	vJgLY51SJh7kJOkj2lS69+v7PzqggtFuRTM9DVr/5n6YNCi3fpY8i4UaYNPR4i98=
X-Received: by 2002:a17:90b:394e:b0:359:d54:846f with SMTP id 98e67ed59e1d1-361403f10f9mr41482669a91.7.1777279690295;
        Mon, 27 Apr 2026 01:48:10 -0700 (PDT)
X-Received: by 2002:a17:90b:394e:b0:359:d54:846f with SMTP id 98e67ed59e1d1-361403f10f9mr41482639a91.7.1777279689802;
        Mon, 27 Apr 2026 01:48:09 -0700 (PDT)
Received: from [10.217.222.83] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36140fc593bsm38732895a91.1.2026.04.27.01.48.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 01:48:09 -0700 (PDT)
Message-ID: <60f06bc0-16fd-4629-90d5-60021fb40d59@oss.qualcomm.com>
Date: Mon, 27 Apr 2026 14:18:03 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: dma: qcom: bam-dma: Add support for
 kaanapali BAM v2.0.0
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Harshal Dev <harshal.dev@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260424-knp_qce-v1-0-813e18f8f355@oss.qualcomm.com>
 <20260424-knp_qce-v1-1-813e18f8f355@oss.qualcomm.com>
 <20260425-handsome-papaya-porcupine-d42df7@quoll>
 <19600dfe-00e7-49be-9879-95cf662e1604@kernel.org>
Content-Language: en-US
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
In-Reply-To: <19600dfe-00e7-49be-9879-95cf662e1604@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: _CwrwgrAi_HLlxpreiJIjjZ5N6t542v9
X-Proofpoint-ORIG-GUID: _CwrwgrAi_HLlxpreiJIjjZ5N6t542v9
X-Authority-Analysis: v=2.4 cv=TuPWQjXh c=1 sm=1 tr=0 ts=69ef22cb cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=aNQcmT1Oi1EDLeyP3UsA:9 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDA5MiBTYWx0ZWRfX07+m8MiyZqYh
 r6+I4ogLcKv3EQnj5GfX03pnkN+wZEmRPoMTSKCY6+5Bdn6VU6HxfYY9Fr2vPOScbWwknbmOp3j
 0X1fHYywnBwCyXVZi8jgHP3Oxd6lyy8U9NAbuPBITkXWLPP6PkpS8pwPqrq4ionX3ijDTrN5bF2
 6DqCrQt54sX+tFxl48lfKB1AWTVnwzXbihGwK3PrEpRoVBwvZ6IySEAwwceo8mcy2ihNcQagB2o
 9zxmNahq0frg7GVT2djGQC59lG4jNtjfdzjzub+dfKeLc0YiOlzp/Th+tT4TJhRBq/Fb98xFtWw
 /V8OtlCVGiPJbMGbUicQGfqre6Y7FnOlxWk4mMmeIdfa5dUUsUf4y/SG2OoDNbT1DE1jGbB+UVc
 DTSt49xMTdlMGlYAQBrQysgFtKV2cpOvDMm5r5sgAnGIrs0DzYkpa0sCmcOI46f9n+9iBEk9Q5K
 npfU5TD6RQBFjqPKO3g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 impostorscore=0 clxscore=1015 suspectscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270092
X-Rspamd-Queue-Id: 8060346F612
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-10123-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuldeep.singh@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

On 25-04-2026 15:54, Krzysztof Kozlowski wrote:
> On 25/04/2026 12:23, Krzysztof Kozlowski wrote:
>> On Fri, Apr 24, 2026 at 05:04:15PM +0530, Kuldeep Singh wrote:
>>> Kaanapali support newer BAM v2.0.0 version.
>>> Document the compatible string and update example along with it.
>>
>> And why v2.0.0 is not compatible with v1.7.0? Or what is not compatible?
>>
>>>
> 
> 
> Ah, and drop redundant "support for". Write concise subjects and binding
> cannot "support" something.
Sure, will reword and keep something simple like below.
"Document compatible string for bam v2.0.0 version found on kaanapali."

-- 
Regards
Kuldeep


