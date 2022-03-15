Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6E8B4DA55D
	for <lists+dmaengine@lfdr.de>; Tue, 15 Mar 2022 23:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347705AbiCOW3A (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 15 Mar 2022 18:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235864AbiCOW27 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 15 Mar 2022 18:28:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08E531205;
        Tue, 15 Mar 2022 15:27:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A2FD4B81906;
        Tue, 15 Mar 2022 22:27:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4812FC340E8;
        Tue, 15 Mar 2022 22:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647383263;
        bh=CCHXKaV6VaJlX68acVE6TzhowGRMZ8DAhLZPZnnE5e4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=bkT8faJ5s4C5maxW+tUl6Ueb0mktcbXMHd6gGeC7E3zp5jnSQd4A8oct/aFChoCUQ
         cHQzj+IM3p1TSMFUEYEWenKbAQwSXu0FqpSWHCZoszFDD7bBDhQuqTOlVci1I7DKaB
         Xzp4PSIRM68RfB8OVgnFMJJj+ysIfZXOhuqCTkk+Vcyt3XTjnfumrGtWf6EDhEDdDC
         sL89jtxc7RCiBm9ISZsN4saKSKPct5Uh9XxEJU69HKNG+2UHyrGa8u7Q6AnfO6yi3M
         gDKaEaxStTZXYnbK+CXCWKFuuB98Bg/Kd3OdtMcWjZyvicIp4i7lLLD+L5hgMw8HKd
         3TDQGWvLlthvQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220315191255.221473-3-miquel.raynal@bootlin.com>
References: <20220315191255.221473-1-miquel.raynal@bootlin.com> <20220315191255.221473-3-miquel.raynal@bootlin.com>
Subject: Re: [PATCH v5 2/8] dt-bindings: clock: r9a06g032-sysctrl: Reference the DMAMUX subnode
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh@kernel.org>
To:     Gareth Williams <gareth.williams.jx@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Date:   Tue, 15 Mar 2022 15:27:41 -0700
User-Agent: alot/0.10
Message-Id: <20220315222743.4812FC340E8@smtp.kernel.org>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Quoting Miquel Raynal (2022-03-15 12:12:49)
> This system controller contains several registers that have nothing to
> do with the clock handling, like the DMA mux register. Describe this
> part of the system controller as a subnode.
>=20
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
