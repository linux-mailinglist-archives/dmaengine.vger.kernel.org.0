Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E22AE581367
	for <lists+dmaengine@lfdr.de>; Tue, 26 Jul 2022 14:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233759AbiGZMvI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 26 Jul 2022 08:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232845AbiGZMvI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 26 Jul 2022 08:51:08 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02081D30E
        for <dmaengine@vger.kernel.org>; Tue, 26 Jul 2022 05:51:04 -0700 (PDT)
Received: from localhost (82-69-11-11.dsl.in-addr.zen.co.uk [82.69.11.11])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: alarumbe)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 69E176601B12;
        Tue, 26 Jul 2022 13:51:03 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658839863;
        bh=25ZgJko+8EFRSY1f5ucufZjjU3v6jCPjdSYaUE4QFJ4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j0OZnSGc45od1xoJt1gLHLvfCaQpzyfW/an0aelI7/dYcGI0stFsnriE1jcmlnrbz
         rC4kExRaTyNdCRH9ePhhELGzdyxyjTB+JhPSF1wOT7eM45K+//1uizgRE56KZqhiA3
         mJbAbQaYGtd6FZDiBMSNHvG2Kmcmr+w6cSuP7Ng0DAsQflLVqXrPzCP6tR3Ec1GXlL
         RDqviUvdo1wyg2jtEQMxlA5qI/9XNQJiFLAojA+IswMELFnBkmefIicbX9zAfyQmS0
         WWaEN3vsQoGw7Jib3uTvkBjTot9ndZuUBcZmEGOnCqC3pLWmytbo3vFWbGtSjrGPhh
         uWqPfUIxiZE6g==
Date:   Tue, 26 Jul 2022 13:51:01 +0100
From:   Adrian Larumbe <adrian.larumbe@collabora.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: Remove DMA_MEMCPY_SG operation as it has no
 consumers
Message-ID: <20220726125101.k6drrb6tfcwfityc@sobremesa>
References: <20220726094323.566140-1-adrian.larumbe@collabora.com>
 <Yt/dyVXRQ3vxzufo@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yt/dyVXRQ3vxzufo@matsya>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 26.07.2022 17:57, Vinod Koul wrote:
>On 26-07-22, 10:43, Adrian Larumbe wrote:
>> There are no in kernel consumers for DMA_MEMCPY_SG. Remove operation and
>> Xilinx CDMA driver code which implemented it.
>
>What was this based on?

dmaengine/master

>> This reverts the following commits:
>
>Did you see 0cae04373b77 ("dmaengine: remove DMA_MEMCPY_SG once again")

Just saw it, nevermind then.

Adrian Larumbe
