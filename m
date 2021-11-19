Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A36454572E3
	for <lists+dmaengine@lfdr.de>; Fri, 19 Nov 2021 17:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236452AbhKSQar (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 19 Nov 2021 11:30:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236466AbhKSQar (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 19 Nov 2021 11:30:47 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC69C061574;
        Fri, 19 Nov 2021 08:27:45 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id b184-20020a1c1bc1000000b0033140bf8dd5so7916887wmb.5;
        Fri, 19 Nov 2021 08:27:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jwyOhCiVlhmifA4bQDRHR85Pklwt1LGn8eLudMr/F2U=;
        b=DXZJ3UxygHcwt/Ha22NnYjmjVvsTF2q5k2iQDCloE/XQtXoXu0gXs0MpgLg5nElxHX
         92VQKPRfQ64AJB+Z3ucjT/elxJyDkna3rqIfo8QdHFSJPyOH3R4qsP/AtIetXse1ONYd
         36iAFHEStgzGWkV4lC6x2SS4OIdDStB20P59n4sGblcn9oMkYRK1bM6HGJrIXen565+r
         ZYDbOSN3kGL0SA1ajPS1Ra1LunjlpUiJYxia0ZuilYcr8qaZ6X2rgUhRGN59WIZMi9Z+
         4nzqjnlJ4rw8bjjNa8cWGk+Ua7uV9O3opF84xIK1c6VEoDQoY7mnbtSdhvtW/3wtu62X
         e31A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jwyOhCiVlhmifA4bQDRHR85Pklwt1LGn8eLudMr/F2U=;
        b=1cwTSuEl6GKPLqw8o37W5/HSOhgjB28xny0q6V2FVY4uf0jbCNmuOJAWi7n6qdp7AQ
         XnAwptGwkibwgP6nI9IBeoNxRVZPSGAvrXOOQnNGYFCxXfmdzegTCoRXvO9xd6lx0iMS
         wx/aZXWOGMLcMeSyuiXaUwXcYXS6g7JuVbfG2X9scCBNeARGpFzFteOW3atAjFri89p7
         7WH93TFkDiQsxfo//6zgb3AJe6bnq/o8uA/WX65AgFcyquAOOiMLXXAB4qmNPM66f8M5
         8uF0Mel8l4qqRAg4ZmMRZJgNbJL6cuJLRB0wxs4MsAKbWsIHkW8hkpOSwOsmWmUtUKOy
         Otxw==
X-Gm-Message-State: AOAM533DA9dFHHghITz5LxlMJcLi/kPuURr321yQ7uCe5lsv7pxhgYKV
        XQGS/ab/h7K6SLFeF3+j6che44j99N/aoA==
X-Google-Smtp-Source: ABdhPJw89k7Fg4fI6tevke/MA4dVfBOQAF5PSa1qwrzPD2v2HDse9qwZJjlDBngFvFlQcTmuYn7KwQ==
X-Received: by 2002:a05:600c:1d28:: with SMTP id l40mr1079389wms.192.1637339263651;
        Fri, 19 Nov 2021 08:27:43 -0800 (PST)
Received: from [192.168.2.41] ([46.227.18.67])
        by smtp.gmail.com with ESMTPSA id c16sm179452wrx.96.2021.11.19.08.27.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Nov 2021 08:27:43 -0800 (PST)
Subject: Re: [PATCH 02/13] tty: serial: atmel: Check return code of
 dmaengine_submit()
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        ludovic.desroches@microchip.com, vkoul@kernel.org,
        richard.genoud@gmail.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        mripard@kernel.org, linux-arm-kernel@lists.infradead.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <20211116112036.96349-1-tudor.ambarus@microchip.com>
 <20211116112036.96349-3-tudor.ambarus@microchip.com>
From:   Richard Genoud <richard.genoud@gmail.com>
Message-ID: <e87ef826-1d03-e319-1d27-d876cf4fda5f@gmail.com>
Date:   Fri, 19 Nov 2021 17:27:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211116112036.96349-3-tudor.ambarus@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

Le 16/11/2021 à 12:20, Tudor Ambarus a écrit :
> The tx_submit() method of struct dma_async_tx_descriptor is entitled
> to do sanity checks and return errors if encountered. It's not the
> case for the DMA controller drivers that this client is using
> (at_h/xdmac), because they currently don't do sanity checks and always
> return a positive cookie at tx_submit() method. In case the controller
> drivers will implement sanity checks and return errors, print a message
> so that the client will be informed that something went wrong at
> tx_submit() level.
> 
> Fixes: 08f738be88bb ("serial: at91: add tx dma support")
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>  drivers/tty/serial/atmel_serial.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index 2c99a47a2535..376f7a9c2868 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -1004,6 +1004,11 @@ static void atmel_tx_dma(struct uart_port *port)
>  		desc->callback = atmel_complete_tx_dma;
>  		desc->callback_param = atmel_port;
>  		atmel_port->cookie_tx = dmaengine_submit(desc);
> +		if (dma_submit_error(atmel_port->cookie_tx)) {
> +			dev_err(port->dev, "dma_submit_error %d\n",
> +				atmel_port->cookie_tx);
> +			return;
> +		}
>  	}
>  
>  	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> @@ -1258,6 +1263,11 @@ static int atmel_prepare_rx_dma(struct uart_port *port)
>  	desc->callback_param = port;
>  	atmel_port->desc_rx = desc;
>  	atmel_port->cookie_rx = dmaengine_submit(desc);
> +	if (dma_submit_error(atmel_port->cookie_rx)) {
> +		dev_err(port->dev, "dma_submit_error %d\n",
> +			atmel_port->cookie_rx);
> +		goto chan_err;
> +	}
>  
>  	return 0;
>  
> 

Acked-by: Richard Genoud <richard.genoud@gmail.com>


Thanks !
