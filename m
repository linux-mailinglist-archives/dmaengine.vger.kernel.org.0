Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD6726D1F88
	for <lists+dmaengine@lfdr.de>; Fri, 31 Mar 2023 13:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbjCaLzo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 31 Mar 2023 07:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbjCaLzn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 31 Mar 2023 07:55:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9461D86C;
        Fri, 31 Mar 2023 04:55:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 61FB9B82EC5;
        Fri, 31 Mar 2023 11:55:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D309C433EF;
        Fri, 31 Mar 2023 11:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680263739;
        bh=DZjPgvsvx+QFSuqOVUmOJTZFeEdqJ5FO+fnshzW85Eg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fZf7OpVvRwRP/6DDgpf+1tze1rwrDsE5IepX1Eo2hM7x6h7dsYzBIDxibvjKH+P7G
         KIWe0Fh5jTgkPRcyQxwtV0+MDHHHBa5xYU3PEQZSzN/GGtR41+CKXeCtGyCt7hc++v
         tSvRG/ncfzNipVZ/mGKhXGbyaujaYEKXGPkZsKCagUW5dHi8rEIEinG34nlJI7H0Or
         p100K0bknhNzOJjHk1SWE/ihCJ6tKbn++wVBpiz/CXTnxe/yrLv4UGra61wEtp7JbB
         NjWDJDjSLzkldN6Qq0e1lo3wt4LCf3QC5jw/oliZWdLN+ls0ANZb7cKlnAgdMUQSRJ
         Na6eK2loyEb0g==
Date:   Fri, 31 Mar 2023 17:25:34 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Dave Jiang <dave.jiang@intel.com>, dmaengine@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] Add descriptor definitions for a few new DSA
 operations
Message-ID: <ZCbKNtJvGtwwrPv+@matsya>
References: <20230303213413.3357431-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230303213413.3357431-1-fenghua.yu@intel.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 03-03-23, 13:34, Fenghua Yu wrote:
> A few new DSA operations are introduced [1]:
> 1. Memory fill with 16 bytes of pattern.
> 2. Translation fetch.
> 3. Data Integrity Extension (DIX) generate.
> 
> This series adds descriptor definitions for the new DSA operations.
> With the definitions, user can issue the DSA operations to optimize
> corresponding transactions.

Applied, thanks

-- 
~Vinod
