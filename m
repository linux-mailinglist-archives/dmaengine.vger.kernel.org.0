Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD1F5577D4
	for <lists+dmaengine@lfdr.de>; Thu, 23 Jun 2022 12:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbiFWKZv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 23 Jun 2022 06:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbiFWKZq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 23 Jun 2022 06:25:46 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E5D4AE2D;
        Thu, 23 Jun 2022 03:25:08 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id g12so16665329ljk.11;
        Thu, 23 Jun 2022 03:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WqCHtUCnOvJqjoM2/65DgkYvOyKmc4p+aq7/u8FCyxA=;
        b=PIkKFT6MmcaUETNYYp/00cGxbMns4B3hZ5K5nmtGI6rNA0GIEW+mljG/Fne1m1MoDJ
         hEob9rUTJYEcXgm+2VfxUeSgEiCC4beWQTqOtIjvrmPzJY59yY0aQjFSYFq6uZ+yCsBY
         TkSAwqVecLhSbMBWc2qGK5asYINBDeVKWuZfIJIRPVXH2ooAOk+CilaQasEiFEnBPvo1
         9yU7sRGCq0pbvG7DXQEPHm1Bepg/+EXQeJ5lKtflHEWo024/pU+tCE0tyKXp96P7eK6/
         MtHCviPz6ujkgIRgMZdT9HQ/BMuTmBvX0T0E+5sbw8JvnmtJwX+DR8LPIVdwao4FUT9T
         fbMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WqCHtUCnOvJqjoM2/65DgkYvOyKmc4p+aq7/u8FCyxA=;
        b=xMc2bE3kLNvmQkza61DTzP2N2j66Wx7HQyAl24DvwbKAwP+AT5S1OLuEYDJCthaBoD
         0ttPg0vzKO3Ol/BGhCqj0gTEyUofmE6NcOxMmTWRd+pHCLy8BjZQ+7AqUth7TkBW2ijV
         T+/MU8L2dz5k2UpiLgUV6dYDeoTawr434MY9xOtJJnqukAGzqRCt2geigL1ipuzizPLp
         J97cLCGv60pkE1nHBiRV6CkeEAqxjAQBHtCLc7CsBOs3Cq7xMLlHzxPy8+2qwfgA4m0s
         mHeopZLMsfcgYIzkTDdFnnJpKE6QuZPeZaSh8YWJqTMX3DNXjp2g0BZc3oZwCwoKH8Hh
         Ww/w==
X-Gm-Message-State: AJIora+5rFk8kuFcqSWFmnhstsKuQGssJovI7tE1dPUk7x31aBknQLe4
        7IZbOEn3IMZS8zszmo4/ayw/IcaOH6lbylZx
X-Google-Smtp-Source: AGRyM1uzm9hmF9QK316rJoAfTTvEoAQhcLS5DK1sh8QXwvTquRMs7E5mQ7FvnFV0WtaDWVYa8qbSYg==
X-Received: by 2002:a2e:a883:0:b0:25a:8d91:27b4 with SMTP id m3-20020a2ea883000000b0025a8d9127b4mr2875724ljq.509.1655979906447;
        Thu, 23 Jun 2022 03:25:06 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id z1-20020a2e9641000000b00253deeaeb3dsm2727519ljh.131.2022.06.23.03.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 03:25:05 -0700 (PDT)
Date:   Thu, 23 Jun 2022 13:25:02 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Conor.Dooley@microchip.com
Cc:     damien.lemoal@opensource.wdc.com, mail@conchuod.ie,
        airlied@linux.ie, daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, thierry.reding@gmail.com,
        sam@ravnborg.org, Eugeniy.Paltsev@synopsys.com, vkoul@kernel.org,
        lgirdwood@gmail.com, broonie@kernel.org, daniel.lezcano@linaro.org,
        palmer@dabbelt.com, palmer@rivosinc.com, tglx@linutronix.de,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
        masahiroy@kernel.org, geert@linux-m68k.org, niklas.cassel@wdc.com,
        dillon.minfei@gmail.com, jee.heng.sia@intel.com,
        joabreu@synopsys.com, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-spi@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 06/14] spi: dt-bindings: dw-apb-ssi: update
 spi-{r,t}x-bus-width for dwc-ssi
Message-ID: <20220623102502.jiksqr3m6y733haq@mobilestation>
References: <20220618123035.563070-1-mail@conchuod.ie>
 <20220618123035.563070-7-mail@conchuod.ie>
 <20220620205654.g7fyipwytbww5757@mobilestation>
 <61b0fb86-078d-0262-b142-df2984ce0f97@microchip.com>
 <9a1fcb40-9267-d8e6-b3b6-3b03fd789822@opensource.wdc.com>
 <a2d85598-76d1-c9dc-d50d-e5aa815997cf@conchuod.ie>
 <c272728f-f610-77df-bd9b-c9fee6b727f8@opensource.wdc.com>
 <bd2547f8-e069-60a2-a223-9f694457636d@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd2547f8-e069-60a2-a223-9f694457636d@microchip.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Jun 21, 2022 at 04:06:21PM +0000, Conor.Dooley@microchip.com wrote:
> On 21/06/2022 00:17, Damien Le Moal wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > On 6/21/22 07:49, Conor Dooley wrote:
> >>
> ---8<---
> >>>>
> >>>> hmm, well I'll leave that up to people that have Canaan hardware!
> >>>
> >>> I will test this series.
> >>>
> >>
> >> Cool, thanks.
> >> I'll try to get a respin out tomorrow w/ the memory node "unfixed".
> > 
> > OK. I will test that then :)
> 
> Since the memory node hit that dt-schema snag, I have not sent a v2.
> Going to be AFK for a few days, so I dropped the memory node change,
> changed the spi binding & put the series on:
> git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/ canaan
> 

> If you get a chance to look at it great, if not I'll send a v2 once
> the memory node is figured out.

commit 84df6ca0f277 ("spi: dt-bindings: dw-apb-ssi: update
spi-{r,t}x-bus-width") looks good to me. Feel free to add my ack tag
to v2 of that patch.

-Sergey

> 
> Thanks,
> Conor.
> 
