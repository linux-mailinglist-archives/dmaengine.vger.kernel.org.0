Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2B9577712F
	for <lists+dmaengine@lfdr.de>; Thu, 10 Aug 2023 09:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232907AbjHJHUq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 10 Aug 2023 03:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233712AbjHJHUi (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 10 Aug 2023 03:20:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535BE1718;
        Thu, 10 Aug 2023 00:20:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF78B65132;
        Thu, 10 Aug 2023 07:20:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A0B5C433C7;
        Thu, 10 Aug 2023 07:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691652037;
        bh=lVp1fdZkB3g1qBqLaFckDWoDTsdFHEO1yT6/fIrNlq0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=WWIWH6bqssPracuMAzLqNyFVN8jTR6htHRM3yXs4Yzc/i1NS7Og4+o4m6xa9Djxji
         m0P93r3ddeiLztoibTGo5TowIj/2A30FfjLKL9mCYn6wet84HXTWbWqad/w6l3Tg18
         iFp0X58ZTizwh5Lvfzo0j78HEldZM0r4MvzFv8nKfCoop85a2Id04uhAzodLdFJoIr
         Laf54g3RxoWn+F9Wn9mRQXMggQciZD2tOGfRSoHmekcD11XjAwfwyKcSKPtBOt4LmZ
         FEtQ5P4Rn5omGab60cfP4CzpCcO7IiPwhOAn8gi7OtW1UBwt1ZdUUBea1ESet9tBv1
         mORzMC5obp7jg==
Received: (nullmailer pid 3911837 invoked by uid 1000);
        Thu, 10 Aug 2023 07:20:21 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Binbin Zhou <zhoubinbin@loongson.cn>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Binbin Zhou <zhoubb.aaron@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Xuerui Wang <kernel@xen0n.name>, devicetree@vger.kernel.org,
        loongarch@lists.linux.dev,
        Conor Dooley <conor.dooley@microchip.com>,
        loongson-kernel@lists.loongnix.cn, Vinod Koul <vkoul@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Yingkun Meng <mengyingkun@loongson.cn>,
        dmaengine@vger.kernel.org
In-Reply-To: <1f921395f61d305e0d05cdb1937bdbadf479e025.1691647870.git.zhoubinbin@loongson.cn>
References: <cover.1691647870.git.zhoubinbin@loongson.cn>
 <1f921395f61d305e0d05cdb1937bdbadf479e025.1691647870.git.zhoubinbin@loongson.cn>
Message-Id: <169165202097.3911766.12811830439842145796.robh@kernel.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: dmaengine: Add Loongson LS2X APB
 DMA controller
Date:   Thu, 10 Aug 2023 01:20:21 -0600
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On Thu, 10 Aug 2023 14:56:38 +0800, Binbin Zhou wrote:
> Add Loongson LS2X APB DMA controller binding with DT schema
> format using json-schema.
> 
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../bindings/dma/loongson,ls2x-apbdma.yaml    | 62 +++++++++++++++++++
>  MAINTAINERS                                   |  6 ++
>  2 files changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/loongson,ls2x-apbdma.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/1f921395f61d305e0d05cdb1937bdbadf479e025.1691647870.git.zhoubinbin@loongson.cn

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

