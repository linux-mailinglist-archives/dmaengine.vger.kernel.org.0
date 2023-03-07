Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E85496AD62D
	for <lists+dmaengine@lfdr.de>; Tue,  7 Mar 2023 05:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjCGEWC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 Mar 2023 23:22:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjCGEVm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 6 Mar 2023 23:21:42 -0500
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E726060D7D;
        Mon,  6 Mar 2023 20:21:10 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pZOoX-0017fk-QQ; Tue, 07 Mar 2023 12:20:38 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 07 Mar 2023 12:20:37 +0800
Date:   Tue, 7 Mar 2023 12:20:37 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Tom Zanussi <tom.zanussi@linux.intel.com>
Cc:     davem@davemloft.net, fenghua.yu@intel.com, vkoul@kernel.org,
        dave.jiang@intel.com, tony.luck@intel.com,
        wajdi.k.feghali@intel.com, james.guilford@intel.com,
        kanchana.p.sridhar@intel.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH 00/16] crypto: Add Intel Analytics Accelerator (IAA)
 crypto compression driver
Message-ID: <ZAa7lS/eS1wWuXYp@gondor.apana.org.au>
References: <20230306185226.26483-1-tom.zanussi@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230306185226.26483-1-tom.zanussi@linux.intel.com>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Mar 06, 2023 at 12:52:10PM -0600, Tom Zanussi wrote:
> This series adds Linux crypto algorithm support for Intel® In-memory
> Analytics Accelerator (Intel IAA) [1] hardware compression and
> decompression, which is available on Sapphire Rapids systems.

I haven't reviewed the patches yet, but could you please create
a drivers/crypto/intel directory and put this driver in it?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
