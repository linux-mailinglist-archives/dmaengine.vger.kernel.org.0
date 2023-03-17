Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142BD6BDF0F
	for <lists+dmaengine@lfdr.de>; Fri, 17 Mar 2023 03:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjCQCwz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 Mar 2023 22:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjCQCwz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 16 Mar 2023 22:52:55 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC028A3B6;
        Thu, 16 Mar 2023 19:52:53 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pd0C4-005aM8-MU; Fri, 17 Mar 2023 10:51:49 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 17 Mar 2023 10:51:48 +0800
Date:   Fri, 17 Mar 2023 10:51:48 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Tom Zanussi <tom.zanussi@linux.intel.com>
Cc:     davem@davemloft.net, fenghua.yu@intel.com, vkoul@kernel.org,
        dave.jiang@intel.com, tony.luck@intel.com,
        wajdi.k.feghali@intel.com, james.guilford@intel.com,
        kanchana.p.sridhar@intel.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH 12/16] crypto: iaa - Add support for iaa_crypto deflate
 compression algorithm
Message-ID: <ZBPVxDSESihZ12tD@gondor.apana.org.au>
References: <20230306185226.26483-1-tom.zanussi@linux.intel.com>
 <20230306185226.26483-13-tom.zanussi@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306185226.26483-13-tom.zanussi@linux.intel.com>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Mar 06, 2023 at 12:52:22PM -0600, Tom Zanussi wrote:
>
> +static struct crypto_alg iaa_comp_deflate = {
> +	.cra_name		= "deflate",
> +	.cra_driver_name	= "iaa_crypto",
> +	.cra_flags		= CRYPTO_ALG_TYPE_COMPRESS,
> +	.cra_priority		= IAA_ALG_PRIORITY,
> +	.cra_module		= THIS_MODULE,
> +	.cra_u			= {
> +	.compress = {
> +			.coa_compress	= iaa_comp_compress,
> +			.coa_decompress	= iaa_comp_decompress
> +		}
> +	}
> +};

Please add any new code using the legacy compression interface.
We're trying to phase them out.

If your user is still using the legacy interface, they should
be converted instead.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
