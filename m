Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF954B624B
	for <lists+dmaengine@lfdr.de>; Tue, 15 Feb 2022 06:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbiBOFCL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 15 Feb 2022 00:02:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiBOFCK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 15 Feb 2022 00:02:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C493DD45F;
        Mon, 14 Feb 2022 21:01:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 86FC0B80764;
        Tue, 15 Feb 2022 05:01:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 302F1C340EC;
        Tue, 15 Feb 2022 05:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644901317;
        bh=RGMHP+n6KziqZbnQnvGiDqtYBf0hXdilu2Ww+PnFi+I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ujiPgO1z/x01C9l3qOr6oO/Uz3mRvOloFoDDA1V9XiLJ/AJGN1Y22fxjiHbxSKhzm
         dDdfKf2OryJdZm7XaVExcTHJ/i6EzzrTmy+MRYVdL2tbwR8t22rM7M63oPLzDtm1cX
         5xTafWdVtZyhWcEe+8uJ334TNHIr9etusVTqsw2gkCbPd8cXGTKkeO7s9b/BTRWJps
         FQ0JgUBYd8H2MnYijitUXhrFCUhUykiCQksXbEKdQHqnN2H3Z84c9VrrwoLZHV0utw
         wDR5VOTUQ8uJ5nnXoSk5dJPu7eMKVfHBrbIwVQ8VurzS2i7Cn4Sx0R+gq1GEyEjRvQ
         H5XAZSLQ3c8fQ==
Date:   Tue, 15 Feb 2022 10:31:53 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Rob Herring <robh+dt@kernel.org>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: dma: rz-dmac: Document RZ/G2UL SoC
Message-ID: <Ygszwf1BwMXnaf9T@matsya>
References: <20220206200308.14315-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220206200308.14315-1-biju.das.jz@bp.renesas.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 06-02-22, 20:03, Biju Das wrote:
> Document RZ/G2UL DMAC bindings. RZ/G2UL DMAC is identical to one found
> on the RZ/G2L SoC. No driver changes are required as generic compatible
> string "renesas,rz-dmac" will be used as a fallback.

Applied, thanks

-- 
~Vinod
