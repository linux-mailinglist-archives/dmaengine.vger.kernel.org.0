Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D71A550248
	for <lists+dmaengine@lfdr.de>; Mon, 24 Jun 2019 08:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbfFXG3T (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 24 Jun 2019 02:29:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:34076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726334AbfFXG3T (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 24 Jun 2019 02:29:19 -0400
Received: from localhost (unknown [106.201.35.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FA1D20679;
        Mon, 24 Jun 2019 06:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561357758;
        bh=2TQRe3QkhnUJy/2JQY1vTTVylzKrx/xWJfWzJ6o3RiE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rGBMJXhwNue1MqIZfA88N+ylezEMzckRFHzw/Z9skTub1kEKtlDyEG+sZgNExhJlH
         2iLgT3nAdnk4c4Tx8Rzztj/3X2uNeZXtc93wuY/0IMPn6xARWj6DrZNcswpQ1r8f3y
         ALZlKuGj2kms+tMtZJ/fbUijendUriAkh9lZEurI=
Date:   Mon, 24 Jun 2019 11:56:09 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     dan.j.williams@intel.com, tiwai@suse.com, jonathanh@nvidia.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        sharadg@nvidia.com, rlokhande@nvidia.com, dramesh@nvidia.com,
        mkumard@nvidia.com
Subject: Re: [PATCH] [RFC] dmaengine: add fifo_size member
Message-ID: <20190624062609.GV2962@vkoul-mobl>
References: <20190502122506.GP3845@vkoul-mobl.Dlink>
 <3368d1e1-0d7f-f602-5b96-a978fcf4d91b@nvidia.com>
 <20190504102304.GZ3845@vkoul-mobl.Dlink>
 <ce0e9c0b-b909-54ae-9086-a1f0f6be903c@nvidia.com>
 <20190506155046.GH3845@vkoul-mobl.Dlink>
 <b7e28e73-7214-f1dc-866f-102410c88323@nvidia.com>
 <20190613044352.GC9160@vkoul-mobl.Dlink>
 <09929edf-ddec-b70e-965e-cbc9ba4ffe6a@nvidia.com>
 <20190618043308.GJ2962@vkoul-mobl>
 <23474b74-3c26-3083-be21-4de7731a0e95@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23474b74-3c26-3083-be21-4de7731a0e95@nvidia.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 20-06-19, 15:59, Sameer Pujar wrote:

> > > > So can you explain me what is the difference here that the peripheral
> > > > cannot configure and use burst size with passing fifo depth?
> > > Say for example FIFO_THRESHOLD is programmed as 16 WORDS, BURST_SIZE as 8
> > > WORDS.
> > > ADMAIF does not push data to AHUB(operation [2]) till threshold of 16 WORDS
> > > is
> > > reached in ADMAIF FIFO. Hence 2 burst transfers are needed to reach the
> > > threshold.
> > > As mentioned earlier, threshold here is to just indicate when data transfer
> > > can happen
> > > to AHUB modules.
> > So we have ADMA and AHUB and peripheral. You are talking to AHUB and that
> > is _not_ peripheral and if I have guess right the fifo depth is for AHUB
> > right?
> Yes the communication is between ADMA and AHUB. ADMAIF is the interface
> between
> ADMA and AHUB. ADMA channel sending data to AHUB pairs with ADMAIF TX
> channel.
> Similary ADMA channel receiving data from AHUB pairs with ADMAIF RX channel.
> FIFO DEPTH we are talking is about each ADMAIF TX/RX channel and it is
> configurable.
> DMA transfers happen to/from ADMAIF FIFOs and whenever data(per WORD) is
> popped/pushed
> out of ADMAIF to/from AHUB, asseration is made to ADMA. ADMA keeps counters
> based on
> these assertions. By knowing FIFO DEPTH and these counters, ADMA knows when
> to wait or
> when to transfer data.

Where does ADMAIF driver reside in kernel, who configures it for normal
dma txns..?

Also it wold have helped the long discussion if that part was made clear
rather than talking about peripheral all this time :(

-- 
~Vinod
