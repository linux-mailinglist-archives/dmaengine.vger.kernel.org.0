Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30D6B5076DF
	for <lists+dmaengine@lfdr.de>; Tue, 19 Apr 2022 19:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244007AbiDSR7D (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Apr 2022 13:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238280AbiDSR7C (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 19 Apr 2022 13:59:02 -0400
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0AF9BF55;
        Tue, 19 Apr 2022 10:56:19 -0700 (PDT)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-e5ca5c580fso8006055fac.3;
        Tue, 19 Apr 2022 10:56:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UTQU/4ZS7iunfcTFw90SndC6lGxGaDR1zY8YP8er/Ns=;
        b=gf0qKRD15bZlxX/GlYEV6s/uxqK0tptyvuaBR1XsYxX+7xNBeoaTjJE9C9Y/+QEY4u
         qV5Hb8KmPtqnnzIR/z1mTsA4hPByp21gLD7l2WXH7sYf5YdoRL7iuNHQZFrbpGKzhOQg
         zjsDk32ghSJ1amFc3JnBFxV2uZ1ch8q0+Qf7PD1Hy89MEqa/SfalsVqMi2uF7DHTSZjK
         c5/BBzwbbfjWQG5B0BnTRL2w231I/UiclgS59JtLOcW7DEtzf2+X4OuishBzAqNoIF4N
         LtPgCnyJ5DS71yUuCUs5I/y+pcy9T4PIUJqGBjOx64dITDb++XlfE82eV7ViamvaGQzk
         ml2A==
X-Gm-Message-State: AOAM532/92ofiBI3wfxDfqIsU3bl0mzrvf3SortW9giADfI7cBq5gtoF
        ps2o1Bd/DJwzF6K0CqSVdA==
X-Google-Smtp-Source: ABdhPJyy+fAMCc5zeulhydURCk1KC3Y9jD3mJV2iGlVkFXt4BU5pTOhUpjDNton94OJPJLMPCFyGtA==
X-Received: by 2002:a05:6870:2190:b0:e6:26d2:abe0 with SMTP id l16-20020a056870219000b000e626d2abe0mr1113589oae.15.1650390979219;
        Tue, 19 Apr 2022 10:56:19 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o13-20020a4ae58d000000b00324dfcc5bcfsm5741589oov.12.2022.04.19.10.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 10:56:18 -0700 (PDT)
Received: (nullmailer pid 3053283 invoked by uid 1000);
        Tue, 19 Apr 2022 17:56:18 -0000
Date:   Tue, 19 Apr 2022 12:56:18 -0500
From:   Rob Herring <robh@kernel.org>
To:     Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Cc:     devicetree@vger.kernel.org, krzk+dt@kernel.org,
        dmaengine@vger.kernel.org, michal.simek@xilinx.com,
        vkoul@kernel.org, robh+dt@kernel.org, git@xilinx.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: dmaengine: xilinx_dma: Add MCMDA channel ID
 index description
Message-ID: <Yl73wg/N0f2xGvLY@robh.at.kernel.org>
References: <1649939061-6675-1-git-send-email-radhey.shyam.pandey@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1649939061-6675-1-git-send-email-radhey.shyam.pandey@xilinx.com>
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

On Thu, 14 Apr 2022 17:54:21 +0530, Radhey Shyam Pandey wrote:
> MCDMA IP provides up to 16 multiple channels of data movement each on
> MM2S and S2MM paths. Inline with implementation, in the binding add
> description for the channel ID start index and mention that it's fixed
> irrespective of the MCDMA IP configuration(number of read/write channels).
> 
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> ---
>  Documentation/devicetree/bindings/dma/xilinx/xilinx_dma.txt | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
