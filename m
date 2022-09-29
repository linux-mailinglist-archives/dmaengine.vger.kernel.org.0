Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF4455EFA7A
	for <lists+dmaengine@lfdr.de>; Thu, 29 Sep 2022 18:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234996AbiI2QaX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 29 Sep 2022 12:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236280AbiI2Q3v (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 29 Sep 2022 12:29:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B9614D489;
        Thu, 29 Sep 2022 09:29:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0ED461AB0;
        Thu, 29 Sep 2022 16:29:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C45D0C433C1;
        Thu, 29 Sep 2022 16:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664468964;
        bh=lai6muO+sRFE7eR6vEJvlDipJfbkCfQ+xED7W97wXI0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o9FQOFEXL17hXS/u8KqgrzyQ5bvPM6dTunuauTk2O7Vn9/FTLteX4LfXJZ+V5hPN6
         ZhTZZcHCdhKGed0dhVrdo2R2+qvb/2Socun53eKJ95FUKbTtPSJ821U6HfnglgtgGT
         MSISMdL8bs/lksnvn6zOBspsf/JGbB/6D2P9QQf6C5iRS04qM0S+++DavwnGHi4+uw
         Dc/L6kOvRZtOMrnarkZ1q+oTT8l1WPhR1njF5ecorceP0tDxZgVODU4kI1nyGeSho6
         WkEBfx6jY/adGcrzarjxFXZpj+UQuRfzmbvwdSmgyJl6+Q1Kk5F0J3RdeAfVTuvTHo
         FE97mRPwsnGfQ==
Date:   Thu, 29 Sep 2022 21:59:19 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Dave Jiang <dave.jiang@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH 0/5] Enable a few DSA 2.0 features
Message-ID: <YzXH3zJMtezvavpW@matsya>
References: <20220917161222.2835172-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220917161222.2835172-1-fenghua.yu@intel.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 17-09-22, 09:12, Fenghua Yu wrote:
> Data Streaming Accelerator (DSA) 2.0 [1] introduces a few new features.
> This series enables the new features:

Applied, thanks

-- 
~Vinod
