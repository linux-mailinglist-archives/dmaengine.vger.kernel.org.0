Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5964E304A
	for <lists+dmaengine@lfdr.de>; Mon, 21 Mar 2022 19:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345238AbiCUS4s (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 21 Mar 2022 14:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245481AbiCUS4r (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 21 Mar 2022 14:56:47 -0400
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C014630F6C;
        Mon, 21 Mar 2022 11:55:21 -0700 (PDT)
Received: by mail-oo1-f53.google.com with SMTP id w3-20020a4ac183000000b0031d806bbd7eso20227997oop.13;
        Mon, 21 Mar 2022 11:55:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7gYimi7IXaGh1o6TmiU/YwpmZl88VAlShoDJCgXTGA4=;
        b=5raOEuxgFXfh3ngyrFz9mFOIAnUR2KknaHTlWCs7OJIgn3WvpG43zTG5TRLuy+9sNs
         hTHYpn6MqlBKcfODkA+IPFuYon7lwAbxbFw6RqZlO4DvG+I0C9IeJitRMx3VyJZDg3oa
         O/6OvI2IAOmN6QBWlKrGzUjae9LD+4TXNfy/4GEFwVVdnSb6+Qt1NaNyu9VHO8l9SMXD
         WhARp8A1Ndtd1XF6JKHP7ndr+EcU6DUJB5mZ7TLT+fGJ7NQbeLbHKTeViXH9Bd+5Jyrh
         Le2s0ZYuo+aMnacNNoxcxSkpjx528YZfuvR/2ONuF0Jq1GFXnLYnKrsdgtqH3xYLillX
         1v4Q==
X-Gm-Message-State: AOAM532otnXG77iXU3UexEd1WuwMv8eoSzvJac1aexnXmoruuZF/2/xg
        YGygglhxM7pEPDBO5pk9rA==
X-Google-Smtp-Source: ABdhPJw1MRcil7h8zdAWMFtY/6TL02ehb+MaL8EpGrGIMuov9NUrElMt1E9LSjlNbJgNtXYHt1C1ig==
X-Received: by 2002:a05:6870:d348:b0:db:12b5:d6a with SMTP id h8-20020a056870d34800b000db12b50d6amr224887oag.183.1647888920545;
        Mon, 21 Mar 2022 11:55:20 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id gk6-20020a0568703c0600b000de4880b357sm83241oab.50.2022.03.21.11.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 11:55:19 -0700 (PDT)
Received: (nullmailer pid 362706 invoked by uid 1000);
        Mon, 21 Mar 2022 18:55:18 -0000
Date:   Mon, 21 Mar 2022 13:55:18 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Vinod Koul <vkoul@kernel.org>, linux-riscv@lists.infradead.org,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        Palmer Debbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Green Wan <green.wan@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: dmaengine: sifive,fu540-c000: include
 generic schema
Message-ID: <YjjKFvNZ1BVn/zaB@robh.at.kernel.org>
References: <20220318162044.169350-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220318162044.169350-1-krzysztof.kozlowski@canonical.com>
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

On Fri, 18 Mar 2022 17:20:43 +0100, Krzysztof Kozlowski wrote:
> Include generic dma-controller.yaml schema, which enforces node naming
> and other generic properties.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../devicetree/bindings/dma/sifive,fu540-c000-pdma.yaml   | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 

Applied, thanks!
