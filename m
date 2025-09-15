Return-Path: <dmaengine+bounces-6510-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC263B5799A
	for <lists+dmaengine@lfdr.de>; Mon, 15 Sep 2025 13:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFD4416440A
	for <lists+dmaengine@lfdr.de>; Mon, 15 Sep 2025 11:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805A12FC015;
	Mon, 15 Sep 2025 11:59:43 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3105A2FF67E;
	Mon, 15 Sep 2025 11:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757937583; cv=none; b=pSu9ZsZt6ggVcjyc0HpgCm2fji/7ahbMky/5JOd1I7OsPxvYlQPWh1Aas5hd1sks7W+i0bLV6n+rbQvqoft+07rvBA1DFywUCn9I+jb9do8RV8XG+XwT2h5aBkLJaYTcfal4ZvOVfcQcOVfqUZX3dHEFs+te1bmr7WatvCbG8lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757937583; c=relaxed/simple;
	bh=0atUbuex1WlEaQIwqqQJx3gQteNqeRmz4Pmh2A2EI4M=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hYUV35K5tsmXjAKgFQkFrdrbYwexQW4nmCw3Fyff/wiVfTYTxg1hHcIoBJ8ID7drxuY6uZdKfaG6nGpCPn6tY32uKxex/Wif1nyY08uH/6u/bKHhDiRYPWUH2ja2rwMkLPUiCuxeyPtJcHbdrlJS/laBtPXbevyBa6tDdsAS05I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cQNmj20DQz6M57M;
	Mon, 15 Sep 2025 19:56:53 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id CA4E11400DC;
	Mon, 15 Sep 2025 19:59:38 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 15 Sep
 2025 13:59:38 +0200
Date: Mon, 15 Sep 2025 12:59:37 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
CC: <nathan.lynch@amd.com>, Vinod Koul <vkoul@kernel.org>, Wei Huang
	<wei.huang2@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>
Subject: Re: [PATCH RFC 05/13] dmaengine: sdxi: Add software data structures
Message-ID: <20250915125937.000072ab@huawei.com>
In-Reply-To: <20250905-sdxi-base-v1-5-d0341a1292ba@amd.com>
References: <20250905-sdxi-base-v1-0-d0341a1292ba@amd.com>
	<20250905-sdxi-base-v1-5-d0341a1292ba@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 05 Sep 2025 13:48:28 -0500
Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org> wrote:

> From: Nathan Lynch <nathan.lynch@amd.com>
> 
> Add the driver's central header sdxi.h, which brings in the major
> software abstractions used throughout the driver -- mainly the SDXI
> device or function (sdxi_dev) and context (sdxi_cxt).
> 
> Co-developed-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>

I'm not personally a fan of 'header' patches.  It's find of reasonable if it's
just stuff of the datasheet, but once we get function definitions, we should
have the function implementations in the same patch.

> ---
>  drivers/dma/sdxi/sdxi.h | 206 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 206 insertions(+)
> 
> diff --git a/drivers/dma/sdxi/sdxi.h b/drivers/dma/sdxi/sdxi.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..13e02f0541e0d60412c99b0b75bd37155a531e1d
> --- /dev/null
> +++ b/drivers/dma/sdxi/sdxi.h
> @@ -0,0 +1,206 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * SDXI device driver header
> + *
> + * Copyright (C) 2025 Advanced Micro Devices, Inc.
> + */
> +
> +#ifndef __SDXI_H
> +#define __SDXI_H
> +
> +#include <linux/dev_printk.h>
> +#include <linux/device.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/dmapool.h>

Some of these could I think be removed in favor of one or two forwards
definitions.  In general good to keep to minimal includes following principles of
include what you use din each file.

> +#include <linux/dmaengine.h>
> +#include <linux/io-64-nonatomic-lo-hi.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/types.h>



> +/* Device Control */

Superficially these don't seem have anything to do with controlling
the device. So this comment is confusing to me rather than helpful.

> +int sdxi_device_init(struct sdxi_dev *sdxi, const struct sdxi_dev_ops *ops);
> +void sdxi_device_exit(struct sdxi_dev *sdxi);

Bring these in with the code, not in an earlier patch.
Ideally set things up so the code is build able after each patch.




