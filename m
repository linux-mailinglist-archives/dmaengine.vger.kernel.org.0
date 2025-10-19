Return-Path: <dmaengine+bounces-6881-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88008BEE0D1
	for <lists+dmaengine@lfdr.de>; Sun, 19 Oct 2025 10:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41DE03E317E
	for <lists+dmaengine@lfdr.de>; Sun, 19 Oct 2025 08:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1EF5209F5A;
	Sun, 19 Oct 2025 08:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jlLXTfqw"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870C542050;
	Sun, 19 Oct 2025 08:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760863374; cv=none; b=NTouwtqqoreYq/kEgrMla0RUXbsVWotEu6JrY0us2pY8lLJjjnIPqH1suoNPmMfJrqJelsEPerrjmlADdmVjkaBuYlTS41swsNgj2qvWjfdVjLqb36A4MoER4DyG+tmhvPyQJAj7C2RKrMODjd3CjgkUPxMEv3x/t9mXHgM7YJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760863374; c=relaxed/simple;
	bh=3rC1rXs13g9kVylyOUE74ytjRnI/cTBx45WIM2YR9F4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hoOVOMlbmRC18yNb+nnzNM3NAoqN0ksuiHq8cYoDsnDM+OYXFXRNls7Jrv2HH+6484Jg0rMbl43VBKrZxhU8IMZT/tO8dthLR5XxgL5GKW9BalHYHkYovdXiBMFLJxTNG9rRDDQK+4Ff5g4tjKg0PASjYkhFpEQJzcnHlZRtoRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jlLXTfqw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E10AC4CEE7;
	Sun, 19 Oct 2025 08:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760863374;
	bh=3rC1rXs13g9kVylyOUE74ytjRnI/cTBx45WIM2YR9F4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jlLXTfqwuandNhbhBrdc/JsTfqaBN3pts9UR7ARxShCN7y8isp+YXjPf+XdUk132s
	 h7NUfsdwXtTwUxpqXfGpjEHBmOJV8fsCEKksYQe8u9dOxuOor9TlLNdfW1/vR0A4xM
	 jn+MHwJK3hmuqCz9JV+081s/PSEc0CXcFJpJTSzA0upSXggrYiQasXrKrAK+CxdOTZ
	 ZilEryxHo6JDbXF2hmEhMjeZBY2iHE8L2y72YTS47eyVpsuDUkPui8JWJvFo+goOVM
	 rZbh+/5rbDwL8hDpp43nFtoq+jicpRTiQb5DCNBAb+8hf1SbBMYHPdT2TEDPdkWN7K
	 1U6jD29KHW87w==
Date: Sun, 19 Oct 2025 09:42:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 robh@kernel.org, conor+dt@kernel.org, krzk+dt@kernel.org,
 linux-iio@vger.kernel.org, s32@nxp.com, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, chester62515@gmail.com, mbrugger@suse.com,
 ghennadi.procopciuc@oss.nxp.com, Vinod Koul <vkoul@kernel.org>,
 dmaengine@vger.kernel.org
Subject: Re: [PATCH v5 2/2] iio: adc: Add the NXP SAR ADC support for the
 s32g2/3 platforms
Message-ID: <20251019094246.38daf7bf@jic23-huawei>
In-Reply-To: <20251017164238.1908585-3-daniel.lezcano@linaro.org>
References: <20251017164238.1908585-1-daniel.lezcano@linaro.org>
	<20251017164238.1908585-3-daniel.lezcano@linaro.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Oct 2025 18:42:38 +0200
Daniel Lezcano <daniel.lezcano@linaro.org> wrote:

> From: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
> 
> The NXP S32G2 and S32G3 platforms integrate a successive approximation
> register (SAR) ADC. Two instances are available, each providing 8
> multiplexed input channels with 12-bit resolution. The conversion rate
> is up to 1 Msps depending on the configuration and sampling window.
> 
> The SAR ADC supports raw, buffer, and trigger modes. It can operate
> in both single-shot and continuous conversion modes, with optional
> hardware triggering through the cross-trigger unit (CTU) or external
> events. An internal prescaler allows adjusting the sampling clock,
> while per-channel programmable sampling times provide fine-grained
> trade-offs between accuracy and latency. Automatic calibration is
> performed at probe time to minimize offset and gain errors.
> 
> The driver is derived from the BSP implementation and has been partly
> rewritten to comply with upstream requirements. For this reason, all
> contributors are listed as co-developers, while the author refers to
> the initial BSP driver file creator.
> 
> All modes have been validated on the S32G274-RDB2 platform using an
> externally generated square wave captured by the ADC. Tests covered
> buffered streaming via IIO, trigger synchronization, and accuracy
> verification against a precision laboratory signal source.
> 
> Co-developed-by: Alexandru-Catalin Ionita <alexandru-catalin.ionita@nxp.com>
> Signed-off-by: Alexandru-Catalin Ionita <alexandru-catalin.ionita@nxp.com>
> Co-developed-by: Ciprian Costea <ciprianmarian.costea@nxp.com>
> Signed-off-by: Ciprian Costea <ciprianmarian.costea@nxp.com>
> Co-developed-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
> Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
> Signed-off-by: Stefan-Gabriel Mirea <stefan-gabriel.mirea@nxp.com>
> Co-developed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Hi Daniel,

Only significant question in here is around lifetimes of the
dma buffer.

+CC Vinod and dmaengine list. Hopefully someone will rapidly tell me
my concern is garbage ;)

IIO folk who are familiar with dmaengine channels etc please take
a look at this as well.  I think all the upstream drivers we have doing
similar things to this predate devm_ management being a common thing.

Jonathan


> diff --git a/drivers/iio/adc/nxp-sar-adc.c b/drivers/iio/adc/nxp-sar-adc.c
> new file mode 100644
> index 000000000000..fa390c9d911f
> --- /dev/null
> +++ b/drivers/iio/adc/nxp-sar-adc.c
> @@ -0,0 +1,1006 @@

> +
> +static void nxp_sar_adc_dma_cb(void *data)
> +{
> +	struct nxp_sar_adc *info = iio_priv(data);
> +	struct iio_dev *indio_dev = data;

Trivial but it would slightly more intuitive to do.
	struct iio_dev *indio_dev = data;
	struct nxp_sar_adc *info = iio_priv(indio_dev);

> +	struct dma_tx_state state;
> +	struct circ_buf *dma_buf;
> +	struct device *dev_dma;
> +	u32 *dma_samples;
> +	s64 timestamp;
> +	int idx, ret;
> +
> +	guard(spinlock_irqsave)(&info->lock);
> +
> +	dma_buf = &info->dma_buf;
> +	dma_samples = (u32 *)dma_buf->buf;
> +	dev_dma = info->dma_chan->device->dev;
> +
> +	dmaengine_tx_status(info->dma_chan, info->cookie, &state);
> +
> +	dma_sync_single_for_cpu(dev_dma, info->rx_dma_buf,
> +				NXP_SAR_ADC_DMA_BUFF_SZ, DMA_FROM_DEVICE);
> +
> +	/* Current head position. */
> +	dma_buf->head = (NXP_SAR_ADC_DMA_BUFF_SZ - state.residue) /
> +			NXP_SAR_ADC_DMA_SAMPLE_SZ;
> +
> +	/* If everything was transferred, avoid an off by one error. */
> +	if (!state.residue)
> +		dma_buf->head--;
> +
> +	/* Something went wrong and nothing transferred. */
> +	if (state.residue == NXP_SAR_ADC_DMA_BUFF_SZ)
> +		goto out;
> +
> +	/* Make sure that head is multiple of info->channels_used. */
> +	dma_buf->head -= dma_buf->head % info->channels_used;
> +
> +	/*
> +	 * dma_buf->tail != dma_buf->head condition will become false
> +	 * because dma_buf->tail will be incremented with 1.
> +	 */
> +	while (dma_buf->tail != dma_buf->head) {
> +		idx = dma_buf->tail % info->channels_used;
> +		info->buffer[idx] = dma_samples[dma_buf->tail];
> +		dma_buf->tail = (dma_buf->tail + 1) % NXP_SAR_ADC_DMA_SAMPLE_CNT;
> +		if (idx != info->channels_used - 1)
> +			continue;
> +
> +		/*
> +		 * iio_push_to_buffers_with_timestamp should not be

Comment needs an update as using with_ts()


> +		 * called with dma_samples as parameter. The samples
> +		 * will be smashed if timestamp is enabled.
> +		 */
> +		timestamp = iio_get_time_ns(indio_dev);
> +		ret = iio_push_to_buffers_with_ts(indio_dev, info->buffer,
> +						  sizeof(info->buffer),
> +						  timestamp);
> +		if (ret < 0 && ret != -EBUSY)
> +			dev_err_ratelimited(&indio_dev->dev,
> +					    "failed to push iio buffer: %d",
> +					    ret);
> +	}
> +
> +	dma_buf->tail = dma_buf->head;
> +out:
> +	dma_sync_single_for_device(dev_dma, info->rx_dma_buf,
> +				   NXP_SAR_ADC_DMA_BUFF_SZ, DMA_FROM_DEVICE);
> +}



> +static int nxp_sar_adc_dma_probe(struct device *dev, struct nxp_sar_adc *info)
> +{
> +	struct device *dev_dma;
> +	u8 *rx_buf;
> +
> +	info->dma_chan = devm_dma_request_chan(dev, "rx");
> +	if (IS_ERR(info->dma_chan))
> +		return PTR_ERR(info->dma_chan);
> +
> +	dev_dma = info->dma_chan->device->dev;
> +	rx_buf = dmam_alloc_coherent(dev_dma, NXP_SAR_ADC_DMA_BUFF_SZ,
> +				     &info->rx_dma_buf, GFP_KERNEL);

Is this setting up the right life time?  Superficially it looks to be
associating the buffer lifetime with a device related to the dma engine rather
than the device we are dealing with here.

This particular pattern with devm_dma_request_chan() is vanishingly rare
so not much prior art to rely on.

If the info->dma_chan->device->dev is instantiated by devm_dma_request_chan()
and hence torn down as that is unwound it will be fine as this is simply
nested devm handling, but it seems a struct dma_device has many chans so
I think that isn't the case.

Given that device parameter is also needed for the buffer allocation and
making sure we have the right properties / iommu magic etc, I'm not sure
how to make this work. One option would be to use dma_alloc_coherent() and
tear down with a devm_add_action_or_reset() handler on dev rather than
dev_dma.

> +	if (!rx_buf)
> +		return -ENOMEM;
> +
> +	info->dma_buf.buf = rx_buf;
> +
> +	return 0;
> +}

