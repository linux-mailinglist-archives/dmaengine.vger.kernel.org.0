Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9037975689B
	for <lists+dmaengine@lfdr.de>; Mon, 17 Jul 2023 18:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbjGQQDQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 17 Jul 2023 12:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbjGQQDM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 17 Jul 2023 12:03:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18EF910F8;
        Mon, 17 Jul 2023 09:03:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C72061129;
        Mon, 17 Jul 2023 16:03:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1B9CC433CB;
        Mon, 17 Jul 2023 16:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689609784;
        bh=aZICCOVfKf1PqTHgRCOupCS9EkykRJONrhoP14RlBbY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RjTKbIlOKFKAdT9+GbcTkdLrDGOHEezkmDutGTRyLx2lp53JR+Nz+OR6K+D9kTAaq
         AiKAEbcjoQm/6Y4ZH2T94uqpkUTXE/ivwfxwwzCs3GX629h8bGy6BxqwTffITGuDgz
         lrWsuT+VfZUJhf5khJL01hNYIk7FTk420NOk02QnaYVF3z8+Md13oy8ytRu/scv6uO
         jhYu7UHeznp3ruJwr/tNBSXy4ect2sUkWAgSioVZjPhu5oeLzhGDc4zky934XT//wF
         jZx/4IwrsVwoVvV1FzoAV+rY/02+4k0C0RSeWmeEazP8s1BxvRca5gX6K46WO7ajgV
         sJK4ccBDA5WTQ==
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3142970df44so4499379f8f.3;
        Mon, 17 Jul 2023 09:03:03 -0700 (PDT)
X-Gm-Message-State: ABy/qLZDVDEolBs+MgxPnz4UnJwlcq1RqZOSAH4vwYajl6RGbwtz0iLd
        89wGea8/XZYb0vnOZyIKzllnCu6V8oRnXcz9oQ==
X-Google-Smtp-Source: APBJJlGT3Z4OwG+5PD2iOuBmukBKYkwOVI4cYi2ZBHphRuP2mDYunFyhxEBn+UEFg93NJOzQaxqKN1Nt2m8NdZz6Fm0=
X-Received: by 2002:a2e:9455:0:b0:2b4:6f0c:4760 with SMTP id
 o21-20020a2e9455000000b002b46f0c4760mr8630130ljh.11.1689609761393; Mon, 17
 Jul 2023 09:02:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230714174430.4054533-1-robh@kernel.org>
In-Reply-To: <20230714174430.4054533-1-robh@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 17 Jul 2023 10:02:28 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+qcoFd7_wWUZeHgqWpB0JfdE0j4qLCxfJwD_Cqkz-HgA@mail.gmail.com>
Message-ID: <CAL_Jsq+qcoFd7_wWUZeHgqWpB0JfdE0j4qLCxfJwD_Cqkz-HgA@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: Explicitly include correct DT includes
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Vinod Koul <vkoul@kernel.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Li Yang <leoyang.li@nxp.com>, Zhang Wei <zw@zh-kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Sinan Kaya <okaya@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Michal Simek <michal.simek@amd.com>
Cc:     devicetree@vger.kernel.org, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-mediatek@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Jul 14, 2023 at 11:44=E2=80=AFAM Rob Herring <robh@kernel.org> wrot=
e:
>
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it as merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/dma/apple-admac.c                      | 3 ++-
>  drivers/dma/at_hdmac.c                         | 2 +-
>  drivers/dma/bcm-sba-raid.c                     | 4 +++-
>  drivers/dma/bestcomm/bestcomm.c                | 4 +---

v2 coming for this:

>> drivers/dma/bestcomm/bestcomm.
c:80:13: error: call to undeclared function 'irq_of_parse_and_map';
ISO C99 and later do not support implicit function declarations
[-Wimplicit-function-declaration]
      80 |         tsk->irq =3D irq_of_parse_and_map(bcom_eng->ofnode,
tsk->tasknum);
         |                    ^
>> drivers/dma/bestcomm/bestcomm.c:105:4: error: call to undeclared functio=
n 'irq_dispose_mapping'; ISO C99 and later do not support implicit function=
 declarations [-Wimplicit-function-declaration]
     105 |                         irq_dispose_mapping(tsk->irq);
         |                         ^
   drivers/dma/bestcomm/bestcomm.c:128:2: error: call to undeclared
function 'irq_dispose_mapping'; ISO C99 and later do not support
implicit function declarations [-Wimplicit-function-declaration]
     128 |         irq_dispose_mapping(tsk->irq);
         |         ^
   3 errors generated.
