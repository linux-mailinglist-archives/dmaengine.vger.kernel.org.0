Return-Path: <dmaengine+bounces-9287-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4N3wI3veqWm4GgEAu9opvQ
	(envelope-from <dmaengine+bounces-9287-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 05 Mar 2026 20:50:19 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7AC217C71
	for <lists+dmaengine@lfdr.de>; Thu, 05 Mar 2026 20:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C38F53045033
	for <lists+dmaengine@lfdr.de>; Thu,  5 Mar 2026 19:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E3F3EBF00;
	Thu,  5 Mar 2026 19:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VmF13nSh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KK3n3+tn"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913A23EB810
	for <dmaengine@vger.kernel.org>; Thu,  5 Mar 2026 19:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772740179; cv=none; b=I97xwgCX6ew2u/HlgquxjJscqavpU5csVE974DBzboh1MLnWVXqZhQWipQQg9H5pqaCQqzpEf0cJa+t8GDDF44G9+GEdGM1WejIgECbes4V32QCFopMM8kxiDzyeDme9GiKNQrwhNe57FhexyK9guDYDu35wN8mJwZ6vTDufGsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772740179; c=relaxed/simple;
	bh=WPWPlT8nmCqIZAEuv9H/d5ylOJBqMsjr7ba7VrnF/wc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AMjMZRW0umumFG5RTn7xIjwmt4Q/TUcX70iVTDM+UPNS/W5PbMVZ3HTABKvuI+EPUIQHu28AmLtz2YgqoaSODtHKlL01TY1wfOMCDrHNEgLe4nZeMwvkYz4E4YUpiVE6MVw/Yeltc47ppMY1tbQMwYRZeBzVLK3kpOKZ0VPNwo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VmF13nSh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KK3n3+tn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 625INhuU1783563
	for <dmaengine@vger.kernel.org>; Thu, 5 Mar 2026 19:49:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	W+xZbg2UcQYU0NAtEL3ooNVs0zEnn8ejUS3RGwHRvhs=; b=VmF13nShpwR94pDQ
	zOtKvBgKFN0Du38CIX6ki/pV5RFPmMPQJzeJKpr8uaKevY3CTw6BEIe3HZpknY01
	jspR/kdToEP4lAk6CH7IjAcI5XoQ2d85YFUCOnhpJniFBGWqMMjTKmMTd8RcNLB8
	mGyK8USv/otuq/fKJjHn70n/FUhJXYBPT7PVmek1nSvzmjLLK+DShG0g+eYbRLCU
	DG5krug1C1Vy1P0VhjJzV8CiqKxVclA7IGHGjkn5+46H79pKd8plfbQls8YpGYCH
	Up0PlqdBnShiCvlqwyjYlllsWL424k3C7xeJmbQ83iAoOy6pUr/kw++qGm+F6kEd
	AgUz/A==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cq1pk37et-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Thu, 05 Mar 2026 19:49:36 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cb3ad1b81aso1013864585a.2
        for <dmaengine@vger.kernel.org>; Thu, 05 Mar 2026 11:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772740176; x=1773344976; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=W+xZbg2UcQYU0NAtEL3ooNVs0zEnn8ejUS3RGwHRvhs=;
        b=KK3n3+tn0e3ihjdVdh+pdnkRKNQiiyjnCwcJi1ZitXjI/O14g1YiSSd7W03eVEyzqa
         1A0RpJ9ViLzGcKJ6qBCEzm54TyNLDJ3AnDT+SSuI8DfVcuT1d/oZqOFX1/YCsPXUMHXf
         I46Xb6McX8t7AnPgabwOHIjMDa830k8UUEu+++c1XGtgxTSGNn5BGfM6fTWDyOxhn85x
         I0b2cb1+DuZSi7eST/NLGZ6ZSjTZ5InYK/sYhOdj2NyosZC+ZQPiG/BiCPWLrrLefaO9
         Q5maLrvQ1GvSZLwZEwZmKAlTA+Df+pQi90fgRb9uE7jeYFRj6LpKsCKn1w1IxA+cTD4t
         ZRnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772740176; x=1773344976;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W+xZbg2UcQYU0NAtEL3ooNVs0zEnn8ejUS3RGwHRvhs=;
        b=d7mRmYmmqxlxH9OjRWd/hdQS9KBMRBIneKE5SByr04/i13gk1vsYRGMt9l5T5mohXe
         8nTmAaW73Qv++R2LEjnHXITkrk16rxCm4Onw5cfsTqdOM2AMwd8ySlO/I5/wA/TFkxTT
         V54gQJUp9MNZAH6LEX0hMx3k6KpkRQCjiDD5xeyNf/rMMRt1UqUSEcyPLW2JOiqqerDi
         yCEJrienRjKEPlRXAArFjGGcp9sNXvfpKxy1vASFCE5kE6w8lD6JKvcCFjGjKW3JH8l3
         lTwTsr4r8JB+9/8Y8BMIVZvh7GeF7HKtPW135stb8Gpf6JVfEfqEdvlwvuWeDKFDMpM/
         2epg==
X-Forwarded-Encrypted: i=1; AJvYcCVnEdSkqqmLXDOW0EbKGxm2l+IwGhUopoJBAYI8GzZRvEXgKi13QfYvAvMERrPCYbKxrEj4OIqtjtw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQrovcw6Ju2neyY3xn8jYBp20/k03jsxxOpW60R6I7B7e/SkPe
	CHnqNspvna6aRzeuiu8xU4v7X7bg5ZTAgLs7eKJf65pirSV0C5rntAkD4q6erSpD1vlrIiGTBQL
	wZa2OwGLSjbhHg64rTX4VlYpNXAHxspdoG7Jjmtvr31TSjGodm2eKtQ4reVHUReg=
X-Gm-Gg: ATEYQzz7eTBQtWsiJneTcHSDzNjJPOdC+CmCfcJUBGILDkLdjE93UAmk6tVXDW42iZk
	4I6zbDLWot39Z4+xJRQD2HZaDSem/QjZbJqiWyBsdwmTFGCL74upRG0G3PRKfZTAmEnHn1pYc01
	dWUuQY2vc2NkhlJCXXSL/3If7SjrnSbbiR72lfNwpjh7C6UgWlQhwnsLQYYOJvXplgdSdo9dQkJ
	w4sBFlSqvBMlai2qvWHZeuQiHunONjTnZBn6//cVibznSSJPilOHtcHrslsxRS42Zst2EjCwCrS
	WRtGM9NudP5dsw9rcQCoEwS+jne8K0UR8HIRTZHTMA40JxByCH9IP7KGhx7zH8frrGje/FsI+do
	humjkXFj6dwQAZ1tF3DHXXJKFClzT5nCVesAwfhf4BgrVKtYl
X-Received: by 2002:a05:620a:450f:b0:8cb:3bca:bb46 with SMTP id af79cd13be357-8cd5afa3a2cmr885521185a.64.1772740175839;
        Thu, 05 Mar 2026 11:49:35 -0800 (PST)
X-Received: by 2002:a05:620a:450f:b0:8cb:3bca:bb46 with SMTP id af79cd13be357-8cd5afa3a2cmr885516485a.64.1772740175244;
        Thu, 05 Mar 2026 11:49:35 -0800 (PST)
Received: from [192.168.1.29] ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b03db76bsm37388533f8f.18.2026.03.05.11.49.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2026 11:49:34 -0800 (PST)
Message-ID: <7aa1e643-a557-439c-a337-20575adf1e35@oss.qualcomm.com>
Date: Thu, 5 Mar 2026 20:49:31 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ti: sci: Drop fake 'const' on handle pointer
To: Andrew Davis <afd@ti.com>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Thomas Gleixner <tglx@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Dave Gerlach <d-gerlach@ti.com>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20260223202426.566958-2-krzysztof.kozlowski@oss.qualcomm.com>
 <195cc8dc-8642-481c-8bdd-f5409ab8f5b5@ti.com>
 <5b6a4284-4766-424c-9171-feaa08c52ad1@oss.qualcomm.com>
 <2d852f07-0bd9-4076-b0dd-93425ed237f4@ti.com>
 <c768706e-f063-44bd-92cd-f3984ad3bfbc@oss.qualcomm.com>
 <aa2899ff-a8d9-4740-b256-266f7073f0a9@ti.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@oss.qualcomm.com; keydata=
 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
 cwzYbmi/Et7T2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <aa2899ff-a8d9-4740-b256-266f7073f0a9@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: vsZ77z0RSrhFWrTbQlekvqqZG63H16p1
X-Authority-Analysis: v=2.4 cv=Gu9PO01C c=1 sm=1 tr=0 ts=69a9de50 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=QannFOAQAd3pVwgO2DEA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: vsZ77z0RSrhFWrTbQlekvqqZG63H16p1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDE2NiBTYWx0ZWRfX6MAIfm0xQN2B
 VExFP8Roe83HZf6UTg3J+DdSgMut4Bx+FrLpi0P2oY4dFToCjXwqEYUNw8XXkIKsIsIyVTnXqtW
 m1AG3m6L0N/hURsL1409TnnUE5Owx9gT8cGQNmCKAxb+6z7FkAnSgGyZ1bS4b6h5yV0Fq0HbphS
 Z7CBjULUvwr9ru2GVhYWh0o0XQWX9+M+HXVg4x8wwO4am3hZe9D1U76rCAABYFIA7MC+0f73fLi
 +FZOi4wsqw/b6wvXTY31aKVK61cghVZXe4rMRwGAABKqAS8SyMnCDNM3KG1xB9XPJhTy++CN/71
 HuU4BrDObBsxZFKwpGNad20ba5JbTD42lLiO7Z5zIvGwK2K8us9TCsDtvLuRqdttXzY+FS9BIFv
 YcvO1A8bQkaCaZM9Ze6Uo7/FspDO+B2wxhhzoyclbx4LRKFE5Hy9McXSDtRvdVm3bABN+RO6zLW
 s61b3zr4EFl8oywXZSA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_05,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0 adultscore=0
 impostorscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050166
X-Rspamd-Queue-Id: 3A7AC217C71
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9287-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim];
	FREEMAIL_TO(0.00)[ti.com,kernel.org,baylibre.com,gmail.com,linaro.org,pengutronix.de,lists.infradead.org,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzysztof.kozlowski@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On 05/03/2026 19:44, Andrew Davis wrote:
> On 3/5/26 9:59 AM, Krzysztof Kozlowski wrote:
>> On 05/03/2026 16:52, Andrew Davis wrote:
>>>>>> The code is not correct logically, either, because functions like
>>>>>> ti_sci_get_handle() and ti_sci_put_handle() are meant to modify the
>>>>>> handle reference counting, thus they must modify the handle.
>>>>>
>>>>> The reference counting is handled outside of the ti_sci_handle struct,
>>>>> the contents of the handle are never modified after it is created.
>>>>>
>>>>> The const is only added by functions return a handle to consumers.
>>>>> We cannot return non-const to consumer drivers or then they would
>>>>> be able to modify the content without a compiler warning, which would
>>>>> be a real problem.
>>>>
>>>> This is the same argument as making pointer to const the pointer freed
>>>> via kfree() (or free() in userspace). kfree() does not modify the
>>>> contents of the pointer, right? The same as getting putting handle does
>>>> not modify the handle...
>>>>
>>>
>>> In that argument, if we wanted the consumer of the pointer to not free()
>>> it we would return a const pointer, free()'ing that would result in the
>>> warning we want (discards const qualifier).
>>>
>>> If you could somehow malloc() from a const area in memory then free()
>>> doesn't modify the pointed to values, only the non-const record keeping
>>> which would be stored outside of the const memory. So even in this analogy
>>> there isn't a problem.
>>
>> I am not saying about malloc. I am saying about free() which does not
>> modify the freed memory.
>>
> 
> And if you look, kfree() in Linux takes a const pointer. We also do not

The slub, but that's the only implementation being I believe frowned
upon. The mistake made long time ago...

> modify the content of the pointer we are given either, so we should
> be okay using const by the same reasoning.

That's a mistake so you cannot use the same reasoning. It's bogus and
bugfree to take a pointer to const for any kfree(). Just poke MM folks...


> 
>>>
>>>> The point is that storing the reference counter outside of handle does
>>>> not make the argument correct. Logically when you get a reference, you
>>>> increase the counter, so it is not a pointer to const. And the code
>>>> agrees, because you must drop the const.
>>>>
>>>
>>> The record keeping memory is not const and can be modified.
>>>
>>> And where do we drop the const? The outer "struct ti_sci_info" was never
>>> const to begin with, so no dropped const.
>>
>> We discuss about different points. I did not say the outer memory is
>> const. I said that you drop the const - EXPLICITLY - from the pointer to
>> handle.
>>
> 
> Only because container_of() forces the const to be dropped, that is out
> of our control. But we never modify handle though the non-const parent
> struct.

That is not true. You could use container_of_const() if you wanted to
have const. You explicitly drop the const, code would not work without
dropping the const and this is the problem.

> 
>> And that API which gets a handle (increases reference count) via pointer
>> to const is completely illogical, because increasing refcnt is already
>> modifying it. Just because you store the refcnt outside, does not change
>> the fact that API is simply confusing.
>>
> 
> If the refcnt is not inside the const struct, then the contents are not
> changed, therefor const is still correct. Even if the content of handle
> were in fixed ROM, nothing would break here.

I am talking about API and again you go into memory correctness. So
again, very simple: any refcnt get taking const data is bogus.


Best regards,
Krzysztof

