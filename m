Return-Path: <dmaengine+bounces-6719-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DB6BA5587
	for <lists+dmaengine@lfdr.de>; Sat, 27 Sep 2025 00:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35F291B250C8
	for <lists+dmaengine@lfdr.de>; Fri, 26 Sep 2025 22:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715AB261393;
	Fri, 26 Sep 2025 22:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oa4ImZYn"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0732288EE
	for <dmaengine@vger.kernel.org>; Fri, 26 Sep 2025 22:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758926162; cv=none; b=UT6oyV16e9hI6ItJnyo59mtKQaBx0+Vh9+nCMraU94Tm+W7/kOkhSKkJnaGMl9ZTLxQeNwA7LYD1rwDdlTSbmi67+FIf6lLM0Fw8X080pH1Ihb9J1A150fivJdenMmGZ0V2zDmAJjX75wtA3UTHzY3FDeq8UKi1ZGQxeV99LRZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758926162; c=relaxed/simple;
	bh=9purHNX1lS082Hyqiy1U7KvnoSCetzFJVKiqA+89V8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eFTitllhkwtNFg6kJ6qxkvolIkQJO42iLdmqK7FVDRlqvUIkTl0kQpIFhJ45RouHzKhmOjjGrm1uJMh2wb2A1Fq5QbClwETyEDOtObsbeJG7Wc1l0mujvFeyfswK4cIUZp83ICIH2iV1tiRhXOiu40udWuc27ZJlN6UKDcfTJu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oa4ImZYn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58QEWoPO030154
	for <dmaengine@vger.kernel.org>; Fri, 26 Sep 2025 22:35:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=SoeY4l6ebsrYr5pagnV48aNI
	rgnvCjkETPIfrORiaFw=; b=oa4ImZYnM2V3WAMBIsyzs7kAnuckDrb/EzjN8BlA
	CodXqF6dZFTwu74QKBC4wl0XM0onTUVfpBpcmHpfiODxqL12Hjh56fs5QlqY+u9j
	/3K2UIQKxdmAd4SrLs6VpaB+iAJ9Zp6baHDpFL1oXt/5GfxIAgne46tyz5RKaSXa
	CFaA3AWi6O3OUtSL6Q3K4wlCZBwLQC0VwnEsdUCfFy8NE48Ma7K0NimyL/TYQQG0
	3U6zVHpvRD92zoVlV5B532RFk8DbbqpjOwZoHKig2EWoLnscWqarSEE7BAankOPD
	OC3mMibYKu5Bu6IFP5pN6vQXV+a+O4e3oO1LNU/zN8BgOw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49db34mb4e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Fri, 26 Sep 2025 22:35:58 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4de35879e7dso19670131cf.0
        for <dmaengine@vger.kernel.org>; Fri, 26 Sep 2025 15:35:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758926158; x=1759530958;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SoeY4l6ebsrYr5pagnV48aNIrgnvCjkETPIfrORiaFw=;
        b=YtWRG4D19OMcjN1jnH/AFLrYsZMAp7LQ4mQPXrPs0WgvRsIAXkAdos1Ee2olOMfY5y
         y5Z4Qn6zHVM5kS9fN5CkjObRKNijxPvDhg0CURCf3I1OEjmEYZ+k750ANBg0NKPUxRMM
         iDrC67BWKXWlmRVSSbSLf5ydraNH94IUKzaiW9A8dZcwRwv7kaLkoLekEkvSv36peJpm
         6rDTv8yW45FPqP0asFnoZKJwngCDuZNQm0b11m4Fp1O4Jmj/MnE2oZUCjdrYVtr3+CwX
         +Cyi9IV6BkALJ8M/MLux40iQcSB4B/FtcUBY2oggWLihgxq8kU44xrnt+YyciY7mOeRa
         VW5g==
X-Forwarded-Encrypted: i=1; AJvYcCXZQhOHKs4mkcqINHS320yqdtwWVMeWq5FaJlxLxZz6pPc506zphlyM1Uk0QvFGmOv7/P1sHhT4SdI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzeiw/0BkBR6WGFsa2/NoUlqabXvw6Nc3KBP0FLPu1Dz83OQYvn
	ialDCPd/QlbkkwpmivoAowiRQUEKtYSglKwhje7jZp4GDci5r61m4fklAIMG8gz+BeBKT2zYYLy
	e5GSq9/+L/RzEsylNaEnhEMhiGKOr1hADoQuJ+INzjdLjZCr/V/EydK6M+Utl+7c=
X-Gm-Gg: ASbGncu+gGAMP0sh+gjUMbLVJ3av+CE+k6xIFsWqYzw2WwO1X2gviA0kjqU4leZ+w0w
	fOMDjSyVw2sk+gsA8u3NxsMkmx3xHvSzsp1em2KP2oVC8NVwRHaULE/pbVxvZSnyxJTn9e7etU+
	jdysJi78eLaoZO9IivRLsN+T5GRePfPwKKCMYrIQtfRoxiW3ibULQ8dYQ7y7gVlLfTHlpJm2rHX
	y43AfFVCuY3m59gztdzZxDB6pjtPoX3qEIXR3ZvxA/1mhCJyqHA1XqP0dbQz/U4YXfCdEHM0gDl
	VbNQGZ/J3/jnfT2+W+fAGDc2Wg/ClRIVHrtmb8i7VPUa7+rThLlTiRpRaaN34mw+RbEiPDSWR22
	dUqKH8uRvWY2PwcKx0K01wCWI1u1wVpp5csad/024eaUKHuMhbs1g
X-Received: by 2002:a05:622a:1a0f:b0:4b0:da90:d7d with SMTP id d75a77b69052e-4da47a1a220mr115923211cf.3.1758926157810;
        Fri, 26 Sep 2025 15:35:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/mVxWB3lmLAFeQC9Fvkdijqlfs9w38uYfGjjdvBN7+TJwGSvqr+pkIUIo3hPrxbde64DYZg==
X-Received: by 2002:a05:622a:1a0f:b0:4b0:da90:d7d with SMTP id d75a77b69052e-4da47a1a220mr115922721cf.3.1758926157253;
        Fri, 26 Sep 2025 15:35:57 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58313430a7dsm2147362e87.22.2025.09.26.15.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 15:35:55 -0700 (PDT)
Date: Sat, 27 Sep 2025 01:35:53 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>,
        Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>,
        Viken Dadhaniya <quic_vdadhani@quicinc.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, quic_vtanuku@quicinc.com
Subject: Re: [PATCH v8 1/2] dmaengine: qcom: gpi: Add GPI Block event
 interrupt support
Message-ID: <vdd33houteml2inilry6vkqdpdm7vykcqb5vf66sdhq5knlfhr@mzlrb5babocx>
References: <20250925120035.2844283-1-jyothi.seerapu@oss.qualcomm.com>
 <20250925120035.2844283-2-jyothi.seerapu@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925120035.2844283-2-jyothi.seerapu@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI1MDE3MiBTYWx0ZWRfX2r9/RTHNNzOC
 mbJAYnUfUzbv8wAwYcDRyirWjQdYKPFMbA+LmcKsskugE0A/SyNtFhGkdo9OHiAXKV/fEUea+n6
 p4QnsaNDUwSFfRweP1+OlPRvQeafcKPtLejBpvj7D89gjdAfvkZ+FootK4Rt0pMN2EoLiXAgQ6B
 we2x47DJ74ukT3L68FKZWwi3KiFOA7gPGt+c0kxMscwilnhZ1g9dqXaWGTo5xkuABBS0Q5nA8/j
 NVp1Zr0i/h9zd+9Y+QjRrZmuPG57rBqnM6VET+79UX9jCeP2ff4OBjecGJNo3v993kn/6ZLEe0g
 qdasx1XtHz2sOhbETT90N6F558ly75C+jE9JaeX74OFNQYku2VYVy87hk4gtgO/oQwMV4OP8dKa
 6gpvwJ5vHhYnYBRH3MC3SNCtmJNmnQ==
X-Authority-Analysis: v=2.4 cv=Hb0ZjyE8 c=1 sm=1 tr=0 ts=68d7154e cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=UZ83mHg5h350vH40qggA:9
 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: ZzUG5FKKiU1X7-0EZrWJ5248wfIhuGqq
X-Proofpoint-GUID: ZzUG5FKKiU1X7-0EZrWJ5248wfIhuGqq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_08,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509250172

On Thu, Sep 25, 2025 at 05:30:34PM +0530, Jyothi Kumar Seerapu wrote:
> From: Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
> 
> GSI hardware generates an interrupt for each transfer completion.
> For multiple messages within a single transfer, this results in
> N interrupts for N messages, leading to significant software
> interrupt latency.
> 
> To mitigate this latency, utilize Block Event Interrupt (BEI) mechanism.
> Enabling BEI instructs the GSI hardware to prevent interrupt generation
> and BEI is disabled when an interrupt is necessary.
> 
> Large I2C transfer can be divided into chunks of messages internally.
> Interrupts are not expected for the messages for which BEI bit set,
> only the last message triggers an interrupt, indicating the completion of
> N messages. This BEI mechanism enhances overall transfer efficiency.
> 
> Signed-off-by: Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
> ---
> 
> v7 -> v8:
>    - Removed duplicate sentence in commit description
> 
> v6 -> v7:
>    - The design has been modified to configure BEI for interrupt
>      generation either:
>      After the last I2C message, if sufficient TREs are available, or
>      After a specific I2C message, when no further TREs are available.
>    - In the GPI driver, passed the flags argumnetr to the gpi_create_i2c_tre function
>      and so avoided using external variables for DMA_PREP_INTERRUPT status.
> 
> v5 ->v6:
>   - For updating the block event interrupt bit, instead of relying on
>     bei_flag, decision check is moved with DMA_PREP_INTERRUPT flag.
> 
> v4 -> v5:
>   - BEI flag naming changed from flags to bei_flag.
>   - QCOM_GPI_BLOCK_EVENT_IRQ macro is removed from qcom-gpi-dma.h
>     file, and Block event interrupt support is checked with bei_flag.
> 
> v3 -> v4:
>   - API's added for Block event interrupt with multi descriptor support for
>     I2C is moved from qcom-gpi-dma.h file to I2C geni qcom driver file.
>   - gpi_multi_xfer_timeout_handler function is moved from GPI driver to
>     I2C driver.
> 
> v2-> v3:
>    - Renamed gpi_multi_desc_process to gpi_multi_xfer_timeout_handler
>    - MIN_NUM_OF_MSGS_MULTI_DESC changed from 4 to 2
>    - Added documentation for newly added changes in "qcom-gpi-dma.h" file
>    - Updated commit description.
> 
> v1 -> v2:
>    - Changed dma_addr type from array of pointers to array.
>    - To support BEI functionality with the TRE size of 64 defined in GPI driver,
>      updated QCOM_GPI_MAX_NUM_MSGS to 16 and NUM_MSGS_PER_IRQ to 4.
> 
>  drivers/dma/qcom/gpi.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

