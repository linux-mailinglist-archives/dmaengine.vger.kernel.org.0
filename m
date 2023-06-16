Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1754732F52
	for <lists+dmaengine@lfdr.de>; Fri, 16 Jun 2023 13:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344266AbjFPLB7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 16 Jun 2023 07:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344586AbjFPLBk (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 16 Jun 2023 07:01:40 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06727282;
        Fri, 16 Jun 2023 03:55:27 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qA76k-003mcA-3A; Fri, 16 Jun 2023 18:55:11 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 16 Jun 2023 18:55:10 +0800
Date:   Fri, 16 Jun 2023 18:55:10 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Tom Zanussi <tom.zanussi@linux.intel.com>
Cc:     davem@davemloft.net, fenghua.yu@intel.com, vkoul@kernel.org,
        dave.jiang@intel.com, tony.luck@intel.com,
        wajdi.k.feghali@intel.com, james.guilford@intel.com,
        kanchana.p.sridhar@intel.com, vinodh.gopal@intel.com,
        giovanni.cabiddu@intel.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v6 13/15] crypto: iaa - Add support for
 deflate-iaa-canned compression algorithm
Message-ID: <ZIw/jtxdg6O1O0j3@gondor.apana.org.au>
References: <20230605201536.738396-1-tom.zanussi@linux.intel.com>
 <20230605201536.738396-14-tom.zanussi@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230605201536.738396-14-tom.zanussi@linux.intel.com>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Jun 05, 2023 at 03:15:34PM -0500, Tom Zanussi wrote:
> Add support for a 'canned' compression mode using the IAA compression
> mode in-kernel API.
> 
> The IAA 'canned' compression mode is added alongside the existing
> 'fixed' compression mode and a crypto algorithm named
> 'deflate-iaa-canned' is registered using it.

So you said that canned is not compatible with the generic deflate
algorithm.  Does that mean that there is no way for it to decompress
something compressed by the generic deflate algorithm, and vice versa
its compressed output cannot be decompressed by generic deflate?

We don't add an algorithm to the Crypto API if the only implementation
is by hardware.  IOW if you are adding a new algorithm, then a
software version must be the first patch.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
