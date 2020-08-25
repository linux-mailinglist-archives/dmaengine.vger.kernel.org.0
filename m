Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4DA251260
	for <lists+dmaengine@lfdr.de>; Tue, 25 Aug 2020 08:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbgHYGuf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 25 Aug 2020 02:50:35 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:50768 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729079AbgHYGue (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 25 Aug 2020 02:50:34 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 07P6oUbp069409;
        Tue, 25 Aug 2020 01:50:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1598338230;
        bh=tdz2P7L4M7GY6138AgTYwy06Fxammm7gnj52s0oLfW4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=NqErmEm2w2etd7BIyxArIlTF1/OHd3NZ8hLCT4WyEwurZ/3kXmoU/WuOeBk7MezRU
         Ofhv7ZVbaxJWvQldcjndPLJ+e4bwXQY168W3YdkcZTiVAxX/lIXJw7Xb9Z8GAoHQ29
         PTewyxZX+rXuWSaZZ3wogFB7ojZx4FDpsU/OXwfg=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 07P6oUCX054547
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Aug 2020 01:50:30 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 25
 Aug 2020 01:50:30 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 25 Aug 2020 01:50:30 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 07P6oRlL124533;
        Tue, 25 Aug 2020 01:50:28 -0500
Subject: Re: [RFC PATCH 2/3] dmaengine: add peripheral configuration
To:     Vinod Koul <vkoul@kernel.org>, <dmaengine@vger.kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200824084712.2526079-1-vkoul@kernel.org>
 <20200824084712.2526079-3-vkoul@kernel.org>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
X-Pep-Version: 2.0
Message-ID: <50ed780f-4c1a-2da2-71e4-423f3b224e25@ti.com>
Date:   Tue, 25 Aug 2020 09:52:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200824084712.2526079-3-vkoul@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Vinod,

On 24/08/2020 11.47, Vinod Koul wrote:
> Some complex dmaengine controllers have capability to program the
> peripheral device, so pass on the peripheral configuration as part of
> dma_slave_config
>=20
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  include/linux/dmaengine.h | 75 +++++++++++++++++++++++++++++++++++++++=

>  1 file changed, 75 insertions(+)
>=20
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index 6fbd5c99e30c..264643ca9209 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -380,6 +380,73 @@ enum dma_slave_buswidth {
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
> + * @pack_en: process tx/rx buffers as packed
> + * @word_len: spi word length
> + * @clk_div: source clock divider
> + * @clk_src: serial clock
> + * @cmd: spi cmd
> + * @cs: chip select toggle
> + * @rx_len: receive length for spi buffer
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
> +	enum spi_transfer_cmd cmd;
> +	u8 cs;
> +	u32 rx_len;
> +};
> +
> +/**
> + * struct dmaengine_i2c_config - i2c config for peripheral
> + *
> + * @pack_enable: process tx/rx buffers as packed
> + * @cycle_count: clock cycles to be sent
> + * @high_count: high period of clock
> + * @low_count: low period of clock
> + * @clk_div: source clock divider
> + * @addr: i2c bus address
> + * @strech: strech the clock at eot
> + * @op: i2c cmd
> + */
> +struct dmaengine_i2c_config {
> +	u8 pack_enable;
> +	u8 cycle_count;
> +	u8 high_count;
> +	u8 low_count;
> +	u16 clk_div;
> +	u8 addr;
> +	u8 strech;
> +	u8 op;
> +};
> +
> +enum dmaengine_peripheral {
> +	DMAENGINE_PERIPHERAL_SPI,
> +	DMAENGINE_PERIPHERAL_I2C,
> +	DMAENGINE_PERIPHERAL_UART,
> +	DMAENGINE_PERIPHERAL_LAST =3D DMAENGINE_PERIPHERAL_UART,
> +};
> +
>  /**
>   * struct dma_slave_config - dma slave channel runtime config
>   * @direction: whether the data shall go in or out on this slave
> @@ -418,6 +485,10 @@ enum dma_slave_buswidth {
>   * @slave_id: Slave requester id. Only valid for slave channels. The d=
ma
>   * slave peripheral will have unique id as dma requester which need to=
 be
>   * pass as slave config.
> + * @peripheral: type of peripheral to DMA to/from
> + * @set_config: set peripheral config
> + * @spi: peripheral config for spi
> + * @:i2c peripheral config for i2c
>   *
>   * This struct is passed in as configuration data to a DMA engine
>   * in order to set up a certain channel for DMA transport at runtime.
> @@ -443,6 +514,10 @@ struct dma_slave_config {
>  	u32 dst_port_window_size;
>  	bool device_fc;
>  	unsigned int slave_id;
> +	enum dmaengine_peripheral peripheral;
> +	u8 set_config;
> +	struct dmaengine_spi_config spi;
> +	struct dmaengine_i2c_config i2c;

Would it be possible to reuse one of the existing feature already
supported by DMAengine?
We have DMA_PREP_CMD to give a command instead of a real transfer:
dmaengine_prep_slave_single(tx_chan, config_data, config_len,
			    DMA_MEM_TO_DEV, DMA_PREP_CMD);
dmaengine_prep_slave_single(tx_chan, tx_buff, tx_len, DMA_MEM_TO_DEV,
			    DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
dma_async_issue_pending(tx_chan);

or the metadata support:
tx =3D dmaengine_prep_slave_single(tx_chan, tx_buff, tx_len,
				 DMA_MEM_TO_DEV,
				 DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
dmaengine_desc_attach_metadata(tx, config_data, config_len);
dma_async_issue_pending(tx_chan);

By reading the driver itself, it is not clear if you always need to send
the config for TX, or only when the config is changing and what happens
if the first transfer (for SPI, since that is the only implemented one)
is RX, when you don't send config at all...

I'm concerned about the size increase of dma_slave_config (it grows by
>30 bytes) and for DMAs with hundreds of channels (UDMA) it will add up
to a sizeable amount.

>  };
> =20
>  /**
>=20

- P=C3=A9ter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

