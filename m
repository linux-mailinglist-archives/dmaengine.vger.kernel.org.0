Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80FA5657353
	for <lists+dmaengine@lfdr.de>; Wed, 28 Dec 2022 07:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbiL1Ghz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Dec 2022 01:37:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbiL1Gh1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 28 Dec 2022 01:37:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C593DFDE;
        Tue, 27 Dec 2022 22:37:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD7256129E;
        Wed, 28 Dec 2022 06:37:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CFB9C433EF;
        Wed, 28 Dec 2022 06:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672209444;
        bh=UmeElRBv90Ok40JFFOTcInePA4Rg+1XS9aiEoizOkRU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o/F1QqGGuLBwV6bl84ASMHdNNq4TK2ZfeGaHgZefNE71VigcYG4/MNA+/DppPTuyq
         KdBIOzqI/6bhrGnOAaQ2zFu+bt/8H+4OkdwgsLgKEP3vgq4HRoSTjEWm36Vcy9nrlt
         3203jJQCWs0TuWxjedXgcsdqYlGu5vmK4ZRHN6AOnF9UXmouDe5LZ8+qV+BTkj6IA+
         7m2QSS/G/Y7fyqs1qulu2VjdWMngssunID/grzkDQCJBrITTDHSp4Qy/W7JQYax5cF
         vkUTzNZwXWVEE6h/BOeS2OU9PbExCDhRbx/zVhRM6IDFr+pkc9xEQl6jt9fSVCMfBL
         FgYMdJQAFqS7A==
Date:   Wed, 28 Dec 2022 12:07:19 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 0/5] dmaengine: Add support for AM62A SoC DMAs
Message-ID: <Y6vkHz/SEdDNUXfd@matsya>
References: <20221213164304.1126945-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221213164304.1126945-1-vigneshr@ti.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 13-12-22, 22:12, Vignesh Raghavendra wrote:
> This series introduces support for various DMAs on TI's AM62A SoC under
> K3 family of devices.
> 
> Apart from usual BCDMA and PKTDMA thats present on K3 family, AM62A has
> a dedicated BCDMA for camera (CSI) with only RX DMA Channels.

Applied, thanks

-- 
~Vinod
