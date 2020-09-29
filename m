Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05BE027BED2
	for <lists+dmaengine@lfdr.de>; Tue, 29 Sep 2020 10:06:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbgI2IGK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 29 Sep 2020 04:06:10 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:52438 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgI2IGK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 29 Sep 2020 04:06:10 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08T8668B036512;
        Tue, 29 Sep 2020 03:06:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1601366766;
        bh=Zk6WGDzhpPM6sRSQ1cFhP30MQOAdaqW+rvAUokcbiH8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=mwdmVWOiXOKLHqFtvjW6Vf8ALeenzgKfXxMqCa9NuUrd8bYIHwFgoxYeRJkY9FZuT
         eTNaCuE5GBa99AlfpoEffgEAq/rVpGzhg6ekcDICwieVPzui63yC7O1/shYBGDlPW9
         ODDgXWoByWQ9DdebmF6UYtWl6VmA7OkDDCGjiTHk=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08T86681120938
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 29 Sep 2020 03:06:06 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 29
 Sep 2020 03:06:06 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 29 Sep 2020 03:06:06 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08T864GY102128;
        Tue, 29 Sep 2020 03:06:04 -0500
Subject: Re: [PATCH v3 2/3] dmaengine: add peripheral configuration
To:     Vinod Koul <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200923063410.3431917-1-vkoul@kernel.org>
 <20200923063410.3431917-3-vkoul@kernel.org>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
X-Pep-Version: 2.0
Message-ID: <29f95fff-c484-0131-d1fe-b06e3000fb9f@ti.com>
Date:   Tue, 29 Sep 2020 11:06:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200923063410.3431917-3-vkoul@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 23/09/2020 9.34, Vinod Koul wrote:
> Some complex dmaengine controllers have capability to program the
> peripheral device, so pass on the peripheral configuration as part of
> dma_slave_config
>=20
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  include/linux/dmaengine.h | 91 +++++++++++++++++++++++++++++++++++++++=

>  1 file changed, 91 insertions(+)
>=20
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index 6fbd5c99e30c..bbc32271ad7f 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -380,6 +380,94 @@ enum dma_slave_buswidth {
>  	DMA_SLAVE_BUSWIDTH_64_BYTES =3D 64,
>  };
> =20
> +/**
> + * enum spi_transfer_cmd - spi transfer commands
> + */
> +enum spi_transfer_cmd {
> +	SPI_TX =3D 1,
> +	SPI_RX,
> +	SPI_DUPLEX,
> +};
> +
> +/**
> + * struct dmaengine_spi_config - spi config for peripheral
> + *
> + * @loopback_en: spi loopback enable when set
> + * @clock_pol: clock polarity
> + * @data_pol: data polarity

*_pol_high ?

> + * @pack_en: process tx/rx buffers as packed

what does this mean?

> + * @word_len: spi word length
> + * @clk_div: source clock divider
> + * @clk_src: serial clock

we tend to use common clock framework for clock configuration?

> + * @cmd: spi cmd
> + * @cs: chip select toggle
> + */
> +struct dmaengine_spi_config {
> +	u8 loopback_en;
> +	u8 clock_pol;
> +	u8 data_pol;
> +	u8 pack_en;
> +	u8 word_len;
> +	u32 clk_div;
> +	u32 clk_src;
> +	u8 fragmentation;

This is not documented and I can not really guess what it is.

> +	enum spi_transfer_cmd cmd;
> +	u8 cs;
> +};
> +
> +enum i2c_op {
> +	I2C_WRITE =3D 1,
> +	I2C_READ,
> +};
> +
> +/**
> + * struct dmaengine_i2c_config - i2c config for peripheral
> + *
> + * @pack_enable: process tx/rx buffers as packed

Is this the same thing as with the spi?

> + * @cycle_count: clock cycles to be sent
> + * @high_count: high period of clock
> + * @low_count: low period of clock
> + * @clk_div: source clock divider
> + * @addr: i2c bus address
> + * @stretch: stretch the clock at eot
> + * @op: i2c cmd
> + */
> +struct dmaengine_i2c_config {
> +	u8 pack_enable;
> +	u8 cycle_count;
> +	u8 high_count;
> +	u8 low_count;
> +	u16 clk_div;
> +	u8 addr;
> +	u8 stretch;
> +	enum i2c_op op;
> +	bool multi_msg;

Not documented.
Is it indicates multiple-byte read/write or multiple messages?

> +};
> +
> +enum dmaengine_peripheral {
> +	DMAENGINE_PERIPHERAL_SPI =3D 1,
> +	DMAENGINE_PERIPHERAL_UART =3D 2,
> +	DMAENGINE_PERIPHERAL_I2C =3D 3,
> +	DMAENGINE_PERIPHERAL_LAST =3D DMAENGINE_PERIPHERAL_I2C,
> +};
> +
> +/**
> + * struct dmaengine_peripheral_config - peripheral configuration for
> + * dmaengine peripherals
> + *
> + * @peripheral: type of peripheral to DMA to/from
> + * @set_config: set peripheral config
> + * @rx_len: receive length for buffer

Why is it part of the peripheral config? You get the buffer via
prep_slave_sg(). Or is this something else?

The GPI driver uses the rx_len for DMA_MEM_TO_DEV (tx) setup.

> + * @spi: peripheral config for spi
> + * @i2c: peripheral config for i2c
> + */
> +struct dmaengine_peripheral_config {
> +	enum dmaengine_peripheral peripheral;
> +	u8 set_config;
> +	u32 rx_len;
> +	struct dmaengine_spi_config spi;
> +	struct dmaengine_i2c_config i2c;

I know that you want this to be as generic as much as it is possible,
but do we really want to?
GPIv2 will also handle I2S peripheral, other vendor's similar solution
would require different sets of parameters unique to their IPs?

How we are going to handle similar setups for DMA which is used for
networking, SPI/I2C/I2S/NAND/display/capture, etc?

Imho these settings are really part of the peripheral's domain and not
the DMA. It is just a small detail that instead of direct register
writes, your setup is using the DMA descriptors to write.
It is similar to what I use as metadata (part of the descriptor belongs
and owned by the client driver).

I think it would be better to have:

enum dmaengine_peripheral {
	DMAENGINE_PERIPHERAL_GPI_SPI =3D 1,
	DMAENGINE_PERIPHERAL_GPI_UART,
	DMAENGINE_PERIPHERAL_GPI_I2C,
	DMAENGINE_PERIPHERAL_XYZ_SPI,
	DMAENGINE_PERIPHERAL_XYZ_AASRC,
	DMAENGINE_PERIPHERAL_ABC_CAM,
	...
	DMAENGINE_PERIPHERAL_LAST,
};

enum dmaengine_peripheral peripheral_type;
void *peripheral_config;


and that's it. The set_config is specific to GPI.
It can be debated where the structs should be defined, in the generic
dmaengine.h or in include/linux/dma/ as controller specific
(gpi_peripheral.h) or a generic one, like dmaengine_peripheral.h

The SPI/I2C/UART client of yours would pass the GPI specific struct as
in any case it has to know what is the DMA it is serviced by.

> +};
>  /**
>   * struct dma_slave_config - dma slave channel runtime config
>   * @direction: whether the data shall go in or out on this slave
> @@ -418,6 +506,8 @@ enum dma_slave_buswidth {
>   * @slave_id: Slave requester id. Only valid for slave channels. The d=
ma
>   * slave peripheral will have unique id as dma requester which need to=
 be
>   * pass as slave config.
> + * @peripheral: peripheral configuration for programming peripheral fo=
r
> + * dmaengine transfer
>   *
>   * This struct is passed in as configuration data to a DMA engine
>   * in order to set up a certain channel for DMA transport at runtime.
> @@ -443,6 +533,7 @@ struct dma_slave_config {
>  	u32 dst_port_window_size;
>  	bool device_fc;
>  	unsigned int slave_id;
> +	struct dmaengine_peripheral_config *peripheral;
>  };
> =20
>  /**
>=20

- P=C3=A9ter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

