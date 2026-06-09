Return-Path: <dmaengine+bounces-11341-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1BJwH52mJ2rD0AIAu9opvQ
	(envelope-from <dmaengine+bounces-11341-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 09 Jun 2026 07:37:33 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 325BB65C7A5
	for <lists+dmaengine@lfdr.de>; Tue, 09 Jun 2026 07:37:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=bVeOx00s;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=M4F8AzK3;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11341-lists+dmaengine=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="dmaengine+bounces-11341-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B2CB43017CD3
	for <lists+dmaengine@lfdr.de>; Tue,  9 Jun 2026 05:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2217C3C6A51;
	Tue,  9 Jun 2026 05:37:21 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8983C5832
	for <dmaengine@vger.kernel.org>; Tue,  9 Jun 2026 05:37:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780983441; cv=none; b=qSMYIwmiy7/MRU2cVzIxCViyicea5AVfAETTjK6Na/3zDyiH0pUBv/CvyBV2d9q1dNMgUsjcKWWwKupPx9GIfw3quXg4szoJdBisu2h6dVottTOcroYjRPsuPfOuwg+liR+Qjjsg9En4ZE0yWOmccShK+IVINGLtp6zlsgC0cAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780983441; c=relaxed/simple;
	bh=uugD+ZTT3EoWEOXwbqISV+D0swD+cMJ1IGS+gn868C8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AaMAvdTapNpS013Zm94+e0vUh214fnU3YrgejEcYj0nG83Q2NYN8LyBf2BDDYhahi45t4K1o08+z1brFlXNPr/7KT+pviunbTilPCVB+STRiEi4rr1byzWg0tO9uAZAeVCLWkasVxxXziec7VcOQM7YpT7mmy6ZvhAlcPRxd3Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bVeOx00s; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=M4F8AzK3; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6593wpxa1026276
	for <dmaengine@vger.kernel.org>; Tue, 9 Jun 2026 05:37:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PR2hiJkiUQvrfmG0FVY4y008fpQ+lbRvpnuUvQasTUk=; b=bVeOx00sUnruNkyL
	0n5nL7OW4FT6mS9hzPhdOu3hPkJwERH7eRth45itatpDzXferqMtBAUYXGki1MmR
	l0bJQFmXpP5n7AwoE8F93LhRCvLCdomCDNNeugyX6BP4LBeR4u7gpk5gXEAD5Uld
	HmhA5AzmK9YNaHURKyrwVqIYcfW9A4l9VEsZdCZ6O82pDuPZbfwKsBHdMW65VYP+
	Cd6mxvC/AOSjfjra/QYSbOXIkCsnZY5WT8sCOnH39s/HnMVh/4e/LCY4KQXx/TTM
	62DhaKAJmUHamNX6N7EIRsrxAM3NJiYn0KNgS9psvDjljJCtzNxtdI8lOOOQkVa7
	it4zzA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enunack0h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Tue, 09 Jun 2026 05:37:18 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-36d97a4e08fso4733033a91.0
        for <dmaengine@vger.kernel.org>; Mon, 08 Jun 2026 22:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780983438; x=1781588238; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PR2hiJkiUQvrfmG0FVY4y008fpQ+lbRvpnuUvQasTUk=;
        b=M4F8AzK3eRmkTjN34hQXK9bqACNIalscJM3kjSbl/LcvvUGgNIJxXYdIjtgVqDrKRM
         t9AberkoqctwPxhUGoNq76auCvvx700gFKJTuUY3IekmqD2Dl4KjvLW63GbEAuFRJ+TO
         KKfkV23uRtjRplyfdOBYXuxhmqHWo6tmTCm6dCrPly5IHKhpENvslmDzESMDHvL+KxXY
         CcV137oG3ke+0oaA8+VN0kPkH4SPXP4ROjtZyTuyk8CAwKUWmsTM5Z/jQsciYnAf1su3
         ma6qZsKznspsGY2vdfeGA45wCrRsSou4/Pk1m6IslDBspaM57wOp+GPRy/scVgT7lS8y
         E5QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780983438; x=1781588238;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PR2hiJkiUQvrfmG0FVY4y008fpQ+lbRvpnuUvQasTUk=;
        b=Z59AGp+F4cZzJAwvX3R5r1bEN87qAbjYTWuDDVhc49eg9x1fF18NkpZiM72Ff/tG/x
         rQKfa6PGP6uVep3wWmqhWw0so5TsWpD1z5ZgX3MmigDxbhcvlP8VuB4fCR7DPwVkUTmm
         gVoU+HiybFSRE0jUjf/8ZDXJYqSGDS+rUOWFU+XNhWoJIf479dVQKlgv4rtpopDI48lN
         si2WXm/cftsCkmH7EA5nGbmXRrqopZqQUxTSIMxDOUOuPrQcHPY4y7G0cy5lWQ+VSyGK
         JlVwvHzcfjh58eB4roikwCynNe60ul2aNN33H9vGVXP0my39buwqrxMBf/jdBNNsdpVj
         ZC+w==
X-Forwarded-Encrypted: i=1; AFNElJ/sf8kYq46Js4I/fF7CPGI8h/jq0DsPb5qpSaardQH/yiR33HjL6R1g7tKPFnvuRJ8gn+55qacl1hM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyaq1bhHueP8g5tvW563hR89RnbOJfXYSymGU/1GpnErnMrUzPM
	aAelGyV4vhaEID2wak7iMmozXBxHTbQzMdk5/0fkLUIvabapj0nvsBB6+72Y2bq358p0mgPnDL7
	DgrFPkmmoxcmAZj8tLB4dVE5efTnAnmurHwoH+hmjXTUVui5VnDqVZQ/uIGjRCLQ=
X-Gm-Gg: Acq92OFdTfk2q+Y4pbh35DE9yPsAJrpWXEWRycev0rl9Ix1mgpexvkgsuxo6EucX/3r
	VJdkS9iiBWf/THg4NwBYN+dqhrZKI+rE4d+NCbMYxKipFiYgMyx3vGVK6BTChDf7wFwNtkCWjIz
	91ej+ol7yItcywdZzNNzYp9n9kp3nt6oDG2g2YDT2et/dMm3JDvYZHBZmflb1bsOOp7JtttueFx
	FZtkq9LVnH1P+SVn0YSHToZlf6mS2a8yJhgj2LxveFu/b0XJxLRRCpu+cDHwqDoPi9LL4JwAA6Y
	GahA0XY9rZBQAdnV8sgFcPJjmtr6LbVZE+K1mbz/vMYo0mPG5DpNpgShXIrc3QG1ZZLaCcfA/Nd
	IdfeqC0Hzx3OrvNOdyHxO6RXjDpIozp7/cmA2WN2OpX0qgWK+b349by7II5e4gjk=
X-Received: by 2002:a17:90b:5210:b0:36a:8240:2477 with SMTP id 98e67ed59e1d1-370f0967012mr19947174a91.19.1780983437857;
        Mon, 08 Jun 2026 22:37:17 -0700 (PDT)
X-Received: by 2002:a17:90b:5210:b0:36a:8240:2477 with SMTP id 98e67ed59e1d1-370f0967012mr19947132a91.19.1780983437420;
        Mon, 08 Jun 2026 22:37:17 -0700 (PDT)
Received: from [10.217.222.59] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f6d109dcdsm20019455a91.9.2026.06.08.22.37.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 22:37:16 -0700 (PDT)
Message-ID: <26b56175-a83e-4c3e-a871-28fb3aab0725@oss.qualcomm.com>
Date: Tue, 9 Jun 2026 11:07:09 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] dt-bindings: dma: qcom,bam-dma: Increase iommus
 maxItems to seven
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Harshal Dev <harshal.dev@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
References: <20260521-shikra_crypto_changse-v1-0-0154cc9cc0de@oss.qualcomm.com>
 <20260521-shikra_crypto_changse-v1-4-0154cc9cc0de@oss.qualcomm.com>
 <20260530-spiffy-glittering-quail-dff199@quoll>
 <289a5bca-5491-4fc2-92d9-1102aa664021@oss.qualcomm.com>
 <844eccf8-4ad3-46a2-bc8a-67895d629c4f@kernel.org>
Content-Language: en-US
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
In-Reply-To: <844eccf8-4ad3-46a2-bc8a-67895d629c4f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA0OSBTYWx0ZWRfX5GtiqTS4zaGz
 jy0TmmwSdl2VpBmqXZcl1e+sGDCyYcbGks0q1CgyRl8OAKj3mbX8Rr+pr359SVfGw/ltQqQeEpJ
 QibuGG7dIvUing/iEyaunEIJucPFx1WZYYgY193c3AOXm7EslmzZ846gwhKXPRu1hLnBh1SO4D8
 fllMKnPLgo5S94H6Zs4elBo6ZWBxr3eG7rxXh9G/eADU/AzYOFicU5eC0Fx74VmZRSdGgUolt2y
 pOcmEBuF1HTePjAMq4WHr3T1cm155jSTrUuzp6bthCqFAulPMAYDED2anewRdJGQIuUluuVQ+VJ
 yiCGhS0UMTr+jbA5bsvNFKu83g1rhr2SVgElJiZyo8TaFNmE6JQjbU7+C3zZzcHVTe1kxFeMGQn
 fkOmEffUlSGuNNaBWffz3JPfztPRqwHAxrbkA2WwSPoWBzxGX7/IwqZO+Vhe5ery6LOtTk/lrgn
 4FWHNHX5L4HojGpYPbg==
X-Authority-Analysis: v=2.4 cv=RfugzVtv c=1 sm=1 tr=0 ts=6a27a68e cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=gEfo2CItAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=3IJvv1DdaQ7zVQMhPnMA:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-ORIG-GUID: td_-R6PsM_R0Qhj8YUGucF6aSvYiBNmC
X-Proofpoint-GUID: td_-R6PsM_R0Qhj8YUGucF6aSvYiBNmC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_01,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606090049
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
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-11341-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:krzk@kernel.org,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:vkoul@kernel.org,m:thara.gopinath@gmail.com,m:konradybcio@kernel.org,m:Frank.Li@kernel.org,m:agross@kernel.org,m:harshal.dev@oss.qualcomm.com,m:linux-arm-msm@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dmaengine@vger.kernel.org,m:conor@kernel.org,m:tharagopinath@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuldeep.singh@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FREEMAIL_CC(0.00)[gondor.apana.org.au,davemloft.net,kernel.org,gmail.com,oss.qualcomm.com,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,devicetree.org:url,qualcomm.com:dkim,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuldeep.singh@oss.qualcomm.com,dmaengine@vger.kernel.org];
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
X-Rspamd-Queue-Id: 325BB65C7A5

On 09-06-2026 01:19, Krzysztof Kozlowski wrote:
> On 06/06/2026 22:59, Kuldeep Singh wrote:
>> On 30-05-2026 16:09, Krzysztof Kozlowski wrote:
>>> On Thu, May 21, 2026 at 06:47:11PM +0530, Kuldeep Singh wrote:
>>>> Shikra bam dma engine support 7 iommu entries and not 6.
>>>> Increase maxItems property for iommus to pass dtbs_check errors.
>>>
>>> What errors? There is no Shikra in upstream so how could we have errors?
>> dt-bindings updates are prerequisites for the DT changes of ice,rng, qce
>> and hence updated bindings in patch [1-4]/5.
>> Also, the commit message mention about shikra and DT change is also in
>> same series.
>>
>> I hope this clarifies.
> 
> 
> No, nothing is clarified. This commit msg is just misleading.
Yes, I'll update commit message better in next rev.

I specified error observed after introducing qcrypto DT(with 7 iommus)
for shikra here[1].
Sharing just error snippet:
dma-controller@1b04000 (qcom,bam-v1.7.4): iommus: [[31, 132, 17], [31,
134, 17], [31, 146, 0], [31, 148, 17], [31, 150, 17], [31, 152, 1], [31,
159, 0]] is too long
	from schema $id: http://devicetree.org/schemas/dma/qcom,bam-dma.yaml

[1]
https://lore.kernel.org/lkml/11c2d639-d2b8-487f-b627-f507bab25d60@oss.qualcomm.com/

-- 
Regards
Kuldeep


