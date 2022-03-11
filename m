Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D80994D6489
	for <lists+dmaengine@lfdr.de>; Fri, 11 Mar 2022 16:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236044AbiCKP3G (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 11 Mar 2022 10:29:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233904AbiCKP3F (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 11 Mar 2022 10:29:05 -0500
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E862074622;
        Fri, 11 Mar 2022 07:28:00 -0800 (PST)
Received: by mail-oo1-f46.google.com with SMTP id 6-20020a4a0906000000b0031d7eb98d31so10841801ooa.10;
        Fri, 11 Mar 2022 07:28:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+AZuxr9cOspuT2haPxrkmYdQhFq329SVlyo5zkA8oOI=;
        b=2GAgokVSWyljV7CuzMc2fP8RjVdHNVc7BXoTlaqqSxTXpslajMdcCBldXZ1FzT25Lb
         W/HZlTty2rfiZrYDAeAqOtr7rRPkDbMLchoBDIl8Spok2Pd2lmN5vw3yu80XEe3xsdSu
         w9yEwW4WWFKmXJhKOnOfp2niFotu1hJT/iUzuQyeWaLXHFZXTJ7PRXVDPfQaeoZj3TtG
         2FM+IWB3FgWSDcRltfhLELBkVDqmHLIrSft4pQbPBs1HH8+IpVqpjHwObX2RfGwZPCgK
         BwTNLMDIR0cakKVHIUNLiAFrhJIUtvErm61QHQXxMyE20ByPQwq75XiPZ6S4ftw05hMB
         xneA==
X-Gm-Message-State: AOAM533upulOJCQ1bk0ZxlUw9AAMz2QYP/CIR2TSAl9wlCPybbDaVWg2
        LkLP5hCBxfe1w1o54eEXsA==
X-Google-Smtp-Source: ABdhPJzeXNB+ACWkU1gQILoMP7v0kLbYNlNjIsYcD3d7jUqamA/HUApr+Kr7+1ffYn+ajA5/rJWt9w==
X-Received: by 2002:a05:6870:51d0:b0:d7:1e2a:2587 with SMTP id b16-20020a05687051d000b000d71e2a2587mr5622107oaj.176.1647012480197;
        Fri, 11 Mar 2022 07:28:00 -0800 (PST)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 69-20020a9d0bcb000000b005af83322c6asm3644360oth.12.2022.03.11.07.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 07:27:59 -0800 (PST)
Received: (nullmailer pid 3830119 invoked by uid 1000);
        Fri, 11 Mar 2022 15:27:57 -0000
Date:   Fri, 11 Mar 2022 09:27:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Jimmy Lalande <jimmy.lalande@se.com>, dmaengine@vger.kernel.org,
        Herve Codina <herve.codina@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Vinod Koul <vkoul@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Viresh Kumar <vireshk@kernel.org>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Milan Stevanovic <milan.stevanovic@se.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-clk@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v4 1/9] dt-bindings: dma: Introduce RZN1 dmamux bindings
Message-ID: <YitqfeO/JLFybDNU@robh.at.kernel.org>
References: <20220310155755.287294-1-miquel.raynal@bootlin.com>
 <20220310155755.287294-2-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310155755.287294-2-miquel.raynal@bootlin.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, 10 Mar 2022 16:57:47 +0100, Miquel Raynal wrote:
> The Renesas RZN1 DMA IP is based on a DW core, with eg. an additional
> dmamux register located in the system control area which can take up to
> 32 requests (16 per DMA controller). Each DMA channel can be wired to
> two different peripherals.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  .../bindings/dma/renesas,rzn1-dmamux.yaml     | 51 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/renesas,rzn1-dmamux.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
