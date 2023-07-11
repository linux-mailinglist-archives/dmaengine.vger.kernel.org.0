Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E85E74F5F4
	for <lists+dmaengine@lfdr.de>; Tue, 11 Jul 2023 18:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbjGKQpc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 11 Jul 2023 12:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232633AbjGKQpJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 11 Jul 2023 12:45:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EBC81BCF;
        Tue, 11 Jul 2023 09:44:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A26C961529;
        Tue, 11 Jul 2023 16:44:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22D62C433C7;
        Tue, 11 Jul 2023 16:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689093860;
        bh=YhF5GzSKrUG4ROyVWWcSwsr0BD/RChWImwQTdkInk7c=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=cOtip5VViTf+z6hsUqeFUVpJ5sWkeLyYll2lsN93z/HWdOhv6jvtBSCpJ2oT0B3RT
         MHHbbIJyx9zWjmugNhgmzKeTZQUS5C/af/hi+1JjTnMATE4ZAowdRdxlc1gJq0fDVG
         Dyg/Cdi6G+8gZj+XnlqGhWPBgsKodzU8UK28s0NZFsJ+bRRvnNYE8CARlg/XeGoVcd
         UZs1IQDFc2bueEskj8+Dm0qE0hyOdcBEognZSVNQ/ezPzUcqzxmPNtOjPWH2FPLRw8
         7VrNFk+rzhDVQPrmxseZWxLI4OrMWNiJ9GgVuk/CxCejhnON0qzmpmLrVQox6Rw6EB
         Nj/nYIQFp5oeA==
From:   Vinod Koul <vkoul@kernel.org>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        dmaengine@vger.kernel.org
In-Reply-To: <f44be04317387f8936d31d5470963541615f30ef.1685283065.git.christophe.jaillet@wanadoo.fr>
References: <f44be04317387f8936d31d5470963541615f30ef.1685283065.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] dmaengine: idxd: No need to clear memory after a
 dma_alloc_coherent() call
Message-Id: <168909385770.208679.11182902269794530948.b4-ty@kernel.org>
Date:   Tue, 11 Jul 2023 22:14:17 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On Sun, 28 May 2023 16:11:54 +0200, Christophe JAILLET wrote:
> dma_alloc_coherent() already clear the allocated memory, there is no need
> to explicitly call memset().
> 
> 

Applied, thanks!

[1/1] dmaengine: idxd: No need to clear memory after a dma_alloc_coherent() call
      commit: 61e2cd90681e91ee8202d22e5ca25b1100557fc4

Best regards,
-- 
~Vinod


