Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E982313C87A
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jan 2020 16:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbgAOPzG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Jan 2020 10:55:06 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37612 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbgAOPzF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 15 Jan 2020 10:55:05 -0500
Received: by mail-oi1-f194.google.com with SMTP id z64so15848237oia.4
        for <dmaengine@vger.kernel.org>; Wed, 15 Jan 2020 07:55:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=B7DX59sNSuvGuHSzjzaWJDesXQ6glcdz/pP97LB2HkM=;
        b=cv9cOsC1awxBvUBkzgK72iS1Nr9f8fwjBw1GPX7QyAfAqV4i7G3wyHVKZEicX9/2VL
         BJX6cBxBNyDHNULRoTmtZyZhhFyJMOXHY/EEhZbheQ5sqUHqqgjkHTZmc5CXINQjlkWO
         flt2Gly6LBsKp7AFH07kmPfMN7cxMpQfaH5KjTplQo2f4ySc6QappfKuOo4NOwbFxP9a
         6EheulOR+U8XhZiu5kHpVUFsJ3kHH/FUiOpU/XLxxBmU3RcMk3c6CL9Xer/NG67WVkuT
         sy3ei4Mx+9FroOx7Hji8/U43oUo/vzxtnTcQxc+Yy3gCq7uoVCXtkFJKR+TUfa/8n4p4
         MQcw==
X-Gm-Message-State: APjAAAUUbOMBUgQQlCQts/L15E6ga60ZBfMPU9TT0JQ4qkksRyDZQru+
        n/wEX1knPfdJTg+zCznNnHRwqaw=
X-Google-Smtp-Source: APXvYqzMmaSD8m7t81Ae6UUQ7DKaH/xN2211KJVl5bO6S6hlM1QLqb2YOi05j248XjNW5S1k/yIPcQ==
X-Received: by 2002:aca:3d7:: with SMTP id 206mr366861oid.98.1579103704665;
        Wed, 15 Jan 2020 07:55:04 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j8sm2434399oii.32.2020.01.15.07.55.03
        for <dmaengine@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 07:55:03 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 22040c
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Wed, 15 Jan 2020 09:43:35 -0600
Date:   Wed, 15 Jan 2020 09:43:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     mark.rutland@arm.com, vkoul@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        ulf.hansson@linaro.org, srinivas.kandagatla@linaro.org,
        broonie@kernel.org, manivannan.sadhasivam@linaro.org,
        andrew.smirnov@gmail.com, rjones@gateworks.com,
        marcel.ziswiler@toradex.com, sebastien.szymanski@armadeus.com,
        aisheng.dong@nxp.com, richard.hu@technexion.com, angus@akkea.ca,
        cosmin.stoica@nxp.com, l.stach@pengutronix.de,
        rabeeh@solid-run.com, leonard.crestez@nxp.com,
        daniel.baluta@nxp.com, jun.li@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-spi@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH V2 4/7] dt-bindings: spi: imx: Add
 i.MX8MM/i.MX8MN/i.MX8MP compatible
Message-ID: <20200115154335.GA15650@bogus>
References: <1578893602-14395-1-git-send-email-Anson.Huang@nxp.com>
 <1578893602-14395-4-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578893602-14395-4-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Jan 13, 2020 at 01:33:19PM +0800, Anson Huang wrote:
> Add compatbile for imx8mm/imx8mn/imx8mp.

checkpatch reports a typo.

Otherwise,

Acked-by: Rob Herring <robh@kernel.org>

> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> New patch
> ---
>  Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt b/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
> index 2d32641..33bc58f 100644
> --- a/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
> +++ b/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
> @@ -10,7 +10,10 @@ Required properties:
>    - "fsl,imx35-cspi" for SPI compatible with the one integrated on i.MX35
>    - "fsl,imx51-ecspi" for SPI compatible with the one integrated on i.MX51
>    - "fsl,imx53-ecspi" for SPI compatible with the one integrated on i.MX53 and later Soc
> -  - "fsl,imx8mq-ecspi" for SPI compatible with the one integrated on i.MX8M
> +  - "fsl,imx8mq-ecspi" for SPI compatible with the one integrated on i.MX8MQ
> +  - "fsl,imx8mm-ecspi" for SPI compatible with the one integrated on i.MX8MM
> +  - "fsl,imx8mn-ecspi" for SPI compatible with the one integrated on i.MX8MN
> +  - "fsl,imx8mp-ecspi" for SPI compatible with the one integrated on i.MX8MP
>  - reg : Offset and length of the register set for the device
>  - interrupts : Should contain CSPI/eCSPI interrupt
>  - clocks : Clock specifiers for both ipg and per clocks.
> -- 
> 2.7.4
> 
