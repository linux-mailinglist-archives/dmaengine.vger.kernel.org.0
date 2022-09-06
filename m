Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7AF75ADED8
	for <lists+dmaengine@lfdr.de>; Tue,  6 Sep 2022 07:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiIFFRB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 6 Sep 2022 01:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiIFFRA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 6 Sep 2022 01:17:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDAC552FEB;
        Mon,  5 Sep 2022 22:16:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8AD56B81603;
        Tue,  6 Sep 2022 05:16:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72224C433C1;
        Tue,  6 Sep 2022 05:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662441417;
        bh=l0NTIxUVTvFpMVry7S0u606nwl4N6IwM+N9Zep810bc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LsI+b4tAGw7WJb1Q9FCVSCcTrjk0kR9a48wpCtOsG4L09yBRen+3f6wmGAv+409P7
         OJ/Y+zOrz8RKR1VOP6XQR1dPRgLwx8nw8nrbwweuu4cGv5g2j3LvpR+KZYTlNM8y90
         fT0ltMF3XdmYKKn5x3+J1IxVxb3iCX0rYGoGbasSmjo6gmUat6EFvuxfavoCuhfiOl
         UXItJJgheGZ1rwyFKFeYw/rVIMCs1/kTGir5h8M1Ayi3EajsplGHAu/c/81nRhtA9/
         ZKHrAzJMHn0pHL83oFNknvOgWWySzyG9ZtsQElpkasaObrhY89XxdqzWUZFz0uGfCn
         Fyp/A6txpw9wg==
Date:   Tue, 6 Sep 2022 10:46:52 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Joy Zou <joy.zou@nxp.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "S.J. Wang" <shengjiu.wang@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXT] Re: [PATCH V4 2/4] dmaengine: imx-sdma: support hdmi audio
Message-ID: <YxbXxKyVkA4fwY0Z@matsya>
References: <20220901020059.50099-1-joy.zou@nxp.com>
 <YxTPTnrJst9aNpsl@matsya>
 <AM6PR04MB59253DD6C91D41344C08C175E17F9@AM6PR04MB5925.eurprd04.prod.outlook.com>
 <0d523880-9214-7b9b-ce1a-d06d4d5fbdf1@linaro.org>
 <AM6PR04MB59250C67D565B6E5E52621ACE17F9@AM6PR04MB5925.eurprd04.prod.outlook.com>
 <YxXXex775kSSmGin@matsya>
 <AM6PR04MB59255C66A2DEA7B0A8B3C22EE17E9@AM6PR04MB5925.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM6PR04MB59255C66A2DEA7B0A8B3C22EE17E9@AM6PR04MB5925.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 06-09-22, 05:04, Joy Zou wrote:
> 
> > -----Original Message-----
> > From: Vinod Koul <vkoul@kernel.org>
> > Sent: 2022年9月5日 19:03
> > To: Joy Zou <joy.zou@nxp.com>
> > Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>; S.J. Wang
> > <shengjiu.wang@nxp.com>; shawnguo@kernel.org; s.hauer@pengutronix.de;
> > kernel@pengutronix.de; festevam@gmail.com; dl-linux-imx
> > <linux-imx@nxp.com>; dmaengine@vger.kernel.org;
> > linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> > Subject: Re: [EXT] Re: [PATCH V4 2/4] dmaengine: imx-sdma: support hdmi
> > audio
> > 
> > Caution: EXT Email
> > 
> > On 05-09-22, 09:07, Joy Zou wrote:
> > > > From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > > > >> On 01-09-22, 10:00, Joy Zou wrote:
> > > > >>> Add hdmi audio support in sdma.
> > > > >>
> > > > >> Pls make sure you thread your patches properly! They are broken
> > threads!
> > > > > I am trying to support for hdmi audio feature on community driver
> > > > drivers/gpu/drm/bridge/synopsys/.
> > > >
> > > > This does not answer to the problem you patches do not compose
> > > > proper thread. v5 which you sent now is also broken. Supporting HDMI
> > > > audio feature does not prevent you to send patches correctly, right?
> > > I am trying to support for hdmi audio feature on community driver
> > drivers/gpu/drm/bridge/synopsys/.
> > > I think the feature may take some time because I am not audio driver owner.
> > I only want to update the others patch as soon as possible, so I send the patch
> > v5. I am also solving the thread patches properly.
> > 
> > Sorry you have not!
> > 
> > In my inbox, v5 1/2 and 2/2 do not appear as a single thread
> > 
> > Please fix the way you send the series and send them together, it is very
> > difficult to review when they are disjoint
> > 
> > FWIW, I checked the v5 2/2 and it does not have in-reply-to set, which should
> > point to 1/2.. If you are using git send-email, point both the patches to it so
> > that it will do that correctly for you
> I am very sorry. I find the root cause that the patch not appear as a single thread. I use the
> git send-mail to send separately. I also know the patchwork can check it.

No, please point the whole series to git send-email

For example:
$ mkdir temp; cd temp
$ git format-patch -2 --cover-letter -v <patch version>
$ <update cover letter>
$ <run checkpatch etc and verify patches are in order>
$ git send-email *

That should do it for you!

> I'm so sorry to waste your time and effort. I am very grateful to your comments.
> I will change next patch.
> BR
> Joy Zou
> 
> > 
> > --
> > ~Vinod

-- 
~Vinod
