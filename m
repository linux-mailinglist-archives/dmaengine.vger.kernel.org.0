Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D9253DC3C
	for <lists+dmaengine@lfdr.de>; Sun,  5 Jun 2022 16:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344994AbiFEOcE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 5 Jun 2022 10:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344887AbiFEOcD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 5 Jun 2022 10:32:03 -0400
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B445FC6;
        Sun,  5 Jun 2022 07:32:02 -0700 (PDT)
Received: by mail-ot1-f46.google.com with SMTP id w19-20020a9d6393000000b0060aeb359ca8so9056667otk.6;
        Sun, 05 Jun 2022 07:32:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IfYNNheMDHaySO8uAV/0eKWM9iyEP3vdrlJ2GnMDEwY=;
        b=28upnFK9hSfAGQsBqCUrXWlOIk6dI3o+GO/8pWawnTZKA1TcQ/F0xJTYaa25VcRy9W
         gexI6FCOgV1eHmOKAGWZlQDYA0lqOookQKc/SEY0f2FLAThifqev3drLBbzZtMtyyF6o
         /2wz0PmC19f4BcJ9yy9NobouR4+iQxzWlnd8Y3a0oNcbTZeGwUxZO7gjsy2jgxLy0h79
         2KdS3faOMUL21SjbbXNRDIZvbvs3e+osqGNckZDxL6q8daNiHKGZszHwGb6WFtOVB34Z
         f6zw4uIrbyb8gcegIh3u6iA5hUQKxsu8Ffty5AP4MRPYpLyNvkD/1ggv9xErFGn8fLro
         gHOw==
X-Gm-Message-State: AOAM532kfuqQ+lv+O0YdN17mLL/5gqVODaIv7TNfd/DLqeEhJ5mIZ29r
        8EdqDVxGyuj6Qz1sAoqFvw==
X-Google-Smtp-Source: ABdhPJxgClawXrgwzmM5I8cAuEiW+WdvBjRyEtxAjoycBUynlbj9Zb+ui40J4I/4J6tDLfJ+kfyWPQ==
X-Received: by 2002:a05:6830:2693:b0:60a:c590:8382 with SMTP id l19-20020a056830269300b0060ac5908382mr7972030otu.344.1654439521575;
        Sun, 05 Jun 2022 07:32:01 -0700 (PDT)
Received: from robh.at.kernel.org ([2607:fb90:5fed:bdd:4931:91d5:7dbb:83fc])
        by smtp.gmail.com with ESMTPSA id g9-20020a4a7549000000b0035eb4e5a6d3sm6574350oof.41.2022.06.05.07.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 07:32:01 -0700 (PDT)
Received: (nullmailer pid 3455085 invoked by uid 1000);
        Sun, 05 Jun 2022 14:30:15 -0000
Date:   Sun, 5 Jun 2022 09:30:15 -0500
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     devicetree@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH] dt-bindings: dma: Rewrite ST-Ericsson DMA40 to YAML
Message-ID: <20220605143015.GA3455027-robh@kernel.org>
References: <20220527215508.622374-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527215508.622374-1-linus.walleij@linaro.org>
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

On Fri, 27 May 2022 23:55:08 +0200, Linus Walleij wrote:
> This rewrites the ST-Ericsson DMA40 bindings in YAML.
> 
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../devicetree/bindings/dma/ste-dma40.txt     | 138 ---------------
>  .../bindings/dma/stericsson,dma40.yaml        | 159 ++++++++++++++++++
>  2 files changed, 159 insertions(+), 138 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/dma/ste-dma40.txt
>  create mode 100644 Documentation/devicetree/bindings/dma/stericsson,dma40.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
