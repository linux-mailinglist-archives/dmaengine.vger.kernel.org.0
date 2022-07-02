Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23092564284
	for <lists+dmaengine@lfdr.de>; Sat,  2 Jul 2022 21:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbiGBTeq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 2 Jul 2022 15:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiGBTeq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 2 Jul 2022 15:34:46 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E026A455;
        Sat,  2 Jul 2022 12:34:44 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id o9so6729108edt.12;
        Sat, 02 Jul 2022 12:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kQg/6LkplffkCtimKzzt2q4A7biDvqAW9bm94VihuCI=;
        b=ilHiV1DsRo62TeKfx/Leh964ynrDoJGg7hw1VZVZlHnRA6PbhpUF4bBqIEDDWemeC4
         1Mq/vzh0TJAQUFcs3dZrtlUIR9lQzl5Z5J55QWvpv/CTvB4mbN5LqyM2TabdDZ9rElc2
         FwAWQdEKokrizvedaoXzLlbBc2lFRJVZpkIoBmbaRp/vvHiNBJWYuSIpWDN0mVpBzJ/8
         xCSZ8JBfAGpTHT5ZLxqKFUNRNUxFShVIonBkF2TDIjpqd7jNze4PuXFpX2SIPLPnTWr6
         cAI+49bbOLzTk+mBrP+vp0p8ovK1tXSMNd/Tld/DaZedKuZbAjADjgyy1rtiupA0aOSG
         Pmrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kQg/6LkplffkCtimKzzt2q4A7biDvqAW9bm94VihuCI=;
        b=xykm94M2cwnNsyBAT9doA16hQIYuTMf5lG/6qm7oA9ydqzKZVhfTr5WdS5JsgRfWQV
         MZ5Ik4YAV6B24V0n1/xjJWDJzJgQKYS/G/tGjjBZkqp6MqRLUdWBmNOa43Y+yq36dxZG
         oVZc6nNso6TPVCeSGgf4XYfKeVFN+umIQ5sI7c39fHVm58l3AIEmhZ0kcjMjWHuQgC6x
         AWBFGbf8prqKdHipqEBhDHbCYlUvLE+Ho9lisd4w97emDcb4nFove+75rwX+pa+BZoMD
         LRZs4g8ncBD90QG7hTIuxPzkbAeUQRMp4gHxonZ4Abny+8n73Ka5mgRbJ2TFQnjEkWL5
         0cOw==
X-Gm-Message-State: AJIora8d59jitwAnWjBjfPZsRZtau1VzFppHOg7of+m74yPDKcAOYKlO
        0+ZG9ndh4kSh+yhqfUm6kRc=
X-Google-Smtp-Source: AGRyM1tJaOo4gaMbRsM/Ka5hQ7A7XL3QHtzUGEJFHAy5Ouvh5Z+F78XIbfTG3AzW46xXj8DRsTXrZA==
X-Received: by 2002:a05:6402:368f:b0:437:be5d:6617 with SMTP id ej15-20020a056402368f00b00437be5d6617mr27066806edb.187.1656790483189;
        Sat, 02 Jul 2022 12:34:43 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id p16-20020a05640210d000b0043a1bc2ebbcsm123066edu.3.2022.07.02.12.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jul 2022 12:34:42 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Vinod Koul <vkoul@kernel.org>, Samuel Holland <samuel@sholland.org>
Cc:     Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH] dt-bindings: dma: allwinner,sun50i-a64-dma: Fix min/max typo
Date:   Sat, 02 Jul 2022 21:34:41 +0200
Message-ID: <22696538.6Emhk5qWAg@jernej-laptop>
In-Reply-To: <20220702031903.21703-1-samuel@sholland.org>
References: <20220702031903.21703-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Dne sobota, 02. julij 2022 ob 05:19:02 CEST je Samuel Holland napisal(a):
> The conditional block for variants with a second clock should have set
> minItems, not maxItems, which was already 2. Since clock-names requires
> two items, this typo should not have caused any problems.
> 
> Fixes: edd14218bd66 ("dt-bindings: dmaengine: Convert Allwinner A31 and A64
> DMA to a schema") Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 
>  .../devicetree/bindings/dma/allwinner,sun50i-a64-dma.yaml       | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git
> a/Documentation/devicetree/bindings/dma/allwinner,sun50i-a64-dma.yaml
> b/Documentation/devicetree/bindings/dma/allwinner,sun50i-a64-dma.yaml index
> ff0a5c58d78c..e712444abff1 100644
> --- a/Documentation/devicetree/bindings/dma/allwinner,sun50i-a64-dma.yaml
> +++ b/Documentation/devicetree/bindings/dma/allwinner,sun50i-a64-dma.yaml
> @@ -67,7 +67,7 @@ if:
>  then:
>    properties:
>      clocks:
> -      maxItems: 2
> +      minItems: 2

These specific variants have exactly 2 clocks. Having both limits seems right.

Best regards,
Jernej

> 
>    required:
>      - clock-names




