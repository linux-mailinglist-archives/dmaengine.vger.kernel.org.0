Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E45AB36E16E
	for <lists+dmaengine@lfdr.de>; Thu, 29 Apr 2021 00:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbhD1WQL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Apr 2021 18:16:11 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:43729 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbhD1WQF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 28 Apr 2021 18:16:05 -0400
Received: by mail-ot1-f52.google.com with SMTP id u21-20020a0568301195b02902a2119f7613so12869957otq.10;
        Wed, 28 Apr 2021 15:15:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=iU3ZU9/Ent5blXD9jLIsALMQjQlkmzvpnQy00EW909U=;
        b=l87jQcq6EJOkCR6TGh1Otz3nYgoeOrtUVue3zC0UIgT6LihoGKVZdFzkSgVlaZDrV/
         19IkwUc6uPMG+EK5wOPG166/VYOigZjmXFYH5x07AEcyfWw+rzrEUdYPhr8vkRgtevRP
         o5MKqcDkJda23ZQ83Eu9pssdgu7Ibet71Iyl9h7fbCIZ6r8de9YwLuWh7wlWIiPNcAyf
         SGPLuDa6AKGcvj6V42+rREemRlqRnlJIA5ZXGDYw32Hv/imdNJiAeKdBmvYTO0H18Spq
         hNcuz4vlo0pxmEnVEkmmv9HS0ISniirOWz/lAUfICbeHtokuwOgoiCwRA/rJLpSt4KfY
         dulA==
X-Gm-Message-State: AOAM531BdTQxP/3ti2m37Yktl87D2bFFHtRkYWZ6A+B6ikrL7DSPvaL2
        aaGCsH0qHA01K/XrVs+YLA==
X-Google-Smtp-Source: ABdhPJxlwhLOHk7JnzWR5v8h353/uWyjIL/jmDqpSX3b6V8AHdTajqumfJeCdNKO4Z88ztDIhSO6ww==
X-Received: by 2002:a9d:6e1a:: with SMTP id e26mr18649169otr.83.1619648119192;
        Wed, 28 Apr 2021 15:15:19 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v15sm223641ots.76.2021.04.28.15.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 15:15:18 -0700 (PDT)
Received: (nullmailer pid 4061029 invoked by uid 1000);
        Wed, 28 Apr 2021 22:15:09 -0000
From:   Rob Herring <robh@kernel.org>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linus.walleij@linaro.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, vkoul@kernel.org
In-Reply-To: <20210428055750.683963-1-clabbe@baylibre.com>
References: <20210428055750.683963-1-clabbe@baylibre.com>
Subject: Re: [PATCH RFC] dt-bindings: dma: convert arm-pl08x to yaml
Date:   Wed, 28 Apr 2021 17:15:09 -0500
Message-Id: <1619648109.771241.4061028.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, 28 Apr 2021 05:57:50 +0000, Corentin Labbe wrote:
> Converts dma/arm-pl08x.txt to yaml.
> In the process, I add an example for the faraday variant.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  .../devicetree/bindings/dma/arm-pl08x.txt     |  59 --------
>  .../devicetree/bindings/dma/arm-pl08x.yaml    | 127 ++++++++++++++++++
>  2 files changed, 127 insertions(+), 59 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/dma/arm-pl08x.txt
>  create mode 100644 Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/dma/arm-pl08x.yaml:19:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
./Documentation/devicetree/bindings/dma/arm-pl08x.yaml:22:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
./Documentation/devicetree/bindings/dma/arm-pl08x.yaml:25:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
./Documentation/devicetree/bindings/dma/arm-pl08x.yaml:66:9: [warning] wrong indentation: expected 6 but found 8 (indentation)
./Documentation/devicetree/bindings/dma/arm-pl08x.yaml:78:9: [warning] wrong indentation: expected 6 but found 8 (indentation)

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/watchdog/arm,sp805.example.dt.yaml: watchdog@66090000: '#dma-cells' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/watchdog/arm,sp805.example.dt.yaml: watchdog@66090000: $nodename:0: 'watchdog@66090000' does not match '^dma-controller(@.*)?$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/watchdog/arm,sp805.example.dt.yaml: watchdog@66090000: compatible: 'oneOf' conditional failed, one must be fixed:
	['arm,sp805', 'arm,primecell'] is too short
	'arm,pl080' was expected
	'arm,pl081' was expected
	'faraday,ftdma020' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/watchdog/arm,sp805.example.dt.yaml: watchdog@66090000: clocks: [[4294967295], [4294967295]] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/watchdog/arm,sp805.example.dt.yaml: watchdog@66090000: clock-names:0: 'apb_pclk' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/watchdog/arm,sp805.example.dt.yaml: watchdog@66090000: clock-names: ['wdog_clk', 'apb_pclk'] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/watchdog/arm,sp805.example.dt.yaml: watchdog@66090000: clock-names: Additional items are not allowed ('apb_pclk' was unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/watchdog/arm,sp805.example.dt.yaml: watchdog@66090000: '#dma-cells' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-pl022.example.dt.yaml: spi@e0100000: '#dma-cells' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-pl022.example.dt.yaml: spi@e0100000: $nodename:0: 'spi@e0100000' does not match '^dma-controller(@.*)?$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-pl022.example.dt.yaml: spi@e0100000: compatible: 'oneOf' conditional failed, one must be fixed:
	['arm,pl022', 'arm,primecell'] is too short
	'arm,pl080' was expected
	'arm,pl081' was expected
	'faraday,ftdma020' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-pl022.example.dt.yaml: spi@e0100000: 'clocks' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-pl022.example.dt.yaml: spi@e0100000: 'clock-names' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-pl022.example.dt.yaml: spi@e0100000: '#dma-cells' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/serial/pl011.example.dt.yaml: serial@80120000: '#dma-cells' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/serial/pl011.example.dt.yaml: serial@80120000: $nodename:0: 'serial@80120000' does not match '^dma-controller(@.*)?$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/serial/pl011.example.dt.yaml: serial@80120000: compatible: 'oneOf' conditional failed, one must be fixed:
	['arm,pl011', 'arm,primecell'] is too short
	'arm,pl080' was expected
	'arm,pl081' was expected
	'faraday,ftdma020' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/serial/pl011.example.dt.yaml: serial@80120000: clocks: [[4294967295], [4294967295]] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/serial/pl011.example.dt.yaml: serial@80120000: clock-names:0: 'apb_pclk' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/serial/pl011.example.dt.yaml: serial@80120000: clock-names: ['uartclk', 'apb_pclk'] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/serial/pl011.example.dt.yaml: serial@80120000: clock-names: Additional items are not allowed ('apb_pclk' was unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/serial/pl011.example.dt.yaml: serial@80120000: '#dma-cells' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dt.yaml: cti@20020000: '#dma-cells' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dt.yaml: cti@20020000: $nodename:0: 'cti@20020000' does not match '^dma-controller(@.*)?$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dt.yaml: cti@20020000: compatible: 'oneOf' conditional failed, one must be fixed:
	['arm,coresight-cti', 'arm,primecell'] is too short
	'arm,pl080' was expected
	'arm,pl081' was expected
	'faraday,ftdma020' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dt.yaml: cti@20020000: '#dma-cells' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dt.yaml: cti@20020000: 'oneOf' conditional failed, one must be fixed:
	'interrupts' is a required property
	'interrupts-extended' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dt.yaml: cti@859000: '#dma-cells' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dt.yaml: cti@859000: $nodename:0: 'cti@859000' does not match '^dma-controller(@.*)?$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dt.yaml: cti@859000: compatible: 'oneOf' conditional failed, one must be fixed:
	['arm,coresight-cti-v8-arch', 'arm,coresight-cti', 'arm,primecell'] is too long
	Additional items are not allowed ('arm,primecell' was unexpected)
	'arm,pl080' was expected
	'arm,pl081' was expected
	'faraday,ftdma020' was expected
	'arm,primecell' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dt.yaml: cti@859000: '#dma-cells' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dt.yaml: cti@859000: 'oneOf' conditional failed, one must be fixed:
	'interrupts' is a required property
	'interrupts-extended' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dt.yaml: cti@858000: '#dma-cells' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dt.yaml: cti@858000: $nodename:0: 'cti@858000' does not match '^dma-controller(@.*)?$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dt.yaml: cti@858000: compatible: 'oneOf' conditional failed, one must be fixed:
	['arm,coresight-cti', 'arm,primecell'] is too short
	'arm,pl080' was expected
	'arm,pl081' was expected
	'faraday,ftdma020' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dt.yaml: cti@858000: '#dma-cells' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dt.yaml: cti@858000: 'oneOf' conditional failed, one must be fixed:
	'interrupts' is a required property
	'interrupts-extended' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dt.yaml: cti@20110000: '#dma-cells' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dt.yaml: cti@20110000: $nodename:0: 'cti@20110000' does not match '^dma-controller(@.*)?$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dt.yaml: cti@20110000: compatible: 'oneOf' conditional failed, one must be fixed:
	['arm,coresight-cti', 'arm,primecell'] is too short
	'arm,pl080' was expected
	'arm,pl081' was expected
	'faraday,ftdma020' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dt.yaml: cti@20110000: '#dma-cells' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dt.yaml: cti@20110000: 'oneOf' conditional failed, one must be fixed:
	'interrupts' is a required property
	'interrupts-extended' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@5000: '#dma-cells' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@5000: $nodename:0: 'mmc@5000' does not match '^dma-controller(@.*)?$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@5000: compatible: 'oneOf' conditional failed, one must be fixed:
	['arm,pl180', 'arm,primecell'] is too short
	'arm,pl080' was expected
	'arm,pl081' was expected
	'faraday,ftdma020' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@5000: clocks: [[4294967295], [4294967295]] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@5000: clock-names:0: 'apb_pclk' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@5000: clock-names: ['mclk', 'apb_pclk'] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@5000: clock-names: Additional items are not allowed ('apb_pclk' was unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@5000: '#dma-cells' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@80126000: '#dma-cells' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@80126000: $nodename:0: 'mmc@80126000' does not match '^dma-controller(@.*)?$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@80126000: compatible: 'oneOf' conditional failed, one must be fixed:
	['arm,pl18x', 'arm,primecell'] is too short
	'arm,pl080' was expected
	'arm,pl081' was expected
	'faraday,ftdma020' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@80126000: clocks: [[4294967295, 1, 5], [4294967295, 1, 5]] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@80126000: clock-names:0: 'apb_pclk' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@80126000: clock-names: ['sdi', 'apb_pclk'] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@80126000: clock-names: Additional items are not allowed ('apb_pclk' was unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@80126000: '#dma-cells' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@101f6000: '#dma-cells' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@101f6000: $nodename:0: 'mmc@101f6000' does not match '^dma-controller(@.*)?$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@101f6000: compatible: 'oneOf' conditional failed, one must be fixed:
	['arm,pl18x', 'arm,primecell'] is too short
	'arm,pl080' was expected
	'arm,pl081' was expected
	'faraday,ftdma020' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@101f6000: clocks: [[4294967295], [4294967295]] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@101f6000: clock-names:0: 'apb_pclk' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@101f6000: clock-names: ['mclk', 'apb_pclk'] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@101f6000: clock-names: Additional items are not allowed ('apb_pclk' was unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@101f6000: '#dma-cells' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@52007000: '#dma-cells' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@52007000: $nodename:0: 'mmc@52007000' does not match '^dma-controller(@.*)?$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@52007000: compatible: 'oneOf' conditional failed, one must be fixed:
	['arm,pl18x', 'arm,primecell'] is too short
	'arm,pl080' was expected
	'arm,pl081' was expected
	'faraday,ftdma020' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@52007000: '#dma-cells' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/timer/arm,sp804.example.dt.yaml: timer@fc800000: '#dma-cells' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/timer/arm,sp804.example.dt.yaml: timer@fc800000: $nodename:0: 'timer@fc800000' does not match '^dma-controller(@.*)?$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/timer/arm,sp804.example.dt.yaml: timer@fc800000: compatible: 'oneOf' conditional failed, one must be fixed:
	['arm,sp804', 'arm,primecell'] is too short
	'arm,pl080' was expected
	'arm,pl081' was expected
	'faraday,ftdma020' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/timer/arm,sp804.example.dt.yaml: timer@fc800000: interrupts: [[0, 0, 4], [0, 1, 4]] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/timer/arm,sp804.example.dt.yaml: timer@fc800000: clocks: [[4294967295], [4294967295], [4294967295]] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/timer/arm,sp804.example.dt.yaml: timer@fc800000: clock-names:0: 'apb_pclk' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/timer/arm,sp804.example.dt.yaml: timer@fc800000: clock-names: ['timer1', 'timer2', 'apb_pclk'] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/timer/arm,sp804.example.dt.yaml: timer@fc800000: clock-names: Additional items are not allowed ('timer2', 'apb_pclk' were unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/timer/arm,sp804.example.dt.yaml: timer@fc800000: '#dma-cells' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhu.example.dt.yaml: mailbox@2b1f0000: '#dma-cells' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhu.example.dt.yaml: mailbox@2b1f0000: $nodename:0: 'mailbox@2b1f0000' does not match '^dma-controller(@.*)?$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhu.example.dt.yaml: mailbox@2b1f0000: compatible: 'oneOf' conditional failed, one must be fixed:
	['arm,mhu', 'arm,primecell'] is too short
	'arm,pl080' was expected
	'arm,pl081' was expected
	'faraday,ftdma020' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhu.example.dt.yaml: mailbox@2b1f0000: interrupts: [[0, 36, 4], [0, 35, 4], [0, 37, 4]] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhu.example.dt.yaml: mailbox@2b1f0000: '#dma-cells' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhu.example.dt.yaml: mailbox@2b2f0000: '#dma-cells' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhu.example.dt.yaml: mailbox@2b2f0000: $nodename:0: 'mailbox@2b2f0000' does not match '^dma-controller(@.*)?$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhu.example.dt.yaml: mailbox@2b2f0000: compatible: 'oneOf' conditional failed, one must be fixed:
	['arm,mhu-doorbell', 'arm,primecell'] is too short
	'arm,pl080' was expected
	'arm,pl081' was expected
	'faraday,ftdma020' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhu.example.dt.yaml: mailbox@2b2f0000: interrupts: [[0, 36, 4], [0, 35, 4], [0, 37, 4]] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhu.example.dt.yaml: mailbox@2b2f0000: '#dma-cells' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhuv2.example.dt.yaml: mailbox@2b1f0000: '#dma-cells' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhuv2.example.dt.yaml: mailbox@2b1f0000: $nodename:0: 'mailbox@2b1f0000' does not match '^dma-controller(@.*)?$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhuv2.example.dt.yaml: mailbox@2b1f0000: compatible: 'oneOf' conditional failed, one must be fixed:
	['arm,mhuv2-tx', 'arm,primecell'] is too short
	'arm,pl080' was expected
	'arm,pl081' was expected
	'faraday,ftdma020' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhuv2.example.dt.yaml: mailbox@2b1f0000: '#dma-cells' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhuv2.example.dt.yaml: mailbox@2b1f1000: '#dma-cells' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhuv2.example.dt.yaml: mailbox@2b1f1000: $nodename:0: 'mailbox@2b1f1000' does not match '^dma-controller(@.*)?$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhuv2.example.dt.yaml: mailbox@2b1f1000: compatible: 'oneOf' conditional failed, one must be fixed:
	['arm,mhuv2-rx', 'arm,primecell'] is too short
	'arm,pl080' was expected
	'arm,pl081' was expected
	'faraday,ftdma020' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhuv2.example.dt.yaml: mailbox@2b1f1000: '#dma-cells' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/bus/arm,integrator-ap-lm.example.dt.yaml: serial@100000: '#dma-cells' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/bus/arm,integrator-ap-lm.example.dt.yaml: serial@100000: $nodename:0: 'serial@100000' does not match '^dma-controller(@.*)?$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/bus/arm,integrator-ap-lm.example.dt.yaml: serial@100000: compatible: 'oneOf' conditional failed, one must be fixed:
	['arm,pl011', 'arm,primecell'] is too short
	'arm,pl080' was expected
	'arm,pl081' was expected
	'faraday,ftdma020' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/bus/arm,integrator-ap-lm.example.dt.yaml: serial@100000: 'clocks' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/bus/arm,integrator-ap-lm.example.dt.yaml: serial@100000: 'clock-names' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/bus/arm,integrator-ap-lm.example.dt.yaml: serial@100000: '#dma-cells' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.example.dt.yaml: mmc@80118000: '#dma-cells' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.example.dt.yaml: mmc@80118000: $nodename:0: 'mmc@80118000' does not match '^dma-controller(@.*)?$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.example.dt.yaml: mmc@80118000: compatible: 'oneOf' conditional failed, one must be fixed:
	['arm,pl18x', 'arm,primecell'] is too short
	'arm,pl080' was expected
	'arm,pl081' was expected
	'faraday,ftdma020' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.example.dt.yaml: mmc@80118000: clocks: [[4294967295, 0], [4294967295, 1]] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.example.dt.yaml: mmc@80118000: clock-names:0: 'apb_pclk' was expected
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.example.dt.yaml: mmc@80118000: clock-names: ['mclk', 'apb_pclk'] is too long
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.example.dt.yaml: mmc@80118000: clock-names: Additional items are not allowed ('apb_pclk' was unexpected)
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.example.dt.yaml: mmc@80118000: '#dma-cells' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
Error: Documentation/devicetree/bindings/dma/arm-pl08x.example.dts:56.27-28 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:377: Documentation/devicetree/bindings/dma/arm-pl08x.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1414: dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1470980

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

