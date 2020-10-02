Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D61F280F34
	for <lists+dmaengine@lfdr.de>; Fri,  2 Oct 2020 10:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbgJBIsn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 2 Oct 2020 04:48:43 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:48260 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgJBIsn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 2 Oct 2020 04:48:43 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0928meiZ060590;
        Fri, 2 Oct 2020 03:48:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601628520;
        bh=KxIx2Q8BMe/BobBif6MsMuzIp5+oXC2YcE/NTHkf08I=;
        h=From:Subject:To:CC:References:Date:In-Reply-To;
        b=U+xQbIMyUgrRoMVxee4SCSno9XMO5dABhiIjPusxZ4ky9+l/dr/Sq122nX6MjVDpB
         nJku4NJoapMnhmUY3R2fBXibJJ7VRiz5IoXUe1p+BZB1Y3Ftxv0VZPQI7O5sig9gcZ
         rK2pWAAFnpPN4ogns1PmJBj+qFJYKZTpR6TUrjkg=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0928me96009602
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 2 Oct 2020 03:48:40 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 2 Oct
 2020 03:48:39 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 2 Oct 2020 03:48:39 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0928mbcW099978;
        Fri, 2 Oct 2020 03:48:38 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v3 2/3] dmaengine: add peripheral configuration
To:     Vinod Koul <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200923063410.3431917-1-vkoul@kernel.org>
 <20200923063410.3431917-3-vkoul@kernel.org>
 <29f95fff-c484-0131-d1fe-b06e3000fb9f@ti.com>
 <20201001112307.GX2968@vkoul-mobl>
X-Pep-Version: 2.0
Message-ID: <f063ae03-41da-480a-19ba-d061e140e4d2@ti.com>
Date:   Fri, 2 Oct 2020 11:48:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201001112307.GX2968@vkoul-mobl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

On 01/10/2020 14.23, Vinod Koul wrote:
> Hi Peter,
>=20
> On 29-09-20, 11:06, Peter Ujfalusi wrote:
>=20
>>> + * @spi: peripheral config for spi
>>> + * @i2c: peripheral config for i2c
>>> + */
>>> +struct dmaengine_peripheral_config {
>>> +	enum dmaengine_peripheral peripheral;
>>> +	u8 set_config;
>>> +	u32 rx_len;
>>> +	struct dmaengine_spi_config spi;
>>> +	struct dmaengine_i2c_config i2c;
>>
>> I know that you want this to be as generic as much as it is possible,
>> but do we really want to?
>=20
> That is really a good question ;-)
>=20
>> GPIv2 will also handle I2S peripheral, other vendor's similar solution=

>=20
> Not I2S, but yes but additional peripherals is always a question

Never underestimate the 'creativity'.

>> would require different sets of parameters unique to their IPs?
>>
>> How we are going to handle similar setups for DMA which is used for
>> networking, SPI/I2C/I2S/NAND/display/capture, etc?
>>
>> Imho these settings are really part of the peripheral's domain and not=

>> the DMA. It is just a small detail that instead of direct register
>> writes, your setup is using the DMA descriptors to write.
>> It is similar to what I use as metadata (part of the descriptor belong=
s
>> and owned by the client driver).
>>
>> I think it would be better to have:
>>
>> enum dmaengine_peripheral {
>> 	DMAENGINE_PERIPHERAL_GPI_SPI =3D 1,
>> 	DMAENGINE_PERIPHERAL_GPI_UART,
>> 	DMAENGINE_PERIPHERAL_GPI_I2C,
>> 	DMAENGINE_PERIPHERAL_XYZ_SPI,
>> 	DMAENGINE_PERIPHERAL_XYZ_AASRC,
>> 	DMAENGINE_PERIPHERAL_ABC_CAM,
>> 	...
>> 	DMAENGINE_PERIPHERAL_LAST,
>> };
>>
>> enum dmaengine_peripheral peripheral_type;
>> void *peripheral_config;
>>
>>
>> and that's it. The set_config is specific to GPI.
>> It can be debated where the structs should be defined, in the generic
>> dmaengine.h or in include/linux/dma/ as controller specific
>> (gpi_peripheral.h) or a generic one, like dmaengine_peripheral.h
>>
>> The SPI/I2C/UART client of yours would pass the GPI specific struct as=

>> in any case it has to know what is the DMA it is serviced by.
>=20
> If we want to take that approach, I can actually move the whole logic o=
f
> creating the specific TREs from DMA to clients and they pass on TRE
> values and driver adds to ring after appending DMA TREs

The drawback is that you are tying the driver to a specific DMA with
directly giving the TREs. If the TRE (or other method) is used by a
newer device you need to work on both sides.

> Question is how should this interface look like? reuse metadata or add =
a
> new API which sets the txn specific data (void pointer and size) to the=

> txn..=20

It depends which is best for the use case.
I see the metadata useful when you need to send different
metadata/configuration with each transfer.
It can be also useful when you need it seldom, but for your use case and
setup the dma_slave_config extended with

enum dmaengine_peripheral peripheral_type;
void *peripheral_config;

would be a bit more explicit.

I would then deal with the peripheral config in this way:
when the DMA driver's device_config is called, I would take the
parameters and set a flag that the config needs to be processed as it
has changed.
In the next prep_slave_sg() then I would prepare the TREs with the
config and clear the flag that the next transfer does not need the
configuration anymore.

In this way each dmaengine_slave_config() will trigger at the next
prep_slave_sg time configuration update for the peripheral to be
included in the TREs.
The set_config would be internal to the DMA driver, clients just need to
update the configuration when they need to and everything is taken care o=
f.

- P=C3=A9ter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

