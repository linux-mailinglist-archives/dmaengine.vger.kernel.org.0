Return-Path: <dmaengine+bounces-3895-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 303F49E3BCC
	for <lists+dmaengine@lfdr.de>; Wed,  4 Dec 2024 14:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E51B6285299
	for <lists+dmaengine@lfdr.de>; Wed,  4 Dec 2024 13:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF93E1FC0E5;
	Wed,  4 Dec 2024 13:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fuV5Kg/o"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CB61FAC46;
	Wed,  4 Dec 2024 13:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733320482; cv=none; b=DCpJd59uXw0RbJ8OdLDS/9BLHQ1cWCZ6PyzYhpuK+Bru+E4d+GloiIEh73+3kAP4PqJwLL9CW3JrKg4qrYY76hrDt49iKm+drGSM9jA+h9rvRMsY4OkXbjgNMDcU7rjfHOzM6mq5mPoPd3Xza7FQpXEgDRJOIKIX6J2gRAm05bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733320482; c=relaxed/simple;
	bh=1L62bNxrljW4KkY9gFqj6n2sOhs+XaSBPRiN0rt6P54=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Q7ZmGaARqUGq0IT7HacK8dYR5iDua8HPoOIMWGoBg/no7QxlOAFU/6o5folKd9puPWTwAaoihn84OEB9uE+RZnIo8YJEedz7dqBVVEE84Zt32QzXsRkFcSkI/Izy/UQOnT0l2YE521q4eidgIPZaIfU53Qd81pLc9IWhTUkw4zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fuV5Kg/o; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B469AIn027830;
	Wed, 4 Dec 2024 13:54:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZGZXjuWtIi1Zlfhet5+PW55ZC5lyVkYW9alNkcB62ag=; b=fuV5Kg/osR8lhuFZ
	nq/QvG9hO1xbZ8RvWOYSX+hx+ONlIE0G6e4PTr9u/2DnLVm7fn61+YsMw/pdPoE2
	ctJeU8ZdACdFofHxW50DuI/vWDK3frON2V5fvZVFQVEnX7gj3gNGC8MwwLmtLMVK
	TQAThQKF2EXde6ESnphTB4/ZUoa1m02eub+e2rqYyFFFKsGMs0hXpnZRowK79ERm
	BKo8Z0Jjhp1D74Y0h+rLHViLk2bdOAPXY5LHRx5rub0EqGp7jq7IbGQ2SCLNwBNt
	UfMBTvvKx4mpsZ2HUaHSj5a+Ns9o016izCguvdqLqnw/alkyo43xFvJ+DGfxjWvm
	eVPCCQ==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 439vcemj49-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Dec 2024 13:54:36 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B4Dsafs011790
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 4 Dec 2024 13:54:36 GMT
Received: from [10.217.219.62] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 4 Dec 2024
 05:54:33 -0800
Message-ID: <07f627cd-e5ea-4491-8c3e-2693554e6032@quicinc.com>
Date: Wed, 4 Dec 2024 19:24:30 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] dmaengine: qcom: gpi: Add GPI immediate DMA support
 for SPI protocol
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Vinod Koul <vkoul@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_msavaliy@quicinc.com>, <quic_vtanuku@quicinc.com>
References: <20241204122059.24239-1-quic_jseerapu@quicinc.com>
 <higpzg6b4e66zpykuu3wlcmaxzplzz3qasoycfytidunp7yqbn@nunjmucxkjbe>
 <052c98ab-1ba4-4665-8b45-3e5ad4fa553b@quicinc.com>
 <CAA8EJppynecscUbUW7Ue=+oYyhFzftiYVgTc6rEuXbUhpxF7iQ@mail.gmail.com>
Content-Language: en-US
From: Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
In-Reply-To: <CAA8EJppynecscUbUW7Ue=+oYyhFzftiYVgTc6rEuXbUhpxF7iQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: zdtQoR2FaTsEZkSn7MPHYFa6SymqhFOk
X-Proofpoint-ORIG-GUID: zdtQoR2FaTsEZkSn7MPHYFa6SymqhFOk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=999 adultscore=0 suspectscore=0 spamscore=0
 impostorscore=0 phishscore=0 mlxscore=0 malwarescore=0 clxscore=1011
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412040106



On 12/4/2024 7:09 PM, Dmitry Baryshkov wrote:
> On Wed, 4 Dec 2024 at 15:25, Jyothi Kumar Seerapu
> <quic_jseerapu@quicinc.com> wrote:
>>
>>
>>
>> On 12/4/2024 6:15 PM, Dmitry Baryshkov wrote:
>>> On Wed, Dec 04, 2024 at 05:50:59PM +0530, Jyothi Kumar Seerapu wrote:
>>>> The DMA TRE(Transfer ring element) buffer contains the DMA
>>>> buffer address. Accessing data from this address can cause
>>>> significant delays in SPI transfers, which can be mitigated to
>>>> some extent by utilizing immediate DMA support.
>>>>
>>>> QCOM GPI DMA hardware supports an immediate DMA feature for data
>>>> up to 8 bytes, storing the data directly in the DMA TRE buffer
>>>> instead of the DMA buffer address. This enhancement enables faster
>>>> SPI data transfers.
>>>>
>>>> This optimization reduces the average transfer time from 25 us to
>>>> 16 us for a single SPI transfer of 8 bytes length, with a clock
>>>> frequency of 50 MHz.
>>>>
>>>> Signed-off-by: Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>
>>>> ---
>>>>
>>>> v2-> v3:
>>>>      - When to enable Immediate DMA support, control is moved to GPI driver
>>>>        from SPI driver.
>>>>      - Optimizations are done in GPI driver related to immediate dma changes.
>>>>      - Removed the immediate dma supported changes in qcom-gpi-dma.h file
>>>>        and handled in GPI driver.
>>>>
>>>>      Link to v2:
>>>>       https://lore.kernel.org/all/20241128133351.24593-2-quic_jseerapu@quicinc.com/
>>>>       https://lore.kernel.org/all/20241128133351.24593-3-quic_jseerapu@quicinc.com/
>>>>
>>>> v1 -> v2:
>>>>      - Separated the patches to dmaengine and spi subsystems
>>>>      - Removed the changes which are not required for this feature from
>>>>        qcom-gpi-dma.h file.
>>>>      - Removed the type conversions used in gpi_create_spi_tre.
>>>>
>>>>      Link to v1:
>>>>       https://lore.kernel.org/lkml/20241121115201.2191-2-quic_jseerapu@quicinc.com/
>>>>
>>>>    drivers/dma/qcom/gpi.c | 32 +++++++++++++++++++++++++++-----
>>>>    1 file changed, 27 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
>>>> index 52a7c8f2498f..35451d5a81f7 100644
>>>> --- a/drivers/dma/qcom/gpi.c
>>>> +++ b/drivers/dma/qcom/gpi.c
>>>> @@ -27,6 +27,7 @@
>>>>    #define TRE_FLAGS_IEOT             BIT(9)
>>>>    #define TRE_FLAGS_BEI              BIT(10)
>>>>    #define TRE_FLAGS_LINK             BIT(11)
>>>> +#define TRE_FLAGS_IMMEDIATE_DMA     BIT(16)
>>>>    #define TRE_FLAGS_TYPE             GENMASK(23, 16)
>>>>
>>>>    /* SPI CONFIG0 WD0 */
>>>> @@ -64,6 +65,7 @@
>>>>
>>>>    /* DMA TRE */
>>>>    #define TRE_DMA_LEN                GENMASK(23, 0)
>>>> +#define TRE_DMA_IMMEDIATE_LEN       GENMASK(3, 0)
>>>>
>>>>    /* Register offsets from gpi-top */
>>>>    #define GPII_n_CH_k_CNTXT_0_OFFS(n, k)     (0x20000 + (0x4000 * (n)) + (0x80 * (k)))
>>>> @@ -1711,6 +1713,8 @@ static int gpi_create_spi_tre(struct gchan *chan, struct gpi_desc *desc,
>>>>       dma_addr_t address;
>>>>       struct gpi_tre *tre;
>>>>       unsigned int i;
>>>> +    int len;
>>>> +    u8 immediate_dma;
>>>>
>>>>       /* first create config tre if applicable */
>>>>       if (direction == DMA_MEM_TO_DEV && spi->set_config) {
>>>> @@ -1763,14 +1767,32 @@ static int gpi_create_spi_tre(struct gchan *chan, struct gpi_desc *desc,
>>>>       tre_idx++;
>>>>
>>>>       address = sg_dma_address(sgl);
>>>> -    tre->dword[0] = lower_32_bits(address);
>>>> -    tre->dword[1] = upper_32_bits(address);
>>>> +    len = sg_dma_len(sgl);
>>>>
>>>> -    tre->dword[2] = u32_encode_bits(sg_dma_len(sgl), TRE_DMA_LEN);
>>>> +    immediate_dma = (direction == DMA_MEM_TO_DEV) && len <= 2 * sizeof(tre->dword[0]);
>>>
>>> inline this condition, remove extra brackets and split the line after &&.
>> Hi Dmitry Baryshkov, thanks for the review.
>> Sure, i will make the changes mentioned below. Please let me know otherwise.
>>
>> immediate_dma = direction == DMA_MEM_TO_DEV &&
>>                   len <= 2 * sizeof(tre->dword[0]);
> 
> I was suggesting to _inline_ this condition rather than having a
> separate variable for it.

I can directly use the condition as follows:
if (direction == DMA_MEM_TO_DEV && len <= 2 * sizeof(tre->dword[0]))

However, this condition also needs to account for the 
"TRE_FLAGS_IMMEDIATE_DMA" update. Therefore, I introduced a separate 
variable.

tre->dword[3] |= u32_encode_bits(!!immediate_dma, TRE_FLAGS_IMMEDIATE_DMA);

Please let me know if it's acceptable to mention the entire condition in 
both places instead of using a separate variable.


> 
>>>> +
>>>> +    /* Support Immediate dma for write transfers for data length up to 8 bytes */
>>>> +    if (immediate_dma) {
>>>> +            /*
>>>> +             * For Immediate dma, data length may not always be length of 8 bytes,
>>>> +             * it can be length less than 8, hence initialize both dword's with 0
>>>> +             */
>>>> +            tre->dword[0] = 0;
>>>> +            tre->dword[1] = 0;
>>>> +            memcpy(&tre->dword[0], sg_virt(sgl), len);
>>>> +
>>>> +            tre->dword[2] = u32_encode_bits(len, TRE_DMA_IMMEDIATE_LEN);
>>>> +    } else {
>>>> +            tre->dword[0] = lower_32_bits(address);
>>>> +            tre->dword[1] = upper_32_bits(address);
>>>> +
>>>> +            tre->dword[2] = u32_encode_bits(len, TRE_DMA_LEN);
>>>> +    }
>>>>
>>>>       tre->dword[3] = u32_encode_bits(TRE_TYPE_DMA, TRE_FLAGS_TYPE);
>>>> -    if (direction == DMA_MEM_TO_DEV)
>>>> -            tre->dword[3] |= u32_encode_bits(1, TRE_FLAGS_IEOT);
>>>> +    tre->dword[3] |= u32_encode_bits(!!immediate_dma, TRE_FLAGS_IMMEDIATE_DMA);
>>>> +    tre->dword[3] |= u32_encode_bits(!!(direction == DMA_MEM_TO_DEV),
>>>> +                                     TRE_FLAGS_IEOT);
>>>>
>>>>       for (i = 0; i < tre_idx; i++)
>>>>               dev_dbg(dev, "TRE:%d %x:%x:%x:%x\n", i, desc->tre[i].dword[0],
>>>> --
>>>> 2.17.1
>>>>
>>>
> 
> 
> 

