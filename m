Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D95280723
	for <lists+dmaengine@lfdr.de>; Sat,  3 Aug 2019 18:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387653AbfHCQBo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 3 Aug 2019 12:01:44 -0400
Received: from smtp.domeneshop.no ([194.63.252.55]:33640 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387464AbfHCQBn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 3 Aug 2019 12:01:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org; s=ds201810;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=FVVDDc3qcCOsDzVHjJvBttU1tFjf1MY/wUz+c8T/9Js=;
        b=XPUC40aDylcelt6AwUjRPrre7+jPfAoWRzu66fOZY7TSgGf1EfVFG+oRzEiX/PqNzam9vsvaZqQk5NqmEeXcg/HlVhujjuBsjohpTYiSvD655VJ78dFLXcw+j7KXdK4KcEMGbhgPimjredtCZLKeFDueAdDdswSgkIBr2MoTLxerJS+t+K1lHRrfBpgX1wSb40yYcmU5fhTOCbDHCmX1Iyp5NSxK2yigZdeFisifsJMcmLH1cOGNe5ClQdLc09wEeUEcLwJncZL66kZfBRlHOAoqOpERHqWYDUnJ42pvGFHISiLj5v3+nDSlumvjR1tp4RtFZVV/MHOqpiNgg5WPsA==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:53009 helo=[192.168.10.173])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <noralf@tronnes.org>)
        id 1htwTT-0003PB-E8; Sat, 03 Aug 2019 18:01:39 +0200
Subject: Re: [PATCH 00/10] Raspberry Pi SPI speedups
To:     Lukas Wunner <lukas@wunner.de>, Mark Brown <broonie@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Stefan Wahren <wahrenst@gmx.net>, linux-spi@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com
Cc:     Eric Anholt <eric@anholt.net>, Nuno Sa <nuno.sa@analog.com>,
        Martin Sperl <kernel@martin.sperl.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Florian Kauer <florian.kauer@koalo.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
References: <cover.1564825752.git.lukas@wunner.de>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <7e3eda3e-838a-fb08-b543-a3c576f11ea6@tronnes.org>
Date:   Sat, 3 Aug 2019 18:01:27 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <cover.1564825752.git.lukas@wunner.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



Den 03.08.2019 12.10, skrev Lukas Wunner:
> So far the BCM2835 SPI driver cannot cope with TX-only and RX-only
> transfers (rx_buf or tx_buf is NULL) when using DMA:  It relies on
> the SPI core to convert them to full-duplex transfers by allocating
> and DMA-mapping a dummy rx_buf or tx_buf.  This costs performance.
> 
> Resolve by pre-allocating reusable DMA descriptors which cyclically
> clear the RX FIFO (for TX-only transfers) or zero-fill the TX FIFO
> (for RX-only transfers).  Patch [07/10] provides some numbers for
> the achieved latency improvement and CPU time reduction with an
> SPI Ethernet controller.  SPI displays should see a similar speedup.
> I've also made an effort to reduce peripheral and memory bus accesses.
> 
> The series is meant to be applied on top of broonie/for-next.
> It can be applied to Linus' current tree if commit
> 8d8bef503658 ("spi: bcm2835: Fix 3-wire mode if DMA is enabled")
> is cherry-picked from broonie's repo beforehand.
> 
> Please review and test.  Thank you.
> 

Tested-by: Noralf Trønnes <noralf@tronnes.org>

I've tested on a 320x240 RGB565 display, flipping 2 framebuffers as fast
as possible. The buffers are 320x240x2=150kB which are maxsize split by
spi-bcm2835.

I see a small increase in speed from ~34.75 to ~35.55 fps using this series.

Details:

$ ~/libdrm/tests/modetest/modetest -M mi0283qt -s 31:320x240@RG16 -v
setting mode 320x240-0Hz@RG16 on connectors 31, crtc 34
freq: 30.36Hz
freq: 35.32Hz
freq: 35.56Hz
freq: 35.57Hz
freq: 35.54Hz
freq: 35.55Hz
freq: 35.60Hz
freq: 35.62Hz
freq: 35.50Hz
freq: 35.23Hz
freq: 35.49Hz
freq: 35.44Hz
freq: 35.39Hz
freq: 35.58Hz

$ od --endian big -tu4 -An
/sys/bus/spi/devices/spi0.0/of_node/spi-max-frequency
   64000000

<skip those that are zero>
pi@pi2835:~$ tail -n +1 /sys/bus/spi/devices/spi0.0/statistics/*
==> /sys/bus/spi/devices/spi0.0/statistics/bytes <==
131644720
==> /sys/bus/spi/devices/spi0.0/statistics/bytes_rx <==
2
==> /sys/bus/spi/devices/spi0.0/statistics/bytes_tx <==
131644718
==> /sys/bus/spi/devices/spi0.0/statistics/messages <==
5188
==> /sys/bus/spi/devices/spi0.0/statistics/spi_sync <==
5188
==> /sys/bus/spi/devices/spi0.0/statistics/spi_sync_immediate <==
5188
==> /sys/bus/spi/devices/spi0.0/statistics/transfer_bytes_histo_0-1 <==
2609
==>
/sys/bus/spi/devices/spi0.0/statistics/transfer_bytes_histo_16384-32767 <==
857
==> /sys/bus/spi/devices/spi0.0/statistics/transfer_bytes_histo_2-3 <==
5
==>
/sys/bus/spi/devices/spi0.0/statistics/transfer_bytes_histo_32768-65535 <==
1714
==> /sys/bus/spi/devices/spi0.0/statistics/transfer_bytes_histo_4-7 <==
1717
==> /sys/bus/spi/devices/spi0.0/statistics/transfer_bytes_histo_8-15 <==
2
==> /sys/bus/spi/devices/spi0.0/statistics/transfers <==
6904
==> /sys/bus/spi/devices/spi0.0/statistics/transfers_split_maxsize <==
857


Noralf.

