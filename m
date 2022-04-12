Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC264FE478
	for <lists+dmaengine@lfdr.de>; Tue, 12 Apr 2022 17:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241570AbiDLPTd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 12 Apr 2022 11:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbiDLPTc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 12 Apr 2022 11:19:32 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8C55E74D;
        Tue, 12 Apr 2022 08:17:13 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 37A3024000E;
        Tue, 12 Apr 2022 15:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1649776632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fRPbzKghNrLcWzL0upbuuhSfisRbrbkUbmUfYgSIypo=;
        b=i/yWvK0e0N+bBW0QN02/AQQB/xfMLKHE8CbISse+qvoLnonxgWT0JMrzN3O4GI3VJ6mLIq
        FA+Pcn5MwzHCreLJfhZbqixMBB9+TgyyRchO2565KfIqFQVOqwVCQMRsrzamqbupZrK3N4
        pmJvepfXODmaQFRhd1t5vj9u6SRUNa6eq+mvv77sBH4tJSHWoIy/YMhs0w8F+3Fie36RRx
        wfH6qX/1D9DlgevB7iNRkM5TPZ+1E9bdyxSL0Wv1plLMZ/e01nwF1uX5oG2zrUdpAaefHn
        RJrMcO8VvuxGQHdQm7zwTXS6HB8w0jkaROpdjJa/lR4I4dOYmNayPokSYfeMxg==
Date:   Tue, 12 Apr 2022 17:17:05 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Vinod Koul <vkoul@kernel.org>,
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
        Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v9 5/9] dmaengine: dw: dmamux: Introduce RZN1 DMA router
 support
Message-ID: <20220412171705.0dd51846@xps13>
In-Reply-To: <YlVdsTVpWrx+XaUH@smile.fi.intel.com>
References: <20220412102138.45975-1-miquel.raynal@bootlin.com>
        <20220412102138.45975-6-miquel.raynal@bootlin.com>
        <YlVdNpuYdgzo7Vgi@smile.fi.intel.com>
        <YlVdsTVpWrx+XaUH@smile.fi.intel.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Andy,

andriy.shevchenko@linux.intel.com wrote on Tue, 12 Apr 2022 14:08:33
+0300:

> On Tue, Apr 12, 2022 at 02:06:31PM +0300, Andy Shevchenko wrote:
> > On Tue, Apr 12, 2022 at 12:21:34PM +0200, Miquel Raynal wrote:  
> 
> ...
> 
> > > +	clear_bit(BIT(map->req_idx), dmamux->used_chans);  
> 
> On top of the previously asked, are you sure the use of BIT() is correct here?

Looks like I have been tricked by the doc...

	* DOC: bitmap bitops
	*  set_bit(bit, addr)                  *addr |= bit
	*  clear_bit(bit, addr)                *addr &= ~bit
