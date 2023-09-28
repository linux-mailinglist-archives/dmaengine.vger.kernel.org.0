Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1CEB7B1558
	for <lists+dmaengine@lfdr.de>; Thu, 28 Sep 2023 09:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbjI1Huq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 Sep 2023 03:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbjI1Huq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 28 Sep 2023 03:50:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E2195;
        Thu, 28 Sep 2023 00:50:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DED51C433C7;
        Thu, 28 Sep 2023 07:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695887444;
        bh=FDCqZCAloUgFy83qeaM98dMcfkYWTD/rX6/C78mV2A0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WH0KmnRd2D2TDARyQf3rvTLFNsmRMEUX0BXIGJa1+u020hunr3zKtkKam7ihuK4YQ
         Z1rDLiTA/VTzyIVFzOOjcUSAyOQNC1phkLkdCIPRZRnEUYDT76ow0K2YUK/d0dkhBs
         ooZ1AWpwfvTPXtWux5t1o2sIxk7oBczVXC5kAqIhWb/AYxiitEQPQoORjObR0mZFQI
         M9ZqyP9kcjzE7YtwjAC+cmioUxjpbgRQEma7U50VHay5IlWncl3VtQ1Igh2u+/3gJ2
         qZQbxfXtPMZM54mMpkRVdJmmhH0t27CVtj/aeUY2lxmLcNMqzw/kqGg2Nskqht5P2o
         WwKK6ZwH6/hfw==
Date:   Thu, 28 Sep 2023 13:20:40 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Siddharth Vadapalli <s-vadapalli@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        MD Danish Anwar <danishanwar@ti.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 3/3 net] dmaengine: ti: k3-udma-glue: clean up
 k3_udma_glue_tx_get_irq() return
Message-ID: <ZRUwUBRvs+bkfOgW@matsya>
References: <4c2073cc-e7ef-4f16-9655-1a46cfed9fe9@moroto.mountain>
 <bf2cee83-ca8d-4d95-9e83-843a2ad63959@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf2cee83-ca8d-4d95-9e83-843a2ad63959@moroto.mountain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 26-09-23, 17:06, Dan Carpenter wrote:
> The k3_udma_glue_tx_get_irq() function currently returns negative error
> codes on error, zero on error and positive values for success.  This
> complicates life for the callers who need to propagate the error code.
> Also GCC will not warn about unsigned comparisons when you check:
> 
> 	if (unsigned_irq <= 0)
> 
> All the callers have been fixed now but let's just make this easy going
> forward.

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
