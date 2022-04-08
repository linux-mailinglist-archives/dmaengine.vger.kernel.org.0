Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A26274F9C04
	for <lists+dmaengine@lfdr.de>; Fri,  8 Apr 2022 19:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbiDHRyk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 8 Apr 2022 13:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiDHRyj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 8 Apr 2022 13:54:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3F9E6F;
        Fri,  8 Apr 2022 10:52:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0FC8621CA;
        Fri,  8 Apr 2022 17:52:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DC5DC385A1;
        Fri,  8 Apr 2022 17:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649440354;
        bh=B57/5xtwGjtQQwX7LcGe4TUx9pFhis7TbAC9KQ0jxsU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UrMHsxIK7qPI8bzuz7H3meT/pExAoM9aRFtS3aCgbwddoDfCsHVAFas0BA5tl6Kc3
         OG7WPPA/8wmm3mfY1Y8BEvhCsE1Y9PytGPM/y0N5oZQMn8ri2IE0MoLMPMMnjx7//P
         YzLGe/UR8okxrztBaV3Xsd2NEx0N8KmugNnWyFD70jIWsre9PgHw6O0fGZyC52wJPp
         t0ywYY6P2jyFnu7SLywjlppjT81VUeIfQzeaalIRsXxAb6082T4qfhcvc1kgHSsxd6
         MJR/y/NYxETbVcT0n8RyQ8LzcMxlVg9k5D8/zutOF/WEc1aeDkh3EF6GqKJnG3iqf2
         1IeyyJ7LASLng==
Date:   Fri, 8 Apr 2022 23:22:29 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH] dmaengine: sh: Kconfig: Make RZ_DMAC depend on ARCH_RZG2L
Message-ID: <YlB2XVYCHtZ/NnLe@matsya>
References: <20220406080417.14593-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406080417.14593-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 06-04-22, 09:04, Lad Prabhakar wrote:
> The DMAC block is identical on Renesas RZ/G2L, RZ/G2UL and RZ/V2L SoC's, so
> instead of adding dependency for each SoC's add dependency on ARCH_RZG2L.
> The ARCH_RZG2L config option is already selected by ARCH_R9A07G043,
> ARCH_R9A07G044 and ARCH_R9A07G054.

Applied, thanks

-- 
~Vinod
