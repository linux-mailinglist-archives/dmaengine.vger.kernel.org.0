Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC24B70DEC8
	for <lists+dmaengine@lfdr.de>; Tue, 23 May 2023 16:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237230AbjEWOKo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 23 May 2023 10:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237240AbjEWOK0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 23 May 2023 10:10:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3995138;
        Tue, 23 May 2023 07:09:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3CD43618D5;
        Tue, 23 May 2023 14:09:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1F3DC4339E;
        Tue, 23 May 2023 14:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684850942;
        bh=35t9saet70NVn/nZc1z7s+Djje/zdpytl46XmhUm/Zk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h3/6BK+IC9LETj04oeUZbTelqXTCkzVFzyto2ZYFzt+Zit+sWzRtyRQDoDUi/1mt8
         jGipWZtklYaxIRvpdyeThyaE7pPKqMILFeVAp9HHDp78rThJauopEnnRQXjR8WiTg5
         N98m/bzHQiBBheD40ESx6Ryf7tl9dL3sNGwKhkBuh14MBDxfvtt7m6c7eiJ7bzdGWK
         7LybT59zL9qUTmMchtSgXrCj+Z8jNlgGFbhRkDHgqH3ThAR48Z2EuqkoSgHKc3bQE2
         QaO5uj8g9xCV/iTq46w1zcxcfU5rrwMqKfKzeqwlvpi0N34elpuqwOvOrqOuG3pQQ9
         GMJcl+kgtvuRQ==
Date:   Tue, 23 May 2023 19:38:58 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Jaswinder Singh <jassisinghbrar@gmail.com>,
        Jaswinder Singh <jassi.brar@samsung.com>,
        Boojin Kim <boojin.kim@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        dmaengine@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] dmaengine: pl330: rename _start to prevent build error
Message-ID: <ZGzI+gsYdF6kEHFk@matsya>
References: <20230523000606.9405-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523000606.9405-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 22-05-23, 17:06, Randy Dunlap wrote:
> "_start" is used in several arches and proably should be reserved
> for ARCH usage. Using it in a driver for a private symbol can cause
> a build error when it conflicts with ARCH usage of the same symbol.
> 
> Therefore rename pl330's "_start" to "_start_thread" so that there
> is no conflict and no build error.

Why not rename to pl330_start or pl330_start_thread to ensure we will
might not conflict ever!

-- 
~Vinod
