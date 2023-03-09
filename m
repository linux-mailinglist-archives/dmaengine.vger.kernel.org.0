Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F7A6B2110
	for <lists+dmaengine@lfdr.de>; Thu,  9 Mar 2023 11:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbjCIKQ3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 9 Mar 2023 05:16:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbjCIKPr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 9 Mar 2023 05:15:47 -0500
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 192D35DCA1;
        Thu,  9 Mar 2023 02:15:20 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1paDIH-00250t-OJ; Thu, 09 Mar 2023 18:14:42 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 09 Mar 2023 18:14:41 +0800
Date:   Thu, 9 Mar 2023 18:14:41 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Tom Zanussi <tom.zanussi@linux.intel.com>, davem@davemloft.net,
        fenghua.yu@intel.com, vkoul@kernel.org, tony.luck@intel.com,
        wajdi.k.feghali@intel.com, james.guilford@intel.com,
        kanchana.p.sridhar@intel.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH 00/16] crypto: Add Intel Analytics Accelerator (IAA)
 crypto compression driver
Message-ID: <ZAmxkd7yMz8hiCxR@gondor.apana.org.au>
References: <20230306185226.26483-1-tom.zanussi@linux.intel.com>
 <ZAa7lS/eS1wWuXYp@gondor.apana.org.au>
 <3a39812e-62da-377c-f430-dd6c1eb473e2@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a39812e-62da-377c-f430-dd6c1eb473e2@intel.com>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Mar 07, 2023 at 08:54:03AM -0700, Dave Jiang wrote:
>
> Hi Herbert, does this mean drivers/crypto/qat should now move to
> drivers/crypto/intel/qat?

Yes we should move qat as well.  Oh and there's also ixp4xx and
keembay.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
