Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A171D7CA01C
	for <lists+dmaengine@lfdr.de>; Mon, 16 Oct 2023 09:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjJPHL1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 16 Oct 2023 03:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjJPHL0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 16 Oct 2023 03:11:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BEF7C5;
        Mon, 16 Oct 2023 00:11:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1D16C433C8;
        Mon, 16 Oct 2023 07:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697440284;
        bh=l/Vg0iqD0UinYyhUjSctEB0Snsg6BWXcoeOBRlbiWVo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eQjhdoS+1/ZbY7r7aCl4mEZfIRzNj8u8LuOfVGzSusDASPitargYnsYw9tT3MGbuO
         dksuSRmLlsJbz6o9+Bgiowr32+F3wSIAGB8wopQZXqskxZeOVFgsrSvrbsN7SVGraZ
         F51Eod6EE9WT54cumc16W2O33m49je59N1u0hVb+xaBZAKganjKryU4L8dAUpW6Zvt
         +CV2w+u+ucaLt8APuI3i0qb2CpsQAfRnQ3eNaaWoFwvU492Xu3sGGeGlb+EbnXwjzs
         k4r0tS7DIEQRjq1F8iICV3sMyCVzfcQTqXFKa/4h6BRymEqukSuaGs3X//kZlu11nb
         3SMm4G/rWfEYw==
Date:   Mon, 16 Oct 2023 12:41:20 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, asahi@lists.linux.dev,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] dmaengine: apple-sio: Add Apple SIO driver
Message-ID: <ZSziGA6ao+KG3l8q@matsya>
References: <20231013164936.60718-1-povik+lin@cutebit.org>
 <20231013164936.60718-3-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231013164936.60718-3-povik+lin@cutebit.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 13-10-23, 18:49, Martin Povišer wrote:

> +static struct dma_async_tx_descriptor *sio_prep_dma_cyclic(

this should generate a check warning, typically lines should not end with a '('

> +		struct dma_chan *chan, dma_addr_t buf_addr, size_t buf_len,
> +		size_t period_len, enum dma_transfer_direction direction,
> +		unsigned long flags)

also helps to align with the open brace to something like:
static struct dma_async_tx_descriptor *
sio_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf_addr, size_t buf_len,
                    size_t period_len, enum dma_transfer_direction direction,
                    unsigned long flags)

> +static bool sio_fill_in_locked(struct sio_chan *siochan);
> +
> +static void sio_handle_issue_ack(struct sio_chan *siochan, void *cookie, bool ok)
> +{
> +	dma_cookie_t tx_cookie = (unsigned long) cookie;

space not required after a cast

> +static struct dma_chan *sio_dma_of_xlate(struct of_phandle_args *dma_spec,
> +					 struct of_dma *ofdma)
> +{
> +	struct sio_data *sio = (struct sio_data *) ofdma->of_dma_data;

drop space after cast here too

> +static int sio_device_config(struct dma_chan *chan,
> +			     struct dma_slave_config *config)
> +{
> +	struct sio_chan *siochan = to_sio_chan(chan);
> +	struct sio_data *sio = siochan->host;
> +	bool is_tx = sio_chan_direction(siochan->no) == DMA_MEM_TO_DEV;
> +	struct sio_shmem_chan_config *cfg_shmem = sio->shmem;
> +	struct sio_shmem_chan_config cfg;
> +	int ret;
> +
> +	switch (is_tx ? config->dst_addr_width : config->src_addr_width) {
> +	case DMA_SLAVE_BUSWIDTH_1_BYTE:
> +		cfg.datashape = 0;
> +		break;
> +	case DMA_SLAVE_BUSWIDTH_2_BYTES:
> +		cfg.datashape = 1;
> +		break;
> +	case DMA_SLAVE_BUSWIDTH_4_BYTES:
> +		cfg.datashape = 2;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	cfg.fifo = 0x800;
> +	cfg.limit = 0x800;
> +	cfg.threshold = 0x800;

what do these values represent, should this not be passed by the client

> +static int sio_alloc_shmem(struct sio_data *sio)
> +{
> +	dma_addr_t iova;
> +	int err;
> +
> +	sio->shmem = dma_alloc_coherent(sio->dev, SIO_SHMEM_SIZE,
> +					&iova, GFP_KERNEL);
> +	if (!sio->shmem)
> +		return -ENOMEM;
> +
> +	sio->shmem_desc_base = (struct sio_coproc_desc *) (sio->shmem + 56);

here too

> +static int sio_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct sio_data *sio;
> +	struct dma_device *dma;
> +	int nchannels;
> +	int err, i;
> +
> +	err = of_property_read_u32(np, "dma-channels", &nchannels);

why not use device_property_read_u32()
-- 
~Vinod
