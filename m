Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC20150B157
	for <lists+dmaengine@lfdr.de>; Fri, 22 Apr 2022 09:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444722AbiDVH1q (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 22 Apr 2022 03:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444773AbiDVH1f (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 22 Apr 2022 03:27:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE10F5006B
        for <dmaengine@vger.kernel.org>; Fri, 22 Apr 2022 00:24:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A5578B82A89
        for <dmaengine@vger.kernel.org>; Fri, 22 Apr 2022 07:24:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E059BC385A4;
        Fri, 22 Apr 2022 07:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650612280;
        bh=a9XFHB5KTUVM/++Od48uhizMUvs2RvY3v9GzsQ1YNjA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z2bsHmenAmd+0gSva0cKVTq0mQ8Fyk9JIlJw5STkfLgGC+NbCA98wtXUpLtaQ0yE+
         oOhbSelgbPDPFT0IwwV/r/tl618vqNqmhCrU2hbSsNninx8YTFJFFV2/9BkptcqWWI
         dXhVPuQkUI9gcz5nTi9f9D+M7QD/bsy4V6sqFYn4zGks2wzcJWSyuLUb6iJvjSlON4
         yRwFYGxZZKm+kJs+JJp0i/M5yswPHl6XSxYbUORvgAFpPV+fDxi/OdaLXIfztWH+Vn
         vlWZBroEs8jEhxE8U6Fviv6RQJBuc+rnyxmlx6pCGtwxwTuCqyW60KL+LudKhlNkeN
         wl6WEuaq3ZfhA==
Date:   Fri, 22 Apr 2022 12:54:35 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: refactor wq driver enable/disable
 operations
Message-ID: <YmJYM9WQa4FAuNU5@matsya>
References: <165047301643.3841827.11222723219862233060.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165047301643.3841827.11222723219862233060.stgit@djiang5-desk3.ch.intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 20-04-22, 09:43, Dave Jiang wrote:
> Move the core driver operations from wq driver to the drv_enable_wq() and
> drv_disable_wq() functions. The move should reduce the wq driver's
> knowledge of the core driver operations and prevent code confusion for
> future wq drivers.

Applied, thanks

-- 
~Vinod
