Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2797B3B58
	for <lists+dmaengine@lfdr.de>; Fri, 29 Sep 2023 22:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjI2UnD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 29 Sep 2023 16:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbjI2UnD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 29 Sep 2023 16:43:03 -0400
Received: from smtp.smtpout.orange.fr (smtp-22.smtpout.orange.fr [80.12.242.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 78CDE1AA
        for <dmaengine@vger.kernel.org>; Fri, 29 Sep 2023 13:43:01 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id mKCtqYUXuDYMSmKCuqSlsu; Fri, 29 Sep 2023 22:35:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1696019728;
        bh=/omWOnUopIQaBLJ6GGrAgyTNWLTcb1siWJJxie6fb7w=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=CPJsKfL1f7BtX1obCd4opisP33OL0ev+Kbwz9LO4o6N+sFGSLvUQK3hMND7zA84gx
         kjOSh/DEo0n2Bq9tPOeXbsurmszLL6JrsfXBNu6JMSnrD0QeDevQwmvfBHDcXHHWBi
         nYWhG6bKwYB/6pmkybrAtvvzPD42XDMZ6wmcDJb+U7rPtrDPxqVRYnsJ1j7F3P6jxj
         3oq94aPPd1QwnuB7psjsAXOxhAGAmA1rTwnEu0WeX2hgxZ1Gi80IQW11yRKltrEhfa
         aZy5v8qZO49plOr3XGsTPy3wDsO9Tu3lpP5WQWKUMJIebn05MQsKvgaIOj+547rMI9
         4J9Vpb80qqX7g==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 29 Sep 2023 22:35:28 +0200
X-ME-IP: 86.243.2.178
Message-ID: <0750d8b2-b624-3293-23ac-a034c88d8e0e@wanadoo.fr>
Date:   Fri, 29 Sep 2023 22:35:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH V6 1/1] dmaengine: amd: qdma: Add AMD QDMA driver
To:     Lizhi Hou <lizhi.hou@amd.com>, vkoul@kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Nishad Saraf <nishads@amd.com>, nishad.saraf@amd.com,
        sonal.santan@amd.com, max.zhen@amd.com
References: <1696008263-42937-1-git-send-email-lizhi.hou@amd.com>
 <1696008263-42937-2-git-send-email-lizhi.hou@amd.com>
Content-Language: fr
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <1696008263-42937-2-git-send-email-lizhi.hou@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Le 29/09/2023 à 19:24, Lizhi Hou a écrit :
> From: Nishad Saraf <nishads@amd.com>
> 
> Adds driver to enable PCIe board which uses AMD QDMA (the Queue-based
> Direct Memory Access) subsystem. For example, Xilinx Alveo V70 AI
> Accelerator devices.
>      https://www.xilinx.com/applications/data-center/v70.html
> 
> The QDMA subsystem is used in conjunction with the PCI Express IP block
> to provide high performance data transfer between host memory and the
> card's DMA subsystem.
> 

...

> +static int amd_qdma_probe(struct platform_device *pdev)
> +{
> +	struct qdma_platdata *pdata = dev_get_platdata(&pdev->dev);
> +	struct qdma_device *qdev;
> +	struct resource *res;
> +	void __iomem *regs;
> +	int ret;
> +
> +	qdev = devm_kzalloc(&pdev->dev, sizeof(*qdev), GFP_KERNEL);
> +	if (!qdev)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, qdev);
> +	qdev->pdev = pdev;
> +	mutex_init(&qdev->ctxt_lock);

If this was done later, it could simplify some error handling below.

> +
> +	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> +	if (!res) {
> +		qdma_err(qdev, "Failed to get IRQ resource");
> +		ret = -ENODEV;
> +		goto failed;
> +	}
> +	qdev->err_irq_idx = pdata->irq_index;
> +	qdev->queue_irq_start = res->start + 1;
> +	qdev->queue_irq_num = res->end - res->start;
> +
> +	regs = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
> +	if (IS_ERR(regs)) {
> +		ret = PTR_ERR(regs);
> +		qdma_err(qdev, "Failed to map IO resource, err %d", ret);
> +		goto failed;
> +	}
> +
> +	qdev->regmap = devm_regmap_init_mmio(&pdev->dev, regs,
> +					     &qdma_regmap_config);
> +	if (IS_ERR(qdev->regmap)) {
> +		ret = PTR_ERR(qdev->regmap);
> +		qdma_err(qdev, "Regmap init failed, err %d", ret);
> +		goto failed;
> +	}
> +
> +	ret = qdma_device_verify(qdev);
> +	if (ret)
> +		goto failed;
> +
> +	ret = qdma_get_hw_info(qdev);
> +	if (ret)
> +		goto failed;
> +
> +	INIT_LIST_HEAD(&qdev->dma_dev.channels);
> +
> +	ret = qdma_device_setup(qdev);
> +	if (ret)
> +		goto failed;
> +
> +	ret = qdma_intr_init(qdev);
> +	if (ret) {
> +		qdma_err(qdev, "Failed to initialize IRQs %d", ret);
> +		return ret;

Should it be "goto failed"?

> +	}
> +	qdev->status |= QDMA_DEV_STATUS_INTR_INIT;
> +
> +	dma_cap_set(DMA_SLAVE, qdev->dma_dev.cap_mask);
> +	dma_cap_set(DMA_PRIVATE, qdev->dma_dev.cap_mask);

...

> +struct qdma_device {
> +	struct platform_device		*pdev;
> +	struct dma_device		dma_dev;
> +	struct regmap			*regmap;
> +	struct mutex			ctxt_lock; /* protect ctxt registers */
> +	const struct qdma_reg_field	*rfields;
> +	const struct qdma_reg		*roffs;
> +	struct qdma_queue		*h2c_queues;
> +	struct qdma_queue		*c2h_queues;
> +	struct qdma_intr_ring		*qintr_rings;
> +	u32				qintr_ring_num;
> +	u32				qintr_ring_idx;
> +	u32				chan_num;
> +	u32				queue_irq_start;
> +	u32				queue_irq_num;
> +	u32				err_irq_idx;
> +	u32				fid;
> +	u32				status;

Using such a mechanism with this 'status' in the probe and 
amd_qdma_remove(), apparently only to simplify the error handling of the 
probe looks really unusual to me.

CJ

> +};

...

