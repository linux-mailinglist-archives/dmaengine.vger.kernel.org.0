Return-Path: <dmaengine+bounces-11959-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XbwDLo9ORmq5QQsAu9opvQ
	(envelope-from <dmaengine+bounces-11959-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 13:42:07 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B56EE6F6DD0
	for <lists+dmaengine@lfdr.de>; Thu, 02 Jul 2026 13:42:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=njFg64kP;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=azeM8BV+;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11959-lists+dmaengine=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="dmaengine+bounces-11959-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B9B1130FF424
	for <lists+dmaengine@lfdr.de>; Thu,  2 Jul 2026 10:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0933CAA30;
	Thu,  2 Jul 2026 10:57:16 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C1A2D63E5
	for <dmaengine@vger.kernel.org>; Thu,  2 Jul 2026 10:57:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782989836; cv=none; b=tYy+eCtgeYMKKDT4/NUzH8Pa9LPzLx7CtEA7iaKnOVv9PYrgprv8PmOspRr40KrydSu6dS2xDsa9Yx3DaBX1KQnN2MHcJ9BJrxjQ0kOofTiO8sB94EwXlOLrdQ1F1OTZK3xMknonrbciQE9usfGrXy7ZU4WqBopD61w6Pg4lz2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782989836; c=relaxed/simple;
	bh=Ez+V8uwq4c/i2Dw+5MR5FhJDBOScJ2oEbEe6gRFruS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b6kJvQcKNjT7jErmlkxbFuFNC0Kcfxlentg+uUQ2A7xkBuqoJ9soWqt3I2lffVL9Jo/LB1DxyV5St8QBmcwkRN3juwanE4xevzc6BbMVQli7ChiV8D0xddfX//MaS2viVyf9JRjzA7q7nPUglIwnrfmgBWUOCpZqocU/WCOPTwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=njFg64kP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=azeM8BV+; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6629LIov4117784
	for <dmaengine@vger.kernel.org>; Thu, 2 Jul 2026 10:57:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	u0LvctxXJ/ux9qwDwJwKAbHaxE+w2/PZyxvI7B6d/BY=; b=njFg64kPugC+BVaW
	4eyYIHQCKr+nMWfQntCiodb5M6Aouz4PUuJl/G1hJuRymvbIBvMWaY3O0FlG5WeR
	gitbtwyOQQ7rYrlcQwLlU/6X/HhfVKdmkjkMA6oIfQbLfYA4DBiR1X2ddo+pVeKd
	vuhawQX8vDDu4OlrhZS9x4zaF3hSpQLFsFqUgEVu09Xl5yyN8yDMXO2RNyxJ8pSI
	liqIDkjiwRpJMhJ32KhmXdVQ6Hu68l5L9K91r3hzVjCWHsWtzs9TPKVz9hNd7HP7
	IH1Y1TN+I+4S9+ZwNG1HbfgqJrBp1RyO7qfmVf938FQSM/nIUTOE1Y1cvh+Q0xle
	eOu6Kg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5n9bgbhw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Thu, 02 Jul 2026 10:57:14 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c21be5bb4so8362381cf.0
        for <dmaengine@vger.kernel.org>; Thu, 02 Jul 2026 03:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782989833; x=1783594633; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u0LvctxXJ/ux9qwDwJwKAbHaxE+w2/PZyxvI7B6d/BY=;
        b=azeM8BV+JeLn8Ho9UFfUt7DQoWqsXUGN/3UXSa8KA5PXmPFmBu5unIsUFkkQGQK97Y
         oj8tFRWoUU7VIQDsKiGgwr2YuB7n+kBRi7FqQoXmhRzQqU+cdoPLPMHV5vEgN2fPSqj0
         QNpeHPzMkzMyeehk4LeeWJ+0msmmb95dNipMQB8rAD3aUiU0MoqWKZgTD7VA6foraair
         /tHJR47b2EVUGeZpZkkBqFaMAcwIZLmDt8gnil+At7XnOq4uBk8YYwvt70OlPXgZIhoX
         SfAnN+SXmm34kw0374fQi59oNAx54RxfE3OPEbTiRPE/F+DGouQWqLZytDMUSIpv7YhS
         cTtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782989833; x=1783594633;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u0LvctxXJ/ux9qwDwJwKAbHaxE+w2/PZyxvI7B6d/BY=;
        b=IY8036B1Wq0UMRdtD2l9/p8pNNoU/RziicnDd0e7EKCFhNpKJp5pZ3XItN0AUB7ETL
         OYXclsZPefp8HIGtztsH4xBJPKp+MBUvDu1SbQUcV8XBNzL0lKg0vTyFzO2WtnKQmqKg
         LuS1kxYtmLfvNy0dCx9TGfjArU36umMb95vs54XH4eN0UnuPiz+0QYeR+KRRgI+owHoL
         pCqqdU0JejqLIPFRAsZ8JIAsdqjl8noykdlXE39d3eEcTNQtbqmzNienZUCAIkSZb03n
         JooRYoHN3ckjxhpqMUdR433hgJTq50JqaqDoQbZzdz+VFdF1DKpGXETpZ/GvVQJNQ+KQ
         M27Q==
X-Forwarded-Encrypted: i=1; AFNElJ9kEqAGbRzypN9CCyhmc4ntCc6aag78Pq9f9pNGh1QVzmaxKbGaJ01IN8gpB4vEE7fCUS2HrnaEQ1E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8OIXPS/VejxAURF+UokVTTZTn+mEqUA4GuzT6jQi9KPCDddFI
	8jNkgjqA/0APyFzFDdknv1KKurYwt9N2MBhCBXa1ZaFUB8wMPe/bF4aVeBsmVoQKw76THSU6GUQ
	J1FsyX598fEp7OUtGR8go2ynQUbxJRIjQ+qK1xrfPRSsVVfMJRtze7QRdIv1c+38=
X-Gm-Gg: AfdE7cmNEkG8iW/zNf27NMchjEtEMeqmbKHNHvEhU7DuMH17JoxpnQJIn99YQ01irM6
	3M4lD9PrrII3jowtnQu+0Af9HSYgeP22Z+Rug+my0mnPyeFab5Nzqo3ffqJ2f/XmCcsqPqyZouk
	/WEb0gpwxOfixnxMS6wUD9XtDiOzxhu2eRQT+9HgdDQK8u4Q9w7JKSry+VpAnqdOfzCvTF/ed03
	5u0IOZKPGRXmdOc9q1adVPLTIG8j02dU65a1M7mSSb9Lc+2RTtR0XWNF3yOLE7iLg3+Z8tEtSMx
	WU1kDjQfmluLKxy3z2oHug5Vw75ze5k48T/eC6+hh+O62LZP0xchHM9BVcXb44r4vWHVETupOep
	ol0V6sJoQ+yTQyX1TOT/TDLpC5rNMpGRtBlo=
X-Received: by 2002:a05:622a:487:b0:51c:4fd:9a1f with SMTP id d75a77b69052e-51c268fabd0mr41784161cf.0.1782989833584;
        Thu, 02 Jul 2026 03:57:13 -0700 (PDT)
X-Received: by 2002:a05:622a:487:b0:51c:4fd:9a1f with SMTP id d75a77b69052e-51c268fabd0mr41784091cf.0.1782989833236;
        Thu, 02 Jul 2026 03:57:13 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b628d632sm110467266b.31.2026.07.02.03.57.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 03:57:12 -0700 (PDT)
Message-ID: <ab3d2bbf-2b20-43d9-b940-757450c82ae2@oss.qualcomm.com>
Date: Thu, 2 Jul 2026 12:57:09 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/11] arm64: dts: qcom: shikra: add WiFi node support
To: Komal Bajaj <komal.bajaj@oss.qualcomm.com>, Vinod Koul
 <vkoul@kernel.org>,
        Frank Li <Frank.Li@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260702-shikra-dt-m1-v5-0-f911ac92720c@oss.qualcomm.com>
 <20260702-shikra-dt-m1-v5-9-f911ac92720c@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260702-shikra-dt-m1-v5-9-f911ac92720c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: FurkLWthhdIoNF5q69EUXoJDcBWfv3Xf
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDExMyBTYWx0ZWRfX2BRMJqn1woJu
 1Ms4248Ht06nGWDhtGWmx8tVWNYXkBDmgpZPUq2+ha4NtGv3AY5QMCQIqgZ71/CuI6b0q3CsGgz
 MY2jbZALNFE+/bX+89sUi9s+lNfJZ08=
X-Proofpoint-GUID: FurkLWthhdIoNF5q69EUXoJDcBWfv3Xf
X-Authority-Analysis: v=2.4 cv=bOom5v+Z c=1 sm=1 tr=0 ts=6a46440a cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=NKnFMAUvp7LoSZ-z84cA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDExMyBTYWx0ZWRfX17cQuz+d2jmD
 X14iFOerHN834vmqEo0up1IH3irNYApd5sB4FfmcY0aKlP46I9vDgKtMFv17ceAGCBd06Cf7gsl
 DfJRc2L1go4JYvgTWIUMDjHIBjRead8e/j1QqziI1PtN65MzcDRLCZDkxpKYsMnbNq8qfeXYIbh
 v98xKJyOKrZ+5jo+FGh149vpED4G8Xv/iG+lhJwaWyg0ezpCtcXUSwuzOyNFUpnZRNqiVCej+sy
 fg4s4lu7LdfgG0VawZPuhF1Jhz60IAArb4PPUHkyWQYXxlw6gGhD1b4l4hDSVQ6oipiZyKBNmD1
 bK7jJUqvIIx/a7lvPSg3Bpee3DTWJ6rHRTGXkFx0Egio5JWFF2odrdqPGb7XIxvE83mP5yzubWW
 vtf5JsqRCtUZztzUWGq6ZhU65hoGbNApGJEmZ4Mi5lzpdrTgwZvU0KqKuP/mckF7b39nY0laY0D
 1QjRdCUjH7IAbiQUwaw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015 suspectscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020113
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-11959-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:komal.bajaj@oss.qualcomm.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:krzk@kernel.org,m:djakov@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:linux-arm-msm@vger.kernel.org,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pm@vger.kernel.org,m:miaoqing.pan@oss.qualcomm.com,m:dmitry.baryshkov@oss.qualcomm.com,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[konrad.dybcio@oss.qualcomm.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,qualcomm.com:dkim,qualcomm.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,dmaengine@vger.kernel.org];
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
X-Rspamd-Queue-Id: B56EE6F6DD0

On 7/2/26 11:50 AM, Komal Bajaj wrote:
> Introduce the WiFi hardware description in shikra.dtsi, including
> register space, interrupts, IOMMU configuration and reserved memory.
> The node is kept disabled by default and is intended to be enabled
> by board-specific device trees.
> 
> Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

