Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25AC7740F7A
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jun 2023 12:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbjF1K6B (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 28 Jun 2023 06:58:01 -0400
Received: from sender4-op-o15.zoho.com ([136.143.188.15]:17530 "EHLO
        sender4-op-o15.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbjF1K5q (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 28 Jun 2023 06:57:46 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1687949856; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=lolKdYMH9//FJVcezcjoakLi76Mmm4I4NkH/Y7xn+/lrXv4B4oKoSNLwZTj+mmzc1VAAkzRm2J2LvQyG01+1sCJtuA5+Hkbeo2s8zuVWwbYxD0tg8AdhzCdHfQVrH+muCxA6u6MM3X8Jfi/z8KRUwVjKIDoXpZTls5L/CXM4FFQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1687949856; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=8K+nKJ/3xWzEx5rKzAeQMHMskxt0a3+GGU9b7FhFp3s=; 
        b=UcU8Cm9ggl//3w9KPfMVPfKPbxmtjbOf4yZ4rxc2gWz/P7Y7bp/zPAI7uC8HpvJaGu8U+WKy94REob/FtAu+v5r2F+fqb1Ifs+p7XJ3TUcDNrYYalq5qEEqs8SxDvLBmQuDWXTBh1hHLKtR8yW8pqhRVbswiGbW18EvCeRFFSMU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=linux.beauty;
        spf=pass  smtp.mailfrom=me@linux.beauty;
        dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1687949856;
        s=zmail; d=linux.beauty; i=me@linux.beauty;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=8K+nKJ/3xWzEx5rKzAeQMHMskxt0a3+GGU9b7FhFp3s=;
        b=mgZmAbtGcHQn+Khka68nTsRpnKZgg0RQBLABueHMqI8Y7oF8AMmCNpPEUO/YvM5Y
        QJDJTYhsAxUU8bETq4gCF4pqrXJR+XfSS4vi8aKr8r4yoTAtLy0AcP6CVgfjecy8G8O
        xa1T+eAWgHox24GI7UpagUuDdmGg049BUqIgExtk=
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1687949855751748.7272600539072; Wed, 28 Jun 2023 03:57:35 -0700 (PDT)
Date:   Wed, 28 Jun 2023 18:57:35 +0800
From:   Li Chen <me@linux.beauty>
To:     "dmaengine" <dmaengine@vger.kernel.org>,
        "linux-arm-kernel" <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>
Cc:     "Arnd Bergmann" <arnd@arndb.de>
Message-ID: <18901a6cbf0.c9e3e099688173.4166132371304083225@linux.beauty>
In-Reply-To: 
Subject: Should dma_map_single take the dma controller or its consumer as an
 argument?
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi all,

I recently encountered an issue where the dma_mask was set in the DMA controller's driver, but the consumer peripheral driver didn't set its own dma_mask.

If I utilize APIs such as dma_map_single or dma_alloc_coherent and pass a DMA controller as the argument, such as dma_map_single(dma_chan->device->dev, ...), the dma_mask is respected and there would be no issues. I also saw there are some user cases in the kernel:
```
# rg "dma_map_single.*chan"
drivers/i2c/busses/i2c-sh_mobile.c
536:    dma_addr = dma_map_single(chan->device->dev, pd->dma_buf, pd->msg->len, dir);

drivers/i2c/busses/i2c-imx.c
399:    dma->dma_buf = dma_map_single(chan_dev, msgs->buf,

drivers/i2c/busses/i2c-stm32.c
121:    dma->dma_buf = dma_map_single(chan_dev, buf, dma->dma_len,

drivers/i2c/busses/i2c-rcar.c
443:    dma_addr = dma_map_single(chan->device->dev, buf, len, dir);

drivers/net/ethernet/ti/davinci_cpdma.c
1049:           buffer = dma_map_single(ctlr->dev, si->data_virt, len, chan->dir);

drivers/tty/serial/ambarella_uart.c
826:            dma_phys = dma_map_single(dma_chan->device->dev,
836:            dma_phys = dma_map_single(dma_chan->device->dev,

drivers/tty/serial/samsung_tty.c
1105:   dma->rx_addr = dma_map_single(dma->rx_chan->device->dev, dma->rx_buf,
1114:   dma->tx_addr = dma_map_single(dma->tx_chan->device->dev,

drivers/tty/serial/8250/8250_dma.c
253:    dma->tx_addr = dma_map_single(dma->txchan->device->dev,

drivers/tty/serial/sh-sci.c
1600:           s->tx_dma_addr = dma_map_single(chan->device->dev,

drivers/mtd/hyperbus/hbmc-am654.c
87:     dma_dst = dma_map_single(rx_chan->device->dev, to, len, DMA_FROM_DEVICE);

drivers/mtd/nand/raw/intel-nand-controller.c
314:    buf_dma = dma_map_single(chan->device->dev, (void *)buf, len, dir);

drivers/mtd/nand/raw/sh_flctl.c
398:    dma_addr = dma_map_single(chan->device->dev, buf, len, dir);
...
```

However, if I pass the consumer peripheral's struct device to dma_map_single, the dma_mask would not be respected because the peripheral driver doesn't set it, which would lead to unexpected outcomes. For instance, even if the DMA controller is capable of handling 64-bit operations, it would still use SWIOTLB, which is really unnecessary.

So my question is which device should be dma_map_single's first argument? DMA controller or the consumer peripheral itself?

I know I could also set dma_mask in my peripheral driver, just the same as the DMA controller did, but I want to learn the best practice.

Thanks in advanced.

Regards,
Li
