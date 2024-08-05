Return-Path: <dmaengine+bounces-2794-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D19947C74
	for <lists+dmaengine@lfdr.de>; Mon,  5 Aug 2024 16:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D6462870F4
	for <lists+dmaengine@lfdr.de>; Mon,  5 Aug 2024 14:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1276D7710C;
	Mon,  5 Aug 2024 14:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Obax5ydv"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571507E111;
	Mon,  5 Aug 2024 14:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722866709; cv=none; b=tcXXJkkcgQ6tT7oBzGFGRQS653BWD/12x9vzQr1aizK61bolsNnahH5axxOrfVnVj7S9xK7+cdaJhAcmTaYeuvO7UPabFQE0dzb3VM+77jl4cVJUYeS3b6EpPna1rD0Tt7Zq/kG2YNzmMdVSvnZpULzO0iy3I016niTNwClM958=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722866709; c=relaxed/simple;
	bh=BjePA2AumzeQ2TLYhYHG4psY9v3MizraF/wucVMIA8s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qV3EVl7Cz/xdA4TofPJLMuDWENujKIHDAa7XO+zzOocQ9k+be9Q2hFww1KTLrvur1DJo+RSnw84HYQ+rX0Ly+GpF5jq3UMJGMMoIOKmbyhqhJuf6f1wKSqsuZdCMc6vcb9w/dUJb6P/Fkwf5siBC7crWXqhWPuT+CDjnwexbeVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Obax5ydv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 475BnESh012547;
	Mon, 5 Aug 2024 14:05:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	v+NbPHwCe66lLJYavIiC+igOHVE6p4ONkno/jcBSnAI=; b=Obax5ydv7rtK83kx
	akuRF5/UsukpBdXNuAmuqX8DVpBJzMUs5N3FqtnEMuoHIHDx0QZTk7ti0PxIavxs
	5vL3ZBBqYlQeaCcx0E4+J386IV+DZ1Oh5Gm7h3oTK6EX/CecOGOjy6B5pkCivNs2
	9CDvPwr63zaGES/vYztqbpN1LDNyPtI5PWFBNiBJ4MF5rRMOM4OLKK1ENf5X1ckd
	ZFhYZYWHa3/c+Mz2BImX16/1He4qrle0+rwP70xxchPzgxO3oWYHKEz/tPteaN0c
	go/RsJ6oj4xBqXEk5zYbmiQ5Q/ahrrzrKgGw5zLx3l+c3e6X+N4zZ2c02dMbn2O/
	D3NODA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40sbj6m82w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Aug 2024 14:04:59 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 475E4wo3013376
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 5 Aug 2024 14:04:58 GMT
Received: from [10.217.219.66] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 5 Aug 2024
 07:04:54 -0700
Message-ID: <4f7dafa5-ba2a-f06f-0fff-8251969b283a@quicinc.com>
Date: Mon, 5 Aug 2024 19:34:46 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 2/2] dmaengine: dw-edma: Do not enable watermark
 interrupts for HDMA
Content-Language: en-US
To: Serge Semin <fancer.lancer@gmail.com>
CC: <manivannan.sadhasivam@linaro.org>, <vkoul@kernel.org>,
        <quic_shazhuss@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_ramkri@quicinc.com>, <quic_nayiluri@quicinc.com>,
        <quic_krichai@quicinc.com>, <quic_vbadigan@quicinc.com>,
        <stable@vger.kernel.org>, Cai Huoqing <cai.huoqing@linux.dev>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1721740773-23181-1-git-send-email-quic_msarkar@quicinc.com>
 <1721740773-23181-3-git-send-email-quic_msarkar@quicinc.com>
 <mhfcw7yuv55me2d7kf6jh3eggzebq6riv5im4nbvx6qrzsg2mr@xpq3srpzemkb>
From: Mrinmay Sarkar <quic_msarkar@quicinc.com>
In-Reply-To: <mhfcw7yuv55me2d7kf6jh3eggzebq6riv5im4nbvx6qrzsg2mr@xpq3srpzemkb>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: A8sJ_MWOcyKDLGf5Q8p9ZmlE_Ido2mbv
X-Proofpoint-GUID: A8sJ_MWOcyKDLGf5Q8p9ZmlE_Ido2mbv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-05_02,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 priorityscore=1501 adultscore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0
 phishscore=0 mlxlogscore=764 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408050100


On 8/2/2024 6:04 AM, Serge Semin wrote:
> On Tue, Jul 23, 2024 at 06:49:32PM +0530, Mrinmay Sarkar wrote:
>> DW_HDMA_V0_LIE and DW_HDMA_V0_RIE are initialized as BIT(3) and BIT(4)
>> respectively in dw_hdma_control enum. But as per HDMA register these
>> bits are corresponds to LWIE and RWIE bit i.e local watermark interrupt
>> enable and remote watermarek interrupt enable. In linked list mode LWIE
>> and RWIE bits only enable the local and remote watermark interrupt.
>>
>> Since the watermark interrupts are not used but enabled, this leads to
>> spurious interrupts getting generated. So remove the code that enables
>> them to avoid generating spurious watermark interrupts.
>>
>> And also rename DW_HDMA_V0_LIE to DW_HDMA_V0_LWIE and DW_HDMA_V0_RIE to
>> DW_HDMA_V0_RWIE as there is no LIE and RIE bits in HDMA and those bits
>> are corresponds to LWIE and RWIE bits.
>>
>> Fixes: e74c39573d35 ("dmaengine: dw-edma: Add support for native HDMA")
>> cc: stable@vger.kernel.org
>> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
>> ---
>>   drivers/dma/dw-edma/dw-hdma-v0-core.c | 17 +++--------------
>>   1 file changed, 3 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
>> index fa89b3a..9ad2e28 100644
>> --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
>> +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
>> @@ -17,8 +17,8 @@ enum dw_hdma_control {
>>   	DW_HDMA_V0_CB					= BIT(0),
>>   	DW_HDMA_V0_TCB					= BIT(1),
>>   	DW_HDMA_V0_LLP					= BIT(2),
>> -	DW_HDMA_V0_LIE					= BIT(3),
>> -	DW_HDMA_V0_RIE					= BIT(4),
>> +	DW_HDMA_V0_LWIE					= BIT(3),
>> +	DW_HDMA_V0_RWIE					= BIT(4),
>>   	DW_HDMA_V0_CCS					= BIT(8),
>>   	DW_HDMA_V0_LLE					= BIT(9),
>>   };
>> @@ -195,25 +195,14 @@ static void dw_hdma_v0_write_ll_link(struct dw_edma_chunk *chunk,
>>   static void dw_hdma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
>>   {
>>   	struct dw_edma_burst *child;
>> -	struct dw_edma_chan *chan = chunk->chan;
>>   	u32 control = 0, i = 0;
>> -	int j;
>>   
>>   	if (chunk->cb)
>>   		control = DW_HDMA_V0_CB;
>>   
>> -	j = chunk->bursts_alloc;
>> -	list_for_each_entry(child, &chunk->burst->list, list) {
>> -		j--;
>> -		if (!j) {
>> -			control |= DW_HDMA_V0_LIE;
>> -			if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
>> -				control |= DW_HDMA_V0_RIE;
>> -		}
>> -
>> +	list_for_each_entry(child, &chunk->burst->list, list)
>>   		dw_hdma_v0_write_ll_data(chunk, i++, control, child->sz,
>>   					 child->sar, child->dar);
>> -	}
> Hm, in case of DW EDMA the LIE/RIE flags of the LL entries gets to be
> moved to the LIE/RIE flags of the channel context register by the
> DMA-engine. In its turn the context register LIE/RIE flags determine
> whether the Local and Remote Done/Abort IRQs being raised. So without
> the LIE/RIE flags being set in the LL-entries the IRQs won't be raised
> and the whole procedure won't work. I have doubts it works differently
> in case of HDMA because changing the semantics would cause
> implementing additional logic in the DW HDMA RTL-model. Seeing the DW
> HDMA IP-core supports the eDMA compatibility mode it would needlessly
> expand the controller size. What are the rest of the CONTROL1 register
> fields? There must be LIE/RIE flags someplace there for the non-LL
> transfers and to preserve the values retrieved from the LL-entries.
>
> Moreover the DW eDMA HW manual has a dedicated chapter called
> "Interrupts and Error Handling" with a very demonstrative figures
> describing the way the flags work. Does the DW HDMA databook have
> something like that?
>
> Please also note, the DW _EDMA_ LIE and RIE flags can be also utilized
> for the intermediate IRQ raising, to implement the runtime LL-entries
> recycling pattern. The IRQ in that case is called as "watermark" IRQ
> in the DW EDMA HW databook, but the flags are still called as just
> LIE/RIE.
>
> -Serge(y)
Yes, you are right LIE/RIE flags need to be set without that the IRQs
won't be raised in case of DW EDMA.
But in DW HDMA case there in no such LIE/RIE flags and these particular
bits has been mapped to LWIE and RWIE flags and these are used to enable
watermark interrupt only.
There is no LIE/RIE fields in HDMA_CONTROL1_OFF_WRCH register fields
the same is present in EDMA CONTROL1 register.

DW HDMA has INT_SETUP register and it has LSIE/RSIE, LAIE/RAIE fields
those are enabling Local and Remote Stop/Abort IRQs in LL mode.

yes DW HDMA data book also have figures in "Interrupts and Error Handling"
section and there is no LIE/RIE flags and it is replaced with LWIE/RWIE 
flags
as I mentioned above.

Thanks,
Mrinmay

>>   
>>   	control = DW_HDMA_V0_LLP | DW_HDMA_V0_TCB;
>>   	if (!chunk->cb)
>> -- 
>> 2.7.4
>>

