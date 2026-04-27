Return-Path: <dmaengine+bounces-10122-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJ3zMAsg72ml6wAAu9opvQ
	(envelope-from <dmaengine+bounces-10122-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2026 10:36:27 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C95AF46F2A1
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2026 10:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3FC023002912
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2026 08:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4529A39B4BB;
	Mon, 27 Apr 2026 08:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fqwsc5x1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WZ4U7nFW"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054EE39B495
	for <dmaengine@vger.kernel.org>; Mon, 27 Apr 2026 08:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777278897; cv=none; b=aNKyjj/t2yC1s/rcmq+HDOrQyPx2I7fnQwpRHO9zHXAm1Tk/v8rBM1rSs30smNe1mjq82Bpgodc544TNitOaNSLk4UTkGjLaNN737Crtr43YKYkv1mO9nzH1wlBSFx9tlmh2PJp+s8VHADufaWWWGISSry8bIUerHwnHjcVylhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777278897; c=relaxed/simple;
	bh=qjpOWTEBATWY+1ClpZB2F4dd9qTPzr/dSEUESfXn5l8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tunKOzIo0S9Y25FMzhui9ZbGtl1XQf7ps0SLJkn/8EuHF9Pny86HBsSuiW//YflHFhTzaHt6dT8C7h0IbMHkVk46CKSh42YEAYe55YMsfAyopgQ99WDJ6MLArlG4Vs+NV85IIzYfc0uQRfB8BkUy2mi2d1v8X0Zm9nzYXj6ubUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fqwsc5x1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WZ4U7nFW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63R8T8mc1761960
	for <dmaengine@vger.kernel.org>; Mon, 27 Apr 2026 08:34:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	L8Vi0CxTuBDh51sr0243sMsVnC5pQihWTiyZH0CgvNA=; b=fqwsc5x1gFJEM86+
	xltHEEkJ8erTCbDnBPl2AxlP25Lnl60fqYXffN5ccLHWeg8p81EWrdgFvBxsEhYu
	TVyjx8pYGlkgyi6iuVD4CpivjPfpOgKce5zeXj92p2tmXcFQ4/1V+JcBENt/InPl
	0ptJ1lWnB2YBqxXkjQPfAn/eSlY7o+QRybKoDUCm9mip0/mDCoq7UkguQ6Mh1z86
	vMtOXmLEDQkua4ixJD32h0DfhB6fUdjQ6wsQ3acDlCF25OJwdO/ZiQVYh5gtCR+z
	QLP75Z3jF1G0wrG6T9LOua8mF6QK/oxUiZbVMIdpkI4ESgEQS1VYR+9Dm4XiW5Vj
	C0ZKYw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4drpw9d2m1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 27 Apr 2026 08:34:55 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2a90510a6d1so82434835ad.0
        for <dmaengine@vger.kernel.org>; Mon, 27 Apr 2026 01:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777278895; x=1777883695; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L8Vi0CxTuBDh51sr0243sMsVnC5pQihWTiyZH0CgvNA=;
        b=WZ4U7nFWbPiCumeYl8pBEWhFUHr2yxlv2GV6sQd1YriP7TYs42RTnhWAEl3dMTb2ww
         ZudIAiCXMHhDqx8A4+InNZUJ3RfKVxWtkoZh1oqoH0hqRCd0bEpuGNLBmNqt57PNrCfy
         RywsCVo3PEcMvZ/L7aAeRyvabNLba7R4/zTLFgeqAR6JlJHQQWTT+EmOE4P4qXK86y+I
         p49fJzcc5dkKpxQfFwaHA4Dzghd/+wVuJ2qtqiV06famHyPLI9xAJjyGIZHAttyDQ2uc
         b0sW6eCTbAFLJeTvDIbLeC/eooyNbCtBTIG1a077DisMgnJcajjy2ZmJEaa68R2wRBy0
         CO5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777278895; x=1777883695;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L8Vi0CxTuBDh51sr0243sMsVnC5pQihWTiyZH0CgvNA=;
        b=jYmYNWK8WJNRwuPPMqKRO8+V9d+Myu/KXLr8XlXbVb+6RrIR0PJLpsmdUqt1nAVx1C
         ihtJA304bdR9Bf63BcFrKDKGC83cfP3aL1YZnGBU4PMz1p7j3VQmwDy4uQyyflp5mIBH
         8k4ex6c46oTrAib/yLeGyZ4fe2gNFSgSJ1KQttO4lL44UsSP1dKwzOLmRwykswuL4qey
         zdiiBdHt/gtejuaAKievwn8VkoC5UD+b1cVGAcjyPbYHqjs066VI+XXaaXCPQzGMLaN4
         UhTNLaC9qNEdEawJzPFKgP8MLsZm6nsVFKsqn3VnTmRt6lGWdKT5HbXgF7QfVTsl3fzT
         RzHw==
X-Forwarded-Encrypted: i=1; AFNElJ+RbT2xr7FKd9j3tdHpKKC7UiIEQ4bcPZTG1FtJGr65/3bh7azjQLA3f/evKL00kTjltLs9qzFJlEI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7U1ucR1dD5sOuQsvFbS32KFxqFFrswqG7gpb3Pr0kcWMQKJe/
	6DT/DxvqpBm/cnABnyez9wF/iz0rVVJbQ0yKD8ov8Zo4xCoQ10ClDsDY59cekMkpBrko6ynBIpm
	qPJvEKaeyV3A3ZxqZIxWte7iUC8JH/c+djd867tACgrHg0DaPRLdUo6g4/BWnY2s=
X-Gm-Gg: AeBDievOU6dhAy+MSLbHqv90Tmnkt/iAhqWQ5ZyaZ8rK1jJOdS7B/AtSKdTQnXzhnWS
	LWCGHLsyCxoVRKpmduN7/Xc1dvBc373Dn6I7Pwqtbq4JTtfAVKDmfpzuUZT92XTVCoSTrxClg83
	qWsvD6zGjw/sepsL9teD94ko8yiWaAyQKnTSvW7OGFEPhfDaf6D/TjR/ly+htvjw0Sm8GotONco
	M9IA/ErsarUK2pEv453p1DFxEYvcmDj2x9HLGxH1UO+wQpJV+QHes/tHD02aksysUhVjGHEZf3b
	1so4O6tZHmuSwbVQ8uSc61W4rCGKxTi4ZFjV2szDQEv3Q+zg37QwXNx/9aDjysto2Wk0i+nVCjM
	In2ASxH0qA0+Bm87rV+J7xMZEDklDxAO/sdJgLNpXwinsMemEZnze8x7kjvWirFU=
X-Received: by 2002:a17:903:3884:b0:2b0:c060:aab8 with SMTP id d9443c01a7336-2b5f9de53fbmr349372395ad.9.1777278894457;
        Mon, 27 Apr 2026 01:34:54 -0700 (PDT)
X-Received: by 2002:a17:903:3884:b0:2b0:c060:aab8 with SMTP id d9443c01a7336-2b5f9de53fbmr349372135ad.9.1777278893978;
        Mon, 27 Apr 2026 01:34:53 -0700 (PDT)
Received: from [10.217.222.83] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fa9ff3casm376926205ad.17.2026.04.27.01.34.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 01:34:53 -0700 (PDT)
Message-ID: <e00eb12b-e8ad-4db3-b4f3-c8a81f6a081b@oss.qualcomm.com>
Date: Mon, 27 Apr 2026 14:04:48 +0530
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
Content-Language: en-US
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
In-Reply-To: <20260425-handsome-papaya-porcupine-d42df7@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: E5P6sNTRehKjEMdQF66JwVA7587mLuLT
X-Authority-Analysis: v=2.4 cv=H67rBeYi c=1 sm=1 tr=0 ts=69ef1faf cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=fbGrPKVLzK6cyc7TY9gA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDA4OSBTYWx0ZWRfX9b2fXqzMvH4x
 OV1r+RIVUvhNhFeqy9nePYOgZHVepsm37Bsg1AKboQKJzenNqIMq+1It2XuxIa1yRreWFdlC15X
 baCuJeneFRs3PkopahLeaPFVGN4NGEvNGgGq46Yi2+78el/Wey0ZKEvqhWpkQ/ywk9fpi8/HAlN
 kLBt9/gfPDRkYblbrBF+lhvEtCKNR8jAQP0ovS14MGvK94w/ND2BzqyBCpFhgy1mbp52byM4MwM
 MY4CY475YB5WgNTsSfRINcySfqnK+jbQIu24vl9mt+Rz6XSYWvSCPFVgAMLHRVvoyWkBRZjeiNs
 oEnuFUHZ5QWbLmIHr3yRmR4Vw1sfKoDRhp98OWmhvrDH5EgPTlDfOFWtPS6qfhwoNUbGIZyYFp9
 hWjzj+sqxxF7ZGdsz6UBVF63etIb3Tz8cAuN4UDpk3+IfDEp1DPVLJ5dDar9BbZp7w4f9BAkTR6
 PFO2G2+53ORWVX3iGOA==
X-Proofpoint-ORIG-GUID: E5P6sNTRehKjEMdQF66JwVA7587mLuLT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270089
X-Rspamd-Queue-Id: C95AF46F2A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-10122-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuldeep.singh@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

On 25-04-2026 15:53, Krzysztof Kozlowski wrote:
> On Fri, Apr 24, 2026 at 05:04:15PM +0530, Kuldeep Singh wrote:
>> Kaanapali support newer BAM v2.0.0 version.
>> Document the compatible string and update example along with it.
> 
> And why v2.0.0 is not compatible with v1.7.0? Or what is not compatible?

Kindly check patch 2/3 of series to understand register level 
differences in v1.7.0 to v2.0.0.

> 
>>
>> Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
>> ---
>>   .../devicetree/bindings/dma/qcom,bam-dma.yaml       | 21 +++++++++++++++++++++
>>   1 file changed, 21 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
>> index 6493a6968bb4..0923fb189ada 100644
>> --- a/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
>> +++ b/Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
>> @@ -23,6 +23,8 @@ properties:
>>             - qcom,bam-v1.4.0
>>             # MSM8916, SDM630
>>             - qcom,bam-v1.7.0
>> +          # Kaanapali
>> +          - qcom,bam-v2.0.0
>>         - items:
>>             - enum:
>>                 # SDM845, SM6115, SM8150, SM8250 and QCM2290
>> @@ -118,4 +120,23 @@ examples:
>>           #dma-cells = <1>;
>>           qcom,ee = <0>;
>>       };
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +
> 
> Drop the example, no need for difference in compatible.
The current example captures an old instance and doesn't give complete 
picture.
Example, doesn't specify iommus, qcom,controlled-remotely etc. whereas 
recent ones don't specify clocks and reg address/size cells are 2 not 1.

I believe current example doesn't give enough info and hence want to 
extend and highlight latest usage for either v1.7.4 or v2.0.0

Do you want me to have separate patch for this change if looks ok?

-- 
Regards
Kuldeep


