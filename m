Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D361D4E7D1F
	for <lists+dmaengine@lfdr.de>; Sat, 26 Mar 2022 01:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233259AbiCYVMj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 25 Mar 2022 17:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbiCYVMi (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 25 Mar 2022 17:12:38 -0400
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD731FF412;
        Fri, 25 Mar 2022 14:11:03 -0700 (PDT)
Received: by mail-oi1-f174.google.com with SMTP id w127so9487607oig.10;
        Fri, 25 Mar 2022 14:11:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wXvBLN2YPI/f+mwgNpVUSPw3vc7vaslW8j6BkDAkPkw=;
        b=5yVFPYFVS/tIzDi0a9ZxGo5qJfpMOsEpodTqe7HVQb77GpyQCti0jT0NIGDNA6LoHQ
         dFxli7rK6VXnwjqNRNpg3zv9vACIdfHArhvWNPVqzkmTwQ73au+ylEfD8om8qsbnHK1e
         cWYXuMzNMn9dIy2kceK1oEKCUrfI3ms9KfHkkERZa/1/jit65VYQxOI6mIgukZYxg4A4
         m+DFGPEvPpSPDjCf0jwoMdd8ytTrbQ3a2IPgOsifuv+pDSx92qPLZtwlaGVb/v+2gpCm
         mD/PFOkeUvHKJS5AcwgyA7JL0M92TfScdHrbqUUnkQcBUgjXAsOpot69l1dg80bpHyq9
         815g==
X-Gm-Message-State: AOAM533lqbX31IXv5s0k3N2/ktd4BN8dUKh90tQhnh3SkBsWq4XoBLf3
        u6nz2qIeuer8z7SChl1oow==
X-Google-Smtp-Source: ABdhPJz/WMdnAOINviqJND5zDMeL1o27zVTXARwz/Cw5GDE6nIi94HXm4B8MMoxqz03bNIsAqu/rNQ==
X-Received: by 2002:a05:6808:9b9:b0:2ef:7562:1586 with SMTP id e25-20020a05680809b900b002ef75621586mr6372651oig.261.1648242662763;
        Fri, 25 Mar 2022 14:11:02 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id c26-20020a4ae25a000000b0031c268c5436sm3028104oot.16.2022.03.25.14.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 14:11:01 -0700 (PDT)
Received: (nullmailer pid 460214 invoked by uid 1000);
        Fri, 25 Mar 2022 21:11:01 -0000
Date:   Fri, 25 Mar 2022 16:11:01 -0500
From:   Rob Herring <robh@kernel.org>
To:     Olivier Dautricourt <olivier.dautricourt@orolia.com>
Cc:     Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stefan Roese <sr@denx.de>
Subject: Re: [PATCH 2/2] dt-bindings: altr,msgdma: update my email address
Message-ID: <Yj4v5c3nTdOhgyU7@robh.at.kernel.org>
References: <85c4174fa162bd946ccf3e08dcfc9b83cfe69b5c.1647539776.git.olivier.dautricourt@orolia.com>
 <dc3decf1dae172c688017bd3ada2ad2b7d060c1e.1647539776.git.olivier.dautricourt@orolia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc3decf1dae172c688017bd3ada2ad2b7d060c1e.1647539776.git.olivier.dautricourt@orolia.com>
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

On Thu, 17 Mar 2022 18:56:56 +0100, Olivier Dautricourt wrote:
> This email should now be used to contact me.
> 
> Signed-off-by: Olivier Dautricourt <olivier.dautricourt@orolia.com>
> ---
>  Documentation/devicetree/bindings/dma/altr,msgdma.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
