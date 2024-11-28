Return-Path: <dmaengine+bounces-3813-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D62999DB8DE
	for <lists+dmaengine@lfdr.de>; Thu, 28 Nov 2024 14:37:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AC1BB22300
	for <lists+dmaengine@lfdr.de>; Thu, 28 Nov 2024 13:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1741A9B4E;
	Thu, 28 Nov 2024 13:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="TymRsEzc"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13ACB1A9B49;
	Thu, 28 Nov 2024 13:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732800994; cv=none; b=WqG9Fw2hO4CQrkUc0AYh81KBljTvzuJP2LEBVTWpSawVdAi9RLLUg7cqi+ylH7HAJwpazCyQR0grTzJEasE7Iks3CgpQbRGwbjkrY8ahnbruUeFQgUE4NqQhcNBOvPgw4k2F3vNDPC5MEjFP3KQKqBE/O8lYYcQy2TW5yzZVsg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732800994; c=relaxed/simple;
	bh=6dXn1DV1akMsaFHxE7uPcQZPLGjDGqMc8nj3NB1ZBtg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hQ6AVWM9PBaAGhPUSkkjWvnZVnalnBRI2KPdQNak+E/gZaa5C6kmbzeXdBaeeGgQW+R2fB7MY9L6c2INwZwDBVa8449YhZ6tb2e/SrgEX5Hh4itRyweb6qSjE6ePkeTcl+oed7aIGsWQq5C3QX5QBU3BXOR7Qdm9ox6ySLKnhwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=TymRsEzc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ASALqH9005786;
	Thu, 28 Nov 2024 13:36:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WmpaYwaIp1RNCn9576MN11K7LyA28i9IH3kFKhIB+wA=; b=TymRsEzc2KzN45np
	vwlgFusMEMftimFE6dH69twiU3WddYmweZ7USuBKisuHFFGvLf/7Km8Aq6YkbWvj
	erbhL+FpxlEMDmBJXUissRxIo2uXLbdxZMqbfJKoKeg0xosiqhUIwT3xOO6jJn19
	7qVYrZsn79at31UJZq9jSWK21wVJfNy9fstOy0cI7atp8UDXvUD64nC1gs7JH8C8
	0cgJxQe97HSAECATHDWQcmRjm5Xm96RflN6PdWcDtzGij/xgctt+Yn58MBcmbbQV
	xU/mS8PtTOVgLGGuEwQ3/rqxgEsF8O5glQwNWei3gDBrPYdNGVDx4IRNkAl2FKC4
	gcE2jg==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43671eatjc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Nov 2024 13:36:29 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4ASDaSBM032514
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Nov 2024 13:36:28 GMT
Received: from [10.217.219.62] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 28 Nov
 2024 05:36:25 -0800
Message-ID: <71d9e588-73eb-48c8-8efb-1ee79066092d@quicinc.com>
Date: Thu, 28 Nov 2024 19:06:22 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] spi: spi-geni-qcom: Add immediate DMA support
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <quic_msavaliy@quicinc.com>, <quic_vtanuku@quicinc.com>
References: <20241121115201.2191-1-quic_jseerapu@quicinc.com>
 <20241121115201.2191-2-quic_jseerapu@quicinc.com>
 <d2ybuvo676ouxhj2rejx6swlwkofycms2iwqsfcnwbfl3llbdr@4yoxxbmalpyf>
Content-Language: en-US
From: Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
In-Reply-To: <d2ybuvo676ouxhj2rejx6swlwkofycms2iwqsfcnwbfl3llbdr@4yoxxbmalpyf>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 4Ksl2fm4zVpKyja5xuHb1eKcUgG4hK0l
X-Proofpoint-GUID: 4Ksl2fm4zVpKyja5xuHb1eKcUgG4hK0l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 impostorscore=0 mlxscore=0 phishscore=0 priorityscore=1501 clxscore=1011
 bulkscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2411280107



On 11/22/2024 3:38 AM, Dmitry Baryshkov wrote:
> On Thu, Nov 21, 2024 at 05:22:01PM +0530, Jyothi Kumar Seerapu wrote:
>> The DMA TRE(Transfer ring element) buffer contains the DMA
>> buffer address. Accessing data from this address can cause
>> significant delays in SPI transfers, which can be mitigated to
>> some extent by utilizing immediate DMA support.
>>
>> QCOM GPI DMA hardware supports an immediate DMA feature for data
>> up to 8 bytes, storing the data directly in the DMA TRE buffer
>> instead of the DMA buffer address. This enhancement enables faster
>> SPI data transfers.
> 
> Is it supported on all GPI DMA platforms, starting from SDM845?
Yes, it supported on all GPI DMA platforms.
> 
>>
>> This optimization reduces the average transfer time from 25 us to
>> 16 us for a single SPI transfer of 8 bytes length, with a clock
>> frequency of 50 MHz.
>>
>> Signed-off-by: Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
>> ---
>>   drivers/dma/qcom/gpi.c           | 32 +++++++++++++++++++++++++++-----
>>   drivers/spi/spi-geni-qcom.c      |  7 +++++++
>>   include/linux/dma/qcom-gpi-dma.h |  7 +++++++
> 
> How is this supposed to be merged? Please try to separate the patches by
> the subsystem, letting maintainers to handle possible dependencies.
> 
Sure, separated  the patches in V2.
>>   3 files changed, 41 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
>> index 52a7c8f2498f..a8df1e835e27 100644
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
>> +	if ((spi->flags & QCOM_GPI_IMMEDIATE_DMA) && direction == DMA_MEM_TO_DEV) {
>> +		buf = (u8 *)sg_virt(sgl);
>>   
>> -	tre->dword[3] = u32_encode_bits(TRE_TYPE_DMA, TRE_FLAGS_TYPE);
>> -	if (direction == DMA_MEM_TO_DEV)
>> +		/* memcpy may not always be length of 8, hence pre-fill both dword's with 0 */
>> +		tre->dword[0] = 0;
>> +		tre->dword[1] = 0;
>> +		memcpy((u8 *)&tre->dword[0], buf, len);
> 
> Drop all type conversions, they should not be necessary. memcpy()
> functions accepts void pointers.
Done
> 
>> +
>> +		tre->dword[2] = u32_encode_bits(len, TRE_DMA_IMMEDIATE_LEN);
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
>> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
>> index 768d7482102a..53c8f6b7f3c5 100644
>> --- a/drivers/spi/spi-geni-qcom.c
>> +++ b/drivers/spi/spi-geni-qcom.c
>> @@ -472,11 +472,18 @@ static int setup_gsi_xfer(struct spi_transfer *xfer, struct spi_geni_master *mas
>>   		mas->cur_speed_hz = xfer->speed_hz;
>>   	}
>>   
>> +	/*
>> +	 * Set QCOM_GPI_IMMEDIATE_DMA flag if transfer length up to 8 bytes.
>> +	 */
>>   	if (xfer->tx_buf && xfer->rx_buf) {
>>   		peripheral.cmd = SPI_DUPLEX;
>> +		if (xfer->len <= QCOM_GPI_IMMEDIATE_DMA_LEN)
>> +			peripheral.flags |= QCOM_GPI_IMMEDIATE_DMA;
>>   	} else if (xfer->tx_buf) {
>>   		peripheral.cmd = SPI_TX;
>>   		peripheral.rx_len = 0;
>> +		if (xfer->len <= QCOM_GPI_IMMEDIATE_DMA_LEN)
>> +			peripheral.flags |= QCOM_GPI_IMMEDIATE_DMA;
>>   	} else if (xfer->rx_buf) {
>>   		peripheral.cmd = SPI_RX;
>>   		if (!(mas->cur_bits_per_word % MIN_WORD_LEN)) {
>> diff --git a/include/linux/dma/qcom-gpi-dma.h b/include/linux/dma/qcom-gpi-dma.h
>> index 6680dd1a43c6..0eb96e62a1f1 100644
>> --- a/include/linux/dma/qcom-gpi-dma.h
>> +++ b/include/linux/dma/qcom-gpi-dma.h
>> @@ -15,6 +15,11 @@ enum spi_transfer_cmd {
>>   	SPI_DUPLEX,
>>   };
>>   
>> +#define QCOM_GPI_BLOCK_EVENT_IRQ	BIT(0)
> 
> Unrelated, please drop.
Sure, done.
> 
>> +#define QCOM_GPI_IMMEDIATE_DMA		BIT(1)
> 
> Can GPI driver deduce whether it should use immediate DMA based on the
> transfer length?
protocol driver like SPI will update whether it should use immediate DMA 
or not based on the transfer length and GPI driver will configure it 
accordingly .
> 
>> +
>> +#define QCOM_GPI_IMMEDIATE_DMA_LEN	8
>> +
>>   /**
>>    * struct gpi_spi_config - spi config for peripheral
>>    *
>> @@ -30,6 +35,7 @@ enum spi_transfer_cmd {
>>    * @cs: chip select toggle
>>    * @set_config: set peripheral config
>>    * @rx_len: receive length for buffer
>> + * @flags: flags for immediate dma and block event interrupt support
>>    */
>>   struct gpi_spi_config {
>>   	u8 set_config;
>> @@ -44,6 +50,7 @@ struct gpi_spi_config {
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
> 

