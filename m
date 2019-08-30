Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00868A374C
	for <lists+dmaengine@lfdr.de>; Fri, 30 Aug 2019 14:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbfH3M5H (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 30 Aug 2019 08:57:07 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:39476 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727522AbfH3M5H (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 30 Aug 2019 08:57:07 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x7UCuudL128298;
        Fri, 30 Aug 2019 07:56:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1567169816;
        bh=UaNOBiFUxRDC03w4l9TpbqiM1zQ9drYlCsOBiGaSkK8=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=ZVo/sXkrLT2YKSlm9KphTh8pa8fpy8Yxtk31+HIMrpO0xXZhtFrDJBsv3TToTaRL8
         2oaPEYUs+8cgDmCHW1aJRlW2BeAN7+bkSKn9Pv/gXRQ63sLjriXlSCnkstgz11OztG
         MPa9lz4/NXbo/ABspA4TLVs3uTTGR6r3PbjE9uEA=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x7UCuuXV051443
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 30 Aug 2019 07:56:56 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 30
 Aug 2019 07:56:55 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 30 Aug 2019 07:56:55 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x7UCuql1036840;
        Fri, 30 Aug 2019 07:56:52 -0500
Subject: Re: [PATCH v2 02/14] soc: ti: k3: add navss ringacc driver
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>, <nm@ti.com>,
        <ssantosh@kernel.org>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <lokeshvutla@ti.com>,
        <t-kristo@ti.com>, <tony@atomide.com>, <j-keerthy@ti.com>
References: <20190730093450.12664-1-peter.ujfalusi@ti.com>
 <20190730093450.12664-3-peter.ujfalusi@ti.com>
Message-ID: <4da72d53-60cf-06ed-63c0-6cf8b4aeb690@ti.com>
Date:   Fri, 30 Aug 2019 15:57:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190730093450.12664-3-peter.ujfalusi@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

On 30/07/2019 12.34, Peter Ujfalusi wrote:
> From: Grygorii Strashko <grygorii.strashko@ti.com>
> 
> The Ring Accelerator (RINGACC or RA) provides hardware acceleration to
> enable straightforward passing of work between a producer and a consumer.
> There is one RINGACC module per NAVSS on TI AM65x SoCs.
> 
> The RINGACC converts constant-address read and write accesses to equivalent
> read or write accesses to a circular data structure in memory. The RINGACC
> eliminates the need for each DMA controller which needs to access ring
> elements from having to know the current state of the ring (base address,
> current offset). The DMA controller performs a read or write access to a
> specific address range (which maps to the source interface on the RINGACC)
> and the RINGACC replaces the address for the transaction with a new address
> which corresponds to the head or tail element of the ring (head for reads,
> tail for writes). Since the RINGACC maintains the state, multiple DMA
> controllers or channels are allowed to coherently share the same rings as
> applicable. The RINGACC is able to place data which is destined towards
> software into cached memory directly.
> 
> Supported ring modes:
> - Ring Mode
> - Messaging Mode
> - Credentials Mode
> - Queue Manager Mode
> 
> TI-SCI integration:
> 
> Texas Instrument's System Control Interface (TI-SCI) Message Protocol now
> has control over Ringacc module resources management (RM) and Rings
> configuration.
> 
> The corresponding support of TI-SCI Ringacc module RM protocol
> introduced as option through DT parameters:
> - ti,sci: phandle on TI-SCI firmware controller DT node
> - ti,sci-dev-id: TI-SCI device identifier as per TI-SCI firmware spec
> 
> if both parameters present - Ringacc driver will configure/free/reset Rings
> using TI-SCI Message Ringacc RM Protocol.
> 
> The Ringacc driver manages Rings allocation by itself now and requests
> TI-SCI firmware to allocate and configure specific Rings only. It's done
> this way because, Linux driver implements two stage Rings allocation and
> configuration (allocate ring and configure ring) while I-SCI Message
> Protocol supports only one combined operation (allocate+configure).
> 
> Grygorii Strashko <grygorii.strashko@ti.com>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  drivers/soc/ti/Kconfig            |   17 +
>  drivers/soc/ti/Makefile           |    1 +
>  drivers/soc/ti/k3-ringacc.c       | 1191 +++++++++++++++++++++++++++++
>  include/linux/soc/ti/k3-ringacc.h |  262 +++++++
>  4 files changed, 1471 insertions(+)
>  create mode 100644 drivers/soc/ti/k3-ringacc.c
>  create mode 100644 include/linux/soc/ti/k3-ringacc.h
> 
> diff --git a/drivers/soc/ti/Kconfig b/drivers/soc/ti/Kconfig
> index cf545f428d03..10c76faa503e 100644
> --- a/drivers/soc/ti/Kconfig
> +++ b/drivers/soc/ti/Kconfig
> @@ -80,6 +80,23 @@ config TI_SCI_PM_DOMAINS
>  	  called ti_sci_pm_domains. Note this is needed early in boot before
>  	  rootfs may be available.
>  
> +config TI_K3_RINGACC
> +	tristate "K3 Ring accelerator Sub System"
> +	depends on ARCH_K3 || COMPILE_TEST
> +	depends on TI_SCI_INTA_IRQCHIP
> +	default y
> +	help
> +	  Say y here to support the K3 Ring accelerator module.
> +	  The Ring Accelerator (RINGACC or RA)  provides hardware acceleration
> +	  to enable straightforward passing of work between a producer
> +	  and a consumer. There is one RINGACC module per NAVSS on TI AM65x SoCs
> +	  If unsure, say N.
> +
> +config TI_K3_RINGACC_DEBUG
> +	tristate "K3 Ring accelerator Sub System tests and debug"
> +	depends on TI_K3_RINGACC
> +	default n
> +
>  endif # SOC_TI
>  
>  config TI_SCI_INTA_MSI_DOMAIN
> diff --git a/drivers/soc/ti/Makefile b/drivers/soc/ti/Makefile
> index b3868d392d4f..cc4bc8b08bf5 100644
> --- a/drivers/soc/ti/Makefile
> +++ b/drivers/soc/ti/Makefile
> @@ -9,3 +9,4 @@ obj-$(CONFIG_AMX3_PM)			+= pm33xx.o
>  obj-$(CONFIG_WKUP_M3_IPC)		+= wkup_m3_ipc.o
>  obj-$(CONFIG_TI_SCI_PM_DOMAINS)		+= ti_sci_pm_domains.o
>  obj-$(CONFIG_TI_SCI_INTA_MSI_DOMAIN)	+= ti_sci_inta_msi.o
> +obj-$(CONFIG_TI_K3_RINGACC)		+= k3-ringacc.o
> diff --git a/drivers/soc/ti/k3-ringacc.c b/drivers/soc/ti/k3-ringacc.c
> new file mode 100644
> index 000000000000..401dfc963319
> --- /dev/null
> +++ b/drivers/soc/ti/k3-ringacc.c
> @@ -0,0 +1,1191 @@

...

> +void k3_ringacc_ring_reset_dma(struct k3_ring *ring, u32 occ)
> +{
> +	if (!ring || !(ring->flags & K3_RING_FLAG_BUSY))
> +		return;
> +
> +	if (!ring->parent->dma_ring_reset_quirk)

k3_ringacc_ring_reset(ring); is missing from here.

> +		return;
> +
> +	if (!occ)
> +		occ = dbg_readl(&ring->rt->occ);
> +
> +	if (occ) {
> +		u32 db_ring_cnt, db_ring_cnt_cur;
> +
> +		k3_nav_dbg(ring->parent->dev, "%s %u occ: %u\n", __func__,
> +			   ring->ring_id, occ);
> +		/* 2. Reset the ring */
> +		k3_ringacc_ring_reset_sci(ring);
> +
> +		/*
> +		 * 3. Setup the ring in ring/doorbell mode
> +		 * (if not already in this mode)
> +		 */
> +		if (ring->mode != K3_RINGACC_RING_MODE_RING)
> +			k3_ringacc_ring_reconfig_qmode_sci(
> +					ring, K3_RINGACC_RING_MODE_RING);
> +		/*
> +		 * 4. Ring the doorbell 2**22 – ringOcc times.
> +		 * This will wrap the internal UDMAP ring state occupancy
> +		 * counter (which is 21-bits wide) to 0.
> +		 */
> +		db_ring_cnt = (1U << 22) - occ;
> +
> +		while (db_ring_cnt != 0) {
> +			/*
> +			 * Ring the doorbell with the maximum count each
> +			 * iteration if possible to minimize the total
> +			 * of writes
> +			 */
> +			if (db_ring_cnt > K3_RINGACC_MAX_DB_RING_CNT)
> +				db_ring_cnt_cur = K3_RINGACC_MAX_DB_RING_CNT;
> +			else
> +				db_ring_cnt_cur = db_ring_cnt;
> +
> +			writel(db_ring_cnt_cur, &ring->rt->db);
> +			db_ring_cnt -= db_ring_cnt_cur;
> +		}
> +
> +		/* 5. Restore the original ring mode (if not ring mode) */
> +		if (ring->mode != K3_RINGACC_RING_MODE_RING)
> +			k3_ringacc_ring_reconfig_qmode_sci(ring, ring->mode);
> +	}
> +
> +	/* 2. Reset the ring */
> +	k3_ringacc_ring_reset(ring);
> +}
> +EXPORT_SYMBOL_GPL(k3_ringacc_ring_reset_dma);

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
