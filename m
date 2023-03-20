Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96FE86C0FC1
	for <lists+dmaengine@lfdr.de>; Mon, 20 Mar 2023 11:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjCTKxd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 20 Mar 2023 06:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjCTKxL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 20 Mar 2023 06:53:11 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B7E62915C;
        Mon, 20 Mar 2023 03:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679309403; x=1710845403;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=f6Szu5N899vOcyBENHXvllnFIVnKt622pI3xmC0KjFk=;
  b=YaRdKqCq0PI+0jn+r5O+lpNKJwha4TWsgs0+dGujUoO2ruAJMvVzLU8t
   JolK1FdNc2+Tffit2mEmc354ncEJ8p8DSdXGfpOGSSzs2PxPJWwJTuVXF
   ncKMOawx9Er1cqnMJZ4QBho87Ou1Hh9hgsAbcMoJr0dwXHJL7hNnBAB4c
   2x00KV5CzjFQK5sS85dDA4zKpKxESlED+xqr5XNVbKWxnd24KY+M6lH6S
   qleV8KlNZ3Of2QgXKQ35rbEVsJCQ1k4x+X0gvMx9RrFrfTeMsMUGNaupb
   IVLI8KTjnGOwpIBj3H1xJAdftYQV5MNP+9igjlOy7wtrN6+PlXkibbJ6w
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="424904692"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="424904692"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 03:49:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="926922801"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="926922801"
Received: from mbouhaou-mobl1.ger.corp.intel.com ([10.252.61.151])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 03:49:00 -0700
Date:   Mon, 20 Mar 2023 12:48:58 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     ChiaWei Wang <chiawei_wang@aspeedtech.com>
cc:     "vkoul@kernel.org" <vkoul@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>,
        "hdanton@sina.com" <hdanton@sina.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>
Subject: RE: [PATCH v3 4/5] serial: 8250: Add AST2600 UART driver
In-Reply-To: <KL1PR0601MB37819E400753132F11F0202D91809@KL1PR0601MB3781.apcprd06.prod.outlook.com>
Message-ID: <a5b0d7d8-d78a-a12f-783-419713742d5@linux.intel.com>
References: <20230320081133.23655-1-chiawei_wang@aspeedtech.com> <20230320081133.23655-5-chiawei_wang@aspeedtech.com> <10864478-99cb-e2cd-8e7b-95c6dca677e8@linux.intel.com>
 <KL1PR0601MB37819E400753132F11F0202D91809@KL1PR0601MB3781.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1298225524-1679308939=:2177"
Content-ID: <e597b71-f321-21ca-f9f8-549a285c1d69@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1298225524-1679308939=:2177
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <f31fa036-f420-7de5-9463-207d1dedfd2b@linux.intel.com>

On Mon, 20 Mar 2023, ChiaWei Wang wrote:

> > From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > Sent: Monday, March 20, 2023 5:43 PM
> > 
> > On Mon, 20 Mar 2023, Chia-Wei Wang wrote:
> > 
> > > Add new UART driver with DMA support for Aspeed AST2600 SoCs.
> > > The drivers mainly prepare the dma instance based on the 8250_dma
> > > implementation to leverage the AST2600 UART DMA (UDMA) engine.
> > >
> > > Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> > > ---
> > >  drivers/tty/serial/8250/8250_aspeed.c | 224
> > ++++++++++++++++++++++++++
> > >  drivers/tty/serial/8250/Kconfig       |   8 +
> > >  drivers/tty/serial/8250/Makefile      |   1 +
> > >  3 files changed, 233 insertions(+)
> > >  create mode 100644 drivers/tty/serial/8250/8250_aspeed.c
> > >
> > > diff --git a/drivers/tty/serial/8250/8250_aspeed.c
> > > b/drivers/tty/serial/8250/8250_aspeed.c
> > > new file mode 100644
> > > index 000000000000..04d0bf6fba28
> > > --- /dev/null
> > > +++ b/drivers/tty/serial/8250/8250_aspeed.c
> > > @@ -0,0 +1,224 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Copyright (C) ASPEED Technology Inc.
> > > + */
> > > +#include <linux/device.h>
> > > +#include <linux/io.h>
> > > +#include <linux/module.h>
> > > +#include <linux/serial_8250.h>
> > > +#include <linux/serial_reg.h>
> > > +#include <linux/of.h>
> > > +#include <linux/of_irq.h>
> > > +#include <linux/of_platform.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/clk.h>
> > > +#include <linux/reset.h>
> > > +#include <linux/dma-mapping.h>
> > > +#include <linux/circ_buf.h>
> > > +#include <linux/tty_flip.h>
> > > +#include <linux/pm_runtime.h>
> > > +
> > > +#include "8250.h"
> > > +
> > > +#define DEVICE_NAME "aspeed-uart"
> > > +
> > > +struct ast8250_data {
> > > +	int line;
> > > +	int irq;
> > > +	u8 __iomem *regs;
> > > +	struct reset_control *rst;
> > > +	struct clk *clk;
> > > +#ifdef CONFIG_SERIAL_8250_DMA
> > > +	struct uart_8250_dma dma;
> > > +#endif
> > > +};
> > > +
> > > +#ifdef CONFIG_SERIAL_8250_DMA
> > > +static int ast8250_rx_dma(struct uart_8250_port *p);
> > > +
> > > +static void ast8250_rx_dma_complete(void *param) {
> > > +	struct uart_8250_port *p = param;
> > > +	struct uart_8250_dma *dma = p->dma;
> > > +	struct tty_port *tty_port = &p->port.state->port;
> > > +	struct dma_tx_state	state;
> > > +	int	count;
> > > +
> > > +	dmaengine_tx_status(dma->rxchan, dma->rx_cookie, &state);
> > > +
> > > +	count = dma->rx_size - state.residue;
> > > +
> > > +	tty_insert_flip_string(tty_port, dma->rx_buf, count);
> > > +	p->port.icount.rx += count;
> > > +
> > > +	tty_flip_buffer_push(tty_port);
> > > +
> > > +	ast8250_rx_dma(p);
> > > +}
> > > +
> > > +static int ast8250_rx_dma(struct uart_8250_port *p) {
> > > +	struct uart_8250_dma *dma = p->dma;
> > > +	struct dma_async_tx_descriptor *tx;
> > > +
> > > +	tx = dmaengine_prep_slave_single(dma->rxchan, dma->rx_addr,
> > > +					 dma->rx_size, DMA_DEV_TO_MEM,
> > > +					 DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
> > > +	if (!tx)
> > > +		return -EBUSY;
> > 
> > How does the DMA Rx "loop" restart when this is taken?
> 
> The loop re-starts from ast8250_startup.

Why would startup get called again?

> > > +	tx->callback = ast8250_rx_dma_complete;
> > > +	tx->callback_param = p;
> > > +
> > > +	dma->rx_cookie = dmaengine_submit(tx);
> > > +
> > > +	dma_async_issue_pending(dma->rxchan);
> > > +
> > > +	return 0;
> > > +}
> > > +#endif
> > 
> > These 2 functions look very similar to what 8250_dma offers for you. The only
> > difference I could see is that always start DMA Rx thing which could be
> > handled by adding some capability flag into uart_8250_dma for those UARTs
> > that can launch DMA Rx while Rx queue is empty.
> > 
> > So, just use the standard 8250_dma functions and make the small capabilities
> > flag tweak there.
> > 
> > By using the stock functions you also avoid 8250_dma Rx and your DMA Rx
> > racing like they currently would (8250_port assigns the functions from
> > 8250_dma when you don't specify the rx handler and the default 8250 irq
> > handler will call into those standard 8250 DMA functions).
> 
> Yes for the difference described.
> 
> Our customers usually use UDMA for file-transmissions over UART.
> And I found the preceding bytes will get lost easily due to the late 
> start of DMA engine. 
>
> In fact, I was seeking the default implementation to always start RX DMA 
> instead of enabling it upon DR bit rising. But no luck and thus add 
> ast8250_rx_dma. (The default 8250 ISR also called into up->dma->rx_dma)
>
> If adding a new capability flag is the better way to go, I will try to 
> implement in that way for further review.

Yes it would be much better.

Add unsigned int capabilities into uart_8250_dma and put the necessary 
checks + code into general code. Don't add any #ifdef 
CONFIG_SERIAL_8250_DMA into 8250_port.c nor 8250_dma.c. Instead, if you 
feel a need for one, use the #ifdef ... #else ... #endif in 8250.h to
provide an empty static inline function for the #else case.

> > I'm curious about this HW and how it behaves under these two scenarios:
> > - When Rx is empty, does UART/DMA just sit there waiting forever?
> 
> Yes.

Okay.

> > - When a stream of incoming Rx characters suddenly ends, how does
> > UART/DMA
> >   react? ...On 8250 UARTs I'm familiar with this triggers UART_IIR_TIMEOUT
> >   which you don't seem to handle.
> 
> UDMA also has a timeout control.
> If the data suddenly ends and timeout occurs, UDMA will trigger an interrupt.
> UDMA ISR then check if there is data available using DMA read/write 
> pointers and invokes callback if any. 

Okay. And the UART side won't trigger any interrupts?

> > When you provide answer to those two questions, I can try to help you further
> > on how to integrate into the standard 8250 DMA code.
> 
> Thanks!
> It would be great using the default one to avoid mostly duplicated code.

You need to take a look into handle_rx_dma() what to do there. Probably 
just call to ->rx_dma() unconditionally to prevent UART interrupts from 
messing up with DMA Rx. This restart for DMA Rx is just for backup if the 
DMA Rx "loop" stopped due to an error.


-- 
 i.
--8323329-1298225524-1679308939=:2177--
