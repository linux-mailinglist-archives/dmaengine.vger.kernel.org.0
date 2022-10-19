Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75579604D7B
	for <lists+dmaengine@lfdr.de>; Wed, 19 Oct 2022 18:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbiJSQeM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 19 Oct 2022 12:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiJSQeL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 19 Oct 2022 12:34:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8110D1C5A67;
        Wed, 19 Oct 2022 09:34:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CF3061939;
        Wed, 19 Oct 2022 16:34:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4A25C433C1;
        Wed, 19 Oct 2022 16:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666197249;
        bh=OQwM+ReWswGV6gQguSXGQnAQ5pETyCKMpBbDzat8faE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XhCj0hmuqdrIvwN5ItwJNX36Cfz7minRFTUglywYdHfLllkUsJ9vqd1eGT7nrIwl9
         7ViqBcsZkW8aCs5PIIYE+BfHzRS/NnIIjbptibHWffavzQQXaCuv6d4ppp9jTHqZUb
         vYIOOJ0D/GMziZPGZcLKy+JU/zYuGk4ZGY9UI/ADBwY+CWQmZ1RQhPQhN6+Luu2fYf
         O7wLi3CDU+c6HiLAD/O63Sli0pTpvVxbhmijESaMHYWjx3dqht8xQA6gdKln9XqNHx
         AIF8mZpAtGr37HEEHRk5mlZ0pqqQRcWdI/4IAT3LIG1iWE/IrgMirnkYlzBSzPprzo
         fzsSFaxDwgpyg==
Date:   Wed, 19 Oct 2022 22:04:05 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Ben Walker <benjamin.walker@intel.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/7] dmaengine: Add provider documentation on cookie
 assignment
Message-ID: <Y1Am/RpgWv3PAVaU@matsya>
References: <20220622193753.3044206-1-benjamin.walker@intel.com>
 <20220829203537.30676-1-benjamin.walker@intel.com>
 <20220829203537.30676-5-benjamin.walker@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220829203537.30676-5-benjamin.walker@intel.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 29-08-22, 13:35, Ben Walker wrote:
> Clarify the rules on assigning cookies to DMA transactions.
> 
> Signed-off-by: Ben Walker <benjamin.walker@intel.com>
> ---
>  .../driver-api/dmaengine/provider.rst         | 45 +++++++++++++++----
>  1 file changed, 37 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/driver-api/dmaengine/provider.rst b/Documentation/driver-api/dmaengine/provider.rst
> index 1d0da2777921d..a5539f816d125 100644
> --- a/Documentation/driver-api/dmaengine/provider.rst
> +++ b/Documentation/driver-api/dmaengine/provider.rst
> @@ -417,7 +417,9 @@ supported.
>  
>      - tx_submit: A pointer to a function you have to implement,
>        that is supposed to push the current transaction descriptor to a
> -      pending queue, waiting for issue_pending to be called.
> +      pending queue, waiting for issue_pending to be called. Each
> +      descriptor is given a cookie to identify it. See the section
> +      "Cookie Management" below.
>  
>    - In this structure the function pointer callback_result can be
>      initialized in order for the submitter to be notified that a
> @@ -522,6 +524,40 @@ supported.
>  
>    - May sleep.
>  
> +Cookie Management
> +------------------
> +
> +When a transaction is queued for submission via tx_submit(), the provider
> +must assign that transaction a cookie (dma_cookie_t) to uniquely identify it.
> +The provider is allowed to perform this assignment however it wants, but for

We assumes that we have monotonically increasing cookie and
if cookie 10 is marked complete cookie 8 is assumed complete too...

Completion is always in order unless we specify DMA_COMPLETION_NO_ORDER

> +convenience the following utility functions are available to create
> +monotonically increasing cookies
> +
> +  .. code-block:: c
> +
> +    void dma_cookie_init(struct dma_chan *chan);
> +
> +  Called once at channel creation
> +
> +  .. code-block:: c
> +
> +    dma_cookie_t dma_cookie_assign(struct dma_async_tx_descriptor *tx);
> +
> +  Assign a cookie to the given descriptor
> +
> +  .. code-block:: c
> +
> +    void dma_cookie_complete(struct dma_async_tx_descriptor *tx);
> +
> +  Mark the descriptor as complete and invalidate the cookie
> +
> +  .. code-block:: c
> +
> +    enum dma_status dma_cookie_status(struct dma_chan *chan,
> +      dma_cookie_t cookie, struct dma_tx_state *state);
> +
> +  Report the status of the cookie and filling in state, if not NULL.
> +
>  
>  Misc notes
>  ==========
> @@ -537,13 +573,6 @@ where to put them)
>  - Makes sure that dependent operations are run before marking it
>    as complete.
>  
> -dma_cookie_t
> -
> -- it's a DMA transaction ID.
> -
> -- The value can be chosen by the provider, or use the helper APIs
> -  such as dma_cookie_assign() and dma_cookie_complete().
> -
>  DMA_CTRL_ACK
>  
>  - If clear, the descriptor cannot be reused by provider until the
> -- 
> 2.37.1

-- 
~Vinod
