Return-Path: <dmaengine+bounces-3872-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FF79E2753
	for <lists+dmaengine@lfdr.de>; Tue,  3 Dec 2024 17:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47CFCB44C16
	for <lists+dmaengine@lfdr.de>; Tue,  3 Dec 2024 14:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970991F4299;
	Tue,  3 Dec 2024 14:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="L87XEI7a"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD771EE005;
	Tue,  3 Dec 2024 14:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733235340; cv=none; b=j9FzdyvYtsAvSfXP4eZIAsNUHN0OVQPsSYpriK0BGsSsQ03mDQPg9YugzUg0+a66cGCJWjLNi8ofYKA7JA26MK04wAsqVYCnr0fl2bsRbMtWN0DA86TEz2qcF3YX4+prd57T+7zga7VUxc8KBWXW8kW7pRs5fUNQATczyCVZMlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733235340; c=relaxed/simple;
	bh=sSZgVKzREHNegVfqpBOFfbvqvtDnMDQojEWkRWd8rDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fG83x7IcreDYLuVPLISHM1kDdWOCJ1KAIfZzY8yGhI4yQ4amXG8zVuYic6kSCnRE26SAPFdIpLG+EXjHN2+i/w5qbxBwssdm2k2So2iPimyIwSZv0K8UQWpVOE0zAk5NSLLG0ahrLj2Ia5uMOy8Vo6gjpHfhRPR38gGUvqWGqf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=L87XEI7a; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B373XdD030964;
	Tue, 3 Dec 2024 14:15:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bgC+VJOxitckbULFZ9hDXbCA0nOETHhbU4U+gAUeP9g=; b=L87XEI7aEXa/y0rG
	FS8REU97yU8v3Xr4rYJudMQonh3GLpp86AUq0DqiMvpEFqJSdnUeamQrngm3JTn6
	uyp9PTvoxqxS5+tcMNSF68ytAJahsLTEg4/evTirxXGxLTQA21kwZmSOid2Ii61s
	L9fJ1B/2LSAR8T8I/xoHf6LJaCRiPAHjtlD8xp3VM0gkoDxTPHph8L+le/43ZIgu
	ZwdWpR+mxz3+gBubfROk+/9bpja4fCY4WjTqXc1oxttSlsUjYFfYxN+ALRw1eOCw
	rjSnSUpd6kSfWceRM+U5hkIhO+KWEDmlgbmKVPfknZZdH8x18DktnMwJNiDVzr3Z
	dhiWoQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 439w90s25x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Dec 2024 14:15:34 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B3EFXUU012351
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 3 Dec 2024 14:15:33 GMT
Received: from [10.217.219.62] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 3 Dec 2024
 06:15:30 -0800
Message-ID: <9bcbc281-f430-4eb9-8fa1-157a966fd5f5@quicinc.com>
Date: Tue, 3 Dec 2024 19:45:28 +0530
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
X-Proofpoint-ORIG-GUID: NCoz5xeUkwXVm8kEnKlJEVH-Mj8oMgJ8
X-Proofpoint-GUID: NCoz5xeUkwXVm8kEnKlJEVH-Mj8oMgJ8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 impostorscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412030121



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
> [1] Compare "all transfers of length 8 or less, which are mem to device"
> vs "all transfers which are mem to device, with a length of 8 or less".
> The bigger "selection criteria" is the direction, then that's fine tuned
> by the length query.
> 
>> +		buf = sg_virt(sgl);
> 
> It's a question of style, but I think you could just put the sg_virt()
> directly in the memcpy() call and avoid the extra variable.
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
Sure, will correct it to initialize instead pre-fill.
> 
> 
> That said, does it matter? Will the QUP read beyond the
> TRE_DMA_IMMEDIATE_LEN bytes? If so, please put _that_ in the comment
> ("QUP reads beyond the provided len, so additional content needs to be
> cleared", or similar)

Data lengths upto 8 bytes(len <=8) can be handled using immediate dma.
QUP won't handle beyond 8 bytes in immediate dma, if more than 8 bytes 
then it process the logic mentioned in else path.

Each dword is of size 4 bytes and so in this immediate dma case, dword0 
and dword1 is used to hold 8 bytes datae. In scenarios like data size if 
lesss then 8 bytes, for example if the spi data transfer size is 4bytes 
then it will update in dword0 and dword1 might contain some garbage data 
and so make sure to initialize both dword0 and dword1 with 0 and then 
memcpy the actual spi transfer data based on the legth to the dword's.
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
> 
> 
> Perhaps you could reduce the scope of this if/else then as well, as the
> assignment of of dword[2] and dword[3] is mostly the same with and
> without immediate mode (just the one bit to enable it)
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

