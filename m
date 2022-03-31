Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEF0A4ED748
	for <lists+dmaengine@lfdr.de>; Thu, 31 Mar 2022 11:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234341AbiCaJvp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 31 Mar 2022 05:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234311AbiCaJve (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 31 Mar 2022 05:51:34 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01BA202155
        for <dmaengine@vger.kernel.org>; Thu, 31 Mar 2022 02:49:46 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id bq8so32971537ejb.10
        for <dmaengine@vger.kernel.org>; Thu, 31 Mar 2022 02:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=m16w9fEGVD//K7+2kxbDNAUSN0et4kbrtMPyOKxLkDc=;
        b=lh7sz9LE7yCpF7q3YNDueS6YUg3i/L8SrcymKXUwyCasx+JSkpM80KUtEHbZhM53vQ
         P79XB2fDcti8E6uDHeVCsBLD+bd7/MZSft00FQ3b0MktX91GubtfnpUuEEimARVTUPVc
         KprT6r8oCEmaBm9XtQZTF8bRavGIilVmKuXqIsEbf93lQIJz6Fw3oao1amm9yCOqr8TN
         vYt5GFMyfDKve27wuiEy/qaR4wIfBT1RX1qyqVuaI2Gd6NfoKmBgO3PMeLhkZAbvbH+j
         4xlLuKdm0FKM03aANwhs90RyTRHX2k3jsESmaQTJvOjiHPvgcf4SXJYXBMUF/Q4G3Ccx
         33eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=m16w9fEGVD//K7+2kxbDNAUSN0et4kbrtMPyOKxLkDc=;
        b=DYV8zzIqWOAyHssRw91UjhsqbAUbb5XD9Ea9Vfa/tmdXBiTYuUdixU20QYE89mfHKU
         wICUb7cyi8a6QL+/HCA5baxIEjDKgUsvIuyDaj2uY25OUl5f5+wlEl1le6uIgyNKzWyJ
         ZypX5rHlOdegKh8YrTHcGoctJI0YWM1BdFw/oAyDQiC+ir4kTkpY9P53LCHJlSHBVSBL
         97B3mnY8hVpNpar2fLqFMCKZ3TKu/b2qbDInjwK3bxEzbgVAWDmYmwwWku1mRr1kRCFM
         CoEHLzxX1s3tVIfwta9JGuqPoI7Q838NZkwI0gyOrbSQZtUf7v4f9RG+XIAQR1SrDKN4
         PGDw==
X-Gm-Message-State: AOAM533ZwnZOYkoLuZjsfgH8U2r7wVVEutE+B+fURxTmj7QtKY8O2q31
        XAM3Uut4twraVkJCxxuLGlsvOQ==
X-Google-Smtp-Source: ABdhPJy/X3zrywwEq4pBICGkuvdH34x0UF68c5umbRsEpIF3pCn7WjNK7dhZdICVAwUqhmgbTJbaxw==
X-Received: by 2002:a17:907:3e8b:b0:6df:f199:6aa3 with SMTP id hs11-20020a1709073e8b00b006dff1996aa3mr4110135ejc.410.1648720185162;
        Thu, 31 Mar 2022 02:49:45 -0700 (PDT)
Received: from [192.168.0.166] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id hr13-20020a1709073f8d00b006dff3a69572sm9176300ejc.5.2022.03.31.02.49.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Mar 2022 02:49:44 -0700 (PDT)
Message-ID: <cc1470c4-70f0-292a-a453-bdcae8fca61d@linaro.org>
Date:   Thu, 31 Mar 2022 11:49:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/2] dmaengine: apple-admac: Add Apple ADMAC driver
Content-Language: en-US
To:     =?UTF-8?Q?Martin_Povi=c5=a1er?= <povik@cutebit.org>
Cc:     =?UTF-8?Q?Martin_Povi=c5=a1er?= <povik+lin@cutebit.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Kettenis <kettenis@openbsd.org>
References: <20220330164458.93055-1-povik+lin@cutebit.org>
 <20220330164458.93055-3-povik+lin@cutebit.org>
 <2b67081a-0b59-20d2-dbb5-a3e0b24862db@linaro.org>
 <AA1C6D16-9016-4A11-9F90-C49A13FACBC0@cutebit.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <AA1C6D16-9016-4A11-9F90-C49A13FACBC0@cutebit.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 31/03/2022 11:42, Martin Povišer wrote:
> 
>> On 31. 3. 2022, at 8:25, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 30/03/2022 18:44, Martin Povišer wrote:
>>> Add driver for Audio DMA Controller present on Apple SoCs from the
>>> "Apple Silicon" family.
>>>
>>> Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
>>> ---
>>> MAINTAINERS               |   2 +
>>> drivers/dma/Kconfig       |   8 +
>>> drivers/dma/Makefile      |   1 +
>>> drivers/dma/apple-admac.c | 799 ++++++++++++++++++++++++++++++++++++++
>>> 4 files changed, 810 insertions(+)
>>> create mode 100644 drivers/dma/apple-admac.c
>>>
>>
>> (...)
>>
>>> +
>>> +static void admac_poke(struct admac_data *ad, int reg, u32 val)
>>> +{
>>> +	writel_relaxed(val, ad->base + reg);
>>> +}
>>> +
>>> +static u32 admac_peek(struct admac_data *ad, int reg)
>>> +{
>>
>> Please do not write some custom-named functions for common functions. No
>> need to "#define true 0" or "#define read peek" etc. Read is read, write
>> is write. Using other names is counter intuitive and makes reading the
>> code more difficult.
>>
>> You actually should not have these wrappers because they don't make the
>> code smaller (more arguments needed...).
>>
>> If you want the wrappers, please use regmap_mmio.
>>
>> Only modify wrapper save some space, so it could stay.
> 
> I get the aversion to custom naming, but I would rather keep the helpers.
> Compare e.g.
> 
>   admac_write(ad, REG_BUS_WIDTH(adchan->no), bus_width);
> 
> and
> 
>   writel_relaxed(bus_width, ad->base + REG_BUS_WIDTH(adchan->no));

You safe few characters but you gain one more argument. readX/writeX
should not have wrappers. What if every driver does it? And then add a
second flavor - for non-relaxed version?

> 
> Although I guess as you said I may use regmap.

Yes, if you want a wrapper, go for the MMIO regmap. It's however
slightly bigger wrapper than just call a function, but eventually might
bring other benefits (fields etc).

> 
>>> +	return readl_relaxed(ad->base + reg);
>>> +}
>>> +
>>> +static void admac_modify(struct admac_data *ad, int reg, u32 mask, u32 val)
>>> +{
>>> +	void __iomem *addr = ad->base + reg;
>>> +	u32 curr = readl_relaxed(addr);
>>> +
>>> +	writel_relaxed((curr & ~mask) | (val & mask), addr);
>>> +}
> 
> 
>>> +
>>> +/*
>>> + * Write one hardware descriptor for a dmaengine cyclic transaction.
>>> + */
>>> +static void admac_cyclic_write_one_desc(struct admac_data *ad, int channo,
>>> +					struct admac_tx *tx)
>>> +{
>>> +	dma_addr_t addr;
>>> +
>>> +	if (WARN_ON(!tx->cyclic))
>>
>> WARN_ON_ONCE() - although I wonder why do you need this. You fully
>> control the callers to this function, don't you?
> 
> I do. Not really needed, just wanted to make it obvious we are operating
> under that assumption. Can drop it then.

For testing makes sense. For final driver it's rather discussible or at
least leave a comment. These warns will appear in user's syslog so he
should be able to act.

> 
>>> +		return;
>>> +
>>> +	addr = tx->buf_addr + (tx->submitted_pos % tx->buf_len);
>>> +	WARN_ON(addr + tx->period_len > tx->buf_end);
>>
>> If this is possible, you have buggy code. If this is not possible, why warn?
> 
> Well so if the code is buggy, I will get kicked right away here! Again,
> happy to drop it then.

The same as above.

> 
>>> +
>>> +	dev_dbg(ad->dev, "ch%d descriptor: addr=0x%pad len=0x%zx flags=0x%x\n",
>>> +		channo, addr, tx->period_len, FLAG_DESC_NOTIFY);
>>> +
>>> +	admac_poke(ad, REG_DESC_WRITE(channo), addr);
>>> +	admac_poke(ad, REG_DESC_WRITE(channo), addr >> 32);
>>> +	admac_poke(ad, REG_DESC_WRITE(channo), tx->period_len);
>>> +	admac_poke(ad, REG_DESC_WRITE(channo), FLAG_DESC_NOTIFY);
>>> +
>>> +	tx->submitted_pos += tx->period_len;
>>> +	tx->submitted_pos %= 2 * tx->buf_len;
>>> +}
> 
> (snip)
> 
>>> +static void admac_handle_status_err(struct admac_data *ad, int channo)
>>> +{
>>> +	bool handled = false;
>>> +
>>> +	if (admac_peek(ad, REG_DESC_RING(channo) & RING_ERR)) {
>>> +		admac_poke(ad, REG_DESC_RING(channo), RING_ERR);
>>> +		dev_err(ad->dev, "ch%d descriptor ring error\n", channo);
>>
>> It looks this is executed on every interrupt, so you might flood the
>> dmesg. This should be ratelimited.
> 
> OK
> 
>>> +		handled = true;
>>> +	}
>>> +
>>> +	if (admac_peek(ad, REG_REPORT_RING(channo)) & RING_ERR) {
>>> +		admac_poke(ad, REG_REPORT_RING(channo), RING_ERR);
>>> +		dev_err(ad->dev, "ch%d report ring error\n", channo);
>>> +		handled = true;
>>> +	}
>>> +
>>> +	if (unlikely(!handled)) {
>>> +		dev_err(ad->dev, "ch%d unknown error, masking errors as cause of IRQs\n", channo);
>>> +		admac_modify(ad, REG_CHAN_INTMASK(channo, ad->irq_index),
>>> +				STATUS_ERR, 0);
>>> +	}
>>> +}
> 
> (snip)
> 
>>> +static int admac_probe(struct platform_device *pdev)
>>> +{
>>> +	struct device_node *np = pdev->dev.of_node;
>>> +	struct admac_data *ad;
>>> +	struct dma_device *dma;
>>> +	int nchannels;
>>> +	int err, irq, i;
>>> +
>>> +	err = of_property_read_u32(np, "dma-channels", &nchannels);
>>> +	if (err || nchannels > NCHANNELS_MAX) {
>>> +		dev_err(&pdev->dev, "missing or invalid dma-channels property\n");
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	ad = devm_kzalloc(&pdev->dev, struct_size(ad, channels, nchannels), GFP_KERNEL);
>>> +	if (!ad)
>>> +		return -ENOMEM;
>>> +
>>> +	platform_set_drvdata(pdev, ad);
>>> +	ad->dev = &pdev->dev;
>>> +	ad->nchannels = nchannels;
>>> +
>>> +	err = of_property_read_u32(np, "apple,internal-irq-destination",
>>> +					&ad->irq_index);
>>> +	if (err || ad->irq_index >= IRQ_NINDICES) {
>>> +		dev_err(&pdev->dev, "missing or invalid apple,internal-irq-destination property\n");
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	irq = platform_get_irq(pdev, 0);
>>> +	if (irq < 0) {
>>> +		dev_err(&pdev->dev, "unable to obtain interrupt resource\n");
>>> +		return irq;
>>> +	}
>>> +
>>> +	err = devm_request_irq(&pdev->dev, irq, admac_interrupt,
>>> +					0, dev_name(&pdev->dev), ad);
>>
>> Align the arguments with previous line. This applies everywhere in the
>> driver.
> 
> I hope best-effort tab aligning is okay.

No, although we do not re-align existing code. Since this is a new code,
please align it with opening '('. Recent vim does it automatically,
other editors might as well.

> 
>>> +	if (err) {
>>> +		dev_err(&pdev->dev, "unable to register interrupt: %d\n", err);
>>> +		return err;
>>> +	}
>>> +
>>> +	ad->base = devm_platform_ioremap_resource(pdev, 0);
>>> +	if (IS_ERR(ad->base)) {
>>> +		dev_err(&pdev->dev, "unable to obtain MMIO resource\n");
>>> +		return PTR_ERR(ad->base);
>>> +	}
>>> +
>>> +	dma = &ad->dma;
>>> +
>>> +	dma_cap_set(DMA_PRIVATE, dma->cap_mask);
>>> +	dma_cap_set(DMA_CYCLIC, dma->cap_mask);
>>> +
>>> +	dma->dev = &pdev->dev;
>>> +	dma->device_alloc_chan_resources = admac_alloc_chan_resources;
>>> +	dma->device_free_chan_resources = admac_free_chan_resources;
>>> +	dma->device_tx_status = admac_tx_status;
>>> +	dma->device_issue_pending = admac_issue_pending;
>>> +	dma->device_terminate_all = admac_terminate_all;
>>> +	dma->device_prep_dma_cyclic = admac_prep_dma_cyclic;
>>> +	dma->device_config = admac_device_config;
>>> +	dma->device_pause = admac_pause;
>>> +	dma->device_resume = admac_resume;
>>> +
>>> +	dma->directions = BIT(DMA_MEM_TO_DEV) | BIT(DMA_DEV_TO_MEM);
>>> +	dma->residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
>>> +	dma->dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
>>> +			BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
>>> +			BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
>>> +
>>> +	INIT_LIST_HEAD(&dma->channels);
>>> +	for (i = 0; i < nchannels; i++) {
>>> +		struct admac_chan *adchan = &ad->channels[i];
>>> +
>>> +		adchan->host = ad;
>>> +		adchan->no = i;
>>> +		adchan->chan.device = &ad->dma;
>>> +		spin_lock_init(&adchan->lock);
>>> +		INIT_LIST_HEAD(&adchan->submitted);
>>> +		INIT_LIST_HEAD(&adchan->issued);
>>> +		list_add_tail(&adchan->chan.device_node, &dma->channels);
>>> +		tasklet_setup(&adchan->tasklet, admac_chan_tasklet);
>>> +	}
>>> +
>>> +	err = dma_async_device_register(&ad->dma);
>>> +	if (err) {
>>> +		dev_err(&pdev->dev, "failed to register DMA device: %d\n", err);
>>
>> Use dev_err_probe() here and in other places.
> 
> Okay!
> 
>>> +		return err;
>>> +	}
>>> +
>>> +	err = of_dma_controller_register(pdev->dev.of_node, admac_dma_of_xlate, ad);
>>> +	if (err) {
>>> +		dev_err(&pdev->dev, "failed to register with OF: %d\n", err);
>>> +		dma_async_device_unregister(&ad->dma);
>>> +		return err;
>>> +	}
>>> +
>>> +	dev_dbg(&pdev->dev, "all good, ready to go!\n");
>>
>> No debugging messages for simple probe success, please.
> 
> If you insist. :)

Yes, we have infrastructure for such simple success-prints. You are
allowed however to print here (preferably dev_dbg) useful information,
see pl330 for example.

Best regards,
Krzysztof
