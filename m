Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4114DA563
	for <lists+dmaengine@lfdr.de>; Tue, 15 Mar 2022 23:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352251AbiCOW3f (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 15 Mar 2022 18:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352244AbiCOW3f (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 15 Mar 2022 18:29:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DBCB1C92B;
        Tue, 15 Mar 2022 15:28:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCB82612B7;
        Tue, 15 Mar 2022 22:28:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FDBFC340E8;
        Tue, 15 Mar 2022 22:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647383301;
        bh=IoWtr+uaNbF74yc3AVtjTkb2gJE77265clN6rkXSnkI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=SuTfVErnY0tDWtg0x6YU6PmGOGI89MiQ4PQvzepNwhGuWF6Id+PwhL/1uCi5lpR8P
         dARQL+X/iThztMWo4jVwi+0x8IOy+wcPNo8v9tss2bzYoL1OJFHf5KXT/xRn45m81N
         NtHM07yAYwoRLYEpTr3ZsFNpNROZ1twUtiXbJbp50xvL71Jly26ALOPKBiQeYO+n8j
         t0onLke4nEEjxdqjT5eu6YapzZf2MUa2RZ1QZG/7mQezBkmvTPmC3GJJQIdqQA1di6
         WR/LIAhgHyVac8DMZHfRihD34UcJAH/oaNRh3aPZMtHG5+8YhZI+pwZRNGcAF1Lhtv
         NnSFFMBuAyHjA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220315191255.221473-6-miquel.raynal@bootlin.com>
References: <20220315191255.221473-1-miquel.raynal@bootlin.com> <20220315191255.221473-6-miquel.raynal@bootlin.com>
Subject: Re: [PATCH v5 5/8] dmaengine: dw: dmamux: Introduce RZN1 DMA router support
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
Date:   Tue, 15 Mar 2022 15:28:19 -0700
User-Agent: alot/0.10
Message-Id: <20220315222821.2FDBFC340E8@smtp.kernel.org>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Quoting Miquel Raynal (2022-03-15 12:12:52)
> The Renesas RZN1 DMA IP is based on a DW core, with eg. an additional
> dmamux register located in the system control area which can take up to
> 32 requests (16 per DMA controller). Each DMA channel can be wired to
> two different peripherals.
>=20
> We need two additional information from the 'dmas' property: the channel
> (bit in the dmamux register) that must be accessed and the value of the
> mux for this channel.
>=20
> Aside from the driver introduction, as these devices are described as
> subnodes of the system controller, we also need the system controller
> (clock) driver to populate its children manually. Starting from now on,
> one child can be the dmamux.
>=20
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
