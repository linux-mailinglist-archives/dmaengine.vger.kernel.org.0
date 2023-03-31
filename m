Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D96CE6D2041
	for <lists+dmaengine@lfdr.de>; Fri, 31 Mar 2023 14:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbjCaM2K (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 31 Mar 2023 08:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbjCaM2I (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 31 Mar 2023 08:28:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9544B1EFFF;
        Fri, 31 Mar 2023 05:28:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1885762893;
        Fri, 31 Mar 2023 12:28:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CF46C433D2;
        Fri, 31 Mar 2023 12:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680265686;
        bh=Hr/XK3TZ4xTRxTLCywjpNnOkygP2/qvs28NoAAX1LAs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A2M2Yk7xjb8X/Bsg2juFV9TLplaW6OrVAyftk+nrPKmWQvxvj0AaKT4jkie/td/NR
         eZMmK0XpMB2+gZIT0W81WUDw+PsnbmftR+YJz9YDH4OMv9IL6GJpLBOZUdGy00pgDP
         l5IzF8zNxZxrNFkdG80+MqCJ7/l9gYvDMBeX3JhKv4b2aB9cWITyNlQX0tD9Gh0KX2
         IhtmY+FEVWvFoUnzDIkpHeneVcowm2BfUFztah/cLu4EY8uddZ1uCHF2mqKWzJPao0
         mOVZV/B4cFhRm6jyIbJt+txExQTf2NpN2pqLTNYdVw/bpOXzWeRAE9i5vMJIBM0JtD
         UKpwYtdpITD4A==
Date:   Fri, 31 Mar 2023 17:58:02 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Tom Rix <trix@redhat.com>
Cc:     peter.ujfalusi@gmail.com, nathan@kernel.org,
        ndesaulniers@google.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] dmaengine: ti: edma: remove unused edma_and function
Message-ID: <ZCbR0h7ZgQ2HL7ZB@matsya>
References: <20230320231209.1728940-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320231209.1728940-1-trix@redhat.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 20-03-23, 19:12, Tom Rix wrote:
> clang with W=1 reports
> drivers/dma/ti/edma.c:321:20: error: unused function
>   'edma_and' [-Werror,-Wunused-function]
> static inline void edma_and(struct edma_cc *ecc, int offset, unsigned and)
>                    ^
> This function is not used, so remove it.

Applied, thanks

-- 
~Vinod
