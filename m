Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4751709553
	for <lists+dmaengine@lfdr.de>; Fri, 19 May 2023 12:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjESKrD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 19 May 2023 06:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjESKrC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 19 May 2023 06:47:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6959E4D;
        Fri, 19 May 2023 03:47:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E7EC61418;
        Fri, 19 May 2023 10:47:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3826BC433EF;
        Fri, 19 May 2023 10:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684493220;
        bh=3uAm/2bTZUrc8KqR08kwNxSgWihTy05EukpcaIfjFMM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bgjfBjIC7ezr3/mytPB/hcFVAFsWXWGimWWRHYOc8y9UJfRzSF0MIHlsCpUlS9aAv
         lHkla7MKJ/gszsZ6Kzs/0mtE7y5kTVWyyIvjJzlAgYUuUlFKG4OV8yFu1H1hR752ae
         mVIOkTzRah10tytpYhhiW64ObtiNCTSPk6+v78VFO59bc0RBUIBqozAykMBDyF3IN8
         1p23WzsyCZvwltt6n6OzxPt0h3V7Zo5VcMr+nLHxRbuKepeKXULgFWKDukq146yJNQ
         LxK0OVNRyrbcKtC4BVIJcjnxfIi1kLIgS4vgygdwclAeVYlaC6dimjX/330it1cdOh
         NVk2qtlGGxNjw==
Date:   Fri, 19 May 2023 16:16:56 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: ste_dma40: use proper format string for
 resource_size_t
Message-ID: <ZGdToIv95DkTrObb@matsya>
References: <20230517201951.619693-1-arnd@kernel.org>
 <ZGYMJWoOYL0ddPBg@matsya>
 <2b7eef56-9409-46bd-bcf7-dea054adfccd@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b7eef56-9409-46bd-bcf7-dea054adfccd@app.fastmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 18-05-23, 13:59, Arnd Bergmann wrote:
> On Thu, May 18, 2023, at 13:29, Vinod Koul wrote:
> > On 17-05-23, 22:19, Arnd Bergmann wrote:
> >> From: Arnd Bergmann <arnd@arndb.de>
> >> 
> >> When LPAE is set, both the dma_addr_t and resource_size_t become 64 bit
> >> wide, causing a warning about the format string:
> >> 
> >> drivers/dma/ste_dma40.c: In function 'd40_probe':
> >> drivers/dma/ste_dma40.c:3539:23: error: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'resource_size_t' {aka 'long long unsigned int'} [-Werror=format=]
> >>  3539 |         dev_info(dev, "found LCPA SRAM at 0x%08x, size 0x%08x\n",
> >> 
> >> Change both to the special %pap and %pap helpers for these types.
> >
> > Already posted [1] and applied now
> >
> > [1]: https://lore.kernel.org/r/20230517064434.141091-1-vkoul@kernel.org
> 
> I think yours is wrong: you use %pR with a resource_size_t, but it
> expects a "struct resource instead".

Right, i indeed looked up wrong format

-- 
~Vinod
