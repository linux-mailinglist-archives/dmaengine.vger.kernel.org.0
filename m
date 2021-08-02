Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 049433DD0D6
	for <lists+dmaengine@lfdr.de>; Mon,  2 Aug 2021 08:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232297AbhHBG6B (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 2 Aug 2021 02:58:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:54258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231410AbhHBG6B (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 2 Aug 2021 02:58:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 66BE060F11;
        Mon,  2 Aug 2021 06:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627887472;
        bh=rXv/V219Iq9Dj/9J2Kc7l/iH5bQ7K0iwclj82DEEgbI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QhqMeE5gV4gtlIYrpAwjLC2gAeFgaM0+c7lkNw+uf9/U/u1ruUBS2gCjOHeb4RALj
         Bghia3zCSjrkTquUJbTAERMgs2RoR5kabqbFRXkBAOW9R0kjyg8gCFK8tRGD3NpnXF
         q3YzNV9B72XLZOriikLb/Q4MmEA2X0OGc9KCbk9WDLU//opvJipQUFuWF5KicQkRNW
         p4w781y+9DlS27mD1mNl1nPpPNPEuxKA8m0DZeE/+5zZDVU5ZO2u2q96gnc2EC5b2c
         x/HhPx8sn2mgCi/DcNmn7M/KLNTDPNNxl8vAjCFQfP1v/YC4KMtLEkkLIlmcDcXDbT
         gyQKaXc5mnRDw==
Date:   Mon, 2 Aug 2021 12:27:48 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 5/8] dmaengine: ep93xx: Prepare clock before using it
Message-ID: <YQeXbGNVKJjhNfHT@matsya>
References: <20210726115058.23729-1-nikita.shubin@maquefel.me>
 <20210726140001.24820-1-nikita.shubin@maquefel.me>
 <20210726140001.24820-6-nikita.shubin@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210726140001.24820-6-nikita.shubin@maquefel.me>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 26-07-21, 16:59, Nikita Shubin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> 
> Use clk_prepare_enable()/clk_disable_unprepare() in preparation for switch
> to Common Clock Framework, otherwise the following is visible:
> 
> WARNING: CPU: 0 PID: 1 at drivers/clk/clk.c:1011 clk_core_enable+0x9c/0xbc
> Enabling unprepared m2p0
> ...
> Hardware name: Cirrus Logic EDB9302 Evaluation Board
> ...
> clk_core_enable
> clk_core_enable_lock
> ep93xx_dma_alloc_chan_resources
> dma_chan_get
> find_candidate
> __dma_request_channel
> snd_dmaengine_pcm_request_channel
> dmaengine_pcm_new
> snd_soc_pcm_component_new
> soc_new_pcm
> snd_soc_bind_card
> edb93xx_probe
> ...
> ep93xx-i2s ep93xx-i2s: Missing dma channel for stream: 0
> ep93xx-i2s ep93xx-i2s: ASoC: error at snd_soc_pcm_component_new on ep93xx-i2s: -22
> edb93xx-audio edb93xx-audio: ASoC: can't create pcm CS4271 HiFi :-22
> edb93xx-audio edb93xx-audio: snd_soc_register_card() failed: -22
> edb93xx-audio: probe of edb93xx-audio failed with error -22

Applied, thanks

-- 
~Vinod
