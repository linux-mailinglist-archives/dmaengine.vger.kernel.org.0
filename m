Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 538A613A923
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jan 2020 13:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbgANMVQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 14 Jan 2020 07:21:16 -0500
Received: from lb3-smtp-cloud8.xs4all.net ([194.109.24.29]:60729 "EHLO
        lb3-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726053AbgANMVQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 14 Jan 2020 07:21:16 -0500
Received: from [IPv6:2001:420:44c1:2577:11b:d594:936e:b16a]
 ([IPv6:2001:420:44c1:2577:11b:d594:936e:b16a])
        by smtp-cloud8.xs4all.net with ESMTPA
        id rLBviFvU2pLtbrLByieypI; Tue, 14 Jan 2020 13:21:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s1;
        t=1579004473; bh=el/sCcXKoLi1FEc8sscgQSjCYSmbdJMyDT1iZnQSnSU=;
        h=Subject:To:From:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=LjQRYpxPLh+sE48zdnmzx1dYwbjH4bXf1Ow+L9xGtnyLYk22ootoKM/W9LPRAIgKT
         LLdOswZfIOJ19EhGCDm2XmYZWdtI6Xuyl8dC5s7pZAnPOnHvgDHSBKUIFmgTQIhTVG
         ij0tC8LIc6YqFte/+lbYjCbxQhtShNEKnJZi5/TjgcBt3gomJpQPEu7aOO69F69zpN
         OZPkGFql/MkFGntWAnRLCI4yBg5FtwfYVadZ5t73EwJzQSaPTnFRe9rfkiRcwhvAGE
         0ir1vP7bKiXOEArWvvZbnMYeMemda8rYy6AiZUejTxhRAkSw6FHwz7VxGtoaJJalpD
         AZAylzCO9BqGw==
Subject: Re: [PATCH v2 05/17] dt-bindings: atmel-isi: add
 microchip,sam9x60-isi
To:     Claudiu Beznea <claudiu.beznea@microchip.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com,
        vkoul@kernel.org, eugen.hristev@microchip.com, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        mchehab@kernel.org, lee.jones@linaro.org,
        radu_nicolae.pirea@upb.ro, richard.genoud@gmail.com,
        tudor.ambarus@microchip.com, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, wg@grandegger.com,
        mkl@pengutronix.de, a.zummo@towertech.it
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-media@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-can@vger.kernel.org, linux-rtc@vger.kernel.org
References: <1578673089-3484-1-git-send-email-claudiu.beznea@microchip.com>
 <1578673089-3484-6-git-send-email-claudiu.beznea@microchip.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <58d0a872-9f9e-ab64-b9e4-d6548b05142b@xs4all.nl>
Date:   Tue, 14 Jan 2020 13:21:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1578673089-3484-6-git-send-email-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfDyyJ8A46d/VZ6mWF8HvSJL6XohAbYvGlIDN2xY5sRpRC0AJZrnUH0YX0+FSqCMhFZjpHxOyHfMDslHdlLv97QcDoHwck2Z9TrOv5t+lopMv/NRf0PUV
 55QN8cKR2GeYA535VmrhiJJ3ojVhCtZHdqwlNqcXOOfA1jLuIJ84iCZRAPBbM5rNAMNY7EvoyTG6hFaMVlzvbuZ37zENLdycB1+4kebYsziUTwZWtoZuAnMk
 LMyouB9mCtPGzmRTzeL74XvIxJXSiMOXKUukMY9CZcdbxL+hqcyNHH1cvq0Ae2LxwdzWO4GARzgfg1BRhHkpDrmwNAST/Nzpp1yk+mYmUHUeCKMDd8m74vHt
 kAndHbAOE1qpMQD5koRQwLbarJX8A/2eAFJTImw2pecQ7825zIoL2og3ZAauw5oPkPbp/rESm4VQrrwIzQZTIdS19wLJw93WlMa24o0M4Pe9Z5x+vxoRp8Xp
 MMUfb2fVE69KZls7TdCcam6e05Yvra1yqVNR1HEStwiaFBzk/jI1Bo9NFI5Glm7TYVnbqxqMkf306iQCOo0qEXlt+P7vZcEiAVvNC8QVCAnZ33xDCOO1P0MJ
 t0xckD3lecqem5SKtKLXefkxwFCHpcH207vyGk/FUL9CikGLulLMLG70jX9Ld1ENlKvZKk+13vUDiYXETUhOLvxSM6cMGAGAw9ZxxcdL4ipi7AhZ8LDj/Hos
 Mkt9jvglBTYomM/KU9sebjVWgPJeviHg+luR+JN4Q5LWheX1ajixs/F7bHRcZ6vELvkzMcco4AX3I2EuQF4KMcH1Q96bO+BppQYyR75cNBcTiu6LbkouxWVm
 MW4NsCXcJ0fzeQoSgXBZIfj4wzfcvGDsqbwGk6u+aW6XLHkGAEIwPAz0wqV7xfW4B3Tt72thIoZ7yEUcb1NqMczIB0lX1EeMNRmoxXWuOAXv/Y3kllOdMvVM
 Ar5uaZEBf2ZZJczJNl00ZE/cL98RXshGjLQcLmOO0cOB+ZAxxE+2AbyLSmra4urIpIuGwP7z7WLnDrpuqSoBI65/nkfakNI++OOqwtpqiY5+Ovy2sTlhvJMP
 NKQilXVls4YsoomtfMm326htDEL8iehi87LtyVzJDdVEbpDuB6M944CpeFCi1lvlbLZKp/xm9YleC7sbhMLQVs92SnXK+0ICEfNtNZ1N8vaiu7fVSr1BFLjZ
 8jCShZPcvKBaXW12eRihzGqkWpLj65UlbQwlDHhc7D924tsjBZuhfWnz7g69Vb/e/iBiBa4o3+DHoJJhFax7VwFnU7KuBXXDdERSFtOo/S6RRxadrFshFakC
 uUzp6UW6M/OChwP1r3uaki5uIkuF9f7/Jnmdj1J/6ho0dIxRF3nVLa/XFeZ5FVlRe4UOcaC31YtX32Em/eD2YPZuHMSsTxORpfBZpdDOFMwv4NAg26A=
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 1/10/20 5:17 PM, Claudiu Beznea wrote:
> Add microchip,sam9x60-isi to DT bindings documentation.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  Documentation/devicetree/bindings/media/atmel-isi.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/media/atmel-isi.txt b/Documentation/devicetree/bindings/media/atmel-isi.txt
> index 332513a151cc..8924c7545b63 100644
> --- a/Documentation/devicetree/bindings/media/atmel-isi.txt
> +++ b/Documentation/devicetree/bindings/media/atmel-isi.txt
> @@ -2,7 +2,7 @@ Atmel Image Sensor Interface (ISI)
>  ----------------------------------
>  
>  Required properties for ISI:
> -- compatible: must be "atmel,at91sam9g45-isi".
> +- compatible: must be "atmel,at91sam9g45-isi" or "microchip,sam9x60-isi".
>  - reg: physical base address and length of the registers set for the device.
>  - interrupts: should contain IRQ line for the ISI.
>  - clocks: list of clock specifiers, corresponding to entries in the clock-names
> 

Acked-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

Regards,

	Hans
