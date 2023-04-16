Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA10B6E395B
	for <lists+dmaengine@lfdr.de>; Sun, 16 Apr 2023 16:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbjDPOhH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 16 Apr 2023 10:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjDPOhG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 16 Apr 2023 10:37:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FCFC30CA;
        Sun, 16 Apr 2023 07:37:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F1C760E15;
        Sun, 16 Apr 2023 14:37:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85AEFC433D2;
        Sun, 16 Apr 2023 14:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681655824;
        bh=xstw4Blo5PrTHnYU4m1zV2JUUOYTKT/DRqf2pSK/LVs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ONzu9qgmhYs4Fu4Dh02MbPA14WpAaWF1yq68JibN/u8UgSwW8TpSjfdiw/J55JNjz
         3NBdE1N4+LOSH+bpEg3lg2S1O9qBEPkugnbmRK+JrjNy2dKxlXQU9QSsOwFrgFHQA7
         k9xbUZNztK3czwpYSoOpSrJDN1VumCDOPZoXCTMq/4OplASmTJGJU8zmkdkl5eSTe7
         c9Ku5+DWfppK4XEopd8eHm1gaR4sXBXZM/7d/KxATlPdUmYCjTq06JYky9qf8THgWe
         aX7c20QkaOkyltltQbH4flXW0FrJqtW1uu1SowNEizMtXwrQETjKUN2aPgxmyFR/s+
         Fo6LeoQ19zI+A==
Date:   Sun, 16 Apr 2023 15:37:04 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Vinod Koul <vkoul@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        Alexandru Ardelean <ardeleanalex@gmail.com>
Subject: Re: [PATCH v3 06/11] iio: buffer-dmaengine: Enable write support
Message-ID: <20230416153704.35f5ff4d@jic23-huawei>
In-Reply-To: <20230403154800.215924-7-paul@crapouillou.net>
References: <20230403154800.215924-1-paul@crapouillou.net>
        <20230403154800.215924-7-paul@crapouillou.net>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon,  3 Apr 2023 17:47:55 +0200
Paul Cercueil <paul@crapouillou.net> wrote:

> Use the iio_dma_buffer_write() and iio_dma_buffer_space_available()
> functions provided by the buffer-dma core, to enable write support in
> the buffer-dmaengine code.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>
> ---
>  drivers/iio/buffer/industrialio-buffer-dmaengine.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> index 592d2aa9044c..866c8b84bb24 100644
> --- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> +++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> @@ -123,12 +123,14 @@ static void iio_dmaengine_buffer_release(struct iio_buffer *buf)
>  
>  static const struct iio_buffer_access_funcs iio_dmaengine_buffer_ops = {
>  	.read = iio_dma_buffer_read,
> +	.write = iio_dma_buffer_write,
>  	.set_bytes_per_datum = iio_dma_buffer_set_bytes_per_datum,
>  	.set_length = iio_dma_buffer_set_length,
>  	.request_update = iio_dma_buffer_request_update,
>  	.enable = iio_dma_buffer_enable,
>  	.disable = iio_dma_buffer_disable,
>  	.data_available = iio_dma_buffer_data_available,
> +	.space_available = iio_dma_buffer_space_available,
Follow through from earlier patch.  I would prefer it to be obvious
hers that the two callbacks above are identical.  Easiest way to
expose that detail is to set the callbacks to the same function, but then
it perhaps needs a rename so it isn't specific to one of the other.

Jonathan

>  	.release = iio_dmaengine_buffer_release,
>  
>  	.modes = INDIO_BUFFER_HARDWARE,

