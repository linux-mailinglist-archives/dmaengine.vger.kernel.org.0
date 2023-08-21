Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC52E782A07
	for <lists+dmaengine@lfdr.de>; Mon, 21 Aug 2023 15:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235244AbjHUNLL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 21 Aug 2023 09:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbjHUNLL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 21 Aug 2023 09:11:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7E6F1;
        Mon, 21 Aug 2023 06:11:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D5FB635AA;
        Mon, 21 Aug 2023 13:11:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31450C433C7;
        Mon, 21 Aug 2023 13:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692623466;
        bh=JcjSJgA+kO+taEl9CzPKO96+/wFQLCjavvmjUHsUWLg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=awcZpnDQVa2PYKJPh2PJorDEGm6oOnoIYe89mjzw9u+3d77IUqHrdYEzUxEJQQ3pq
         xJPpuvWjpwtUETu97+4Ivae+vQqRmizbCFm5YtsxJUFvxNWWJWpgWVRltv3z8uEcQo
         vW+GWreYMtFHpeuu/uvS19xK3d2kuX59N8vv+oMmCGQJFWeZbQVMJCgUThwqljRV0u
         jxWpFwH6OUxtp4bIJgv067H8uC/WECo+I3Vnvn5EnfVJ6x8krPi60HX8wACgM5FNil
         c7v5MSvcBLK4XedmzWgNa7ehgGotjM+nmzB7pKLPg/RONSqUun+7Gm1Lap8KQmH0Td
         8rW3GUsyamumA==
Date:   Mon, 21 Aug 2023 18:41:02 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, michal.simek@amd.com, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com, linux@armlinux.org.uk,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, git@amd.com
Subject: Re: [PATCH net-next v5 00/10] net: axienet: Introduce dmaengine
Message-ID: <ZONiZq/qCqhfViqM@matsya>
References: <1691387509-2113129-1-git-send-email-radhey.shyam.pandey@amd.com>
 <20230808155315.2e68b95c@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808155315.2e68b95c@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 08-08-23, 15:53, Jakub Kicinski wrote:
> On Mon, 7 Aug 2023 11:21:39 +0530 Radhey Shyam Pandey wrote:
> > The axiethernet driver can use the dmaengine framework to communicate
> > with the xilinx DMAengine driver(AXIDMA, MCDMA). The inspiration behind
> > this dmaengine adoption is to reuse the in-kernel xilinx dma engine
> > driver[1] and remove redundant dma programming sequence[2] from the
> > ethernet driver. This simplifies the ethernet driver and also makes
> > it generic to be hooked to any complaint dma IP i.e AXIDMA, MCDMA
> > without any modification.
> > 
> > The dmaengine framework was extended for metadata API support during
> > the axidma RFC[3] discussion. However, it still needs further
> > enhancements to make it well suited for ethernet usecases.
> > 
> > Comments, suggestions, thoughts to implement remaining functional
> > features are very welcome!
> 
> Vinod, any preference on how this gets merged?
> Since we're already at -rc5 if the dmaengine parts look good to you 
> taking those in for 6.6 and delaying the networking bits until 6.7
> could be on the table? Possibly?

Yep, I am picking the dmaengine bits


-- 
~Vinod
