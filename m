Return-Path: <dmaengine+bounces-9801-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4LT/Mz3xzGknYAYAu9opvQ
	(envelope-from <dmaengine+bounces-9801-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 01 Apr 2026 12:19:41 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B959C37861B
	for <lists+dmaengine@lfdr.de>; Wed, 01 Apr 2026 12:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 16A3130151DE
	for <lists+dmaengine@lfdr.de>; Wed,  1 Apr 2026 10:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4E43E6395;
	Wed,  1 Apr 2026 10:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PS4rqm3P";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EjxLJli8"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1F83E5EFE
	for <dmaengine@vger.kernel.org>; Wed,  1 Apr 2026 10:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775038774; cv=none; b=ktodG4uRbfXHkG1eZ3UDRRUUkI2fhtgmXgNdUdcW0V5ZtXsN9VxSEq5k019PoQhVMtYUNMR4PDtrnh0GLCkfMoPQNgezS+JqS35qREbVUrNsHAZzlu421m+CkYuXhtsAq0WJ8eSqx1OLszvTUmzfjTdlVAlP6rJXaFnLQ7i0cuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775038774; c=relaxed/simple;
	bh=Njs9tyb3D8m4OZGmINAbbtRppnbGqiI7vwhKUfDMq0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qp8O2vFZ7vwaIdr3CIYjpqjD7OHC/z+h4xIrHEqJerdl4P0zI6+tlmSKDmo648h5Xo5xnPsJd9L1mn3xYGFHQZJCaR4bzjF4+gWkvzmCE+O31MlnfiiLkAEuPodT1SQNkmyyGfF8WtxCT3ZpDyfPXVdDi1TtFP+Fhf/r6Pd3r5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PS4rqm3P; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EjxLJli8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6317BCxr719536
	for <dmaengine@vger.kernel.org>; Wed, 1 Apr 2026 10:19:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	icigY/o4erm1hQ6wPL4lotqSd1rhrSmpE3CjS8+amCc=; b=PS4rqm3PjWOKLUxC
	fZmZSUMfFQbAXkocGS4eg3LQmoZUuKRadt4L2LHY2ulxThZbr206u3pO9CW3UceI
	UqxuOqvR+PJFdbi+KZv5/EAiCXBXxZXZupFmQMuLK39B1ekkfHVpsE9vxzptH+Kr
	mRIHuGhY4/qc84EWpt65VFnnPwEzHmGQ8bkE7pFQFOmErjbLwg26rrByfwO4uulw
	bv5JeqhlwDj1TXq6Nl0j1mbzEGn0K8qDmhpd8teX08ypCtTRpEAAe/r11HsqeUri
	iZa8sy66H4eL/mukdq4REeOVhw9MpCBeZq6r2NQzub2RTBo+OWNGrfOY6ZrAugA+
	+k7tug==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8kcsug1k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Wed, 01 Apr 2026 10:19:24 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-89cd541c0edso29431856d6.1
        for <dmaengine@vger.kernel.org>; Wed, 01 Apr 2026 03:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775038764; x=1775643564; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=icigY/o4erm1hQ6wPL4lotqSd1rhrSmpE3CjS8+amCc=;
        b=EjxLJli8UVcbyrIh8P2L26RAsZaNbeigCRp65HilibDeJkAJLuqvDbgvA3yjEatPAU
         UI/HifMc9uMgNLUCeRy4ABllhcFN+//JBX1nER9JICTDu3BbhgTGMt1SAxxomly61hIQ
         LKbYVYnHfVVFyvNzCHNktmEllxzCi2K+GWt9jn27SjlfDSG5Y172/G0zYv0Gi3XXrd6U
         x1Zt0KLBnSGqdLch+fxV1GugzL5vRRJdRXtb4/2bQSKI5C0BRp12GDZGKDn+yZ6w+nTY
         Cgp8skyU5cMazc1v9yA0fq0DPAIyQYc/fCz6vKU8zI5TTW/guHHKyhY1b4AD9OYKtIMN
         8Z5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775038764; x=1775643564;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=icigY/o4erm1hQ6wPL4lotqSd1rhrSmpE3CjS8+amCc=;
        b=lNqcJGz0c+vMBRgQCVclhbPXKxhXF4Ke82wbdvJCLProyuZn4kqjZ53zZPTKIPdvmS
         hEgLzOszHy6JxoYQzuYfhpy6yPDYsD18pWbTEFLnvKtizoBI0EyLYVGkMThXTcYzdmxq
         e9COOo+uo2DPSWTmSZZoWjVz6hY7splzN0dK6gJ9qHfU6xjXVsgbRlDCPqSR3V5cbEZK
         OsiOjK7F9xloK8KDniJAEpexp/MF9Q9H3bhqDPWbm+Wrz92Kiij51c8bcdWCLMTNf2bM
         kVvsr3DMr85u2jDx8OAyFr1oAHUiSBq/hnvgTCvHhqE6Q4Oo96BqONV86crC/h0Bmivg
         hwyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgAU8kCGoEgwe4xFt5+PYebuxX+9cxQwKy3O7IFCAthb930XNHs5iWJg9iNTJVEuQCcS68Rj9hGVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh0v1OePEeF3vPCaTuvtweXTj8Q6pVkpiV8+zaWO5fHKJ3PFYn
	0QIuzaN9isWJsP+LqOgrrMYas5034EuVk14n79i5BV13QQvCHMYetrLTkGOE0A0cQnTwjgdk0qC
	bTBd0tfGn7obl4u61cD28MK71vTnaeJ4rPbmcj7vq1/kH98Nr/cN5p9MbpksE3DA=
X-Gm-Gg: ATEYQzwEPY22/2QidHiI4b1vyLNAs4iwG2oaLsLCm04/lgi17OwvINr+zcj/ZM9Zyxz
	s8M9lUgEFRKC4WMgywkB9wdu7cR3mTIJCmkEf2XLT9uga7Wl1hAwRLpwqDGPj5ra9MQXM0JdGgA
	94zOCH1KZk8vn2dfOCZi1t6hINGyctcBc1pRf/yWIsw2RrJbbvwtbCWLZMqxM3nf++RtI3dq6i4
	lYF4Pc4l5tFZB+Ko0VENxkfpeOTeTPFmRpZ7P9VgKCESN0cHkSP9r5y2xTQ3ZYV7HPPQgJJn3H8
	OUcJe9yYYQusMckcQ2RkMJ19VYRGharZB7WTQ+vw5jjdbV7hFlcaGsuz/wjAp/hFhesQFy+e+nR
	zSzWzKP5WAJjd1Zfrd1ZrM2BZr08maldKp903738RHxlLdF5EJArHcwUKvfQ+wuOu4y3sg+cOlN
	P8eq0=
X-Received: by 2002:a05:6214:5184:b0:89c:5285:200e with SMTP id 6a1803df08f44-8a43a55cfe7mr30042746d6.4.1775038763833;
        Wed, 01 Apr 2026 03:19:23 -0700 (PDT)
X-Received: by 2002:a05:6214:5184:b0:89c:5285:200e with SMTP id 6a1803df08f44-8a43a55cfe7mr30042446d6.4.1775038763384;
        Wed, 01 Apr 2026 03:19:23 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9c2c28d97fsm23326766b.20.2026.04.01.03.19.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2026 03:19:22 -0700 (PDT)
Message-ID: <ce5eb817-ce13-49c3-81f8-8e28c40632a1@oss.qualcomm.com>
Date: Wed, 1 Apr 2026 12:19:19 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/4] soc: qcom: geni-se: Keep pinctrl active for
 multi-owner controllers
To: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
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
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260331114742.2896317-4-mukesh.savaliya@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDA5MyBTYWx0ZWRfXw4N1X8zrLh0x
 6AvIUkU2cz6snO7uUYHzSMtCv38jVxdzKj6Lxlz6/cpPJuzk8uewFL2fIV3Tj0DWrsPyCcvFcTN
 ApfqtECW5zgrQJ6Vg2es58KpG33CjD4jmnxD8wDHpi9TCtyPVRMeH/TGy6U5AS3aOIiA094wKyY
 UrFs9/tc+wu7diFxa3lkxGKpHHxK9RnejVsf3FQhvNW7qt69WILW3KYV4JgVYeFP6iCd3mmwuKz
 PcprxJdWoy/ZGBBSEc2AftsA57+SwUbV4QEOe8Sm2vu5RRi218UrTQhXOPa/QRIm8kr4H12vPcO
 aUou13jduvwn/EyKlMiRhwuGzHvGtbaghV5RO8MJPeILgJdVRqkFlZ3hVP3i3gAv3ZxEMU8nbLf
 Z0yBMc2quK/TfMTpZq3EOeN/4d8kGHaawitSAuciF9ocdkuKtt/YqcltnJF7D5xBtTSoHq1pDkc
 wHDbhdr0rWeOwAP8brA==
X-Authority-Analysis: v=2.4 cv=KNlXzVFo c=1 sm=1 tr=0 ts=69ccf12c cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=z3Ex9-aFqVcHxkoEKGUA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: qiuKjRvi3r28m32G3y8lBks7lcyRknXc
X-Proofpoint-GUID: qiuKjRvi3r28m32G3y8lBks7lcyRknXc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_03,2026-04-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 phishscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010093
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9801-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,gmail.com,quicinc.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B959C37861B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/31/26 1:47 PM, Mukesh Kumar Savaliya wrote:
> On platforms where a GENI Serial Engine is shared with another system
> processor, selecting the "sleep" pinctrl state can disrupt ongoing
> transfers initiated by the other processor.
> 
> Teach geni_se_resources_off() to skip selecting the pinctrl sleep state
> when the Serial Engine is marked as shared, while still allowing the
> rest of the resource shutdown sequence to proceed.
> 
> This is required for multi-owner configurations (described via DeviceTree
> with qcom,qup-multi-owner on the protocol controller node).
> 
> Signed-off-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
> ---

[...]

> + * @multi_owner:	True if SE is shared between multiprocessors.

'between multiple owners'?

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

