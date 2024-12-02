Return-Path: <dmaengine+bounces-3836-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0149DFAC5
	for <lists+dmaengine@lfdr.de>; Mon,  2 Dec 2024 07:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81FC5281A1E
	for <lists+dmaengine@lfdr.de>; Mon,  2 Dec 2024 06:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B931F8AF6;
	Mon,  2 Dec 2024 06:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IN572+JB"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19ED33F6;
	Mon,  2 Dec 2024 06:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733121459; cv=none; b=Kp2c8TksHc7XXDWwzdqXb56DzqRxCukjZWvpZ3YswDa0uM73B+477gZd6Tlmj9QWGcZjr+/hdEH3YZFBQdQiQSZl7UL7CXez0lRSH+0mRNhQ6U7wpRDIDRJmt0cHpRGp+Ou8OnKthSSj6QYbRuS6bFFxYrnw+Eq1PnjlcIxcbJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733121459; c=relaxed/simple;
	bh=QQvQXaEOUqSto30dPrEV3btJuInxXZtM/Il0NXgo70s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MaL8/CDj2wqbJMfoLMm3jh8/irpJzTapwjMqKNdNalLvj+cgTyixd129rxBTm3YZO+wYT04nQRvXu9F7AxNhVbCqVPZquI/lFOPA51xMNWtqGEdNZVPB/QLT+qk0YndHsZZ9MZs/VyX9x8SfN4/Ty8D1YBqgC3+UwCKJRnGdJdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IN572+JB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B1LfmnG016179;
	Mon, 2 Dec 2024 06:37:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YbdM9GSYDLg+fxz5al7QnCRK8heQ4yWSX4Wnum8fndQ=; b=IN572+JBEBcaArNs
	GMYZ2g7orjm2yUALWEdrmt8wMAjl4vV9YjvQk5Kjtuk0s8vk+z/8am8aFWPrvBaz
	GuETNbTs53vCt/hP2nVCIQeEdtNjrkrF08yRb/db44FHMIPBRenPA41Wd/sWp4t7
	+GQdUegALRjIFOkcxPuVEnvmY1YI9lM1kRews3dJ7uWfwo/jTLxe/mPsm3yStv+0
	jjJ9ISo8QXV3rKZsSVfLTOE4DHT2SSXjrvOF3SP1T+Mj3/7mSgbpNofSvg6H1tJN
	5dCDAWxq5e6edz4aPjMJ1Axt8KtO/n12xkb4IEqgW9B6Nve3KTirj1gbWi79zEZX
	HV4oHw==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 437r2mutjt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Dec 2024 06:37:33 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B26bW57030823
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 2 Dec 2024 06:37:32 GMT
Received: from [10.217.219.62] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 1 Dec 2024
 22:37:29 -0800
Message-ID: <f1cf0dd1-06f5-4633-b2c3-fd3666911f07@quicinc.com>
Date: Mon, 2 Dec 2024 12:07:26 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] spi: spi-geni-qcom: Add immediate DMA support
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <quic_msavaliy@quicinc.com>, <quic_vtanuku@quicinc.com>
References: <20241128133351.24593-1-quic_jseerapu@quicinc.com>
 <20241128133351.24593-3-quic_jseerapu@quicinc.com>
 <dou77hbrpdqsdlzx3ymco6fgbbmimimt6rrzzezghzmc3a2hle@fgdnpbmg6xsb>
Content-Language: en-US
From: Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
In-Reply-To: <dou77hbrpdqsdlzx3ymco6fgbbmimimt6rrzzezghzmc3a2hle@fgdnpbmg6xsb>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: GQiqpaFxE34VedGeo7zq2zQaSrcO2m5C
X-Proofpoint-GUID: GQiqpaFxE34VedGeo7zq2zQaSrcO2m5C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 clxscore=1015 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412020056



On 11/28/2024 7:36 PM, Dmitry Baryshkov wrote:
> On Thu, Nov 28, 2024 at 07:03:51PM +0530, Jyothi Kumar Seerapu wrote:
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
>> v1 -> v2:
>>     - Moved the spi changes as patch2.
>>
>>   drivers/spi/spi-geni-qcom.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
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
> 
> NAK. Please finish discussions in the previous iteration before posting
> new revision. Sending your responses together with sending next
> iteration is a bad practice and is frowned upon (unless one agrees to
> all the comments).
> 
> There was an open question here and your answer doesn't sound convincing
> enough. Please continue discussion in v1.

Sure Dmitry, thanks for the guidance.
I will make sure that post the new revisions after all the comments are 
sorted out.
> 
>>   	} else if (xfer->rx_buf) {
>>   		peripheral.cmd = SPI_RX;
>>   		if (!(mas->cur_bits_per_word % MIN_WORD_LEN)) {
>> -- 
>> 2.17.1
>>
> 

