Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73F9036ECD6
	for <lists+dmaengine@lfdr.de>; Thu, 29 Apr 2021 16:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234473AbhD2O6L (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 29 Apr 2021 10:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232989AbhD2O6K (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 29 Apr 2021 10:58:10 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5DFC06138C
        for <dmaengine@vger.kernel.org>; Thu, 29 Apr 2021 07:57:23 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id n127so24224622wmb.5
        for <dmaengine@vger.kernel.org>; Thu, 29 Apr 2021 07:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=eiH4MuCFQjVyQQ5uKELhe43w/SRp+jR1z8CHl7E36wE=;
        b=aZPpvgZny57TK7CN/Bkg0Q4QZuDR+5BvD7dJAT/BQivDUKaQef0CD6EF5UTsQZ2By3
         ntjxcSE5VsjnA5L9glDTh1LQvw3ZlEb7z1kLZKtlUJo8gsNbLn7DV1OV8LKJl/rzpb59
         lADi6NYIg2GZpBNKKnh0ZBWtpYrr+2pEhn7ktjNANsQb+XmnkiKkP1RnjVGGUI37WvmR
         QF67e00zpewydOsYmNK+1gfqcqL/c5c9WQw4SemYw6KJ2A1PzMF7KvCF+uKImasrXGzt
         fS2A7e3Q5Q0U2QnGpe8OpVQIkYQtTbpm2+54YBVb+0DQ8DS5xCJnp6tx1QNJagt5AWeG
         mpgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=eiH4MuCFQjVyQQ5uKELhe43w/SRp+jR1z8CHl7E36wE=;
        b=ofnAeb9BCEPSuk1FeS4dfIVMA0HPTkRp8eqOWxwY4wUY8oQtyxAh1x743Q7ASYVHFt
         kP2Loc4x0EQ4bOaQrBfHvoCQmrNh4e/9jW7eC4gYtpNIp6dPj+dEh0aoARAexzDqM/Gd
         kRv68LVKYEqNJ0XiJglQ4G2nJFFVnSiGaHi73J8h1hTJtTn82Hk7f9kmLQm9lzI0qS7k
         FViOZR0syi2l2P3Vcb8AcPwSvPa4ifJi1RjKfhD4Xeuwa7t9P4eQkugMGjDbJVloj2W6
         MU/KLYGercr60jwyOF4XzSNls95gKRVns3M7WfusBNI3pEZhvsGUTctBtT33luDaLSbF
         wuNA==
X-Gm-Message-State: AOAM531XJ3PWv7qw24ieSNQx1QSHuqEI75ProtGG61hvvXBxFCaJsbT6
        PNbrOl9Q9sxLEcXKxDREVc3+XQ==
X-Google-Smtp-Source: ABdhPJzOSt9E9qCgBC9F2uRsvObQX80Wz+8sDrq1pZe/raJh7YUWacY024jLR+kUEa0jfU6RqAcF2A==
X-Received: by 2002:a1c:9897:: with SMTP id a145mr2535178wme.9.1619708242490;
        Thu, 29 Apr 2021 07:57:22 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id m67sm12423079wme.27.2021.04.29.07.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 07:57:21 -0700 (PDT)
Date:   Thu, 29 Apr 2021 16:57:19 +0200
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Rob Herring <robh@kernel.org>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linus.walleij@linaro.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, vkoul@kernel.org
Subject: Re: [PATCH RFC] dt-bindings: dma: convert arm-pl08x to yaml
Message-ID: <YIrJTycPqfP0UnEz@Red>
References: <20210428055750.683963-1-clabbe@baylibre.com>
 <1619648109.771241.4061028.nullmailer@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1619648109.771241.4061028.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Le Wed, Apr 28, 2021 at 05:15:09PM -0500, Rob Herring a écrit :
> On Wed, 28 Apr 2021 05:57:50 +0000, Corentin Labbe wrote:
> > Converts dma/arm-pl08x.txt to yaml.
> > In the process, I add an example for the faraday variant.
> > 
> > Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> > ---
> >  .../devicetree/bindings/dma/arm-pl08x.txt     |  59 --------
> >  .../devicetree/bindings/dma/arm-pl08x.yaml    | 127 ++++++++++++++++++
> >  2 files changed, 127 insertions(+), 59 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/dma/arm-pl08x.txt
> >  create mode 100644 Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> ./Documentation/devicetree/bindings/dma/arm-pl08x.yaml:19:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
> ./Documentation/devicetree/bindings/dma/arm-pl08x.yaml:22:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
> ./Documentation/devicetree/bindings/dma/arm-pl08x.yaml:25:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
> ./Documentation/devicetree/bindings/dma/arm-pl08x.yaml:66:9: [warning] wrong indentation: expected 6 but found 8 (indentation)
> ./Documentation/devicetree/bindings/dma/arm-pl08x.yaml:78:9: [warning] wrong indentation: expected 6 but found 8 (indentation)
> 

Hello

I have installed yamllint, so this kind of error should no happen again

> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/watchdog/arm,sp805.example.dt.yaml: watchdog@66090000: '#dma-cells' is a required property
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/watchdog/arm,sp805.example.dt.yaml: watchdog@66090000: $nodename:0: 'watchdog@66090000' does not match '^dma-controller(@.*)?$'
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/watchdog/arm,sp805.example.dt.yaml: watchdog@66090000: compatible: 'oneOf' conditional failed, one must be fixed:
> 	['arm,sp805', 'arm,primecell'] is too short
> 	'arm,pl080' was expected
> 	'arm,pl081' was expected
> 	'faraday,ftdma020' was expected
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/watchdog/arm,sp805.example.dt.yaml: watchdog@66090000: clocks: [[4294967295], [4294967295]] is too long
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/watchdog/arm,sp805.example.dt.yaml: watchdog@66090000: clock-names:0: 'apb_pclk' was expected
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/watchdog/arm,sp805.example.dt.yaml: watchdog@66090000: clock-names: ['wdog_clk', 'apb_pclk'] is too long
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/watchdog/arm,sp805.example.dt.yaml: watchdog@66090000: clock-names: Additional items are not allowed ('apb_pclk' was unexpected)
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/watchdog/arm,sp805.example.dt.yaml: watchdog@66090000: '#dma-cells' is a required property
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-pl022.example.dt.yaml: spi@e0100000: '#dma-cells' is a required property
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-pl022.example.dt.yaml: spi@e0100000: $nodename:0: 'spi@e0100000' does not match '^dma-controller(@.*)?$'
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-pl022.example.dt.yaml: spi@e0100000: compatible: 'oneOf' conditional failed, one must be fixed:
> 	['arm,pl022', 'arm,primecell'] is too short
> 	'arm,pl080' was expected
> 	'arm,pl081' was expected
> 	'faraday,ftdma020' was expected
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-pl022.example.dt.yaml: spi@e0100000: 'clocks' is a required property
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-pl022.example.dt.yaml: spi@e0100000: 'clock-names' is a required property
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-pl022.example.dt.yaml: spi@e0100000: '#dma-cells' is a required property
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/serial/pl011.example.dt.yaml: serial@80120000: '#dma-cells' is a required property
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/serial/pl011.example.dt.yaml: serial@80120000: $nodename:0: 'serial@80120000' does not match '^dma-controller(@.*)?$'
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/serial/pl011.example.dt.yaml: serial@80120000: compatible: 'oneOf' conditional failed, one must be fixed:
> 	['arm,pl011', 'arm,primecell'] is too short
> 	'arm,pl080' was expected
> 	'arm,pl081' was expected
> 	'faraday,ftdma020' was expected
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/serial/pl011.example.dt.yaml: serial@80120000: clocks: [[4294967295], [4294967295]] is too long
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/serial/pl011.example.dt.yaml: serial@80120000: clock-names:0: 'apb_pclk' was expected
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/serial/pl011.example.dt.yaml: serial@80120000: clock-names: ['uartclk', 'apb_pclk'] is too long
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/serial/pl011.example.dt.yaml: serial@80120000: clock-names: Additional items are not allowed ('apb_pclk' was unexpected)
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/serial/pl011.example.dt.yaml: serial@80120000: '#dma-cells' is a required property
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dt.yaml: cti@20020000: '#dma-cells' is a required property
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dt.yaml: cti@20020000: $nodename:0: 'cti@20020000' does not match '^dma-controller(@.*)?$'
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dt.yaml: cti@20020000: compatible: 'oneOf' conditional failed, one must be fixed:
> 	['arm,coresight-cti', 'arm,primecell'] is too short
> 	'arm,pl080' was expected
> 	'arm,pl081' was expected
> 	'faraday,ftdma020' was expected
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dt.yaml: cti@20020000: '#dma-cells' is a required property
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dt.yaml: cti@20020000: 'oneOf' conditional failed, one must be fixed:
> 	'interrupts' is a required property
> 	'interrupts-extended' is a required property
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dt.yaml: cti@859000: '#dma-cells' is a required property
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dt.yaml: cti@859000: $nodename:0: 'cti@859000' does not match '^dma-controller(@.*)?$'
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dt.yaml: cti@859000: compatible: 'oneOf' conditional failed, one must be fixed:
> 	['arm,coresight-cti-v8-arch', 'arm,coresight-cti', 'arm,primecell'] is too long
> 	Additional items are not allowed ('arm,primecell' was unexpected)
> 	'arm,pl080' was expected
> 	'arm,pl081' was expected
> 	'faraday,ftdma020' was expected
> 	'arm,primecell' was expected
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dt.yaml: cti@859000: '#dma-cells' is a required property
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dt.yaml: cti@859000: 'oneOf' conditional failed, one must be fixed:
> 	'interrupts' is a required property
> 	'interrupts-extended' is a required property
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dt.yaml: cti@858000: '#dma-cells' is a required property
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dt.yaml: cti@858000: $nodename:0: 'cti@858000' does not match '^dma-controller(@.*)?$'
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dt.yaml: cti@858000: compatible: 'oneOf' conditional failed, one must be fixed:
> 	['arm,coresight-cti', 'arm,primecell'] is too short
> 	'arm,pl080' was expected
> 	'arm,pl081' was expected
> 	'faraday,ftdma020' was expected
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dt.yaml: cti@858000: '#dma-cells' is a required property
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dt.yaml: cti@858000: 'oneOf' conditional failed, one must be fixed:
> 	'interrupts' is a required property
> 	'interrupts-extended' is a required property
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dt.yaml: cti@20110000: '#dma-cells' is a required property
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dt.yaml: cti@20110000: $nodename:0: 'cti@20110000' does not match '^dma-controller(@.*)?$'
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dt.yaml: cti@20110000: compatible: 'oneOf' conditional failed, one must be fixed:
> 	['arm,coresight-cti', 'arm,primecell'] is too short
> 	'arm,pl080' was expected
> 	'arm,pl081' was expected
> 	'faraday,ftdma020' was expected
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dt.yaml: cti@20110000: '#dma-cells' is a required property
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dt.yaml: cti@20110000: 'oneOf' conditional failed, one must be fixed:
> 	'interrupts' is a required property
> 	'interrupts-extended' is a required property
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@5000: '#dma-cells' is a required property
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@5000: $nodename:0: 'mmc@5000' does not match '^dma-controller(@.*)?$'
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@5000: compatible: 'oneOf' conditional failed, one must be fixed:
> 	['arm,pl180', 'arm,primecell'] is too short
> 	'arm,pl080' was expected
> 	'arm,pl081' was expected
> 	'faraday,ftdma020' was expected
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@5000: clocks: [[4294967295], [4294967295]] is too long
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@5000: clock-names:0: 'apb_pclk' was expected
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@5000: clock-names: ['mclk', 'apb_pclk'] is too long
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@5000: clock-names: Additional items are not allowed ('apb_pclk' was unexpected)
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@5000: '#dma-cells' is a required property
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@80126000: '#dma-cells' is a required property
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@80126000: $nodename:0: 'mmc@80126000' does not match '^dma-controller(@.*)?$'
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@80126000: compatible: 'oneOf' conditional failed, one must be fixed:
> 	['arm,pl18x', 'arm,primecell'] is too short
> 	'arm,pl080' was expected
> 	'arm,pl081' was expected
> 	'faraday,ftdma020' was expected
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@80126000: clocks: [[4294967295, 1, 5], [4294967295, 1, 5]] is too long
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@80126000: clock-names:0: 'apb_pclk' was expected
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@80126000: clock-names: ['sdi', 'apb_pclk'] is too long
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@80126000: clock-names: Additional items are not allowed ('apb_pclk' was unexpected)
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@80126000: '#dma-cells' is a required property
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@101f6000: '#dma-cells' is a required property
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@101f6000: $nodename:0: 'mmc@101f6000' does not match '^dma-controller(@.*)?$'
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@101f6000: compatible: 'oneOf' conditional failed, one must be fixed:
> 	['arm,pl18x', 'arm,primecell'] is too short
> 	'arm,pl080' was expected
> 	'arm,pl081' was expected
> 	'faraday,ftdma020' was expected
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@101f6000: clocks: [[4294967295], [4294967295]] is too long
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@101f6000: clock-names:0: 'apb_pclk' was expected
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@101f6000: clock-names: ['mclk', 'apb_pclk'] is too long
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@101f6000: clock-names: Additional items are not allowed ('apb_pclk' was unexpected)
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@101f6000: '#dma-cells' is a required property
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@52007000: '#dma-cells' is a required property
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@52007000: $nodename:0: 'mmc@52007000' does not match '^dma-controller(@.*)?$'
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@52007000: compatible: 'oneOf' conditional failed, one must be fixed:
> 	['arm,pl18x', 'arm,primecell'] is too short
> 	'arm,pl080' was expected
> 	'arm,pl081' was expected
> 	'faraday,ftdma020' was expected
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@52007000: '#dma-cells' is a required property
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/timer/arm,sp804.example.dt.yaml: timer@fc800000: '#dma-cells' is a required property
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/timer/arm,sp804.example.dt.yaml: timer@fc800000: $nodename:0: 'timer@fc800000' does not match '^dma-controller(@.*)?$'
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/timer/arm,sp804.example.dt.yaml: timer@fc800000: compatible: 'oneOf' conditional failed, one must be fixed:
> 	['arm,sp804', 'arm,primecell'] is too short
> 	'arm,pl080' was expected
> 	'arm,pl081' was expected
> 	'faraday,ftdma020' was expected
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/timer/arm,sp804.example.dt.yaml: timer@fc800000: interrupts: [[0, 0, 4], [0, 1, 4]] is too long
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/timer/arm,sp804.example.dt.yaml: timer@fc800000: clocks: [[4294967295], [4294967295], [4294967295]] is too long
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/timer/arm,sp804.example.dt.yaml: timer@fc800000: clock-names:0: 'apb_pclk' was expected
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/timer/arm,sp804.example.dt.yaml: timer@fc800000: clock-names: ['timer1', 'timer2', 'apb_pclk'] is too long
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/timer/arm,sp804.example.dt.yaml: timer@fc800000: clock-names: Additional items are not allowed ('timer2', 'apb_pclk' were unexpected)
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/timer/arm,sp804.example.dt.yaml: timer@fc800000: '#dma-cells' is a required property
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhu.example.dt.yaml: mailbox@2b1f0000: '#dma-cells' is a required property
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhu.example.dt.yaml: mailbox@2b1f0000: $nodename:0: 'mailbox@2b1f0000' does not match '^dma-controller(@.*)?$'
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhu.example.dt.yaml: mailbox@2b1f0000: compatible: 'oneOf' conditional failed, one must be fixed:
> 	['arm,mhu', 'arm,primecell'] is too short
> 	'arm,pl080' was expected
> 	'arm,pl081' was expected
> 	'faraday,ftdma020' was expected
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhu.example.dt.yaml: mailbox@2b1f0000: interrupts: [[0, 36, 4], [0, 35, 4], [0, 37, 4]] is too long
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhu.example.dt.yaml: mailbox@2b1f0000: '#dma-cells' is a required property
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhu.example.dt.yaml: mailbox@2b2f0000: '#dma-cells' is a required property
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhu.example.dt.yaml: mailbox@2b2f0000: $nodename:0: 'mailbox@2b2f0000' does not match '^dma-controller(@.*)?$'
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhu.example.dt.yaml: mailbox@2b2f0000: compatible: 'oneOf' conditional failed, one must be fixed:
> 	['arm,mhu-doorbell', 'arm,primecell'] is too short
> 	'arm,pl080' was expected
> 	'arm,pl081' was expected
> 	'faraday,ftdma020' was expected
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhu.example.dt.yaml: mailbox@2b2f0000: interrupts: [[0, 36, 4], [0, 35, 4], [0, 37, 4]] is too long
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhu.example.dt.yaml: mailbox@2b2f0000: '#dma-cells' is a required property
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhuv2.example.dt.yaml: mailbox@2b1f0000: '#dma-cells' is a required property
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhuv2.example.dt.yaml: mailbox@2b1f0000: $nodename:0: 'mailbox@2b1f0000' does not match '^dma-controller(@.*)?$'
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhuv2.example.dt.yaml: mailbox@2b1f0000: compatible: 'oneOf' conditional failed, one must be fixed:
> 	['arm,mhuv2-tx', 'arm,primecell'] is too short
> 	'arm,pl080' was expected
> 	'arm,pl081' was expected
> 	'faraday,ftdma020' was expected
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhuv2.example.dt.yaml: mailbox@2b1f0000: '#dma-cells' is a required property
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhuv2.example.dt.yaml: mailbox@2b1f1000: '#dma-cells' is a required property
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhuv2.example.dt.yaml: mailbox@2b1f1000: $nodename:0: 'mailbox@2b1f1000' does not match '^dma-controller(@.*)?$'
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhuv2.example.dt.yaml: mailbox@2b1f1000: compatible: 'oneOf' conditional failed, one must be fixed:
> 	['arm,mhuv2-rx', 'arm,primecell'] is too short
> 	'arm,pl080' was expected
> 	'arm,pl081' was expected
> 	'faraday,ftdma020' was expected
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhuv2.example.dt.yaml: mailbox@2b1f1000: '#dma-cells' is a required property
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/bus/arm,integrator-ap-lm.example.dt.yaml: serial@100000: '#dma-cells' is a required property
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/bus/arm,integrator-ap-lm.example.dt.yaml: serial@100000: $nodename:0: 'serial@100000' does not match '^dma-controller(@.*)?$'
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/bus/arm,integrator-ap-lm.example.dt.yaml: serial@100000: compatible: 'oneOf' conditional failed, one must be fixed:
> 	['arm,pl011', 'arm,primecell'] is too short
> 	'arm,pl080' was expected
> 	'arm,pl081' was expected
> 	'faraday,ftdma020' was expected
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/bus/arm,integrator-ap-lm.example.dt.yaml: serial@100000: 'clocks' is a required property
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/bus/arm,integrator-ap-lm.example.dt.yaml: serial@100000: 'clock-names' is a required property
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/bus/arm,integrator-ap-lm.example.dt.yaml: serial@100000: '#dma-cells' is a required property
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.example.dt.yaml: mmc@80118000: '#dma-cells' is a required property
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.example.dt.yaml: mmc@80118000: $nodename:0: 'mmc@80118000' does not match '^dma-controller(@.*)?$'
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.example.dt.yaml: mmc@80118000: compatible: 'oneOf' conditional failed, one must be fixed:
> 	['arm,pl18x', 'arm,primecell'] is too short
> 	'arm,pl080' was expected
> 	'arm,pl081' was expected
> 	'faraday,ftdma020' was expected
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.example.dt.yaml: mmc@80118000: clocks: [[4294967295, 0], [4294967295, 1]] is too long
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.example.dt.yaml: mmc@80118000: clock-names:0: 'apb_pclk' was expected
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.example.dt.yaml: mmc@80118000: clock-names: ['mclk', 'apb_pclk'] is too long
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.example.dt.yaml: mmc@80118000: clock-names: Additional items are not allowed ('apb_pclk' was unexpected)
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.example.dt.yaml: mmc@80118000: '#dma-cells' is a required property
> 	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> Error: Documentation/devicetree/bindings/dma/arm-pl08x.example.dts:56.27-28 syntax error
> FATAL ERROR: Unable to parse input tree
> make[1]: *** [scripts/Makefile.lib:377: Documentation/devicetree/bindings/dma/arm-pl08x.example.dt.yaml] Error 1
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile:1414: dt_binding_check] Error 2
> 

Most of thoses error came from the fact the compatible end with "arm,primecell".
So it try to match against the wrong dt-binding.

Does there is any correct way to limit/prevent this ?

Regards
