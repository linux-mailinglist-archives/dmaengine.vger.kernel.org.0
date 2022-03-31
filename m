Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3A344ED729
	for <lists+dmaengine@lfdr.de>; Thu, 31 Mar 2022 11:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234220AbiCaJn5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 31 Mar 2022 05:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233957AbiCaJn5 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 31 Mar 2022 05:43:57 -0400
Received: from hutie.ust.cz (hutie.ust.cz [185.8.165.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55981D8315;
        Thu, 31 Mar 2022 02:42:07 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1648719723; bh=bxHjM8nQMv6N9KHDuQPaOT4fM9NaqF0YzmvJaTCXop4=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To;
        b=ffRBSzKwPKDLf8HOVm3jMId/Tw/wMqbynZUZvZdfE7htutoxByK8ZVN2yeQZLx7Fx
         yZL92fKn7ho1nDLsgvzSBe0Jl5Ds1Xvsitd5J8daJTvFFv+3WszHT8hkSTuJp2mHfh
         baJIRu73TaNwLwrUgkDdv6jIvwL5rLBjM3/ywGb4=
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH 2/2] dmaengine: apple-admac: Add Apple ADMAC driver
From:   =?utf-8?Q?Martin_Povi=C5=A1er?= <povik@cutebit.org>
In-Reply-To: <2b67081a-0b59-20d2-dbb5-a3e0b24862db@linaro.org>
Date:   Thu, 31 Mar 2022 11:42:00 +0200
Cc:     =?utf-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Kettenis <kettenis@openbsd.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <AA1C6D16-9016-4A11-9F90-C49A13FACBC0@cutebit.org>
References: <20220330164458.93055-1-povik+lin@cutebit.org>
 <20220330164458.93055-3-povik+lin@cutebit.org>
 <2b67081a-0b59-20d2-dbb5-a3e0b24862db@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


> On 31. 3. 2022, at 8:25, Krzysztof Kozlowski =
<krzysztof.kozlowski@linaro.org> wrote:
>=20
> On 30/03/2022 18:44, Martin Povi=C5=A1er wrote:
>> Add driver for Audio DMA Controller present on Apple SoCs from the
>> "Apple Silicon" family.
>>=20
>> Signed-off-by: Martin Povi=C5=A1er <povik+lin@cutebit.org>
>> ---
>> MAINTAINERS               |   2 +
>> drivers/dma/Kconfig       |   8 +
>> drivers/dma/Makefile      |   1 +
>> drivers/dma/apple-admac.c | 799 =
++++++++++++++++++++++++++++++++++++++
>> 4 files changed, 810 insertions(+)
>> create mode 100644 drivers/dma/apple-admac.c
>>=20
>=20
> (...)
>=20
>> +
>> +static void admac_poke(struct admac_data *ad, int reg, u32 val)
>> +{
>> +	writel_relaxed(val, ad->base + reg);
>> +}
>> +
>> +static u32 admac_peek(struct admac_data *ad, int reg)
>> +{
>=20
> Please do not write some custom-named functions for common functions. =
No
> need to "#define true 0" or "#define read peek" etc. Read is read, =
write
> is write. Using other names is counter intuitive and makes reading the
> code more difficult.
>=20
> You actually should not have these wrappers because they don't make =
the
> code smaller (more arguments needed...).
>=20
> If you want the wrappers, please use regmap_mmio.
>=20
> Only modify wrapper save some space, so it could stay.

I get the aversion to custom naming, but I would rather keep the =
helpers.
Compare e.g.

  admac_write(ad, REG_BUS_WIDTH(adchan->no), bus_width);

and

  writel_relaxed(bus_width, ad->base + REG_BUS_WIDTH(adchan->no));

Although I guess as you said I may use regmap.

>> +	return readl_relaxed(ad->base + reg);
>> +}
>> +
>> +static void admac_modify(struct admac_data *ad, int reg, u32 mask, =
u32 val)
>> +{
>> +	void __iomem *addr =3D ad->base + reg;
>> +	u32 curr =3D readl_relaxed(addr);
>> +
>> +	writel_relaxed((curr & ~mask) | (val & mask), addr);
>> +}


>> +
>> +/*
>> + * Write one hardware descriptor for a dmaengine cyclic transaction.
>> + */
>> +static void admac_cyclic_write_one_desc(struct admac_data *ad, int =
channo,
>> +					struct admac_tx *tx)
>> +{
>> +	dma_addr_t addr;
>> +
>> +	if (WARN_ON(!tx->cyclic))
>=20
> WARN_ON_ONCE() - although I wonder why do you need this. You fully
> control the callers to this function, don't you?

I do. Not really needed, just wanted to make it obvious we are operating
under that assumption. Can drop it then.

>> +		return;
>> +
>> +	addr =3D tx->buf_addr + (tx->submitted_pos % tx->buf_len);
>> +	WARN_ON(addr + tx->period_len > tx->buf_end);
>=20
> If this is possible, you have buggy code. If this is not possible, why =
warn?

Well so if the code is buggy, I will get kicked right away here! Again,
happy to drop it then.

>> +
>> +	dev_dbg(ad->dev, "ch%d descriptor: addr=3D0x%pad len=3D0x%zx =
flags=3D0x%x\n",
>> +		channo, addr, tx->period_len, FLAG_DESC_NOTIFY);
>> +
>> +	admac_poke(ad, REG_DESC_WRITE(channo), addr);
>> +	admac_poke(ad, REG_DESC_WRITE(channo), addr >> 32);
>> +	admac_poke(ad, REG_DESC_WRITE(channo), tx->period_len);
>> +	admac_poke(ad, REG_DESC_WRITE(channo), FLAG_DESC_NOTIFY);
>> +
>> +	tx->submitted_pos +=3D tx->period_len;
>> +	tx->submitted_pos %=3D 2 * tx->buf_len;
>> +}

(snip)

>> +static void admac_handle_status_err(struct admac_data *ad, int =
channo)
>> +{
>> +	bool handled =3D false;
>> +
>> +	if (admac_peek(ad, REG_DESC_RING(channo) & RING_ERR)) {
>> +		admac_poke(ad, REG_DESC_RING(channo), RING_ERR);
>> +		dev_err(ad->dev, "ch%d descriptor ring error\n", =
channo);
>=20
> It looks this is executed on every interrupt, so you might flood the
> dmesg. This should be ratelimited.

OK

>> +		handled =3D true;
>> +	}
>> +
>> +	if (admac_peek(ad, REG_REPORT_RING(channo)) & RING_ERR) {
>> +		admac_poke(ad, REG_REPORT_RING(channo), RING_ERR);
>> +		dev_err(ad->dev, "ch%d report ring error\n", channo);
>> +		handled =3D true;
>> +	}
>> +
>> +	if (unlikely(!handled)) {
>> +		dev_err(ad->dev, "ch%d unknown error, masking errors as =
cause of IRQs\n", channo);
>> +		admac_modify(ad, REG_CHAN_INTMASK(channo, =
ad->irq_index),
>> +				STATUS_ERR, 0);
>> +	}
>> +}

(snip)

>> +static int admac_probe(struct platform_device *pdev)
>> +{
>> +	struct device_node *np =3D pdev->dev.of_node;
>> +	struct admac_data *ad;
>> +	struct dma_device *dma;
>> +	int nchannels;
>> +	int err, irq, i;
>> +
>> +	err =3D of_property_read_u32(np, "dma-channels", &nchannels);
>> +	if (err || nchannels > NCHANNELS_MAX) {
>> +		dev_err(&pdev->dev, "missing or invalid dma-channels =
property\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	ad =3D devm_kzalloc(&pdev->dev, struct_size(ad, channels, =
nchannels), GFP_KERNEL);
>> +	if (!ad)
>> +		return -ENOMEM;
>> +
>> +	platform_set_drvdata(pdev, ad);
>> +	ad->dev =3D &pdev->dev;
>> +	ad->nchannels =3D nchannels;
>> +
>> +	err =3D of_property_read_u32(np, =
"apple,internal-irq-destination",
>> +					&ad->irq_index);
>> +	if (err || ad->irq_index >=3D IRQ_NINDICES) {
>> +		dev_err(&pdev->dev, "missing or invalid =
apple,internal-irq-destination property\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	irq =3D platform_get_irq(pdev, 0);
>> +	if (irq < 0) {
>> +		dev_err(&pdev->dev, "unable to obtain interrupt =
resource\n");
>> +		return irq;
>> +	}
>> +
>> +	err =3D devm_request_irq(&pdev->dev, irq, admac_interrupt,
>> +					0, dev_name(&pdev->dev), ad);
>=20
> Align the arguments with previous line. This applies everywhere in the
> driver.

I hope best-effort tab aligning is okay.

>> +	if (err) {
>> +		dev_err(&pdev->dev, "unable to register interrupt: =
%d\n", err);
>> +		return err;
>> +	}
>> +
>> +	ad->base =3D devm_platform_ioremap_resource(pdev, 0);
>> +	if (IS_ERR(ad->base)) {
>> +		dev_err(&pdev->dev, "unable to obtain MMIO resource\n");
>> +		return PTR_ERR(ad->base);
>> +	}
>> +
>> +	dma =3D &ad->dma;
>> +
>> +	dma_cap_set(DMA_PRIVATE, dma->cap_mask);
>> +	dma_cap_set(DMA_CYCLIC, dma->cap_mask);
>> +
>> +	dma->dev =3D &pdev->dev;
>> +	dma->device_alloc_chan_resources =3D admac_alloc_chan_resources;
>> +	dma->device_free_chan_resources =3D admac_free_chan_resources;
>> +	dma->device_tx_status =3D admac_tx_status;
>> +	dma->device_issue_pending =3D admac_issue_pending;
>> +	dma->device_terminate_all =3D admac_terminate_all;
>> +	dma->device_prep_dma_cyclic =3D admac_prep_dma_cyclic;
>> +	dma->device_config =3D admac_device_config;
>> +	dma->device_pause =3D admac_pause;
>> +	dma->device_resume =3D admac_resume;
>> +
>> +	dma->directions =3D BIT(DMA_MEM_TO_DEV) | BIT(DMA_DEV_TO_MEM);
>> +	dma->residue_granularity =3D DMA_RESIDUE_GRANULARITY_BURST;
>> +	dma->dst_addr_widths =3D BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
>> +			BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
>> +			BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
>> +
>> +	INIT_LIST_HEAD(&dma->channels);
>> +	for (i =3D 0; i < nchannels; i++) {
>> +		struct admac_chan *adchan =3D &ad->channels[i];
>> +
>> +		adchan->host =3D ad;
>> +		adchan->no =3D i;
>> +		adchan->chan.device =3D &ad->dma;
>> +		spin_lock_init(&adchan->lock);
>> +		INIT_LIST_HEAD(&adchan->submitted);
>> +		INIT_LIST_HEAD(&adchan->issued);
>> +		list_add_tail(&adchan->chan.device_node, =
&dma->channels);
>> +		tasklet_setup(&adchan->tasklet, admac_chan_tasklet);
>> +	}
>> +
>> +	err =3D dma_async_device_register(&ad->dma);
>> +	if (err) {
>> +		dev_err(&pdev->dev, "failed to register DMA device: =
%d\n", err);
>=20
> Use dev_err_probe() here and in other places.

Okay!

>> +		return err;
>> +	}
>> +
>> +	err =3D of_dma_controller_register(pdev->dev.of_node, =
admac_dma_of_xlate, ad);
>> +	if (err) {
>> +		dev_err(&pdev->dev, "failed to register with OF: %d\n", =
err);
>> +		dma_async_device_unregister(&ad->dma);
>> +		return err;
>> +	}
>> +
>> +	dev_dbg(&pdev->dev, "all good, ready to go!\n");
>=20
> No debugging messages for simple probe success, please.

If you insist. :)

>=20
> Best regards,
> Krzysztof

Best, Martin

