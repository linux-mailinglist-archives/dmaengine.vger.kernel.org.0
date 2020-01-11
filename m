Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1F99137F39
	for <lists+dmaengine@lfdr.de>; Sat, 11 Jan 2020 11:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730400AbgAKKQs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 11 Jan 2020 05:16:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:60336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729229AbgAKKQr (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sat, 11 Jan 2020 05:16:47 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E34AB20673;
        Sat, 11 Jan 2020 10:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578737807;
        bh=cWDB7LJUkZzYeNN+RNZaHLYw/EuP9iPySeFRixVAIjA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0qhrTvJ622zuqqpkVY6pldy0gCLgzoi6fLpEKdLGssA+K+q3Fav7TZlYrzPTGIIBl
         TVokV2Sr087WkhwqRXpD6MVH1E4QUO9n4BX+xy9AuCHloJLmKQFiIN3G08ewL08zRg
         Je0b8p1WKEiuZZW1e3Yt6xXOhhTJXUYByXAEcbvI=
Date:   Sat, 11 Jan 2020 10:16:38 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <vkoul@kernel.org>,
        <eugen.hristev@microchip.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>, <mchehab@kernel.org>,
        <lee.jones@linaro.org>, <radu_nicolae.pirea@upb.ro>,
        <richard.genoud@gmail.com>, <tudor.ambarus@microchip.com>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <wg@grandegger.com>, <mkl@pengutronix.de>, <a.zummo@towertech.it>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <linux-can@vger.kernel.org>, <linux-rtc@vger.kernel.org>
Subject: Re: [PATCH v2 06/17] dt-bindings: at91-sama5d2_adc: add
 microchip,sam9x60-adc
Message-ID: <20200111101638.7920f26c@archlinux>
In-Reply-To: <1578673089-3484-7-git-send-email-claudiu.beznea@microchip.com>
References: <1578673089-3484-1-git-send-email-claudiu.beznea@microchip.com>
        <1578673089-3484-7-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, 10 Jan 2020 18:17:58 +0200
Claudiu Beznea <claudiu.beznea@microchip.com> wrote:

> Add microchip,sam9x60-adc to DT bindings documentation.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

I'm assuming this lot of binding changes will all go via Rob.
Let me know if you are expecting it to go via the various
individual trees.

Thanks,

Jonathan


> ---
>  Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt b/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt
> index 4a3c1d496e1a..07c59f301b31 100644
> --- a/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/at91-sama5d2_adc.txt
> @@ -1,7 +1,7 @@
>  * AT91 SAMA5D2 Analog to Digital Converter (ADC)
>  
>  Required properties:
> -  - compatible: Should be "atmel,sama5d2-adc".
> +  - compatible: Should be "atmel,sama5d2-adc" or "microchip,sam9x60-adc".
>    - reg: Should contain ADC registers location and length.
>    - interrupts: Should contain the IRQ line for the ADC.
>    - clocks: phandle to device clock.

