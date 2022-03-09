Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F15BB4D2785
	for <lists+dmaengine@lfdr.de>; Wed,  9 Mar 2022 05:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbiCIDWf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 8 Mar 2022 22:22:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbiCIDWe (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 8 Mar 2022 22:22:34 -0500
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F9414E95E;
        Tue,  8 Mar 2022 19:21:37 -0800 (PST)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1nRmtJ-0002wo-Pl; Wed, 09 Mar 2022 14:21:34 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Wed, 09 Mar 2022 15:21:33 +1200
Date:   Wed, 9 Mar 2022 15:21:33 +1200
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     =?utf-8?B?RMSBdmlzIE1vc8SBbnM=?= <davispuh@gmail.com>
Cc:     linux-kernel@vger.kernel.org, thomas.lendacky@amd.com,
        john.allen@amd.com, linux-crypto@vger.kernel.org,
        dmaengine@vger.kernel.org, davispuh@gmail.com
Subject: Re: [PATCH] ccp: ccp_dmaengine_unregister release dma channels
Message-ID: <YigdPfAF8y3LBtl2@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220228031545.11639-1-davispuh@gmail.com>
X-Newsgroups: apana.lists.os.linux.cryptoapi,apana.lists.os.linux.kernel
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Dāvis Mosāns <davispuh@gmail.com> wrote:
> ccp_dmaengine_register adds dma_chan->device_node to dma_dev->channels list
> but ccp_dmaengine_unregister didn't remove them.
> That can cause crashes in various dmaengine methods that tries to use dma_dev->channels
> 
> Signed-off-by: Dāvis Mosāns <davispuh@gmail.com>
> ---
> drivers/crypto/ccp/ccp-dmaengine.c | 16 ++++++++++++++++
> 1 file changed, 16 insertions(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
