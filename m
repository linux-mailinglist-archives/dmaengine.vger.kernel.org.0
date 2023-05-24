Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6CB70F372
	for <lists+dmaengine@lfdr.de>; Wed, 24 May 2023 11:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbjEXJun (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 May 2023 05:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231818AbjEXJuf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 24 May 2023 05:50:35 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3B418B;
        Wed, 24 May 2023 02:50:31 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1q1l7V-00CkU8-Pj; Wed, 24 May 2023 17:49:26 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 24 May 2023 17:49:25 +0800
Date:   Wed, 24 May 2023 17:49:25 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Tom Zanussi <tom.zanussi@linux.intel.com>
Cc:     davem@davemloft.net, fenghua.yu@intel.com, vkoul@kernel.org,
        dave.jiang@intel.com, tony.luck@intel.com,
        wajdi.k.feghali@intel.com, james.guilford@intel.com,
        kanchana.p.sridhar@intel.com, giovanni.cabiddu@intel.com,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH v5 13/15] crypto: iaa - Add support for default IAA
 'canned' compression mode
Message-ID: <ZG3dpbPlRXbF2ZxN@gondor.apana.org.au>
References: <20230516215009.51794-1-tom.zanussi@linux.intel.com>
 <20230516215009.51794-14-tom.zanussi@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230516215009.51794-14-tom.zanussi@linux.intel.com>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, May 16, 2023 at 04:50:07PM -0500, Tom Zanussi wrote:
.
> To choose 'fixed' mode:
> 
>   echo "fixed" >  /sys/bus/dsa/drivers/crypto/compression_mode
> 
> To choose 'canned' mode:
> 
>   echo "canned" >  /sys/bus/dsa/drivers/crypto/compression_mode

This seems to be a strange way to switch modes.  How about just
registering both algorithms and then let the user decide which
one to use throught the algorithm name?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
