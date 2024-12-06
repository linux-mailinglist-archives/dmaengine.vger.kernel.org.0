Return-Path: <dmaengine+bounces-3919-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A1B9E6C40
	for <lists+dmaengine@lfdr.de>; Fri,  6 Dec 2024 11:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECEA91888FD1
	for <lists+dmaengine@lfdr.de>; Fri,  6 Dec 2024 10:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15C21FCCE3;
	Fri,  6 Dec 2024 10:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cxogOW9y"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4561FC7CB;
	Fri,  6 Dec 2024 10:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733480768; cv=none; b=t9PruW1OjeSNYh0BH1e+bEpVmZgAh5gVNgV+WGtGSFQhiHur2gZAvM9nW2feBj82MBG12AC/Fzc9l5HMYhRijKaa3WSikItByTbRBTGIGSBLlQuSJmKSnk0WI93eI48QCPs/xeG6tklhDp+f/jMcYhRvJfXpRCrJF7j2Wu24IZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733480768; c=relaxed/simple;
	bh=mtX0rO0v9Qr5tY9AyUhwOp5NS4mAz7OpQ/6YiP6Xj38=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=l8r5u3oKYYHEozSZhiK/9qwcKc3RgUkZvnweRiowwRFAL0H9WDXv1ywEPnG3quWm5INJofgvbsbQpvQUTQuK07TVThanrhZqUc0BBjRoZz7nPSb+6HXSiIf5PBkhCVwQONMWnwh3OX5jgXyxUHf5cQ2F5SAUzZnZx4FTcSdc7+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cxogOW9y; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B67YSVt016410;
	Fri, 6 Dec 2024 10:26:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eLUqCUSJcdvzLlfkVoGdNf59nixxVLQSqU8fZf7JFY4=; b=cxogOW9ydgKqUY+I
	SRh5BwXsSxM+ljKN3MpHl44gAfogxrYEzlrg0x4s05MDbu6j222G4boTsfWkLg3q
	Xn2D8/OQYT94KzkdM+9sjT2N3qjCv23gKiWjq5KaKihukR5bpGo993EuvfCvdW3D
	YLxVDSa/tU3zkdBjyxVLZkgw+1oDkU3uk+yFId9WySMSi4BPxYFr4qJ9fKZlgSJT
	LXEhxV2xJzkGuiRpZTP3LR7eCR6/Co9h2CGsDHNC5Mqr8dhihWHKjOrwhTrukUxw
	zGvM3i0BHDyTQyFb+FyCIg/xQLrcwwZ0bD1WyWjS6ga5g2ENtLQQ1vgDMfRmp301
	DGD0fw==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43bbnmk8gn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Dec 2024 10:26:02 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B6AQ1YA006516
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 6 Dec 2024 10:26:01 GMT
Received: from [10.217.219.62] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 6 Dec 2024
 02:25:58 -0800
Message-ID: <09f4bb30-eec6-410d-9516-cd23f4ab79c8@quicinc.com>
Date: Fri, 6 Dec 2024 15:55:55 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] dmaengine: qcom: gpi: Add GPI immediate DMA support
 for SPI protocol
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Vinod Koul <vkoul@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_msavaliy@quicinc.com>, <quic_vtanuku@quicinc.com>
References: <20241205170611.18566-1-quic_jseerapu@quicinc.com>
 <d74ibj74mrluovh3ylok3dyctf3r4iimoosegdair5acvpre6c@w5xfl6adtfto>
Content-Language: en-US
From: Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
In-Reply-To: <d74ibj74mrluovh3ylok3dyctf3r4iimoosegdair5acvpre6c@w5xfl6adtfto>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: QL-7P0X3knFbBj-PdpO4wgJhWnQu0DQ3
X-Proofpoint-GUID: QL-7P0X3knFbBj-PdpO4wgJhWnQu0DQ3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 spamscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 adultscore=0 clxscore=1015 phishscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412060075



On 12/5/2024 10:46 PM, Dmitry Baryshkov wrote:
> On Thu, Dec 05, 2024 at 10:36:11PM +0530, Jyothi Kumar Seerapu wrote:
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
>>
>> v3 -> v4:
>>     - Instead using extra variable(immediate_dma) for Immediate dma
>>       condition check, made it to inlined.
>>     - Removed the extra brackets around Immediate dma condition check.
>>
>>     Link to v3:
>> 	https://lore.kernel.org/lkml/20241204122059.24239-1-quic_jseerapu@quicinc.com/
>>
>> v2 -> v3:
>>     - When to enable Immediate DMA support, control is moved to GPI driver
>>       from SPI driver.
>>     - Optimizations are done in GPI driver related to immediate dma changes.
>>     - Removed the immediate dma supported changes in qcom-gpi-dma.h file
>>       and handled in GPI driver.
>>
>>     Link to v2:
>> 	https://lore.kernel.org/all/20241128133351.24593-2-quic_jseerapu@quicinc.com/
>> 	https://lore.kernel.org/all/20241128133351.24593-3-quic_jseerapu@quicinc.com/
>>
>> v1 -> v2:
>>     - Separated the patches to dmaengine and spi subsystems
>>     - Removed the changes which are not required for this feature from
>>       qcom-gpi-dma.h file.
>>     - Removed the type conversions used in gpi_create_spi_tre.
>>
>>     Link to v1:
>> 	https://lore.kernel.org/lkml/20241121115201.2191-2-quic_jseerapu@quicinc.com/
>>
>>   drivers/dma/qcom/gpi.c | 31 ++++++++++++++++++++++++++-----
>>   1 file changed, 26 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
>> index 52a7c8f2498f..9d4fc760bbe6 100644
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
>> @@ -1711,6 +1713,7 @@ static int gpi_create_spi_tre(struct gchan *chan, struct gpi_desc *desc,
>>   	dma_addr_t address;
>>   	struct gpi_tre *tre;
>>   	unsigned int i;
>> +	int len;
>>   
>>   	/* first create config tre if applicable */
>>   	if (direction == DMA_MEM_TO_DEV && spi->set_config) {
>> @@ -1763,14 +1766,32 @@ static int gpi_create_spi_tre(struct gchan *chan, struct gpi_desc *desc,
>>   	tre_idx++;
>>   
>>   	address = sg_dma_address(sgl);
>> -	tre->dword[0] = lower_32_bits(address);
>> -	tre->dword[1] = upper_32_bits(address);
>> +	len = sg_dma_len(sgl);
>>   
>> -	tre->dword[2] = u32_encode_bits(sg_dma_len(sgl), TRE_DMA_LEN);
>> +	/* Support Immediate dma for write transfers for data length up to 8 bytes */
>> +	if (direction == DMA_MEM_TO_DEV && len <= 2 * sizeof(tre->dword[0])) {
>> +		/*
>> +		 * For Immediate dma, data length may not always be length of 8 bytes,
>> +		 * it can be length less than 8, hence initialize both dword's with 0
>> +		 */
>> +		tre->dword[0] = 0;
>> +		tre->dword[1] = 0;
>> +		memcpy(&tre->dword[0], sg_virt(sgl), len);
>> +
>> +		tre->dword[2] = u32_encode_bits(len, TRE_DMA_IMMEDIATE_LEN);
>> +	} else {
>> +		tre->dword[0] = lower_32_bits(address);
>> +		tre->dword[1] = upper_32_bits(address);
>> +
>> +		tre->dword[2] = u32_encode_bits(len, TRE_DMA_LEN);
>> +	}
>>   
>>   	tre->dword[3] = u32_encode_bits(TRE_TYPE_DMA, TRE_FLAGS_TYPE);
>> -	if (direction == DMA_MEM_TO_DEV)
>> -		tre->dword[3] |= u32_encode_bits(1, TRE_FLAGS_IEOT);
>> +	tre->dword[3] |= u32_encode_bits(direction == DMA_MEM_TO_DEV &&
>> +					 len <= 2 * sizeof(tre->dword[0]),
>> +					 TRE_FLAGS_IMMEDIATE_DMA);
> 
> Don't repeat the condition, put it inside if.
Moving logic of setting "TRE_FLAGS_IMMEDIATE_DMA" to inside 'if' causes 
this flag(16th bit) to overwrite due to "u32_encode_bits(TRE_TYPE_DMA, 
TRE_FLAGS_TYPE)" operation.

And so, instead using "TRE_TYPE_DMA" + "TRE_FLAGS_IMMEDIATE_DMA" for 
immediate dma type, will define separate macro "TRE_TYPE_IMMEDIATE_DMA" 
with type 0x11 and use it for immediate dma operation and existing 
"TRE_TYPE_DMA" for non-immediate dma operation.
As per hardware programming guide, type 0x11 for immediate dma.

#define TRE_TYPE_DMA            0x10
#define TRE_TYPE_IMMEDIATE_DMA  0x11

Please let me know if it is fine or any improvements/suggestions here.

> 
>> +	tre->dword[3] |= u32_encode_bits(direction == DMA_MEM_TO_DEV,
>> +					 TRE_FLAGS_IEOT);
>>   
>>   	for (i = 0; i < tre_idx; i++)
>>   		dev_dbg(dev, "TRE:%d %x:%x:%x:%x\n", i, desc->tre[i].dword[0],
>> -- 
>> 2.17.1
>>
> 

