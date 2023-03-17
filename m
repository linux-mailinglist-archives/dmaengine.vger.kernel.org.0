Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38B6D6BF00A
	for <lists+dmaengine@lfdr.de>; Fri, 17 Mar 2023 18:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbjCQRoe (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Mar 2023 13:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbjCQRod (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 17 Mar 2023 13:44:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDBA36FE6;
        Fri, 17 Mar 2023 10:44:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E481F60DBE;
        Fri, 17 Mar 2023 17:43:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4F01C433EF;
        Fri, 17 Mar 2023 17:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679075034;
        bh=nN7qOre89NjI0kWpENX5GLcHG+oU6zTxhdSN2qDHG68=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J1Hgnh1GzmLUeGGRJe6gO/qSsCn8qOF+XKFkQPOJ0JNB/KCkVdvBn4qdmPcNIJaF/
         NFHk/icVNWUc/WROt3RbHWon1DteVhQLtVLWtX4JSLgqEKcAR+m6VX8/quqddf3mll
         S+My7FN+uBbiLlq4LO6Q0KAI4AJmMmZ+viKIjHA3tH5zl3J71mVMsiHyVavoPpI0RI
         qwjoPUWWhC6CWeYD50vDhTS1rp9GmM8JgXYwsAf4wCdwf49uruaDhdMUXnQ2wOwEXI
         o7vWd2QoY0vQpHhgKeAcdr8p9Z0CeSqZ6UZJognyagkJY7657xJHqw9+gke1kf1VMY
         /40qvCazcY5pQ==
Date:   Fri, 17 Mar 2023 23:13:50 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] dmaengine: Actually use devm_add_action_or_reset()
Message-ID: <ZBSm1mWj3u/5f0zG@matsya>
References: <20230213112138.32118-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230213112138.32118-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 13-02-23, 13:21, Andy Shevchenko wrote:
> It appears that the commit a1beaa50b583 ("dmaengine: Simplify
> dmaenginem_async_device_register() function") mentions
> devm_add_action_or_reset() the actual change utilised devm_add_action()
> call by mistake.
> 
> Fix the issue by switching to devm_add_action_or_reset().

Applied, thanks

-- 
~Vinod
