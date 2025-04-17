Return-Path: <dmaengine+bounces-4920-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 348ABA9236A
	for <lists+dmaengine@lfdr.de>; Thu, 17 Apr 2025 19:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 946F13BA4D2
	for <lists+dmaengine@lfdr.de>; Thu, 17 Apr 2025 17:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2EFA22B8C8;
	Thu, 17 Apr 2025 17:07:29 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE1D2550B6;
	Thu, 17 Apr 2025 17:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744909649; cv=none; b=G0v7Rpov/PigvL32ybDgePUwXaXfh45ZEQWKdnCfvrt0FgwohmrIXxRIMZk1qTtbM6UZphEY15A829YQjcDF827C5LlXZn/wRfuGEN4C2nIlokf5OIKpGvZNnNFqmVXiLAA6zKqn9YMYwqjEdGR9kyEz2/6N4wjmo4Z/e82dZqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744909649; c=relaxed/simple;
	bh=fEPLRrhKmzms7qgN8GEjuB1eEhoQB9sxMKXLJqiOKtk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WitInRqpy7MNfOek0+W2TxzVgELEKTBAkWbi/8Q8fne/lP+87GyhpXuHK+/TCwcjqNhgEvY38h7louhCW5w08Suxok5dUhsQgtflB80Xlhb02GqqcdbYL1gd+TvRidPhae8J0Rk2O6sHYjG/1+ieGQe7YRIiJPfpMij1MQihP8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Zdkjl0nrbz6K9K2;
	Fri, 18 Apr 2025 01:03:07 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id A57A3140145;
	Fri, 18 Apr 2025 01:07:24 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 17 Apr
 2025 19:07:24 +0200
Date: Thu, 17 Apr 2025 18:07:22 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Robin Murphy <robin.murphy@arm.com>
CC: <vkoul@kernel.org>, <devicetree@vger.kernel.org>,
	<dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 2/2] dmaengine: Add Arm DMA-350 driver
Message-ID: <20250417180722.00002465@huawei.com>
In-Reply-To: <6d7d8efefa935d34977b59a74797ab377528db94.1741780808.git.robin.murphy@arm.com>
References: <cover.1741780808.git.robin.murphy@arm.com>
	<6d7d8efefa935d34977b59a74797ab377528db94.1741780808.git.robin.murphy@arm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 12 Mar 2025 12:05:10 +0000
Robin Murphy <robin.murphy@arm.com> wrote:

> Add an initial driver for the Arm Corelink DMA-350 controller, to
> support basic mem-to-mem async_tx. The design here leaves room for more
> fun things like peripheral support and scatter-gather chaining to come
> in future.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> v2:
>  - Fix build warnings
>  - Limit retries for reading live residue
Drive by review as I was curious...

Few things inline but it's been too long since I last looked
at a DMA driver to give a detailed review.

Jonathan

> +
> +static int d350_probe(struct platform_device *pdev)
> +{



> +
> +	platform_set_drvdata(pdev, dmac);
If you used the managed form of register, I don't think you need this?
> +
> +	ret = dma_async_device_register(&dmac->dma);

This is pretty noisy on most non -ENOMEM errors anyway. Is it worth another
layer of error print?

> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to register DMA device\n");
> +
> +	return 0;
> +}
> +
> +static void d350_remove(struct platform_device *pdev)
> +{
> +	struct d350 *dmac = platform_get_drvdata(pdev);
> +
> +	dma_async_device_unregister(&dmac->dma);

dmaenginem_async_device_register() and get rid of remove.

J



> +}



