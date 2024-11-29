Return-Path: <dmaengine+bounces-3819-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF799DC28E
	for <lists+dmaengine@lfdr.de>; Fri, 29 Nov 2024 12:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06A7116226D
	for <lists+dmaengine@lfdr.de>; Fri, 29 Nov 2024 11:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916FD1990C5;
	Fri, 29 Nov 2024 11:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KU1NGAmr"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746DA155726;
	Fri, 29 Nov 2024 11:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732878788; cv=none; b=fbsPM0KZi1cAflHyBCxwCIBA+H5OLp88DTyGVPJMgl9rLH9upYhRUMgzRE/PBoE289mE9QK8qpbv7d3jD0Ve/C6srcWmgTls0rRt8Drjavji3z1ep4lU/V+BSxTmHdxdEnX3cuXVRC/jcAMo80cvTEu9aSXnZyZnG+n9agwsGMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732878788; c=relaxed/simple;
	bh=FZiUn4NJagM0lB9c4LCcyGuSyiPTtNSe0J05M3v3Ayg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Wt6bXRObOs7UqS8ysu0/sDm2czDD2X+3RXQpvrm8gb9AKho32LB18rvB4lnQtllMZ8+qMLmviJi3JA/QOYtRsUjTOsO5mYaHHpevogNIw89nNXyN0wzQjzKzeYmEH9obqpEWyEcwdhDSp3U9XAznkHlq1aT/OBhls/CPz5yymD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KU1NGAmr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ASNVOUd005357;
	Fri, 29 Nov 2024 11:13:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2+Z4ZHIEsn9Y1D4pKbrPvvdS2e/HpZYhbeKKUzJZl8A=; b=KU1NGAmr55e/xZT9
	IKJDdQPRl6KOTIxpJPmU0OwwIMn+V01xfGvHXj/VYVLdq/HjmDC/U6rzsINuorRf
	/pwKszH9L3e7+EqKkEfcemApTyhZroNZsR9a1RUaeC/PQk65rA+CEFI96SuhN+eZ
	l7OPMDQooJ1yjN/mUWPOKrnZfP3pcJzNVZJAGt5QeBvWUdjVeUleNSNUFTyaykEn
	SnpV/apJrGfTGiQoYpTO4DqBwZAiYrI0ggH9HQuNzBTnniJLhdtYXcw+WTwVG+5I
	HOxauROoFVkUB7DFGvJsrivakXj9UYhpp8wwwVyxYqY6dvMSn+pGFkSkh8DedZBT
	82/Dxg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 436h2mm1g6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Nov 2024 11:13:01 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4ATBD0Oo010185
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Nov 2024 11:13:00 GMT
Received: from [10.216.24.185] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 29 Nov
 2024 03:12:57 -0800
Message-ID: <b131a208-acff-41d2-bf8b-7d4ee4e4feb4@quicinc.com>
Date: Fri, 29 Nov 2024 16:42:53 +0530
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
 <71d9e588-73eb-48c8-8efb-1ee79066092d@quicinc.com>
 <wndlbjorghg5tilcoiv47vmxw44euitpomvmlgwqdjwvlhxiy5@jzade5xterdl>
Content-Language: en-US
From: Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
In-Reply-To: <wndlbjorghg5tilcoiv47vmxw44euitpomvmlgwqdjwvlhxiy5@jzade5xterdl>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4C7YpGmqjf2t5scqZ7LTKTsACXzZ8ovD
X-Proofpoint-ORIG-GUID: 4C7YpGmqjf2t5scqZ7LTKTsACXzZ8ovD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 mlxscore=0 impostorscore=0 clxscore=1011
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2411290092



On 11/28/2024 7:32 PM, Dmitry Baryshkov wrote:
> On Thu, Nov 28, 2024 at 07:06:22PM +0530, Jyothi Kumar Seerapu wrote:
>>
>>
>> On 11/22/2024 3:38 AM, Dmitry Baryshkov wrote:
>>> On Thu, Nov 21, 2024 at 05:22:01PM +0530, Jyothi Kumar Seerapu wrote:
>>>> The DMA TRE(Transfer ring element) buffer contains the DMA
>>>> buffer address. Accessing data from this address can cause
>>>> significant delays in SPI transfers, which can be mitigated to
>>>> some extent by utilizing immediate DMA support.
>>>>
>>>> QCOM GPI DMA hardware supports an immediate DMA feature for data
>>>> up to 8 bytes, storing the data directly in the DMA TRE buffer
>>>> instead of the DMA buffer address. This enhancement enables faster
>>>> SPI data transfers.
>>>
>>> Is it supported on all GPI DMA platforms, starting from SDM845?
>> Yes, it supported on all GPI DMA platforms.
>>>
>>>>
>>>> This optimization reduces the average transfer time from 25 us to
>>>> 16 us for a single SPI transfer of 8 bytes length, with a clock
>>>> frequency of 50 MHz.
>>>>
>>>> Signed-off-by: Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
>>>> ---
>>>>    drivers/dma/qcom/gpi.c           | 32 +++++++++++++++++++++++++++-----
>>>>    drivers/spi/spi-geni-qcom.c      |  7 +++++++
>>>>    include/linux/dma/qcom-gpi-dma.h |  7 +++++++
>>>
>>> How is this supposed to be merged? Please try to separate the patches by
>>> the subsystem, letting maintainers to handle possible dependencies.
>>>
>> Sure, separated  the patches in V2.
>>>>    3 files changed, 41 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
>>>> index 52a7c8f2498f..a8df1e835e27 100644
>>>> --- a/drivers/dma/qcom/gpi.c
>>>> +++ b/drivers/dma/qcom/gpi.c
>>>> @@ -27,6 +27,7 @@
>>>>    #define TRE_FLAGS_IEOT		BIT(9)
>>>>    #define TRE_FLAGS_BEI		BIT(10)
>>>>    #define TRE_FLAGS_LINK		BIT(11)
>>>> +#define TRE_FLAGS_IMMEDIATE_DMA	BIT(16)
>>>>    #define TRE_FLAGS_TYPE		GENMASK(23, 16)
>>>>    /* SPI CONFIG0 WD0 */
>>>> @@ -64,6 +65,7 @@
>>>>    /* DMA TRE */
>>>>    #define TRE_DMA_LEN		GENMASK(23, 0)
>>>> +#define TRE_DMA_IMMEDIATE_LEN	GENMASK(3, 0)
>>>>    /* Register offsets from gpi-top */
>>>>    #define GPII_n_CH_k_CNTXT_0_OFFS(n, k)	(0x20000 + (0x4000 * (n)) + (0x80 * (k)))
>>>> @@ -1711,6 +1713,8 @@ static int gpi_create_spi_tre(struct gchan *chan, struct gpi_desc *desc,
>>>>    	dma_addr_t address;
>>>>    	struct gpi_tre *tre;
>>>>    	unsigned int i;
>>>> +	u8 *buf;
>>>> +	int len = 0;
>>>>    	/* first create config tre if applicable */
>>>>    	if (direction == DMA_MEM_TO_DEV && spi->set_config) {
>>>> @@ -1763,14 +1767,32 @@ static int gpi_create_spi_tre(struct gchan *chan, struct gpi_desc *desc,
>>>>    	tre_idx++;
>>>>    	address = sg_dma_address(sgl);
>>>> -	tre->dword[0] = lower_32_bits(address);
>>>> -	tre->dword[1] = upper_32_bits(address);
>>>> +	len = sg_dma_len(sgl);
>>>> -	tre->dword[2] = u32_encode_bits(sg_dma_len(sgl), TRE_DMA_LEN);
>>>> +	/* Support Immediate dma for write transfers for data length up to 8 bytes */
>>>> +	if ((spi->flags & QCOM_GPI_IMMEDIATE_DMA) && direction == DMA_MEM_TO_DEV) {
>>>> +		buf = (u8 *)sg_virt(sgl);
>>>> -	tre->dword[3] = u32_encode_bits(TRE_TYPE_DMA, TRE_FLAGS_TYPE);
>>>> -	if (direction == DMA_MEM_TO_DEV)
>>>> +		/* memcpy may not always be length of 8, hence pre-fill both dword's with 0 */
>>>> +		tre->dword[0] = 0;
>>>> +		tre->dword[1] = 0;
>>>> +		memcpy((u8 *)&tre->dword[0], buf, len);
>>>
>>> Drop all type conversions, they should not be necessary. memcpy()
>>> functions accepts void pointers.
>> Done
>>>
>>>> +
>>>> +		tre->dword[2] = u32_encode_bits(len, TRE_DMA_IMMEDIATE_LEN);
>>>> +
>>>> +		tre->dword[3] = u32_encode_bits(TRE_TYPE_DMA, TRE_FLAGS_TYPE);
>>>>    		tre->dword[3] |= u32_encode_bits(1, TRE_FLAGS_IEOT);
>>>> +		tre->dword[3] |= u32_encode_bits(1, TRE_FLAGS_IMMEDIATE_DMA);
>>>> +	} else {
>>>> +		tre->dword[0] = lower_32_bits(address);
>>>> +		tre->dword[1] = upper_32_bits(address);
>>>> +
>>>> +		tre->dword[2] = u32_encode_bits(len, TRE_DMA_LEN);
>>>> +
>>>> +		tre->dword[3] = u32_encode_bits(TRE_TYPE_DMA, TRE_FLAGS_TYPE);
>>>> +		if (direction == DMA_MEM_TO_DEV)
>>>> +			tre->dword[3] |= u32_encode_bits(1, TRE_FLAGS_IEOT);
>>>> +	}
>>>>    	for (i = 0; i < tre_idx; i++)
>>>>    		dev_dbg(dev, "TRE:%d %x:%x:%x:%x\n", i, desc->tre[i].dword[0],
>>>> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
>>>> index 768d7482102a..53c8f6b7f3c5 100644
>>>> --- a/drivers/spi/spi-geni-qcom.c
>>>> +++ b/drivers/spi/spi-geni-qcom.c
>>>> @@ -472,11 +472,18 @@ static int setup_gsi_xfer(struct spi_transfer *xfer, struct spi_geni_master *mas
>>>>    		mas->cur_speed_hz = xfer->speed_hz;
>>>>    	}
>>>> +	/*
>>>> +	 * Set QCOM_GPI_IMMEDIATE_DMA flag if transfer length up to 8 bytes.
>>>> +	 */
>>>>    	if (xfer->tx_buf && xfer->rx_buf) {
>>>>    		peripheral.cmd = SPI_DUPLEX;
>>>> +		if (xfer->len <= QCOM_GPI_IMMEDIATE_DMA_LEN)
>>>> +			peripheral.flags |= QCOM_GPI_IMMEDIATE_DMA;
>>>>    	} else if (xfer->tx_buf) {
>>>>    		peripheral.cmd = SPI_TX;
>>>>    		peripheral.rx_len = 0;
>>>> +		if (xfer->len <= QCOM_GPI_IMMEDIATE_DMA_LEN)
>>>> +			peripheral.flags |= QCOM_GPI_IMMEDIATE_DMA;
>>>>    	} else if (xfer->rx_buf) {
>>>>    		peripheral.cmd = SPI_RX;
>>>>    		if (!(mas->cur_bits_per_word % MIN_WORD_LEN)) {
>>>> diff --git a/include/linux/dma/qcom-gpi-dma.h b/include/linux/dma/qcom-gpi-dma.h
>>>> index 6680dd1a43c6..0eb96e62a1f1 100644
>>>> --- a/include/linux/dma/qcom-gpi-dma.h
>>>> +++ b/include/linux/dma/qcom-gpi-dma.h
>>>> @@ -15,6 +15,11 @@ enum spi_transfer_cmd {
>>>>    	SPI_DUPLEX,
>>>>    };
>>>> +#define QCOM_GPI_BLOCK_EVENT_IRQ	BIT(0)
>>>
>>> Unrelated, please drop.
>> Sure, done.
>>>
>>>> +#define QCOM_GPI_IMMEDIATE_DMA		BIT(1)
>>>
>>> Can GPI driver deduce whether it should use immediate DMA based on the
>>> transfer length?
>> protocol driver like SPI will update whether it should use immediate DMA or
>> not based on the transfer length and GPI driver will configure it
>> accordingly .
> 
> You are describing your implementation. I asked if it is possible to be
> implemented other way around. Otherwise you are adding too much
> knowledge to the SPI driver.

Yeah got it.
It is possible to check in GPI driver only whether to use immediate DMA 
and handle it.
> 
>>>
>>>> +
>>>> +#define QCOM_GPI_IMMEDIATE_DMA_LEN	8
>>>> +
>>>>    /**
>>>>     * struct gpi_spi_config - spi config for peripheral
>>>>     *
>>>> @@ -30,6 +35,7 @@ enum spi_transfer_cmd {
>>>>     * @cs: chip select toggle
>>>>     * @set_config: set peripheral config
>>>>     * @rx_len: receive length for buffer
>>>> + * @flags: flags for immediate dma and block event interrupt support
>>>>     */
>>>>    struct gpi_spi_config {
>>>>    	u8 set_config;
>>>> @@ -44,6 +50,7 @@ struct gpi_spi_config {
>>>>    	u32 clk_src;
>>>>    	enum spi_transfer_cmd cmd;
>>>>    	u32 rx_len;
>>>> +	u8 flags;
>>>>    };
>>>>    enum i2c_op {
>>>> -- 
>>>> 2.17.1
>>>>
>>>
> 

