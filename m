Return-Path: <dmaengine+bounces-3279-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66FF8992BA7
	for <lists+dmaengine@lfdr.de>; Mon,  7 Oct 2024 14:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA210B24A4D
	for <lists+dmaengine@lfdr.de>; Mon,  7 Oct 2024 12:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235B91D2B3C;
	Mon,  7 Oct 2024 12:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b="IdYVVxsY"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B5B1D27AF
	for <dmaengine@vger.kernel.org>; Mon,  7 Oct 2024 12:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728303908; cv=none; b=rQlJdcDwK55LINcmlPWmWirP8Ve2ZT2Y2PxNvI2FEUkG/fUp9RIS203kVaH1MCT+Q6isTD0XZJtZjKwCS50Ti4XQPZI7p3QYZaG6xsCkGt9+Aar9IPEX/VMKLdKNCy1LtNdLjzrZy7r0SVYmb5WjEx7mLEvwqpKFV5UiPOP1RIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728303908; c=relaxed/simple;
	bh=Yqa0XvNtnjZsPKDcT41xGnEWosRzzxdqRW0lD1BJnpU=;
	h=Date:Subject:In-Reply-To:CC:From:To:Message-ID:Mime-Version:
	 Content-Type; b=Y5pDbvpb1Bfd0QQpVDLbwZBwYbr/9lmC+gkMZf8DgQGAVOgmQM2vX76HI/r1AkS9PEMLY22XfEqOrBKtCE4+oA8B8GgSk69i2gErRzr24TsQfyjdh4SUefZ6jJr8EcYnYHhbSLdOAe3FBkRXoy/uZadU9dffiJs9fSF0TWsOTFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com; spf=pass smtp.mailfrom=dabbelt.com; dkim=pass (2048-bit key) header.d=dabbelt-com.20230601.gappssmtp.com header.i=@dabbelt-com.20230601.gappssmtp.com header.b=IdYVVxsY; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dabbelt.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7d4f85766f0so3587682a12.2
        for <dmaengine@vger.kernel.org>; Mon, 07 Oct 2024 05:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20230601.gappssmtp.com; s=20230601; t=1728303905; x=1728908705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gM96gy8f618bGBajVDpCaKuepjJ0dpUYbsUw4JQ//R4=;
        b=IdYVVxsYW0MXzv3Pg5jxERbzT0O0NRLhgffIbl0fNzjqG8DUySk/f8oVxbK3InLQMQ
         9/bWLyboKvCW/GCjsCg5h1uFeDPg5f+rBGw4fjYuUrHPvOHZ8H7A0Ud1jpM/0DWt8ZtK
         oRmgA1u/LyPcU+QqNwij0UVNUiB1WxFVGHValOn8cfi+GPVp7xGsPG6b+Pe0P7DvuRAH
         fpuwowQQpa7JD0Dn7usdC4MvnVW+18qZ8a9INISZGfSZjlReXaD7dhLmBx/PsbGkIIuV
         HW2dFhixpoVaTKSc9nnVZHgJ+ebUcBGA8uWJVpZJIrAmm6iji0NILgOuvXjAVz/wb64T
         Bqjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728303905; x=1728908705;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gM96gy8f618bGBajVDpCaKuepjJ0dpUYbsUw4JQ//R4=;
        b=cKkZfLu7Nvt5CYjQhyigZGlQmmctFjGERPVToyT56RGOsZLASMXAMNlgTs4J9UfRJ5
         9f0U+qc5z4lTfgzOJnN0o+yObc9qFuesgnHCH8xuhI22HBx4Qto7CvLtZmU5Ww3cEsL8
         Gnh/wKlGPyAwr3hu4aLUxsB5dkTmUtqalfjS1r6Sp0MA6ZY5ApUi/8j+XO8n3hhQyv1e
         hS+1xWaJugZxfd1o0/ehXgbUi/7ND33OvqUYz3reT4rgmTXWwiuJmF7qbVHrNtBAjrrG
         tewPurdzqXsHEaItrAKMDggq0qR5QJwpKpBFfJq/KDJqpGgvLzZPpoRH+J72LOdHThhv
         7q7g==
X-Forwarded-Encrypted: i=1; AJvYcCXqX6P5eKo8xsY+6Pk9+/4XBrHNfgezGtC8KWFWT1af0//H2dmi8T42cODfFj/437JH+xNuB4Q+QZA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7sT7oYUnUWZ/MEZBS/SDvq1aWZPkss1R4iUW3CtKYt9NaHkvT
	2gp3agBnfqnE9mZcmcHm4Sub1eMew53qtpkApBOx9BoMCHfTtetRCuZcfC5MIszZFq7lk3Rxq6c
	4
X-Google-Smtp-Source: AGHT+IHzmdeyk7BcbsepBbIRiOyd9bViCdVFyVoSqlIqtw/HHX0y/avV8U1WcrVmd8PF5MvJp7Tjrg==
X-Received: by 2002:a05:6a20:d492:b0:1d6:5054:a02 with SMTP id adf61e73a8af0-1d6dfa24d0amr16925290637.2.1728303905288;
        Mon, 07 Oct 2024 05:25:05 -0700 (PDT)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d66695sm4409586b3a.174.2024.10.07.05.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 05:25:04 -0700 (PDT)
Date: Mon, 07 Oct 2024 05:25:04 -0700 (PDT)
X-Google-Original-Date: Mon, 07 Oct 2024 05:25:03 PDT (-0700)
Subject:     Re: [PATCH v1] dma: fix typo in the comment
In-Reply-To: <20240918034114.860132-1-yanzhen@vivo.com>
CC: vkoul@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
  samuel.holland@sifive.com, michal.simek@amd.com, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
  linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, opensource.kernel@vivo.com,
  yanzhen@vivo.com
From: Palmer Dabbelt <palmer@dabbelt.com>
To: yanzhen@vivo.com
Message-ID: <mhng-8b05e8aa-ec7d-4ccf-883f-5e88cd86ad4f@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On Tue, 17 Sep 2024 20:41:14 PDT (-0700), yanzhen@vivo.com wrote:
> Correctly spelled comments make it easier for the reader to understand
> the code.
>
> Replace 'enngine' with 'engine' in the comment &
> replace 'trascatioin' with 'transaction' in the comment &
> replace 'descripter' with 'descriptor' in the comment &
> replace 'descritpor' with 'descriptor' in the comment &
> replace 'rgisters' with 'registers' in the comment.
>
> Signed-off-by: Yan Zhen <yanzhen@vivo.com>
> ---
>  drivers/dma/mv_xor_v2.c         | 2 +-
>  drivers/dma/sf-pdma/sf-pdma.c   | 2 +-

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

for the SiFive stuff.  I'm happy to pick this up via the RISC-V tree if 
people want, but it's mostly for other stuff so I'm going to leave it 
alone for now.

Thanks!

>  drivers/dma/sh/shdma-base.c     | 2 +-
>  drivers/dma/sh/usb-dmac.c       | 2 +-
>  drivers/dma/xilinx/zynqmp_dma.c | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/dma/mv_xor_v2.c b/drivers/dma/mv_xor_v2.c
> index c8c67f4d982c..c6c9702dcca0 100644
> --- a/drivers/dma/mv_xor_v2.c
> +++ b/drivers/dma/mv_xor_v2.c
> @@ -635,7 +635,7 @@ static int mv_xor_v2_descq_init(struct mv_xor_v2_device *xor_dev)
>  	writel(MV_XOR_V2_DESC_NUM,
>  	       xor_dev->dma_base + MV_XOR_V2_DMA_DESQ_SIZE_OFF);
>
> -	/* write the DESQ address to the DMA enngine*/
> +	/* write the DESQ address to the DMA engine*/
>  	writel(lower_32_bits(xor_dev->hw_desq),
>  	       xor_dev->dma_base + MV_XOR_V2_DMA_DESQ_BALR_OFF);
>  	writel(upper_32_bits(xor_dev->hw_desq),
> diff --git a/drivers/dma/sf-pdma/sf-pdma.c b/drivers/dma/sf-pdma/sf-pdma.c
> index 428473611115..538a7bc58108 100644
> --- a/drivers/dma/sf-pdma/sf-pdma.c
> +++ b/drivers/dma/sf-pdma/sf-pdma.c
> @@ -354,7 +354,7 @@ static irqreturn_t sf_pdma_done_isr(int irq, void *dev_id)
>  	if (!residue) {
>  		tasklet_hi_schedule(&chan->done_tasklet);
>  	} else {
> -		/* submit next trascatioin if possible */
> +		/* submit next transaction if possible */
>  		struct sf_pdma_desc *desc = chan->desc;
>
>  		desc->src_addr += desc->xfer_size - residue;
> diff --git a/drivers/dma/sh/shdma-base.c b/drivers/dma/sh/shdma-base.c
> index 588c5f409a80..fdd41e1c2263 100644
> --- a/drivers/dma/sh/shdma-base.c
> +++ b/drivers/dma/sh/shdma-base.c
> @@ -961,7 +961,7 @@ void shdma_chan_probe(struct shdma_dev *sdev,
>
>  	spin_lock_init(&schan->chan_lock);
>
> -	/* Init descripter manage list */
> +	/* Init descriptor manage list */
>  	INIT_LIST_HEAD(&schan->ld_queue);
>  	INIT_LIST_HEAD(&schan->ld_free);
>
> diff --git a/drivers/dma/sh/usb-dmac.c b/drivers/dma/sh/usb-dmac.c
> index f7cd0cad056c..cc7f7ee7f74a 100644
> --- a/drivers/dma/sh/usb-dmac.c
> +++ b/drivers/dma/sh/usb-dmac.c
> @@ -301,7 +301,7 @@ static struct usb_dmac_desc *usb_dmac_desc_get(struct usb_dmac_chan *chan,
>  	struct usb_dmac_desc *desc = NULL;
>  	unsigned long flags;
>
> -	/* Get a freed descritpor */
> +	/* Get a freed descriptor */
>  	spin_lock_irqsave(&chan->vc.lock, flags);
>  	list_for_each_entry(desc, &chan->desc_freed, node) {
>  		if (sg_len <= desc->sg_allocated_len) {
> diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
> index 9ae46f1198fe..18a407975e14 100644
> --- a/drivers/dma/xilinx/zynqmp_dma.c
> +++ b/drivers/dma/xilinx/zynqmp_dma.c
> @@ -366,7 +366,7 @@ static void zynqmp_dma_init(struct zynqmp_dma_chan *chan)
>  	}
>  	writel(val, chan->regs + ZYNQMP_DMA_DATA_ATTR);
>
> -	/* Clearing the interrupt account rgisters */
> +	/* Clearing the interrupt account registers */
>  	val = readl(chan->regs + ZYNQMP_DMA_IRQ_SRC_ACCT);
>  	val = readl(chan->regs + ZYNQMP_DMA_IRQ_DST_ACCT);

