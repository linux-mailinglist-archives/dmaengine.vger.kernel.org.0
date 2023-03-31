Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD2E06D2045
	for <lists+dmaengine@lfdr.de>; Fri, 31 Mar 2023 14:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbjCaM2g (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 31 Mar 2023 08:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbjCaM2f (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 31 Mar 2023 08:28:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A1A2030D;
        Fri, 31 Mar 2023 05:28:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3B9F5B82EF2;
        Fri, 31 Mar 2023 12:28:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0377BC433D2;
        Fri, 31 Mar 2023 12:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680265698;
        bh=Pg0DePMuJKjZlovJ/nySaK2os7XdKXlA34IFzgpt8o0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C2lph4njsRBU2k/ZsecfHCbNIg89ivSOUsOtARY6SQmK12owwMrvJyLJ6uOlmdxTL
         glEq156FXxFU1pbUUGk7BSqoCrN8Za1LfIP2XUctcHEbSHt9rmslnWs3ht0ZXYjHrq
         pkhHQMkm1Z4X4v3XQDpFwx5T4j3pS4h+8fKSLyiOQfSb2IcIir+NKCMCHunK1X/cYb
         fGPVxShah7ekESAZk9SDytzrqbRvGHk+O8Ny286yH6eNID/8il8QvclehI/DLTt7Ef
         /qIFkqb3g+SbFhDnILCOaFkrmZ7vRQop17dNvEt/W5PcNx/WORmA7ct7LDYfJEhDFE
         nINBvSIULnOMQ==
Date:   Fri, 31 Mar 2023 17:58:15 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Tom Rix <trix@redhat.com>
Cc:     gustavo.pimentel@synopsys.com, nathan@kernel.org,
        ndesaulniers@google.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] dmaengine: dw-edma: remove unused readq_ch and writeq_ch
 functions
Message-ID: <ZCbR30KbAouGwicz@matsya>
References: <20230320234906.1730308-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320234906.1730308-1-trix@redhat.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 20-03-23, 19:49, Tom Rix wrote:
> clang with W=1 reports
> drivers/dma/dw-edma/dw-edma-v0-core.c:162:20: error:
>   unused function 'writeq_ch' [-Werror,-Wunused-function]
> static inline void writeq_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
>                    ^
> drivers/dma/dw-edma/dw-edma-v0-core.c:185:19: error:
>   unused function 'readq_ch' [-Werror,-Wunused-function]
> static inline u64 readq_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
>                   ^
> These functions and their wrapping macros are not used, so remove them.

Applied, thanks

-- 
~Vinod
