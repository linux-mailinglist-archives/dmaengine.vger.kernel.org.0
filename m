Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3C9139D3A
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jan 2020 00:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729290AbgAMXX0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 Jan 2020 18:23:26 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39597 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728897AbgAMXX0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 13 Jan 2020 18:23:26 -0500
Received: by mail-ot1-f67.google.com with SMTP id 77so10726072oty.6
        for <dmaengine@vger.kernel.org>; Mon, 13 Jan 2020 15:23:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oyL/JS9B7rUgj8Iql4HM1FyxI7CsxZnIzSDjO8scpzY=;
        b=tuqM6sNfra1X4BAzyjoz3wJ/Ow0tBm4oPr/CaiU6J/8BUlw5AKM8zprEyYQrT1BcFv
         cs6l249IRiAubLMqOEdUKnSQO18JZUOWEhwMsG+mmVQ8hKvr85CtO5PH5M+1WMaRHcDz
         Iu4ZK856BnnJWY0UvjV+A+GbqJbAtLTOytI4/FEskL4niy1dIXmzTZDw6GbdQ08/NkNM
         3+cFUR0Fbh+NHBjzdQhKjJdUSDfPV4b3yquQ213x/1LoqPZQGHY8JRZDcVpzSgbN7HMU
         3XMapDpBZRLP8nRSQjCOgaYUxgdV4N6IeQBR81S56y0YvGcOfNSItjMOQk8r2q8iAQ/B
         U3+Q==
X-Gm-Message-State: APjAAAWq8OZkcGX9qk61PxbQ+xmWKfHMtrWLts+7YOJi8H1S+YDWY8ds
        UTzJBR9IsfZJS4liA3mu9bke68aTzA==
X-Google-Smtp-Source: APXvYqxjPGUyzDeRMeltXxd6YZuHMw6yJjartE/sTdp+T4bIPL4PsrwzJZ+UTgRdFK1OwTjaz68oxQ==
X-Received: by 2002:a05:6830:108a:: with SMTP id y10mr14882664oto.81.1578957805050;
        Mon, 13 Jan 2020 15:23:25 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p21sm4733182otc.21.2020.01.13.15.23.23
        for <dmaengine@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 15:23:24 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 221a32
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Mon, 13 Jan 2020 17:23:23 -0600
Date:   Mon, 13 Jan 2020 17:23:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, vkoul@kernel.org,
        eugen.hristev@microchip.com, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, mchehab@kernel.org,
        lee.jones@linaro.org, radu_nicolae.pirea@upb.ro,
        richard.genoud@gmail.com, tudor.ambarus@microchip.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        wg@grandegger.com, mkl@pengutronix.de, a.zummo@towertech.it,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-media@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-can@vger.kernel.org, linux-rtc@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: Re: [PATCH v2 03/17] dt-bindings: atmel-can: add
 microchip,sam9x60-can
Message-ID: <20200113232323.GA31125@bogus>
References: <1578673089-3484-1-git-send-email-claudiu.beznea@microchip.com>
 <1578673089-3484-4-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578673089-3484-4-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, 10 Jan 2020 18:17:55 +0200, Claudiu Beznea wrote:
> Add microchip,sam9x60-can to DT bindings documentation.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  Documentation/devicetree/bindings/net/can/atmel-can.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
