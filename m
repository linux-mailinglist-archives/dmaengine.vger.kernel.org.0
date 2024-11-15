Return-Path: <dmaengine+bounces-3744-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C219CF4C4
	for <lists+dmaengine@lfdr.de>; Fri, 15 Nov 2024 20:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B681E1F22425
	for <lists+dmaengine@lfdr.de>; Fri, 15 Nov 2024 19:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7A21CF7A2;
	Fri, 15 Nov 2024 19:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O9AQRPON"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1801E1041
	for <dmaengine@vger.kernel.org>; Fri, 15 Nov 2024 19:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731698592; cv=none; b=dGnV8pG5TJA5LrzqmmxSIq5qXUIfpK6zeaR/VJLeEjN7wirfA3HDOifVlbE8yEH5Lb584jFyexCXNmHdh3QV5dFywCLZ7fjaoTFPbzh30VmMC9vyq/+U3bVl80yXtg4BLZbVRDTMA6JkABZhU2QaoiDZotiRrZFgCiucpPKwUUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731698592; c=relaxed/simple;
	bh=0ugwYsMiPjIzE3XO6yj6SmDSHCV6ux2FxLlF975nzOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fblz0qWD3AbqgRn26QIN7LuMrGgOGBE5mQaV1bmg7Kq+w83Dy1gwvwQrV0JDu1D5cS4LklEdeDr/+PsjTxT46PD8w8ge07JbJEmXnm3oRWD+9rlR2n4irLqsXR/Jv+IGqo4iwgOYWN+LDOuN9RfBNRYmhXHdxCvSfoyKN7G0bbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=fail smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O9AQRPON; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AF91lbv023995
	for <dmaengine@vger.kernel.org>; Fri, 15 Nov 2024 19:23:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vQzNcm9MPebrurEXRmoO+0JRCZ5y5XJ1U7A64WaIO54=; b=O9AQRPONyF+IU8e1
	sX8WQubaMBWfkr/q774TjLs4rcEFmb5VHPMyxL9eoItXv44e/4ve0zi1NlQZrXBh
	nmsirgnss8GovmTniEqLVSCtl4LlGYJSg+j/SL4mv8i39XWsGt+Lse+0gnap4JXK
	84ywbk4ruaOk3KYuRXvDmUXVgdJSc6I1MyAleIa1AHjrjW43NGKpovaUgotIhmmq
	tLrmbKXd/EouD502jy4k2XjsvXxrElgur1Fa3r99cbS+bkkKDNIIUQkgdGWUTUf7
	tMLQkatyDp8OXVo5R9X+OV0Y45AK+LxsyHwGqqAPOmCrjusIylHhMms5/CwkeHVF
	fzFAdQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42x3achmk1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Fri, 15 Nov 2024 19:23:08 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6d3f929dcfeso4727786d6.3
        for <dmaengine@vger.kernel.org>; Fri, 15 Nov 2024 11:23:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731698588; x=1732303388;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vQzNcm9MPebrurEXRmoO+0JRCZ5y5XJ1U7A64WaIO54=;
        b=Au27XlXP5/RxCL21LyhheQO9X27xYDSwpmdebnCybjYCqCb4dyoINeJtJ0kLKJ/lzc
         qnGaun4MPOSUPiAjzVjQHX7qpgSH+Slu0LAM7Oe7zbojXNYjtwyzzApjhAgn6LP4RUql
         xjNeDdypCpBoV3HYC6nkCSKC0BtHi4/ZeaIAXbGAenm6J+Kb8U4dT7259K4Z05O/VijN
         apEuCGPkqvfl3sBT/9938tIV1/rcUN6Atqe1PL0+YY4SDVsLBYQV0Wz33pmS0X5JEyjL
         Ns5oki3AmTerQkjcgxqClF5KHeO1h1nKrlPtgH0AkLSqOTgR0kflXjcbX8HYOJ0gKyiK
         feEw==
X-Forwarded-Encrypted: i=1; AJvYcCX4G5ffZ7/SLFGVKxB7qBnuefIoK94wrLNc9oeRcQcbpRVGj/8wKWL4F81gxlmqfIAPM7RoMyWiJXM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTHC54wYnnBy3/Qxv40W1COITPUmE/zpOJEsWTTXVXKB5q5WZy
	Ps1t9V+j23e4qbRgroEnOaqZsGLOYwYNzQ7n6KOVKPtDGd0J0s+vEtXaoxrlVFDHfrchWq9F/t8
	vsdwTlR0XMGr9Z4A2xT78jpAGUqpppgEBsMzjfnsoCkKFUgdeYQuTlM7gNeA=
X-Received: by 2002:a05:620a:d8d:b0:7b1:aeb3:8cc8 with SMTP id af79cd13be357-7b3621c7d95mr233833585a.0.1731698587833;
        Fri, 15 Nov 2024 11:23:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEjzrzD6ZAVyYrWwmcz9xTYFtSBD7Vx63QI4phyNsR8JT9avb0i4h9YwIrXteSGtjIrVPNcpg==
X-Received: by 2002:a05:620a:d8d:b0:7b1:aeb3:8cc8 with SMTP id af79cd13be357-7b3621c7d95mr233830185a.0.1731698587348;
        Fri, 15 Nov 2024 11:23:07 -0800 (PST)
Received: from [192.168.212.120] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df1b5eesm211019666b.26.2024.11.15.11.23.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 11:23:06 -0800 (PST)
Message-ID: <87cc1f1e-85d2-40cb-b3b3-8935004f4f98@oss.qualcomm.com>
Date: Fri, 15 Nov 2024 20:23:04 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] dmaengine: gpi: Add Lock and Unlock TRE support to
 access I2C exclusively
To: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>,
        konrad.dybcio@linaro.org, andersson@kernel.org, andi.shyti@kernel.org,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        conor+dt@kernel.org, agross@kernel.org, devicetree@vger.kernel.org,
        vkoul@kernel.org, linux@treblig.org, dan.carpenter@linaro.org,
        Frank.Li@nxp.com, konradybcio@kernel.org, bryan.odonoghue@linaro.org,
        krzk+dt@kernel.org, robh@kernel.org
Cc: quic_vdadhani@quicinc.com
References: <20241113161413.3821858-1-quic_msavaliy@quicinc.com>
 <20241113161413.3821858-3-quic_msavaliy@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20241113161413.3821858-3-quic_msavaliy@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Hn1YcYU5li3LrFX1t5rSiZrmkpNDmWns
X-Proofpoint-ORIG-GUID: Hn1YcYU5li3LrFX1t5rSiZrmkpNDmWns
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 lowpriorityscore=0 spamscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411150163

On 13.11.2024 5:14 PM, Mukesh Kumar Savaliya wrote:
> GSI DMA provides specific TREs(Transfer ring element) namely Lock and
> Unlock TRE. It provides mutually exclusive access to I2C controller from
> any of the processor(Apps,ADSP). Lock prevents other subsystems from
> concurrently performing DMA transfers and avoids disturbance to data path.
> Basically for shared I2C usecase, lock the SE(Serial Engine) for one of
> the processor, complete the transfer, unlock the SE.
> 
> Apply Lock TRE for the first transfer of shared SE and Apply Unlock
> TRE for the last transfer.
> 
> Also change MAX_TRE macro to 5 from 3 because of the two additional TREs.
> 
> Signed-off-by: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
> ---
>  drivers/dma/qcom/gpi.c           | 37 +++++++++++++++++++++++++++++++-
>  include/linux/dma/qcom-gpi-dma.h |  6 ++++++
>  2 files changed, 42 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
> index 52a7c8f2498f..c9e71c576680 100644
> --- a/drivers/dma/qcom/gpi.c
> +++ b/drivers/dma/qcom/gpi.c
> @@ -2,6 +2,7 @@
>  /*
>   * Copyright (c) 2017-2020, The Linux Foundation. All rights reserved.
>   * Copyright (c) 2020, Linaro Limited
> + * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
>   */
>  
>  #include <dt-bindings/dma/qcom-gpi.h>
> @@ -65,6 +66,14 @@
>  /* DMA TRE */
>  #define TRE_DMA_LEN		GENMASK(23, 0)
>  
> +/* Lock TRE */
> +#define TRE_LOCK		BIT(0)
> +#define TRE_MINOR_TYPE		GENMASK(19, 16)
> +#define TRE_MAJOR_TYPE		GENMASK(23, 20)
> +
> +/* Unlock TRE */
> +#define TRE_I2C_UNLOCK		BIT(8)

So the lock is generic.. I'd then expect the unlock to be generic, too?

> +
>  /* Register offsets from gpi-top */
>  #define GPII_n_CH_k_CNTXT_0_OFFS(n, k)	(0x20000 + (0x4000 * (n)) + (0x80 * (k)))
>  #define GPII_n_CH_k_CNTXT_0_EL_SIZE	GENMASK(31, 24)
> @@ -516,7 +525,7 @@ struct gpii {
>  	bool ieob_set;
>  };
>  
> -#define MAX_TRE 3
> +#define MAX_TRE 5
>  
>  struct gpi_desc {
>  	struct virt_dma_desc vd;
> @@ -1637,6 +1646,19 @@ static int gpi_create_i2c_tre(struct gchan *chan, struct gpi_desc *desc,
>  	struct gpi_tre *tre;
>  	unsigned int i;
>  
> +	/* create lock tre for first tranfser */
> +	if (i2c->shared_se && i2c->first_msg) {

Does the first/last logic handle errors well? i.e. what if we
have >= 3 transfers and:

1) the first transfer succeeds but the last doesn't
2) the first transfer succeeds, the second one doesn't and the lock
   is submitted again
3) the unlock never suceeds

Konrad

