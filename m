Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 673334CBF0A
	for <lists+dmaengine@lfdr.de>; Thu,  3 Mar 2022 14:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233809AbiCCNnT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 3 Mar 2022 08:43:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233805AbiCCNnT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 3 Mar 2022 08:43:19 -0500
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1064F50441;
        Thu,  3 Mar 2022 05:42:34 -0800 (PST)
Received: by mail-oo1-f49.google.com with SMTP id n5-20020a4a9545000000b0031d45a442feso5791131ooi.3;
        Thu, 03 Mar 2022 05:42:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5lWBzoOWGU7G5/Zn3FRdl8Hy5UVc8HqxipISQi2chqQ=;
        b=Se/vQlyW0u2daI8EWdoYCZc2yspAGd6I3ggUZAPBnvW/fIt41Pa/V9CIOv+NRadqvw
         XginrU4h3/hvDu8REqCX/AwWjKuKcHQpHnQdwvxwfGlntiYjN0HHqs0yKP4P/tK/CQsl
         8ev1tGY73pesHCuE6fDttYFOcq+bTAXd1QTQSdDshrncNNYxdBLSQPcfZjUwjoU4P2Wb
         DlXCOoSoj5OXo7+lP21qLzlOGtAxlztTWFl/zBDCcmKcG3YJ+g/BtEDjAEF5Wu1tNfnQ
         l6kLDfRnlb/ATAFUkKq9uiBHyz7WSD7dIwFt4HBD3Hmy85YuZ2YsDbc2yyWIJhakac8r
         JiuQ==
X-Gm-Message-State: AOAM531jXZTyVKpBdo/BOqsR2w2Xjp1cpBBowvPBaa5tVRn+Fa5pnGJC
        g46YsTvJXjCasev6Mjb6fA==
X-Google-Smtp-Source: ABdhPJwZDnkj6WGwaUvxYlZzHP+V6c+mocX9RVyZQwpWKoYGtlzUPQ7kmzaogIdQ65P5HG5IcDFmzA==
X-Received: by 2002:a05:6870:8322:b0:d3:a3f7:ad88 with SMTP id p34-20020a056870832200b000d3a3f7ad88mr3859346oae.107.1646314953406;
        Thu, 03 Mar 2022 05:42:33 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id y28-20020a4aea3c000000b0031c0cddfbf9sm942208ood.20.2022.03.03.05.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 05:42:31 -0800 (PST)
Received: (nullmailer pid 1491084 invoked by uid 1000);
        Thu, 03 Mar 2022 13:42:30 -0000
Date:   Thu, 3 Mar 2022 07:42:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-clk@vger.kernel.org,
        Milan Stevanovic <milan.stevanovic@se.com>,
        linux-renesas-soc@vger.kernel.org,
        Magnus Damm <magnus.damm@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH v3 2/7] dt-bindings: dma: Introduce RZN1 DMA compatible
Message-ID: <YiDFxoubwNp1Zuwo@robh.at.kernel.org>
References: <20220225112403.505562-1-miquel.raynal@bootlin.com>
 <20220225112403.505562-3-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225112403.505562-3-miquel.raynal@bootlin.com>
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

On Fri, 25 Feb 2022 12:23:57 +0100, Miquel Raynal wrote:
> Just like for the NAND controller that is also on this SoC, let's
> provide a SoC generic and a more specific couple of compatibles for the
> DMA controller.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  .../devicetree/bindings/dma/snps,dma-spear1340.yaml       | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
