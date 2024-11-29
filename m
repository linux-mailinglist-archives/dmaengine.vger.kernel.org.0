Return-Path: <dmaengine+bounces-3821-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0864F9DC2E8
	for <lists+dmaengine@lfdr.de>; Fri, 29 Nov 2024 12:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7BB6281B30
	for <lists+dmaengine@lfdr.de>; Fri, 29 Nov 2024 11:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79FFC14F135;
	Fri, 29 Nov 2024 11:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="beDvieyB"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA41132C38;
	Fri, 29 Nov 2024 11:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732879954; cv=none; b=vDrIbyxq7I/d0mr8RJfJiunHp8npysIrGblWrYVZ2k9a5F/7I/YDAsX7t+UziMUePfn1j1keJav6cw6YqJIvq7xNgYrgEAb1kTqnX1Qdfq7U1M9Nv3Od4rt4e50Sg2HiX8sXYNX0SYmwNx0Wfd6aHeCTht3XP3pzCBA7ZDz10kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732879954; c=relaxed/simple;
	bh=dLYAxPU05ap9ZtTk6YG8sQI8LbXFyNWS0TmAQPy+ua0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jJu0j0atrU6wIVi4mI4JhbQZqxktnmZioJExce3dUBF8T9/Plmcjn1J67lggDIj0vrmAhDH8MAEQfBf1rv4U6ULgTyhjTyqBghAr/HlnsyApCCIcBUOQbqsuuMzViq9psUCp4Pd9uHxH8uEerIsMr4BsEqON6GQQi8Hrg8AapLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=beDvieyB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ASLZ9TA011311;
	Fri, 29 Nov 2024 11:32:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OlFfXTyXzQb+d7HV9knMkhMhZBRlUTg1e43LvQfj5Mc=; b=beDvieyBAgZYTNRq
	OEbSChn2FipKPpNT7xoPd2EcUMkkBCMSmiDIGqoL/9t5yDFd6iwA0KgSw/WIHgF8
	/deAXC0U+MWbXqw+XfV91p+SNz5cdTB2Nl9REO1/nZug2vKLKVFpLhPA4c9+MNg4
	/nHukT1pWb07vLSnvW9+7hiWWl42VOnVYo+5+K6Zy9oljqMdElOAKU25wot+q3aP
	bpfu9B9YYU/1XkYSMqpiWKOtse27fUJHv8xS2G9wCybLiMyQ3jVeFu2jVvYpB40T
	hrDF8Rv/SVtBZHj8NUEHjbLA4oi6F4CoC+7kcEnerHCdoyU8yZivHcDL+Ymf9m/H
	UL1x6Q==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4366xw5esr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Nov 2024 11:32:29 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4ATBWT8D006644
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Nov 2024 11:32:29 GMT
Received: from [10.216.24.185] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 29 Nov
 2024 03:32:25 -0800
Message-ID: <1666035c-d674-43dd-bc33-83231d64e5f7@quicinc.com>
Date: Fri, 29 Nov 2024 17:02:22 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dmaengine: qcom: gpi: Add GPI immediate DMA
 support
To: Bjorn Andersson <andersson@kernel.org>
CC: Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <quic_msavaliy@quicinc.com>, <quic_vtanuku@quicinc.com>
References: <20241128133351.24593-1-quic_jseerapu@quicinc.com>
 <20241128133351.24593-2-quic_jseerapu@quicinc.com>
 <obv72hhaqvremd7b4c4efpqv6vy7blz54upwc7jqx3pvrzg24t@zebke7igb3nl>
Content-Language: en-US
From: Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
In-Reply-To: <obv72hhaqvremd7b4c4efpqv6vy7blz54upwc7jqx3pvrzg24t@zebke7igb3nl>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: cK7wonPNjpNQBFBnIeWVEMt0JqKca5n6
X-Proofpoint-ORIG-GUID: cK7wonPNjpNQBFBnIeWVEMt0JqKca5n6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 bulkscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2411290094



On 11/28/2024 8:53 PM, Bjorn Andersson wrote:
> On Thu, Nov 28, 2024 at 07:03:50PM +0530, Jyothi Kumar Seerapu wrote:
>> The DMA TRE(Transfer ring element) buffer contains the DMA
>> buffer address. Accessing data from this address can cause
>> significant delays in SPI transfers, which can be mitigated to
>> some extent by utilizing immediate DMA support.
>>
>> QCOM GPI DMA hardware supports an immediate DMA feature for data
>> up to 8 bytes, storing the data directly in the DMA TRE buffer
>> instead of the DMA buffer address. This enhancement enables faster
>> SPI data transfers.
>>
>> This optimization reduces the average transfer time from 25 us to
>> 16 us for a single SPI transfer of 8 bytes length, with a clock
>> frequency of 50 MHz.
>>
>> Signed-off-by: Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
>> ---
>> v1 -> v2:
>>     - Separated the patches to dmaengine and spi subsystems
>>     - Removed the changes which are not required for this feature from
>>       qcom-gpi-dma.h file.
>>     - Removed the type conversions used in gpi_create_spi_tre.
>>
>>   drivers/dma/qcom/gpi.c           | 32 +++++++++++++++++++++++++++-----
>>   include/linux/dma/qcom-gpi-dma.h |  6 ++++++
>>   2 files changed, 33 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
>> index 52a7c8f2498f..4c5df696ddd8 100644
>> --- a/drivers/dma/qcom/gpi.c
>> +++ b/drivers/dma/qcom/gpi.c
>> @@ -27,6 +27,7 @@
>>   #define TRE_FLAGS_IEOT		BIT(9)
>>   #define TRE_FLAGS_BEI		BIT(10)
>>   #define TRE_FLAGS_LINK		BIT(11)
>> +#define TRE_FLAGS_IMMEDIATE_DMA	BIT(16)
>>   #define TRE_FLAGS_TYPE		GENMASK(23, 16)
>>   
>>   /* SPI CONFIG0 WD0 */
>> @@ -64,6 +65,7 @@
>>   
>>   /* DMA TRE */
>>   #define TRE_DMA_LEN		GENMASK(23, 0)
>> +#define TRE_DMA_IMMEDIATE_LEN	GENMASK(3, 0)
>>   
>>   /* Register offsets from gpi-top */
>>   #define GPII_n_CH_k_CNTXT_0_OFFS(n, k)	(0x20000 + (0x4000 * (n)) + (0x80 * (k)))
>> @@ -1711,6 +1713,8 @@ static int gpi_create_spi_tre(struct gchan *chan, struct gpi_desc *desc,
>>   	dma_addr_t address;
>>   	struct gpi_tre *tre;
>>   	unsigned int i;
>> +	u8 *buf;
>> +	int len = 0;
> 
> First use of "len" is an assignment, so you shouldn't zero-initialize it
> here.
Sure, will do it in V3.
> 
>>   
>>   	/* first create config tre if applicable */
>>   	if (direction == DMA_MEM_TO_DEV && spi->set_config) {
>> @@ -1763,14 +1767,32 @@ static int gpi_create_spi_tre(struct gchan *chan, struct gpi_desc *desc,
>>   	tre_idx++;
>>   
>>   	address = sg_dma_address(sgl);
>> -	tre->dword[0] = lower_32_bits(address);
>> -	tre->dword[1] = upper_32_bits(address);
>> +	len = sg_dma_len(sgl);
>>   
>> -	tre->dword[2] = u32_encode_bits(sg_dma_len(sgl), TRE_DMA_LEN);
>> +	/* Support Immediate dma for write transfers for data length up to 8 bytes */
> 
> And what happens if the developer writing the SPI driver forgets to read
> this comment and sets QCOM_GPI_IMMEDIATE_DMA for a 9 byte transfer?
In V2 patch, QCOM_GPI_IMMEDIATE_DMA is set based on 
QCOM_GPI_IMMEDIATE_DMA_LEN only.

As per Hardware programming guide, immediate dma support is for up to 8 
bytes only.
Need to check what is the behavior if we want to handle 9 bytes using 
immediate dma feature support.

> 
>> +	if ((spi->flags & QCOM_GPI_IMMEDIATE_DMA) && direction == DMA_MEM_TO_DEV) {
> 
> Why is this flag introduced?
> 
> If I understand the next patch, all DMA_MEM_TO_DEV transfers of <=
> QCOM_GPI_IMMEDIATE_DMA_LEN can use the immediate mode, so why not move
> the condition here?
> 
> Also ordering[1].
> 
> 	if (direction == DMA_MEM_TO_DEV && len <= 2 * sizeof(tre->dword[0]))
> 
> 
Sure, thanks for the suggestion.
so, instead using "QCOM_GPI_IMMEDIATE_DMA_LEN" need to use " 2 * 
sizeof(tre->dword[0])" for 8 bytes length check.

> [1] Compare "all transfers of length 8 or less, which are mem to device"
> vs "all transfers which are mem to device, with a length of 8 or less".
> The bigger "selection criteria" is the direction, then that's fine tuned
> by the length query.
> 
>> +		buf = sg_virt(sgl);
> 
> It's a question of style, but I think you could just put the sg_virt()
> directly in the memcpy() call and avoid the extra variable.

Okay, i will directly put sg_virt() in memcpy().
> 
>>   
>> -	tre->dword[3] = u32_encode_bits(TRE_TYPE_DMA, TRE_FLAGS_TYPE);
>> -	if (direction == DMA_MEM_TO_DEV)
>> +		/* memcpy may not always be length of 8, hence pre-fill both dword's with 0 */
> 
> The implementation of memcpy() is always more than 8 bytes, it's buf
> that might be less than 8 bytes ;)
> 
> Also you're not "pre-filling", you're "zero-initializing", or just
> "initialize".
Okay, i will update it in V3.
> 
> 
> That said, does it matter? Will the QUP read beyond the
> TRE_DMA_IMMEDIATE_LEN bytes? If so, please put _that_ in the comment
> ("QUP reads beyond the provided len, so additional content needs to be
> cleared", or similar)
Okay, i will update it in V3.

> 
>> +		tre->dword[0] = 0;
>> +		tre->dword[1] = 0;
>> +		memcpy(&tre->dword[0], buf, len);
>> +
>> +		tre->dword[2] = u32_encode_bits(len, TRE_DMA_IMMEDIATE_LEN);
> 
> Does the format of tre->dword[2] really change when
> TRE_FLAGS_IMMEDIATE_DMA is set, or is TRE_DMA_IMMEDIATE_LEN just a
> mask to highlight that len can't be more than 4 bits?
> 
> It seems like you could drop TRE_DMA_IMMEDIATE_LEN and just use
> TRE_DMA_LEN here? (But it should match what the hardware programming
> guide states)
As per hardware programming guide, for Immediate dma, in dword2 length 
should be 4 bytes only and so need to use TRE_DMA_IMMEDIATE_LEN .
> 
> 
> Perhaps you could reduce the scope of this if/else then as well, as the
> assignment of of dword[2] and dword[3] is mostly the same with and
> without immediate mode (just the one bit to enable it)
sure, will check it and update in V3.
> 
>> +
>> +		tre->dword[3] = u32_encode_bits(TRE_TYPE_DMA, TRE_FLAGS_TYPE);
>>   		tre->dword[3] |= u32_encode_bits(1, TRE_FLAGS_IEOT);
>> +		tre->dword[3] |= u32_encode_bits(1, TRE_FLAGS_IMMEDIATE_DMA);
>> +	} else {
>> +		tre->dword[0] = lower_32_bits(address);
>> +		tre->dword[1] = upper_32_bits(address);
>> +
>> +		tre->dword[2] = u32_encode_bits(len, TRE_DMA_LEN);
>> +
>> +		tre->dword[3] = u32_encode_bits(TRE_TYPE_DMA, TRE_FLAGS_TYPE);
>> +		if (direction == DMA_MEM_TO_DEV)
>> +			tre->dword[3] |= u32_encode_bits(1, TRE_FLAGS_IEOT);
>> +	}
>>   
>>   	for (i = 0; i < tre_idx; i++)
>>   		dev_dbg(dev, "TRE:%d %x:%x:%x:%x\n", i, desc->tre[i].dword[0],
>> diff --git a/include/linux/dma/qcom-gpi-dma.h b/include/linux/dma/qcom-gpi-dma.h
>> index 6680dd1a43c6..84598848d53a 100644
>> --- a/include/linux/dma/qcom-gpi-dma.h
>> +++ b/include/linux/dma/qcom-gpi-dma.h
>> @@ -15,6 +15,10 @@ enum spi_transfer_cmd {
>>   	SPI_DUPLEX,
>>   };
>>   
>> +#define QCOM_GPI_IMMEDIATE_DMA		BIT(1)
>> +
>> +#define QCOM_GPI_IMMEDIATE_DMA_LEN	8
>> +
>>   /**
>>    * struct gpi_spi_config - spi config for peripheral
>>    *
>> @@ -30,6 +34,7 @@ enum spi_transfer_cmd {
>>    * @cs: chip select toggle
>>    * @set_config: set peripheral config
>>    * @rx_len: receive length for buffer
>> + * @flags: true for immediate dma support
> 
> Per above I think you can remove this flag, but "true for immediate DMA
> support" doesn't match what you have written in the code. (Also in
> general u8 shouldn't be "true")

Sure, will update in V3.

Thanks for providing the review comments.
> 
> Regards,
> Bjorn
> 
>>    */
>>   struct gpi_spi_config {
>>   	u8 set_config;
>> @@ -44,6 +49,7 @@ struct gpi_spi_config {
>>   	u32 clk_src;
>>   	enum spi_transfer_cmd cmd;
>>   	u32 rx_len;
>> +	u8 flags;
>>   };
>>   
>>   enum i2c_op {
>> -- 
>> 2.17.1
>>
>>

