Return-Path: <dmaengine+bounces-3812-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF9B9DB8D6
	for <lists+dmaengine@lfdr.de>; Thu, 28 Nov 2024 14:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92387163668
	for <lists+dmaengine@lfdr.de>; Thu, 28 Nov 2024 13:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892C11A9B44;
	Thu, 28 Nov 2024 13:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="i2jW5Hlr"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017B41A29A;
	Thu, 28 Nov 2024 13:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732800965; cv=none; b=V6Qc6sAz11JakjJU8wH2lWXJSSeI2ONuJBKIXDyKqHQNosmhXlyyfRC6+zs0EcvkWkH4362GM4k9jmQqiadech7ViXMvbPRsKKWWi5QQcoumoDIH9lXKh1XSkfO8918fV+hoOsb1UYChizHum4l3s9cvXwTMozwKYx7mxK8WiRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732800965; c=relaxed/simple;
	bh=oeA92mO+1aSFPpE10vWThNdGQtUxwKKsGQM7cWNQPx8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=iUkOQDvDN/J9fK84dHcC9xsqI3WYUl3JuRGf1JH0LkW26WMT2OTFMqzxJBdPqMzKXzsR9TdCkCBQSSRpchdslwADAuieWZDTei8PEpcH+jpeffqeBM1pQsHLmlI9c2d9FbG3Mrep3xPPbmtFXjz9xFyYU4P34L5iCFpAEjeKBZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=i2jW5Hlr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AS9IDXO012280;
	Thu, 28 Nov 2024 13:36:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1sbpMS2lyQJTRXtdaP/okOhSVLIf3qlOOJSSmkZW2ag=; b=i2jW5HlrO7u0iRfE
	soxqbVsRtyX2cnXUtpAmkYd7eTgJRsdHkFetJG9op9gLFGGQ9WDBHvVUjNBVGopz
	T7erNDRSza5xGPxiKm+vdm4LHoX0Fzr9N3Si59w8rgTeNYOssTSLTJpXDqSeIzJA
	N01mIgDMZ+VLIAmI5Cwf18p17W1qL+gq8L9TNYJ1KhWpC6v7ugpelYLPSdKzeo+n
	Rfyebo0EVWNgSIsZeodgUn2AIiKV4e9ADiA+kZPViFBsiUaM0ETjdEIG6PK+9ckZ
	Xi5tKs4FwBBVeI/O6rB2puO4xUVrOgM/FlavFEKtz+P9AqOJrQJVxayhAxIxnN81
	EO4uvg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4366xy2t8r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Nov 2024 13:36:00 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4ASDZxkC019357
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Nov 2024 13:35:59 GMT
Received: from [10.217.219.62] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 28 Nov
 2024 05:35:57 -0800
Message-ID: <56bf2e08-e8e3-4aca-9d51-176c009bedd5@quicinc.com>
Date: Thu, 28 Nov 2024 19:05:54 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/1] Add immediate DMA support
To: Mark Brown <broonie@kernel.org>
CC: Vinod Koul <vkoul@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <quic_msavaliy@quicinc.com>,
        <quic_vtanuku@quicinc.com>
References: <20241121115201.2191-1-quic_jseerapu@quicinc.com>
 <073ae0ed-32bf-4097-850c-832cccda6b58@sirena.org.uk>
Content-Language: en-US
From: Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
In-Reply-To: <073ae0ed-32bf-4097-850c-832cccda6b58@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -rnUU1UOtHQmxV8TVMHcz_py7cSJgueq
X-Proofpoint-ORIG-GUID: -rnUU1UOtHQmxV8TVMHcz_py7cSJgueq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 adultscore=0 mlxlogscore=823
 mlxscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2411280106



On 11/21/2024 5:32 PM, Mark Brown wrote:
> On Thu, Nov 21, 2024 at 05:22:00PM +0530, Jyothi Kumar Seerapu wrote:
>> The DMA TRE(Transfer ring element) buffer contains the DMA
>> buffer address. Accessing data from this address can cause
>> significant delays in SPI transfers, which can be mitigated to
>> some extent by utilizing immediate DMA support.
> 
> Please don't send cover letters for single patches, if there is anything
> that needs saying put it in the changelog of the patch or after the ---
> if it's administrative stuff.  This reduces mail volume and ensures that
> any important information is recorded in the changelog rather than being
> lost.

Sure, thanks. will follow it for single patch.

