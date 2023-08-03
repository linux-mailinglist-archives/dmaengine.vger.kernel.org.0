Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22F5C76E9E1
	for <lists+dmaengine@lfdr.de>; Thu,  3 Aug 2023 15:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234692AbjHCNSW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 3 Aug 2023 09:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236279AbjHCNSE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 3 Aug 2023 09:18:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DCF24226;
        Thu,  3 Aug 2023 06:17:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D75A361D74;
        Thu,  3 Aug 2023 13:17:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C57F0C433C8;
        Thu,  3 Aug 2023 13:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691068677;
        bh=4gs18OIcwMnXqrtjETCzulxV8ACcOd183Hsm5UKKmjw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tpv/hwndsTqRSZOgJZSJrVHXjx7nr7VXkaMXG+dHgRDXKhfCa4ypRGixTVd0uN77h
         GnWJAd+01y0L2K8T/ish3ug9YSz+kGAqWV31AHfOfa5QjTkSW+9iIQc5hzlZjNwk6I
         1PPFadUBR2O99oMtjHvYY4Z0H5l7dmrdsUCQF5KtBYOPcpWt/oYRzCnKbfNmFQul3R
         AhjsQjLTRmsdRC7mY+igk2XRAKSxW7rDGzrwWQwr9pvn28d4q5M40TdAz9jD9blMmt
         5LFNipK6I99PcwI6FSXhJ/ApvWHBK9ZPVOhomW+cCmNooZydsRFX1lQDJXMSkRHzQY
         qrNiS+NYLYwFg==
Date:   Thu, 3 Aug 2023 18:47:53 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Tom Zanussi <tom.zanussi@linux.intel.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        fenghua.yu@intel.com, dave.jiang@intel.com, tony.luck@intel.com,
        wajdi.k.feghali@intel.com, james.guilford@intel.com,
        kanchana.p.sridhar@intel.com, vinodh.gopal@intel.com,
        giovanni.cabiddu@intel.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v8 06/14] dmaengine: idxd: Add wq private data accessors
Message-ID: <ZMupAZbD4s6JEN3y@matsya>
References: <20230731212939.1391453-1-tom.zanussi@linux.intel.com>
 <20230731212939.1391453-7-tom.zanussi@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731212939.1391453-7-tom.zanussi@linux.intel.com>
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
> Add the accessors idxd_wq_set_private() and idxd_wq_get_private()
> allowing users to set and retrieve a private void * associated with an
> idxd_wq.
> 
> The private data is stored in the idxd_dev.conf_dev associated with
> each idxd_wq.

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
