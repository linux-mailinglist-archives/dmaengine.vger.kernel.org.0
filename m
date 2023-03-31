Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42FE06D1F7D
	for <lists+dmaengine@lfdr.de>; Fri, 31 Mar 2023 13:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjCaLxW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 31 Mar 2023 07:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbjCaLxV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 31 Mar 2023 07:53:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B1C12CD2;
        Fri, 31 Mar 2023 04:53:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3F355B82EC1;
        Fri, 31 Mar 2023 11:53:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59C69C433EF;
        Fri, 31 Mar 2023 11:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680263597;
        bh=hhd9nbbSJ5RTG1k98hUY9XQbJXehPQvw/S7adZu0qHM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cN/o1EkNaMPJceihagehs5ghNOVUaMPhLLNIvRdkABKEFgvSZnN1zyLDYeLldU/53
         /VDlFdBkp9EebsFMLa81R6ebJly/VsWcyIBYEMDEGxQqBmafUltWxoN5xkUt5H66vm
         SaINmpFr3eN/aMNqGNOd2GKkupJC569U+90APOJSjY/4jfOhvwqu9lvuLpwrHm2ZOA
         Q7Z6BsP4iBx+Uw81YFIsLplIQlh9NFHj8WF1ZZ8OZGMe4dK0mXYMznAOTV42KOAPFj
         Jm9Ov7p438Lp6eNT3rIoHTdH9anSJdnKOizY5ecxvpElh1t7NBBVKbe5oJgtyXD89E
         qLsUeWFuFNXqg==
Date:   Fri, 31 Mar 2023 17:23:13 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Rob Herring <robh@kernel.org>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH 1/2] dmaengine: mv_xor_v2: Fix an error code.
Message-ID: <ZCbJqfUtP0YeueF8@matsya>
References: <201170dff832a3c496d125772e10070cd834ebf2.1679814350.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201170dff832a3c496d125772e10070cd834ebf2.1679814350.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 26-03-23, 09:06, Christophe JAILLET wrote:
> If the probe is deferred, -EPROBE_DEFER should be returned, not
> +EPROBE_DEFER.

Applied both, thanks

-- 
~Vinod
