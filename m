Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAF14D5F63
	for <lists+dmaengine@lfdr.de>; Fri, 11 Mar 2022 11:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238846AbiCKKYq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 11 Mar 2022 05:24:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347946AbiCKKYp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 11 Mar 2022 05:24:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE216D1B2;
        Fri, 11 Mar 2022 02:23:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 77C04617C9;
        Fri, 11 Mar 2022 10:23:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00BFAC340E9;
        Fri, 11 Mar 2022 10:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646994221;
        bh=MQBcv8LT2Jk6uJnFFZyBXCLNVGhpoXjUK0NRa0YuX4k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z9XHa74W+TzgLgZqAEsu/oRDpF+MqmkiAHF70KZEB+IS5C3x7F/H3yctqi6BnCNVx
         L9eLUGDO1FAXbF/KqDXEnNngAh2ENr9YVKJf/0WjJsHt3dlmprceVqsJSyE4mOrpOA
         wfIbwvtK3EyP8gbTTRyIW42Hp06aNXAPZW80V+yiGSlvG/he3xkgVfZZU1BQYPwOGf
         w6fTat542Q8Q7DfEtYxwOB0TK2YOsURxkzFvs+4PFJlwoLU8gAynWYe+E15cIcLx+3
         dFnkdr6ECE/nJg0jSEPp0xSfF+I50fC8EPaPZPUHE9NiMNNUv8y4IFxYaI+bKVrHmJ
         LnA/onzi8FP7w==
Date:   Fri, 11 Mar 2022 15:53:37 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-renesas-soc@vger.kernel.org,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>,
        dmaengine@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>
Subject: Re: [PATCH v4 5/9] dma: dw: dmamux: Introduce RZN1 DMA router support
Message-ID: <YisjKdZWoXJF292S@matsya>
References: <20220310155755.287294-1-miquel.raynal@bootlin.com>
 <20220310155755.287294-6-miquel.raynal@bootlin.com>
 <Yio47YVZuHaFvwE8@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yio47YVZuHaFvwE8@smile.fi.intel.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 10-03-22, 19:44, Andy Shevchenko wrote:
> On Thu, Mar 10, 2022 at 04:57:51PM +0100, Miquel Raynal wrote:
> > The Renesas RZN1 DMA IP is based on a DW core, with eg. an additional
> > dmamux register located in the system control area which can take up to
> > 32 requests (16 per DMA controller). Each DMA channel can be wired to
> > two different peripherals.
> > 
> > We need two additional information from the 'dmas' property: the channel
> > (bit in the dmamux register) that must be accessed and the value of the
> > mux for this channel.
> > 
> > Aside from the driver introduction, as these devices are described as
> > subnodes of the system controller, we also need the system controller
> > (clock) driver to populate its children manually. Starting from now on,
> > one child can be the dmamux.
> 
> In all DMA engine related patches the prefix should be "dmaengine:".

Yep!

-- 
~Vinod
