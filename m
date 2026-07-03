Return-Path: <dmaengine+bounces-12025-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +vAoO354R2odYwAAu9opvQ
	(envelope-from <dmaengine+bounces-12025-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 03 Jul 2026 10:53:18 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E92627004D5
	for <lists+dmaengine@lfdr.de>; Fri, 03 Jul 2026 10:53:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=WlqBeQ60;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=dM6jI659;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12025-lists+dmaengine=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="dmaengine+bounces-12025-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2A05930779F0
	for <lists+dmaengine@lfdr.de>; Fri,  3 Jul 2026 08:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA97348C67;
	Fri,  3 Jul 2026 08:38:34 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD16D2C234A
	for <dmaengine@vger.kernel.org>; Fri,  3 Jul 2026 08:38:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783067913; cv=none; b=LOzo48H1HLPCU3QN3+pQ2C4qetGhStW+XZdg7b8HfyxlNHzyHjfZtIRXCduSA3r6w1qk+Qfr+ct4aNYCv+6Oo5cgsUNTGGNbtSFRiPzaQUQnSv7stGccfuKzzu6z0FcUnRZqK0k00EoSCVV0Ne8EkMZfRxDlU51szPdRutlqQ1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783067913; c=relaxed/simple;
	bh=cdBpJkB4l/ZRo4O9VKG44JGa5I2jAbDW8goIFlmTmp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hsT3qRnLXvWjMhabeypDbT8cVVKn1e3BTjWa2Y8nTtYwLG851VEk8LE0Oyt4a9nF+fbe/E3GFApUOsi0hlvkc+l/ArCZbqaWN/ca43AF333/Oz+cCpvIG2x/Sr3q+KQTEpcFhzJwovlq8n+l1G2sECoY1jTQUbdE4LW0RFG2+qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WlqBeQ60; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dM6jI659; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6637IV2N3195235
	for <dmaengine@vger.kernel.org>; Fri, 3 Jul 2026 08:38:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hswMxx9rR2coXNNSZIKHclwuegKHDm4R8y+AVY1VBRs=; b=WlqBeQ60qkIZLhWx
	Kf4n1LSI6Tw0suSiShNTHd8D6b0jay0AG/pBMBgFrS1kQ1LgxiKay+T5CXIFCr6d
	KXz/dMxeHlxCIhPaqYHoH4DRLcjgIyEi07Rslbn0ne32eSoY/rbl1s17FTwyUAzj
	rdsPz48ickOfyZsdL57OwYx06JWoV4teyhunVc/NUHY7RorO9kjHRQ9MnBEj91Fk
	1oxQjDQedUoz0WxfIhTWbCwnvTs7fTnLhZcC3Q8MlOJd/d7GK8TKRO28/44QQ8XG
	EKdLpfHOzWfRFj/ZW3SHEtaEkNX4EqvOAf4RZkbskcb0PxUpCesWqxsgDI6MFsQx
	XznlXw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f68jyr9h1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Fri, 03 Jul 2026 08:38:31 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2c9e994869aso6157685ad.0
        for <dmaengine@vger.kernel.org>; Fri, 03 Jul 2026 01:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783067911; x=1783672711; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hswMxx9rR2coXNNSZIKHclwuegKHDm4R8y+AVY1VBRs=;
        b=dM6jI659XygDcPD9ZihuiG76xg4zPAGD9NmIM9/yB7Nuzn7qKzF7w1duq980gIjqCA
         a8aSf1x3Fx6BftyPJUoPjiUm8XnnqLq65+R9EGax45ABkjUBH4xui3Y8fzFma7hxhOIq
         8yBOkvGQKu/JLn2CHZXG0UFSavc3Ra4KCD8gix4oVF+imLYmMowiGym/I+PwY78mi4JQ
         e09nnPk3SRbufurr/R3PME2Dk5gcRJsuwkaJSIdCqdy399C9hz0rtxJx/pFE8jrqzAts
         EfpMThpCySWX9tz4IG5MNmnRrYZHzkFdvVww0VhYV0gt4lcvVR94VIMMktJmmeFzQsgr
         gz+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783067911; x=1783672711;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hswMxx9rR2coXNNSZIKHclwuegKHDm4R8y+AVY1VBRs=;
        b=dleH+Zkw0ZST5idrDuUq/HsfBp9sU5IAt0s0LsRLhS6HT3TW9GTuc1oTm2puU9pAyS
         k6gFQdMKBfToq7IFJRz2CzQQmrgPi7fAUUgIzOboWHQ5p2leOQYYotY6PgVroC5stqWY
         CgRUw81a2mijCr90ni8PF/Lhej8pXBQj+6dRL+PafuDw0GKM0PVByiECv2yxd3T8qrSV
         q7l3mKNpx8QRblRRH5oko62c6ww5i9+LKDbwtnfc2o6YSJvBRT10XlTJumJ8wF6rFCKv
         fdcyNr91NPSN5rrloWE23fOBm/mOlMEMDvw7QG4juVPYce/czi3RfgJ2izh1GGweP5x6
         6vCg==
X-Forwarded-Encrypted: i=1; AHgh+RoPTma+hP+9ArgNUq6xTe5KvKzSYwqows1NjAXkZxa6WEjc0BTTl1vOv04MneqhbZEVnPVCC7rosLg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNs5WGkyyF49atPVZHLQuU9oYvUh0dZglJH9kz2e75CyXPHna7
	VcdabXaXAVHuP9hQJoSSn/GQbPR4V93JNgHjEJvCOTkwi+ymeEKSoDctjjDAxPfTR/ilxHGsaw4
	nVnXE2pm4OiHqy+yYlDf9iWycKn3K8s1U/1PbSxy4BDgC6ZTDSOxf+mIRQAZLzm4=
X-Gm-Gg: AfdE7clGE1FlA/VLtgWSsalI/lWdCOh7e401DkqiZ1n2fHqAv8Zm7ddqdmYqeUcxoWr
	iPAKoXoLfgfZRajAaYCeQGjjigJfXaZxBWDJig01RvaA6fInRPsMOCwG4YOPMfTzVeWTUO0oN/P
	rjs2CXJUBXPuUsAKZCmL82EAwnWy0fnAB66fE56HR6xYe3m6fWP9JLWRZet2x86V3gXv2dVmLwF
	auqGILMLGxkLcfT3x0ePYNQkzY94nN8ZLatQifZaKg9Wuw29V1G2HbS/Gd1iVMZlUN/mFkDvaZ5
	jI7RA2BkdHguie/GwewRln8zVl3+dV0am/mIGURSHnHBHdB/cPmjYQn6ILvcVRxEoiCSZwAGKi0
	04OjlHpZB1fWNHUsJLSppmjzx46ScjgqCsvDSDUY/s/0=
X-Received: by 2002:a17:902:e54c:b0:2c9:adbb:5862 with SMTP id d9443c01a7336-2ca7e8b686fmr96679035ad.45.1783067911348;
        Fri, 03 Jul 2026 01:38:31 -0700 (PDT)
X-Received: by 2002:a17:902:e54c:b0:2c9:adbb:5862 with SMTP id d9443c01a7336-2ca7e8b686fmr96678625ad.45.1783067910779;
        Fri, 03 Jul 2026 01:38:30 -0700 (PDT)
Received: from [10.217.222.146] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3c876ea9sm15875811c88.13.2026.07.03.01.38.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2026 01:38:30 -0700 (PDT)
Message-ID: <e53f9b7d-66f1-4922-ab20-f6e66015c912@oss.qualcomm.com>
Date: Fri, 3 Jul 2026 14:08:22 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] dt-bindings: dma: qcom,bam-dma: Increase iommus
 maxItems to seven
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Harshal Dev <harshal.dev@oss.qualcomm.com>,
        Vinod Koul <vkoul@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        Konrad Dybcio
 <konradybcio@kernel.org>,
        Frank Li <Frank.Li@kernel.org>, Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
References: <20260702-b4-shikra_crypto_changse-v2-0-66173f2f28b3@qti.qualcomm.com>
 <20260702-b4-shikra_crypto_changse-v2-5-66173f2f28b3@qti.qualcomm.com>
 <20260703-steadfast-greedy-seagull-ad32ab@quoll>
Content-Language: en-US
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
In-Reply-To: <20260703-steadfast-greedy-seagull-ad32ab@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA4MSBTYWx0ZWRfX9QvGSKF5hQ76
 b8brwSb2vMezC3Thc7WcMempNn6cFpFZjI+JhokcsWbxQxk/MJTWmgQ4eJU2T/numbQHGGZBNjg
 S7leEbYE5wjCG8lR8w54jmP8ATqp/lN/K3/qWm4cfEwR4bR9aDvRJsV2o79Enz+pUjFVouuhCva
 jiVySDZHGwlgwYKM42RpRgReifd6EuxeZZE5lksaasdLzVJV8nVPcmTDikeMMkGbMNQ4mEDAGxi
 I3Q1qzuky6g4nJXSxdZAcJ0LOaTNwk+PrO0WbpCDqCeoo+WGFMmt649tvXvJ0gTBAzXodxI8M24
 MbzdWUbAf1Oc8gASZ6kCEU4Z1TtECUGIui22ILF3qv/KXvwzyBPwwWA/m++R1ftHT0ZHcPPeWiC
 1GRZ+l0ZJOPok6OzaMeTdMcpWO6JnfIAq+8N36wvmNLG8v5MI6ABAa9z3eaKi6Sc6Z1cvQFjCgj
 7Lt8sizZUoHKUetKZJA==
X-Proofpoint-GUID: BIVaOfyB6LymCg6kC9M1Qumz3ZU1Gk7x
X-Authority-Analysis: v=2.4 cv=QbFWeMbv c=1 sm=1 tr=0 ts=6a477508 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=B0NKSWsiUjiwxuKyzxsA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: BIVaOfyB6LymCg6kC9M1Qumz3ZU1Gk7x
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA4MSBTYWx0ZWRfXwWaaanI33rmi
 flvEvO3jc8Y+30dYu0T/HH+SUEgZfw7wzwppiyL5Jzt7ZamwagHLqXM5S/UlV1fExLSRDLPGG+V
 7qFBeuIGu5dOKzF0MCCcR2eACxjzfq4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 bulkscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030081
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
	TAGGED_FROM(0.00)[bounces-12025-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:krzk@kernel.org,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:harshal.dev@oss.qualcomm.com,m:vkoul@kernel.org,m:brgl@kernel.org,m:konradybcio@kernel.org,m:Frank.Li@kernel.org,m:agross@kernel.org,m:krzysztof.kozlowski@oss.qualcomm.com,m:linux-arm-msm@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dmaengine@vger.kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuldeep.singh@oss.qualcomm.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuldeep.singh@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RWL_MAILSPIKE_POSSIBLE(0.00)[104.64.211.4:from];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E92627004D5

On 03-07-2026 12:24, Krzysztof Kozlowski wrote:
> On Thu, Jul 02, 2026 at 01:47:15AM +0530, Kuldeep Singh wrote:
>> Upcoming Shikra BAM DMA uses 7 IOMMU entries and not 6, so increase the
>> `iommus` maxItems constraint.
>>
>> Fix below error:
>> dma-controller@1b04000 (qcom,bam-v1.7.4): iommus: [[25, 132, 17], [25,
> 
> There is no dma-controller@1b04000 in DTS. Please drop all the warnings
> which do not exist.

Kindly check patch 6/6, it is introducing bam node with 7iommus which IP
describes and hence, updated bindings before to accustom this which also
helps in avoiding rob's dt-schema bot error.

The same way we add qcom,shikra* compatible before consuming in DT,
isn't this case also similar where bindings are updated as per the DT
changes?
> You cannot add incorrect code, 

Shikra bam actually has 7 iommus and hence, bindings need an update.

-- 
Regards
Kuldeep


