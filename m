Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F353588482
	for <lists+dmaengine@lfdr.de>; Wed,  3 Aug 2022 00:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbiHBWom (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 2 Aug 2022 18:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiHBWol (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 2 Aug 2022 18:44:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F8F54ACE;
        Tue,  2 Aug 2022 15:44:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3045BB8213F;
        Tue,  2 Aug 2022 22:44:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D466BC433D7;
        Tue,  2 Aug 2022 22:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659480277;
        bh=V9bk76GSzx33fU+JZ+1Bdf90KJc+ck5Yqw/pwb8oRxg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Gadaajw8M9DDiWhT/k6J+yzz4p8PpUvtrllO7Mi2ekfYWHFi89NQ3meznMyUXIdCs
         h/K46ThUWYOYukOyHkoHz62W+/mIO949x6zwztX1cVRIwyjOXkuepfrgKne3QGN/10
         tm4+vvGM73gCvKfnUXQ4lO9CF/ghduBYOtYIidD1V7JIlZYCaxcLdPNB/DjQLDIV1G
         0HvOIVAjivVuqIyUXcj4/0uFQAa9gUvRSNreJfwPis8qgQeLBMYtDLGTpyDaIccNSw
         Y4nAQ08fOUoR9zUO40PLExqokEjlCgQojAMc90VGcUtq7r4VaRVJc/5oPPehyQwXYT
         0mvLHxllP70Lw==
Received: by mail-pj1-f46.google.com with SMTP id d65-20020a17090a6f4700b001f303a97b14so203754pjk.1;
        Tue, 02 Aug 2022 15:44:37 -0700 (PDT)
X-Gm-Message-State: ACgBeo3R0kq8Pzw/bPShw6QVZH2sfTgULy6T8brAW9IGLeZzoJDUPg+5
        tycwmju1Vnfp8uwj2aoAZmzehZsWdKK+/Rq6yg==
X-Google-Smtp-Source: AA6agR4yGn4dNgN1F5VZu/eS4OHwaG9ojj3g7zAcnkZGjF9yIXh6RCdJOQOCU4N9lVwJ2tW4qCHsr0tWdDEMjgyVL4Q=
X-Received: by 2002:a17:903:328e:b0:16e:fa5f:37ae with SMTP id
 jh14-20020a170903328e00b0016efa5f37aemr8392334plb.148.1659480277466; Tue, 02
 Aug 2022 15:44:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220524080337.1322240-1-joy.zou@nxp.com> <AM6PR04MB592501ABD3A369F913137E1FE19D9@AM6PR04MB5925.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR04MB592501ABD3A369F913137E1FE19D9@AM6PR04MB5925.eurprd04.prod.outlook.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 2 Aug 2022 16:44:25 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJWvLrC91=MvVUiCyC3txEbK7tvja1SpZ7wsUktPMNoeA@mail.gmail.com>
Message-ID: <CAL_JsqJWvLrC91=MvVUiCyC3txEbK7tvja1SpZ7wsUktPMNoeA@mail.gmail.com>
Subject: Re: FW: [PATCH V2 1/2] bindings: fsl-imx-sdma: Document 'HDMI Audio' transfer
To:     Joy Zou <joy.zou@nxp.com>
Cc:     "vkoul@kernel.org" <vkoul@kernel.org>,
        "S.J. Wang" <shengjiu.wang@nxp.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Aug 1, 2022 at 9:58 PM Joy Zou <joy.zou@nxp.com> wrote:
>
> Gentle ping...

For what? Krzysztof commented less than 2 hours after you sent v2. And
dtbs_check shows a ton of warnings as reported. I suspect you need to
update the schema to fix some of those unless you think they are all
.dts file fixes.

Rob
