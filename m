Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B99336F073
	for <lists+dmaengine@lfdr.de>; Thu, 29 Apr 2021 21:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbhD2TYw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 29 Apr 2021 15:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234604AbhD2TVd (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 29 Apr 2021 15:21:33 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1446AC06138B
        for <dmaengine@vger.kernel.org>; Thu, 29 Apr 2021 12:20:46 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id k4-20020a7bc4040000b02901331d89fb83so372974wmi.5
        for <dmaengine@vger.kernel.org>; Thu, 29 Apr 2021 12:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=t6SlMHHlQFE1OQOM+1rvg/8m8TUkrk0fqhLulvR2tXA=;
        b=QlBoKZlF8hNQi8fLH8o2SbnChMI4wvY7s19HrDaXe0EHprDcPRiOglEgbqZuEZtWcV
         7jM3k7XgkWRTkj4O9uVLo97CfC1wDtCU/JyLSUMuZLm7Rr2wg597XsUJIpV4UDvQm7Cq
         cl8EdeNyTvxqZWqToNm8SxWRAOsLubHCLyL/L9SxTi0az5d6kW9meRtxL9xWcL8hoYhp
         5CSzHz7HZ+qfS6Wul1dXwTeTKujotj++Af1CVmMpLMqpD1JNGrEIdy5ccV4uRMm762Yi
         lDsU6p2NAKWiW5rAKQ30KLoVQiXaTTDmKSYjwgGV/xvX+y17Q8X5NjoQll92izDz+pqZ
         jLyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=t6SlMHHlQFE1OQOM+1rvg/8m8TUkrk0fqhLulvR2tXA=;
        b=BLq+DKuTlhcdAcEnKOkbdLCFLitPtT7wNQ7NuABsxGOgPH+Fkdi5OhlnU+n7W/1JGh
         Tzc6FNsqipKsT2ptBp7D7yTG8htJINZmo7MtZlJdQ5N521Ny0x0LFnVpwni9f7hZJ3A0
         Uw3Cq5Lu9IHRQVLR2DnDhcUSCdpepVc27dYavlGR2rZ28rmyrpoWlCesveymcE4eD1pV
         t1yUtI7DGHWhlRhOkSue8LTj9Xe46+viqtga8qzJDMaWRTXsY7YbRYRWgFwSokOvSkh2
         OEjj+zdNacNHC/dHR9gkumUwbKjbG0hrtl/W1VK6vQr6z5fKFJFwdU9COVYLnxo1fuTo
         vPaw==
X-Gm-Message-State: AOAM5316ZVGVWeABsyo2IsC/ABSGG+wJd2/4Shn1X1ZtdbAVg2veJxjd
        HG+SKWGwj/xKIns22WkpvUgKZkidn8fKoA==
X-Google-Smtp-Source: ABdhPJxC1Pn/a5sMYc2QenurxvvHOCbSN+quNjLhergsfpWTGttP39V6khjoJjZvMrb2IAsFHsr/hw==
X-Received: by 2002:a1c:7903:: with SMTP id l3mr12733535wme.0.1619724044677;
        Thu, 29 Apr 2021 12:20:44 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id m184sm1069883wme.40.2021.04.29.12.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 12:20:44 -0700 (PDT)
Date:   Thu, 29 Apr 2021 21:20:42 +0200
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>, Vinod <vkoul@kernel.org>
Subject: Re: [PATCH RFC] dt-bindings: dma: convert arm-pl08x to yaml
Message-ID: <YIsHCnMm+mDBA+yo@Red>
References: <20210428055750.683963-1-clabbe@baylibre.com>
 <1619648109.771241.4061028.nullmailer@robh.at.kernel.org>
 <YIrJTycPqfP0UnEz@Red>
 <CAL_JsqJab4wmfDSyz-uQpp24Qcus8j=Vks8Yfk472rgXyd5U6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqJab4wmfDSyz-uQpp24Qcus8j=Vks8Yfk472rgXyd5U6g@mail.gmail.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Le Thu, Apr 29, 2021 at 11:12:45AM -0500, Rob Herring a écrit :
> On Thu, Apr 29, 2021 at 9:57 AM LABBE Corentin <clabbe@baylibre.com> wrote:
> >
> > Le Wed, Apr 28, 2021 at 05:15:09PM -0500, Rob Herring a écrit :
> > > On Wed, 28 Apr 2021 05:57:50 +0000, Corentin Labbe wrote:
> > > > Converts dma/arm-pl08x.txt to yaml.
> > > > In the process, I add an example for the faraday variant.
> > > >
> > > > Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> > > > ---
> > > >  .../devicetree/bindings/dma/arm-pl08x.txt     |  59 --------
> > > >  .../devicetree/bindings/dma/arm-pl08x.yaml    | 127 ++++++++++++++++++
> > > >  2 files changed, 127 insertions(+), 59 deletions(-)
> > > >  delete mode 100644 Documentation/devicetree/bindings/dma/arm-pl08x.txt
> > > >  create mode 100644 Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > >
> > >
> > > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> > >
> > > yamllint warnings/errors:
> > > ./Documentation/devicetree/bindings/dma/arm-pl08x.yaml:19:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
> > > ./Documentation/devicetree/bindings/dma/arm-pl08x.yaml:22:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
> > > ./Documentation/devicetree/bindings/dma/arm-pl08x.yaml:25:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
> > > ./Documentation/devicetree/bindings/dma/arm-pl08x.yaml:66:9: [warning] wrong indentation: expected 6 but found 8 (indentation)
> > > ./Documentation/devicetree/bindings/dma/arm-pl08x.yaml:78:9: [warning] wrong indentation: expected 6 but found 8 (indentation)
> > >
> >
> > Hello
> >
> > I have installed yamllint, so this kind of error should no happen again
> >
> > > dtschema/dtc warnings/errors:
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/watchdog/arm,sp805.example.dt.yaml: watchdog@66090000: '#dma-cells' is a required property
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/watchdog/arm,sp805.example.dt.yaml: watchdog@66090000: $nodename:0: 'watchdog@66090000' does not match '^dma-controller(@.*)?$'
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/watchdog/arm,sp805.example.dt.yaml: watchdog@66090000: compatible: 'oneOf' conditional failed, one must be fixed:
> > >       ['arm,sp805', 'arm,primecell'] is too short
> > >       'arm,pl080' was expected
> > >       'arm,pl081' was expected
> > >       'faraday,ftdma020' was expected
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/watchdog/arm,sp805.example.dt.yaml: watchdog@66090000: clocks: [[4294967295], [4294967295]] is too long
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/watchdog/arm,sp805.example.dt.yaml: watchdog@66090000: clock-names:0: 'apb_pclk' was expected
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/watchdog/arm,sp805.example.dt.yaml: watchdog@66090000: clock-names: ['wdog_clk', 'apb_pclk'] is too long
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/watchdog/arm,sp805.example.dt.yaml: watchdog@66090000: clock-names: Additional items are not allowed ('apb_pclk' was unexpected)
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/watchdog/arm,sp805.example.dt.yaml: watchdog@66090000: '#dma-cells' is a required property
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-pl022.example.dt.yaml: spi@e0100000: '#dma-cells' is a required property
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-pl022.example.dt.yaml: spi@e0100000: $nodename:0: 'spi@e0100000' does not match '^dma-controller(@.*)?$'
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-pl022.example.dt.yaml: spi@e0100000: compatible: 'oneOf' conditional failed, one must be fixed:
> > >       ['arm,pl022', 'arm,primecell'] is too short
> > >       'arm,pl080' was expected
> > >       'arm,pl081' was expected
> > >       'faraday,ftdma020' was expected
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-pl022.example.dt.yaml: spi@e0100000: 'clocks' is a required property
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-pl022.example.dt.yaml: spi@e0100000: 'clock-names' is a required property
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/spi-pl022.example.dt.yaml: spi@e0100000: '#dma-cells' is a required property
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/serial/pl011.example.dt.yaml: serial@80120000: '#dma-cells' is a required property
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/serial/pl011.example.dt.yaml: serial@80120000: $nodename:0: 'serial@80120000' does not match '^dma-controller(@.*)?$'
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/serial/pl011.example.dt.yaml: serial@80120000: compatible: 'oneOf' conditional failed, one must be fixed:
> > >       ['arm,pl011', 'arm,primecell'] is too short
> > >       'arm,pl080' was expected
> > >       'arm,pl081' was expected
> > >       'faraday,ftdma020' was expected
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/serial/pl011.example.dt.yaml: serial@80120000: clocks: [[4294967295], [4294967295]] is too long
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/serial/pl011.example.dt.yaml: serial@80120000: clock-names:0: 'apb_pclk' was expected
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/serial/pl011.example.dt.yaml: serial@80120000: clock-names: ['uartclk', 'apb_pclk'] is too long
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/serial/pl011.example.dt.yaml: serial@80120000: clock-names: Additional items are not allowed ('apb_pclk' was unexpected)
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/serial/pl011.example.dt.yaml: serial@80120000: '#dma-cells' is a required property
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dt.yaml: cti@20020000: '#dma-cells' is a required property
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dt.yaml: cti@20020000: $nodename:0: 'cti@20020000' does not match '^dma-controller(@.*)?$'
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dt.yaml: cti@20020000: compatible: 'oneOf' conditional failed, one must be fixed:
> > >       ['arm,coresight-cti', 'arm,primecell'] is too short
> > >       'arm,pl080' was expected
> > >       'arm,pl081' was expected
> > >       'faraday,ftdma020' was expected
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dt.yaml: cti@20020000: '#dma-cells' is a required property
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dt.yaml: cti@20020000: 'oneOf' conditional failed, one must be fixed:
> > >       'interrupts' is a required property
> > >       'interrupts-extended' is a required property
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dt.yaml: cti@859000: '#dma-cells' is a required property
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dt.yaml: cti@859000: $nodename:0: 'cti@859000' does not match '^dma-controller(@.*)?$'
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dt.yaml: cti@859000: compatible: 'oneOf' conditional failed, one must be fixed:
> > >       ['arm,coresight-cti-v8-arch', 'arm,coresight-cti', 'arm,primecell'] is too long
> > >       Additional items are not allowed ('arm,primecell' was unexpected)
> > >       'arm,pl080' was expected
> > >       'arm,pl081' was expected
> > >       'faraday,ftdma020' was expected
> > >       'arm,primecell' was expected
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dt.yaml: cti@859000: '#dma-cells' is a required property
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dt.yaml: cti@859000: 'oneOf' conditional failed, one must be fixed:
> > >       'interrupts' is a required property
> > >       'interrupts-extended' is a required property
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dt.yaml: cti@858000: '#dma-cells' is a required property
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dt.yaml: cti@858000: $nodename:0: 'cti@858000' does not match '^dma-controller(@.*)?$'
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dt.yaml: cti@858000: compatible: 'oneOf' conditional failed, one must be fixed:
> > >       ['arm,coresight-cti', 'arm,primecell'] is too short
> > >       'arm,pl080' was expected
> > >       'arm,pl081' was expected
> > >       'faraday,ftdma020' was expected
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dt.yaml: cti@858000: '#dma-cells' is a required property
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dt.yaml: cti@858000: 'oneOf' conditional failed, one must be fixed:
> > >       'interrupts' is a required property
> > >       'interrupts-extended' is a required property
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dt.yaml: cti@20110000: '#dma-cells' is a required property
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dt.yaml: cti@20110000: $nodename:0: 'cti@20110000' does not match '^dma-controller(@.*)?$'
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dt.yaml: cti@20110000: compatible: 'oneOf' conditional failed, one must be fixed:
> > >       ['arm,coresight-cti', 'arm,primecell'] is too short
> > >       'arm,pl080' was expected
> > >       'arm,pl081' was expected
> > >       'faraday,ftdma020' was expected
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dt.yaml: cti@20110000: '#dma-cells' is a required property
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/arm/coresight-cti.example.dt.yaml: cti@20110000: 'oneOf' conditional failed, one must be fixed:
> > >       'interrupts' is a required property
> > >       'interrupts-extended' is a required property
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@5000: '#dma-cells' is a required property
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@5000: $nodename:0: 'mmc@5000' does not match '^dma-controller(@.*)?$'
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@5000: compatible: 'oneOf' conditional failed, one must be fixed:
> > >       ['arm,pl180', 'arm,primecell'] is too short
> > >       'arm,pl080' was expected
> > >       'arm,pl081' was expected
> > >       'faraday,ftdma020' was expected
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@5000: clocks: [[4294967295], [4294967295]] is too long
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@5000: clock-names:0: 'apb_pclk' was expected
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@5000: clock-names: ['mclk', 'apb_pclk'] is too long
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@5000: clock-names: Additional items are not allowed ('apb_pclk' was unexpected)
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@5000: '#dma-cells' is a required property
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@80126000: '#dma-cells' is a required property
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@80126000: $nodename:0: 'mmc@80126000' does not match '^dma-controller(@.*)?$'
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@80126000: compatible: 'oneOf' conditional failed, one must be fixed:
> > >       ['arm,pl18x', 'arm,primecell'] is too short
> > >       'arm,pl080' was expected
> > >       'arm,pl081' was expected
> > >       'faraday,ftdma020' was expected
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@80126000: clocks: [[4294967295, 1, 5], [4294967295, 1, 5]] is too long
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@80126000: clock-names:0: 'apb_pclk' was expected
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@80126000: clock-names: ['sdi', 'apb_pclk'] is too long
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@80126000: clock-names: Additional items are not allowed ('apb_pclk' was unexpected)
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@80126000: '#dma-cells' is a required property
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@101f6000: '#dma-cells' is a required property
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@101f6000: $nodename:0: 'mmc@101f6000' does not match '^dma-controller(@.*)?$'
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@101f6000: compatible: 'oneOf' conditional failed, one must be fixed:
> > >       ['arm,pl18x', 'arm,primecell'] is too short
> > >       'arm,pl080' was expected
> > >       'arm,pl081' was expected
> > >       'faraday,ftdma020' was expected
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@101f6000: clocks: [[4294967295], [4294967295]] is too long
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@101f6000: clock-names:0: 'apb_pclk' was expected
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@101f6000: clock-names: ['mclk', 'apb_pclk'] is too long
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@101f6000: clock-names: Additional items are not allowed ('apb_pclk' was unexpected)
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@101f6000: '#dma-cells' is a required property
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@52007000: '#dma-cells' is a required property
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@52007000: $nodename:0: 'mmc@52007000' does not match '^dma-controller(@.*)?$'
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@52007000: compatible: 'oneOf' conditional failed, one must be fixed:
> > >       ['arm,pl18x', 'arm,primecell'] is too short
> > >       'arm,pl080' was expected
> > >       'arm,pl081' was expected
> > >       'faraday,ftdma020' was expected
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@52007000: '#dma-cells' is a required property
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/timer/arm,sp804.example.dt.yaml: timer@fc800000: '#dma-cells' is a required property
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/timer/arm,sp804.example.dt.yaml: timer@fc800000: $nodename:0: 'timer@fc800000' does not match '^dma-controller(@.*)?$'
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/timer/arm,sp804.example.dt.yaml: timer@fc800000: compatible: 'oneOf' conditional failed, one must be fixed:
> > >       ['arm,sp804', 'arm,primecell'] is too short
> > >       'arm,pl080' was expected
> > >       'arm,pl081' was expected
> > >       'faraday,ftdma020' was expected
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/timer/arm,sp804.example.dt.yaml: timer@fc800000: interrupts: [[0, 0, 4], [0, 1, 4]] is too long
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/timer/arm,sp804.example.dt.yaml: timer@fc800000: clocks: [[4294967295], [4294967295], [4294967295]] is too long
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/timer/arm,sp804.example.dt.yaml: timer@fc800000: clock-names:0: 'apb_pclk' was expected
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/timer/arm,sp804.example.dt.yaml: timer@fc800000: clock-names: ['timer1', 'timer2', 'apb_pclk'] is too long
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/timer/arm,sp804.example.dt.yaml: timer@fc800000: clock-names: Additional items are not allowed ('timer2', 'apb_pclk' were unexpected)
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/timer/arm,sp804.example.dt.yaml: timer@fc800000: '#dma-cells' is a required property
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhu.example.dt.yaml: mailbox@2b1f0000: '#dma-cells' is a required property
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhu.example.dt.yaml: mailbox@2b1f0000: $nodename:0: 'mailbox@2b1f0000' does not match '^dma-controller(@.*)?$'
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhu.example.dt.yaml: mailbox@2b1f0000: compatible: 'oneOf' conditional failed, one must be fixed:
> > >       ['arm,mhu', 'arm,primecell'] is too short
> > >       'arm,pl080' was expected
> > >       'arm,pl081' was expected
> > >       'faraday,ftdma020' was expected
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhu.example.dt.yaml: mailbox@2b1f0000: interrupts: [[0, 36, 4], [0, 35, 4], [0, 37, 4]] is too long
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhu.example.dt.yaml: mailbox@2b1f0000: '#dma-cells' is a required property
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhu.example.dt.yaml: mailbox@2b2f0000: '#dma-cells' is a required property
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhu.example.dt.yaml: mailbox@2b2f0000: $nodename:0: 'mailbox@2b2f0000' does not match '^dma-controller(@.*)?$'
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhu.example.dt.yaml: mailbox@2b2f0000: compatible: 'oneOf' conditional failed, one must be fixed:
> > >       ['arm,mhu-doorbell', 'arm,primecell'] is too short
> > >       'arm,pl080' was expected
> > >       'arm,pl081' was expected
> > >       'faraday,ftdma020' was expected
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhu.example.dt.yaml: mailbox@2b2f0000: interrupts: [[0, 36, 4], [0, 35, 4], [0, 37, 4]] is too long
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhu.example.dt.yaml: mailbox@2b2f0000: '#dma-cells' is a required property
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhuv2.example.dt.yaml: mailbox@2b1f0000: '#dma-cells' is a required property
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhuv2.example.dt.yaml: mailbox@2b1f0000: $nodename:0: 'mailbox@2b1f0000' does not match '^dma-controller(@.*)?$'
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhuv2.example.dt.yaml: mailbox@2b1f0000: compatible: 'oneOf' conditional failed, one must be fixed:
> > >       ['arm,mhuv2-tx', 'arm,primecell'] is too short
> > >       'arm,pl080' was expected
> > >       'arm,pl081' was expected
> > >       'faraday,ftdma020' was expected
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhuv2.example.dt.yaml: mailbox@2b1f0000: '#dma-cells' is a required property
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhuv2.example.dt.yaml: mailbox@2b1f1000: '#dma-cells' is a required property
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhuv2.example.dt.yaml: mailbox@2b1f1000: $nodename:0: 'mailbox@2b1f1000' does not match '^dma-controller(@.*)?$'
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhuv2.example.dt.yaml: mailbox@2b1f1000: compatible: 'oneOf' conditional failed, one must be fixed:
> > >       ['arm,mhuv2-rx', 'arm,primecell'] is too short
> > >       'arm,pl080' was expected
> > >       'arm,pl081' was expected
> > >       'faraday,ftdma020' was expected
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mailbox/arm,mhuv2.example.dt.yaml: mailbox@2b1f1000: '#dma-cells' is a required property
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/bus/arm,integrator-ap-lm.example.dt.yaml: serial@100000: '#dma-cells' is a required property
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/bus/arm,integrator-ap-lm.example.dt.yaml: serial@100000: $nodename:0: 'serial@100000' does not match '^dma-controller(@.*)?$'
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/bus/arm,integrator-ap-lm.example.dt.yaml: serial@100000: compatible: 'oneOf' conditional failed, one must be fixed:
> > >       ['arm,pl011', 'arm,primecell'] is too short
> > >       'arm,pl080' was expected
> > >       'arm,pl081' was expected
> > >       'faraday,ftdma020' was expected
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/bus/arm,integrator-ap-lm.example.dt.yaml: serial@100000: 'clocks' is a required property
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/bus/arm,integrator-ap-lm.example.dt.yaml: serial@100000: 'clock-names' is a required property
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/bus/arm,integrator-ap-lm.example.dt.yaml: serial@100000: '#dma-cells' is a required property
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.example.dt.yaml: mmc@80118000: '#dma-cells' is a required property
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.example.dt.yaml: mmc@80118000: $nodename:0: 'mmc@80118000' does not match '^dma-controller(@.*)?$'
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.example.dt.yaml: mmc@80118000: compatible: 'oneOf' conditional failed, one must be fixed:
> > >       ['arm,pl18x', 'arm,primecell'] is too short
> > >       'arm,pl080' was expected
> > >       'arm,pl081' was expected
> > >       'faraday,ftdma020' was expected
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.example.dt.yaml: mmc@80118000: clocks: [[4294967295, 0], [4294967295, 1]] is too long
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.example.dt.yaml: mmc@80118000: clock-names:0: 'apb_pclk' was expected
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.example.dt.yaml: mmc@80118000: clock-names: ['mclk', 'apb_pclk'] is too long
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.example.dt.yaml: mmc@80118000: clock-names: Additional items are not allowed ('apb_pclk' was unexpected)
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.example.dt.yaml: mmc@80118000: '#dma-cells' is a required property
> > >       From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/dma/arm-pl08x.yaml
> > > Error: Documentation/devicetree/bindings/dma/arm-pl08x.example.dts:56.27-28 syntax error
> > > FATAL ERROR: Unable to parse input tree
> > > make[1]: *** [scripts/Makefile.lib:377: Documentation/devicetree/bindings/dma/arm-pl08x.example.dt.yaml] Error 1
> > > make[1]: *** Waiting for unfinished jobs....
> > > make: *** [Makefile:1414: dt_binding_check] Error 2
> > >
> >
> > Most of thoses error came from the fact the compatible end with "arm,primecell".
> > So it try to match against the wrong dt-binding.
> >
> > Does there is any correct way to limit/prevent this ?
> 
> You need a custom 'select' schema. Look at the 'select' schema for
> other users of "arm,primecell".
> 

It is exactly what I needed.
Thanks.
