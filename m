Return-Path: <dmaengine+bounces-10524-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OpAMdANDGqJVAUAu9opvQ
	(envelope-from <dmaengine+bounces-10524-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 09:14:24 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26380578CA7
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 09:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BF1E3041A5E
	for <lists+dmaengine@lfdr.de>; Tue, 19 May 2026 07:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092713B47F1;
	Tue, 19 May 2026 07:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k8TnIJgz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KAueQnj/"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70CF3B3BE4
	for <dmaengine@vger.kernel.org>; Tue, 19 May 2026 07:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779174578; cv=none; b=XVcSPKa42UUmsfWDaMNBj8ZLd0SXLNRNefWIEnxcmb+aCU7fxplEmY4oRpZ/sbs0lxljNF6P1+EXiNzA5ayUgwVoMhmKWLc7+gW4zheZ+n2BF9UyD8akNyaRnpuiWP3X1lIZiZ1BdFEp/WuSGej/lJvyn04EXO2b/hvCxAXQBcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779174578; c=relaxed/simple;
	bh=HwXDOwJ/n8kwN5m65KMuiRC57ObOd4uZu5RS7F3aRHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WDRGz2IO9yccsCSODi+39ERJlbdiqsPRBwPBTYSP13pHLzACIYKs5SC7ZyxWLVSTjzxnN7/ZP1a9V7DvRnn75aHjawBCYuXS/RGazT4KkNHLJvECk21GMCumt3Hqz/+2Yi+M1/XC6uUiovULjokkm2vmOM3xZT/VOWDiAufzIy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k8TnIJgz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KAueQnj/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64J6gqpt1737169
	for <dmaengine@vger.kernel.org>; Tue, 19 May 2026 07:09:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	flpjn8w2XFi3HDGFXRZoiV0RXVmGTmh3woS4zlIQX2s=; b=k8TnIJgzFnzTAcNk
	Xznrj3F6dsjV/bSW5iDpbg8odUQ1Ym0tIJhj7zRmnUu8YclwkG506SS5Mv4S1e/d
	oOpn6g4mKRqAL4PQSa0k2Uu+B2Lb0CQK30evFwtOxxX12iFnz9c4V7vbosXDVTEo
	kWgnCIwPsmLT48erBtYQnli4qUhxsNQiy0tnQojDVBst2f6p4zoMnd4R0VDmWsCL
	W1R7QJWgDTEj1kzjOja1pA7c4CYtNCKJ6N1/sh/a98aX3wTNM+1eehcrvrzHJOig
	hvN0U8L9wQlO3sYbzOcy1y3vpFJIxwAExe/KvB4h6dJnDqppoYt59kTUNGSw4l+n
	IaK/cA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8ju903jg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Tue, 19 May 2026 07:09:36 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c802545ae0eso2006825a12.2
        for <dmaengine@vger.kernel.org>; Tue, 19 May 2026 00:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779174576; x=1779779376; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=flpjn8w2XFi3HDGFXRZoiV0RXVmGTmh3woS4zlIQX2s=;
        b=KAueQnj/Sk42xz+DEI30livgaBIsFHXbtVokiCm25E1hwRFUn7KDAQcvwcBxzCD5OQ
         o5WOihfokimBXC3uhkz+Go8Aa+wY+vDj8yd8HRwh8yuX07Q4xqvYGGA/GfQ1vBznlJv9
         wO4Dh/DXKgk6s4BsdjiqkOYRACaZnYv44QPRVcz/CB15Hq0VYiWrG802+E9txRrHrDyd
         0VmXl9e4cO/HxtNZ83KXlIVwfI20POZjOk4k9T9YeInHDVcQA82l2n/VTNPD1XcftrWd
         9NDc+aM+2zDJiMnvsBQykusZv0rZgR0Inpv/pWt07W9xYkpZiD+Yqn5i1ifKEsNN8TEv
         fpTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779174576; x=1779779376;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=flpjn8w2XFi3HDGFXRZoiV0RXVmGTmh3woS4zlIQX2s=;
        b=VCTyl0SUMp8SXrJvr0SMSCSRaSIq0FpVIBXv/zkKFfPQnKp3sJSmkunR08xDLtBxS/
         WClav+Zx2hqgYRK6YdydUmtckBI/yErBdvLa5XjNs79bFS/R4iffJs0F4A9QNHpG/A8a
         gM+yy/9Vi4CoiXWFUjHZIvSxu2OHV5bgOZEbN8aiN3WZ9KiDOzNtxqTp68xXPOeq1i2d
         EV/cfHoeHYsO54dsqBnSoVnM9bS68FPlO7/UKlZuB50kOjLDxXKKt+Q27QBvpVGjNaQH
         z4Ehpt/x/NmjreugfIjl+SuZB56LC7lIXXpnZogJDAnikAYIkgAVJU10IrE10O5i5hAc
         pkOA==
X-Forwarded-Encrypted: i=1; AFNElJ+tg/Ialcc8S3TnE1fk/EVXH+AgpnPbgXR/TDJGHs59tw4dQTEEc4CFhaQPO28OAG0iy9C9/o+Q3oU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ4xajXdT152fQYQV2LW+WvoU0fme1BClwSM+GQS/n5AAEnail
	9lOpPRwaBEAL7xFOyOYC1PtPYdNeREWjU/la5px5FlkAcunEXReobamSb18MWTAgHVTixDxaoYO
	Mut3allYhq48FLr44TG5YzL0irjz23RvTj2CWtmm/eai1o8hzWOrMMrKn6HXt/PDEzfCSfqs=
X-Gm-Gg: Acq92OG58vPZ5yhrQwEma9rRE1PfO/0QfLgC3VyXHq9rdBSrKSWTN05nfKEwp9B/4ZY
	UCzj4UJ77UNzdaLAJGFkKJpO7ugUxULmj9OFrqsDdrxfBShPm5+r0GuWbnvzDLCqR3kq0SPI9U3
	Xe6TYTRbMq6W6r774pOUnoTZ0P3xF52UdKINw/s3F51P847UEMy10hDNzubr80hA1qe0rLOM7bC
	FcmJ9fMjTlVkCRQZuzIEi4aeHP9G/3Tm8J/N+dWSg2i6fe5MK3blVkmpiem4LpW7SmcRv8coRst
	YyRAL8YXDAKwpsTe0+/fpr07nHpUfjbhwy4SMYn65AMQRdJur+hY8D7Apl1kaDta4cqY7DO2Dsh
	CtqfyOYbJzpRcVd+iBwpNxcUlL22g3fXUgqbQRVXaHTzyahURq0U1
X-Received: by 2002:a05:6a00:4fc8:b0:82f:48e:241c with SMTP id d2e1a72fcca58-83f33d8ba87mr18630223b3a.23.1779174575612;
        Tue, 19 May 2026 00:09:35 -0700 (PDT)
X-Received: by 2002:a05:6a00:4fc8:b0:82f:48e:241c with SMTP id d2e1a72fcca58-83f33d8ba87mr18630188b3a.23.1779174575082;
        Tue, 19 May 2026 00:09:35 -0700 (PDT)
Received: from [10.92.176.107] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19c7f202sm16288753b3a.43.2026.05.19.00.09.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 00:09:34 -0700 (PDT)
Message-ID: <f40798ef-e066-4814-a26c-729dcdb9f5b1@oss.qualcomm.com>
Date: Tue, 19 May 2026 12:39:27 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: crypto: qcom-qce: Document the Shikra
 crypto engine
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Frank Li <Frank.Li@kernel.org>, Andy Gross <agross@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
References: <20260515-shikra_qcrypto-v1-0-80f07b345c29@oss.qualcomm.com>
 <20260515-shikra_qcrypto-v1-1-80f07b345c29@oss.qualcomm.com>
 <181abfec-a6f9-49d3-9428-21a169a94246@kernel.org>
Content-Language: en-US
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
In-Reply-To: <181abfec-a6f9-49d3-9428-21a169a94246@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: A8bo7h9Fa2tVID8R6GSgA_Ox7W7CqpY9
X-Authority-Analysis: v=2.4 cv=eeUNubEH c=1 sm=1 tr=0 ts=6a0c0cb0 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=nVgdB394IWv0AcZ3mQQA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDA2OCBTYWx0ZWRfX1vnp+dM8Gjjn
 lTsg1Y1tO5SxT+4nfzP1rJw/veWVDY5QaZnMPc+TZfVuHcqLw5GLky2ezUyuRRKe6pEUof6k7BQ
 UZ75TdFXYXVtDuYjnbegJgDZ6cnxHAHVK0Ech8vnR0o8sYKIW2Pe80Bjit1zIcASjJafZGpV0ha
 aFW06FdwrJNh+kPZWIFF6nKrE6piAuf1N+4FYRc4VT8BqG6UFvmZzYlBRQrFSiIiL0ccqrk9Hft
 96+diFMQ6RXFSEk0+vhJsEZolu6pXyWZXaknCF4WCSGgtccuB+X2kw2EQTwE9oLKVgrqF7HoIPM
 0tWGa6r0VeWzoMy/FlF3os806qkVGR8hkAAypq4ihcc1HqrYGjAQIdocE6V3x7blxYfDPJQbXR1
 kvVrtjOSXF/OCbVJRkq6MuQaX3YCcCbN0HAX6SWCyNkTPlGRBC2Ci9QK5o20d3w4rxgbJQFLJcR
 6zJIJP7MQutpoRJF2+Q==
X-Proofpoint-ORIG-GUID: A8bo7h9Fa2tVID8R6GSgA_Ox7W7CqpY9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 adultscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 phishscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190068
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10524-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,gondor.apana.org.au,davemloft.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuldeep.singh@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 26380578CA7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 15-05-2026 16:30, Krzysztof Kozlowski wrote:
> On 14/05/2026 21:23, Kuldeep Singh wrote:
>> Document the crypto engine on the Shikra platform.
>>
>> Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
>> ---
> 
> Same comments as for IPQ, Nord. I gave the same feedback internally more
> than once.

If i understand you correctly, you are looking for more descriptive
commit message?

-- 
Regards
Kuldeep


