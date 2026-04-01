Return-Path: <dmaengine+bounces-9802-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aEdCIsTzzGl9YQYAu9opvQ
	(envelope-from <dmaengine+bounces-9802-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 01 Apr 2026 12:30:28 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5ECB378847
	for <lists+dmaengine@lfdr.de>; Wed, 01 Apr 2026 12:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2E0D3114902
	for <lists+dmaengine@lfdr.de>; Wed,  1 Apr 2026 10:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B5E3E9F9B;
	Wed,  1 Apr 2026 10:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PR0IskKE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RBY9yL6U"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E54A3E9F9E
	for <dmaengine@vger.kernel.org>; Wed,  1 Apr 2026 10:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775038874; cv=none; b=LuRCcTtnbdItqhFNYF9Q0xkE4g4pSz+h2gCZtmOcBFyPeONZPK+hIBecHx+i96rCb/ecVEIdPKef3nNqSj7mauCI4iKrt6CFAVDqTRUJkMg7vPbRHef6E9KAvPkL4ILviiE1/Mv9dzYqiSPfz5B1opnkT9yNOw57ecoDynCZV2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775038874; c=relaxed/simple;
	bh=ntImYGAUuNndHflyGt0nJi1gktfiJhPa0rhgtxBQqls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o6O5NuQp4sctiWp1auhPfwfjFDAWkYHYnb+GFe+Tf++IliLkeBwjqJZtCymF1tj6oyC+p4RvF+TE61tKwbktuhDO1NBm5v43e5FUzmvpJ+y/5fjc3BG90h+OwlY5wAvgWSlz0owZmjVh9SYJw78sp7k8hiTMNRmJySc8xBwekug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PR0IskKE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RBY9yL6U; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6314MdGL3363191
	for <dmaengine@vger.kernel.org>; Wed, 1 Apr 2026 10:21:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xicnXfvbJIl+1tvirj2jRUxdt5mn2YyJxXsD3imbT4A=; b=PR0IskKE3mdbiMUR
	N7rmJJQ768nIozFdFWf/LTTP/RGGf12wZXbcdzWkx1DMU/f5V+O3kM4y8zs921hf
	icTvvR+Un/Cnxdkshq5Wrp/go+w0iUuc4aIxX+5+EQ+uXw11yFxmhgh1+D8EoGMy
	U3Odpw6mlqM9lxCvkQsIJUyEbOYC4g6ivMTX4fnbSwEnPq8HuSTZzbRVHqM3QooF
	9g8x9NqDFrVsOB0IRO/GTbfdvwDcWtypGEPiqokpgKzMKYzubvfkAqbH5rIuvBAr
	x4n09efvhyZ9a3+PBeMEKTUBcjll4dw8oKdN5eKemgJKSs/zYXQ3NUgomYgBg9nG
	TXcoSg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8nddjv60-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Wed, 01 Apr 2026 10:21:09 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8cb456d53a5so195537285a.2
        for <dmaengine@vger.kernel.org>; Wed, 01 Apr 2026 03:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775038869; x=1775643669; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xicnXfvbJIl+1tvirj2jRUxdt5mn2YyJxXsD3imbT4A=;
        b=RBY9yL6UCf2G9ppi1ij3r4yuvMnaid/L4c4LVpzNfTgDG9/daOMHTv1MXrBzbbKmQ+
         CeWX3nzco7B56DLblN27RZz6NreJW0/fyZXZY0t4n6C72i7GaxHPNNWuusT16TOHB+o5
         9GRxpbx1+l16nKNGizviywSaHLGhlu7ATKx7ouuEhuivRt+Sj0pKdxFQalPBt3fhGxQ+
         S6arKeltt4hJb1CCEhMF/rYsgt0f3giizogtmLRwWbj+8xpb8viK5bbzUmwgcBxTfCpO
         y3h1zkRRM5L4tAHfvQLhFAmpdK927JJBfszx8TTjHuXFTKvEmQtw52pIKeuIgo3wvHmT
         43yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775038869; x=1775643669;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xicnXfvbJIl+1tvirj2jRUxdt5mn2YyJxXsD3imbT4A=;
        b=SWMi+RpJsooBlv/jXq0Co76BsWXjhZbW+MBSAjMi+9iezNcDVkJaLvxrrqYMvFTH93
         q/0BWN2hBkbdnHrj7vVFsJ94ibfPUz6IOCiQFHFX6CoY9+RFpsrsBW3EwHDgJD/v6G7V
         WVY19ZywhFPSDvU5c3aeuvyJ5Me5hFxYcDWApjbW0axDOus/tvhHlFj21vn2YaWPnbgW
         DkA+tf1+tnPaBGnUDXMRL/i3x/5kWCirjWAVq4A1nx8A12kUU0D0XaPcOKgTJfsh0sfn
         sDDOSCn1Us0inSIN98WQB0eqLzSuFilppC7sAFiOVzm4bS5cxKPrSlgNEICwmgd4mnOP
         XIIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWI5BJ/mBeoCG26ZenJNMCcoX5utuDfRnuc7XfOkMlup9rG82phmUMhl2rYLj6bhuqQlkmzQneWznM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXBdOY7RpsF9C7H3LQlnlXXB2ksrFKmnYAf0ljALDMpb7kGcL8
	xzHIlccP0pwwJqDzDCnzHYrnE8aLqe+07Tmu6I2Q8l0pEN3Sm63nliRK4SQpH59FRc5VvyOJATD
	l3aQZnwpZBEjYMS8r/V243hiTNplSbziwhpvcoYPmx+e7WX6dYNjPedkWJTvgBHs=
X-Gm-Gg: ATEYQzzzxhIxe18WU7gjpNRnZPihM/0tyc22MHpVwT5sh3zllWEIbH60fHokl0+Wlpx
	8gtX4rOKl+CNIun+GZOE2TmKjB0b2FQREh8rf0aynBkmWB2Ro19702iap//7S4eLMBnIHFZYu7x
	orRK3jvj6G006tvR7BatS51sSKVPdZIfS4iM52wX+W4YQsHGjbKrIxd3tQETtfOr7lvdN6Xjzma
	dpxCrBqXIP9KHoWBhPRuPJ8p6rqVYAjMRFrQHXI2Pp8Qsy+QQZrgR8p+NHThHpxt2JclxAe5xyo
	ueU0hF28lmcUaKI/S1haJQ7MwC4xxe4BuuwbvWvgal3cj0WQv5q9obVa+Dza81q9rhNh4nQwnxQ
	p7+ih+d9ydaE+JGLG12kywuQFOxIRqY67SnAUMIWjDlixKtofxRgvArbLqyuwmTTSZP0aAT6aK9
	pVBGc=
X-Received: by 2002:a05:620a:4156:b0:8cf:d2be:5796 with SMTP id af79cd13be357-8d1b5c29d80mr354281185a.6.1775038869034;
        Wed, 01 Apr 2026 03:21:09 -0700 (PDT)
X-Received: by 2002:a05:620a:4156:b0:8cf:d2be:5796 with SMTP id af79cd13be357-8d1b5c29d80mr354277185a.6.1775038868582;
        Wed, 01 Apr 2026 03:21:08 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-66c07ab1634sm2476185a12.16.2026.04.01.03.21.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2026 03:21:06 -0700 (PDT)
Message-ID: <52685536-6b77-497b-aa48-621a82da2a0e@oss.qualcomm.com>
Date: Wed, 1 Apr 2026 12:21:03 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/4] i2c: qcom-geni: Support multi-owner controllers in
 GPI mode
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
 <20260331114742.2896317-5-mukesh.savaliya@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260331114742.2896317-5-mukesh.savaliya@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=ZfUQ98VA c=1 sm=1 tr=0 ts=69ccf195 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=1VLNcVKysphvfcDyL1cA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: rA6ZgYemqHKIuunG-hrRNRe_YhCNEhVb
X-Proofpoint-ORIG-GUID: rA6ZgYemqHKIuunG-hrRNRe_YhCNEhVb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDA5NCBTYWx0ZWRfXwQ2tFX4Esuhd
 65nqPAQIGLA+gJZeMGx53m6T5x3LU+vXX9v2l4G0ZDmGoBj8NXaGT7gTEiZNqrIFmNANAaHdFDw
 qy15vLAviEzUfPNQzK8Y8veN3kOPdj1tEvVsL2MVlTauscp0o96ljNhjvLMLwEQszYkVvI13CQo
 1rtz/bB1MjbGfAx/Lbp5JRFcyslz1yM9DavLTQBFFuksALeo24rt3rKRf4yoNaP+C1I1sKIcgPt
 uXF4570Ss0nnEk5WJw4TkVR/Urex2pd8qX7Ah9NK8v9JvikAd88DqwNpo2UtEDTnOXnssuVSOJO
 9CMO5KnmVuhQx5rx10iVAFUhqvqNPVgWzSGqoX99T6cMFBct93vX5Ojna/lypN4FMMdZ4QfYh83
 IOCtRaNbA3pMlLywvcb5Ibvg7cRr86JtdscTvPLVJMawd3pX3Djbs6YowUm1Ko8utGfCssoHLuo
 xNJIg0929nv8ONLh2aQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_03,2026-04-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 spamscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010094
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9802-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email];
	FREEMAIL_TO(0.00)[oss.qualcomm.com,kernel.org,gmail.com,quicinc.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: D5ECB378847
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/31/26 1:47 PM, Mukesh Kumar Savaliya wrote:
> Some platforms use a QUP-based I2C controller in a configuration where the
> controller is shared with another system processor. In this setup the
> operating system must not assume exclusive ownership of the controller or
> its associated pins.
> 
> Add support for enabling multi-owner operation when DeviceTree specifies
> qcom,qup-multi-owner. When enabled, mark the underlying serial engine as
> shared so the common GENI resource handling avoids selecting the "sleep"
> pinctrl state, which could disrupt transfers initiated by the other
> processor.
> 
> For GPI mode transfers, request lock/unlock TRE sequencing from the GPI
> driver by setting a single lock_action selector per message, emitting lock
> before the first message and unlock after the last message (handling the
> single-message case as well). This serializes access to the shared
> controller without requiring message-position flags to be passed into the
> DMA engine layer.
> 
> Signed-off-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
> ---

[...]

> +	if (of_property_read_bool(pdev->dev.of_node, "qcom,qup-multi-owner")) {
> +		/*
> +		 * Multi-owner controller configuration: the controller may be
> +		 * used by another system processor. Mark the SE as shared so
> +		 * common GENI resource handling can avoid pin state changes
> +		 * that would disrupt the other user.
> +		 */

I don't find this comment very useful given we have kerneldoc for that
property and the behavior you described impacts another file

[...]

> +		if (gi2c->se.multi_owner)
> +			dev_err_probe(dev, -EINVAL, "I2C sharing not supported in non GSI mode\n");

return dev_err_probe()

Konrad

