Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D75CB35C1
	for <lists+dmaengine@lfdr.de>; Mon, 16 Sep 2019 09:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729231AbfIPHh1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 16 Sep 2019 03:37:27 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:8163 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728109AbfIPHh1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 16 Sep 2019 03:37:27 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d7f3bbb0002>; Mon, 16 Sep 2019 00:37:31 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 16 Sep 2019 00:37:26 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 16 Sep 2019 00:37:26 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 16 Sep
 2019 07:37:26 +0000
Received: from [10.24.44.187] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 16 Sep
 2019 07:37:24 +0000
Subject: Re: [PATCH v2] dmaengine: tegra210-adma: fix transfer failure
To:     Jon Hunter <jonathanh@nvidia.com>, <vkoul@kernel.org>,
        <ldewangan@nvidia.com>
CC:     <thierry.reding@gmail.com>, <dmaengine@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>
References: <1562929830-29344-1-git-send-email-spujar@nvidia.com>
 <9ac012f8-2594-cc70-44cb-b2c560c7df07@nvidia.com>
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <69348c44-7c26-61aa-520e-1177b6c68259@nvidia.com>
Date:   Mon, 16 Sep 2019 13:07:21 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <9ac012f8-2594-cc70-44cb-b2c560c7df07@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1568619451; bh=ZQMpdGSntHDeVB3aL2F0OXr8wH6L0E7vrSRdUbxCBhE=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=k5DAKvj5cNT9DtqHJnYlaaTiF1efR/jPhPYihy7NSRjQUtiDrkywdm+zht5J/8hOW
         PGsqE8rA1p7EDBzxTCP1fqzPd+SooHKx/XtPQEjWJRAmdOYYHWZlZvu6XI+znLD6Qy
         0kshQmZCFaPSIxpS3oVI/9kAHZsN5hv0+5bqbVSToGhNGFPRJFa06ZfpQyDocp6CCV
         NgOOK71I6XZaZ+BYEGMS4xH/wUqLfSk+/oNc0Z3CRqSbA5Kg2agXCswpA/GT6ygyW2
         DhD2U7WzDPzrr9bzalVogJ1Kid41lDwsC1Ue7/ilZAPx6cI6q6L2RCLS8lQ/6I/KxF
         BjINptCzsrZSg==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Sorry for delayed reply, I was consumed in some other work.

On 8/19/2019 11:10 PM, Jon Hunter wrote:
> On 12/07/2019 12:10, Sameer Pujar wrote:
>>  From Tegra186 onwards OUTSTANDING_REQUESTS field is added in channel
>> configuration register(bits 7:4) which defines the maximum number of reads
>> from the source and writes to the destination that may be outstanding at
>> any given point of time. This field must be programmed with a value
>> between 1 and 8. A value of 0 will prevent any transfers from happening.
>>
>> Thus added 'ch_pending_req' member in chip data structure and the same is
>> populated with maximum allowed pending requests. Since the field is not
>> applicable to Tegra210, mentioned bit fields are unused and hence the
>> member is initialized with 0. For Tegra186, by default program this field
>> with the maximum permitted value of 8.
>>
>> Fixes: 433de642a76c ("dmaengine: tegra210-adma: add support for Tegra186/Tegra194")
>>
>> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
>> ---
>>   drivers/dma/tegra210-adma.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
>> index 2805853..5ab4e3a9 100644
>> --- a/drivers/dma/tegra210-adma.c
>> +++ b/drivers/dma/tegra210-adma.c
>> @@ -74,6 +74,8 @@
>>   				    TEGRA186_ADMA_CH_FIFO_CTRL_TXSIZE(3)    | \
>>   				    TEGRA186_ADMA_CH_FIFO_CTRL_RXSIZE(3))
>>   
>> +#define TEGRA186_DMA_MAX_PENDING_REQS			8
>> +
>>   #define ADMA_CH_REG_FIELD_VAL(val, mask, shift)	(((val) & mask) << shift)
>>   
>>   struct tegra_adma;
>> @@ -85,6 +87,7 @@ struct tegra_adma;
>>    * @ch_req_tx_shift: Register offset for AHUB transmit channel select.
>>    * @ch_req_rx_shift: Register offset for AHUB receive channel select.
>>    * @ch_base_offset: Register offset of DMA channel registers.
>> + * @ch_pending_req: Outstaning DMA requests for a channel.
> s/Outstaning/Outstanding
will fix.
> I do wonder if this variable should be a boolean variable
> 'has_oustanding_reqs' because this is not applicable to Tegra210. I
> think this will be clearer that this is a difference between SoC
> versions and that it should not be configured for Tegra210. And then ...
>
>>    * @ch_fifo_ctrl: Default value for channel FIFO CTRL register.
>>    * @ch_req_mask: Mask for Tx or Rx channel select.
>>    * @ch_req_max: Maximum number of Tx or Rx channels available.
>> @@ -98,6 +101,7 @@ struct tegra_adma_chip_data {
>>   	unsigned int ch_req_tx_shift;
>>   	unsigned int ch_req_rx_shift;
>>   	unsigned int ch_base_offset;
>> +	unsigned int ch_pending_req;
>>   	unsigned int ch_fifo_ctrl;
>>   	unsigned int ch_req_mask;
>>   	unsigned int ch_req_max;
>> @@ -602,6 +606,7 @@ static int tegra_adma_set_xfer_params(struct tegra_adma_chan *tdc,
>>   			 ADMA_CH_CTRL_FLOWCTRL_EN;
>>   	ch_regs->config |= cdata->adma_get_burst_config(burst_size);
>>   	ch_regs->config |= ADMA_CH_CONFIG_WEIGHT_FOR_WRR(1);
>> +	ch_regs->config |= cdata->ch_pending_req;
> ... you can ...
>
>          if (cdata->has_outstanding_reqs)
>              ch_regs->config |= TEGRA186_ADMA_CH_CONFIG_OUTSTNDREQS(8)
yes, this can be done. Will update in next revision.
>
>>   	ch_regs->fifo_ctrl = cdata->ch_fifo_ctrl;
>>   	ch_regs->tc = desc->period_len & ADMA_CH_TC_COUNT_MASK;
>>   
>> @@ -786,6 +791,7 @@ static const struct tegra_adma_chip_data tegra210_chip_data = {
>>   	.ch_req_tx_shift	= 28,
>>   	.ch_req_rx_shift	= 24,
>>   	.ch_base_offset		= 0,
>> +	.ch_pending_req		= 0,
>>   	.ch_fifo_ctrl		= TEGRA210_FIFO_CTRL_DEFAULT,
>>   	.ch_req_mask		= 0xf,
>>   	.ch_req_max		= 10,
>> @@ -800,6 +806,7 @@ static const struct tegra_adma_chip_data tegra186_chip_data = {
>>   	.ch_req_tx_shift	= 27,
>>   	.ch_req_rx_shift	= 22,
>>   	.ch_base_offset		= 0x10000,
>> +	.ch_pending_req		= (TEGRA186_DMA_MAX_PENDING_REQS << 4),
>>   	.ch_fifo_ctrl		= TEGRA186_FIFO_CTRL_DEFAULT,
>>   	.ch_req_mask		= 0x1f,
>>   	.ch_req_max		= 20,
>>
