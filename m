Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09E6F5122C5
	for <lists+dmaengine@lfdr.de>; Wed, 27 Apr 2022 21:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbiD0TeP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 27 Apr 2022 15:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234869AbiD0TeC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 27 Apr 2022 15:34:02 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 754C419D
        for <dmaengine@vger.kernel.org>; Wed, 27 Apr 2022 12:30:40 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id gj17-20020a17090b109100b001d8b390f77bso5796460pjb.1
        for <dmaengine@vger.kernel.org>; Wed, 27 Apr 2022 12:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nqHaRTfHThJkqhALCqIT5LeqKtw4VE1vM52q4z/IlSc=;
        b=SMZS3v8YjUqrZkSPCI7d6K3hmAKcRimgium9aZBybxcLq1tbveraUj7dWHzdXP7i0t
         xh7dWhI1nMlp1JbdH0Ge8BcDE5OInxMlN3sHeZIwCeWWp9kZz/mbkwtNxs5bys+l8bD6
         1tQRWQJyzayy6s5kujObAT5jVzswctCcB2p2S+WWRUSaL9aGNbuy6DKNXnU2kCQnCwe8
         T921ZaJZGoaSl/0JSAHrlBKheRoNZYTuQxgH0TLnwy6Z++J1to049cDDBDc+MK+k0+8K
         Ioksu8Sa1g7ylWGlxrV4PqDQP0FYRgSgKiBOEvoh5R/jI4Q6WRWSeEi/ViH4LoxwjTp6
         s4qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nqHaRTfHThJkqhALCqIT5LeqKtw4VE1vM52q4z/IlSc=;
        b=P4mF8t0L+aHKNw//zNS0X6kXUOGHmRIXhTCzVCTEYDNIt4u5HpMThq+fdtCXfjwhDw
         my/yRwIf+bslUPE/kURmyIKz/TLu/9QLJKheevtoyO1LmhSHUTYv0L5JJJwols5LyTbh
         F7JNDmpq0ZiiQNU1lJ1toDX+wRr/oSXjdxp+4QTNCbs8Msk2eU/CV+FnorvmEk5uHgnv
         ZtjeKBO61GE3aNBlk7ZTEwoHN8Vc/drsEwCxCPVIFKNCSHP1DEWsjxHQTrs9YYvjaW0N
         J9f0XmkjPGNtSRzI8pP8oDKVWN++6aKmZkyrQ2l6Seuk5dMQfXpqBBYOQNoo7hSPN3em
         572A==
X-Gm-Message-State: AOAM530IzNmSJMTuXL3kSSvh95tZ2375cionFWGUvmcO0IcZqsy9zxVh
        QXZQx0qGczUVX1FUzNh6hjeqGSnfbKjIVW4iHilpww==
X-Google-Smtp-Source: ABdhPJzPt2me5zAU0/rrKiJB9unrBPzqakZtEinMjw00JI2fGizxCw95qhMp2gcDUpMIssgcgnDYOfYxVS/ePSoGLoU=
X-Received: by 2002:a17:902:8306:b0:158:ea27:307d with SMTP id
 bd6-20020a170902830600b00158ea27307dmr29744990plb.164.1651087839950; Wed, 27
 Apr 2022 12:30:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220427161533.647837-1-krzysztof.kozlowski@linaro.org> <YmmLRbb4XNmpEn1b@robh.at.kernel.org>
In-Reply-To: <YmmLRbb4XNmpEn1b@robh.at.kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date:   Wed, 27 Apr 2022 21:30:27 +0200
Message-ID: <CAGE=qrrg-9v+4o31ZGDDOZuAHMVTUbo1dNLJDcFYdi0amWeUxA@mail.gmail.com>
Subject: Re: [PATCH 0/2] dmaengine/ARM: use proper 'dma-channels/requests' properties
To:     Rob Herring <robh@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, 27 Apr 2022 at 20:28, Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Apr 27, 2022 at 06:15:31PM +0200, Krzysztof Kozlowski wrote:
> > Hi,
> >
> > The core DT schema defines generic 'dma-channels' and 'dma-requests'
> > properties, so in preparation to moving bindings to DT schema, convert
> > existing users of '#dma-channels' and '#dma-requests' to the generic
> > variant.
> >
> > Not tested on hardware.
> >
> > IMPORTANT
> > =========
> > The patchset is not bisectable! The DTS patches should be applied a
> > release *after* driver change is accepted.
>
> There's no driver change though...

Indeed, copy paste cover letter. This FSL dma driver does not use the
properties, so it's only in the bindings and in the DTS. The patchset
can be taken as-is, without in-kernel ABI break. Only out-of-tree
users of DTSI will be affected.

Best regards,
Krzysztof
