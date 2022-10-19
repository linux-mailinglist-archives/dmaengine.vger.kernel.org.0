Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8A7D604DD9
	for <lists+dmaengine@lfdr.de>; Wed, 19 Oct 2022 18:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbiJSQyd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 19 Oct 2022 12:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbiJSQy3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 19 Oct 2022 12:54:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B0B13CF8;
        Wed, 19 Oct 2022 09:54:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D171F61807;
        Wed, 19 Oct 2022 16:54:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDF26C433C1;
        Wed, 19 Oct 2022 16:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666198467;
        bh=d4/4ZD6s1YFUuLMYMvCceYt3Rwz2SkopjdmOR9YOlt4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oTCBjnY1yHKx7YZ4HVoRFrp8dQEWhpeuBS0LhH4MSRWvIqNTlMXaIBkx9vzQOjt5W
         JbrePAs2l0hoCcyO/5usfM4i65HQwsLKfnc50MJiUKQ3gM9W9xHTG4lOM9XoMC+9Wd
         BJv2UDTcI6qvg+8mEbJBW3/SEpbjtugB6JhUrAQCOvn7XAnXticnER9yIkWjd5RVvs
         ufNY5D3brnw1vI6+TcLYlPI6TJMUefOEzPXbP6EvyNplNoftFNj1tJOGPvr1PbywYC
         A05Gsz9397SKSIReEPYKDs4ZvMvn5Yx5pgaytJPU8JnUjF3owx/rgFVsd5XSGpxkLI
         sj5/0dQ1LUYUA==
Date:   Wed, 19 Oct 2022 22:24:23 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc:     asahi@lists.linux.dev, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dmaengine: apple-admac: Fix grabbing of channels
 in of_xlate
Message-ID: <Y1Arv9uJnKgyqA41@matsya>
References: <20221019132324.8585-1-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221019132324.8585-1-povik+lin@cutebit.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 19-10-22, 15:23, Martin Povišer wrote:
> The of_xlate callback is supposed to return the channel after already
> having 'grabbed' it for private use, so fill that in.

Applied both, thanks

-- 
~Vinod
