Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 939D67B8249
	for <lists+dmaengine@lfdr.de>; Wed,  4 Oct 2023 16:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233340AbjJDO3J (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 4 Oct 2023 10:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233430AbjJDO3I (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 4 Oct 2023 10:29:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587C8AB;
        Wed,  4 Oct 2023 07:29:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 656B2C433CA;
        Wed,  4 Oct 2023 14:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696429745;
        bh=i3oPaZJTxFmjSMSUxGfO7GQlP35gAN9BPs9L6YdVA6M=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=bXjY9E97A/1VOk+6wOUzboJsNwLSfsBhUlDN0nyVZqntCaX+JrGAqpSRiLebAkz73
         dZRR8k7v2qbnFqm+EoY72WFHR6K6P0hsf1y5ObLLt08C2ghLMDZDPTBfnwUGywUJvU
         wmElgty8QOD7gekd/ios9OzEDDhydG5kUJRUjAUhRXL2xc0syYaA5gRZ3pmUgCKfYk
         Dyr3gTrP0aK3bIhX0X55FRv7QWWsOVT/LPwOaoBdgNHMZqwOQjH7l48Biw61SELPxz
         GIiXRuvxFuNilruaA+/tfsscO91fXIm1J/GFic6YnSvYHs7p7wVgjhi5hmC8LdDmPZ
         MxOHGIksb6QEg==
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Cc:     dmaengine@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
In-Reply-To: <20230908201045.4115614-1-fenghua.yu@intel.com>
References: <20230908201045.4115614-1-fenghua.yu@intel.com>
Subject: Re: [PATCH] dmaengine: idxd: add wq driver name support for
 accel-config user tool
Message-Id: <169642974297.440009.10230225002907030565.b4-ty@kernel.org>
Date:   Wed, 04 Oct 2023 19:59:02 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On Fri, 08 Sep 2023 13:10:45 -0700, Fenghua Yu wrote:
> With the possibility of multiple wq drivers that can be bound to the wq,
> the user config tool accel-config needs a way to know which wq driver to
> bind to the wq. Introduce per wq driver_name sysfs attribute where the user
> can indicate the driver to be bound to the wq. This allows accel-config to
> just bind to the driver using wq->driver_name.
> 
> 
> [...]

Applied, thanks!

[1/1] dmaengine: idxd: add wq driver name support for accel-config user tool
      commit: 7af1e0aceeb321cbc90fcf6fa0bec8870290377f

Best regards,
-- 
~Vinod


