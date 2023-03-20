Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 552156C0D92
	for <lists+dmaengine@lfdr.de>; Mon, 20 Mar 2023 10:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbjCTJnY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 20 Mar 2023 05:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbjCTJnL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 20 Mar 2023 05:43:11 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FED81449E;
        Mon, 20 Mar 2023 02:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679305376; x=1710841376;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=RbtSMMS+dHu2r2jUrf9VmNBe6O1aIOF19pAoLDXXhRk=;
  b=P5fLVB4A6K2yysp0R8HE/ydpyGEnS9uVasrwxtI9pVURDpCYGbmefByg
   WpQFinmoBywKK2ciK737+l75YCseSXmdQMyyk03ZZFBPa9tCxOzzOL+D4
   Bb5WoZ8p9mXDPU8laMlikmhKyHbr86l8ub/jLeK9mFFR6Qyxan2d9jI+d
   nkVNX6CgLHbrfsEye8bCx+VUvAgZtRAgn01hjfkAgQA31+xNeDIpPrVYe
   k3CihzOTZmUOnen+I+UUSGqE0RFyplK0yyTRj7+2fKhyP3JgvRNUCbYUV
   ZQUZnK4M/84pSivJduhFU9IMGJ27kvovp+F1rEpFhmpNtK7UWIJFF7c9P
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="336120094"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="336120094"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 02:42:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10654"; a="713517706"
X-IronPort-AV: E=Sophos;i="5.98,274,1673942400"; 
   d="scan'208";a="713517706"
Received: from mbouhaou-mobl1.ger.corp.intel.com ([10.252.61.151])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 02:42:50 -0700
Date:   Mon, 20 Mar 2023 11:42:48 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Chia-Wei Wang <chiawei_wang@aspeedtech.com>
cc:     vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, pmenzel@molgen.mpg.de,
        hdanton@sina.com, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        openbmc@lists.ozlabs.org
Subject: Re: [PATCH v3 4/5] serial: 8250: Add AST2600 UART driver
In-Reply-To: <20230320081133.23655-5-chiawei_wang@aspeedtech.com>
Message-ID: <10864478-99cb-e2cd-8e7b-95c6dca677e8@linux.intel.com>
References: <20230320081133.23655-1-chiawei_wang@aspeedtech.com> <20230320081133.23655-5-chiawei_wang@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, 20 Mar 2023, Chia-Wei Wang wrote:

> Add new UART driver with DMA support for Aspeed AST2600 SoCs.
> The drivers mainly prepare the dma instance based on the 8250_dma
> implementation to leverage the AST2600 UART DMA (UDMA) engine.
> 
> Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> ---
>  drivers/tty/serial/8250/8250_aspeed.c | 224 ++++++++++++++++++++++++++
>  drivers/tty/serial/8250/Kconfig       |   8 +
>  drivers/tty/serial/8250/Makefile      |   1 +
>  3 files changed, 233 insertions(+)
>  create mode 100644 drivers/tty/serial/8250/8250_aspeed.c
> 
> diff --git a/drivers/tty/serial/8250/8250_aspeed.c b/drivers/tty/serial/8250/8250_aspeed.c
> new file mode 100644
> index 000000000000..04d0bf6fba28
> --- /dev/null
> +++ b/drivers/tty/serial/8250/8250_aspeed.c
> @@ -0,0 +1,224 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) ASPEED Technology Inc.
> + */
> +#include <linux/device.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/serial_8250.h>
> +#include <linux/serial_reg.h>
> +#include <linux/of.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/clk.h>
> +#include <linux/reset.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/circ_buf.h>
> +#include <linux/tty_flip.h>
> +#include <linux/pm_runtime.h>
> +
> +#include "8250.h"
> +
> +#define DEVICE_NAME "aspeed-uart"
> +
> +struct ast8250_data {
> +	int line;
> +	int irq;
> +	u8 __iomem *regs;
> +	struct reset_control *rst;
> +	struct clk *clk;
> +#ifdef CONFIG_SERIAL_8250_DMA
> +	struct uart_8250_dma dma;
> +#endif
> +};
> +
> +#ifdef CONFIG_SERIAL_8250_DMA
> +static int ast8250_rx_dma(struct uart_8250_port *p);
> +
> +static void ast8250_rx_dma_complete(void *param)
> +{
> +	struct uart_8250_port *p = param;
> +	struct uart_8250_dma *dma = p->dma;
> +	struct tty_port *tty_port = &p->port.state->port;
> +	struct dma_tx_state	state;
> +	int	count;
> +
> +	dmaengine_tx_status(dma->rxchan, dma->rx_cookie, &state);
> +
> +	count = dma->rx_size - state.residue;
> +
> +	tty_insert_flip_string(tty_port, dma->rx_buf, count);
> +	p->port.icount.rx += count;
> +
> +	tty_flip_buffer_push(tty_port);
> +
> +	ast8250_rx_dma(p);
> +}
> +
> +static int ast8250_rx_dma(struct uart_8250_port *p)
> +{
> +	struct uart_8250_dma *dma = p->dma;
> +	struct dma_async_tx_descriptor *tx;
> +
> +	tx = dmaengine_prep_slave_single(dma->rxchan, dma->rx_addr,
> +					 dma->rx_size, DMA_DEV_TO_MEM,
> +					 DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
> +	if (!tx)
> +		return -EBUSY;

How does the DMA Rx "loop" restart when this is taken?

> +	tx->callback = ast8250_rx_dma_complete;
> +	tx->callback_param = p;
> +
> +	dma->rx_cookie = dmaengine_submit(tx);
> +
> +	dma_async_issue_pending(dma->rxchan);
> +
> +	return 0;
> +}
> +#endif

These 2 functions look very similar to what 8250_dma offers for you. The 
only difference I could see is that always start DMA Rx thing which could 
be handled by adding some capability flag into uart_8250_dma for those 
UARTs that can launch DMA Rx while Rx queue is empty.

So, just use the standard 8250_dma functions and make the small 
capabilities flag tweak there. 

By using the stock functions you also avoid 8250_dma Rx and your DMA Rx 
racing like they currently would (8250_port assigns the functions from 
8250_dma when you don't specify the rx handler and the default 8250 irq 
handler will call into those standard 8250 DMA functions).


I'm curious about this HW and how it behaves under these two scenarios:
- When Rx is empty, does UART/DMA just sit there waiting forever?
- When a stream of incoming Rx characters suddenly ends, how does UART/DMA
  react? ...On 8250 UARTs I'm familiar with this triggers UART_IIR_TIMEOUT
  which you don't seem to handle.

When you provide answer to those two questions, I can try to help you 
further on how to integrate into the standard 8250 DMA code.

> +static int ast8250_handle_irq(struct uart_port *port)
> +{
> +	return serial8250_handle_irq(port, serial_port_in(port, UART_IIR));
> +}
> +
> +static int ast8250_startup(struct uart_port *port)
> +{
> +#ifdef CONFIG_SERIAL_8250_DMA

This ifdef'fery is entirely unnecessary.

> +	int rc;
> +	struct uart_8250_port *up = up_to_u8250p(port);

Reverse xmas tree order.

> +
> +	rc = serial8250_do_startup(port);
> +	if (rc)
> +		return rc;
> +
> +	/*
> +	 * The default RX DMA is launched upon rising DR bit.
> +	 *
> +	 * However, this can result in byte lost if UART FIFO has
> +	 * been overruned before the DMA engine gets prepared and
> +	 * read the data out. This is especially common when UART
> +	 * DMA is used for file transfer. Thus we initiate RX DMA
> +	 * as early as possible.
> +	 */
> +	if (up->dma)
> +		return ast8250_rx_dma(up);

Once you start using the general 8250 dma code and add the DMA Rx always
capabilities flag, this can go into serial8250_do_startup(). Since 
serial8250_rx_dma() always exists independent of CONFIG_SERIAL_8250_DMA, 
no include guards are necessary.

...After which you probably don't need this whole function anymore.

> +
> +	return 0;
> +#else
> +	return serial8250_do_startup(port);
> +#endif
> +}
> +
> +static void ast8250_shutdown(struct uart_port *port)
> +{
> +	return serial8250_do_shutdown(port);
> +}
> +
> +static int ast8250_probe(struct platform_device *pdev)
> +{
> +	int rc;

Put this as last.

> +	struct uart_8250_port uart = {};
> +	struct uart_port *port = &uart.port;
> +	struct device *dev = &pdev->dev;
> +	struct ast8250_data *data;
> +	struct resource *res;
> +
> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->irq = platform_get_irq(pdev, 0);
> +	if (data->irq < 0)
> +		return data->irq;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (res == NULL) {
> +		dev_err(dev, "failed to get register base\n");
> +		return -ENODEV;
> +	}
> +
> +	data->regs = devm_ioremap(dev, res->start, resource_size(res));
> +	if (IS_ERR(data->regs)) {
> +		dev_err(dev, "failed to map registers\n");
> +		return PTR_ERR(data->regs);
> +	}
> +
> +	data->clk = devm_clk_get(dev, NULL);
> +	if (IS_ERR(data->clk)) {
> +		dev_err(dev, "failed to get clocks\n");
> +		return -ENODEV;
> +	}
> +
> +	rc = clk_prepare_enable(data->clk);
> +	if (rc) {
> +		dev_err(dev, "failed to enable clock\n");
> +		return rc;
> +	}
> +
> +	data->rst = devm_reset_control_get_optional_exclusive(dev, NULL);
> +	if (!IS_ERR(data->rst))
> +		reset_control_deassert(data->rst);
> +
> +	spin_lock_init(&port->lock);
> +	port->dev = dev;
> +	port->type = PORT_16550A;
> +	port->irq = data->irq;
> +	port->line = of_alias_get_id(dev->of_node, "serial");
> +	port->handle_irq = ast8250_handle_irq;
> +	port->mapbase = res->start;
> +	port->mapsize = resource_size(res);
> +	port->membase = data->regs;
> +	port->uartclk = clk_get_rate(data->clk);
> +	port->regshift = 2;
> +	port->iotype = UPIO_MEM32;
> +	port->flags = UPF_FIXED_TYPE | UPF_FIXED_PORT | UPF_SHARE_IRQ;
> +	port->startup = ast8250_startup;
> +	port->shutdown = ast8250_shutdown;
> +	port->private_data = data;

> +#ifdef CONFIG_SERIAL_8250_DMA
> +	data->dma.rxconf.src_maxburst = UART_XMIT_SIZE;
> +	data->dma.txconf.dst_maxburst = UART_XMIT_SIZE;
> +	uart.dma = &data->dma;
> +#endif

Add a setup function for this and make an empty function with the same 
name when CONFIG_SERIAL_8250_DMA is not there.

> +
> +	data->line = serial8250_register_8250_port(&uart);
> +	if (data->line < 0) {
> +		dev_err(dev, "failed to register 8250 port\n");
> +		return data->line;
> +	}
> +
> +	platform_set_drvdata(pdev, data);
> +
> +	return 0;
> +}
> +
> +static int ast8250_remove(struct platform_device *pdev)
> +{
> +	struct ast8250_data *data = platform_get_drvdata(pdev);
> +
> +	serial8250_unregister_port(data->line);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id ast8250_of_match[] = {
> +	{ .compatible = "aspeed,ast2600-uart" },
> +	{ },
> +};
> +
> +static struct platform_driver ast8250_platform_driver = {
> +	.driver = {
> +		.name = DEVICE_NAME,
> +		.of_match_table = ast8250_of_match,
> +	},
> +	.probe = ast8250_probe,
> +	.remove = ast8250_remove,
> +};
> +
> +module_platform_driver(ast8250_platform_driver);
> +
> +MODULE_AUTHOR("Chia-Wei Wang <chiawei_wang@aspeedtech.com>");
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Aspeed 8250 UART Driver with DMA support");


-- 
 i.

