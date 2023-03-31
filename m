Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B724D6D1F8D
	for <lists+dmaengine@lfdr.de>; Fri, 31 Mar 2023 13:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbjCaL5J (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 31 Mar 2023 07:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbjCaL5I (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 31 Mar 2023 07:57:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 110A71A963;
        Fri, 31 Mar 2023 04:57:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A08F5623F5;
        Fri, 31 Mar 2023 11:57:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85A57C433EF;
        Fri, 31 Mar 2023 11:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680263827;
        bh=EyvfjlBAyxUoTaDBNthqqTsa3gx5coPnPuGYL6OJgRk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V011AXD6PGA08x18mvrDbALidf8+ksL+wW7utjYNDxMhHIZgQAsmLNEOcN8yWqn3b
         /3MP5aiUIWBGwW6BR7cCcu7Kffhe6Oi6SvbHVlLHztfdZzH+WbouUeOf24L8iBB/gc
         Y8FiStMu1swnhIJpF7z7vTE/ogKo4iKNdadSX4KElHYClKALxKGIQbWfNC/+Ca7WCL
         cl/8OafZToo8tM4lzAT4kQSYFvuxTn8pWJofnYYEBWtXsyLHZuZHwwDW/5GuZKvhnq
         Jjn3uVEno07JRqxyaThxpXDOBaeEnxAAsrT/ZeC3EATw/p4FhUbaosFXAFmKZI0xFd
         f1SOyPHuq8YrQ==
Date:   Fri, 31 Mar 2023 17:27:03 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Dave Jiang <dave.jiang@intel.com>, dmaengine@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] Expose IAA 2.0 device capabilities
Message-ID: <ZCbKj7zyUXwpjctZ@matsya>
References: <20230303213732.3357494-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230303213732.3357494-1-fenghua.yu@intel.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 03-03-23, 13:37, Fenghua Yu wrote:
> In-memory Analytics Accelerator (IAA) 2.0 [1] introduces General
> Capabilities Register (GENCAP). Add a sysfs attribute to expose the
> register to applications.
> 
> This series is applied cleanly on top of DSA 2.0 Event Log and Completion
> Record Faulting series: 
> https://lore.kernel.org/dmaengine/20230103163505.1569356-1-fenghua.yu@intel.com/T/#m13ba6167994f3add6446d2d7e242ecb637c54426

Applied, thanks

-- 
~Vinod
