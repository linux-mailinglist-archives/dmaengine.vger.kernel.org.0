Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7BC64B6246
	for <lists+dmaengine@lfdr.de>; Tue, 15 Feb 2022 06:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbiBOFBs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 15 Feb 2022 00:01:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiBOFBs (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 15 Feb 2022 00:01:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2A8CEA1F;
        Mon, 14 Feb 2022 21:01:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 65EF96133A;
        Tue, 15 Feb 2022 05:01:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E459AC340EC;
        Tue, 15 Feb 2022 05:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644901296;
        bh=3q8Li7JDFVru23AgrJO52F+Glyipz0NufWYmBtCa9XI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VL56RVbajOHmhCAh7YCJ9Z6/uGvKNGUOzwwD99/Q+00wRRCaZmcCwMxtQVoYdjUed
         871sBKeriRgVWD5C/VkNbtVhkDB6xSu21/sH3HvNrfWqSYsDpgyx9cz1B7Dn453gpb
         qh8BCOWBeequmilF/ZxbvUfA97uuC2jNK3Mv1p4VBhhVukAlbXvSCQt+SSqZf22BiP
         0W4tRbkBowEhuDKXl1Kb7ef4fxUx4p6OHv5QSfXdBKTD3WWNPw7VJfS3Gt38tW0USw
         q+gxZGlbj6cZqPhtgjk3S1tfX9B+Ss2QjdNygIgmFTnitGOw1WhDaxZG1cYLmiMJGP
         uOqKIyOmc1Rxw==
Date:   Tue, 15 Feb 2022 10:31:32 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 08/12] dt-bindings: dma: rz-dmac: Document RZ/V2L SoC
Message-ID: <YgszrHG6p2RMkvq+@matsya>
References: <20220110134659.30424-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220110134659.30424-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110134659.30424-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 10-01-22, 13:46, Lad Prabhakar wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
> 
> Document RZ/V2L DMAC bindings. RZ/V2L DMAC is identical to one found on
> the RZ/G2L SoC. No driver changes are required as generic compatible
> string "renesas,rz-dmac" will be used as a fallback.

Applied, thanks

-- 
~Vinod
