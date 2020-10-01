Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5B427FE43
	for <lists+dmaengine@lfdr.de>; Thu,  1 Oct 2020 13:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731877AbgJALXS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 1 Oct 2020 07:23:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:52692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731134AbgJALXM (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 1 Oct 2020 07:23:12 -0400
Received: from localhost (unknown [122.167.37.56])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3332208B6;
        Thu,  1 Oct 2020 11:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601551392;
        bh=bUHEd1e9zOHwRPVq02x/79Y7+fidiGQpvPe4mV0kfTw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1n8NslubAAO20XWnkYQbenY2slljF1Rf26iLMA9V/lrhfSmrpnPIWCVARWNm0Kpdg
         07OpUmM3bik9PVYwCu2L7XeEMkqBBs8ZOZsdvOUfNpHCdH+GVZKd7V2dhT32v/SEsS
         CYbzEexUe9pQPk4C4gayFBYjdZ0fAvmvDJ3lae00=
Date:   Thu, 1 Oct 2020 16:53:07 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     dmaengine@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] dmaengine: add peripheral configuration
Message-ID: <20201001112307.GX2968@vkoul-mobl>
References: <20200923063410.3431917-1-vkoul@kernel.org>
 <20200923063410.3431917-3-vkoul@kernel.org>
 <29f95fff-c484-0131-d1fe-b06e3000fb9f@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29f95fff-c484-0131-d1fe-b06e3000fb9f@ti.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Peter,

On 29-09-20, 11:06, Peter Ujfalusi wrote:

> > + * @spi: peripheral config for spi
> > + * @i2c: peripheral config for i2c
> > + */
> > +struct dmaengine_peripheral_config {
> > +	enum dmaengine_peripheral peripheral;
> > +	u8 set_config;
> > +	u32 rx_len;
> > +	struct dmaengine_spi_config spi;
> > +	struct dmaengine_i2c_config i2c;
> 
> I know that you want this to be as generic as much as it is possible,
> but do we really want to?

That is really a good question ;-)

> GPIv2 will also handle I2S peripheral, other vendor's similar solution

Not I2S, but yes but additional peripherals is always a question

> would require different sets of parameters unique to their IPs?
> 
> How we are going to handle similar setups for DMA which is used for
> networking, SPI/I2C/I2S/NAND/display/capture, etc?
> 
> Imho these settings are really part of the peripheral's domain and not
> the DMA. It is just a small detail that instead of direct register
> writes, your setup is using the DMA descriptors to write.
> It is similar to what I use as metadata (part of the descriptor belongs
> and owned by the client driver).
> 
> I think it would be better to have:
> 
> enum dmaengine_peripheral {
> 	DMAENGINE_PERIPHERAL_GPI_SPI = 1,
> 	DMAENGINE_PERIPHERAL_GPI_UART,
> 	DMAENGINE_PERIPHERAL_GPI_I2C,
> 	DMAENGINE_PERIPHERAL_XYZ_SPI,
> 	DMAENGINE_PERIPHERAL_XYZ_AASRC,
> 	DMAENGINE_PERIPHERAL_ABC_CAM,
> 	...
> 	DMAENGINE_PERIPHERAL_LAST,
> };
> 
> enum dmaengine_peripheral peripheral_type;
> void *peripheral_config;
> 
> 
> and that's it. The set_config is specific to GPI.
> It can be debated where the structs should be defined, in the generic
> dmaengine.h or in include/linux/dma/ as controller specific
> (gpi_peripheral.h) or a generic one, like dmaengine_peripheral.h
> 
> The SPI/I2C/UART client of yours would pass the GPI specific struct as
> in any case it has to know what is the DMA it is serviced by.

If we want to take that approach, I can actually move the whole logic of
creating the specific TREs from DMA to clients and they pass on TRE
values and driver adds to ring after appending DMA TREs

Question is how should this interface look like? reuse metadata or add a
new API which sets the txn specific data (void pointer and size) to the
txn.. 

-- 
~Vinod
