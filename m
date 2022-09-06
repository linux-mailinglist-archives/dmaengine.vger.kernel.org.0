Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99CF05AF101
	for <lists+dmaengine@lfdr.de>; Tue,  6 Sep 2022 18:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238153AbiIFQqZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 6 Sep 2022 12:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233902AbiIFQpr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 6 Sep 2022 12:45:47 -0400
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6D97B2BA;
        Tue,  6 Sep 2022 09:25:53 -0700 (PDT)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-127ba06d03fso5882376fac.3;
        Tue, 06 Sep 2022 09:25:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=nLk2tHEZjw/WNoaVVDMOlbDOyUnW9vyfOpQM4cnClvI=;
        b=jzZ5iv4l+cOmrtaWqz7uzHBmiuT2J94g+InUFkGt1a8JCNIO9Pf2h59FbMFb5sWfXu
         OhgasUtlG1nSuu96wAE2befcKvgsOb68dvgUa4YbicPt0vZ2JzNDzmK38UQI6EFq+prz
         Us60ck4UOXO6WsxY3pNjZ8SaUiNmxj8hoFbly7TiO5zX3LmyBmkJrwGDUAuUi7XGHZzZ
         Vn724X7uikobFTvB0YBzaLxEfbDc9ro6SvtTK+jT/zidY8nq6AFM7kcRLJPzu1tilywx
         Vk04HpCLadVjaFzQLM1Rj72aBGCraZDKAaWFg8ACuTSvDH72dvvVmfufV6JbfNRkcB6a
         SS/w==
X-Gm-Message-State: ACgBeo0039nCh9QcDH/ZgHQdpG6lUFwVdOgTgm56T6Toc16ELw7UEni+
        FOK7EVKsGTVgxg/p93d4Xg==
X-Google-Smtp-Source: AA6agR4XFWHpXeFahUwXObQOJFMisExAbB2J6LdFjzK50pm+TOKTLLEquq3PoJ+rh86WbLCLYUFG0Q==
X-Received: by 2002:a05:6808:20a9:b0:343:c4e:24c8 with SMTP id s41-20020a05680820a900b003430c4e24c8mr10360338oiw.73.1662481552575;
        Tue, 06 Sep 2022 09:25:52 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w9-20020a056830280900b00638a1c49383sm5968530otu.78.2022.09.06.09.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 09:25:52 -0700 (PDT)
Received: (nullmailer pid 644962 invoked by uid 1000);
        Tue, 06 Sep 2022 16:25:51 -0000
Date:   Tue, 6 Sep 2022 11:25:51 -0500
From:   Rob Herring <robh@kernel.org>
To:     Joy Zou <joy.zou@nxp.com>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "S.J. Wang" <shengjiu.wang@nxp.com>,
        "martink@posteo.de" <martink@posteo.de>,
        "dev@lynxeye.de" <dev@lynxeye.de>, Peng Fan <peng.fan@nxp.com>,
        "david@ixit.cz" <david@ixit.cz>,
        "aford173@gmail.com" <aford173@gmail.com>,
        Hongxing Zhu <hongxing.zhu@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXT] Re: [PATCH v6 1/4] dt-bindings: fsl-imx-sdma: Convert imx
 sdma to DT schema
Message-ID: <20220906162551.GA636621-robh@kernel.org>
References: <20220906094256.3787384-1-joy.zou@nxp.com>
 <20220906094256.3787384-2-joy.zou@nxp.com>
 <4743969.GXAFRqVoOG@steina-w>
 <AM6PR04MB59257DD8A94B63D419737756E17E9@AM6PR04MB5925.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM6PR04MB59257DD8A94B63D419737756E17E9@AM6PR04MB5925.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Sep 06, 2022 at 11:13:41AM +0000, Joy Zou wrote:
> 
> > -----Original Message-----
> > From: Alexander Stein <alexander.stein@ew.tq-group.com>
> > Sent: 2022年9月6日 18:55
> > To: Joy Zou <joy.zou@nxp.com>
> > Cc: vkoul@kernel.org; robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org;
> > shawnguo@kernel.org; s.hauer@pengutronix.de; kernel@pengutronix.de;
> > festevam@gmail.com; S.J. Wang <shengjiu.wang@nxp.com>;
> > martink@posteo.de; dev@lynxeye.de; Peng Fan <peng.fan@nxp.com>;
> > david@ixit.cz; aford173@gmail.com; Hongxing Zhu <hongxing.zhu@nxp.com>;
> > dl-linux-imx <linux-imx@nxp.com>; dmaengine@vger.kernel.org;
> > devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > linux-kernel@vger.kernel.org
> > Subject: [EXT] Re: [PATCH v6 1/4] dt-bindings: fsl-imx-sdma: Convert imx sdma
> > to DT schema
> > 
> > Caution: EXT Email
> > 
> > Hi,
> > 
> > thanks for the YAML conversion patch.
> > 
> > Am Dienstag, 6. September 2022, 11:42:53 CEST schrieb Joy Zou:
> > > Convert the i.MX SDMA binding to DT schema format using json-schema.
> > >
> > > The compatibles fsl,imx31-to1-sdma, fsl,imx31-to2-sdma,
> > > fsl,imx35-to1-sdma and fsl,imx35-to2-sdma are not used. So need to
> > > delete it. The compatibles fsl,imx50-sdma, fsl,imx6sll-sdma and
> > > fsl,imx6sl-sdma are added. The original binding don't list all compatible used.
> > >
> > > In addition, add new peripheral types HDMI Audio.
> > >
> > > Signed-off-by: Joy Zou <joy.zou@nxp.com>
> > > ---
> > > Changes in v6:
> > > delete tag Acked-by from commit message.
> > >
> > > Changes in v5:
> > > modify the commit message fromat.
> > > add additionalProperties, because delete the quotes in patch v4.
> > > delete unevaluatedProperties due to similar to additionalProperties.
> > > modification fsl,sdma-event-remap items and description.
> > >
> > > Changes in v4:
> > > modify the commit message.
> > > delete the quotes in patch.
> > > modify the compatible in patch.
> > > delete maxitems and add items for clock-names property.
> > > add iram property.
> > >
> > > Changes in v3:
> > > modify the commit message.
> > > modify the filename.
> > > modify the maintainer.
> > > delete the unnecessary comment.
> > > modify the compatible and run dt_binding_check and dtbs_check.
> > > add clocks and clock-names property.
> > > delete the reg description and add maxItems.
> > > delete the interrupts description and add maxItems.
> > > add ref for gpr property.
> > > modify the fsl,sdma-event-remap ref type and add items.
> > > delete consumer example.
> > >
> > > Changes in v2:
> > > convert imx sdma bindings to DT schema.
> > > ---
> > >  .../devicetree/bindings/dma/fsl,imx-sdma.yaml | 147
> > > ++++++++++++++++++  .../devicetree/bindings/dma/fsl-imx-sdma.txt  |
> > > 118 --------------
> > >  2 files changed, 147 insertions(+), 118 deletions(-)  create mode
> > > 100644 Documentation/devicetree/bindings/dma/fsl,imx-sdma.yaml
> > >  delete mode 100644
> > > Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
> > >
> > > diff --git a/Documentation/devicetree/bindings/dma/fsl,imx-sdma.yaml
> > > b/Documentation/devicetree/bindings/dma/fsl,imx-sdma.yaml new file
> > > mode
> > > 100644
> > > index 000000000000..3da65d3ea4af
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/dma/fsl,imx-sdma.yaml
> > > @@ -0,0 +1,147 @@
> > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause %YAML 1.2
> > > +---
> > > +$id:
> > > +https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevi
> > >
> > +cetree.org%2Fschemas%2Fdma%2Ffsl%2Cimx-sdma.yaml%23&amp;data=05
> > %7C01%
> > >
> > +7Cjoy.zou%40nxp.com%7Cc7a8409ee52447126b2908da8ff649db%7C686ea
> > 1d3bc2b
> > >
> > +4c6fa92cd99c5c301635%7C0%7C0%7C637980585219845112%7CUnknown
> > %7CTWFpbGZ
> > >
> > +sb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6M
> > n0%
> > >
> > +3D%7C3000%7C%7C%7C&amp;sdata=XHRpq%2BiZpXdB7Yw4gZRONgWMn7
> > KiSxM9yBES7R
> > > +H0iNc%3D&amp;reserved=0
> > > +$schema:
> > > +https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevi
> > >
> > +cetree.org%2Fmeta-schemas%2Fcore.yaml%23&amp;data=05%7C01%7Cjoy.z
> > ou%4
> > >
> > +0nxp.com%7Cc7a8409ee52447126b2908da8ff649db%7C686ea1d3bc2b4c6f
> > a92cd99
> > >
> > +c5c301635%7C0%7C0%7C637980585220001350%7CUnknown%7CTWFpbG
> > Zsb3d8eyJWIj
> > >
> > +oiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3
> > 000%7
> > >
> > +C%7C%7C&amp;sdata=6albMSOV7dsgaHuDk05ZUtAiMTlwYX6QyHrfXWz7%2
> > BmY%3D&am
> > > +p;reserved=0
> > > +
> > > +title: Freescale Smart Direct Memory Access (SDMA) Controller for
> > > +i.MX
> > > +
> > > +maintainers:
> > > +  - Joy Zou <joy.zou@nxp.com>
> > > +
> > > +properties:
> > 
> > Is it sensible to add something like this?
> > 
> >   $nodename:
> >     pattern: "^dma-controller(@.*)?$"
> > 
> > You are changing the node names in patch 3 anyway.
> Yes, it is sensible to add $nodename. Because I have deleted the dma-controller quotes.
> I follow the dma-controller $nodename. I think it is general. So changing the node name.
> I will add it next version.
> Thanks for your comments!

Instead, just add:

allOf:
  - $ref: dma-controller.yaml#


That will do the same thing.

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

Rob
