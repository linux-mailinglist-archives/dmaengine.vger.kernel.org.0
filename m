Return-Path: <dmaengine+bounces-6343-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA87B419D7
	for <lists+dmaengine@lfdr.de>; Wed,  3 Sep 2025 11:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 323C118896B7
	for <lists+dmaengine@lfdr.de>; Wed,  3 Sep 2025 09:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E092ECD2E;
	Wed,  3 Sep 2025 09:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jqWMLX4t"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430672877F6
	for <dmaengine@vger.kernel.org>; Wed,  3 Sep 2025 09:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756891544; cv=none; b=l48A3rOrPx4Uzen5nFSrClohKQp0qBNpJMnCFYmmX5m3Wal7a7vZ5uzj1hD12JaLPEm6pnB4Cnl+1CmM8xkpFIDtnIhvv5woCwO69ZuyO81pQv23woSX8C4/yr2CFZw17LzmFV2VINXIOZX03zGDjAPCQwPWkYuRxXpGaG/kclM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756891544; c=relaxed/simple;
	bh=G3KruQfuGQZbnwyFFVg7lnm/oURLCwtkXpoaHPhMKhA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=boWOS+P4ChtS2cP47HpwHXlflNI+Fw7rJ82UR6qOBz2dvUUZlsIeFo2p9jrUxC4mn+GSGMyYLDHU1okXc+CD0bjPlNncOaVv9Og5ihA6Gg/MY4eMAmREZG+HYAItvUMINIjVlT/PZhqZJjsCayVZ6wDJeaADgZgzD+AOpy8RRLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jqWMLX4t; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5832x6NC010139
	for <dmaengine@vger.kernel.org>; Wed, 3 Sep 2025 09:25:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=qiSfzdg4mC017dQavh2saF3D
	nvq/ylNZxxXLO3pOk3Y=; b=jqWMLX4t8mAWThwfHqlfOQL+5UkXlSPfUK0Ti7YJ
	tJunk2I2Xg/w5+Yt0BgvCAwhKQjj06lSKt3AbovqMDZO1m5oLvhz92QXlUo3H7ij
	0+kNYH/Kb6FMq5eC7zb2vwuzi8hmt4pcDYZJYZmE7dXBncAIzmeKDfEM0IG8TB8A
	E8zm9Cu5t7QBGI3nkXenmXc7jXQrCobgopq7Zha5M18tJBtQLbzgtBBEzIs/koyo
	4QHBicW8kV0eXtsvi9pNlrJ9AK8c73cW63kA9GfqVExDCgmegkq8BTQmHnuC2jtv
	ZqYQovft3xMcTrVZpK+CPabjifkiu/Z8fmsZn8XyB7WxOw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48uq0ek5a6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Wed, 03 Sep 2025 09:25:42 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-72631c2c2f7so3774226d6.0
        for <dmaengine@vger.kernel.org>; Wed, 03 Sep 2025 02:25:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756891541; x=1757496341;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qiSfzdg4mC017dQavh2saF3Dnvq/ylNZxxXLO3pOk3Y=;
        b=wcpkIWkxtBma0DQ04ZrwoYp+R/flE9m7ayODaxItlvOSladPyx58UAMqrbGdvqvElZ
         sdBM/VyE3dQ40X8I0IdrZQSrvqSf62vyDoTte9pcOeCXdDHu99X+Am9klpzLuMTMgiBc
         fNMXAS473k9WDNHPnTuMhD9cucvl0z/TVZWhhriewXm8x37KRaqJbEH0RojFG1cnnVih
         llqrLGR6QQ+xkkyzmO11UDnuzZLi/uShIxicw1aYEAO4O2KIUcfqM1h9WDW8Lea1s5Tk
         e/zBV3gDL+okRTUQaBVfxyNqGiVEMBvptsqK0+YXhI8gaIMPNTP9pKZPFqDpnzD/6xP6
         g51Q==
X-Forwarded-Encrypted: i=1; AJvYcCWq1PWTjSBOpIVLmOsKPbNMZcaiHgz0IQM/jKGY0rwZ9r07vpB+d7RY7CPe48iKfzTCmniSBeinW4U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza0w20c6KVgL4d2/nMPhf4e7zdWIeZjtGr+Sr0xVyzgb2Usp2A
	0xcf/IvDfscHzxXdRJ2urlluFKfWhmD55qkkqPZKlzRcSyui0VplTcfBwizYP6yW+n6H8CsqlTt
	X3e4+FTSXxVb5fDMnxZa6yA8Cd1Xa2/IRCYju4T+ca3RCrk1+1DtTjdrBZzzVryU=
X-Gm-Gg: ASbGncuzJyuNJp2PupXKlkHO7gfG94PSYvwAzelmR39ZMa6CsFpECWNjn2s28kv9UiH
	+RYn5A08X+sgnqo+8gw7kyzMnPoeS177/KEyKWQoHUHUiXJM0hS9yeI/SS/WyC6dHeOUCRdTWTn
	ufaX3n7t0u7+s8Xp8Z3A8bUAfyNZ3hWvrZ+dPwrXAzhZGlMv/gSB3moPOTOdvHi8E28oh9c5xYq
	AxhgmaASIwcx90MZPT4ht8Q1F+cH7elgwliJyFCTqmU0j2oDVKR3xaqItbC+8WPqTicczBEeZ/1
	7d6Tj9Uh4rjDHKXDtjAmA82INJG97n25fAkOwdENHhW5l4a+wUBRsALZpSB6fKYaro3yxo4WAU0
	mS0x1Vp3FGIOtPwWGEzCbEg+6x+GBXtwLeqtaJOV3qZmMoifk3O5M
X-Received: by 2002:a05:6214:29cd:b0:71c:53c0:564f with SMTP id 6a1803df08f44-71c53c05df2mr85543086d6.6.1756891541042;
        Wed, 03 Sep 2025 02:25:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEffBRG/vxF0pIEnmq/bDAD2fvhoCl8Yhqv0aQxeuHDILYhYTHgkBcj5YQbmS8/TtFPfMC5A==
X-Received: by 2002:a05:6214:29cd:b0:71c:53c0:564f with SMTP id 6a1803df08f44-71c53c05df2mr85542856d6.6.1756891540533;
        Wed, 03 Sep 2025 02:25:40 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608ace9c7esm390417e87.65.2025.09.03.02.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 02:25:39 -0700 (PDT)
Date: Wed, 3 Sep 2025 12:25:37 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
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
Subject: Re: [PATCH v7 1/2] dmaengine: qcom: gpi: Add GPI Block event
 interrupt support
Message-ID: <xy2jgnearfsoln7tmjbb7l6zuwm7sq74wohsxj77eeval5wig5@kisng4ufgbuo>
References: <20250903073059.2151837-1-quic_jseerapu@quicinc.com>
 <20250903073059.2151837-2-quic_jseerapu@quicinc.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903073059.2151837-2-quic_jseerapu@quicinc.com>
X-Proofpoint-GUID: eA_aXp1ptTsAqHw-DeYeUO4DqWXIwCmw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwNCBTYWx0ZWRfXz9ijy2wAcCfK
 qbFl1dl+6HUus1jHUwOLdbElOp30CawwUZug5D2gKJLvAjybJLIduXLfQdCdTPQV93OdSVG57sU
 esWEQAqiCMRSHhNVmGf3TK0zvDHgQPsX6fC7+thsnXDV0ZadkmWO9oO9f4S86IckDPwpqjA7rva
 1p3N4r9OkMgJY7xY9yJvSaawKSPoeSEkdWVUBlzDW1dxodRNgNyLHYf6NeN1fUERzyoZfHcx/z8
 pfpe/UDhJZFPA1YZM/rDBZybzqdWhdK9o42Dn63yWQuoaVmBd2ebwOZCFztQGCMG0cJr3qd3tiu
 I8xeIWWQDCsfbLvW66ZQ6wHFl3MeoWLTDD0XmAZwU0AUeJTtxsyX7hS2PHAqKqA1Uje6TNx50j9
 rJMPcgtu
X-Proofpoint-ORIG-GUID: eA_aXp1ptTsAqHw-DeYeUO4DqWXIwCmw
X-Authority-Analysis: v=2.4 cv=ea09f6EH c=1 sm=1 tr=0 ts=68b80996 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=JXAtfvraFxK_IdIfcZsA:9 a=CjuIK1q_8ugA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_05,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300004

On Wed, Sep 03, 2025 at 01:00:58PM +0530, Jyothi Kumar Seerapu wrote:
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
> This BEI mechanism enhances overall transfer efficiency.

Duplicate phrase.

> 
> Signed-off-by: Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
> ---
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
> diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
> index 8e87738086b2..66bfea1f156d 100644
> --- a/drivers/dma/qcom/gpi.c
> +++ b/drivers/dma/qcom/gpi.c
> @@ -1619,7 +1619,8 @@ gpi_peripheral_config(struct dma_chan *chan, struct dma_slave_config *config)
>  }
>  
>  static int gpi_create_i2c_tre(struct gchan *chan, struct gpi_desc *desc,
> -			      struct scatterlist *sgl, enum dma_transfer_direction direction)
> +			      struct scatterlist *sgl, enum dma_transfer_direction direction,
> +			      unsigned long flags)
>  {
>  	struct gpi_i2c_config *i2c = chan->config;
>  	struct device *dev = chan->gpii->gpi_dev->dev;
> @@ -1684,6 +1685,9 @@ static int gpi_create_i2c_tre(struct gchan *chan, struct gpi_desc *desc,
>  
>  		tre->dword[3] = u32_encode_bits(TRE_TYPE_DMA, TRE_FLAGS_TYPE);
>  		tre->dword[3] |= u32_encode_bits(1, TRE_FLAGS_IEOT);
> +
> +		if (!(flags & DMA_PREP_INTERRUPT))
> +			tre->dword[3] |= u32_encode_bits(1, TRE_FLAGS_BEI);
>  	}
>  
>  	for (i = 0; i < tre_idx; i++)
> @@ -1827,6 +1831,9 @@ gpi_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
>  		return NULL;
>  	}
>  
> +	if (!(flags & DMA_PREP_INTERRUPT) && (nr - nr_tre < 2))
> +		return NULL;

Comment in the source file.

> +
>  	gpi_desc = kzalloc(sizeof(*gpi_desc), GFP_NOWAIT);
>  	if (!gpi_desc)
>  		return NULL;
> @@ -1835,7 +1842,7 @@ gpi_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
>  	if (gchan->protocol == QCOM_GPI_SPI) {
>  		i = gpi_create_spi_tre(gchan, gpi_desc, sgl, direction);
>  	} else if (gchan->protocol == QCOM_GPI_I2C) {
> -		i = gpi_create_i2c_tre(gchan, gpi_desc, sgl, direction);
> +		i = gpi_create_i2c_tre(gchan, gpi_desc, sgl, direction, flags);
>  	} else {
>  		dev_err(dev, "invalid peripheral: %d\n", gchan->protocol);
>  		kfree(gpi_desc);
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

