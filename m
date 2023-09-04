Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC5B791117
	for <lists+dmaengine@lfdr.de>; Mon,  4 Sep 2023 07:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233558AbjIDFqi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+dmaengine@lfdr.de>); Mon, 4 Sep 2023 01:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344916AbjIDFqh (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 4 Sep 2023 01:46:37 -0400
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86BF312A;
        Sun,  3 Sep 2023 22:46:31 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2bcc14ea414so15329101fa.0;
        Sun, 03 Sep 2023 22:46:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693806389; x=1694411189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jSlS5Nn7/93tzc5hw6/561afVbIZPCAbfsDHLo7s/EE=;
        b=RcZMqD8sKtOg9Mfd6amPe5flFr5kTg1xGvu3PemSXBiFJswAbynp/4NnmMlVdY+PiH
         hMW+WCoRzY+ryilRYszd5jrx+BgWVXQ58IesZM2P7gYi0GmHgcjpBANSX6S9BshAoYQw
         wtLAThYE+VQSAeNGqr+mbPZEynkAFhX2LMFRGYChGm0lp+3DT4aHl9cnsWE7hGmCAVov
         +0NtAJ370acNSXqw7N9BdOUfLIMz9CLjnXNPn+8dAqbP4+9E988z2ezyIn/Zbdy2HNbA
         Y/NhbyDOTxjU5Jwwh6iMBgYQpOLrGR37PlmJC23R3N4I8qZHzh+BxulecfXg8qWIllq9
         +k0g==
X-Gm-Message-State: AOJu0Yy3nvTQZLK0sGi5fmY1zUwsJVcsLT1UKcj/x3Z2I03pgq1j0jlP
        aOBYiX1apDK61/0Kgzpv7GQxLRjewTQIww==
X-Google-Smtp-Source: AGHT+IE9iJJbg5uLyZxRNWRUHSN5BFgHrWRP3x3jjRncvTvZAFh8yQgeXqXp3SYAmKCoho2RuyIUJw==
X-Received: by 2002:a2e:7207:0:b0:2b6:9fdf:d8f4 with SMTP id n7-20020a2e7207000000b002b69fdfd8f4mr6262540ljc.29.1693806389317;
        Sun, 03 Sep 2023 22:46:29 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id m19-20020a2eb6d3000000b002bcda31af0fsm1869948ljo.74.2023.09.03.22.46.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Sep 2023 22:46:29 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5008d16cc36so1741854e87.2;
        Sun, 03 Sep 2023 22:46:29 -0700 (PDT)
X-Received: by 2002:a19:500f:0:b0:500:b553:c09e with SMTP id
 e15-20020a19500f000000b00500b553c09emr5025415lfb.32.1693806388886; Sun, 03
 Sep 2023 22:46:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230828170013.75820-1-povik+lin@cutebit.org>
In-Reply-To: <20230828170013.75820-1-povik+lin@cutebit.org>
From:   Neal Gompa <neal@gompa.dev>
Date:   Mon, 4 Sep 2023 01:45:52 -0400
X-Gmail-Original-Message-ID: <CAEg-Je8_f_hZ3VyBg+8tK8uobWNaEqCwp==2JhV6jVpPYXj_Pg@mail.gmail.com>
Message-ID: <CAEg-Je8_f_hZ3VyBg+8tK8uobWNaEqCwp==2JhV6jVpPYXj_Pg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Apple SIO driver
To:     =?UTF-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, asahi@lists.linux.dev,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Aug 28, 2023 at 1:00 PM Martin Povišer <povik+lin@cutebit.org> wrote:
>
> Hi all,
>
> see attached a driver for the SIO coprocessor found on recent Apple
> SoCs. This coprocessor provides general DMA services, it can feed
> many peripherals but so far it seems it will only be useful for
> audio output over HDMI/DisplayPort. So the driver here only supports
> the DMA_CYCLIC mode of transactions with the focus being on audio.
> There's a downstream prototype ALSA driver the DMA driver is being
> tested against.
>
> Some of the boilerplate code in implementing the dmaengine interface
> was lifted from apple-admac.c. Among other things these two drivers
> have in common that they implement the DMA_CYCLIC regime on top of
> hardware/coprocessor layer supporting linear transactions only.
>
> The binding schema saw two RFC rounds before and has a reviewed-by
> from Rob.
> https://lore.kernel.org/asahi/167693643966.613996.10372170526471864080.robh@kernel.org
>
> Best regards,
> Martin
>
> --
>
> Changes since v1:
> https://lore.kernel.org/asahi/20230712133806.4450-1-povik+lin@cutebit.org/T/#t
>  - move to using virt-dma
>  - drop redundant cookie field from `sio_tx`
>  - use DECLARE_BITMAP for `allocated` in sio_tagdata
>
> Martin Povišer (2):
>   dt-bindings: dma: apple,sio: Add schema
>   dmaengine: apple-sio: Add Apple SIO driver
>
>  .../devicetree/bindings/dma/apple,sio.yaml    | 111 +++
>  MAINTAINERS                                   |   2 +
>  drivers/dma/Kconfig                           |  11 +
>  drivers/dma/Makefile                          |   1 +
>  drivers/dma/apple-sio.c                       | 868 ++++++++++++++++++
>  5 files changed, 993 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/apple,sio.yaml
>  create mode 100644 drivers/dma/apple-sio.c
>
> --
> 2.38.3
>
>

Series looks reasonable to me, though this is something I'm more new
at looking at...

Acked-by: Neal Gompa <neal@gompa.dev>


-- 
真実はいつも一つ！/ Always, there's only one truth!
