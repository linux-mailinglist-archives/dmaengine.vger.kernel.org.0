Return-Path: <dmaengine+bounces-2770-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F57A945576
	for <lists+dmaengine@lfdr.de>; Fri,  2 Aug 2024 02:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80129B22B15
	for <lists+dmaengine@lfdr.de>; Fri,  2 Aug 2024 00:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD26FC11;
	Fri,  2 Aug 2024 00:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J6Q0NI7M"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7298D520;
	Fri,  2 Aug 2024 00:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722558888; cv=none; b=h0Rd/B8HGN9QEBKthX0vDaPaa+9h+IE2BlXcGLHbgE4L3IzwDaOX4SKGLSBJyoAoVk8wRGbRD2AWcmEPAizokGfMJodI45zI8++Ve8heKdwcZstLPLk+hf5Yy9E0Fu3jbYCkWjYtqnhY+62Lx1k+Isyoztyv2YpsD3QG2lcsVaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722558888; c=relaxed/simple;
	bh=ZVhOko/Es2Cy0eD/eIbDqzj6uBX2CIFzIfGTkRBHbXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mOLHwzO1wj6YLlUH64sIfVz03hJ+rEXZZV+YI3Uf0Sh+p38ZAxMG731Bx4rdbF9p6dJ0Zk/0ENLhu3n1R91zQLmRta9QGBOiLOppQ4jHld00h9all09zqrMT6KttYUpabEDTg9z7eX4ZUph1L+rInGsFvlSP2bhQZwtP8HikYMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J6Q0NI7M; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2f035ae0fe0so87855071fa.3;
        Thu, 01 Aug 2024 17:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722558885; x=1723163685; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r4TxVSYutmdmVBr6Vm91nJQyTFo86VmYkWwujCrGEo4=;
        b=J6Q0NI7MS46sCeDNXH9iwPZF4u1qCCoIutMnrdP00mgqhFI8nxTBdrmx9zaMbIaH2/
         1wHBfBPZZ1f8kAjFDEhwQQz30Orwe3EXcQZJ8fFS3xQ06so442LfwGJtvAYTLgNXsMVW
         4oICNHs04/ouXPYpSN8DprgxXAr3AFvNR89XeLoOA4TjKZSiVM214hSMJCS+7aBH+QOp
         Uh+AXoDoe1BDs/PApApDDyIQKPozMOxXEPZ/U6zkT9lGnlP9ZmPqdmMZAjFAyeBeE/9/
         qFbD9/CFekvxOP5/cGF7IgMovlPOqzcJXcP+Z3YuKdqkiGFynwOfiRQUviFJE+Hlongw
         JwjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722558885; x=1723163685;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r4TxVSYutmdmVBr6Vm91nJQyTFo86VmYkWwujCrGEo4=;
        b=oHnYFzBlLrzgkhduq91smi0EFizPL2DpPev9VxDCj/7v3b2INnQ4wwfas6TZqqEbhB
         zQi8IHlllN7OeW5BaMSC2V0j9MvUoEZsbZoReSu0DAV7koocLH6AmEJ1M/hMxX8eZKWo
         y+tv3w7MIdkthohWWy/TBp30U77bD75MwerLo+yK1ZMm91Gljwe0BV5Jt+L3x8cwsztG
         tK4JhGF/bIpni1BUJpXOZVIw8LYDnDrpqZDjMlyqIhyHhH5xAM7Hp4JRFPIupVkG6RsA
         fojWImollCYdP2oeYEqwtDwFEkLa7klYHv8ULuqk9zuAx0JUaDQO9c+/ZDv0bzrh38NK
         T1QA==
X-Forwarded-Encrypted: i=1; AJvYcCXoik333iOg6RI5XyqNmXCnUl4nMktO1mRmwPm0jKXKc1SFPq05TKWlGvB5uZCZr5G8zNrV+XU5GNQJkuVuv5gYWTYHiOdO4oBCJJtf79YjS6MGybkTmQVUDMuIfAMBox8sHnYos3hMmMqe24ttWn6jLDFO8CjsGKuLevv4/LWs
X-Gm-Message-State: AOJu0YyfRt4Ux7J9+q8m6Bm+8Ofi1NJgCdj+e60zHdsDDUqsBaJvBpMR
	Q/3ndwDVY4r79jG5E80eDr2TscXmV2wMd0BaCkIlqf8k3aUeMUw2
X-Google-Smtp-Source: AGHT+IG/FMK3bNVlrP15HVAL29rwgIgSr3VJBp7bNTiL3KfUs6zHWiqpafjB1eMUpCtsYUlpQ6PkVw==
X-Received: by 2002:a05:651c:104d:b0:2ee:494c:c3d3 with SMTP id 38308e7fff4ca-2f15ab395afmr11770781fa.43.1722558884154;
        Thu, 01 Aug 2024 17:34:44 -0700 (PDT)
Received: from mobilestation ([176.213.10.205])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f15e250619sm362831fa.79.2024.08.01.17.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 17:34:43 -0700 (PDT)
Date: Fri, 2 Aug 2024 03:34:41 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Mrinmay Sarkar <quic_msarkar@quicinc.com>
Cc: manivannan.sadhasivam@linaro.org, vkoul@kernel.org, 
	quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com, quic_ramkri@quicinc.com, 
	quic_nayiluri@quicinc.com, quic_krichai@quicinc.com, quic_vbadigan@quicinc.com, 
	stable@vger.kernel.org, Cai Huoqing <cai.huoqing@linux.dev>, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dmaengine: dw-edma: Do not enable watermark
 interrupts for HDMA
Message-ID: <mhfcw7yuv55me2d7kf6jh3eggzebq6riv5im4nbvx6qrzsg2mr@xpq3srpzemkb>
References: <1721740773-23181-1-git-send-email-quic_msarkar@quicinc.com>
 <1721740773-23181-3-git-send-email-quic_msarkar@quicinc.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1721740773-23181-3-git-send-email-quic_msarkar@quicinc.com>

On Tue, Jul 23, 2024 at 06:49:32PM +0530, Mrinmay Sarkar wrote:
> DW_HDMA_V0_LIE and DW_HDMA_V0_RIE are initialized as BIT(3) and BIT(4)
> respectively in dw_hdma_control enum. But as per HDMA register these
> bits are corresponds to LWIE and RWIE bit i.e local watermark interrupt
> enable and remote watermarek interrupt enable. In linked list mode LWIE
> and RWIE bits only enable the local and remote watermark interrupt.
> 
> Since the watermark interrupts are not used but enabled, this leads to
> spurious interrupts getting generated. So remove the code that enables
> them to avoid generating spurious watermark interrupts.
> 
> And also rename DW_HDMA_V0_LIE to DW_HDMA_V0_LWIE and DW_HDMA_V0_RIE to
> DW_HDMA_V0_RWIE as there is no LIE and RIE bits in HDMA and those bits
> are corresponds to LWIE and RWIE bits.
> 
> Fixes: e74c39573d35 ("dmaengine: dw-edma: Add support for native HDMA")
> cc: stable@vger.kernel.org
> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
> ---
>  drivers/dma/dw-edma/dw-hdma-v0-core.c | 17 +++--------------
>  1 file changed, 3 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> index fa89b3a..9ad2e28 100644
> --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> @@ -17,8 +17,8 @@ enum dw_hdma_control {
>  	DW_HDMA_V0_CB					= BIT(0),
>  	DW_HDMA_V0_TCB					= BIT(1),
>  	DW_HDMA_V0_LLP					= BIT(2),
> -	DW_HDMA_V0_LIE					= BIT(3),
> -	DW_HDMA_V0_RIE					= BIT(4),
> +	DW_HDMA_V0_LWIE					= BIT(3),
> +	DW_HDMA_V0_RWIE					= BIT(4),
>  	DW_HDMA_V0_CCS					= BIT(8),
>  	DW_HDMA_V0_LLE					= BIT(9),
>  };
> @@ -195,25 +195,14 @@ static void dw_hdma_v0_write_ll_link(struct dw_edma_chunk *chunk,
>  static void dw_hdma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
>  {
>  	struct dw_edma_burst *child;
> -	struct dw_edma_chan *chan = chunk->chan;
>  	u32 control = 0, i = 0;
> -	int j;
>  
>  	if (chunk->cb)
>  		control = DW_HDMA_V0_CB;
>  
> -	j = chunk->bursts_alloc;
> -	list_for_each_entry(child, &chunk->burst->list, list) {
> -		j--;
> -		if (!j) {
> -			control |= DW_HDMA_V0_LIE;
> -			if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
> -				control |= DW_HDMA_V0_RIE;
> -		}
> -
> +	list_for_each_entry(child, &chunk->burst->list, list)
>  		dw_hdma_v0_write_ll_data(chunk, i++, control, child->sz,
>  					 child->sar, child->dar);
> -	}

Hm, in case of DW EDMA the LIE/RIE flags of the LL entries gets to be
moved to the LIE/RIE flags of the channel context register by the
DMA-engine. In its turn the context register LIE/RIE flags determine
whether the Local and Remote Done/Abort IRQs being raised. So without
the LIE/RIE flags being set in the LL-entries the IRQs won't be raised
and the whole procedure won't work. I have doubts it works differently
in case of HDMA because changing the semantics would cause
implementing additional logic in the DW HDMA RTL-model. Seeing the DW
HDMA IP-core supports the eDMA compatibility mode it would needlessly
expand the controller size. What are the rest of the CONTROL1 register
fields? There must be LIE/RIE flags someplace there for the non-LL
transfers and to preserve the values retrieved from the LL-entries.

Moreover the DW eDMA HW manual has a dedicated chapter called
"Interrupts and Error Handling" with a very demonstrative figures
describing the way the flags work. Does the DW HDMA databook have
something like that?

Please also note, the DW _EDMA_ LIE and RIE flags can be also utilized
for the intermediate IRQ raising, to implement the runtime LL-entries
recycling pattern. The IRQ in that case is called as "watermark" IRQ
in the DW EDMA HW databook, but the flags are still called as just
LIE/RIE.

-Serge(y)

>  
>  	control = DW_HDMA_V0_LLP | DW_HDMA_V0_TCB;
>  	if (!chunk->cb)
> -- 
> 2.7.4
> 

