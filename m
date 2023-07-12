Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFAA750615
	for <lists+dmaengine@lfdr.de>; Wed, 12 Jul 2023 13:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbjGLLaj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 12 Jul 2023 07:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjGLLaj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 12 Jul 2023 07:30:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CDA8F;
        Wed, 12 Jul 2023 04:30:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05B9E61711;
        Wed, 12 Jul 2023 11:30:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCA6AC433C7;
        Wed, 12 Jul 2023 11:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689161437;
        bh=NDBF8dBjRANnGKRrDvxMqE+Lw2noCTWhhXn22ig51mw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nitfw/gukMrGiwHAYDuudY/3e4DHA8NJmkYTP8Q7dop1CW1NxeeznW324UIqfv43f
         dYVaPb/7BdTXYEVN0uvmzSxqgtzIFZ3Zu+a3eSjnZqXAO0DcIgi5H/vWtklOlmIQMo
         wgaXO4V+MPqMaCAaSiV2h+R+XiaHteqGlieK2TANbz7KQKrPpbb+hCOCATC79pN1WL
         cRgV60JsxR615B5ZQt1lfab8XmsuCrRycs5C+xq+6CyYm29wOt0cUbVXUslfq40Ouc
         YzmsIgCOPsTt6DDRgfk1m8VCrgG8T1gmVMZlmWRTP6aj6QZgI3rvJNTExb0rmI9v2J
         vVzxB5LPGdeuQ==
Date:   Wed, 12 Jul 2023 17:00:33 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Yangtao Li <frank.li@vivo.com>, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH 1/5] dmaengine: qcom: gpi: Use
 devm_platform_get_and_ioremap_resource()
Message-ID: <ZK6O2b88Nz6J2JeN@matsya>
References: <20230705081856.13734-1-frank.li@vivo.com>
 <168909383153.208679.15343948792914219046.b4-ty@kernel.org>
 <c3373ebe-2f52-bed7-7f59-98e1268c9af2@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3373ebe-2f52-bed7-7f59-98e1268c9af2@linux-m68k.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 12-07-23, 11:33, Geert Uytterhoeven wrote:
> 	Hi Vinod,
> 
> On Tue, 11 Jul 2023, Vinod Koul wrote:
> > On Wed, 05 Jul 2023 16:18:52 +0800, Yangtao Li wrote:
> > > Convert platform_get_resource(), devm_ioremap_resource() to a single
> > > call to devm_platform_get_and_ioremap_resource(), as this is exactly
> > > what this function does.
> > > 
> > > 
> > 
> > Applied, thanks!
> > 
> > [1/5] dmaengine: qcom: gpi: Use devm_platform_get_and_ioremap_resource()
> >      commit: d9313d9f1fbc14cae5147c5130bea54aa76ad65f
> > [2/5] dmaengine: qcom_hidma: Use devm_platform_get_and_ioremap_resource()
> >      commit: a189107deb574fd08018bbf2fe5cd86450a54b13
> > [3/5] dmaengine: qcom: hidma_mgmt: Use devm_platform_get_and_ioremap_resource()
> >      commit: fe6c2622473f3756a09bd6c42cffca6fbdce391c
> > [4/5] dmaengine: shdmac: Convert to devm_platform_ioremap_resource()
> >      commit: 0976421c5a339b1b1a89cfba4471a6de761130ed
> > [5/5] dmaengine: stm32-dma: Use devm_platform_get_and_ioremap_resource()
> >      commit: b402a7eeaa35aaa3300a4ba6bd5b381112ae183c
> 
> I noticed all your new dmaengine[1] and phy[2] commits contain a
> "Message-ID:" tag.  Presumable you added a git hook for that?

Thanks for pointing that out, yes something is messed up for me.
> 
> However, the standard way is to add a Link: tag pointing to lore
> instead, cfr. [3].

Yep and if you look at the dmaengine and phy commits for 6.4 they have
"Link" in them, so something is not working, let me fix that up.

-- 
~Vinod
