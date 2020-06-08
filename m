Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8801F1DA8
	for <lists+dmaengine@lfdr.de>; Mon,  8 Jun 2020 18:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730619AbgFHQod (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 8 Jun 2020 12:44:33 -0400
Received: from foss.arm.com ([217.140.110.172]:55066 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730583AbgFHQob (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 8 Jun 2020 12:44:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8326A1FB;
        Mon,  8 Jun 2020 09:44:30 -0700 (PDT)
Received: from [10.57.9.113] (unknown [10.57.9.113])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A3CB63F73D;
        Mon,  8 Jun 2020 09:44:25 -0700 (PDT)
Subject: Re: [PATCH v9 RESEND 01/13] spi: imx: add dma_sync_sg_for_device
 after fallback from dma
To:     Mark Brown <broonie@kernel.org>, Robin Gong <yibin.gong@nxp.com>
Cc:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "matthias.schiffer@ew.tq-group.com" 
        <matthias.schiffer@ew.tq-group.com>,
        "martin.fuzzey@flowbird.group" <martin.fuzzey@flowbird.group>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <1591485677-20533-1-git-send-email-yibin.gong@nxp.com>
 <1591485677-20533-2-git-send-email-yibin.gong@nxp.com>
 <20200608143458.GH4593@sirena.org.uk>
 <VE1PR04MB66388F89015F774EE3FFF69D89850@VE1PR04MB6638.eurprd04.prod.outlook.com>
 <20200608153139.GI4593@sirena.org.uk>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <59ce3620-00b9-bac1-30e1-011a29583642@arm.com>
Date:   Mon, 8 Jun 2020 17:44:21 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200608153139.GI4593@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2020-06-08 16:31, Mark Brown wrote:
> On Mon, Jun 08, 2020 at 03:08:45PM +0000, Robin Gong wrote:
> 
>>>> +	if (transfer->rx_sg.sgl) {
>>>> +		struct device *rx_dev = spi->controller->dma_rx->device->dev;
>>>> +
>>>> +		dma_sync_sg_for_device(rx_dev, transfer->rx_sg.sgl,
>>>> +				       transfer->rx_sg.nents, DMA_TO_DEVICE);
>>>> +	}
>>>> +
> 
>>> This is confusing - why are we DMA mapping to the device after doing a PIO
>>> transfer?
> 
>> 'transfer->rx_sg.sgl' condition check that's the case fallback PIO after DMA transfer
>> failed. But the spi core still think the buffer should be in 'device' while spi driver
>> touch it by PIO(CPU), so sync it back to device to ensure all received data flush to DDR.
> 
> So we sync it back to the device so that we can then do another sync to
> CPU?  TBH I'm a bit surprised that there's a requirement that we
> explicitly undo a sync and that a redundant double sync in the same
> direction might be an issue but I've not had a need to care so I'm
> perfectly prepared to believe there is.
> 
> At the very least this needs a comment.

Yeah, something's off here - at the very least, syncing with 
DMA_TO_DEVICE on the Rx buffer that was mapped with DMA_FROM_DEVICE is 
clearly wrong. CONFIG_DMA_API_DEBUG should scream about that.

If the device has written to the buffer at all since dma_map_sg() was 
called then you do need a dma_sync_sg_for_cpu() call before touching it 
from a CPU fallback path, but if nobody's going to touch it from that 
point until it's unmapped then there's no point syncing it again. The 
my_card_interrupt_handler() example in DMA-API_HOWTO.txt demonstrates this.

Robin.
