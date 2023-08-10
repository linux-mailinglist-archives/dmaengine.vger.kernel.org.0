Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B354877823F
	for <lists+dmaengine@lfdr.de>; Thu, 10 Aug 2023 22:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjHJUk2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 10 Aug 2023 16:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235712AbjHJUkX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 10 Aug 2023 16:40:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C9E2D68;
        Thu, 10 Aug 2023 13:40:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 421DA60B59;
        Thu, 10 Aug 2023 20:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 695BBC433C8;
        Thu, 10 Aug 2023 20:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691700020;
        bh=/ucuze0js3jaTTWYHvsRV/AOIKKGj3EBCPrAPiZmOG8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PNBN5xISXH7rAHNiMxcftXCUMxuMvvEMEtOr9EglKDljaggrL6KSiHl+SQnAxmrS8
         Pj/e5yHTQIQR8KgtG5tbQCjlDDs1PLZpBgcs75xZgSO4KQTqhO+UisROKnzkaZ3Mpv
         ZtegivcWncn6NGNgqLl/GsRyt+JdfeU2dBMK6WMAMRJr1AQo9gWk5QQY1KZ9881Fpd
         nc715iaJxAF4cS+d2xpM3reOz0GE8T9HEI0RUyxGsczfK1Kz1mmvIgD5hRGn+Otfqm
         OeJJ/GiVDe687SqPsOaeyClAmuai6ApfuaEuft4/jCfwTnTzDygRP4nzaTfoYizAlA
         u81CONZZvEpfQ==
Received: (nullmailer pid 1135487 invoked by uid 1000);
        Thu, 10 Aug 2023 20:40:18 -0000
Date:   Thu, 10 Aug 2023 14:40:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Binbin Zhou <zhoubinbin@loongson.cn>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Binbin Zhou <zhoubb.aaron@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Xuerui Wang <kernel@xen0n.name>, devicetree@vger.kernel.org,
        loongarch@lists.linux.dev,
        Conor Dooley <conor.dooley@microchip.com>,
        loongson-kernel@lists.loongnix.cn, Vinod Koul <vkoul@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Yingkun Meng <mengyingkun@loongson.cn>,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: dmaengine: Add Loongson LS2X APB DMA
 controller
Message-ID: <20230810204018.GA1132140-robh@kernel.org>
References: <cover.1691647870.git.zhoubinbin@loongson.cn>
 <1f921395f61d305e0d05cdb1937bdbadf479e025.1691647870.git.zhoubinbin@loongson.cn>
 <169165202097.3911766.12811830439842145796.robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169165202097.3911766.12811830439842145796.robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Aug 10, 2023 at 01:20:21AM -0600, Rob Herring wrote:
> 
> On Thu, 10 Aug 2023 14:56:38 +0800, Binbin Zhou wrote:
> > Add Loongson LS2X APB DMA controller binding with DT schema
> > format using json-schema.
> > 
> > Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > ---
> >  .../bindings/dma/loongson,ls2x-apbdma.yaml    | 62 +++++++++++++++++++
> >  MAINTAINERS                                   |  6 ++
> >  2 files changed, 68 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/dma/loongson,ls2x-apbdma.yaml
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> 
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/1f921395f61d305e0d05cdb1937bdbadf479e025.1691647870.git.zhoubinbin@loongson.cn

The bot was having an issue. This can be ignored.

Rob
