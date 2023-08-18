Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 159DC7809E1
	for <lists+dmaengine@lfdr.de>; Fri, 18 Aug 2023 12:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344286AbjHRKUR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 18 Aug 2023 06:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359520AbjHRKUQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 18 Aug 2023 06:20:16 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887B61706;
        Fri, 18 Aug 2023 03:20:14 -0700 (PDT)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RRyVy6bh9zVkdj;
        Fri, 18 Aug 2023 18:18:02 +0800 (CST)
Received: from [10.174.178.156] (10.174.178.156) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 18 Aug 2023 18:20:10 +0800
Message-ID: <63211be7-3c35-5032-18eb-5af36773f501@huawei.com>
Date:   Fri, 18 Aug 2023 18:20:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 1/2] dmaengine: Add HiSilicon Ascend SDMA engine support
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <devicetree@vger.kernel.org>
CC:     <xuqiang36@huawei.com>
References: <20230811034822.107229-1-guomengqi3@huawei.com>
 <20230811034822.107229-2-guomengqi3@huawei.com>
 <4270b7d0-d375-0b2a-e472-700cb87be7a0@linaro.org>
From:   "guomengqi (A)" <guomengqi3@huawei.com>
In-Reply-To: <4270b7d0-d375-0b2a-e472-700cb87be7a0@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.156]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

在 2023/8/14 16:54, Krzysztof Kozlowski 写道:
> On 11/08/2023 05:48, Guo Mengqi wrote:
>> This patch adds a driver for HiSilicon Ascend SDMA engine.
>>
>> The DMA controller can do transfers between device and memory
>> or memory to memory. Currently, the controller only support
>> single copy. Drives can pass a substreamid to the DMA engine,
>> which will enable transfers in user-space addresses.
> ...
>
>> +
>> +static int sdma_device_probe(struct platform_device *pdev)
>> +{
>> +	int ret;
>> +	struct device *dev;
>> +	struct sdma_dev *sdev;
>> +	struct sdma_hardware_info info;
>> +
>> +	dev = &pdev->dev;
>> +
>> +	if (!pdev->dev.bus) {
>> +		pr_debug("the sdma dev bus is NULL\n");
> How is this possible?
    This shall not be possible. Removed.
>
>> +		return -EPROBE_DEFER;
>> +	}
>> +
>> +	if (!pdev->dev.bus->iommu_ops) {
>> +		pr_debug("defer probe sdma device\n");
> Anyway, no pr_xxx, but dev_xxx. Is it really, really possible?
>
If iommu driver is loaded later than this driver, then here iommu_ops 
may be uninitialized.
>> +		return -EPROBE_DEFER;> +	}
>> +
>> +	sdev = devm_kzalloc(dev, sizeof(*sdev), GFP_KERNEL);
>> +	if (!sdev) {
>> +		pr_err("alloc sdma_device failed\n");
>> +		return -ENOMEM;
>> +	}
>> +
>> +	sdev->pdev = pdev;
>> +	dev_set_drvdata(&pdev->dev, sdev);
> Come on, you just stored pdev->dev under dev!
>> +
>> +	ret = of_sdma_collect_info(pdev, &info);
>> +	if (ret < 0) {
>> +		pr_err("collect device info failed, %d\n", ret);
> dev_err
>
> Please work on this driver to start looking like other kernel drivers.
>
>
>> +		return ret;
>> +	}
>> +
>> +	sdev->io_base = ioremap(info.base_addr, SDMA_IOMEM_SIZE);
>> +	if (!sdev->io_base) {
>> +		pr_err("ioremap failed\n");
>> +		ret = -ENOMEM;
>> +		return ret;
>> +	}
>> +
>> +	/* Fill in dmaengine */
>> +	sdma_init_dma_device(&sdev->dma_dev, dev);
>> +
>> +	ret = sdma_init_channels(sdev, &info);
>> +	if (ret < 0)
>> +		goto unmap_iobase;
>> +
>> +	ret = iommu_dev_enable_feature(&pdev->dev, IOMMU_DEV_FEAT_IOPF);
>> +	if (ret) {
>> +		pr_err("iommu failed to init iopf, %d\n", ret);
>> +		goto destroy_channels;
>> +	}
>> +
>> +	ret = iommu_dev_enable_feature(&pdev->dev, IOMMU_DEV_FEAT_SVA);
>> +	if (ret) {
>> +		pr_err("iommu failed to init sva, %d\n", ret);
>> +		goto disable_iopf;
>> +	}
>> +
>> +	sdev->streamid = pdev->dev.iommu->fwspec->ids[0];
>> +
>> +	snprintf(sdev->name, SDMA_DEVICE_NAME_LENGTH_MAX, "sdma%d", sdev->idx);
>> +	pr_info("%s device probe success\n", sdev->name);
> No, drop.
>
>> +
>> +	ret = dma_async_device_register(&sdev->dma_dev);
>> +	if (ret) {
>> +		dev_err(dev, "failed to register slave DMA engine: %d\n", ret);
>> +		goto disable_sva;
>> +	}
>> +
>> +	return 0;
>> +
>> +disable_sva:
>> +	iommu_dev_disable_feature(&pdev->dev, IOMMU_DEV_FEAT_SVA);
>> +disable_iopf:
>> +	iommu_dev_disable_feature(&pdev->dev, IOMMU_DEV_FEAT_IOPF);
>> +destroy_channels:
>> +	sdma_destroy_channels(sdev);
>> +unmap_iobase:
>> +	iounmap(sdev->io_base);
>> +	return ret;
>> +}
>> +
>> +static int sdma_device_remove(struct platform_device *pdev)
>> +{
>> +	struct sdma_dev *psdma_dev = dev_get_drvdata(&pdev->dev);
>> +
>> +	dma_async_device_unregister(&psdma_dev->dma_dev);
>> +
>> +	iommu_dev_disable_feature(&pdev->dev, IOMMU_DEV_FEAT_SVA);
>> +	iommu_dev_disable_feature(&pdev->dev, IOMMU_DEV_FEAT_IOPF);
>> +
>> +	sdma_destroy_channels(psdma_dev);
>> +
>> +	iounmap(psdma_dev->io_base);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct of_device_id sdma_of_match[] = {
>> +	{ .compatible = "hisilicon,sdma" },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(of, sdma_of_match);
>> +
>> +static struct platform_driver sdma_driver = {
>> +	.probe    = sdma_device_probe,
>> +	.remove   = sdma_device_remove,
>> +	.driver   = {
>> +		.name           = SDMA_DEVICE_NAME,
>> +		.of_match_table = sdma_of_match,
>> +	},
>> +};
>> +
>> +static int __init sdma_driver_init(void)
>> +{
>> +	return platform_driver_register(&sdma_driver);
>> +}
>> +module_init(sdma_driver_init);
>> +
>> +static void sdma_driver_exit(void)
>> +{
>> +	platform_driver_unregister(&sdma_driver);
>> +}
>> +module_exit(sdma_driver_exit);
> module_platform_driver
>
>
> Best regards,
> Krzysztof
>
> .

Hi

Thank you for carefully reviewing this patch and give all these advices.

I had sent a version 2 of the patch and fixed these points in dts 
bindings and driver code.

If any thing else is wrong, please let me know.


Best regards,

Guo Mengqi

