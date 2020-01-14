Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D83E6139E15
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jan 2020 01:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbgANAZH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 Jan 2020 19:25:07 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:32999 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728802AbgANAZE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 13 Jan 2020 19:25:04 -0500
Received: by mail-ot1-f67.google.com with SMTP id b18so10901681otp.0
        for <dmaengine@vger.kernel.org>; Mon, 13 Jan 2020 16:25:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UiO2+Fp93HhiZmZTyPCKddyYzvj9rECWLiqMRlRa5BM=;
        b=FWiszY5Y4ei7cJ/hdoact5dIwJgB4tuWS7G4R3IBVjCp1V+7C+ae4kk0KAHUkDIG6Q
         +tmPcRBSMWcKjscj36wtHgro0rElBImRJy2yfBAfyKgw6G19BETWp64y4Z0GItMGDY6M
         S3VmTn3iXTQIa1eZKKLy+PCj/JoKKQVjw5cIm3nffmxFpIL0OWV5BTXUTTMnulNEz4hv
         4LT4ltD2DkXjuJk2tK1LSKIBz5puqGRVf7UL6WDDdLnmU8E5WuzpGswMtZ1851DKfLn4
         DdtWmhb1IZQdEtf9ZLNNrc95TGOg+ZUb3ty6k2FBePy7zHS676u79wjH2sjBbY+crnxM
         sk1Q==
X-Gm-Message-State: APjAAAX1HEyM05vearpdrcQ3RxgHZCkF2REbjW13fUEgpIxQBU0AVYMI
        VJ8koGVm8FLkpfYS0ojVLQcTzWdV+Q==
X-Google-Smtp-Source: APXvYqzDPNRfUD//lDn8xie/6U5U3p92ILbyq6+HcOg01deH54KivJLPm9Jd22voAB/b5AK0BsKJQQ==
X-Received: by 2002:a05:6830:22ee:: with SMTP id t14mr14476047otc.236.1578961503798;
        Mon, 13 Jan 2020 16:25:03 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p65sm4078774oif.47.2020.01.13.16.25.02
        for <dmaengine@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 16:25:03 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 220b00
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Mon, 13 Jan 2020 18:18:03 -0600
Date:   Mon, 13 Jan 2020 18:18:03 -0600
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
Subject: Re: [PATCH v2 10/17] dt-bindings: atmel-smc: add
 microchip,sam9x60-smc
Message-ID: <20200114001803.GA13249@bogus>
References: <1578673089-3484-1-git-send-email-claudiu.beznea@microchip.com>
 <1578673089-3484-11-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578673089-3484-11-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, 10 Jan 2020 18:18:02 +0200, Claudiu Beznea wrote:
> Add microchip,sam9x60-smc to DT bindings documentation.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  Documentation/devicetree/bindings/mfd/atmel-smc.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
