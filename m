Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8CC5EEF28
	for <lists+dmaengine@lfdr.de>; Thu, 29 Sep 2022 09:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234933AbiI2HgX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 29 Sep 2022 03:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235156AbiI2HgW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 29 Sep 2022 03:36:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED655E11FB;
        Thu, 29 Sep 2022 00:36:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A3B862061;
        Thu, 29 Sep 2022 07:36:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64137C433C1;
        Thu, 29 Sep 2022 07:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664436981;
        bh=gadGtTCeRLJv1JEE9hnf/EqUmfyZC0F8hypNxMqO454=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fbQxrGZsRJRXH8B52mGdn2+H72g9thOpi/5QqR6sW0Qfkk7dX2LeSUwokOgccIgQM
         YrRYD21upOjaXVinJkUyhybq8ysnAtu/R0EWn+Qp8iqznE8tpQQLYEbzlGBnN6owUv
         8wFv6k/G7YsvKLKfusCAScmgbC70Hd66v4+3sZhwJvzwNscYbBsoc7dkqkcWmnMTfw
         QxaZIp919KAi962Lo9xZ8YkwgzD6ElCcIm6DqXEc9yjGMKkTHZm9HzTXXFaGzvOaKz
         +OctZ4Da+VbBJAEs3CPZO9zt/aRz66JAFNhGe2QntJ4H2a6EOVY9sfRbFxW4Q3S2Rr
         YcZgv1+0af9XQ==
Date:   Thu, 29 Sep 2022 13:06:15 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: renesas,rcar-dmac: Add r8a779g0 support
Message-ID: <YzVK7y2mn7fGNv67@matsya>
References: <0a4d40092a51345003742725aea512a815d27e89.1664204526.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a4d40092a51345003742725aea512a815d27e89.1664204526.git.geert+renesas@glider.be>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 26-09-22, 17:03, Geert Uytterhoeven wrote:
> Document support for the Direct Memory Access Controllers (DMAC) in the
> Renesas R-Car V4H (R8A779G0) SoC.

Applied, thanks

-- 
~Vinod
