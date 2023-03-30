Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE97F6D12DA
	for <lists+dmaengine@lfdr.de>; Fri, 31 Mar 2023 01:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbjC3XKc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 30 Mar 2023 19:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjC3XKb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 30 Mar 2023 19:10:31 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94081CA0F;
        Thu, 30 Mar 2023 16:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:To:
        MIME-Version:Date:Message-ID:cc:content-disposition;
        bh=IYoLxfXdh42eqgzRFxli7S0EgtfkxGlNhOSigI3GRE0=; b=mFbD8Eiz6E02+g22+F8QmHrMIl
        ECPR2l8GJifrt2Qt4XWe/SvSy+3sncUvz5DH8XThRXq85qjisH7ouj0MfgPZfwcvnqHc0CJsSRYrF
        WaSPuNLhRrTrpGsgXD5+ezprY+1U0hB450qMGXEOoEA+IjEsLfP54MaTqmgnnfZs//XpRKm8KLetC
        Qy8OoOxyEXhidTZsAt21p8pHqCBHqYqhLsBG+1DKC26ltdGtRIRtQa3/4BzAEDtQUnKFdb8AqEChS
        kbHajvKOxsbh3+bWerARbkca/rvQN/pDL7O7txN75VDUsTyKqMmgjboONdLYDm7uk7xrrNCtk7Sob
        jdYyoCWA==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1pi1PT-00DmhG-5d; Thu, 30 Mar 2023 17:10:24 -0600
Message-ID: <189e7cf7-3a90-d15e-4e45-f438b751a484@deltatee.com>
Date:   Thu, 30 Mar 2023 17:10:22 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-CA
To:     Kelvin Cao <kelvin.cao@microchip.com>, vkoul@kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230328011142.2107129-1-kelvin.cao@microchip.com>
 <20230328011142.2107129-4-kelvin.cao@microchip.com>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20230328011142.2107129-4-kelvin.cao@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: kelvin.cao@microchip.com, vkoul@kernel.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
Subject: Re: [PATCH 1/1] dmaengine: switchtec-dma: Introduce Switchtec DMA
 engine PCI driver
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Kelvin,

On 2023-03-27 19:11, Kelvin Cao wrote:
> Some Switchtec Switches can expose DMA engines via extra PCI functions
> on the upstream ports. At most one such function can be supported on
> each upstream port. Each function can have one or more DMA channels.
> 
> Implement core PCI driver skeleton and register DMA engine callbacks.
> 
> Signed-off-by: Kelvin Cao <kelvin.cao@microchip.com>
> Co-developed-by: George Ge <george.ge@microchip.com>
> Signed-off-by: George Ge <george.ge@microchip.com>

Looks largely good. I did a quick review on some of the code and have a
few questions and nits.

> +static void switchtec_dma_release(struct dma_device *dma_dev)
> +{
> +	int i;
> +	struct switchtec_dma_dev *swdma_dev =
> +		container_of(dma_dev, struct switchtec_dma_dev, dma_dev);
> +
> +	for (i = 0; i < swdma_dev->chan_cnt; i++)
> +		kfree(swdma_dev->swdma_chans[i]);
> +
> +	kfree(swdma_dev->swdma_chans);
> +	kfree(swdma_dev);
> +
> +	put_device(dma_dev->dev);

dma_dev is part of swdma_dev, but it was just kfree'd so this doesn't
look valid.

> +}
> +
> +static int switchtec_dma_create(struct pci_dev *pdev)
> +{
> +	struct switchtec_dma_dev *swdma_dev;
> +	struct dma_device *dma;
> +	struct dma_chan *chan;
> +	struct device *dev = &pdev->dev;
> +	void __iomem *bar;
> +	int chan_cnt;
> +	int nr_vecs;
> +	int irq;
> +	int rc;
> +	int i;
> +
> +	/*
> +	 * Create the switchtec dma device
> +	 */
> +	swdma_dev = kzalloc(sizeof(*swdma_dev), GFP_KERNEL);
> +	if (!swdma_dev)
> +		return -ENOMEM;
> +
> +	bar = pcim_iomap_table(pdev)[0];
> +	swdma_dev->bar = bar;
> +
> +	swdma_dev->mmio_dmac_ver = bar + SWITCHTEC_DMAC_VERSION_OFFSET;
> +	swdma_dev->mmio_dmac_cap = bar + SWITCHTEC_DMAC_CAPABILITY_OFFSET;
> +	swdma_dev->mmio_dmac_status = bar + SWITCHTEC_DMAC_STATUS_OFFSET;
> +	swdma_dev->mmio_dmac_ctrl = bar + SWITCHTEC_DMAC_CONTROL_OFFSET;
> +	swdma_dev->mmio_chan_hw_all = bar + SWITCHTEC_DMAC_CHAN_CTRL_OFFSET;
> +	swdma_dev->mmio_chan_fw_all = bar + SWITCHTEC_DMAC_CHAN_CFG_STS_OFFSET;
> +
> +	dev_info(dev, "Switchtec PSX/PFX DMA EP\n");

Other prints in this function use the pci_version and pdev directly. As
best as I can see 'dev' is unused except for these prints so could be
removed and converted to pci_ functions.


> +static void switchtec_dma_remove(struct pci_dev *pdev)
> +{
> +	struct switchtec_dma_dev *swdma_dev = pci_get_drvdata(pdev);
> +
> +	switchtec_dma_chans_release(swdma_dev);
> +
> +	tasklet_kill(&swdma_dev->chan_status_task);
> +
> +	rcu_assign_pointer(swdma_dev->pdev, NULL);
> +	synchronize_rcu();

switchtec_dma_remove() can be called while transactions are in progress.
I'm not seeing anything here that might abort transactions that have
been placed on the ring that might not have been finished by the
hardware. Maybe I'm not seeing it. But have you tested unbind while
active? Simply run a process that does dma transactions and then use
sysfs to unbind the pci device and ensure there are no kernel hangs,
panics or memory leaks.

> +#define SWITCHTEC_PCI_DEVICE(device_id, is_fabric) \
> +	{ \
> +		.vendor     = MICROSEMI_VENDOR_ID, \
> +		.device     = device_id, \
> +		.subvendor  = PCI_ANY_ID, \
> +		.subdevice  = PCI_ANY_ID, \
> +		.class      = PCI_CLASS_SYSTEM_OTHER << 8, \
> +		.class_mask = 0xFFFFFFFF, \
> +		.driver_data = is_fabric, \
> +	}

Doesn't look like the .driver_data is used anywhere. Seems like it can
be removed.

> +static const struct pci_device_id switchtec_dma_pci_tbl[] = {
> +	SWITCHTEC_PCI_DEVICE(0x4000, 0),  //PFX 100XG4
> +	SWITCHTEC_PCI_DEVICE(0x4084, 0),  //PFX 84XG4
> +	SWITCHTEC_PCI_DEVICE(0x4068, 0),  //PFX 68XG4
> +	SWITCHTEC_PCI_DEVICE(0x4052, 0),  //PFX 52XG4
> +	SWITCHTEC_PCI_DEVICE(0x4036, 0),  //PFX 36XG4
> +	SWITCHTEC_PCI_DEVICE(0x4028, 0),  //PFX 28XG4
> +	SWITCHTEC_PCI_DEVICE(0x4100, 0),  //PSX 100XG4
> +	SWITCHTEC_PCI_DEVICE(0x4184, 0),  //PSX 84XG4
> +	SWITCHTEC_PCI_DEVICE(0x4168, 0),  //PSX 68XG4
> +	SWITCHTEC_PCI_DEVICE(0x4152, 0),  //PSX 52XG4
> +	SWITCHTEC_PCI_DEVICE(0x4136, 0),  //PSX 36XG4
> +	SWITCHTEC_PCI_DEVICE(0x4128, 0),  //PSX 28XG4
> +	SWITCHTEC_PCI_DEVICE(0x4352, 0),  //PFXA 52XG4
> +	SWITCHTEC_PCI_DEVICE(0x4336, 0),  //PFXA 36XG4
> +	SWITCHTEC_PCI_DEVICE(0x4328, 0),  //PFXA 28XG4
> +	SWITCHTEC_PCI_DEVICE(0x4452, 0),  //PSXA 52XG4
> +	SWITCHTEC_PCI_DEVICE(0x4436, 0),  //PSXA 36XG4
> +	SWITCHTEC_PCI_DEVICE(0x4428, 0),  //PSXA 28XG4
> +	{0}
> +};
> +MODULE_DEVICE_TABLE(pci, switchtec_dma_pci_tbl);
> +
> +static struct pci_driver switchtec_dma_pci_driver = {
> +	.name           = KBUILD_MODNAME,
> +	.id_table       = switchtec_dma_pci_tbl,
> +	.probe          = switchtec_dma_probe,
> +	.remove		= switchtec_dma_remove,
> +};
> +module_pci_driver(switchtec_dma_pci_driver);


Logan
