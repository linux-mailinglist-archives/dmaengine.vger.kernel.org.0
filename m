Return-Path: <dmaengine+bounces-2114-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B72F08CA9F2
	for <lists+dmaengine@lfdr.de>; Tue, 21 May 2024 10:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E876E1C20AFE
	for <lists+dmaengine@lfdr.de>; Tue, 21 May 2024 08:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4047946435;
	Tue, 21 May 2024 08:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LEFcgL/K"
X-Original-To: dmaengine@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F8254F89;
	Tue, 21 May 2024 08:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716280282; cv=none; b=Z8U/BqUbcDSlR2mW6yVF3YfY65z027JT4TxLT/dxszBpQmJMKbT0oltPXPy6HIMAW6FYmyK0h23kmQ8lERhXFhqZWli+enxNzHP9WBx9BE6qqIkJM5ZCqsmPBCVT6kr+k9a/CdxVN4SVQtzLlxh5nxsFVnhDFUE6juiTiYjuAq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716280282; c=relaxed/simple;
	bh=lpS4CuL1hfVfkN6UEIanZaVefK5M3mfjTRzD2Y1ov+k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=K1yWmucss1erCNaiaO2eVrXiQynO08d7CiZYUbRFY5ti0R5pTWFua/V+pLwkHzrhGYQbjCnvvhJMy0FkxjETjkWfTuRrTQ6XHmwcez89A6nkFNGjvYwvUQH3xOaiAC2Y/Eo6MXUVz+tcb2KrgB4V3Hb3YPdo/HH08aGzcE9UtC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LEFcgL/K; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1FB12C0042;
	Tue, 21 May 2024 08:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1716280274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=JhKEEmuqIsp0pcO3xD1Io87gyKvYBy5SHr5INy2szoI=;
	b=LEFcgL/KUyj0TFxT+Jq9QTLhHxatKQ+V+5MxvcoWaITwO8PYDebNzPnkvVanxdrkVemyzY
	2W0UzX6rX2XZNc3DWZQ83uDLS+qD7sNAdO5AUgd3jUEl5UeG2X/ns/K/3V9v+qEO5MYOk5
	qx10sRZFc+oT6FlZsLrHzMDYvHboQEhu6LAD/BupdldhthG7dSvl8N4UM8hjkKjZ46Q4iE
	CgM1XIB2vvthuwymANPUaJVTple5HL9ZpYNZvvUVKVeO4AqNyPOwy/hRKyAxcaGVwWAClR
	YkbIZLI0IoxbDTZDnvMWdAJPmh5bxvg73Ocbg7Zra9G/LJLUOD47tMQ9NzL5LQ==
Date: Tue, 21 May 2024 10:31:12 +0200
From: Louis Chauvet <louis.chauvet@bootlin.com>
To: linux-sound@vger.kernel.org, dmaengine@vger.kernel.org,
	alsa-devel@alsa-project.org
Cc: miquel.raynal@bootlin.com, perex@perex.cz, tiwai@suse.com,
	broonie@kernel.org, lars@metafoo.de, lgirdwood@gmail.com
Subject: DMA Transfer Synchronization Issue in Out-of-Tree Sound Card Driver
Message-ID: <Zkxb0FTzW6wlnYYO@localhost.localdomain>
Mail-Followup-To: linux-sound@vger.kernel.org, dmaengine@vger.kernel.org,
	alsa-devel@alsa-project.org, miquel.raynal@bootlin.com,
	perex@perex.cz, tiwai@suse.com, broonie@kernel.org, lars@metafoo.de,
	lgirdwood@gmail.com
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GND-Sasl: louis.chauvet@bootlin.com


Hello everyone,

I am currently developing an out-of-tree driver for a sound card that 
utilizes XDMA for sample transfers. I am currently using a kernel 6.5 with 
the latest xdma driver cherry-picked, but I don't think any changes since 
6.5 is addressing my issue.

My initial issue pertains to the completion of DMA transfers between a 
start and a stop command in ALSA. If the interval is too brief, the 
transfer does not conclude properly, leading to distorted samples. A 
straightforward solution to this problem was to adequately wait for the 
transfer to finish upon the stop, ie. sleeping until we know the hardware 
is done with the transfert (the XDMA controller does not support stopping 
in the middle of a transfer).

To address this DMA issue, I have created a patch [1] that guarantees the 
completion of the DMA transfer upon the return of xdma_synchronize. This 
means xdma_synchronize now sleeps, but looking at other drivers around it 
appears expected to be able to do so.

Regarding the audio implementation, the following patch enforces the 
synchronization:

	int playback_trigger(struct snd_pcm_substream *substream, int command)
	{
		struct my_dev *my_dev =	snd_pcm_substream_chip(substream);

		switch (command) {
		case SNDRV_PCM_TRIGGER_START:
			/* Synchronize on start, because the trigger stop is called from an IRQ	context	*/
			if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
				dmaengine_synchronize(my_dev->playback_dma_chan);
			pipe_start(&my_dev->playback, substream);
			break;
		case SNDRV_PCM_TRIGGER_STOP:
			pipe_stop(&my_dev->playback, substream);
			break;
		default:
			return -EINVAL;
		}
		return 0;
	}

In order for a sleepable function like dmaengine_synchronize() to work in 
the trigger callbacks, the audio card nonatomic flag had to be set. It 
basically leads the sound core towards the use of a mutex instead of a 
spinlock.

	static int probe([...])	{
		struct snd_pcm *pcm;
		[...]
		/* This flag is needed to be able to sleep in start/stop callbacks */
		pcm->nonatomic = true;
                [...]
		snd_pcm_set_managed_buffer_all(pcm, [...]);
	}

This approach generally works well, but leads to "scheduling while
atomic" errors. Indeed, the IRQ handler from the XDMA driver invokes a
function within the sound subsystem, which subsequently acquires a
mutex...

At the moment, the only solution I've found is to replace the 
wait_for_completion() in the XDMA driver [2] with a busy wait loop. 
However, this approach seems incorrect, as all other synchronization 
functions in other DMA drivers are sleeping, which should not cause an 
issue.

The problem might be related to the sound driver. Should I avoid manually 
using dmaengine_synchronize? How to achieve the same effect in this case? 
Perhaps there is a more traditional way to properly clean the stream in 
the sound subsystem which I overlooked?

Could someone please provide guidance on how to resolve this issue?

Thanks,
Louis Chauvet

[1]: https://lore.kernel.org/all/20240327-digigram-xdma-fixes-v1-2-45f4a52c0283@bootlin.com/
[2]: https://elixir.bootlin.com/linux/latest/source/drivers/dma/xilinx/xdma.c#L550

-- 
Louis Chauvet, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

