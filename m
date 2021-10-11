Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 021864299B7
	for <lists+dmaengine@lfdr.de>; Tue, 12 Oct 2021 01:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235719AbhJKXPv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 Oct 2021 19:15:51 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:36854 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235708AbhJKXPu (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 11 Oct 2021 19:15:50 -0400
Received: by mail-ot1-f44.google.com with SMTP id p6-20020a9d7446000000b0054e6bb223f3so8846678otk.3;
        Mon, 11 Oct 2021 16:13:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=DF/d5K0cmxoRkh9SydPvlCe1QMk0HbpgU+/wg0AVV2o=;
        b=phfP82wLetlEu0gRwYx+pkFB7iMWsZOtKj/4TBuOyKswEKhhihQfIJQPTFSZUvGQHC
         OwyYPBMGX/ZqOQXPJ6vUitkdG9TsaCDOmLWohOQIAWakd5vDxbbLbQxJBxW4b4g+ign6
         pFWegdPzfOkhgh+r8poThtGwDcd0+6UGyjasjqPP8OFTeDfhkGDsbGZFfs8bOExhxlvY
         LCl4wjezBvxN6VVdxy1VQRnLCwEQo5oJksqKNVmVUKvFWt7+odil2BJqbsuEYuIuGVex
         aA7zk3PW3658X3K9sgk62hU0fDY4nbARuEFUGMxZMLTTUiRybqztE6s060rCvXHf/Im4
         KNxA==
X-Gm-Message-State: AOAM532mwoGMiTz4qu4mJMRCxPw3eioxuBFWObW3o9PpIuJbh3lbOKos
        TWfcCOx3TVGZVhlIkjHHB+S7kSJApw==
X-Google-Smtp-Source: ABdhPJy6od+aZa9csuzLBy1w8Z9iY9Ca4jrZ7WaqPvk3lpAM+SGIgdAqicVrOYilyATFt1MGFp/MFQ==
X-Received: by 2002:a9d:4c8:: with SMTP id 66mr23888697otm.113.1633994029005;
        Mon, 11 Oct 2021 16:13:49 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id d7sm2012596otl.19.2021.10.11.16.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 16:13:48 -0700 (PDT)
Received: (nullmailer pid 1347638 invoked by uid 1000);
        Mon, 11 Oct 2021 23:13:43 -0000
From:   Rob Herring <robh@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        devicetree@vger.kernel.org, list@opendingux.net,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20211011143652.51976-2-paul@crapouillou.net>
References: <20211011143652.51976-1-paul@crapouillou.net> <20211011143652.51976-2-paul@crapouillou.net>
Subject: Re: [PATCH 1/5] dt-bindings: dma: ingenic: Add compatible strings for MDMA and BDMA
Date:   Mon, 11 Oct 2021 18:13:43 -0500
Message-Id: <1633994023.327839.1347637.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, 11 Oct 2021 16:36:48 +0200, Paul Cercueil wrote:
> The JZ4760 and JZ4760B SoCs have two additional DMA controllers: the
> MDMA, which only supports memcpy operations, and the BDMA which is
> mostly used for transfer between memories and the BCH controller.
> The JZ4770 also features the same BDMA as in the JZ4760B, but does not
> seem to have a MDMA.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  .../devicetree/bindings/dma/ingenic,dma.yaml  | 26 ++++++++++++-------
>  1 file changed, 17 insertions(+), 9 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/dma/ingenic,dma.yaml:19:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
./Documentation/devicetree/bindings/dma/ingenic,dma.yaml:32:9: [warning] wrong indentation: expected 10 but found 8 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1539355

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

