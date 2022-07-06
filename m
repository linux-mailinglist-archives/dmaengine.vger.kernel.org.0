Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48CFA567DDE
	for <lists+dmaengine@lfdr.de>; Wed,  6 Jul 2022 07:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbiGFFfV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 6 Jul 2022 01:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbiGFFfT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 6 Jul 2022 01:35:19 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9CB2181C;
        Tue,  5 Jul 2022 22:35:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 27BA4CE1E29;
        Wed,  6 Jul 2022 05:35:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90109C3411C;
        Wed,  6 Jul 2022 05:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657085710;
        bh=WAJQav4CJxb3BLVSymvhfwAW87uYuArozZLP8kv7s5I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=luJ+SWW58ynOE3bqUEdvVisZVkiXb7eNWybghbQD701HESskzz5wWZNkbmXZG24iO
         h/7H1wbA21xmaCHtYYfhQjy72cRzKCZFJbu4yR/Ar26TAS5k8jGab/kf/WtAJE02oJ
         FRzd3K1ryGyEfpJ/YIdbpAj4q7aFm+Jc2ZWl78YT9PB4Ai7Im6RPwCfFNRTXjWOkpp
         hf8QUg9XtAUF0kQB+69Zk5AiGwFwxW3/w/XY/0A85asMkB1fmnRXkgew1N99lxShjR
         vOanOecW7YDL4KHacbD/d9iy5Q1mk7xJ8DnwxMJpQeM8oIX82A0TSA8zKDWtnyb8L7
         2+8WnGR+uxULA==
Date:   Wed, 6 Jul 2022 11:05:05 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     XueBing Chen <chenxuebing@jari.cn>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: dmatest: use strscpy to replace strlcpy
Message-ID: <YsUfCaN6KknEAbtd@matsya>
References: <12e4cf06.a35.180fa748c29.Coremail.chenxuebing@jari.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12e4cf06.a35.180fa748c29.Coremail.chenxuebing@jari.cn>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 25-05-22, 17:03, XueBing Chen wrote:
> 
> The strlcpy should not be used because it doesn't limit the source
> length. Preferred is strscpy.

Applied, thanks

-- 
~Vinod
