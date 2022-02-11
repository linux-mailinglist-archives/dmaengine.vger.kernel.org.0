Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81B1B4B299A
	for <lists+dmaengine@lfdr.de>; Fri, 11 Feb 2022 17:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346073AbiBKQDf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 11 Feb 2022 11:03:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237277AbiBKQDf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 11 Feb 2022 11:03:35 -0500
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE641A8;
        Fri, 11 Feb 2022 08:03:34 -0800 (PST)
Received: by mail-oi1-f177.google.com with SMTP id y23so9970852oia.13;
        Fri, 11 Feb 2022 08:03:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oK96NDQ/E6qrHpavTpxLKhY5vh0HN7cuKJXs2+xAB5w=;
        b=UeKD01R9uRexSk/2mxrZ+gmH3wWYGe4eTcizAPfY6rnp7Pc1Z+NywCL3A78T+MABTR
         CpYF+iaBlUvvlAmTTmRutnqV289QM2EUphArKCi+k6RoiUq9u9dqmWurgDAX99n4FZlK
         oLgPIbFx28mIf/g5a5ESqYkHGMH+uwHKqhmQyDtICnfDmi2vFjsD8cENebp56NB9oZ8s
         WCKOWBEXkmMLTVzoAPCY+C9V4070Z1gqeWHQ6Gi7uPcm+K7ged4ckwaYmtL/cfzoqIrL
         N//4ZcHD8faa1FiU14n28Tn4G7QYWyrv9ikCIixjCerc/ZcZYEuuebznEo9oyvg5UrNF
         w7ow==
X-Gm-Message-State: AOAM530LaM4kX1KilpKyUSSXxQJ/jbaAdurOMfL15HTKvvvBJBYAZpE5
        LUF0vgvyELMEgA7QQCsTYg4M4p9IWg==
X-Google-Smtp-Source: ABdhPJx0EqTpAEZur0pxerj8DO4aI9eJkX9cI2W6fhFqx5wXcuO6BRRH7xso+xuLgoqeyCCm3cxStg==
X-Received: by 2002:aca:1b05:: with SMTP id b5mr474898oib.289.1644595413118;
        Fri, 11 Feb 2022 08:03:33 -0800 (PST)
Received: from robh.at.kernel.org ([2607:fb90:5fee:dfce:b6df:c3e1:b1e5:d6d8])
        by smtp.gmail.com with ESMTPSA id n12sm9549472oop.5.2022.02.11.08.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 08:03:32 -0800 (PST)
Received: (nullmailer pid 435201 invoked by uid 1000);
        Fri, 11 Feb 2022 16:03:30 -0000
Date:   Fri, 11 Feb 2022 10:03:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Vinod Koul <vkoul@kernel.org>, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        devicetree@vger.kernel.org, Biju Das <biju.das@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>, dmaengine@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: dma: rz-dmac: Document RZ/G2UL SoC
Message-ID: <YgaI0sc5tPKAI11h@robh.at.kernel.org>
References: <20220206200308.14315-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220206200308.14315-1-biju.das.jz@bp.renesas.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sun, 06 Feb 2022 20:03:08 +0000, Biju Das wrote:
> Document RZ/G2UL DMAC bindings. RZ/G2UL DMAC is identical to one found
> on the RZ/G2L SoC. No driver changes are required as generic compatible
> string "renesas,rz-dmac" will be used as a fallback.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> This patch depend upon [1]
> [1] https://patchwork.kernel.org/project/linux-dmaengine/patch/20220110134659.30424-9-prabhakar.mahadev-lad.rj@bp.renesas.com/
> ---
>  Documentation/devicetree/bindings/dma/renesas,rz-dmac.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
