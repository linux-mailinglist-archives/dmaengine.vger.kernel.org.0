Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACD9A6166B0
	for <lists+dmaengine@lfdr.de>; Wed,  2 Nov 2022 16:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbiKBP6i (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 2 Nov 2022 11:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbiKBP6Z (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 2 Nov 2022 11:58:25 -0400
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308352B63F;
        Wed,  2 Nov 2022 08:58:24 -0700 (PDT)
Received: by mail-ot1-f46.google.com with SMTP id 16-20020a9d0490000000b0066938311495so10515074otm.4;
        Wed, 02 Nov 2022 08:58:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Oa2mr0U3KqvEwJuScZMv4vEnQCNwkxhCzMMRCjtQd8=;
        b=wPET9zyytL3stC8A0a0u1P7kADbVOfllYv8NNNoz14nD2Vk94OCFPlSXaXmLkefVxY
         Z+/dyMZfymCTbGmZQVrIx/wPfDb9lEavcr0hp5uwSiBsLdqwdOcg+/XP5NJPC3RqX1U4
         5PdOmVpGbsrgsfG2kKlC7nYdAxn2AsNi4mxmTeWYQhN7UimAa1JVxoNi45AHhugfTMNh
         QfJWeFRRq9UaZ7HH0PAKNzVS36iikWgOlDb+yzID1o9VtfF9dQMcvHiuPlOWzwsp/Qbx
         X0TnRFe+7ViCq6Jv63rDjulZNK3u2UTpmf7bzq+8QhWhnWN5eKL8wGQNlK07icg/aQQX
         fC1A==
X-Gm-Message-State: ACrzQf1knNmJhrBR7rdfVnHzFqo04iH07rHpWSfv+0+kiQGZBKI3H5O+
        aENTWVMPAA57ZVdSFM5R+A==
X-Google-Smtp-Source: AMsMyM7YzP5LC5WYCWNyfVyHoLOCA5UFQJcFWDv0tjZ9hGCO3ONQ/cAk17lE/lNMBrsl1AJeXpEwGQ==
X-Received: by 2002:a05:6830:4114:b0:661:c422:191a with SMTP id w20-20020a056830411400b00661c422191amr12437806ott.286.1667404703323;
        Wed, 02 Nov 2022 08:58:23 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l4-20020a0568301d6400b0066c495a651dsm4050628oti.38.2022.11.02.08.58.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 08:58:22 -0700 (PDT)
Received: (nullmailer pid 3969605 invoked by uid 1000);
        Wed, 02 Nov 2022 15:58:24 -0000
Date:   Wed, 2 Nov 2022 10:58:24 -0500
From:   Rob Herring <robh@kernel.org>
To:     Joy Zou <joy.zou@nxp.com>
Cc:     shengjiu.wang@nxp.com, festevam@gmail.com, s.hauer@pengutronix.de,
        shawnguo@kernel.org, dev@lynxeye.de, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, kernel@pengutronix.de,
        martink@posteo.de, vkoul@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        alexander.stein@ew.tq-group.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, david@ixit.cz, linux-imx@nxp.com,
        hongxing.zhu@nxp.com, aford173@gmail.com, peng.fan@nxp.com,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH v9 1/2] dt-bindings: fsl-imx-sdma: Convert imx sdma to DT
 schema
Message-ID: <166740470387.3969545.8351119964620233012.robh@kernel.org>
References: <20221031105028.598502-1-joy.zou@nxp.com>
 <20221031105028.598502-2-joy.zou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031105028.598502-2-joy.zou@nxp.com>
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


On Mon, 31 Oct 2022 18:50:27 +0800, Joy Zou wrote:
> Convert the i.MX SDMA binding to DT schema format using json-schema.
> 
> The compatibles fsl,imx31-to1-sdma, fsl,imx31-to2-sdma, fsl,imx35-to1-sdma
> and fsl,imx35-to2-sdma are not used. So need to delete it. The compatibles
> fsl,imx50-sdma, fsl,imx6sll-sdma and fsl,imx6sl-sdma are added. The
> original binding don't list all compatible used.
> 
> In addition, add new peripheral types HDMI Audio.
> 
> Signed-off-by: Joy Zou <joy.zou@nxp.com>
> ---
> Changes in v9:
> add the dma-common quotes.
> delete the dma-controller quotes.
> 
> Changes in v8:
> add the dma-controller quotes.
> delete #dma-cells in required.
> 
> Changes in v6:
> delete tag Acked-by from commit message.
> 
> Changes in v5:
> modify the commit message fromat.
> add additionalProperties, because delete the quotes in patch v4.
> delete unevaluatedProperties due to similar to additionalProperties.
> modification fsl,sdma-event-remap items and description.
> 
> Changes in v4:
> modify the commit message.
> delete the quotes in patch.
> modify the compatible in patch.
> delete maxitems and add items for clock-names property.
> add iram property.
> 
> Changes in v3:
> modify the commit message.
> modify the filename.
> modify the maintainer.
> delete the unnecessary comment.
> modify the compatible and run dt_binding_check and dtbs_check.
> add clocks and clock-names property.
> delete the reg description and add maxItems.
> delete the interrupts description and add maxItems.
> add ref for gpr property.
> modify the fsl,sdma-event-remap ref type and add items.
> delete consumer example.
> 
> Changes in v2:
> convert imx sdma bindings to DT schema.
> ---
>  .../devicetree/bindings/dma/fsl,imx-sdma.yaml | 149 ++++++++++++++++++
>  .../devicetree/bindings/dma/fsl-imx-sdma.txt  | 118 --------------
>  2 files changed, 149 insertions(+), 118 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/dma/fsl,imx-sdma.yaml
>  delete mode 100644 Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
