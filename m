Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9769FEF69A
	for <lists+dmaengine@lfdr.de>; Tue,  5 Nov 2019 08:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387739AbfKEHuL (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 5 Nov 2019 02:50:11 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:52676 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387711AbfKEHuL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 5 Nov 2019 02:50:11 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id xA57nxaQ002538;
        Tue, 5 Nov 2019 01:49:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1572940199;
        bh=c5M1C5p4ZibPjf04SCTeSL+qpVtnaG4bP6HSo8rNMZ8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=egAvS6b4hrClYkrIsiP3//xjCBIvGlaHVMP5c3mP/nknjBXME2AT1HH1T9p0PJ1Rx
         2mjIcHbYNalFL7NO9BMmVVt+LCyI1BRYeHnUYqfAycSrpS2sDgo+cWmwWjVlxG/uYl
         Ry+nxbju2BIlAPHlr/Ht40H7UELm5zDY7zgtxiMw=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id xA57nxEJ073021;
        Tue, 5 Nov 2019 01:49:59 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 5 Nov
 2019 01:49:43 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 5 Nov 2019 01:49:43 -0600
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id xA57nrKc009014;
        Tue, 5 Nov 2019 01:49:54 -0600
Subject: Re: [PATCH v4 07/15] dmaengine: ti: k3 PSI-L remote endpoint
 configuration
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>, <vkoul@kernel.org>,
        <robh+dt@kernel.org>, <nm@ti.com>, <ssantosh@kernel.org>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <lokeshvutla@ti.com>,
        <tony@atomide.com>, <j-keerthy@ti.com>
References: <20191101084135.14811-1-peter.ujfalusi@ti.com>
 <20191101084135.14811-8-peter.ujfalusi@ti.com>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <e23316e7-1913-d0a7-79c6-4af2084e5176@ti.com>
Date:   Tue, 5 Nov 2019 09:49:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191101084135.14811-8-peter.ujfalusi@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 01/11/2019 10:41, Peter Ujfalusi wrote:
> In K3 architecture the DMA operates within threads. One end of the thread
> is UDMAP, the other is on the peripheral side.
> 
> The UDMAP channel configuration depends on the needs of the remote
> endpoint and it can be differ from peripheral to peripheral.
> 
> This patch adds database for am654 and j721e and small API to fetch the
> PSI-L endpoint configuration from the database which should only used by
> the DMA driver(s).
> 
> Another API is added for native peripherals to give possibility to pass new
> configuration for the threads they are using, which is needed to be able to
> handle changes caused by different firmware loaded for the peripheral for
> example.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>   drivers/dma/ti/Kconfig         |   3 +
>   drivers/dma/ti/Makefile        |   1 +
>   drivers/dma/ti/k3-psil-am654.c | 172 ++++++++++++++++++++++++++
>   drivers/dma/ti/k3-psil-j721e.c | 219 +++++++++++++++++++++++++++++++++
>   drivers/dma/ti/k3-psil-priv.h  |  39 ++++++
>   drivers/dma/ti/k3-psil.c       |  97 +++++++++++++++
>   include/linux/dma/k3-psil.h    |  47 +++++++
>   7 files changed, 578 insertions(+)
>   create mode 100644 drivers/dma/ti/k3-psil-am654.c
>   create mode 100644 drivers/dma/ti/k3-psil-j721e.c
>   create mode 100644 drivers/dma/ti/k3-psil-priv.h
>   create mode 100644 drivers/dma/ti/k3-psil.c
>   create mode 100644 include/linux/dma/k3-psil.h
> 
> diff --git a/drivers/dma/ti/Kconfig b/drivers/dma/ti/Kconfig
> index d507c24fbf31..72f3d2728178 100644
> --- a/drivers/dma/ti/Kconfig
> +++ b/drivers/dma/ti/Kconfig
> @@ -34,5 +34,8 @@ config DMA_OMAP
>   	  Enable support for the TI sDMA (System DMA or DMA4) controller. This
>   	  DMA engine is found on OMAP and DRA7xx parts.
>   
> +config TI_K3_PSIL
> +	bool
> +
>   config TI_DMA_CROSSBAR
>   	bool
> diff --git a/drivers/dma/ti/Makefile b/drivers/dma/ti/Makefile
> index 113e59ec9c32..f8d912ad7eaf 100644
> --- a/drivers/dma/ti/Makefile
> +++ b/drivers/dma/ti/Makefile
> @@ -2,4 +2,5 @@
>   obj-$(CONFIG_TI_CPPI41) += cppi41.o
>   obj-$(CONFIG_TI_EDMA) += edma.o
>   obj-$(CONFIG_DMA_OMAP) += omap-dma.o
> +obj-$(CONFIG_TI_K3_PSIL) += k3-psil.o k3-psil-am654.o k3-psil-j721e.o
>   obj-$(CONFIG_TI_DMA_CROSSBAR) += dma-crossbar.o
> diff --git a/drivers/dma/ti/k3-psil-am654.c b/drivers/dma/ti/k3-psil-am654.c
> new file mode 100644
> index 000000000000..edd7fff36f44
> --- /dev/null
> +++ b/drivers/dma/ti/k3-psil-am654.c
> @@ -0,0 +1,172 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + *  Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com
> + *  Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
> + */
> +
> +#include <linux/kernel.h>
> +
> +#include "k3-psil-priv.h"
> +
> +#define PSIL_PDMA_XY_TR(x)				\
> +	{						\
> +		.thread_id = x,				\
> +		.ep_config = {				\
> +			.ep_type = PSIL_EP_PDMA_XY,	\
> +		},					\
> +	}
> +
> +#define PSIL_PDMA_XY_PKT(x)				\
> +	{						\
> +		.thread_id = x,				\
> +		.ep_config = {				\
> +			.ep_type = PSIL_EP_PDMA_XY,	\
> +			.pkt_mode = 1,			\
> +		},					\
> +	}
> +
> +#define PSIL_ETHERNET(x)				\
> +	{						\
> +		.thread_id = x,				\
> +		.ep_config = {				\
> +			.ep_type = PSIL_EP_NATIVE,	\
> +			.pkt_mode = 1,			\
> +			.needs_epib = 1,		\
> +			.psd_size = 16,			\
> +		},					\
> +	}
> +
> +#define PSIL_SA2UL(x, tx)				\
> +	{						\
> +		.thread_id = x,				\
> +		.ep_config = {				\
> +			.ep_type = PSIL_EP_NATIVE,	\
> +			.pkt_mode = 1,			\
> +			.needs_epib = 1,		\
> +			.psd_size = 64,			\
> +			.notdpkt = tx,			\
> +		},					\
> +	}
> +
> +/* PSI-L source thread IDs, used for RX (DMA_DEV_TO_MEM) */
> +struct psil_ep am654_src_ep_map[] = {
> +	/* SA2UL */
> +	PSIL_SA2UL(0x4000, 0),
> +	PSIL_SA2UL(0x4001, 0),
> +	/* PRU_ICSSG0 */
> +	PSIL_ETHERNET(0x4100),
> +	PSIL_ETHERNET(0x4101),
> +	PSIL_ETHERNET(0x4102),
> +	PSIL_ETHERNET(0x4103),
> +	/* PRU_ICSSG1 */
> +	PSIL_ETHERNET(0x4200),
> +	PSIL_ETHERNET(0x4201),
> +	PSIL_ETHERNET(0x4202),
> +	PSIL_ETHERNET(0x4203),
> +	/* PRU_ICSSG2 */
> +	PSIL_ETHERNET(0x4300),
> +	PSIL_ETHERNET(0x4301),
> +	PSIL_ETHERNET(0x4302),
> +	PSIL_ETHERNET(0x4303),
> +	/* PDMA0 - McASPs */
> +	PSIL_PDMA_XY_TR(0x4400),
> +	PSIL_PDMA_XY_TR(0x4401),
> +	PSIL_PDMA_XY_TR(0x4402),
> +	/* PDMA1 - SPI0-4 */
> +	PSIL_PDMA_XY_PKT(0x4500),
> +	PSIL_PDMA_XY_PKT(0x4501),
> +	PSIL_PDMA_XY_PKT(0x4502),
> +	PSIL_PDMA_XY_PKT(0x4503),
> +	PSIL_PDMA_XY_PKT(0x4504),
> +	PSIL_PDMA_XY_PKT(0x4505),
> +	PSIL_PDMA_XY_PKT(0x4506),
> +	PSIL_PDMA_XY_PKT(0x4507),
> +	PSIL_PDMA_XY_PKT(0x4508),
> +	PSIL_PDMA_XY_PKT(0x4509),
> +	PSIL_PDMA_XY_PKT(0x450a),
> +	PSIL_PDMA_XY_PKT(0x450b),
> +	PSIL_PDMA_XY_PKT(0x450c),
> +	PSIL_PDMA_XY_PKT(0x450d),
> +	PSIL_PDMA_XY_PKT(0x450e),
> +	PSIL_PDMA_XY_PKT(0x450f),
> +	PSIL_PDMA_XY_PKT(0x4510),
> +	PSIL_PDMA_XY_PKT(0x4511),
> +	PSIL_PDMA_XY_PKT(0x4512),
> +	PSIL_PDMA_XY_PKT(0x4513),
> +	/* PDMA1 - USART0-2 */
> +	PSIL_PDMA_XY_PKT(0x4514),
> +	PSIL_PDMA_XY_PKT(0x4515),
> +	PSIL_PDMA_XY_PKT(0x4516),
> +	/* CPSW0 */
> +	PSIL_ETHERNET(0x7000),
> +	/* MCU_PDMA0 - ADCs */
> +	PSIL_PDMA_XY_TR(0x7100),
> +	PSIL_PDMA_XY_TR(0x7101),
> +	PSIL_PDMA_XY_TR(0x7102),
> +	PSIL_PDMA_XY_TR(0x7103),
> +	/* MCU_PDMA1 - MCU_SPI0-2 */
> +	PSIL_PDMA_XY_PKT(0x7200),
> +	PSIL_PDMA_XY_PKT(0x7201),
> +	PSIL_PDMA_XY_PKT(0x7202),
> +	PSIL_PDMA_XY_PKT(0x7203),
> +	PSIL_PDMA_XY_PKT(0x7204),
> +	PSIL_PDMA_XY_PKT(0x7205),
> +	PSIL_PDMA_XY_PKT(0x7206),
> +	PSIL_PDMA_XY_PKT(0x7207),
> +	PSIL_PDMA_XY_PKT(0x7208),
> +	PSIL_PDMA_XY_PKT(0x7209),
> +	PSIL_PDMA_XY_PKT(0x720a),
> +	PSIL_PDMA_XY_PKT(0x720b),
> +	/* MCU_PDMA1 - MCU_USART0 */
> +	PSIL_PDMA_XY_PKT(0x7212),
> +};
> +
> +/* PSI-L destination thread IDs, used for TX (DMA_MEM_TO_DEV) */
> +struct psil_ep am654_dst_ep_map[] = {
> +	/* SA2UL */
> +	PSIL_SA2UL(0xc000, 1),
> +	/* PRU_ICSSG0 */
> +	PSIL_ETHERNET(0xc100),
> +	PSIL_ETHERNET(0xc101),
> +	PSIL_ETHERNET(0xc102),
> +	PSIL_ETHERNET(0xc103),
> +	PSIL_ETHERNET(0xc104),
> +	PSIL_ETHERNET(0xc105),
> +	PSIL_ETHERNET(0xc106),
> +	PSIL_ETHERNET(0xc107),
> +	/* PRU_ICSSG1 */
> +	PSIL_ETHERNET(0xc200),
> +	PSIL_ETHERNET(0xc201),
> +	PSIL_ETHERNET(0xc202),
> +	PSIL_ETHERNET(0xc203),
> +	PSIL_ETHERNET(0xc204),
> +	PSIL_ETHERNET(0xc205),
> +	PSIL_ETHERNET(0xc206),
> +	PSIL_ETHERNET(0xc207),
> +	/* PRU_ICSSG2 */
> +	PSIL_ETHERNET(0xc300),
> +	PSIL_ETHERNET(0xc301),
> +	PSIL_ETHERNET(0xc302),
> +	PSIL_ETHERNET(0xc303),
> +	PSIL_ETHERNET(0xc304),
> +	PSIL_ETHERNET(0xc305),
> +	PSIL_ETHERNET(0xc306),
> +	PSIL_ETHERNET(0xc307),
> +	/* CPSW0 */
> +	PSIL_ETHERNET(0xf000),
> +	PSIL_ETHERNET(0xf001),
> +	PSIL_ETHERNET(0xf002),
> +	PSIL_ETHERNET(0xf003),
> +	PSIL_ETHERNET(0xf004),
> +	PSIL_ETHERNET(0xf005),
> +	PSIL_ETHERNET(0xf006),
> +	PSIL_ETHERNET(0xf007),
> +};
> +
> +struct psil_ep_map am654_ep_map = {
> +	.name = "am654",
> +	.src = am654_src_ep_map,
> +	.src_count = ARRAY_SIZE(am654_src_ep_map),
> +	.dst = am654_dst_ep_map,
> +	.dst_count = ARRAY_SIZE(am654_dst_ep_map),
> +};
> diff --git a/drivers/dma/ti/k3-psil-j721e.c b/drivers/dma/ti/k3-psil-j721e.c
> new file mode 100644
> index 000000000000..86e1ff57e197
> --- /dev/null
> +++ b/drivers/dma/ti/k3-psil-j721e.c
> @@ -0,0 +1,219 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + *  Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com
> + *  Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
> + */
> +
> +#include <linux/kernel.h>
> +
> +#include "k3-psil-priv.h"
> +
> +#define PSIL_PDMA_XY_TR(x)				\
> +	{						\
> +		.thread_id = x,				\
> +		.ep_config = {				\
> +			.ep_type = PSIL_EP_PDMA_XY,	\
> +		},					\
> +	}
> +
> +#define PSIL_PDMA_XY_PKT(x)				\
> +	{						\
> +		.thread_id = x,				\
> +		.ep_config = {				\
> +			.ep_type = PSIL_EP_PDMA_XY,	\
> +			.pkt_mode = 1,			\
> +		},					\
> +	}
> +
> +#define PSIL_PDMA_MCASP(x)				\
> +	{						\
> +		.thread_id = x,				\
> +		.ep_config = {				\
> +			.ep_type = PSIL_EP_PDMA_XY,	\
> +			.pdma_acc32 = 1,		\
> +			.pdma_burst = 1,		\
> +		},					\
> +	}
> +
> +#define PSIL_ETHERNET(x)				\
> +	{						\
> +		.thread_id = x,				\
> +		.ep_config = {				\
> +			.ep_type = PSIL_EP_NATIVE,	\
> +			.pkt_mode = 1,			\
> +			.needs_epib = 1,		\
> +			.psd_size = 16,			\
> +		},					\
> +	}
> +
> +#define PSIL_SA2UL(x, tx)				\
> +	{						\
> +		.thread_id = x,				\
> +		.ep_config = {				\
> +			.ep_type = PSIL_EP_NATIVE,	\
> +			.pkt_mode = 1,			\
> +			.needs_epib = 1,		\
> +			.psd_size = 64,			\
> +			.notdpkt = tx,			\
> +		},					\
> +	}
> +
> +/* PSI-L source thread IDs, used for RX (DMA_DEV_TO_MEM) */
> +struct psil_ep j721e_src_ep_map[] = {
> +	/* SA2UL */
> +	PSIL_SA2UL(0x4000, 0),
> +	PSIL_SA2UL(0x4001, 0),
> +	/* PRU_ICSSG0 */
> +	PSIL_ETHERNET(0x4100),
> +	PSIL_ETHERNET(0x4101),
> +	PSIL_ETHERNET(0x4102),
> +	PSIL_ETHERNET(0x4103),
> +	/* PRU_ICSSG1 */
> +	PSIL_ETHERNET(0x4200),
> +	PSIL_ETHERNET(0x4201),
> +	PSIL_ETHERNET(0x4202),
> +	PSIL_ETHERNET(0x4203),
> +	/* PDMA6 (PSIL_PDMA_MCASP_G0) - McASP0-2 */
> +	PSIL_PDMA_MCASP(0x4400),
> +	PSIL_PDMA_MCASP(0x4401),
> +	PSIL_PDMA_MCASP(0x4402),
> +	/* PDMA7 (PSIL_PDMA_MCASP_G1) - McASP3-11 */
> +	PSIL_PDMA_MCASP(0x4500),
> +	PSIL_PDMA_MCASP(0x4501),
> +	PSIL_PDMA_MCASP(0x4502),
> +	PSIL_PDMA_MCASP(0x4503),
> +	PSIL_PDMA_MCASP(0x4504),
> +	PSIL_PDMA_MCASP(0x4505),
> +	PSIL_PDMA_MCASP(0x4506),
> +	PSIL_PDMA_MCASP(0x4507),
> +	PSIL_PDMA_MCASP(0x4508),
> +	/* PDMA8 (PDMA_MISC_G0) - SPI0-1 */
> +	PSIL_PDMA_XY_PKT(0x4600),
> +	PSIL_PDMA_XY_PKT(0x4601),
> +	PSIL_PDMA_XY_PKT(0x4602),
> +	PSIL_PDMA_XY_PKT(0x4603),
> +	PSIL_PDMA_XY_PKT(0x4604),
> +	PSIL_PDMA_XY_PKT(0x4605),
> +	PSIL_PDMA_XY_PKT(0x4606),
> +	PSIL_PDMA_XY_PKT(0x4607),
> +	/* PDMA9 (PDMA_MISC_G1) - SPI2-3 */
> +	PSIL_PDMA_XY_PKT(0x460c),
> +	PSIL_PDMA_XY_PKT(0x460d),
> +	PSIL_PDMA_XY_PKT(0x460e),
> +	PSIL_PDMA_XY_PKT(0x460f),
> +	PSIL_PDMA_XY_PKT(0x4610),
> +	PSIL_PDMA_XY_PKT(0x4611),
> +	PSIL_PDMA_XY_PKT(0x4612),
> +	PSIL_PDMA_XY_PKT(0x4613),
> +	/* PDMA10 (PDMA_MISC_G2) - SPI4-5 */
> +	PSIL_PDMA_XY_PKT(0x4618),
> +	PSIL_PDMA_XY_PKT(0x4619),
> +	PSIL_PDMA_XY_PKT(0x461a),
> +	PSIL_PDMA_XY_PKT(0x461b),
> +	PSIL_PDMA_XY_PKT(0x461c),
> +	PSIL_PDMA_XY_PKT(0x461d),
> +	PSIL_PDMA_XY_PKT(0x461e),
> +	PSIL_PDMA_XY_PKT(0x461f),
> +	/* PDMA11 (PDMA_MISC_G3) */
> +	PSIL_PDMA_XY_PKT(0x4624),
> +	PSIL_PDMA_XY_PKT(0x4625),
> +	PSIL_PDMA_XY_PKT(0x4626),
> +	PSIL_PDMA_XY_PKT(0x4627),
> +	PSIL_PDMA_XY_PKT(0x4628),
> +	PSIL_PDMA_XY_PKT(0x4629),
> +	PSIL_PDMA_XY_PKT(0x4630),
> +	PSIL_PDMA_XY_PKT(0x463a),
> +	/* PDMA13 (PDMA_USART_G0) - UART0-1 */
> +	PSIL_PDMA_XY_PKT(0x4700),
> +	PSIL_PDMA_XY_PKT(0x4701),
> +	/* PDMA14 (PDMA_USART_G1) - UART2-3 */
> +	PSIL_PDMA_XY_PKT(0x4702),
> +	PSIL_PDMA_XY_PKT(0x4703),
> +	/* PDMA15 (PDMA_USART_G2) - UART4-9 */
> +	PSIL_PDMA_XY_PKT(0x4704),
> +	PSIL_PDMA_XY_PKT(0x4705),
> +	PSIL_PDMA_XY_PKT(0x4706),
> +	PSIL_PDMA_XY_PKT(0x4707),
> +	PSIL_PDMA_XY_PKT(0x4708),
> +	PSIL_PDMA_XY_PKT(0x4709),
> +	/* CPSW9 */
> +	PSIL_ETHERNET(0x4a00),
> +	/* CPSW0 */
> +	PSIL_ETHERNET(0x7000),
> +	/* MCU_PDMA0 (MCU_PDMA_MISC_G0) - SPI0 */
> +	PSIL_PDMA_XY_PKT(0x7100),
> +	PSIL_PDMA_XY_PKT(0x7101),
> +	PSIL_PDMA_XY_PKT(0x7102),
> +	PSIL_PDMA_XY_PKT(0x7103),
> +	/* MCU_PDMA1 (MCU_PDMA_MISC_G1) - SPI1-2 */
> +	PSIL_PDMA_XY_PKT(0x7200),
> +	PSIL_PDMA_XY_PKT(0x7201),
> +	PSIL_PDMA_XY_PKT(0x7202),
> +	PSIL_PDMA_XY_PKT(0x7203),
> +	PSIL_PDMA_XY_PKT(0x7204),
> +	PSIL_PDMA_XY_PKT(0x7205),
> +	PSIL_PDMA_XY_PKT(0x7206),
> +	PSIL_PDMA_XY_PKT(0x7207),
> +	/* MCU_PDMA2 (MCU_PDMA_MISC_G2) - UART0 */
> +	PSIL_PDMA_XY_PKT(0x7300),
> +	/* MCU_PDMA_ADC - ADC0-1 */
> +	PSIL_PDMA_XY_TR(0x7400),
> +	PSIL_PDMA_XY_TR(0x7401),
> +	PSIL_PDMA_XY_TR(0x7402),
> +	PSIL_PDMA_XY_TR(0x7403),
> +	/* SA2UL */
> +	PSIL_SA2UL(0x7500, 0),
> +	PSIL_SA2UL(0x7501, 0),
> +};
> +
> +/* PSI-L destination thread IDs, used for TX (DMA_MEM_TO_DEV) */
> +struct psil_ep j721e_dst_ep_map[] = {
> +	/* SA2UL */
> +	PSIL_SA2UL(0xc000, 1),
> +	/* PRU_ICSSG0 */
> +	PSIL_ETHERNET(0xc100),
> +	PSIL_ETHERNET(0xc101),
> +	PSIL_ETHERNET(0xc102),
> +	PSIL_ETHERNET(0xc103),
> +	PSIL_ETHERNET(0xc104),
> +	PSIL_ETHERNET(0xc105),
> +	PSIL_ETHERNET(0xc106),
> +	PSIL_ETHERNET(0xc107),
> +	/* PRU_ICSSG1 */
> +	PSIL_ETHERNET(0xc200),
> +	PSIL_ETHERNET(0xc201),
> +	PSIL_ETHERNET(0xc202),
> +	PSIL_ETHERNET(0xc203),
> +	PSIL_ETHERNET(0xc204),
> +	PSIL_ETHERNET(0xc205),
> +	PSIL_ETHERNET(0xc206),
> +	PSIL_ETHERNET(0xc207),
> +	/* CPSW9 */
> +	PSIL_ETHERNET(0xca00),
> +	PSIL_ETHERNET(0xca01),
> +	PSIL_ETHERNET(0xca02),
> +	PSIL_ETHERNET(0xca03),
> +	PSIL_ETHERNET(0xca04),
> +	PSIL_ETHERNET(0xca05),
> +	PSIL_ETHERNET(0xca06),
> +	PSIL_ETHERNET(0xca07),
> +	/* CPSW0 */
> +	PSIL_ETHERNET(0xf000),
> +	PSIL_ETHERNET(0xf001),
> +	PSIL_ETHERNET(0xf002),
> +	PSIL_ETHERNET(0xf003),
> +	PSIL_ETHERNET(0xf004),
> +	PSIL_ETHERNET(0xf005),
> +	PSIL_ETHERNET(0xf006),
> +	PSIL_ETHERNET(0xf007),
> +	/* SA2UL */
> +	PSIL_SA2UL(0xf500, 1),
> +};
> +
> +struct psil_ep_map j721e_ep_map = {
> +	.name = "j721e",
> +	.src = j721e_src_ep_map,
> +	.src_count = ARRAY_SIZE(j721e_src_ep_map),
> +	.dst = j721e_dst_ep_map,
> +	.dst_count = ARRAY_SIZE(j721e_dst_ep_map),
> +};
> diff --git a/drivers/dma/ti/k3-psil-priv.h b/drivers/dma/ti/k3-psil-priv.h
> new file mode 100644
> index 000000000000..f74420653d8a
> --- /dev/null
> +++ b/drivers/dma/ti/k3-psil-priv.h
> @@ -0,0 +1,39 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + *  Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com
> + */
> +
> +#ifndef K3_PSIL_PRIV_H_
> +#define K3_PSIL_PRIV_H_
> +
> +#include <linux/dma/k3-psil.h>
> +
> +struct psil_ep {
> +	u32 thread_id;
> +	struct psil_endpoint_config ep_config;
> +};
> +
> +/**
> + * struct psil_ep_map - PSI-L thread ID configuration maps
> + * @name:	Name of the map, set it to the name of the SoC
> + * @src:	Array of source PSI-L thread configurations
> + * @src_count:	Number of entries in the src array
> + * @dst:	Array of destination PSI-L thread configurations
> + * @dst_count:	Number of entries in the dst array
> + *
> + * In case of symmetric configuration for a matching src/dst thread (for example
> + * 0x4400 and 0xc400) only the src configuration can be present. If no dst
> + * configuration found the code will look for (dst_thread_id & ~0x8000) to find
> + * the symmetric match.
> + */
> +struct psil_ep_map {
> +	char *name;
> +	struct psil_ep	*src;
> +	int src_count;
> +	struct psil_ep	*dst;
> +	int dst_count;
> +};
> +
> +struct psil_endpoint_config *psil_get_ep_config(u32 thread_id);
> +
> +#endif /* K3_PSIL_PRIV_H_ */
> diff --git a/drivers/dma/ti/k3-psil.c b/drivers/dma/ti/k3-psil.c
> new file mode 100644
> index 000000000000..e610022f09f4
> --- /dev/null
> +++ b/drivers/dma/ti/k3-psil.c
> @@ -0,0 +1,97 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + *  Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com
> + *  Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/of.h>
> +
> +#include "k3-psil-priv.h"
> +
> +extern struct psil_ep_map am654_ep_map;
> +extern struct psil_ep_map j721e_ep_map;
> +
> +static DEFINE_MUTEX(ep_map_mutex);
> +static struct psil_ep_map *soc_ep_map;

So, you are only protecting the high level soc_ep_map pointer only. You 
don't need to protect the database itself via some usecounting or 
something, or are you doing it within the DMA driver?

-Tero

> +
> +struct psil_endpoint_config *psil_get_ep_config(u32 thread_id)
> +{
> +	int i;
> +
> +	mutex_lock(&ep_map_mutex);
> +	if (!soc_ep_map) {
> +		if (of_machine_is_compatible("ti,am654")) {
> +			soc_ep_map = &am654_ep_map;
> +		} else if (of_machine_is_compatible("ti,j721e")) {
> +			soc_ep_map = &j721e_ep_map;
> +		} else {
> +			pr_err("PSIL: No compatible machine found for map\n");
> +			return ERR_PTR(-ENOTSUPP);
> +		}
> +		pr_debug("%s: Using map for %s\n", __func__, soc_ep_map->name);
> +	}
> +	mutex_unlock(&ep_map_mutex);
> +
> +	if (thread_id & K3_PSIL_DST_THREAD_ID_OFFSET && soc_ep_map->dst) {
> +		/* check in destination thread map */
> +		for (i = 0; i < soc_ep_map->dst_count; i++) {
> +			if (soc_ep_map->dst[i].thread_id == thread_id)
> +				return &soc_ep_map->dst[i].ep_config;
> +		}
> +	}
> +
> +	thread_id &= ~K3_PSIL_DST_THREAD_ID_OFFSET;
> +	if (soc_ep_map->src) {
> +		for (i = 0; i < soc_ep_map->src_count; i++) {
> +			if (soc_ep_map->src[i].thread_id == thread_id)
> +				return &soc_ep_map->src[i].ep_config;
> +		}
> +	}
> +
> +	return ERR_PTR(-ENOENT);
> +}
> +EXPORT_SYMBOL(psil_get_ep_config);
> +
> +int psil_set_new_ep_config(struct device *dev, const char *name,
> +			   struct psil_endpoint_config *ep_config)
> +{
> +	struct psil_endpoint_config *dst_ep_config;
> +	struct of_phandle_args dma_spec;
> +	u32 thread_id;
> +	int index;
> +
> +	if (!dev || !dev->of_node)
> +		return -EINVAL;
> +
> +	index = of_property_match_string(dev->of_node, "dma-names", name);
> +	if (index < 0)
> +		return index;
> +
> +	if (of_parse_phandle_with_args(dev->of_node, "dmas", "#dma-cells",
> +				       index, &dma_spec))
> +		return -ENOENT;
> +
> +	thread_id = dma_spec.args[0];
> +
> +	dst_ep_config = psil_get_ep_config(thread_id);
> +	if (IS_ERR(dst_ep_config)) {
> +		pr_err("PSIL: thread ID 0x%04x not defined in map\n",
> +		       thread_id);
> +		of_node_put(dma_spec.np);
> +		return PTR_ERR(dst_ep_config);
> +	}
> +
> +	memcpy(dst_ep_config, ep_config, sizeof(*dst_ep_config));
> +
> +	of_node_put(dma_spec.np);
> +	return 0;
> +}
> +EXPORT_SYMBOL(psil_set_new_ep_config);
> +
> +MODULE_DESCRIPTION("TI K3 PSI-L endpoint database");
> +MODULE_AUTHOR("Peter Ujfalusi <peter.ujfalusi@ti.com>");
> +MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/dma/k3-psil.h b/include/linux/dma/k3-psil.h
> new file mode 100644
> index 000000000000..16e9c8c6f839
> --- /dev/null
> +++ b/include/linux/dma/k3-psil.h
> @@ -0,0 +1,47 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + *  Copyright (C) 2019 Texas Instruments Incorporated - http://www.ti.com
> + */
> +
> +#ifndef K3_PSIL_H_
> +#define K3_PSIL_H_
> +
> +#include <linux/types.h>
> +
> +#define K3_PSIL_DST_THREAD_ID_OFFSET 0x8000
> +
> +struct device;
> +
> +/* Channel Throughput Levels */
> +enum udma_tp_level {
> +	UDMA_TP_NORMAL = 0,
> +	UDMA_TP_HIGH = 1,
> +	UDMA_TP_ULTRAHIGH = 2,
> +	UDMA_TP_LAST,
> +};
> +
> +enum psil_endpoint_type {
> +	PSIL_EP_NATIVE = 0,
> +	PSIL_EP_PDMA_XY,
> +	PSIL_EP_PDMA_MCAN,
> +	PSIL_EP_PDMA_AASRC,
> +};
> +
> +struct psil_endpoint_config {
> +	enum psil_endpoint_type ep_type;
> +
> +	unsigned pkt_mode:1;
> +	unsigned notdpkt:1;
> +	unsigned needs_epib:1;
> +	u32 psd_size;
> +	enum udma_tp_level channel_tpl;
> +
> +	/* PDMA properties, valid for PSIL_EP_PDMA_* */
> +	unsigned pdma_acc32:1;
> +	unsigned pdma_burst:1;
> +};
> +
> +int psil_set_new_ep_config(struct device *dev, const char *name,
> +			   struct psil_endpoint_config *ep_config);
> +
> +#endif /* K3_PSIL_H_ */
> 

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
