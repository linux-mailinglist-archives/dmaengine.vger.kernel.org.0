Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E6F52DAD0
	for <lists+dmaengine@lfdr.de>; Thu, 19 May 2022 19:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242339AbiESRFQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 19 May 2022 13:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233921AbiESRFK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 19 May 2022 13:05:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643F262A20;
        Thu, 19 May 2022 10:05:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0169D60FEF;
        Thu, 19 May 2022 17:05:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A327CC34100;
        Thu, 19 May 2022 17:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652979908;
        bh=j9qmBV0eEQKTQ7zizSQEVzqT008ay3RQiyJibiJAyck=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DDWWrNPw+qBVrcDqcKVcXJC3HNf3pClu9iT6Cnyvi7ak07eyJ+zc4O5J2Ko6da8ZZ
         AxSRaoIPwIvqef1jss2aVYwMGA3t0lWuYlnjcxbDaRTMtNM+onqE/0ylma3KlVuR35
         cxcrFi9387h7e2sq278ZSCsmagysRlkbKXhlaNcHDnr+azXetIOdwbnysx0yAqj686
         kW/7pNwhyCjj8NKxiAjp5xVauxRZGDEurOGIEEHFOQx4KbmAWtnaNKwQy69BCPmMea
         toPTqTLp5uha+BKOmQt2dS1Gf8IX4c9yzagTN3pmFZTBw1PRz1Idrzl65hkulRRqRr
         b+DMYzoUwOYPw==
Date:   Thu, 19 May 2022 22:35:04 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-renesas-soc@vger.kernel.org, dmaengine@vger.kernel.org,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v12 0/9] RZN1 DMA support
Message-ID: <YoZ4wNCxdJ6REp13@matsya>
References: <20220427095653.91804-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427095653.91804-1-miquel.raynal@bootlin.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 27-04-22, 11:56, Miquel Raynal wrote:
> Hello,
> 
> This is the series bringing DMA support to RZN1 platforms.
> The UART changes regarding DMA support has been merged into tty-next
> already.
> 
> There is no other conflicting dependency with the other series, so these
> patches (all but DTS) can go though the dmaengine tree I believe.

Applied 1-7, thanks

-- 
~Vinod
