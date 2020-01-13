Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E162139D64
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jan 2020 00:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbgAMXfI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 Jan 2020 18:35:08 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46897 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729033AbgAMXfG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 13 Jan 2020 18:35:06 -0500
Received: by mail-ot1-f66.google.com with SMTP id r9so10732895otp.13
        for <dmaengine@vger.kernel.org>; Mon, 13 Jan 2020 15:35:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=F2iDZ52lWikDVmU5g/bwIONEfUCTF197jf9k+MTeRXI=;
        b=MCzTHDjWvYJ1yuPbhtjNsQeyneF+cUhsV3n/gW/QFHoEHahow+UJ+KGOO6GLNtGJyC
         6yvxVbbxIESwVJ0Tzrgsdat2U9dlBRgT0cGm/G6A1sq5CZ8esDoYq+0RtzuQqGyFjRjC
         CRxl3QYpstdo6QByWznIF3FrZS/99rVWaRKuQXlaSE5N2+clMBD+u/MKi45ZMDIVWV4q
         WxK9iCCCacAiZVI1u8f2dF1CKM3nBwSBDBTFKx0wYQcV7s6pPb8GNdjM31kxek7RgR7j
         SxVwQr+Ah8vqm2vjX9uP2+KpwYxv2R8gwgKz4w4uK838hFtFZcY+XyaxQnpOT4WFG1QF
         lfTw==
X-Gm-Message-State: APjAAAVvtbey1y8InqillnQsBksfdgjQZdqrfk7q/n/Z4aihRXxJ2ikd
        XutDty7cmsWDvqc8E+/aMCiooj5O5A==
X-Google-Smtp-Source: APXvYqwim60ixlF5nOL4S0W2YBY1CJWBzqW7uUStOrjtTUkKsxTAUlVwb3rsJ+PDcNK9Fw3sOWogCg==
X-Received: by 2002:a9d:5918:: with SMTP id t24mr15451100oth.310.1578958506331;
        Mon, 13 Jan 2020 15:35:06 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i6sm4017747oie.12.2020.01.13.15.35.02
        for <dmaengine@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 15:35:05 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 220b00
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Mon, 13 Jan 2020 17:22:57 -0600
Date:   Mon, 13 Jan 2020 17:22:57 -0600
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
Subject: Re: [PATCH v2 01/17] dt-bindings: at_xdmac: remove wildcard
Message-ID: <20200113232257.GA30124@bogus>
References: <1578673089-3484-1-git-send-email-claudiu.beznea@microchip.com>
 <1578673089-3484-2-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578673089-3484-2-git-send-email-claudiu.beznea@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, 10 Jan 2020 18:17:53 +0200, Claudiu Beznea wrote:
> Remove wildcard and use the available compatible.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  Documentation/devicetree/bindings/dma/atmel-xdma.txt | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
