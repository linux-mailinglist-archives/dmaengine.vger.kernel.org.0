Return-Path: <dmaengine+bounces-10087-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJuWBJG+6WkXjQIAu9opvQ
	(envelope-from <dmaengine+bounces-10087-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 23 Apr 2026 08:39:13 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CA344DAA1
	for <lists+dmaengine@lfdr.de>; Thu, 23 Apr 2026 08:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B505B300BE0B
	for <lists+dmaengine@lfdr.de>; Thu, 23 Apr 2026 06:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5715837F8A2;
	Thu, 23 Apr 2026 06:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GxNcyON/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Iv6pbP0O"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B830D391E49
	for <dmaengine@vger.kernel.org>; Thu, 23 Apr 2026 06:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776926335; cv=none; b=o+weqpiaCeopodmLYPWJgM9ngbeYmcgOGZI7YY6Kj12fsiBV1WqmGfGhmtFnHSu/qbINNJUhygmZlKBWe0Z6WT3Tw0lxFglbVtqUChTLMIugwwDU1mRc+qtObJ1oKf0oacJZKlz4/zx7heamoQ1FVXSswVA8LTn4RyNyLxnJYQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776926335; c=relaxed/simple;
	bh=gWV3fzYIKy638nnFL+aGAA+Vnwp/Cq6LplVvhwhWW54=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hfbY64uYomtwBTAGDLqEBaJJCKrZAhDOoyeF3vx7ZJL/vX58YBi9Iehlb4RzfjlcLNSrP8mPWUqvaApraoRG4Efm0WcUYieRDx4sRc84OOvg+RjaPiX0o0cZbGIn7RYR7Z5WCFUa3Cq7CBm0ZbEnqnT56RLSXlqjsW7RsySpGsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GxNcyON/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Iv6pbP0O; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63N3HX3b872740
	for <dmaengine@vger.kernel.org>; Thu, 23 Apr 2026 06:38:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6P9jh4N49IiB1blBQQ8THdkMemOBh/xmo1QR7ZBCuTs=; b=GxNcyON/n5MqQMqq
	g5sf4Wx/rlKiz5v9jZwCVZ3gmrtmnVvwKAzkNRLsPOp1Ox4MbY23+PBRT8PStLyN
	irIgC39jopHa4FqHLnrL6X4aubHTBBQG9Z+vInHMQoQk+OkwEJ3lEi/kyseQit0L
	gj//BfxuxAt5LpQuzB3yUvAUP3sUW41s4i5CVfYGjJDkE4/vyiaxdJTn8q3RsPzL
	xrMakEP1VIsVk0JSFEBouyg1nrlqArcVKggEJkceIMTTSAQX23CYsn4v/pH62ktZ
	g65HlxdYYc31XJW4vyRoh73JyuwK8OX0VsYTMHAylMlshyrIGpFBF1+ddZm/4zdv
	FiGGqw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dq1jh2hu3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Thu, 23 Apr 2026 06:38:48 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3568090851aso15376024a91.1
        for <dmaengine@vger.kernel.org>; Wed, 22 Apr 2026 23:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776926328; x=1777531128; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6P9jh4N49IiB1blBQQ8THdkMemOBh/xmo1QR7ZBCuTs=;
        b=Iv6pbP0OqFLyUrSPo4fIOygqUNMKIpjbntxgDT0L1yxWZqY1Mi7K+M7NvCstDz7OUf
         Rc7kXsI7HHfN8wP9Y5tnROcfMBJqgnGuXIp87i5uY03fwK5aZXeW3YCNMiUZDt/lD7vC
         aEqb/6OEz2dbyj0Adzhaws0r/+FUoyuyqmRiWnwlJuVF/DhkGqJgXWbyAa0pmCvVxrMW
         Qhc60NMZKZAZ4ibXPbjzXeJfRVLpIqZZEdYb2pIhu1Yo0Cops0Y2QmBCejN/NDysbASa
         B9bU880bo0L/7bf5dYyg84JKXBoIcDRuctKP4nFD8U9SMsZcaaAz/bk+zzwzPghnKuI0
         e7/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776926328; x=1777531128;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6P9jh4N49IiB1blBQQ8THdkMemOBh/xmo1QR7ZBCuTs=;
        b=c4Ju37qCVQfWSMJMsIGdFYKOamkBuaYA5DnIH3KbeO/rWqwvJg30JkmqG/dfh56oFU
         +za0ny82qlKM4RaM3fkH8DprjMm0TRAkQYt1ahqkRtbETjebh1hjc5DqNNXb8gq4S0oP
         r57PpQ6j3z98qsdtvAseVJKoDpM4CHupBHy9R08uLZDfrfvBMTLv4OJEOQxR3ypTbGt2
         RwB+YhP2j4t4450srp8S8r/5+VIcvm0Lj+gPNlfx518UVc2h3cm777DZk4JVjqB4Vz4Y
         rjIErz9yb+MeMAXEB8b44L0Y/WPVk2YCM7DFOh3EGZzUp+x8hKK7Eb1jsyIfJpCxn4+f
         1dHg==
X-Forwarded-Encrypted: i=1; AFNElJ/rfbcEKZv25WP1Sg68qmlo3b84MmwoV2Fz8zQ6sQ4JXPat92ttG3XqPDuFBMYDEU5K4pOWpILgGyI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqoFanTJxfxqv9PVLDcppZUiTwZBhfuIemxNCgJJ4JHj9QrDIo
	fb5LORHGcRD2dzoCkuIFWn3wyAuSY2EWhq/421UnlMf1/OuDwHk9pAyGm/jcaYrbIRewQTcLKAf
	hugbpeCrkY+p+vF5bZnyARPDU0z72L3WvBxa8l/XXYosN9YeKf/0pFPZj9c0+sWY=
X-Gm-Gg: AeBDiesL2UnRMiN8bgv1d4f+HBj6hFszCiK6mwiV8e2z9CiEt8dtBHshUmjm32j7hWz
	AdE8X0ZHF+VgKYC4L27bN8X4O7ocSKrbyB3M/E2ePyc4mrb6v9cvmLIhzIawP8Gumjf+30+g51N
	ile/GyXKK25Xqfc07ZgLWVNjEcoMQ03+JJIcEp/C6OgaLgfjQ1oO2bh3TYA4N+f9h++4uIB+ag7
	XMaY9Lka2v1btWi+wO1UCMHjFv1ellsWbglWgPgaIy0uaxSG1PQloIrGR999Dz9LyBOmn7xpdAa
	tDEanW9Zwlw53g3LPN6e5tUhTivGdUBCiISzQ3frtm6t3C/5xHy+/1yKQHCZrm0aFY8FDrGRHbd
	cC/Z7VKnWgNVaNHU9KbFxdMZNlJYVwjzEyzL8JH9N17OZsZ0M6CeXykukoOCTMXeblYw=
X-Received: by 2002:a17:90b:2244:b0:35e:57cf:c0a3 with SMTP id 98e67ed59e1d1-361404a6b1bmr26676585a91.26.1776926327567;
        Wed, 22 Apr 2026 23:38:47 -0700 (PDT)
X-Received: by 2002:a17:90b:2244:b0:35e:57cf:c0a3 with SMTP id 98e67ed59e1d1-361404a6b1bmr26676545a91.26.1776926327109;
        Wed, 22 Apr 2026 23:38:47 -0700 (PDT)
Received: from [10.217.219.207] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-361410a7ab7sm24264844a91.10.2026.04.22.23.38.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 23:38:46 -0700 (PDT)
Message-ID: <3b99fdf3-3822-4c75-84a9-2371bea24beb@oss.qualcomm.com>
Date: Thu, 23 Apr 2026 12:08:39 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/4] i2c: qcom-geni: Support multi-owner controllers in
 GPI mode
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
 <20260331114742.2896317-5-mukesh.savaliya@oss.qualcomm.com>
 <52685536-6b77-497b-aa48-621a82da2a0e@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <52685536-6b77-497b-aa48-621a82da2a0e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDA2MCBTYWx0ZWRfXyBeps0X2L8/7
 VubphYeAt1WFntXgLRcGBUtKwhNLUbh/GE/IYPkLYGehBOCVl120wPR9q3ZUwuKnXKaW8qyJzTe
 pXfWh/4AJH0RK7IhYlaHLYGkzsphhr6BzS0AEjDokKHLq4cWxrWiQ9IC4Xcd5EoSoJmaf9KN4/b
 VuYJgUwikYqGEKUsumUBck4Ab0E4VzLWsLXZp+ON6aLUhLvyXYjyY4wbIA96aqEkoZvMHvx9S7A
 QBL5Sho1SjZw6SDL2lUj3dRYQIbxVLkYbMrM6v+Gws0w/G7MyZ8bF+dOyb27wKk9Cxv5IHA+Z7q
 CDoD7XiDATZRcnZY7Hhu5MjDAYnYr6grMxTJAOXndLYFJ3mJ3mZOAlpb6DFrmdUhxCV4DKhkDnR
 mmhCUoB2gdCRMN64e03P05AR/Lz8saDu/iqIWd0OcUeGrfqfU6q7FIBQZ3FP5OBz/gdIDiBRH7W
 OOBtxDmZppEpPcupDWw==
X-Authority-Analysis: v=2.4 cv=OeyoyBTY c=1 sm=1 tr=0 ts=69e9be78 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=PLbU5tYRtHHGnyVtiekA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: LyVMq8BjHWtjbaVrg5Ts2d_TFgnEzrP8
X-Proofpoint-ORIG-GUID: LyVMq8BjHWtjbaVrg5Ts2d_TFgnEzrP8
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10087-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,gmail.com,quicinc.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
X-Rspamd-Queue-Id: 11CA344DAA1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thanks Konrad for the review !

On 4/1/2026 3:51 PM, Konrad Dybcio wrote:
> On 3/31/26 1:47 PM, Mukesh Kumar Savaliya wrote:
>> Some platforms use a QUP-based I2C controller in a configuration where the
>> controller is shared with another system processor. In this setup the
>> operating system must not assume exclusive ownership of the controller or
>> its associated pins.
>>
>> Add support for enabling multi-owner operation when DeviceTree specifies
>> qcom,qup-multi-owner. When enabled, mark the underlying serial engine as
>> shared so the common GENI resource handling avoids selecting the "sleep"
>> pinctrl state, which could disrupt transfers initiated by the other
>> processor.
>>
>> For GPI mode transfers, request lock/unlock TRE sequencing from the GPI
>> driver by setting a single lock_action selector per message, emitting lock
>> before the first message and unlock after the last message (handling the
>> single-message case as well). This serializes access to the shared
>> controller without requiring message-position flags to be passed into the
>> DMA engine layer.
>>
>> Signed-off-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
>> ---
> 
> [...]
> 
>> +	if (of_property_read_bool(pdev->dev.of_node, "qcom,qup-multi-owner")) {
>> +		/*
>> +		 * Multi-owner controller configuration: the controller may be
>> +		 * used by another system processor. Mark the SE as shared so
>> +		 * common GENI resource handling can avoid pin state changes
>> +		 * that would disrupt the other user.
>> +		 */
> 
> I don't find this comment very useful given we have kerneldoc for that
> property and the behavior you described impacts another file
> 
Makes sense, will remove this comment in the next patch upload.
> [...]
> 
>> +		if (gi2c->se.multi_owner)
>> +			dev_err_probe(dev, -EINVAL, "I2C sharing not supported in non GSI mode\n");
> 
> return dev_err_probe()
> 
Done, Thanks !
> Konrad
> 


