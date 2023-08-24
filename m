Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0979F78647D
	for <lists+dmaengine@lfdr.de>; Thu, 24 Aug 2023 03:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234603AbjHXBKs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 23 Aug 2023 21:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbjHXBKQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 23 Aug 2023 21:10:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A2710DD;
        Wed, 23 Aug 2023 18:10:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AEFE462B69;
        Thu, 24 Aug 2023 01:10:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B590C433C7;
        Thu, 24 Aug 2023 01:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692839414;
        bh=ezjID3PxHGUATbcnhrCju3Zulnrv6a9vUszI0YdyQuc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pLbShbiAkSkOfESCpTZgmK5Mx1+fsem5sr6qt2cDT3RC+CO64Ib4Pn1JDd2vivEWo
         WTRm2/H1B/EYz9faHgdgRixoGQVtg5LJ7Dw7Sv7VA/vujv1dRND1fT0fwUNC8rcyio
         TdAB5/KvA9B78u28gy0bquEBI385CxD9enBCm4D/GURLmJ38ZN37V3vejgYX68pbYI
         8zvIQp++fPxZAaQ7TADUx1oJxUj4tfvargtQHA43GXqxiONwFcCCrmrcZB+bkGjSqx
         BSIm9LXf8UoFZTt5mlQsegsmjDP7sBT2Bu1Ari5mDJYjxNueyfIvavdTqfZNup6WbK
         p/cz/GxwlTwAA==
Date:   Wed, 23 Aug 2023 18:10:12 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
Cc:     "vkoul@kernel.org" <vkoul@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "Simek, Michal" <michal.simek@amd.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "git (AMD-Xilinx)" <git@amd.com>
Subject: Re: [PATCH net-next v5 10/10] net: axienet: Introduce dmaengine
 support
Message-ID: <20230823181012.0a46d96a@kernel.org>
In-Reply-To: <MN0PR12MB5953AC3094F6BC7190266104B71CA@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <1691387509-2113129-1-git-send-email-radhey.shyam.pandey@amd.com>
        <1691387509-2113129-11-git-send-email-radhey.shyam.pandey@amd.com>
        <20230808154853.0fafa7fc@kernel.org>
        <MN0PR12MB5953A9FEC556D07494DB8E37B711A@MN0PR12MB5953.namprd12.prod.outlook.com>
        <20230814082953.747791ff@kernel.org>
        <MN0PR12MB5953AC3094F6BC7190266104B71CA@MN0PR12MB5953.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, 23 Aug 2023 17:38:58 +0000 Pandey, Radhey Shyam wrote:
> > The kmemcache is not the worst possible option but note that the
> > objects you're allocating (with zeroing) are 512+ bytes. That's
> > pretty large, when most packets will not have full 16 fragments.
> > Ring buffer would allow to better match the allocation size to
> > the packets. Not to mention that it can be done fully locklessly.  
> 
> I modified the implementation to use a circular ring buffer for TX
> and RX. It seems to be working in initial testing and now running 
> perf tests.
> 
> Just had one question on when to submit v6 ? Wait till dmaengine
> patches([01/10-[07/10] is part of net-next? Or can I send it now also.

Assuming Linus cuts final this Sunday - after Sept 10th.
