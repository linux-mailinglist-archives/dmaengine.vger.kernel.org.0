Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03C596D90FB
	for <lists+dmaengine@lfdr.de>; Thu,  6 Apr 2023 10:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234102AbjDFIBK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 6 Apr 2023 04:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235162AbjDFIBJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 6 Apr 2023 04:01:09 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC7C7A87;
        Thu,  6 Apr 2023 01:01:01 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pkKXu-00D12g-1x; Thu, 06 Apr 2023 16:00:39 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 06 Apr 2023 16:00:38 +0800
Date:   Thu, 6 Apr 2023 16:00:38 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Tom Zanussi <tom.zanussi@linux.intel.com>
Cc:     davem@davemloft.net, fenghua.yu@intel.com, vkoul@kernel.org,
        dave.jiang@intel.com, tony.luck@intel.com,
        wajdi.k.feghali@intel.com, james.guilford@intel.com,
        kanchana.p.sridhar@intel.com, giovanni.cabiddu@intel.com,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH v2 12/15] crypto: iaa - Add support for iaa_crypto
 deflate compression algorithm
Message-ID: <ZC58JggIXgpJ1tpD@gondor.apana.org.au>
References: <20230328153535.126223-1-tom.zanussi@linux.intel.com>
 <20230328153535.126223-13-tom.zanussi@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328153535.126223-13-tom.zanussi@linux.intel.com>
X-Spam-Status: No, score=4.3 required=5.0 tests=HELO_DYNAMIC_IPADDR2,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Mar 28, 2023 at 10:35:32AM -0500, Tom Zanussi wrote:
>
> @@ -881,12 +1574,26 @@ static int iaa_crypto_probe(struct idxd_dev *idxd_dev)
>  
>  	rebalance_wq_table();
>  
> +	if (first_wq) {
> +		iaa_crypto_enabled = true;
> +		ret = iaa_register_compression_device();
> +		if (ret != 0) {
> +			iaa_crypto_enabled = false;
> +			dev_dbg(dev, "IAA compression device registration failed\n");
> +			goto err_register;
> +		}
> +
> +		pr_info("iaa_crypto now ENABLED\n");
> +	}
> +

Sorry for picking on your driver but I've got to start somewhere :)

A long standing problem shared by almost all crypto drivers is that
the hardware removal handling is completely broken.

This is because hardware can be removed at any time, including during
a crypto operatin.  So drivers must work carefully around that fact.

Here is a recipe for dealing with this safely:

1) Never unregister your crypto algorithms, even after the last
piece of hardware has been unplugged.  The algorithms should only
be unregistered (if they have been registered through the first
successful probe call) in the module unload function.

2) Never free any software state for your hardware without some form
of synchronisation with oustanding operations.

Any mechanism would do, for example, you could use a spinlock if the
critical path isn't very long.  The operational path would take the
lock, check the hardware state, and if present proceed with the
operation (but still being prepared to cope if the hardware goes
AWAL because even if the driver state is still present the actual
hardware may be gone already).

Then the removal path would simply take the spinlock, set a flag
indicating the hardware is gone and then you could safely unlock
and free your driver states.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
