Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8AE5EF96C
	for <lists+dmaengine@lfdr.de>; Thu, 29 Sep 2022 17:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235920AbiI2Prm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 29 Sep 2022 11:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235507AbiI2PrN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 29 Sep 2022 11:47:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52E718D0FD;
        Thu, 29 Sep 2022 08:46:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 45D6E618D7;
        Thu, 29 Sep 2022 15:46:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21757C433D6;
        Thu, 29 Sep 2022 15:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664466389;
        bh=sgavWwzoOPfZH82PYJjX5OBcYe1QPBbkLIH6iiMjU0o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mUbpAynlf6eW+U+IhnVkaxx9t/x2hJjYZJQHSgIQkU5ZOpBC4CMRcCS01P4OjRrsB
         ezIvUcMZA+BStwk1s28tVJGf9ib4HWgfF8juepV/yMGQUWraTXUQWbjWPF8vEVnjag
         dXU2xi+TLwAzQGANaKzvh365Idgblo6mEroSCgGulIdIx0reksiZQHMm80kLOmELof
         tuJ48tR7xYTR9LxxlbjXFFeQUeIEZvq25tr52ze+VrBl/RNQiuFxdwrt8O7kd4o0bA
         WZiCDpJUGF+VTB0+bA0elhzAh70OpCbSAtIutCENSgLeE1+2sN/iBWuf910vG15QNh
         k6EyRTJ0sw4IQ==
Date:   Thu, 29 Sep 2022 21:16:25 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] dmaengine: sh: rcar-dmac: Replace zero-length
 arrays with DECLARE_FLEX_ARRAY() helper
Message-ID: <YzW90cuRT5hdnZ/5@matsya>
References: <YzIdsJqsR3LH2qEK@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzIdsJqsR3LH2qEK@work>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 26-09-22, 16:46, Gustavo A. R. Silva wrote:
> Zero-length arrays are deprecated and we are moving towards adopting
> C99 flexible-array members, instead. So, replace zero-length arrays
> declarations in anonymous union with the new DECLARE_FLEX_ARRAY()
> helper macro.
> 
> This helper allows for flexible-array members in unions.

Applied, thanks

-- 
~Vinod
