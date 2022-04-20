Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C608A508855
	for <lists+dmaengine@lfdr.de>; Wed, 20 Apr 2022 14:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244439AbiDTMnV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Apr 2022 08:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378728AbiDTMnH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 20 Apr 2022 08:43:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF6D14013;
        Wed, 20 Apr 2022 05:40:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD9EE6197E;
        Wed, 20 Apr 2022 12:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F5F1C385A0;
        Wed, 20 Apr 2022 12:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650458421;
        bh=XbbsN13otZbTzcITveCVrOxBJa3FapvrEzy91rjQNTQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EH2GkKifMitUEqaiV1rvoHFuHtGkCZB1bDG2etxeVBDc0lEDQlxRynu9lkkNCbUPM
         cGou1blo8GSRWOrp4yOcvrLZ4iPO8rXGMx+81QKhkQlB+6iVDil0YxM8IyCsda3J8L
         uTN7Byobs+HOcQSJIkQbkbnpRj6MAk8U8le+DNPnXqh6XtAR8o/kSqOUyPEHIKvTK3
         sBKsgTL+Ytk5Eow0mfN8xJ7l6UhdGDgcllDwCOYbmLX4IiYVWr0PQ3EHmOmoahLfxv
         2bYrHEwTbSPYwLDea3IRSKcwEbD4r/PRPY7tW2wrOt02jZBeKBfBBmq2zJG/DJDsMr
         v3XbkcUJsxzMQ==
Date:   Wed, 20 Apr 2022 18:10:16 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Kettenis <kettenis@openbsd.org>
Subject: Re: [PATCH v2 2/2] dmaengine: apple-admac: Add Apple ADMAC driver
Message-ID: <Yl//MF1MeUFE6N4y@matsya>
References: <20220411222204.96860-1-povik+lin@cutebit.org>
 <20220411222204.96860-3-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220411222204.96860-3-povik+lin@cutebit.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 12-04-22, 00:22, Martin Povišer wrote:

> +struct admac_chan {
> +	int no;

Unsigned int perhaps?

> +static int admac_desc_free(struct dma_async_tx_descriptor *tx)
> +{
> +	struct admac_tx *adtx = to_admac_tx(tx);
> +
> +	devm_kfree(to_admac_chan(tx->chan)->host->dev, adtx);

Why use devm for descriptor memory?

> +static int admac_device_config(struct dma_chan *chan,
> +			       struct dma_slave_config *config)
> +{
> +	struct admac_chan *adchan = to_admac_chan(chan);
> +	struct admac_data *ad = adchan->host;
> +	bool is_tx = admac_chan_direction(adchan->no) == DMA_MEM_TO_DEV;

so are the channel directions hard wired in hardware?

-- 
~Vinod
