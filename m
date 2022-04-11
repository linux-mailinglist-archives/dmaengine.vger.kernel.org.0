Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAEBD4FBDCC
	for <lists+dmaengine@lfdr.de>; Mon, 11 Apr 2022 15:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346738AbiDKNyW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 Apr 2022 09:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237887AbiDKNyV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 11 Apr 2022 09:54:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7020B237EC
        for <dmaengine@vger.kernel.org>; Mon, 11 Apr 2022 06:52:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C4A261198
        for <dmaengine@vger.kernel.org>; Mon, 11 Apr 2022 13:52:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEBA4C385A3;
        Mon, 11 Apr 2022 13:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649685126;
        bh=0mqKjRWK8wR9aLC0OpSdS6yI6rPSkY/3oBZOsBz57Fk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QkRtEZqa6IONL33fp3w9gLqjCwkWAMADHLU3EghnrApHHmTDSOfZ3Ko21swfBK9Bf
         TDxnoCpkb1dKharksZOQL7AuOwyueaP+73PrSt0KcS67XynuHWMkS5CJHE9QrXvqam
         yANMMUGkS6gM84XaEbwPpSkX8Kw+yc7dltGv5gmFWzWWPMrh/IvGLVSNoAmtEQi5fH
         BRulYrlwh7OT/4kZBPMt/6BXS+X44ArPOdu96o185D4JETJRbm7iOM80Mizx2mgDfR
         tn/i8SERgHokQk4NUybvJDv3kdeFLpz4gKx9Zh0x+yOUCFx12YqXQsLpuZ5RvlIH6A
         PwmbHRQbNtcqQ==
Date:   Mon, 11 Apr 2022 19:22:02 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: remove trailing white space on input
 str for wq name
Message-ID: <YlQyghKuFbWj0Dzb@matsya>
References: <164789525123.2799661.13795829125221129132.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164789525123.2799661.13795829125221129132.stgit@djiang5-desk3.ch.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 21-03-22, 13:40, Dave Jiang wrote:
> Add string processing with strim() in order to remove trailing white spaces
> that may be input by user for the wq->name.

Applied, thanks

-- 
~Vinod
