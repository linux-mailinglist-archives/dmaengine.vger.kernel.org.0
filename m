Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9EEB20CB78
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2020 03:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgF2BjF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 28 Jun 2020 21:39:05 -0400
Received: from regular1.263xmail.com ([211.150.70.198]:58234 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbgF2BjF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 28 Jun 2020 21:39:05 -0400
Received: from localhost (unknown [192.168.167.69])
        by regular1.263xmail.com (Postfix) with ESMTP id AA9956C9;
        Mon, 29 Jun 2020 09:38:55 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [172.16.12.19] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P31014T140189206046464S1593394734261642_;
        Mon, 29 Jun 2020 09:38:54 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <2727d7686c637f3bd7561c7dd98d7f80>
X-RL-SENDER: sugar.zhang@rock-chips.com
X-SENDER: zxg@rock-chips.com
X-LOGIN-NAME: sugar.zhang@rock-chips.com
X-FST-TO: linux-kernel@vger.kernel.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
Subject: Re: [PATCH v2 01/13] dmaengine: pl330: Remove the burst limit for
 quirk 'NO-FLUSHP'
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1591665267-37713-1-git-send-email-sugar.zhang@rock-chips.com>
 <1591665267-37713-2-git-send-email-sugar.zhang@rock-chips.com>
 <20200624075437.GT2324254@vkoul-mobl>
From:   sugar zhang <sugar.zhang@rock-chips.com>
Message-ID: <879c88ef-1d74-26d5-1641-efeb450362fa@rock-chips.com>
Date:   Mon, 29 Jun 2020 09:38:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200624075437.GT2324254@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 2020/6/24 15:54, Vinod Koul wrote:
> On 09-06-20, 09:14, Sugar Zhang wrote:
>> There is no reason to limit the performance on the 'NO-FLUSHP' SoCs,
>> cuz these platforms are just that the 'FLUSHP' instruction is broken.
> Lets not use terms like cuz... 'because' is perfect term :)
>
> It can rephrased to:
> There is no reason to limit the performance on the 'NO-FLUSHP' SoCs
> beacuse 'FLUSHP' instruction is broken on these platforms, so remove the
> limit to improve the efficiency
Thanks, I will send a v3 including these.
>
>> so, remove the limit to improve the efficiency.
>>
>> Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
>> ---
>>
>> Changes in v2: None
>>
>>   drivers/dma/pl330.c | 34 ++++++++++++++++++++++------------
>>   1 file changed, 22 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
>> index 6a158ee..ff0a91f 100644
>> --- a/drivers/dma/pl330.c
>> +++ b/drivers/dma/pl330.c
>> @@ -1183,9 +1183,6 @@ static inline int _ldst_peripheral(struct pl330_dmac *pl330,
>>   {
>>   	int off = 0;
>>   
>> -	if (pl330->quirks & PL330_QUIRK_BROKEN_NO_FLUSHP)
>> -		cond = BURST;
>> -
>>   	/*
>>   	 * do FLUSHP at beginning to clear any stale dma requests before the
>>   	 * first WFP.
>> @@ -1231,8 +1228,9 @@ static int _bursts(struct pl330_dmac *pl330, unsigned dry_run, u8 buf[],
>>   }
>>   
>>   /*
>> - * transfer dregs with single transfers to peripheral, or a reduced size burst
>> - * for mem-to-mem.
>> + * only the unaligned bursts transfers have the dregs.
>> + * transfer dregs with a reduced size burst to peripheral,
>> + * or a reduced size burst for mem-to-mem.
> This is not related to broken flush and should be a different patch
> explaining why this changes were done
ok, I will split this patch in v3.
>>    */
>>   static int _dregs(struct pl330_dmac *pl330, unsigned int dry_run, u8 buf[],
>>   		const struct _xfer_spec *pxs, int transfer_length)
>> @@ -1247,8 +1245,23 @@ static int _dregs(struct pl330_dmac *pl330, unsigned int dry_run, u8 buf[],
>>   	case DMA_MEM_TO_DEV:
>>   		/* fall through */
>>   	case DMA_DEV_TO_MEM:
>> -		off += _ldst_peripheral(pl330, dry_run, &buf[off], pxs,
>> -			transfer_length, SINGLE);
>> +		/*
>> +		 * dregs_len = (total bytes - BURST_TO_BYTE(bursts, ccr)) /
>> +		 *             BRST_SIZE(ccr)
>> +		 * the dregs len must be smaller than burst len,
>> +		 * so, for higher efficiency, we can modify CCR
>> +		 * to use a reduced size burst len for the dregs.
>> +		 */
>> +		dregs_ccr = pxs->ccr;
>> +		dregs_ccr &= ~((0xf << CC_SRCBRSTLEN_SHFT) |
>> +			(0xf << CC_DSTBRSTLEN_SHFT));
>> +		dregs_ccr |= (((transfer_length - 1) & 0xf) <<
>> +			CC_SRCBRSTLEN_SHFT);
>> +		dregs_ccr |= (((transfer_length - 1) & 0xf) <<
>> +			CC_DSTBRSTLEN_SHFT);
>> +		off += _emit_MOV(dry_run, &buf[off], CCR, dregs_ccr);
>> +		off += _ldst_peripheral(pl330, dry_run, &buf[off], pxs, 1,
>> +					BURST);
>>   		break;
>>   
>>   	case DMA_MEM_TO_MEM:
>> @@ -2221,9 +2234,7 @@ static bool pl330_prep_slave_fifo(struct dma_pl330_chan *pch,
>>   
>>   static int fixup_burst_len(int max_burst_len, int quirks)
>>   {
>> -	if (quirks & PL330_QUIRK_BROKEN_NO_FLUSHP)
>> -		return 1;
>> -	else if (max_burst_len > PL330_MAX_BURST)
>> +	if (max_burst_len > PL330_MAX_BURST)
>>   		return PL330_MAX_BURST;
>>   	else if (max_burst_len < 1)
>>   		return 1;
>> @@ -3128,8 +3139,7 @@ pl330_probe(struct amba_device *adev, const struct amba_id *id)
>>   	pd->dst_addr_widths = PL330_DMA_BUSWIDTHS;
>>   	pd->directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
>>   	pd->residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
>> -	pd->max_burst = ((pl330->quirks & PL330_QUIRK_BROKEN_NO_FLUSHP) ?
>> -			 1 : PL330_MAX_BURST);
>> +	pd->max_burst = PL330_MAX_BURST;
>>   
>>   	ret = dma_async_device_register(pd);
>>   	if (ret) {
>> -- 
>> 2.7.4
>>
>>
-- 



