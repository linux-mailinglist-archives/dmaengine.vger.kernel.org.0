Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF7F4DA561
	for <lists+dmaengine@lfdr.de>; Tue, 15 Mar 2022 23:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352239AbiCOW3W (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 15 Mar 2022 18:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235864AbiCOW3V (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 15 Mar 2022 18:29:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DEE12AA8;
        Tue, 15 Mar 2022 15:28:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E239612F0;
        Tue, 15 Mar 2022 22:28:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63AA1C340E8;
        Tue, 15 Mar 2022 22:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647383287;
        bh=LNICzXKBQcZ1c5rCo9xWDDs100Y10tPK+LsTLxxLYo8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=uM1aBwMMG1oZL9pMTdQFnpXKtBiLePTBpOrtN+FLIg3GBL953B8vmfKb7SKCMrTRw
         23aHki2JsyLR7Pw5JhFZdWieE9E5uWRUFVpjtwwrFHLV8dT0mcOrcjPSeCwb9A04W6
         taIZKhwWgp2e1ZUWBvL/AuQ3CKztIAfeUo6P4wcHAAuJp8p3xfWzuvIJOIJozZt0fj
         cXZbTCYP2+igYhacK3I+4NLHI10zH5FgLIKynONyD9LR9EHY8DHHA9HPh/5m8avXB1
         0e6/UGhaNOpILf6hLmClDOPjmd3OZCrMMu5XYGrs3ZHurruc9asKLrBZf7JP7cVVGk
         lo1tPF6pzocxQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220315191255.221473-5-miquel.raynal@bootlin.com>
References: <20220315191255.221473-1-miquel.raynal@bootlin.com> <20220315191255.221473-5-miquel.raynal@bootlin.com>
Subject: Re: [PATCH v5 4/8] soc: renesas: rzn1-sysc: Export function to set dmamux
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
To:     Gareth Williams <gareth.williams.jx@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Date:   Tue, 15 Mar 2022 15:28:05 -0700
User-Agent: alot/0.10
Message-Id: <20220315222807.63AA1C340E8@smtp.kernel.org>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Quoting Miquel Raynal (2022-03-15 12:12:51)
> The dmamux register is located within the system controller.
>=20
> Without syscon, we need an extra helper in order to give write access to
> this register to a dmamux driver.
>=20
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
