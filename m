Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1657F4F3298
	for <lists+dmaengine@lfdr.de>; Tue,  5 Apr 2022 14:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347280AbiDEKKK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 5 Apr 2022 06:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236072AbiDEJbC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 5 Apr 2022 05:31:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85BA9B;
        Tue,  5 Apr 2022 02:18:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 74380B81C6C;
        Tue,  5 Apr 2022 09:18:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C493C385A0;
        Tue,  5 Apr 2022 09:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649150307;
        bh=KqfmPx/FGZuQc1QjAMWhBBJLn80U3WK0f+K5lsmzmv8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ooEXi9RjMzMSxfLeOZEDjlTKA2kg1ILji4AeosSD72b5yu7U90rI1zHsW27BxBtKH
         7S8+M5MPtdndh01Bnz7seefyYKzBuRNKUTnluAM9otDxptJ3nIg7ouNT41fRPe38C3
         24rladwUbzaGGuxtmr75bnWKos85SB+LTOgZSkOtz9mcz+J6qJ9eARSqo/6k8s0bRx
         c1Q19JrIqmUCO9hws+/YyGFdZI7ww06cB4Pc4Dvxq7kHGtVz3M+TU0+LuP5F+EHiHe
         76X5+yA1xiB9Ldt/IEEN9vWR5GlwqqXxR2+tM12JtD1a90BmYUEmis6S9g10FOiLmT
         Nq1mgmt1lNq+Q==
Date:   Tue, 5 Apr 2022 14:48:22 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-renesas-soc@vger.kernel.org,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        dmaengine@vger.kernel.org,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>,
        Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH v6 5/8] dmaengine: dw: dmamux: Introduce RZN1 DMA router
 support
Message-ID: <YkwJXq+8tAPJ9saP@matsya>
References: <20220404133904.1296258-1-miquel.raynal@bootlin.com>
 <20220404133904.1296258-6-miquel.raynal@bootlin.com>
 <YkvaOKmamLF+Mp7m@matsya>
 <YkvqsO0aecSjGqx2@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkvqsO0aecSjGqx2@smile.fi.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 05-04-22, 10:07, Andy Shevchenko wrote:
> On Tue, Apr 05, 2022 at 11:27:12AM +0530, Vinod Koul wrote:
> > On 04-04-22, 15:39, Miquel Raynal wrote:
> 
> ...
> 
> > > +MODULE_LICENSE("GPL");
> > 
> > This is not consistent with the SPDX tag..
> 
> Actually it is. "GPLv2" is obsolete form, in new code we are supposed using
> "GPL" as per Documentation.

Yes this has been updated, thanks for pointing out.

-- 
~Vinod
