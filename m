Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50F1C782F4C
	for <lists+dmaengine@lfdr.de>; Mon, 21 Aug 2023 19:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbjHURVo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 21 Aug 2023 13:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232446AbjHURVn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 21 Aug 2023 13:21:43 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13FB1FA;
        Mon, 21 Aug 2023 10:21:39 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 6514F1C0004; Mon, 21 Aug 2023 19:21:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1692638498;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3mZF4aMsBair4Jfy2FPGtiI2hZcQaC38lsmVdIEQApo=;
        b=VWhxK7hHTaVMhoI+c+u0OusO0L3ShzmBOg8ooZH3pVcLMA80/VaHCK8XeF8Yo3dTgPHSBq
        WFV3k1oZUyYiWdwtzmw8pWLeR31pGbc1fX/yyyKL1f41NOS9yxC0iEDyKiqTijYHKMGZ0S
        AlObMqYioddltPk8unJfSErwOC8bP4k=
Date:   Mon, 21 Aug 2023 19:21:34 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Tom Zanussi <tom.zanussi@linux.intel.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        fenghua.yu@intel.com, vkoul@kernel.org, dave.jiang@intel.com,
        tony.luck@intel.com, wajdi.k.feghali@intel.com,
        james.guilford@intel.com, kanchana.p.sridhar@intel.com,
        vinodh.gopal@intel.com, giovanni.cabiddu@intel.com,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH v8 08/14] crypto: iaa - Add IAA Compression Accelerator
 Documentation
Message-ID: <20230821172015.GB2227@bug>
References: <20230731212939.1391453-1-tom.zanussi@linux.intel.com>
 <20230731212939.1391453-9-tom.zanussi@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731212939.1391453-9-tom.zanussi@linux.intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi!

> Because the IAA Compression Accelerator requires significant user
> setup in order to be used properly, this adds documentation on the
> iaa_crypto driver including setup, usage, and examples.
> 
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>


> +accel-config
> +------------
> +
> +Unlike typical drivers, the iaa_crypto driver does not enable the
> +device on driver load.  Due to complexity and configurability of the
> +accelerator devices, it was a design decision to have the user
> +configure the device and manually enable the desired devices and
> +workqueues.

Is the driver really so special? Is it widely used besides of zswap? Could some kind of 
simple default configuration good enough for zswap be provided?

> +The userspace tool to help doing that is called accel-config.  Using
> +accel-config to configure device or loading a previously saved config
> +is highly recommended.  The device can be controlled via sysfs
> +directly but comes with the warning that do this ONLY if you know
> +exactly what you are doing.  This document will not cover the sysfs
> +interface but assumes you will be using accel-config.

Not covering the interface here is okay, but we really should have description somewhere, 
and there should be pointer to it here.

> +++ b/Documentation/driver-api/crypto/iaa/index.rst
> @@ -0,0 +1,20 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=================================
> +IAA (Intel Analytics Accelerator)
> +=================================
> +
> +IAA provides hardware compression and decompression via the crypto
> +API.

Why is it called "analytics accelerator" when its main function is compression?

Best regards,
                                                                        Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
