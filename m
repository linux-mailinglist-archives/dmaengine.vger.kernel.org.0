Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB05E4FE0F3
	for <lists+dmaengine@lfdr.de>; Tue, 12 Apr 2022 14:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351574AbiDLMue (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 12 Apr 2022 08:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354991AbiDLMr6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 12 Apr 2022 08:47:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E256565;
        Tue, 12 Apr 2022 05:14:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7DED16169F;
        Tue, 12 Apr 2022 12:14:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BB61C385A6;
        Tue, 12 Apr 2022 12:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649765651;
        bh=Nz2SivOgqlG94fI51wSS3/fqaxpQqqMbgq6mFjBnfhc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qrh9ykgZpyWAFIO88oxLto2fn19HoGfiBaiZ4cOtod3cwS0HeWyAuYPltV2ykS/qv
         YWPIHwjlXZLQDQHc2bClxbX1qByGJL4QIdqwDIrxpuhepmaXv4N451rs6QxjrQ8VfS
         /ehFtlVC+zvJyMU/knr9RD/App7sp5y9yx8n+BXP/p5QPoelTg+seujwvJU6D0la5k
         Lhqe9FQOnIfXc7CLV4bDuhytXb99MQxH9A9HCozngcRPkq0lRUHYRtkzp12Xcam00w
         +0F4bqyigCrV0YQV2YriTIgLQcw8N3lMKZ4mpTTm8huKnea4Zc09jq1Ce+8dg7q6UK
         EaT3vUvBgXznw==
Date:   Tue, 12 Apr 2022 17:44:07 +0530
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
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH v9 3/9] dt-bindings: dmaengine: Introduce RZN1 DMA
 compatible
Message-ID: <YlVtD8hHMrG60bU8@matsya>
References: <20220412102138.45975-1-miquel.raynal@bootlin.com>
 <20220412102138.45975-4-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412102138.45975-4-miquel.raynal@bootlin.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 12-04-22, 12:21, Miquel Raynal wrote:
> Just like for the NAND controller that is also on this SoC, let's
> provide a SoC generic and a more specific couple of compatibles for the
> DMA controller.

Acked-By: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
