Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F437AF337
	for <lists+dmaengine@lfdr.de>; Tue, 26 Sep 2023 20:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235592AbjIZSqq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 26 Sep 2023 14:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235589AbjIZSqp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 26 Sep 2023 14:46:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DCF112A;
        Tue, 26 Sep 2023 11:46:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B671C433C7;
        Tue, 26 Sep 2023 18:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695753998;
        bh=JeFbJjBuiWqHajB2OML6o8/9pmtv943NTonB+AQX8v4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=gEo+Ife9EEML8hYya7/d5WJJk0piYWiCSaT3uEJirFWHAlVGdq3taRtwDsf2Emf9b
         8wuhsRtZN2V+sV5/4z051PfHRgJZqZYHr07VeXquj+jFjtpjBKMzeuhSXQLQhlIrSe
         p3IhjrJ0x7h5d+fj4zVKBfs3CDM6tI+tmHAILSXEi6g1YFAGeBlI4xsxHecAZfx3ca
         BXXtOfflBUCSPbZgXcoLUctPU+Ia+p7pzwj9WYPR6/31BMrGX/drw6YzolJfSi6GXs
         wmkJEsehnzKdU/6qABFD9SscqyEIJg7zgqkerP/3tXhbBD8EK9F6XFBVjUFN36cu34
         gpky+A/MTz1RA==
Message-ID: <df8ac3ef-6103-4499-a52e-d0f4fdfbad05@kernel.org>
Date:   Tue, 26 Sep 2023 21:46:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3 net] dmaengine: ti: k3-udma-glue: clean up
 k3_udma_glue_tx_get_irq() return
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@linaro.org>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Siddharth Vadapalli <s-vadapalli@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        MD Danish Anwar <danishanwar@ti.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <bf2cee83-ca8d-4d95-9e83-843a2ad63959@moroto.mountain>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <bf2cee83-ca8d-4d95-9e83-843a2ad63959@moroto.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 26/09/2023 17:06, Dan Carpenter wrote:
> The k3_udma_glue_tx_get_irq() function currently returns negative error
> codes on error, zero on error and positive values for success.  This
> complicates life for the callers who need to propagate the error code.
> Also GCC will not warn about unsigned comparisons when you check:
> 
> 	if (unsigned_irq <= 0)
> 
> All the callers have been fixed now but let's just make this easy going
> forward.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Roger Quadros <rogerq@kernel.org>
