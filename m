Return-Path: <dmaengine+bounces-7305-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7521DC7F73A
	for <lists+dmaengine@lfdr.de>; Mon, 24 Nov 2025 10:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 610374E2E6B
	for <lists+dmaengine@lfdr.de>; Mon, 24 Nov 2025 09:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE76436D501;
	Mon, 24 Nov 2025 09:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="B2Mo11Z+"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD23525BEF8
	for <dmaengine@vger.kernel.org>; Mon, 24 Nov 2025 09:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763974909; cv=none; b=asdBH16xAhOrpLl7MUHQJECB8lHu81rv8mf4zcyz2IcsIK4X67oTtKflZdwgW86t/Via+mIsMMWcSNRQaaLlBQqjyBKtiZmdBMe/r8n2/lKIvn3IAdkRrw+j2nnCt3YXpScfzKfxH2ZiN0EXTe6moZUcpZnZNbWTeyW2blhBem8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763974909; c=relaxed/simple;
	bh=9HDxsuDK4Usuf4fFg1Su4y9i5l8Na+Uqsdy5sZXmG8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fQHutVoiVtIGPvzI6KalYAuOtyhA6/ELMKBdc6nqmVJVtvajafH9tRfhVBwY/XsmQ/lz/DQh/GE2gec4fUI5V6Cu0nRzmyrC1b8sOIj878bxOInY+Y9wz50mX4l3E4p3plRcGrnl1T/uz2KlHV78rt3mhTp9CHj4ceZ+iQjj5rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=B2Mo11Z+; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42b3377aaf2so2267657f8f.2
        for <dmaengine@vger.kernel.org>; Mon, 24 Nov 2025 01:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1763974906; x=1764579706; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6nBgH6OeWos1+QO/ftng5YHCteHUXL03O59bd8c4DFQ=;
        b=B2Mo11Z+OsTdlcmdm99gCyQvnxiVflV81NPjETqXpjiHvGazKvRzqF9XhULdY4tED6
         g4R1GVWOkxVk6V06+GvngOw7ZMF1h0i8p3Od8/V7lJnxG5A9epn6fi6l9GZ3UaMQdN8R
         ck0WclMlennuv0IJ2IkwETrAkXHmPAmsDkfgl4iEuApzEQpBZIax5fu9s9tBeP8ZdSBK
         TXH+EvbiHYEa8Vzpn+VlA3OAc3eNQPuMKkxXifOagYJxGBIbz9N5a/UE+cDKaaBNi1Md
         HHtYfv04Q8WRdXDiHHbb4WgL/02RIMIxf5931Kh/1EP5C0HHbT7EcL1IIo9KGh3lE37j
         dbXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763974906; x=1764579706;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6nBgH6OeWos1+QO/ftng5YHCteHUXL03O59bd8c4DFQ=;
        b=p2CQUWiKKzGWyWrqQgxKiUTkdTovOPZcJY1/pirs2TojcVERMCVCyvplrrtFTVtLWf
         Vz8IHjWSbvnzMjIps3c4EXd3E3npTk7AzhEOO34Irx8DkSKiVX1ChrKPPrwcrkFI4cWX
         vprNeHRffOORvQpS8Aj6LsmfmZGywW/ipka6w5Lb7g4Y9BjaHtKgmgNXWjTbEEIS9Hap
         tNdoEWa3ScfiXIH7AjEAD36TBv8KOe445ePZttlnS6OeUER/qgRHCc255QncuQH8HeIO
         L0r5eEJ9r2jDkusDM68o5hSoEfi5cylTzZz2ENn3gz3tc7NDfr9ZrkT9eXX+uCXPHCLz
         ActA==
X-Forwarded-Encrypted: i=1; AJvYcCX1WkH7nYcgEs562dDLxz30mWS7DInKqdoI3hizxUEUErvbalAze8fSnA1WQSBz7kgjcsv+YRANLR4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjO3oRykAGpZD27/A9NZyxZcvda9BMaK6XDnvJsEmD5Ov/kEJh
	65RVEb5okgruVn2qsMUtGtkigmhYA3cprAC1LoDwjmuuEImow/hcSucfzWrSlNIiQEs=
X-Gm-Gg: ASbGncso0NAkIzv77sx0rNGYZ2jwJZl3lJZhaznCPCtwP0XJFdDnSu4FlWalhJK1fky
	ReNbdFCkaItX9wBp86IIW67X1PAO5O2VrA5L/CKeOUpO5MOIfc8Uc1JGxOzB4Rx9vD2hBQ5YB8y
	d6/9+Rfrg1Zs6UI73f8+3OLFQpE0gfSGT6oy7Pz0mIBuRsD1MiKMcjvv+OrKG2/XiM8V9r1CJ+J
	7cDj4Le9EFVTfC/joYSjb4Vjm1cVtcRfy3iOs1pTViRSY4uiVYrT9LW8qJAoWB2/YCUW62URjYz
	vvozvthUR5EEZUr1ymFAbozIUbWYCF27fHxzonDd/KF/7719oy0smt1J6goZmErrNMwcQ0Ps59w
	3Op3nESWSwqXc7mqWw+3cwFZReS7DoBRmg/DfYkEjKkrki3adAK3yM5zm9k43V+YOz46oGBGsrN
	nxAIkK+Xa6SmPX5BlleQGfijWAIlQK4g==
X-Google-Smtp-Source: AGHT+IHpqwyo6K5TdqE2KfSegPDXC/WvD0IxtuuZUq85wkwa8CWfc6Ew15Et9fQbxFWP3fbI3xvJKQ==
X-Received: by 2002:a05:6000:220e:b0:42b:3dbe:3a54 with SMTP id ffacd0b85a97d-42cc1cbd338mr10590267f8f.17.1763974905896;
        Mon, 24 Nov 2025 01:01:45 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7f34fd1sm27603538f8f.11.2025.11.24.01.01.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Nov 2025 01:01:45 -0800 (PST)
Message-ID: <4f21e13c-b37d-4614-94c9-4cb89017539f@tuxon.dev>
Date: Mon, 24 Nov 2025 11:01:44 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: sh: rz-dmac: Fix rz_dmac_terminate_all()
To: Biju Das <biju.das.jz@bp.renesas.com>, Vinod Koul <vkoul@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org, Biju Das <biju.das.au@gmail.com>,
 linux-renesas-soc@vger.kernel.org, stable@kernel.org
References: <20251106125256.122133-1-biju.das.jz@bp.renesas.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <20251106125256.122133-1-biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/6/25 14:52, Biju Das wrote:
> After audio full duplex testing, playing the recorded file contains a few
> playback frames for the first time. The rz_dmac_terminate_all() does not
> reset all the hardware descriptors queued previously, leading to the wrong
> descriptor being picked up during the next DMA transfer. Fix this issue by
> resetting all descriptor headers for a channel in rz_dmac_terminate_all()
> as rz_dmac_lmdesc_recycle() points to the proper descriptor header filled
> by the rz_dmac_prepare_descs_for_slave_sg().
> 
> Cc: stable@kernel.org
> Fixes: 5000d37042a6 ("dmaengine: sh: Add DMAC driver for RZ/G2L SoC")
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

> ---
>  drivers/dma/sh/rz-dmac.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
> index 1f687b08d6b8..3087bbd11d59 100644
> --- a/drivers/dma/sh/rz-dmac.c
> +++ b/drivers/dma/sh/rz-dmac.c
> @@ -557,11 +557,16 @@ rz_dmac_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
>  static int rz_dmac_terminate_all(struct dma_chan *chan)
>  {
>  	struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
> +	struct rz_lmdesc *lmdesc = channel->lmdesc.base;
>  	unsigned long flags;
> +	unsigned int i;
>  	LIST_HEAD(head);
>  
>  	rz_dmac_disable_hw(channel);
>  	spin_lock_irqsave(&channel->vc.lock, flags);
> +	for (i = 0; i < DMAC_NR_LMDESC; i++)
> +		lmdesc[i].header = 0;
> +
>  	list_splice_tail_init(&channel->ld_active, &channel->ld_free);
>  	list_splice_tail_init(&channel->ld_queue, &channel->ld_free);
>  	vchan_get_all_descriptors(&channel->vc, &head);


