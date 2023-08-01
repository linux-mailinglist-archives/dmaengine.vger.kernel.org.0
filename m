Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD31B76BC18
	for <lists+dmaengine@lfdr.de>; Tue,  1 Aug 2023 20:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbjHASOq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 1 Aug 2023 14:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbjHASOp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 1 Aug 2023 14:14:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659701724;
        Tue,  1 Aug 2023 11:14:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E6E2C6166F;
        Tue,  1 Aug 2023 18:14:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9273CC433C8;
        Tue,  1 Aug 2023 18:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690913682;
        bh=LGldI8xCzG+/NgQzVjLKjdG/7h/Dszwve+qs5ujXVF8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TCsELIIPVi+kTn2SFKo2ob8zx4LDQ4kyn3/ZvcLP+nzaA4m954+qkkzXput8dsDFg
         hUNZylYmMCYLt0lnq7C9rCJGKXbUY38JnYxWqxp1AhTOFvORUgW1kc9CtX6a98AEYZ
         Q3/c4U7TI1q5g+yxwD/cEbxbS2VTBLrPgdclbK5ERzUSaXYwZafjWmZWmwP6+vk5xP
         PpaSnAZH1ALyJhi4MjCBgVF2Q1bX4shrGc8RhmIX80CaJnCCLTVH48qhLvflO+iA8Y
         TOUoklQJ721XRJnWei/eP9Gd1883n/WCz0kF41J+abxdrP/adlakA6GeZLefc+V9BW
         2HPu5Ju3/MS2w==
Date:   Tue, 1 Aug 2023 23:44:38 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, asahi@lists.linux.dev,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dmaengine: apple-sio: Add Apple SIO driver
Message-ID: <ZMlLjg9UBi3QO/qV@matsya>
References: <20230712133806.4450-1-povik+lin@cutebit.org>
 <20230712133806.4450-3-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230712133806.4450-3-povik+lin@cutebit.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 12-07-23, 15:38, Martin Povišer wrote:

> +struct sio_chan {
> +	unsigned int no;
> +	struct sio_data *host;
> +	struct dma_chan chan;
> +	struct tasklet_struct tasklet;
> +	struct work_struct terminate_wq;
> +
> +	spinlock_t lock;
> +	struct sio_tx *current_tx;
> +	/*
> +	 * 'tx_cookie' is used for distinguishing between transactions from
> +	 * within tag ack/nack callbacks. Without it, we would have no way
> +	 * of knowing if the current transaction is the one the callback handler
> +	 * was installed for.

not sure what you mean by here.. I dont see why you would need to store
cookie here, care to explain?

> +	 */
> +	unsigned long tx_cookie;
> +	int nperiod_acks;
> +
> +	/*
> +	 * We maintain a 'submitted' and 'issued' list mainly for interface
> +	 * correctness. Typical use of the driver (per channel) will be
> +	 * prepping, submitting and issuing a single cyclic transaction which
> +	 * will stay current until terminate_all is called.
> +	 */
> +	struct list_head submitted;
> +	struct list_head issued;
> +
> +	struct list_head to_free;

can you use virt_dma_chan, that should simplify list handling etc

> +};
> +
> +#define SIO_NTAGS		16
> +
> +typedef void (*sio_ack_callback)(struct sio_chan *, void *, bool);

any reason not to use dmaengine callbacks?

> +static int sio_alloc_tag(struct sio_data *sio)
> +{
> +	struct sio_tagdata *tags = &sio->tags;
> +	int tag, i;
> +
> +	/*
> +	 * Because tag number 0 is special, the usable tag range
> +	 * is 1...(SIO_NTAGS - 1). So, to pick the next usable tag,
> +	 * we do modulo (SIO_NTAGS - 1) *then* plus one.
> +	 */
> +
> +#define SIO_USABLE_TAGS (SIO_NTAGS - 1)
> +	tag = (READ_ONCE(tags->last_tag) % SIO_USABLE_TAGS) + 1;
> +
> +	for (i = 0; i < SIO_USABLE_TAGS; i++) {
> +		if (!test_and_set_bit(tag, &tags->allocated))
> +			break;
> +
> +		tag = (tag % SIO_USABLE_TAGS) + 1;
> +	}
> +
> +	WRITE_ONCE(tags->last_tag, tag);
> +
> +	if (i < SIO_USABLE_TAGS)
> +		return tag;
> +	else
> +		return -EBUSY;
> +#undef SIO_USABLE_TAGS
> +}

can you use kernel mechanisms like ida to alloc and free the tags...

> +static struct dma_async_tx_descriptor *sio_prep_dma_cyclic(
> +		struct dma_chan *chan, dma_addr_t buf_addr, size_t buf_len,
> +		size_t period_len, enum dma_transfer_direction direction,
> +		unsigned long flags)
> +{
> +	struct sio_chan *siochan = to_sio_chan(chan);
> +	struct sio_tx *siotx = NULL;
> +	int i, nperiods = buf_len / period_len;
> +
> +	if (direction != sio_chan_direction(siochan->no))
> +		return NULL;
> +
> +	siotx = kzalloc(struct_size(siotx, siodesc, nperiods), GFP_NOWAIT);
> +	if (!siotx)
> +		return NULL;
> +
> +	init_completion(&siotx->done);
> +	dma_async_tx_descriptor_init(&siotx->tx, chan);
> +	siotx->period_len = period_len;
> +	siotx->nperiods = nperiods;
> +
> +	for (i = 0; i < nperiods; i++) {
> +		struct sio_coproc_desc *d;
> +
> +		siotx->siodesc[i] = d = sio_alloc_desc(siochan->host);
> +		if (!d) {
> +			sio_tx_free(&siotx->tx);
> +			return NULL;
> +		}
> +
> +		d->flag = 1; // not sure what's up with this
> +		d->iova = buf_addr + period_len * i;
> +		d->size = period_len;
> +	}
> +	dma_wmb();

why use barrier here? and to what purpose..

-- 
~Vinod
