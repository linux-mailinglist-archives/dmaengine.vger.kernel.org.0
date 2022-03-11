Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC0B4D5BD4
	for <lists+dmaengine@lfdr.de>; Fri, 11 Mar 2022 08:01:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346883AbiCKHCn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 11 Mar 2022 02:02:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234827AbiCKHCm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 11 Mar 2022 02:02:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41891AA06E;
        Thu, 10 Mar 2022 23:01:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A48C5B82AD4;
        Fri, 11 Mar 2022 07:01:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3477C340F3;
        Fri, 11 Mar 2022 07:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646982097;
        bh=/4vnjn5RwhbcjWbYXTzLNs+qC04kmYyhxk9ctOJ1UXc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sIKU+po8/qLj/4v+d9bHl5BBH82TRkZneN6sjqrM4TkgRTs4xA12sL/40SY20XgY4
         TdGH6jvAsEWRVVTucSRo9UKio5b9aDj8/s0pK0okemIK9OC0xQIF+4HTghCUqmYOG4
         kvPxWjslO4FNRONWdGbr8v1BeO8zQNDEV0xO5BEjjeNWiVwhcUy74vHzM+NGTTVuJh
         Vf6fl02Xre2go6Xme5xtrUelZouK3JVP/oyMUcyN0WQG8DcEW33+Y8RbN/C9nm3NPi
         XHhtBb06JBudac5jDKe1b/ZFD58pjQXxbQwv4I+QbRt3h7L7yGGupZhaN88bUdnawW
         piPEe54w9FIKA==
Date:   Fri, 11 Mar 2022 12:31:33 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     trix@redhat.com
Cc:     peter.ujfalusi@gmail.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma: ti: cleanup comments
Message-ID: <YirzzUL6ueFDCL7I@matsya>
References: <20220217182546.3266909-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217182546.3266909-1-trix@redhat.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 17-02-22, 10:25, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> Remove the second 'the'
> 
> Replacements
> completetion to completion
> seens to seen
> pendling to pending
> atleast to at least
> tranfer to transfer
> multibple to a multiple
> transfering to transferring

Applied, thanks

-- 
~Vinod
