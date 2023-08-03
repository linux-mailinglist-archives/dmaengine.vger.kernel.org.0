Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D011876E9D4
	for <lists+dmaengine@lfdr.de>; Thu,  3 Aug 2023 15:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236199AbjHCNRW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 3 Aug 2023 09:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236201AbjHCNQ7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 3 Aug 2023 09:16:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028FA3C3B;
        Thu,  3 Aug 2023 06:16:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88F0160F1A;
        Thu,  3 Aug 2023 13:16:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72A73C433C8;
        Thu,  3 Aug 2023 13:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691068575;
        bh=PmPFHr9lz8sHgwE4hkcmOYGHuMvk45438tmVTWPLnmk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W7+vQNLgCKTSk4+OPcykNM8UZol8AchKHFLtVJJ1wPbAKLxRqSYOJEOkODhNUPnA1
         d6vZ1zKsgBkHIIlJ85HaO+pbyXy5A8uXG71GlPD9hwxRRMKde8jnvVaeH9+H/iDcPy
         /2BsyIsH6m5evaxD5ryK/IMbw82aNt6KNG0fhR2wWYvTgJ08vm5NxxSxqJpWVDflBu
         fhaogtEvMzdpVVCMZddDESJe2GfZE0H5Z9oyJ0ZB66HojmEto2G7ymMBE1XUmdeULX
         GpfCkr5mjNRboZlIQQgYOTJhk8gV92+e5O1sdoBCEqxaggoCRYkXukpiid7YG3s50B
         NVZB+U3mmxRuw==
Date:   Thu, 3 Aug 2023 18:46:11 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Tom Zanussi <tom.zanussi@linux.intel.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        fenghua.yu@intel.com, dave.jiang@intel.com, tony.luck@intel.com,
        wajdi.k.feghali@intel.com, james.guilford@intel.com,
        kanchana.p.sridhar@intel.com, vinodh.gopal@intel.com,
        giovanni.cabiddu@intel.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v8 04/14] dmaengine: idxd: Export descriptor management
 functions
Message-ID: <ZMuom+C5PyJ/qliF@matsya>
References: <20230731212939.1391453-1-tom.zanussi@linux.intel.com>
 <20230731212939.1391453-5-tom.zanussi@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731212939.1391453-5-tom.zanussi@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 31-07-23, 16:29, Tom Zanussi wrote:
> To allow idxd sub-drivers to access the descriptor management
> functions, export them.

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
