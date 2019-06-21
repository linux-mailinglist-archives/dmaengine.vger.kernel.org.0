Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2AD4DF32
	for <lists+dmaengine@lfdr.de>; Fri, 21 Jun 2019 04:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbfFUCvA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 20 Jun 2019 22:51:00 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:8860 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfFUCvA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 20 Jun 2019 22:51:00 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d0c46130000>; Thu, 20 Jun 2019 19:50:59 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 20 Jun 2019 19:50:58 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 20 Jun 2019 19:50:58 -0700
Received: from [10.24.70.43] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 21 Jun
 2019 02:50:55 +0000
Subject: Re: [PATCH] dmaengine: tegra210-adma: fix transfer failure
To:     Jon Hunter <jonathanh@nvidia.com>, <vkoul@kernel.org>,
        <dan.j.williams@intel.com>
CC:     <thierry.reding@gmail.com>, <ldewangan@nvidia.com>,
        <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1561047348-14413-1-git-send-email-spujar@nvidia.com>
 <1ea807ca-24b3-c884-6a4d-4e260f51ceaa@nvidia.com>
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <740ce945-9f11-1e38-8bdf-739c4c85ee43@nvidia.com>
Date:   Fri, 21 Jun 2019 08:20:51 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <1ea807ca-24b3-c884-6a4d-4e260f51ceaa@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1561085459; bh=HHs8+1M/v/UBRnz9uwiDTYsYAF3xVfgbq4YmOdMB2PA=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=Hj5vD5LR2WGD6HIDFf1y4qR+urMauIhQTL2XiKCIsTjC/uhl3FagekPHFkWeoCOGx
         dftRXHPlIEAgJfQotXokeI3IiVkfoaSAm3T2TWas5ZV5IONJ9tcY7Ml9AT3iJ5zmdE
         v4lXXgJfthFSlhhgmrSXxfJVv5RNHwdrf8ahFoJWsDk47LJEk4LnsKY22HvMZVQUsi
         aKluJnFbr8gOVrtdxR+CztqBeIuXrsCwgaRV9r0lEfblqYzjA9lYalmikSGse5c+RL
         gGSAOPOYEFbDp1tZ/spxFsSYUvZfUc07mq1fSrK0hQNAxXJLQLbYNJSA4Z33CDBtNp
         hlNJrG8b+tF3g==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 6/20/2019 10:07 PM, Jon Hunter wrote:
> On 20/06/2019 17:15, Sameer Pujar wrote:
>>  From Tegra186 onwards OUTSTANDING_REQUESTS field is added in channel
>> configuration register (bits 7:4). ADMA allows a maximum of 8 reads
>> to source and that many writes to target memory be outstanding at any
>> given point of time. If this field is not programmed, DMA transfers
>> fail to happen.
>>
>> Thus added 'ch_pending_req' member in chip data structure and the
>> same is populated with maximum allowed pending requests. Since the
>> field is not applicable to Tegra210, mentioned bit fields are unused
>> and hence the member is initialized with 0.
>>
>> Fixes: 433de642a76c ("dmaengine: tegra210-adma: add support for Tegra186/Tegra194")
>>
>> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
>> ---
>>   drivers/dma/tegra210-adma.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
>> index 17ea4dd99..8d291cf 100644
>> --- a/drivers/dma/tegra210-adma.c
>> +++ b/drivers/dma/tegra210-adma.c
>> @@ -96,6 +96,7 @@ struct tegra_adma;
>>    * @ch_req_tx_shift: Register offset for AHUB transmit channel select.
>>    * @ch_req_rx_shift: Register offset for AHUB receive channel select.
>>    * @ch_base_offset: Register offset of DMA channel registers.
>> + * @ch_pending_req: Outstaning DMA requests for a channel.
>>    * @ch_fifo_ctrl: Default value for channel FIFO CTRL register.
>>    * @ch_req_mask: Mask for Tx or Rx channel select.
>>    * @ch_req_max: Maximum number of Tx or Rx channels available.
>> @@ -109,6 +110,7 @@ struct tegra_adma_chip_data {
>>   	unsigned int ch_req_tx_shift;
>>   	unsigned int ch_req_rx_shift;
>>   	unsigned int ch_base_offset;
>> +	unsigned int ch_pending_req;
>>   	unsigned int ch_fifo_ctrl;
>>   	unsigned int ch_req_mask;
>>   	unsigned int ch_req_max;
>> @@ -613,6 +615,7 @@ static int tegra_adma_set_xfer_params(struct tegra_adma_chan *tdc,
>>   			 ADMA_CH_CTRL_FLOWCTRL_EN;
>>   	ch_regs->config |= cdata->adma_get_burst_config(burst_size);
>>   	ch_regs->config |= ADMA_CH_CONFIG_WEIGHT_FOR_WRR(1);
>> +	ch_regs->config |= cdata->ch_pending_req;
>>   	ch_regs->fifo_ctrl = cdata->ch_fifo_ctrl;
>>   	ch_regs->tc = desc->period_len & ADMA_CH_TC_COUNT_MASK;
>>   
>> @@ -797,6 +800,7 @@ static const struct tegra_adma_chip_data tegra210_chip_data = {
>>   	.ch_req_tx_shift	= 28,
>>   	.ch_req_rx_shift	= 24,
>>   	.ch_base_offset		= 0,
>> +	.ch_pending_req		= 0,
>>   	.ch_fifo_ctrl		= TEGRA210_FIFO_CTRL_DEFAULT,
>>   	.ch_req_mask		= 0xf,
>>   	.ch_req_max		= 10,
>> @@ -811,6 +815,7 @@ static const struct tegra_adma_chip_data tegra186_chip_data = {
>>   	.ch_req_tx_shift	= 27,
>>   	.ch_req_rx_shift	= 22,
>>   	.ch_base_offset		= 0x10000,
>> +	.ch_pending_req		= (8 << 4),
> So given that this is a value and a shift, I think that we should add a
> proper definition like we have for TEGRA186_FIFO_CTRL_DEFAULT below.
I can add.
>
>>   	.ch_fifo_ctrl		= TEGRA186_FIFO_CTRL_DEFAULT,
>>   	.ch_req_mask		= 0x1f,
>>   	.ch_req_max		= 20,
>>
> Please group your patches into a series if you have more than one for a
> given driver.
The other ADMA related change is in Kconfig and a simple change. Current 
patch can go through some review
cycles. Hence didn't want to delay the other patch.
> Cheers
> Jon
>
