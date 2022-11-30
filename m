Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE0863E2AE
	for <lists+dmaengine@lfdr.de>; Wed, 30 Nov 2022 22:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbiK3V1Q (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 30 Nov 2022 16:27:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiK3V1K (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 30 Nov 2022 16:27:10 -0500
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A070C8DBE9;
        Wed, 30 Nov 2022 13:27:08 -0800 (PST)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-141ca09c2fbso22619413fac.6;
        Wed, 30 Nov 2022 13:27:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xEC2E9D0Q/a5Wy4hVCIJkNxQ7VamPlxcjnYOAsJZbSs=;
        b=SbxvXMwcD4fo2ymKKScf66tUQIjW7+yFruMBFZ+QJVpZTyQoxA8q+KyLqHGqU7P2vD
         HbwzGo4+onATdCts11aQMsUOosXse6NtxX81xn0OY++j9Nw5+RoLWcHqAgRlaEArhfjM
         f5cXnSJvzLPniDEOic9r3P6DqTC0Wv5z+AnNjp49gY1RhO5bi8HkqAvR96VIOd4UvLxA
         gJMeXpgyxuuMBCO+dkiFmJbt3a8d1ty+hgMQ/ibIXG0YMhihHzWu1ILooLIeIHYGyYRJ
         WZ77rKIAxDHAI76U9v0rujZmlkXcQekOERdUFPSKi76sKibRhY55jaKNdc1oPdvE5+at
         2LLQ==
X-Gm-Message-State: ANoB5plgPJlmZyzwnH8cRttXb2DgZjUZVqUJRvM/B0cHtiMNbexFEumS
        +dLuu1oBDFIWI2IG9HCVYA==
X-Google-Smtp-Source: AA0mqf5zIqJ++FKRAvU27IUFyDNoEB4UKOWZN2O6rT76rcX6v244euFy2eWiz7DYmpAkhkXb2HFapw==
X-Received: by 2002:a05:6871:4609:b0:143:882a:9a6 with SMTP id nf9-20020a056871460900b00143882a09a6mr13159853oab.219.1669843627801;
        Wed, 30 Nov 2022 13:27:07 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n7-20020a056870558700b0013cd709659dsm1697680oao.52.2022.11.30.13.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 13:27:07 -0800 (PST)
Received: (nullmailer pid 2956065 invoked by uid 1000);
        Wed, 30 Nov 2022 21:27:06 -0000
Date:   Wed, 30 Nov 2022 15:27:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sarath Babu Naidu Gaddam <sarath.babu.naidu.gaddam@amd.com>
Cc:     harini.katakam@amd.com, anirudha.sarangi@amd.com,
        robh+dt@kernel.org, vkoul@kernel.org, adrianml@alumnos.upm.es,
        dmaengine@vger.kernel.org, michal.simek@amd.com, lars@metafoo.de,
        krzysztof.kozlowski+dt@linaro.org, git@amd.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, radhey.shyam.pandey@amd.com
Subject: Re: [PATCH V2 1/6] dt-bindings: dmaengine: xilinx_dma:Add
 xlnx,axistream-connected property
Message-ID: <166984362595.2956008.17012598692733906647.robh@kernel.org>
References: <20221124102745.2620370-1-sarath.babu.naidu.gaddam@amd.com>
 <20221124102745.2620370-2-sarath.babu.naidu.gaddam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221124102745.2620370-2-sarath.babu.naidu.gaddam@amd.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On Thu, 24 Nov 2022 15:57:40 +0530, Sarath Babu Naidu Gaddam wrote:
> From: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> 
> Add an optional AXI DMA property 'xlnx,axistream-connected'. This
> can be specified to indicate that DMA is connected to a streaming IP
> in the hardware design and dma driver needs to do some additional
> handling i.e pass metadata and perform streaming IP specific
> configuration.
> 
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> Signed-off-by: Sarath Babu Naidu Gaddam <sarath.babu.naidu.gaddam@amd.com>
> ---
> Changes in V2:
> 1) Moved xlnx,axistream-connected optional property to under AXI DMA.
> 2) Removed Acked-by: Rob Herring.
> ---
>  Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
