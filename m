Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E76F44F6F4E
	for <lists+dmaengine@lfdr.de>; Thu,  7 Apr 2022 02:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbiDGArQ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 6 Apr 2022 20:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiDGArO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 6 Apr 2022 20:47:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A021CD7C7;
        Wed,  6 Apr 2022 17:45:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8E4CFB82475;
        Thu,  7 Apr 2022 00:45:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A6D1C385A3;
        Thu,  7 Apr 2022 00:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649292311;
        bh=HTXn7kVKBe4UU307aYiMEL2SVHwhEFq0F/tZioWsuFQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=E4hZR+Vc1njlKy9GM/dEpt9PCuaDXMQgC3N+3MskIf0i501Hn62DQV9HxbAu0svyG
         Kfqv6SOsm1kaLdQ/idNLppb4syr2IzcCS95bdvf/2qHJRu/V8i3wNXR5rEHapYfhLC
         1Ys2Z0w5mgrvdYupIHPtupB9u7pYAz88dUP431cMcKcj/4bXvQkQr25lltVYSpyMQJ
         6gQbz2JO9sNbviytwhXtMcoCfcqx0KPOAaIzebjjvekUODjZSomu0SO14aY/bbfmsn
         pgwtnA0NaULJiIMpjKZ3Y5pxPaE/uWuLC44VG2T5l2W8zPA3/xltqgiGbupcBTTFbf
         VVl9BvBXYZzhA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220406161856.1669069-1-miquel.raynal@bootlin.com>
References: <20220406161856.1669069-1-miquel.raynal@bootlin.com>
Subject: Re: [PATCH v8 0/9] RZN1 DMA support
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-renesas-soc@vger.kernel.org, dmaengine@vger.kernel.org,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Clement Leger <clement.leger@bootlin.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
To:     Gareth Williams <gareth.williams.jx@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Vinod Koul <vkoul@kernel.org>
Date:   Wed, 06 Apr 2022 17:45:09 -0700
User-Agent: alot/0.10
Message-Id: <20220407004511.3A6D1C385A3@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Quoting Miquel Raynal (2022-04-06 09:18:47)
> Hello,
>=20
> Here is a first series bringing DMA support to RZN1 platforms. Soon a
> second series will come with changes made to the UART controller
> driver, in order to interact with the RZN1 DMA controller.
>=20
> Stephen acked the sysctrl patch (in the clk driver) but somehow I feel
> like it would be good to have this patch applied on both sides
> (dmaengine and clk) because more changes will depend on the addition of
> this helper, that are not related to DMA at all. I'll let you folks
> figure out what is best.

Are you sending more patches in the next 7 weeks or so that will touch
the same area? If so, then it sounds like I'll need to take the clk
patch through clk tree. I don't know what is best because I don't have
the information about what everyone plans to do in that file.
