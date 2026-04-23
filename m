Return-Path: <dmaengine+bounces-10086-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKfFI2i+6WkXjQIAu9opvQ
	(envelope-from <dmaengine+bounces-10086-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 23 Apr 2026 08:38:32 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E9144DA5C
	for <lists+dmaengine@lfdr.de>; Thu, 23 Apr 2026 08:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D82A4300DA6E
	for <lists+dmaengine@lfdr.de>; Thu, 23 Apr 2026 06:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA713264FE;
	Thu, 23 Apr 2026 06:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="elGp1avN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Qr5B5uc1"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C09838422E
	for <dmaengine@vger.kernel.org>; Thu, 23 Apr 2026 06:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776926309; cv=none; b=RG6/Z/oSsrcGZwgksvD39XlAEzf6qBwsvq3uZFfjPA8BfLY0Aqs8E5gXpQjK2/1RZJesqucrRyNGKAk6ndpOxpxElCdzsOb4iLej7p1Mz9V8S7SPXzil8rczopEXxLFuRioTc7DZvRN39I3bX0W7tVfCCq7Vs4hIEeCGrdn+EAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776926309; c=relaxed/simple;
	bh=f9bB+QCzyO4SPrZm1hCl+G5k5J3z0zeRKWEBzruI15s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bIndg9TCH+54rpt6Q9talQaW3WOUtZ/jsng2j06+d5K2rgZsifg13JK4xkt7PGjfACfhxbuwrZdFRX9SpwC83V04zLzX2E9QsaPVp1mx5/ct1OQoJv0l7I92NJ6p61rCZ2WRf7XBeslOKAguNZdPglSZRpnSsEV7etzn8oAnZlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=elGp1avN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Qr5B5uc1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63N3VO91872662
	for <dmaengine@vger.kernel.org>; Thu, 23 Apr 2026 06:38:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rLGgXgdKNsiXpJ40Bw+Wx6qYrT09N0IAHqV9io35Jzo=; b=elGp1avNJTiNsW3s
	3fcfgJO9t4TwXaPXAcwz558CRkOUbF/p6+V05UE6/QrmEuqXddNB/jWCO0EwIODE
	uwZhWC4tfw9xRWWKbpGgKYarqfvR0n28STK6KdojyEQ4wtyA4+cZgpI6Zi/WYSN2
	U/msFi/Wy0ylYfI+okkTpun5qvbxP/8GC52BcwuLScthnD46oFUYIvVqBncHXIXq
	b4u6o+9zPmW9M2GeLVArhO91Hk4h5quqHGlQ3wTa0p/FDvM4llSqsewZLSDAKC1b
	J/D1ZY5k6c0LBzgMLzOswQl8A/B1fBUZ4F/nkazazWZu8lhGgxa9W6N9L5AGudnc
	r0toOA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dq1jh2hsh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Thu, 23 Apr 2026 06:38:27 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-35449510446so6937656a91.0
        for <dmaengine@vger.kernel.org>; Wed, 22 Apr 2026 23:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776926307; x=1777531107; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rLGgXgdKNsiXpJ40Bw+Wx6qYrT09N0IAHqV9io35Jzo=;
        b=Qr5B5uc1U1BNhzRQhbGjkaFzBy1qOLiwYaeceriH6dLXB3LTTsKZ2/Jmq06yKS5w1l
         RzZWJJppTyBBHSBzB1BURqtKlyOJbqUbudS+Yd68YOs8GXtuEcZhjfLxOZRztdj9uugz
         1RtXx0Ud27KLSBVdytpoCvzyKwqLe6K05lKCR7CDtY6d/O0huZp5w4C+hev7u4DynD6S
         /LdbHRvmBWBtdtwI29AKxbENl60r5mQU0YpLt4DWeP16srcyXS1xfXDermYYn0udV/fY
         yKgQp6Ux9S86pZYX5NMV2BJaZqXbQz54b4caBxcb+z5mM2kCFShtQAAj626M8D70dNT0
         +5oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776926307; x=1777531107;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rLGgXgdKNsiXpJ40Bw+Wx6qYrT09N0IAHqV9io35Jzo=;
        b=aFLHUUJsqiesnUfJZzRtbUT1IxpclMnG77Rhfm387wQmOKi/LHa0eYC1+DMZi7VkfQ
         3HpMc9lGF7+/4CPYcqqNLrT9nKqtpSqwcoI56mopL8iW0yfTIRWmDnX3XuqXlBN8nZ2k
         g0EJOksWqGOB8ZuGLv2l32va1TTSPs67Jfp2SGcYydYzXnp7QnT1jpqdJJxi0C+g86nr
         JcexksABNRRf5SkLzYtBQqghIoMjknddh0QyxXtd4TL9dWcqbg1xyklCC3Y5s6mDAgK5
         K4zcy1y8Uy34EcOBbKdeMBQfU4yk7Y3IPYpjXMCq6TIoRHYXEUrZBY+r7IuBvLnnGMH1
         3rnQ==
X-Forwarded-Encrypted: i=1; AFNElJ92kJR0CFEWjez0PAicdaFwOXBJDmWdpKmTOOnxMLpkb5vb+CyaNQmnzC2IBDBHzbw21R1l/noIwvo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/zj1GX/c4hFDAb4KtosB6fe+A9FWlDTbqIWuH99lMAf5G4IFf
	xld9DhILqmkeZG/BGp4YR4PBMRy38ljVBcYiDlmZemts8ntbWvvwUbdcdJKpc6vN/PGi2lIOXHf
	9mBAEkwJD7Tljarf9fifGNE1JPGShk1nk2X17vzpopDNVvmc9rg/njgKXBckwBBQ=
X-Gm-Gg: AeBDiesvWdnsMIarPR+yiOAMTXQHbnDVR4RDJXvPARnnQlG8UMoq+V4Wl5NlzfDdrMK
	or5+ZZtAWhwyvgkC6KR5u37hUJuAgfdnp0QDU90RfSIepmvlP97cTe3uSYp2NUEzSD0kvzu2xUJ
	mXOtUjQQwnE0jDcZi+UFJlrAEkN1+I+Bs+4lvYSsHiHd29kKZHnejEHFCGM4sPrc+V8yaDzUOcj
	02gxiDhUOiPWXO+mp98AvI6pe5sxxRRLOXAeER2C3t6t6MZeLFRH8owgUx8smMYqELIJHL9FlVf
	+f+In20Lt0Bv8HXl72enUx1bv38DaPyphkUJjWRP6LJY715b+rx1iWLnkW9X2hV3MhS9/4K38QQ
	GnA89TofVPR1gvmksdcWPTMNkY4uE1aMVTWn89K8lXJMiLjTuHnfV8QlKYFKJI3BR7tg=
X-Received: by 2002:a05:6a20:258c:b0:3a2:f75f:73ef with SMTP id adf61e73a8af0-3a2f75f7de6mr9430743637.37.1776926306593;
        Wed, 22 Apr 2026 23:38:26 -0700 (PDT)
X-Received: by 2002:a05:6a20:258c:b0:3a2:f75f:73ef with SMTP id adf61e73a8af0-3a2f75f7de6mr9430713637.37.1776926306134;
        Wed, 22 Apr 2026 23:38:26 -0700 (PDT)
Received: from [10.217.219.207] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7976f0811fsm14309121a12.0.2026.04.22.23.38.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 23:38:25 -0700 (PDT)
Message-ID: <8b2c1131-c05e-4c6d-bb80-55b812b0d132@oss.qualcomm.com>
Date: Thu, 23 Apr 2026 12:08:18 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/4] soc: qcom: geni-se: Keep pinctrl active for
 multi-owner controllers
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        viken.dadhaniya@oss.qualcomm.com, andi.shyti@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        vkoul@kernel.org, Frank.Li@kernel.org, andersson@kernel.org,
        konradybcio@kernel.org, dmitry.baryshkov@oss.qualcomm.com,
        linmq006@gmail.com, quic_jseerapu@quicinc.com, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
Cc: krzysztof.kozlowski@oss.qualcomm.com, bartosz.golaszewski@oss.qualcomm.com,
        bjorn.andersson@oss.qualcomm.com
References: <20260331114742.2896317-1-mukesh.savaliya@oss.qualcomm.com>
 <20260331114742.2896317-4-mukesh.savaliya@oss.qualcomm.com>
 <ce5eb817-ce13-49c3-81f8-8e28c40632a1@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <ce5eb817-ce13-49c3-81f8-8e28c40632a1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDA2MCBTYWx0ZWRfXzlhwGlNOT7Yz
 3UA0v2UoTA7dyrZZWn0If0P4epg8a0enDJ/JO8e0FGHe/xGvwYdNPuWJ98cxGAS7XLIUI6QFwKs
 LrNYGfnrm0okwzTojBtz5CIo9IYeirNXV4gZE8xh9AphX/PuHN6yjrHLoNjEqg8Wkv5ys/uCskP
 VZuAEnUrFq6pUdFOV3YJJFVPF+9m0AUTViDw380ayxie9S2g9inOMx576D8o7FRWlz7ReUKgovV
 GVoz2Lz2o1tTJ8UNb/JLjtmQHNFk9PIoock4ajA9BhAFsWQbVyH7rseoZ6eOBJOWtHDlmfjTe8C
 Mq/m5zy/z6gV7H9otxgmwnUt3ywjDT0xC0okTnqlmDmPj7exo8k9ma9ETWnAvRZL/QHRCREN4Zn
 Z4u4NTMDoCxehEmJU8jFEe9UzcuDrfOCzw+g+OaBhk/6e3HJp97JDJxl8DpIWUZkYxLkfyeQ1c9
 R7nX3bYCoOgzL1VN/tw==
X-Authority-Analysis: v=2.4 cv=OeyoyBTY c=1 sm=1 tr=0 ts=69e9be63 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=NEtnsU5enKSBwt4-RL0A:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: 55-ss5Y6hL43eYPsN0xYA3aCeyAcsJt7
X-Proofpoint-ORIG-GUID: 55-ss5Y6hL43eYPsN0xYA3aCeyAcsJt7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604230060
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10086-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,gmail.com,quicinc.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mukesh.savaliya@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 03E9144DA5C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thanks Konrad for the review !

On 4/1/2026 3:49 PM, Konrad Dybcio wrote:
> On 3/31/26 1:47 PM, Mukesh Kumar Savaliya wrote:
>> On platforms where a GENI Serial Engine is shared with another system
>> processor, selecting the "sleep" pinctrl state can disrupt ongoing
>> transfers initiated by the other processor.
>>
>> Teach geni_se_resources_off() to skip selecting the pinctrl sleep state
>> when the Serial Engine is marked as shared, while still allowing the
>> rest of the resource shutdown sequence to proceed.
>>
>> This is required for multi-owner configurations (described via DeviceTree
>> with qcom,qup-multi-owner on the protocol controller node).
>>
>> Signed-off-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
>> ---
> 
> [...]
> 
>> + * @multi_owner:	True if SE is shared between multiprocessors.
> 
> 'between multiple owners'?
> 

yes, will update for next patch along with keeping below RB tag.

> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> Konrad
> 


