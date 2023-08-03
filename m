Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 947F276E6FA
	for <lists+dmaengine@lfdr.de>; Thu,  3 Aug 2023 13:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjHCLed (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 3 Aug 2023 07:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234239AbjHCLec (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 3 Aug 2023 07:34:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FAA1272A;
        Thu,  3 Aug 2023 04:34:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD38A61D4C;
        Thu,  3 Aug 2023 11:34:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 744D9C433C7;
        Thu,  3 Aug 2023 11:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691062467;
        bh=BkBCAVO6hJF4fOYI49LffKk6yX883oqjF0w8sTjILWc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PCN4VOz3vZBLDraC13sTD64yaF6fph11RxQKvykMl4hCLeo/Mp2kdRAiZpOEW6ZJt
         J4yjrfMabuFRB3KQoiVcRr16WjNMUeKHSwU4FLnZKXlLW0GaqecUIb5A+4RrorDIj9
         01z9y4b+Q3EtGsQ40QacmNiqyNppnNNkW6augIuTjLAqvLDDECY17WYR20sdLSKOmq
         ts7l3E/hFl6cd3KIULc0UrO26H8ilbCBpVJf2ntUJx5BAYfNMDiHvx/+9clYABGBAr
         K3E6tdhOWqQMkJCElhHOMXMkpTra8qDHfvk7H6ibRO6HsGcq5MUD0Now1l1YP3GbTb
         c4N8uTN4J8Kyg==
Date:   Thu, 3 Aug 2023 17:04:22 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, asahi@lists.linux.dev,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dmaengine: apple-sio: Add Apple SIO driver
Message-ID: <ZMuQvhIg0AHH2e7V@matsya>
References: <20230712133806.4450-1-povik+lin@cutebit.org>
 <20230712133806.4450-3-povik+lin@cutebit.org>
 <ZMlLjg9UBi3QO/qV@matsya>
 <7D43A9F3-892C-4E74-9618-DB37360B7641@cutebit.org>
 <38B71067-7D67-41B7-BF49-87511BAA06CF@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <38B71067-7D67-41B7-BF49-87511BAA06CF@cutebit.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 03-08-23, 10:32, Martin Povišer wrote:

> >>> +static int sio_alloc_tag(struct sio_data *sio)
> >>> +{
> >>> +	struct sio_tagdata *tags = &sio->tags;
> >>> +	int tag, i;
> >>> +
> >>> +	/*
> >>> +	 * Because tag number 0 is special, the usable tag range
> >>> +	 * is 1...(SIO_NTAGS - 1). So, to pick the next usable tag,
> >>> +	 * we do modulo (SIO_NTAGS - 1) *then* plus one.
> >>> +	 */
> >>> +
> >>> +#define SIO_USABLE_TAGS (SIO_NTAGS - 1)
> >>> +	tag = (READ_ONCE(tags->last_tag) % SIO_USABLE_TAGS) + 1;
> >>> +
> >>> +	for (i = 0; i < SIO_USABLE_TAGS; i++) {
> >>> +		if (!test_and_set_bit(tag, &tags->allocated))
> >>> +			break;
> >>> +
> >>> +		tag = (tag % SIO_USABLE_TAGS) + 1;
> >>> +	}
> >>> +
> >>> +	WRITE_ONCE(tags->last_tag, tag);
> >>> +
> >>> +	if (i < SIO_USABLE_TAGS)
> >>> +		return tag;
> >>> +	else
> >>> +		return -EBUSY;
> >>> +#undef SIO_USABLE_TAGS
> >>> +}
> >> 
> >> can you use kernel mechanisms like ida to alloc and free the tags...
> > 
> > I can look into that.
> 
> Documentation says IDA is deprecated in favour of Xarray, both look
> like they serve to associate a pointer with an ID. I think neither
> structure beats a simple bitfield and a static array for the per-tag
> data. Agree?

yeah xarray am not too sure. I would still go with ida, we will see when
it is relly removed.

If you need a bitfield why not use bitmap apis.
I dont like drivers implementing the basic logic which kernel provides

-- 
~Vinod
