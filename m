Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 988BA27E090
	for <lists+dmaengine@lfdr.de>; Wed, 30 Sep 2020 07:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725779AbgI3Fqu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 30 Sep 2020 01:46:50 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:38628 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgI3Fqu (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 30 Sep 2020 01:46:50 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08U5kldp121649;
        Wed, 30 Sep 2020 00:46:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601444807;
        bh=IcGXwcmno1GcBhj0sPJ2RIbIjTWcrrKuQT9aId1ObFU=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=SMtFQgid/ACN2r2E6N9nXv45AdHeDw6Vzts/AsWt3j1DwBMmskpNtdPaGGIum2CCl
         /SruN+o0/yy97tiTQ16PZFZ51ROV6VycRgECT97f5XMrp2lyZSvY/Yt4BLuLmvedDt
         llBFlIhf3Xq/H0NtTBZAzZIIdU/lxob9tKZ2E/lE=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08U5klFl036470
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 30 Sep 2020 00:46:47 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 30
 Sep 2020 00:46:47 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 30 Sep 2020 00:46:47 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08U5kjjQ047716;
        Wed, 30 Sep 2020 00:46:45 -0500
Subject: Re: [PATCH v3 2/3] dmaengine: add peripheral configuration
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     Vinod Koul <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200923063410.3431917-1-vkoul@kernel.org>
 <20200923063410.3431917-3-vkoul@kernel.org>
 <29f95fff-c484-0131-d1fe-b06e3000fb9f@ti.com>
X-Pep-Version: 2.0
Message-ID: <aaa3f7df-3625-1b65-aeaa-33dc43566c99@ti.com>
Date:   Wed, 30 Sep 2020 08:47:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <29f95fff-c484-0131-d1fe-b06e3000fb9f@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

On 29/09/2020 11.06, Peter Ujfalusi wrote:
>=20
> I know that you want this to be as generic as much as it is possible,
> but do we really want to?
> GPIv2 will also handle I2S peripheral, other vendor's similar solution
> would require different sets of parameters unique to their IPs?
>=20
> How we are going to handle similar setups for DMA which is used for
> networking, SPI/I2C/I2S/NAND/display/capture, etc?
>=20
> Imho these settings are really part of the peripheral's domain and not
> the DMA. It is just a small detail that instead of direct register
> writes, your setup is using the DMA descriptors to write.
> It is similar to what I use as metadata (part of the descriptor belongs=

> and owned by the client driver).
>=20
> I think it would be better to have:
>=20
> enum dmaengine_peripheral {
> 	DMAENGINE_PERIPHERAL_GPI_SPI =3D 1,
> 	DMAENGINE_PERIPHERAL_GPI_UART,
> 	DMAENGINE_PERIPHERAL_GPI_I2C,
> 	DMAENGINE_PERIPHERAL_XYZ_SPI,
> 	DMAENGINE_PERIPHERAL_XYZ_AASRC,
> 	DMAENGINE_PERIPHERAL_ABC_CAM,
> 	...
> 	DMAENGINE_PERIPHERAL_LAST,
> };
>=20
> enum dmaengine_peripheral peripheral_type;
> void *peripheral_config;

TI have an AASRC (Audio Asynchronous Sample Rate Converted) in j721e and
to configure the DMA side (AASRC_PDMA) we need special configuration
parameters passed from the AASRC driver to the DMA channel.
This peripheral config extension would be perfect for it, but the
parameters I would need is not generic in any ways.

The other thing which might need to be considered is to have src/dst
pair of this. When we do DMA_DEV_TO_DEV, it would help to figure out
which side we should apply which config (if you have the same type of
device on both ends with different config?).


> and that's it. The set_config is specific to GPI.
> It can be debated where the structs should be defined, in the generic
> dmaengine.h or in include/linux/dma/ as controller specific
> (gpi_peripheral.h) or a generic one, like dmaengine_peripheral.h
>=20
> The SPI/I2C/UART client of yours would pass the GPI specific struct as
> in any case it has to know what is the DMA it is serviced by.
>=20
>> +};
>>  /**
>>   * struct dma_slave_config - dma slave channel runtime config
>>   * @direction: whether the data shall go in or out on this slave
>> @@ -418,6 +506,8 @@ enum dma_slave_buswidth {
>>   * @slave_id: Slave requester id. Only valid for slave channels. The =
dma
>>   * slave peripheral will have unique id as dma requester which need t=
o be
>>   * pass as slave config.
>> + * @peripheral: peripheral configuration for programming peripheral f=
or
>> + * dmaengine transfer
>>   *
>>   * This struct is passed in as configuration data to a DMA engine
>>   * in order to set up a certain channel for DMA transport at runtime.=

>> @@ -443,6 +533,7 @@ struct dma_slave_config {
>>  	u32 dst_port_window_size;
>>  	bool device_fc;
>>  	unsigned int slave_id;
>> +	struct dmaengine_peripheral_config *peripheral;
>>  };
>> =20
>>  /**
>>
>=20
> - P=C3=A9ter
>=20
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
>=20

- P=C3=A9ter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

