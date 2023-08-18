Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC1A78079A
	for <lists+dmaengine@lfdr.de>; Fri, 18 Aug 2023 10:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347938AbjHRI7J (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 18 Aug 2023 04:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358813AbjHRI6y (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 18 Aug 2023 04:58:54 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E70830E9;
        Fri, 18 Aug 2023 01:58:51 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qWvJR-005Ewm-GG; Fri, 18 Aug 2023 16:58:34 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 18 Aug 2023 16:58:34 +0800
Date:   Fri, 18 Aug 2023 16:58:34 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Tom Zanussi <tom.zanussi@linux.intel.com>
Cc:     davem@davemloft.net, fenghua.yu@intel.com, vkoul@kernel.org,
        dave.jiang@intel.com, tony.luck@intel.com,
        wajdi.k.feghali@intel.com, james.guilford@intel.com,
        kanchana.p.sridhar@intel.com, vinodh.gopal@intel.com,
        giovanni.cabiddu@intel.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v9 00/14] crypto: Add Intel Analytics Accelerator (IAA)
 crypto compression driver
Message-ID: <ZN8yujTWN42vd2cF@gondor.apana.org.au>
References: <20230807203726.1682123-1-tom.zanussi@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230807203726.1682123-1-tom.zanussi@linux.intel.com>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        PDS_RDNS_DYNAMIC_FP,RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,TVD_RCVD_IP,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Aug 07, 2023 at 03:37:12PM -0500, Tom Zanussi wrote:
> Hi, this is v9 of the IAA crypto driver, incorporating feedback from
> v8.
> 
> v9 changes:
> 
>   - Renamed drv_enable/disable_wq() to idxd_drv_enable/disable_wq()
>     and exported it, changing all existing callers as well as the
>     iaa_crypto driver.
> 
>   - While testing, ran into a use-after-free bug in the irq support
>     flagged by KASAN so fixed that up in iaa_compress() (added missing
>     disable_async check).
> 
>   - Also, while fixing the use-after-free bug, rearranged the out:
>     part of iaa_desc_complete() to make it cleaner.
> 
>   - Also for the verify cases, reversed the dma mapping by adding and
>     calling a new iaa_remap_for_verify() function, since verify
>     basically does a decompress after reversing the src and dst
>     buffers.
> 
>   - Added new Acked-by and Reviewed-by tags.

This adds a bunch of warnings for me:

../drivers/crypto/intel/iaa/iaa_crypto_main.c:2090:5: warning: no previous prototype for ‘wq_stats_show’ [-Wmissing-prototypes]
 2090 | int wq_stats_show(struct seq_file *m, void *v)
      |     ^~~~~~~~~~~~~
../drivers/crypto/intel/iaa/iaa_crypto_main.c:2106:5: warning: no previous prototype for ‘iaa_crypto_stats_reset’ [-Wmissing-prototypes]
 2106 | int iaa_crypto_stats_reset(void *data, u64 value)
      |     ^~~~~~~~~~~~~~~~~~~~~~

../drivers/crypto/intel/iaa/iaa_crypto_main.c:827:38: warning: incorrect type in argument 1 (different base types)
../drivers/crypto/intel/iaa/iaa_crypto_main.c:827:38:    expected unsigned long [usertype] size
../drivers/crypto/intel/iaa/iaa_crypto_main.c:827:38:    got restricted gfp_t
../drivers/crypto/intel/iaa/iaa_crypto_main.c:827:58: warning: incorrect type in argument 2 (different base types)
../drivers/crypto/intel/iaa/iaa_crypto_main.c:827:58:    expected restricted gfp_t [usertype] flags
../drivers/crypto/intel/iaa/iaa_crypto_main.c:827:58:    got unsigned long
../drivers/crypto/intel/iaa/iaa_crypto_main.c:2090:5: warning: symbol 'wq_stats_show' was not declared. Should it be static?
../drivers/crypto/intel/iaa/iaa_crypto_main.c:2106:5: warning: symbol 'iaa_crypto_stats_reset' was not declared. Should it be static?
../drivers/crypto/intel/iaa/iaa_crypto_main.c:2028:13: warning: context imbalance in 'iaa_crypto_remove' - different lock contexts for basic block

../drivers/crypto/intel/iaa/iaa_crypto_comp_fixed.c:10:11: warning: symbol 'fixed_ll_sym' was not declared. Should it be static?
../drivers/crypto/intel/iaa/iaa_crypto_comp_fixed.c:49:11: warning: symbol 'fixed_d_sym' was not declared. Should it be static?

Please fix before resubmitting.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
