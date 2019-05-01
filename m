Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5624D10DB7
	for <lists+dmaengine@lfdr.de>; Wed,  1 May 2019 22:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbfEAUHO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 1 May 2019 16:07:14 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36899 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfEAUHO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 1 May 2019 16:07:14 -0400
Received: by mail-oi1-f196.google.com with SMTP id 143so1525382oii.4;
        Wed, 01 May 2019 13:07:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mKg6SA0SX5HV854mYVNTFbSlG/IOsGPH6fFYgeCQFmk=;
        b=LslzHIYy8d9It+IUvj6m0PERlqGiIrc6DAUtHdG5a1B6oZgVZ7XprLQRU+YHmzgPIz
         c3M4M+7nQ7bMkcA18iWQxvWWAfORw9anlP4HQk+htJnKVGGmYsbHe7Zot1Cp0AZ+dack
         YBx8H2gVReWnZwFhB+u7zXjMhSVhtt1Z0lMPqEKFPQZCbt+ox6NCdAN1xLio3+cRlQMa
         zC4yFF9XaNcC+Nr7O2MeRQlMS74qwX/GR1vX6muBBB/7ECZUAsCi3fNYM5seUr7v+aAn
         7BGufZwXeoiiVw5cB1U7YjtWHL52mxnK9ch4/cpKd4G9EzrmEnxD53Pu+Q9/ZNuQO2xD
         viSg==
X-Gm-Message-State: APjAAAWBgcviHFexS90izNnp2e05YVA3f11umLcIuO5PqvuZTATj9mNz
        h1pKlVGeel7lnTm74BTQ0g==
X-Google-Smtp-Source: APXvYqx5r0LA6i5YuqMDOd9NBN4QAPVZsvNiRZb0YS/Pv4676PBqH7lCEcuJdpsY+bfpypfvpEhe4g==
X-Received: by 2002:aca:ec41:: with SMTP id k62mr42673oih.147.1556741233322;
        Wed, 01 May 2019 13:07:13 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id h24sm15848390otr.39.2019.05.01.13.07.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 May 2019 13:07:12 -0700 (PDT)
Date:   Wed, 1 May 2019 15:07:11 -0500
From:   Rob Herring <robh@kernel.org>
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     "broonie@kernel.org" <broonie@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "plyatov@gmail.com" <plyatov@gmail.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH v2 08/15] dt-bindings: spi: imx: add i.mx6ul to state
 errata fixed
Message-ID: <20190501200711.GA31231@bogus>
References: <1556265512-9130-1-git-send-email-yibin.gong@nxp.com>
 <1556265512-9130-9-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556265512-9130-9-git-send-email-yibin.gong@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Apr 26, 2019 at 08:05:51AM +0000, Robin Gong wrote:
> ERR009165 fixed from i.mx6ul, add it to show the errata fixed.
> 
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> ---
>  Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt b/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
> index 2d32641..32c4263d 100644
> --- a/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
> +++ b/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
> @@ -10,6 +10,8 @@ Required properties:
>    - "fsl,imx35-cspi" for SPI compatible with the one integrated on i.MX35
>    - "fsl,imx51-ecspi" for SPI compatible with the one integrated on i.MX51
>    - "fsl,imx53-ecspi" for SPI compatible with the one integrated on i.MX53 and later Soc
> +  - "fsl,imx6ul-ecspi" ERR009165 fixed on i.MX6UL and later Soc
> +    (https://www.nxp.com/docs/en/errata/IMX6DQCE.pdf)

What about other i.MX6 chips?

Seems like this is missing some fallbacks. The binding doc should make 
it clear what are all valid combinations of compatible strings.

>    - "fsl,imx8mq-ecspi" for SPI compatible with the one integrated on i.MX8M
>  - reg : Offset and length of the register set for the device
>  - interrupts : Should contain CSPI/eCSPI interrupt
> -- 
> 2.7.4
> 
