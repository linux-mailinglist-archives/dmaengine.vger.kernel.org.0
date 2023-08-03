Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E96676E9CB
	for <lists+dmaengine@lfdr.de>; Thu,  3 Aug 2023 15:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236252AbjHCNQn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 3 Aug 2023 09:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236215AbjHCNQ3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 3 Aug 2023 09:16:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA8F448E;
        Thu,  3 Aug 2023 06:15:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CE2661D99;
        Thu,  3 Aug 2023 13:14:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08908C433C7;
        Thu,  3 Aug 2023 13:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691068494;
        bh=9tXX2FIKE8MOIWXd1K+8WbPOQ/m7uwCnkCQGt0+g8AQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XMc7NS4BuZ8tlExBuYyg/arego0CELq+F5mMOUrtFOaQ8rSdgn6CGYFS7bBdYirVK
         fUF3GyXwd4pQon3H/B7tpMxNstuyYwM/S4IYQmq/r8wZ+nTxJfOOpiwfoq/Nc3Nt3z
         WE+ETcBAVsI8rtm9Rt+uylHd2P7ohw/0ye1sD5F+96FaBff/0hNShho5Ice/ZY9cr+
         TxdWUUqVFlLN5g8cSGsXt8l2437Kfb7qJFsU4RF4qMwZg107C77DF+D/A6x3lDdMM3
         eB5GVF23kBseUH4KrUm1JE8aE+k1FsUMLNd4sinkWoERW3Y1boEvoKHaWh4igxFT/n
         JGZwDAiLfUZ8Q==
Date:   Thu, 3 Aug 2023 18:44:50 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Tom Zanussi <tom.zanussi@linux.intel.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        fenghua.yu@intel.com, dave.jiang@intel.com, tony.luck@intel.com,
        wajdi.k.feghali@intel.com, james.guilford@intel.com,
        kanchana.p.sridhar@intel.com, vinodh.gopal@intel.com,
        giovanni.cabiddu@intel.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v8 02/14] dmaengine: idxd: add external module driver
 support for dsa_bus_type
Message-ID: <ZMuoSvB84KaN6wuh@matsya>
References: <20230731212939.1391453-1-tom.zanussi@linux.intel.com>
 <20230731212939.1391453-3-tom.zanussi@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731212939.1391453-3-tom.zanussi@linux.intel.com>
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
> From: Dave Jiang <dave.jiang@intel.com>
> 
> Add support to allow an external driver to be registered to the
> dsa_bus_type and also auto-loaded.

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
