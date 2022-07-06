Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C37AC568B9F
	for <lists+dmaengine@lfdr.de>; Wed,  6 Jul 2022 16:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbiGFOsf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 6 Jul 2022 10:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233150AbiGFOsc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 6 Jul 2022 10:48:32 -0400
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB22815A0D;
        Wed,  6 Jul 2022 07:48:31 -0700 (PDT)
Received: by mail-il1-f180.google.com with SMTP id k1so4751462ilu.1;
        Wed, 06 Jul 2022 07:48:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Wrq2JNxdSNjz+AtYT/VK5cdxeQSjmsW3VIzTuH5qvso=;
        b=Bz8MtfXbNZF7X98JS3LTjBT2T1nvOIfACd70HC+T/0VzrHT6DCAONsIeslYb/rmqTV
         7U4hbDAfWUTEVwwjzEPY923WDXxOQFiv/ruuwtGJsBwVqaqVYUwHoGxR3yRbtmLowbkB
         ZbhfBs8lq9AHx/temzI1iHW/DiZ4B3DCCvBJwsR8fzrcoXTNFgh81A8FNrl0QJAN6Gwr
         Fw70agJzMzzU8Pv5R7y+Rn9Z6kUqVrhCU/x5m2Vnh+KylDYoAKzmUjo1cmIwJ98YZXdU
         8+hMLdotBK9ZpxKDtDpw3geh2XZAR943QuBeLzR/ajtyZ7cQScfmu5VGjjxFHwoC8v51
         kAVg==
X-Gm-Message-State: AJIora/In85zDywFd4RJunYGcGtrk1vcs1JIufdC5xNAUhNYez2tQJa0
        zObZmJDblRNV4xQPfII05A==
X-Google-Smtp-Source: AGRyM1sb5HmhX0XgK9jcKFeRefRiVrF9p1b4SQg8YeeZGNu7klKkXRLtLFt3S05zijGKW8PJyzkj/Q==
X-Received: by 2002:a92:d946:0:b0:2d8:e271:79c2 with SMTP id l6-20020a92d946000000b002d8e27179c2mr24307561ilq.240.1657118911231;
        Wed, 06 Jul 2022 07:48:31 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id a21-20020a027355000000b0033ebd47834fsm5173779jae.128.2022.07.06.07.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 07:48:30 -0700 (PDT)
Received: (nullmailer pid 21846 invoked by uid 1000);
        Wed, 06 Jul 2022 14:48:28 -0000
Date:   Wed, 6 Jul 2022 08:48:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Conor Dooley <mail@conchuod.ie>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        dmaengine@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-riscv@lists.infradead.org,
        Niklas Cassel <niklas.cassel@wdc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Sam Ravnborg <sam@ravnborg.org>, devicetree@vger.kernel.org,
        Dillon Min <dillon.minfei@gmail.com>
Subject: Re: [PATCH v5 04/13] dt-bindings: memory-controllers: add canaan
 k210 sram controller
Message-ID: <20220706144828.GA21787-robh@kernel.org>
References: <20220705215213.1802496-1-mail@conchuod.ie>
 <20220705215213.1802496-5-mail@conchuod.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705215213.1802496-5-mail@conchuod.ie>
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

On Tue, 05 Jul 2022 22:52:05 +0100, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> The k210 U-Boot port has been using the clocks defined in the
> devicetree to bring up the board's SRAM, but this violates the
> dt-schema. As such, move the clocks to a dedicated node with
> the same compatible string & document it.
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../memory-controllers/canaan,k210-sram.yaml  | 52 +++++++++++++++++++
>  1 file changed, 52 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/canaan,k210-sram.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
