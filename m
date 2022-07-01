Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459B75632DA
	for <lists+dmaengine@lfdr.de>; Fri,  1 Jul 2022 13:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235661AbiGALrr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 1 Jul 2022 07:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234170AbiGALrq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 1 Jul 2022 07:47:46 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F4683F18;
        Fri,  1 Jul 2022 04:47:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 31F40CE3172;
        Fri,  1 Jul 2022 11:47:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E883BC3411E;
        Fri,  1 Jul 2022 11:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656676062;
        bh=zHN7lUkv5PsDpZQbhvOzUH17PWAirh032lFbPs15u8U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ojUP+jQJkMu/bAD4b/Fko5MzgbamLPUAz7rk1VcKKWunJAqKfoGf4WsoJ5JI8KR1y
         ZgINc98MK9fct4zXdNJN50T1pK14fcPhRUB7gvtvAiyNrPmtOx5YTQSqceEx4NN5EO
         zm1bDWuZEQwHiZ7jX4z2sZhbnQDpdKaLg9BMtrt5vNYzJ36Lb6pa98t0yr8oTGKpvm
         tFJqAu2cHVqcQNdmtmMNsbGxW4uY9rjW8o7gFSbcUeLwph2M5qo83g1d0bUoIZ8pyO
         cXlF/PfJ+OzOcOvnW9cnPkHvm1HzcXLLAbyEKVyfBwLouWkgY0Ssm1lStYQxIzwuom
         eiMhiNQwRjTEg==
Date:   Fri, 1 Jul 2022 17:17:38 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jayesh Choudhary <j-choudhary@ti.com>
Cc:     dmaengine@vger.kernel.org, peter.ujfalusi@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: ti: k3-psil-j721s2: Add psil threads for sa2ul
Message-ID: <Yr7e2uA2PqfpdI/7@matsya>
References: <20220628050232.331956-1-j-choudhary@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628050232.331956-1-j-choudhary@ti.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 28-06-22, 10:32, Jayesh Choudhary wrote:
> Add endpoint configuration for the four ingress and two egress
> threads for main domain crypto accelerator.

Applied, thanks

-- 
~Vinod
