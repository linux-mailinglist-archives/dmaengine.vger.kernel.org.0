Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9F470ED54
	for <lists+dmaengine@lfdr.de>; Wed, 24 May 2023 07:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbjEXFuo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 May 2023 01:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232367AbjEXFun (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 24 May 2023 01:50:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991B6C1;
        Tue, 23 May 2023 22:50:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 376416390B;
        Wed, 24 May 2023 05:50:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B25CC433EF;
        Wed, 24 May 2023 05:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684907441;
        bh=vAvsTqmFgX+Q9gy81xNfCHJ2KmDSr99InLcdIwbLKSc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Eq11SVVaNdlCHVnN/JmVpX/xHvNd0GJCPkLRe0RFtk05cpgAOYkvXgXh+U8vF/aZX
         oGBPJluzUzStJ6Jib1FQgUlKy19AqTq3IEiXuwstI2L7wc+e6nDz2SZ5poMOIPHcvi
         GzeJW6XBxh98TuYr5257MRw6uMQubANrMqmzm2G4Hr8j7cAFcNiCw5LxWxRrgcHbyR
         gLcy5sJN1y/zHOUOu76jtTvSfFSb+YLMRr/ayEIEQsBGsN1Nq/TP6za2DRuL1ZoyaD
         46VFrMAP6B8fd9rq1b3fjR/UhChP7mSCK/3NQxQOwaPBO8kkXjfkvDVGTN9fOf5ps2
         et2PG7qvjWygw==
Date:   Wed, 24 May 2023 11:20:37 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Rosin <peda@axentia.se>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] dmaengine: at_hdmac: Regression fix and cleanup
Message-ID: <ZG2lrVWxsR0pGhtC@matsya>
References: <221d19e2-6b92-7f38-7d8a-a730f54c33ea@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <221d19e2-6b92-7f38-7d8a-a730f54c33ea@axentia.se>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 23-05-23, 19:19, Peter Rosin wrote:
> Hi!
> 
> I found a regression in DMA handling on one of our SAMA5D3 boards.
> 
> While combing through the regressing commit, a found two unrelated
> strange things. The first is the actually problematic change. The
> second is a number of suspect defines, that I fail to see how they
> can ever do any good.

Applied, thanks

-- 
~Vinod
