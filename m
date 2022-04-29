Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F66951544F
	for <lists+dmaengine@lfdr.de>; Fri, 29 Apr 2022 21:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380249AbiD2TWn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 29 Apr 2022 15:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbiD2TWm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 29 Apr 2022 15:22:42 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3315BC87D;
        Fri, 29 Apr 2022 12:19:22 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id x33so15754496lfu.1;
        Fri, 29 Apr 2022 12:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=GewZaD4ShNldD9kVxTldC8R8+ax3szTCsyjndG0dRHc=;
        b=N9dj8vM26++XU4q2OakNWAe+5xmjeyCbaGMoZqOwboAgVvBYbJlulrH5X27jQuhhe1
         ieDiZ/H2VimJOfN3PETcE/9Vyf/aB10sSs1kCaR2hCg7ww8AJ453Lxh3Ue2Jq7RCcWPC
         p8YRd9rhICID4KiYVZEpobcpQQO7hDmrhhf8QN03z4sJbGi3o8uUOrv5D62uJavwgdDc
         nNugFvgWEeXynam7aaPpCboM4v6qYxyj2wL70Kr4gWRj73LoA6e6P0Rx69Cf/6S0i+nY
         Y/z1Jua+ZqaqkMkVP/eGdK8+N2BGNyMjUovqH+Vid5e+Nm51ePSpef4FGO7qzB3v+kMp
         grBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GewZaD4ShNldD9kVxTldC8R8+ax3szTCsyjndG0dRHc=;
        b=5Ie1y68KB3M7ZmgTcsEj/UM/fNDRrBGstzztyIgRbbkKC9pkE+8KyvyKV80If9EZn3
         iVdef56ad4M+CUL9CvBRRlU33/EC9fiRw87CSfFjWNkK89yl3U3TFM3GVv06R5h3lbCX
         w8uU64oA4zkrmUFS8BVMhyOQsG7Xks9UVkmrArCEdSnWH8Rp0EGUttZ2Q6ErrLlte++X
         721kk5CqSTxIWk4XdEqdtjzxo1MIn7suBeulQWL7u4VAgT7vodoh+l2rqHY7B0UNre+l
         epZ8PrK83Ei3XX9n1jic0qCb/RMvBWmA5KlAsW82xuegRiE7RVkSmd3H5sQn+wbaehgM
         j7kg==
X-Gm-Message-State: AOAM532eyVKJLxAZlxUCOn1KqphQ1gOu6iMNEf3Dpr74shO5hEP3W/iR
        B/1zu4QgrxSd760x65ofjLM=
X-Google-Smtp-Source: ABdhPJzAWbzjAeNyOkcDPXNnS3q8J0aQzarCCZYnhhzzpmtYQTeo5ige0nogmL+UFHzeq9iCLWrEdA==
X-Received: by 2002:ac2:5f4d:0:b0:448:7d37:5838 with SMTP id 13-20020ac25f4d000000b004487d375838mr496420lfz.419.1651259961018;
        Fri, 29 Apr 2022 12:19:21 -0700 (PDT)
Received: from [10.0.0.42] (91-159-150-230.elisa-laajakaista.fi. [91.159.150.230])
        by smtp.gmail.com with ESMTPSA id t23-20020ac25497000000b0047255d211d5sm3560lfk.260.2022.04.29.12.19.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 12:19:20 -0700 (PDT)
Message-ID: <ee637af8-ea26-78d7-8bd6-e4709c1293f0@gmail.com>
Date:   Fri, 29 Apr 2022 22:26:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 21/41] ARM: omap1: dma: remove omap2 specific bits
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>, linux-omap@vger.kernel.org,
        tony@atomide.com, aaro.koskinen@iki.fi, jmkrzyszt@gmail.com
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Paul Walmsley <paul@pwsan.com>,
        Kevin Hilman <khilman@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Mark Brown <broonie@kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-input@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-serial@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org
References: <20220419133723.1394715-1-arnd@kernel.org>
 <20220419133723.1394715-22-arnd@kernel.org>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <20220419133723.1394715-22-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 4/19/22 16:37, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> No part of plat-omap/dma.c is called on omap2 any more, so
> anything omap2 specific in here can simply be removed.

Reviewed-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/plat-omap/dma.c | 217 ++++++++++-----------------------------
>  1 file changed, 55 insertions(+), 162 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
> index b7757864d0aa..eb14528f133c 100644
> --- a/arch/arm/plat-omap/dma.c
> +++ b/arch/arm/plat-omap/dma.c
> @@ -34,11 +34,9 @@
>  
>  #include <linux/omap-dma.h>
>  
> -#ifdef CONFIG_ARCH_OMAP1
>  #include <mach/hardware.h>
>  #include <linux/soc/ti/omap1-io.h>
>  #include <linux/soc/ti/omap1-soc.h>
> -#endif
>  
>  /*
>   * MAX_LOGICAL_DMA_CH_COUNT: the maximum number of logical DMA
> @@ -51,16 +49,7 @@
>  
>  #undef DEBUG
>  
> -#ifndef CONFIG_ARCH_OMAP1
> -enum { DMA_CH_ALLOC_DONE, DMA_CH_PARAMS_SET_DONE, DMA_CH_STARTED,
> -	DMA_CH_QUEUED, DMA_CH_NOTSTARTED, DMA_CH_PAUSED, DMA_CH_LINK_ENABLED
> -};
> -
> -enum { DMA_CHAIN_STARTED, DMA_CHAIN_NOTSTARTED };
> -#endif
> -
>  #define OMAP_DMA_ACTIVE			0x01
> -#define OMAP2_DMA_CSR_CLEAR_MASK	0xffffffff
>  
>  #define OMAP_FUNC_MUX_ARM_BASE		(0xfffe1000 + 0xec)
>  
> @@ -94,13 +83,9 @@ static inline void omap_disable_channel_irq(int lch)
>  	/* disable channel interrupts */
>  	p->dma_write(0, CICR, lch);
>  	/* Clear CSR */
> -	if (dma_omap1())
> -		p->dma_read(CSR, lch);
> -	else
> -		p->dma_write(OMAP2_DMA_CSR_CLEAR_MASK, CSR, lch);
> +	p->dma_read(CSR, lch);
>  }
>  
> -#ifdef CONFIG_ARCH_OMAP1
>  static inline void set_gdma_dev(int req, int dev)
>  {
>  	u32 reg = OMAP_FUNC_MUX_ARM_BASE + ((req - 1) / 5) * 4;
> @@ -112,11 +97,6 @@ static inline void set_gdma_dev(int req, int dev)
>  	l |= (dev - 1) << shift;
>  	omap_writel(l, reg);
>  }
> -#else
> -#define set_gdma_dev(req, dev)	do {} while (0)
> -#define omap_readl(reg)		0
> -#define omap_writel(val, reg)	do {} while (0)
> -#endif
>  
>  #ifdef CONFIG_ARCH_OMAP1
>  void omap_set_dma_priority(int lch, int dst_port, int priority)
> @@ -181,59 +161,24 @@ void omap_set_dma_transfer_params(int lch, int data_type, int elem_count,
>  				  int dma_trigger, int src_or_dst_synch)
>  {
>  	u32 l;
> +	u16 ccr;
>  
>  	l = p->dma_read(CSDP, lch);
>  	l &= ~0x03;
>  	l |= data_type;
>  	p->dma_write(l, CSDP, lch);
>  
> -	if (dma_omap1()) {
> -		u16 ccr;
> -
> -		ccr = p->dma_read(CCR, lch);
> -		ccr &= ~(1 << 5);
> -		if (sync_mode == OMAP_DMA_SYNC_FRAME)
> -			ccr |= 1 << 5;
> -		p->dma_write(ccr, CCR, lch);
> -
> -		ccr = p->dma_read(CCR2, lch);
> -		ccr &= ~(1 << 2);
> -		if (sync_mode == OMAP_DMA_SYNC_BLOCK)
> -			ccr |= 1 << 2;
> -		p->dma_write(ccr, CCR2, lch);
> -	}
> -
> -	if (dma_omap2plus() && dma_trigger) {
> -		u32 val;
> -
> -		val = p->dma_read(CCR, lch);
> -
> -		/* DMA_SYNCHRO_CONTROL_UPPER depends on the channel number */
> -		val &= ~((1 << 23) | (3 << 19) | 0x1f);
> -		val |= (dma_trigger & ~0x1f) << 14;
> -		val |= dma_trigger & 0x1f;
> -
> -		if (sync_mode & OMAP_DMA_SYNC_FRAME)
> -			val |= 1 << 5;
> -		else
> -			val &= ~(1 << 5);
> -
> -		if (sync_mode & OMAP_DMA_SYNC_BLOCK)
> -			val |= 1 << 18;
> -		else
> -			val &= ~(1 << 18);
> -
> -		if (src_or_dst_synch == OMAP_DMA_DST_SYNC_PREFETCH) {
> -			val &= ~(1 << 24);	/* dest synch */
> -			val |= (1 << 23);	/* Prefetch */
> -		} else if (src_or_dst_synch) {
> -			val |= 1 << 24;		/* source synch */
> -		} else {
> -			val &= ~(1 << 24);	/* dest synch */
> -		}
> -		p->dma_write(val, CCR, lch);
> -	}
> +	ccr = p->dma_read(CCR, lch);
> +	ccr &= ~(1 << 5);
> +	if (sync_mode == OMAP_DMA_SYNC_FRAME)
> +		ccr |= 1 << 5;
> +	p->dma_write(ccr, CCR, lch);
>  
> +	ccr = p->dma_read(CCR2, lch);
> +	ccr &= ~(1 << 2);
> +	if (sync_mode == OMAP_DMA_SYNC_BLOCK)
> +		ccr |= 1 << 2;
> +	p->dma_write(ccr, CCR2, lch);
>  	p->dma_write(elem_count, CEN, lch);
>  	p->dma_write(frame_count, CFN, lch);
>  }
> @@ -241,7 +186,7 @@ EXPORT_SYMBOL(omap_set_dma_transfer_params);
>  
>  void omap_set_dma_channel_mode(int lch, enum omap_dma_channel_mode mode)
>  {
> -	if (dma_omap1() && !dma_omap15xx()) {
> +	if (!dma_omap15xx()) {
>  		u32 l;
>  
>  		l = p->dma_read(LCH_CTRL, lch);
> @@ -258,15 +203,12 @@ void omap_set_dma_src_params(int lch, int src_port, int src_amode,
>  			     int src_ei, int src_fi)
>  {
>  	u32 l;
> +	u16 w;
>  
> -	if (dma_omap1()) {
> -		u16 w;
> -
> -		w = p->dma_read(CSDP, lch);
> -		w &= ~(0x1f << 2);
> -		w |= src_port << 2;
> -		p->dma_write(w, CSDP, lch);
> -	}
> +	w = p->dma_read(CSDP, lch);
> +	w &= ~(0x1f << 2);
> +	w |= src_port << 2;
> +	p->dma_write(w, CSDP, lch);
>  
>  	l = p->dma_read(CCR, lch);
>  	l &= ~(0x03 << 12);
> @@ -304,26 +246,15 @@ void omap_set_dma_src_burst_mode(int lch, enum omap_dma_burst_mode burst_mode)
>  	case OMAP_DMA_DATA_BURST_DIS:
>  		break;
>  	case OMAP_DMA_DATA_BURST_4:
> -		if (dma_omap2plus())
> -			burst = 0x1;
> -		else
> -			burst = 0x2;
> +		burst = 0x2;
>  		break;
>  	case OMAP_DMA_DATA_BURST_8:
> -		if (dma_omap2plus()) {
> -			burst = 0x2;
> -			break;
> -		}
>  		/*
>  		 * not supported by current hardware on OMAP1
>  		 * w |= (0x03 << 7);
>  		 */
>  		fallthrough;
>  	case OMAP_DMA_DATA_BURST_16:
> -		if (dma_omap2plus()) {
> -			burst = 0x3;
> -			break;
> -		}
>  		/* OMAP1 don't support burst 16 */
>  		fallthrough;
>  	default:
> @@ -342,12 +273,10 @@ void omap_set_dma_dest_params(int lch, int dest_port, int dest_amode,
>  {
>  	u32 l;
>  
> -	if (dma_omap1()) {
> -		l = p->dma_read(CSDP, lch);
> -		l &= ~(0x1f << 9);
> -		l |= dest_port << 9;
> -		p->dma_write(l, CSDP, lch);
> -	}
> +	l = p->dma_read(CSDP, lch);
> +	l &= ~(0x1f << 9);
> +	l |= dest_port << 9;
> +	p->dma_write(l, CSDP, lch);
>  
>  	l = p->dma_read(CCR, lch);
>  	l &= ~(0x03 << 14);
> @@ -385,22 +314,12 @@ void omap_set_dma_dest_burst_mode(int lch, enum omap_dma_burst_mode burst_mode)
>  	case OMAP_DMA_DATA_BURST_DIS:
>  		break;
>  	case OMAP_DMA_DATA_BURST_4:
> -		if (dma_omap2plus())
> -			burst = 0x1;
> -		else
> -			burst = 0x2;
> +		burst = 0x2;
>  		break;
>  	case OMAP_DMA_DATA_BURST_8:
> -		if (dma_omap2plus())
> -			burst = 0x2;
> -		else
> -			burst = 0x3;
> +		burst = 0x3;
>  		break;
>  	case OMAP_DMA_DATA_BURST_16:
> -		if (dma_omap2plus()) {
> -			burst = 0x3;
> -			break;
> -		}
>  		/* OMAP1 don't support burst 16 */
>  		fallthrough;
>  	default:
> @@ -416,10 +335,7 @@ EXPORT_SYMBOL(omap_set_dma_dest_burst_mode);
>  static inline void omap_enable_channel_irq(int lch)
>  {
>  	/* Clear CSR */
> -	if (dma_omap1())
> -		p->dma_read(CSR, lch);
> -	else
> -		p->dma_write(OMAP2_DMA_CSR_CLEAR_MASK, CSR, lch);
> +	p->dma_read(CSR, lch);
>  
>  	/* Enable some nice interrupts. */
>  	p->dma_write(dma_chan[lch].enabled_irqs, CICR, lch);
> @@ -437,8 +353,7 @@ static inline void enable_lnk(int lch)
>  
>  	l = p->dma_read(CLNK_CTRL, lch);
>  
> -	if (dma_omap1())
> -		l &= ~(1 << 14);
> +	l &= ~(1 << 14);
>  
>  	/* Set the ENABLE_LNK bits */
>  	if (dma_chan[lch].next_lch != -1)
> @@ -456,15 +371,8 @@ static inline void disable_lnk(int lch)
>  	/* Disable interrupts */
>  	omap_disable_channel_irq(lch);
>  
> -	if (dma_omap1()) {
> -		/* Set the STOP_LNK bit */
> -		l |= 1 << 14;
> -	}
> -
> -	if (dma_omap2plus()) {
> -		/* Clear the ENABLE_LNK bit */
> -		l &= ~(1 << 15);
> -	}
> +	/* Set the STOP_LNK bit */
> +	l |= 1 << 14;
>  
>  	p->dma_write(l, CLNK_CTRL, lch);
>  	dma_chan[lch].flags &= ~OMAP_DMA_ACTIVE;
> @@ -508,8 +416,7 @@ int omap_request_dma(int dev_id, const char *dev_name,
>  
>  	chan->enabled_irqs = OMAP_DMA_DROP_IRQ | OMAP_DMA_BLOCK_IRQ;
>  
> -	if (dma_omap1())
> -		chan->enabled_irqs |= OMAP1_DMA_TOUT_IRQ;
> +	chan->enabled_irqs |= OMAP1_DMA_TOUT_IRQ;
>  
>  	if (dma_omap16xx()) {
>  		/* If the sync device is set, configure it dynamically. */
> @@ -522,7 +429,7 @@ int omap_request_dma(int dev_id, const char *dev_name,
>  		 * id.
>  		 */
>  		p->dma_write(dev_id | (1 << 10), CCR, free_ch);
> -	} else if (dma_omap1()) {
> +	} else {
>  		p->dma_write(dev_id, CCR, free_ch);
>  	}
>  
> @@ -739,8 +646,7 @@ dma_addr_t omap_get_dma_src_pos(int lch)
>  			offset = p->dma_read(CSSA, lch);
>  	}
>  
> -	if (dma_omap1())
> -		offset |= (p->dma_read(CSSA, lch) & 0xFFFF0000);
> +	offset |= (p->dma_read(CSSA, lch) & 0xFFFF0000);
>  
>  	return offset;
>  }
> @@ -778,8 +684,7 @@ dma_addr_t omap_get_dma_dst_pos(int lch)
>  			offset = p->dma_read(CDSA, lch);
>  	}
>  
> -	if (dma_omap1())
> -		offset |= (p->dma_read(CDSA, lch) & 0xFFFF0000);
> +	offset |= (p->dma_read(CDSA, lch) & 0xFFFF0000);
>  
>  	return offset;
>  }
> @@ -796,9 +701,8 @@ int omap_dma_running(void)
>  {
>  	int lch;
>  
> -	if (dma_omap1())
> -		if (omap_lcd_dma_running())
> -			return 1;
> +	if (omap_lcd_dma_running())
> +		return 1;
>  
>  	for (lch = 0; lch < dma_chan_count; lch++)
>  		if (p->dma_read(CCR, lch) & OMAP_DMA_CCR_EN)
> @@ -809,8 +713,6 @@ int omap_dma_running(void)
>  
>  /*----------------------------------------------------------------------------*/
>  
> -#ifdef CONFIG_ARCH_OMAP1
> -
>  static int omap1_dma_handle_ch(int ch)
>  {
>  	u32 csr;
> @@ -863,10 +765,6 @@ static irqreturn_t omap1_dma_irq_handler(int irq, void *dev_id)
>  	return handled ? IRQ_HANDLED : IRQ_NONE;
>  }
>  
> -#else
> -#define omap1_dma_irq_handler	NULL
> -#endif
> -
>  struct omap_system_dma_plat_info *omap_get_plat_info(void)
>  {
>  	return p;
> @@ -912,29 +810,27 @@ static int omap_system_dma_probe(struct platform_device *pdev)
>  		if (ch >= 6 && enable_1510_mode)
>  			continue;
>  
> -		if (dma_omap1()) {
> -			/*
> -			 * request_irq() doesn't like dev_id (ie. ch) being
> -			 * zero, so we have to kludge around this.
> -			 */
> -			sprintf(&irq_name[0], "%d", ch);
> -			dma_irq = platform_get_irq_byname(pdev, irq_name);
> -
> -			if (dma_irq < 0) {
> -				ret = dma_irq;
> -				goto exit_dma_irq_fail;
> -			}
> -
> -			/* INT_DMA_LCD is handled in lcd_dma.c */
> -			if (dma_irq == INT_DMA_LCD)
> -				continue;
> -
> -			ret = request_irq(dma_irq,
> -					omap1_dma_irq_handler, 0, "DMA",
> -					(void *) (ch + 1));
> -			if (ret != 0)
> -				goto exit_dma_irq_fail;
> +		/*
> +		 * request_irq() doesn't like dev_id (ie. ch) being
> +		 * zero, so we have to kludge around this.
> +		 */
> +		sprintf(&irq_name[0], "%d", ch);
> +		dma_irq = platform_get_irq_byname(pdev, irq_name);
> +
> +		if (dma_irq < 0) {
> +			ret = dma_irq;
> +			goto exit_dma_irq_fail;
>  		}
> +
> +		/* INT_DMA_LCD is handled in lcd_dma.c */
> +		if (dma_irq == INT_DMA_LCD)
> +			continue;
> +
> +		ret = request_irq(dma_irq,
> +				omap1_dma_irq_handler, 0, "DMA",
> +				(void *) (ch + 1));
> +		if (ret != 0)
> +			goto exit_dma_irq_fail;
>  	}
>  
>  	/* reserve dma channels 0 and 1 in high security devices on 34xx */
> @@ -954,9 +850,6 @@ static int omap_system_dma_remove(struct platform_device *pdev)
>  {
>  	int dma_irq, irq_rel = 0;
>  
> -	if (dma_omap2plus())
> -		return 0;
> -
>  	for ( ; irq_rel < dma_chan_count; irq_rel++) {
>  		dma_irq = platform_get_irq(pdev, irq_rel);
>  		free_irq(dma_irq, (void *)(irq_rel + 1));

-- 
Péter
