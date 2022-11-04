Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88FCB619A68
	for <lists+dmaengine@lfdr.de>; Fri,  4 Nov 2022 15:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbiKDOou (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 4 Nov 2022 10:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbiKDOot (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 4 Nov 2022 10:44:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D06C180
        for <dmaengine@vger.kernel.org>; Fri,  4 Nov 2022 07:44:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CC277B82E2C
        for <dmaengine@vger.kernel.org>; Fri,  4 Nov 2022 14:44:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C6A6C433D6;
        Fri,  4 Nov 2022 14:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667573086;
        bh=fVun06tfRaIzYqLpg+anLNNSb51FswcgznGJ2gE3Bfk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=juNHMgvzakakkw/r7d2RxotcxWuG/txPOCqmK49bo7FL6AhZpi2jH33oM5MGI/7ZL
         xlY1E4bQ2bogr8WiKE5nOSwgIs2FNvK/eOsQPhzBKl6+6EFf4cEq0vEKzGH1z5uUDB
         ZwRlZyurMjrCSlTNcDXuBNAgQLgeAvls6d4ARpiZ5Py8uw3rnlbuMe5gkJJ4O0IQyl
         kSbBgrmTwNLgwJHUSjfmVJFGC5pYIEisfRiUHYPC8GLK/dtQmwju8lFpPEGKrxE3xh
         o6nw3IdDtFAYbv6T1qIFCAfi3napyImgBPiOCFdLArft+94zRZNYCd55PcwLV9+mFO
         onDOC0/W3Grmg==
Date:   Fri, 4 Nov 2022 20:14:42 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Xiaochen Shen <xiaochen.shen@intel.com>
Cc:     fenghua.yu@intel.com, dave.jiang@intel.com,
        dmaengine@vger.kernel.org, ramesh.thomas@intel.com,
        tony.luck@intel.com, tony.zhu@intel.com, pei.p.jia@intel.com
Subject: Re: [PATCH RESEND] dmaengine: idxd: Make read buffer sysfs
 attributes invisible for Intel IAA
Message-ID: <Y2UlWlqnOAuU50kO@matsya>
References: <20220930213324.23897-1-xiaochen.shen@intel.com>
 <20221022074949.11719-1-xiaochen.shen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221022074949.11719-1-xiaochen.shen@intel.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 22-10-22, 15:49, Xiaochen Shen wrote:
> In current code, the following sysfs attributes are exposed to user to
> show or update the values:
>   max_read_buffers (max_tokens)
>   read_buffer_limit (token_limit)
>   group/read_buffers_allowed (group/tokens_allowed)
>   group/read_buffers_reserved (group/tokens_reserved)
>   group/use_read_buffer_limit (group/use_token_limit)
> 
> >From Intel IAA spec [1], Intel IAA does not support Read Buffer
> allocation control. So these sysfs attributes should not be supported on
> IAA device.
> 
> Fix this issue by making these sysfs attributes invisible through
> is_visible() filter when the device is IAA.
> 
> Add description in the ABI documentation to mention that these
> attributes are not visible when the device does not support Read Buffer
> allocation control.

Applied, thanks

-- 
~Vinod
