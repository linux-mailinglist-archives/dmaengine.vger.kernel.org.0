Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4461A50B168
	for <lists+dmaengine@lfdr.de>; Fri, 22 Apr 2022 09:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444807AbiDVH3u (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 22 Apr 2022 03:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241347AbiDVH3s (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 22 Apr 2022 03:29:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4A450456;
        Fri, 22 Apr 2022 00:26:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9B0CBB82A89;
        Fri, 22 Apr 2022 07:26:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB6FEC385A0;
        Fri, 22 Apr 2022 07:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650612413;
        bh=8DAigWYGNyU0r2gEJ6nTrSLjjq33DLSFxok7TZ9V1JQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K9hJ8KegjOYNQHdCNCs8ADQuOalbo8HDW9+EGePILQtDgDVzMQQkL7z2pkFEEc/eC
         xYuSFRf/5VVTxn/q8WiNlygCXOzsB5+nYL0if57asM+hkioxTrVtNMpghDxHM64KpM
         mMfgcYcDwYanlEciwfsaREs0zNQcNutTnrEyk4gbqXYMKN/KPMAZkd/Bf46I+xcoF9
         Iu9+NM8ZLhZGll9F6qM/y89nWE9DQaCbV1ZtCZqx5YZeyvpptS6WpNII4iuZ/PsZK1
         yG0PnaxMR87ondqP4Q7v0vTaMT6UUmKA5bDyVNLRkv6Ko5D5U0mSEvv4tSbiluZNAR
         Dh4IvK0epIcRQ==
Date:   Fri, 22 Apr 2022 12:56:49 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Yunbo Yu <yuyunbo519@gmail.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dmaengine: mv_xor_v2 : Move spin_lock_bh() to
 spin_lock()
Message-ID: <YmJYub0UNVbGYeyz@matsya>
References: <20220420122754.148359-1-yuyunbo519@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420122754.148359-1-yuyunbo519@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 20-04-22, 20:27, Yunbo Yu wrote:
> It is unnecessary to call spin_lock_bh() for that you are already
> in a tasklet.

Applied, thanks

-- 
~Vinod
