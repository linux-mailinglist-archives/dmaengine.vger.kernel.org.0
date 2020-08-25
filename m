Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C58C12513B7
	for <lists+dmaengine@lfdr.de>; Tue, 25 Aug 2020 09:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbgHYH6Z (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 25 Aug 2020 03:58:25 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:50994 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgHYH6Z (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 25 Aug 2020 03:58:25 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 07P7wN8A121790;
        Tue, 25 Aug 2020 02:58:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1598342303;
        bh=eeZpCWnT9ZMBcE9uVN51xldunCmQpTZ2pEk4/QYhHIs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ED9FrdZBXtzL6AaUZvau5SGh5o+0MelSclY1IPX1W/P7wzO7wWTTHqaGJY5Hw5gr8
         eHYSAlJLAwgIvrO3K2h37ADsw9qrR1ytxIFwHKVxS0Taik9Ejtjk0NgfxWGoe0h/3G
         s/vwGf4C39pVEMbsSoTY1tvhRC9zKvVButdPaWCM=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 07P7wNwY057685;
        Tue, 25 Aug 2020 02:58:23 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 25
 Aug 2020 02:58:23 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 25 Aug 2020 02:58:22 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 07P7wLB8113301;
        Tue, 25 Aug 2020 02:58:21 -0500
Subject: Re: [RFC PATCH 2/3] dmaengine: add peripheral configuration
To:     Vinod Koul <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200824084712.2526079-1-vkoul@kernel.org>
 <20200824084712.2526079-3-vkoul@kernel.org>
 <50ed780f-4c1a-2da2-71e4-423f3b224e25@ti.com>
 <20200825071023.GB2639@vkoul-mobl>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
X-Pep-Version: 2.0
Message-ID: <38bc6986-6d1d-7c35-b2df-967326fc5ca7@ti.com>
Date:   Tue, 25 Aug 2020 11:00:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200825071023.GB2639@vkoul-mobl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

On 25/08/2020 10.10, Vinod Koul wrote:
>>>  /**
>>>   * struct dma_slave_config - dma slave channel runtime config
>>>   * @direction: whether the data shall go in or out on this slave
>>> @@ -418,6 +485,10 @@ enum dma_slave_buswidth {
>>>   * @slave_id: Slave requester id. Only valid for slave channels. The=
 dma
>>>   * slave peripheral will have unique id as dma requester which need =
to be
>>>   * pass as slave config.
>>> + * @peripheral: type of peripheral to DMA to/from
>>> + * @set_config: set peripheral config
>>> + * @spi: peripheral config for spi
>>> + * @:i2c peripheral config for i2c
>>>   *
>>>   * This struct is passed in as configuration data to a DMA engine
>>>   * in order to set up a certain channel for DMA transport at runtime=
=2E
>>> @@ -443,6 +514,10 @@ struct dma_slave_config {
>>>  	u32 dst_port_window_size;
>>>  	bool device_fc;
>>>  	unsigned int slave_id;
>>> +	enum dmaengine_peripheral peripheral;
>>> +	u8 set_config;
>>> +	struct dmaengine_spi_config spi;
>>> +	struct dmaengine_i2c_config i2c;
>>
>> Would it be possible to reuse one of the existing feature already
>> supported by DMAengine?
>> We have DMA_PREP_CMD to give a command instead of a real transfer:
>> dmaengine_prep_slave_single(tx_chan, config_data, config_len,
>> 			    DMA_MEM_TO_DEV, DMA_PREP_CMD);
>> dmaengine_prep_slave_single(tx_chan, tx_buff, tx_len, DMA_MEM_TO_DEV,
>> 			    DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
>> dma_async_issue_pending(tx_chan);
>>
>> or the metadata support:
>> tx =3D dmaengine_prep_slave_single(tx_chan, tx_buff, tx_len,
>> 				 DMA_MEM_TO_DEV,
>> 				 DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
>> dmaengine_desc_attach_metadata(tx, config_data, config_len);
>> dma_async_issue_pending(tx_chan);
>>
>> By reading the driver itself, it is not clear if you always need to se=
nd
>> the config for TX, or only when the config is changing and what happen=
s
>> if the first transfer (for SPI, since that is the only implemented one=
)
>> is RX, when you don't send config at all...
>=20
> So this config is sent to driver everytime before the prep call (can be=

> optimized to once if we have similar transfers in queue).

I see that you queue the TREs in the prep callback.

> This config is used to create the configuration passed to dmaengine
> which is used to actually program both dmaengine as well as peripheral
> registers (i2c/spi/etc), so we need a way to pass the spi/i2c config.

But do you need to send it with each DMA_MEM_TO_DEV or only once?
DMA_DEV_TO_MEM does not set the config, so I assume you must have one TX
to initialize the peripheral as the first transfer.

> I think prep cmd can be used to send this data, I do not see any issues=

> with that, it would work if we want to go that route.

The only thing which might be an issue is that with the DMA_PREP_CMD the
config_data is dma_addr_t (via dmaengine_prep_slave_single).

> I did have a prototype with metadata but didnt work very well, the
> problem is it assumes metadata for tx/rx but here i send the data
> everytime from client data.

Yes, the intended use case for metadata (per descriptor!) is for
channels where each transfer might have different metadata needed for
the given transfer (tx/rx).

In your case you have semi static peripheral configuration data, which
is not really changing between transfers.

A compromise would be to add:
void *peripheral_config;
to the dma_slave_config, move the set_config inside of the device
specific struct you are passing from a client to the core?

>> I'm concerned about the size increase of dma_slave_config (it grows by=

>>> 30 bytes) and for DMAs with hundreds of channels (UDMA) it will add u=
p
>> to a sizeable amount.
>=20
> I agree that is indeed a valid concern, that is the reason I tagged thi=
s
> as a RFC patch ;-)
>=20
> I see the prep_cmd is a better approach for this, anyone else has bette=
r
> suggestions?
>=20
> Thanks for looking in.
>=20

- P=C3=A9ter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

