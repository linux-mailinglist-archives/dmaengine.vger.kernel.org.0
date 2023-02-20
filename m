Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA78169D727
	for <lists+dmaengine@lfdr.de>; Tue, 21 Feb 2023 00:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbjBTXkv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 20 Feb 2023 18:40:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbjBTXku (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 20 Feb 2023 18:40:50 -0500
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8CB1E1E1;
        Mon, 20 Feb 2023 15:40:42 -0800 (PST)
Received: by mail-ot1-f44.google.com with SMTP id e18-20020a0568301e5200b00690e6abbf3fso739251otj.13;
        Mon, 20 Feb 2023 15:40:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ekp/l7dS7L5c5Y/xNxbb/NDW4G4Mm3+q7ub7U8gNFqI=;
        b=MjazdspAOr0/z49kDqzWByPuKBxAjcsWhohx7bnRbuW+6cd8xuNTSh2j/2eVZUuBUs
         33i14KXWcMOxbOyIppYbF+p3lct0uqUNJV83TDEkJWMY424puFptpo+j2PX7OVD3TxMq
         QOyxfogTtTehY1GC5+CMhFTqLR4FVqBzgRrK3LrCVT1dW3/Pcih4a4MEywvHHqG22HC5
         Je/QLyKDyeQEdN6NXmXnYe5HFfu3MulkYHmceWJF9IfGJoqv2Rkq6OGhzNWo5Be7pIlG
         HOHbok/pdM5hVOGiEECsx+NcV9Sdd/AYNEB+cCjyf7G6Y5ID0vLQ8fBzsNPOMo6vT0qt
         eM+w==
X-Gm-Message-State: AO0yUKWJ3Pbl6WkAXvqGXrRKCKhYfxxB8HCyXWDAfV1mtRm736pv1Ziw
        EoYqvZkmzEZ6Gnp4MATDiA==
X-Google-Smtp-Source: AK7set+WhIJJXW3KarE7h76hVttihFyNtPia99NTQYAWUZQR15okea5lUnoGuYWWkVtOk7sWd61lBw==
X-Received: by 2002:a9d:19a2:0:b0:68c:1c0d:ab6a with SMTP id k31-20020a9d19a2000000b0068c1c0dab6amr908337otk.13.1676936441767;
        Mon, 20 Feb 2023 15:40:41 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id d2-20020a9d51c2000000b006864816ecd9sm726939oth.59.2023.02.20.15.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 15:40:41 -0800 (PST)
Received: (nullmailer pid 614054 invoked by uid 1000);
        Mon, 20 Feb 2023 23:40:40 -0000
Date:   Mon, 20 Feb 2023 17:40:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Janne Grunau <j@jannau.net>, devicetree@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>, asahi@lists.linux.dev,
        dmaengine@vger.kernel.org, Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [RFC PATCH v2] dt-bindings: dma: apple,sio: Add schema
Message-ID: <167693643966.613996.10372170526471864080.robh@kernel.org>
References: <20230214203637.43630-1-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230214203637.43630-1-povik+lin@cutebit.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On Tue, 14 Feb 2023 21:36:37 +0100, Martin Povišer wrote:
> Describe the SIO coprocessor which serves as pretend DMA controller on
> recent Apple platforms.
> 
> Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
> ---
> Since v1:
>  - formatting fixes requested by Rob
>  - dropped provider nodes from example
>  - added 'memory-region' items range
>  - tweaked 'apple,sio-firmware-params' description
> 
> Since the schema mentions a loader preparing the binding appropriately,
> here's a PR with the relevant (WIP) loader code, if anyone wants to look:
> https://github.com/AsahiLinux/m1n1/pull/286
> 
> 
>  .../devicetree/bindings/dma/apple,sio.yaml    | 111 ++++++++++++++++++
>  1 file changed, 111 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/apple,sio.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

