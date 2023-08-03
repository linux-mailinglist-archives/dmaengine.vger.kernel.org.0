Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498E176E9D1
	for <lists+dmaengine@lfdr.de>; Thu,  3 Aug 2023 15:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235903AbjHCNRF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 3 Aug 2023 09:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235867AbjHCNQx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 3 Aug 2023 09:16:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D3C49C7;
        Thu,  3 Aug 2023 06:16:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89BD060F1A;
        Thu,  3 Aug 2023 13:15:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 764C7C433C7;
        Thu,  3 Aug 2023 13:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691068559;
        bh=GQ8iSQkFOAUCjXyPwJ+EwM/9jgNut0kaWK62mC+Bikc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Izs/KJa7pC+uCc+pCox6I4FX5DgS9CKpDG4YYGoWA4Am+HQssXmWCyp1Pvh48JxNK
         2P3BV2rtLmrESTsHzM0n/sX4cX1IjqjBP/gqYEbKg4kvOhBmBVhVjsQgH2CFCIZcU7
         qMA6qu7a6kfULsi3UKdtu4NOcz2sgb+juntZNdQK+2mH4sKhYyKEgo2ONklqs+PrDN
         sZfoGdkbgvYiYft2A3RfsiFRJSni5Ut+bIXkwoRa/euMLL2CmnkoWCx86fQOlyupvd
         5EP1lHMpQhD7sQKt09PqOk5NmnC8v12RjzMWbZS5//v1e7BtdHmImA2PvdvjHHnYMl
         YqKjtiNvSxTxg==
Date:   Thu, 3 Aug 2023 18:45:55 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Tom Zanussi <tom.zanussi@linux.intel.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        fenghua.yu@intel.com, dave.jiang@intel.com, tony.luck@intel.com,
        wajdi.k.feghali@intel.com, james.guilford@intel.com,
        kanchana.p.sridhar@intel.com, vinodh.gopal@intel.com,
        giovanni.cabiddu@intel.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v8 03/14] dmaengine: idxd: Export drv_enable/disable and
 related functions
Message-ID: <ZMuoi8FycD28v084@matsya>
References: <20230731212939.1391453-1-tom.zanussi@linux.intel.com>
 <20230731212939.1391453-4-tom.zanussi@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731212939.1391453-4-tom.zanussi@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 31-07-23, 16:29, Tom Zanussi wrote:
> To allow idxd sub-drivers to enable and disable wqs, export them.
> 
> Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
> ---
>  drivers/dma/idxd/device.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
> index 5abbcc61c528..87ad95fa3f98 100644
> --- a/drivers/dma/idxd/device.c
> +++ b/drivers/dma/idxd/device.c
> @@ -1505,6 +1505,7 @@ int drv_enable_wq(struct idxd_wq *wq)
>  err:
>  	return rc;
>  }
> +EXPORT_SYMBOL_NS_GPL(drv_enable_wq, IDXD);

Sorry this is a very generic symbol, pls dont export it. I would make it
idxd_drv_enable_wq()

>  
>  void drv_disable_wq(struct idxd_wq *wq)
>  {
> @@ -1526,6 +1527,7 @@ void drv_disable_wq(struct idxd_wq *wq)
>  	wq->type = IDXD_WQT_NONE;
>  	wq->client_count = 0;
>  }
> +EXPORT_SYMBOL_NS_GPL(drv_disable_wq, IDXD);
>  
>  int idxd_device_drv_probe(struct idxd_dev *idxd_dev)
>  {
> -- 
> 2.34.1

-- 
~Vinod
