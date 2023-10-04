Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F68E7B8197
	for <lists+dmaengine@lfdr.de>; Wed,  4 Oct 2023 16:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242739AbjJDOBi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 4 Oct 2023 10:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242742AbjJDOBh (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 4 Oct 2023 10:01:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E801C0;
        Wed,  4 Oct 2023 07:01:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 055FFC433C8;
        Wed,  4 Oct 2023 14:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696428093;
        bh=y7A3aMRH9gnGrrmHxP5ejCSQJTaKPFDLh4HiX31OO6A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nQCGCOT/prT51SQtqAHiBuyvKyN9Wxp5LYAl51mmy8BAB4WUAsxqrLAP6jZ1SkO+1
         euZ5ZOZkKvNssZoE+1KTOXETop6Hsm3ijRrAIUUD3F7GRNxn4JH9MUo99rOY/mQh0Q
         5y+F3A04snyi9gANFaGwriFhAVhrzlbwaR4i594ML6tArJK5pkxncewQNm4dlFJQS1
         +bT7TYevXRVSe2gyTD7oF6WMDU5eMNN27g1hjf+G1fv6/1MWQhdGFLc5Bb4H7R12BY
         qVaLi/e8VgORs2C95jcf2TJM25KWGUc2hUBxi6eB5b8GHqiqffbSy0U90ufwqOVimr
         dwpuMk1ToLzjA==
Date:   Wed, 4 Oct 2023 19:31:29 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, asahi@lists.linux.dev,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] dmaengine: apple-sio: Add Apple SIO driver
Message-ID: <ZR1wOT7Gat/BiOr4@matsya>
References: <20230828170013.75820-1-povik+lin@cutebit.org>
 <20230828170013.75820-3-povik+lin@cutebit.org>
 <ZR1kz7Sil8onc1uC@matsya>
 <06444557-414A-4710-88A0-620975BB258A@cutebit.org>
 <ZR1smXBXyx7xDEmg@matsya>
 <C054722F-B1E0-4F4E-A45D-5F603738249C@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <C054722F-B1E0-4F4E-A45D-5F603738249C@cutebit.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 04-10-23, 15:52, Martin Povišer wrote:
> 
> > On 4. 10. 2023, at 15:46, Vinod Koul <vkoul@kernel.org> wrote:
> > 
> > On 04-10-23, 15:32, Martin Povišer wrote:
> > 
> >>>> + * There are two kinds of 'transaction descriptors' in play here.
> >>>> + *
> >>>> + * There's the struct sio_tx, and the struct dma_async_tx_descriptor embedded
> >>>> + * inside, which jointly represent a transaction to the dmaengine subsystem.
> >>>> + * At this time we only support those transactions to be cyclic.
> >>>> + *
> >>>> + * Then there are the coprocessor descriptors, which is what the coprocessor
> >>>> + * knows and understands. These don't seem to have a cyclic regime, so we can't
> >>>> + * map the dmaengine transaction on an exact coprocessor counterpart. Instead
> >>>> + * we continually queue up many coprocessor descriptors to implement a cyclic
> >>>> + * transaction.
> >>>> + *
> >>>> + * The number below is the maximum of how far ahead (how many) coprocessor
> >>>> + * descriptors we should be queuing up, per channel, for a cyclic transaction.
> >>>> + * Basically it's a made-up number.
> >>>> + */
> >>>> +#define SIO_MAX_NINFLIGHT 4
> >>> 
> >>> you meant SIO_MAX_INFLIGHT if not what is NINFLIGHT?
> >> 
> >> I mean the number is arbitrary, it doesn’t reflect any coprocessor limit since
> >> I haven’t run the tests to figure one out. It's supposed to be a small reasonable
> >> number.
> > 
> > Sorry that was not my question. Should this macro be SIO_MAX_NINFLIGHT
> > or SIO_MAX_INFLIGHT..?
> 
> Yeah, I realized after I sent the reply, sorry. I don’t know what you would
> interpret to be the difference between NINFLIGHT and INFLIGHT, in my book
> both would be the "number of inflight” in the context here.

No worries, I wante to check that was on purpose, it is fine


> >>>> +static int sio_device_config(struct dma_chan *chan,
> >>>> +      struct dma_slave_config *config)
> >>>> +{
> >>>> + struct sio_chan *siochan = to_sio_chan(chan);
> >>>> + struct sio_data *sio = siochan->host;
> >>>> + bool is_tx = sio_chan_direction(siochan->no) == DMA_MEM_TO_DEV;
> >>>> + struct sio_shmem_chan_config *cfg = sio->shmem;
> >>>> + int ret;
> >>>> +
> >>>> + switch (is_tx ? config->dst_addr_width : config->src_addr_width) {
> >>>> + case DMA_SLAVE_BUSWIDTH_1_BYTE:
> >>>> + cfg->datashape = 0;
> >>>> + break;
> >>>> + case DMA_SLAVE_BUSWIDTH_2_BYTES:
> >>>> + cfg->datashape = 1;
> >>>> + break;
> >>>> + case DMA_SLAVE_BUSWIDTH_4_BYTES:
> >>>> + cfg->datashape = 2;
> >>>> + break;
> >>>> + default:
> >>>> + return -EINVAL;
> >>>> + }
> >>>> +
> >>>> + cfg->fifo = 0x800;
> >>>> + cfg->limit = 0x800;
> >>>> + cfg->threshold = 0x800;
> >>>> + dma_wmb();
> >>> 
> >>> ??
> >> 
> >> Again, shared memory
> >> 
> >>>> +
> >>>> + ret = sio_call(sio, FIELD_PREP(SIOMSG_TYPE, MSG_CONFIGURE) |
> >>>> +     FIELD_PREP(SIOMSG_EP, siochan->no));
> >>> 
> >>> this does not sound okay, can you explain why this call is here
> >> 
> >> We are sending the configuration to the coprocessor, it will NACK
> >> it if invalid, seems very fitting here.
> > 
> > I dont this so, purpose of the device_config() is to send peripheral
> > config to driver for use on the next descriptor which is submitted. So
> > sending to co-processor now (when we might even have a txn going on)
> > does not seem right
> > 
> > What would be the behaviour if already a txn is progressing on the
> > co-processor
> 
> I have no idea.
> 
> OK, though is that necessarily part of the dmaengine interface? I ask

Yes, the configuration is applied on next descriptor that is prepared

See: Documentation/driver-api/dmaengine/provider.rst
"  - This command should NOT perform synchronously, or on any
    currently queued transfers, but only on subsequent ones"

> because the other driver I have written (apple-admac.c) does basically
> the same, only it applies the new configuration in MMIO registers rather
> than sending it to a coprocessor, but the end result is the same:
> the configuration gets checked for validity, and applied right away.

That should be fixed too :-)

-- 
~Vinod
