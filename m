Return-Path: <dmaengine+bounces-11291-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6DmBK61tJmqEWQIAu9opvQ
	(envelope-from <dmaengine+bounces-11291-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 08 Jun 2026 09:22:21 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A986537D6
	for <lists+dmaengine@lfdr.de>; Mon, 08 Jun 2026 09:22:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=DuPn7hzA;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=HYwEc8Zj;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11291-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11291-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 898DB3018BF5
	for <lists+dmaengine@lfdr.de>; Mon,  8 Jun 2026 07:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F402135201F;
	Mon,  8 Jun 2026 07:20:58 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D832D378D9F
	for <dmaengine@vger.kernel.org>; Mon,  8 Jun 2026 07:20:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780903258; cv=none; b=qWVlvx5grl423iFVvXJlal0AFGl+eULlyjDR8zF0RxeHVIlVekjRsohvAl/Y2hYer48+AsqjC4Pd8JAvyv7RGSVxABOV7mozd/53kgo+i5X1zdst65vJMm6felysJ2teFTWg5+2wiPGFByAGSqWf4MLAwW/QBeSeKTZLiV8EE3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780903258; c=relaxed/simple;
	bh=R0iBQp9K2iUUw5EJtEU9HU3/RRSnNNKWFTW6ydj9yJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j/Tde/XPVm5llGbbloPOFaAs1MBAgXChZHM82VoW5aHvPLFsK+un4TMKY8rP4gkG8NoiZNp61de7bRoeSo7dmdIqU6PhNwKZ4RHnU8Yy28u3c3tEJdk4L87YedXI5Od1VEoejkIdOlMWYqRcYnAY25CLo9OsR44JIBp0+kwd0Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DuPn7hzA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HYwEc8Zj; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6586Oewv2385869
	for <dmaengine@vger.kernel.org>; Mon, 8 Jun 2026 07:20:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=h2LP9ZCfl+2nXbOOYJOfVeIv
	SatAl48h0/8tonPpRWg=; b=DuPn7hzAGSLGFWCfFWRSCeNjaP2+r3fxs+iSXQhh
	KomPEXoD7ufS+xK1Td37JOTb+NRrcBuSKtxnixkxM9r0HrMNFNbUXrFXUvm8Vk1J
	iwnx0yfU+bvijxqjA6vd4DXk8RQQVCzTEjIMlhpqH2t3EZmPqRq1BeQnFwJtJkDj
	Vn2zMxcB+36HSGU0r7VlObwEyKQqTJ+Eg77UAS8B6ncYF1aEU8g5xRnhU1FpS3eF
	KFl+3BV8ToICqU+OU4W4miuwSN2Sqsfe/WKVdHZ0FQP+A3xx3LtTmVe1MUqy829y
	lFtrYoBV1sK7P+L/U9M0arR6OXZMNcN8EsKg++V6nf608g==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emcu8x900-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 08 Jun 2026 07:20:57 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-963d7eabc83so4053054241.3
        for <dmaengine@vger.kernel.org>; Mon, 08 Jun 2026 00:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780903256; x=1781508056; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h2LP9ZCfl+2nXbOOYJOfVeIvSatAl48h0/8tonPpRWg=;
        b=HYwEc8Zj+InyeN1XsCmEVy+Lb6KZrsB/iN7k4bi0Tml+3nSvKelcxhwZiTXEPJWZE5
         2UJDFQQXTaJK/Z5l0KOP6fXkNtuiP9QT/ozLGBcsX882Bw9p5vs7MGNN8ZfkBSYmYBnh
         tzD859lB5Zy1qUd+Pb86uCCyi8r6nNU1Wfob//XularYKjc7ZlY1pqEoME4BnrZnCqFQ
         hpNXNtpzu9nZzFGLjtGX7tZXFyF/8kY3A17zNVWjg7h1sPYwbcs6Lj30WttEG3bdQkWS
         5H97cXwvgcM8teBN1MQTiAjzP+0/koaAPmHSh6wF/zvpR0J5gVExL1+rH0xIdxydsZ22
         11Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780903256; x=1781508056;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h2LP9ZCfl+2nXbOOYJOfVeIvSatAl48h0/8tonPpRWg=;
        b=BDpXhiXmHvy5mxhJ3/qpC47QvczkC6/ApmZ2iKFdtYmU4lVvm5UJqVypJ1Q+Xkwl+t
         HbSde1XGQf7mIBTCXF/CdtXSCSnZMNE098VMtfXG8815Q7Ml762wppT0bTRfcJZVkXb1
         wGu325fGfD8fjTkCxdliCkSnxBrjxkxZ9wiMxIs/z0DFizpp/HoZGcjrKW08j0NWLr8e
         JgtnIDil/ugPz4lOSw7uMbbeWCoS6ZYNnJeh0CHamJwLyu1UsKR5ObNlH795nBP/F6b9
         cD3rDJMuF1eiIL4n3rJBBytvn38L3+4B4BngDRo8B1Kv/cIiM/v0rjJI4Z6pyKCirX+g
         6J8w==
X-Forwarded-Encrypted: i=1; AFNElJ/EP0MZHbqJvxDVMdULlWEF56dcgDIqHFf35QyAg1ICQjSmjDDO07ZQoRQN4xcpHLGR6M7sk9fBSzY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2FCkSQhf0+LZpD/vAewGO/MjN4v3nTUySFPIUwGAYpquDbLQM
	94V9gpSdEFFzAvnObtBP4xxgVdCwCFBmiMXiVplhdmZsrU/WCQp8aB6YSUxYJLQSTTi00Qlo63f
	Hd3S9KlQ98pw3ZCHLN9TIuvbEzNSHJJh92M2TBq0lbT53bXTdY69/kfjspkfVPqI=
X-Gm-Gg: Acq92OHN/Gg2Mb/Fk1c2fX8mZ2xU9LzKfsGhEsN7QQW9VbRdSXOdx3CKyDFr7iqgpFy
	V+ec9jSdYLc/D5cpRn3jQIwWvlY/bjXFMx7q7oKoja/FhLBPaAAVbKWQ3r1rAa/DEygwAJovsJt
	nyd1BZoEvH8NjjxjSlZqoX/4s/cUNjDBB2t2SfJ4KwxAq2dDMppwiH0CkNSd7zcME4AwbvaWKtk
	SdnGw06nex9lYVFnJd/no8aZ8qzOB452OXwvVAvi3s3zx00a1XOwDZINenJjn7TTM1OErUAXGF5
	4LHgkTRvmLX6aMYvOtI437ktdn53plFGqjBUjWL/66EqPv0UeoOjpUFvSCUthNAL6MrqH5VFOlS
	kNyeR47h0dVFxkDScx2EH+oJhB0TfE11V2ZI6aRHwf6ElW5rGwntb/WnY+JKBmUZlj9M81Vo1qN
	29viGdH81paDLYOFrnXYiz3f84IdrAdYGDuy/maKgP8zXQGw==
X-Received: by 2002:a05:6102:80a4:b0:6dd:ea46:e3d0 with SMTP id ada2fe7eead31-6ff068c6a31mr6573680137.19.1780903256207;
        Mon, 08 Jun 2026 00:20:56 -0700 (PDT)
X-Received: by 2002:a05:6102:80a4:b0:6dd:ea46:e3d0 with SMTP id ada2fe7eead31-6ff068c6a31mr6573673137.19.1780903255815;
        Mon, 08 Jun 2026 00:20:55 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b97ac3fsm3626910e87.42.2026.06.08.00.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 00:20:53 -0700 (PDT)
Date: Mon, 8 Jun 2026 10:20:51 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Kees Cook <kees@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: qcom: gpi: set DMA_PRIVATE capability
Message-ID: <wfhkval663f53dfqegpynzt7el4cmu4bu7qfgfgpchz6w6shea@ljyka3qbvvks>
References: <20260602070344.3707256-1-zhengxingda@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602070344.3707256-1-zhengxingda@iscas.ac.cn>
X-Proofpoint-ORIG-GUID: dn9WqWY_TmrKyX5WTw-gGpN6ZiCWTDAf
X-Authority-Analysis: v=2.4 cv=deGwG3Xe c=1 sm=1 tr=0 ts=6a266d59 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=CYxUhL7LI-M9hzDX5WgA:9 a=CjuIK1q_8ugA:10 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA2NiBTYWx0ZWRfX8nEOvkJgrdcf
 BhBSDw4YN7IIelNTUvz2IzQoHV3Db03wMYGpTzCflSNX068eQKuu1Tb4knGG/3JWfZpMJFpzyUB
 3+xwn5r0OW0+4e4moFnocYbuVdmFhF8+DNS8zDbzNtFCdB8AIp5hdsXw3HyoSWvpIXrJUuPTEy0
 vS2jE/RmCPDYKHwQvvdxMM2mx2cWJowdCxvWz6Drkrn3Izey4jmGzBLEA3/A5IeaExWR7oA2u60
 7MjO2gir4Jf2zLHB3fCZoxCIfNmZiYE7KFemT8I2WvINdJi6AnDRf/UbJvmDgmjXeMcDIuQZVBa
 SJIr0oRxROZZ+9yzWz6BGqPZ3ejtiecFB0qvf7OBEm032WuMqckZ8BCBhDxiwsxfHIOX2xJxFOl
 cLizRLInb5SU3EsfDl3JxLk9LGy1FfzsAs1XQwU0qNGrc10tQBYxAE2cZL5/othkEkDLfLrIh15
 EQbDpX20gadmLoEw3CA==
X-Proofpoint-GUID: dn9WqWY_TmrKyX5WTw-gGpN6ZiCWTDAf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 phishscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080066
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11291-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,iscas.ac.cn:email,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,ljyka3qbvvks:mid];
	FORGED_RECIPIENTS(0.00)[m:zhengxingda@iscas.ac.cn,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:kees@kernel.org,m:krzk@kernel.org,m:quic_jseerapu@quicinc.com,m:andersson@kernel.org,m:konradybcio@kernel.org,m:linux-arm-msm@vger.kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[dmitry.baryshkov@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 04A986537D6

On Tue, Jun 02, 2026 at 03:03:44PM +0800, Icenowy Zheng wrote:
> The GPI DMA controller is only responsible for QUP peripherals, and
> cannot work as a general-purpose DMA accelerator.
> 
> Set DMA_PRIVATE capability for it.
> 
> This fixes error messages about GPI being shown when an async-tx
> consumer is loaded.
> 
> Fixes: 5d0c3533a19f ("dmaengine: qcom: Add GPI dma driver")
> Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
> ---
>  drivers/dma/qcom/gpi.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

