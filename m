Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C794E552A16
	for <lists+dmaengine@lfdr.de>; Tue, 21 Jun 2022 06:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiFUENK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 Jun 2022 00:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243817AbiFUENG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 21 Jun 2022 00:13:06 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8525FF1;
        Mon, 20 Jun 2022 21:13:01 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id m16-20020a7bca50000000b0039c8a224c95so6577260wml.2;
        Mon, 20 Jun 2022 21:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gWNf4zISviT0O075eMDft6o66p0iSBmP3yoC2k9L30s=;
        b=f3qrhg5kivwoN62pkQbcd4DuX9n8K9cZ9BP+ptY1tWJ7tZgQg2er1cSs3AjXP+UnYt
         6cRh3QvedL01Pw75eXfsUtFhueMSqxX6taL4E1ArDFBhODwSRhIgog7UVQhkPn3J8AQp
         zNN0wastumrL5Gq5bfrcqREF5fOFhezoDvKrdUlYlGK5bX42VKGqBdTBaP9jztvuKQfG
         a4AtS9szMHVcLXh7b+ClVSoLfANQKtf6voqXV4k1sQcynXBCA8WwIkaoaNWpZ7u6INe6
         jyuTWFAxheiqlEEnosdoDxMd7fCNGPTpg3qSeX9eLpy2xH9Zi4GsIPX1mqQ4MgHlIGLP
         pxrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gWNf4zISviT0O075eMDft6o66p0iSBmP3yoC2k9L30s=;
        b=76gYYefFPp1liKfPXZtUCcsmNU1XrZpBAKXG5Oo29zu/gjfmn97mjL7na5hpVmixSA
         WdybxzKpO6FC/8FJijeMVuCTZUj/cJHLW0zrOB5rU2Fmwnk4lhoD/wgSGyoz7ZVQhd5Y
         sCs3x/tZ91eCNAngocMZTkT0aOm8BrlKalQ7BRRFuPM9CkREzJ4UljM1r4xd0896gVAs
         zFmWFdMpbcPxAdZnZ03N8eJkUN8ymV4+EZhfrW7/0L8i7ECi1JwWasUcyzrE5J3BzvPF
         Ec34NFVp+FuebY+x5aqwm3ifiNC/flqILeeTZAtQ0Rj1Qy4zmWogCZgnQyxSwNlthbK7
         fCvA==
X-Gm-Message-State: AOAM531cVaKHyFY2thC1SuYpy+cfJstbItKsLaxdbjvHzSLTxcqc+S+4
        r72NkX0FkOrgdT8L07qKUpM=
X-Google-Smtp-Source: ABdhPJy1EcK1Ls78Ofn6WTxbw21kuLZhIFxSHu84kK9NBQ1319q3BRU7LTTnK4saL8kgvjS2sRwCpA==
X-Received: by 2002:a7b:cc94:0:b0:39c:4507:e806 with SMTP id p20-20020a7bcc94000000b0039c4507e806mr38807711wma.91.1655784780332;
        Mon, 20 Jun 2022 21:13:00 -0700 (PDT)
Received: from kista.localnet (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id bt28-20020a056000081c00b0020fcc655e4asm14349200wrb.5.2022.06.20.21.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 21:12:59 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Vinod Koul <vkoul@kernel.org>,
        Samuel Holland <samuel@sholland.org>
Cc:     dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: Re: [PATCH] dmaengine: sun6i: Set the maximum segment size
Date:   Tue, 21 Jun 2022 06:12:53 +0200
Message-ID: <1793109.atdPhlSkOF@kista>
In-Reply-To: <c0c27494-99ea-969d-ff6c-a21f110ed3e8@sholland.org>
References: <20220617034209.57337-1-samuel@sholland.org> <3494277.R56niFO833@kista> <c0c27494-99ea-969d-ff6c-a21f110ed3e8@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Dne torek, 21. junij 2022 ob 02:20:11 CEST je Samuel Holland napisal(a):
> Hi Jernej,
>=20
> On 6/20/22 1:28 PM, Jernej =C5=A0krabec wrote:
> > Dne petek, 17. junij 2022 ob 05:42:09 CEST je Samuel Holland napisal(a):
> >> The sun6i DMA engine supports segment sizes up to 2^25-1 bytes. This is
> >> explicitly stated in newer SoC documentation (H6, D1), and it is impli=
ed
> >> in older documentation by the 25-bit width of the "bytes left in the
> >> current segment" register field.
> >=20
> > At least A10 user manual says 128k max in description for Byte Counter=
=20
> > register (0x100+N*0x20+0xC), although field size is defined as 23:0, bu=
t=20
that's=20
> > still less than 2^25-1. A20 supports only 128k too according to manual.=
=20
New=20
> > quirk should be introduced for this.
>=20
> Thanks for checking this. A10 and A20 use a separate driver (sun4i-dma).=
=20
That
> driver will also benefit from setting the max segment size, so I will sen=
d a
> patch for it.
>=20
> I think all of the variants supported by sun6i-dma have the same segment=
=20
size
> capability, so no quirk is needed here.

Ah, yes. Then this patch is:
Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

>=20
> Regards,
> Samuel
>=20
> >>
> >> Exposing the real segment size limit (instead of the 64k default)
> >> reduces the number of SG list segments needed for a transaction.
> >>
> >> Signed-off-by: Samuel Holland <samuel@sholland.org>
> >> ---
> >> Tested on A64, verified that the maximum ALSA PCM period increased, and
> >> that audio playback still worked.
> >>
> >>  drivers/dma/sun6i-dma.c | 3 +++
> >>  1 file changed, 3 insertions(+)
> >>
> >> diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
> >> index b7557f437936..1425f87d97b7 100644
> >> --- a/drivers/dma/sun6i-dma.c
> >> +++ b/drivers/dma/sun6i-dma.c
> >> @@ -9,6 +9,7 @@
> >> =20
> >>  #include <linux/clk.h>
> >>  #include <linux/delay.h>
> >> +#include <linux/dma-mapping.h>
> >>  #include <linux/dmaengine.h>
> >>  #include <linux/dmapool.h>
> >>  #include <linux/interrupt.h>
> >> @@ -1334,6 +1335,8 @@ static int sun6i_dma_probe(struct platform_devic=
e=20
> > *pdev)
> >>  	INIT_LIST_HEAD(&sdc->pending);
> >>  	spin_lock_init(&sdc->lock);
> >> =20
> >> +	dma_set_max_seg_size(&pdev->dev, DMA_BIT_MASK(25));
> >> +
> >>  	dma_cap_set(DMA_PRIVATE, sdc->slave.cap_mask);
> >>  	dma_cap_set(DMA_MEMCPY, sdc->slave.cap_mask);
> >>  	dma_cap_set(DMA_SLAVE, sdc->slave.cap_mask);
> >> --=20
> >> 2.35.1
> >>
> >>
> >=20
> >=20
>=20
>=20


