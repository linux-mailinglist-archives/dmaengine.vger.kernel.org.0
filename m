Return-Path: <dmaengine+bounces-6514-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF4FB57ECD
	for <lists+dmaengine@lfdr.de>; Mon, 15 Sep 2025 16:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 493941881443
	for <lists+dmaengine@lfdr.de>; Mon, 15 Sep 2025 14:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF7B31D73E;
	Mon, 15 Sep 2025 14:23:39 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC7B2D47E9;
	Mon, 15 Sep 2025 14:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757946219; cv=none; b=kSYIdt9SIc25Oo9cEWUDHsfadfhHk58APfUB/GIHjF9eFQv766/gjzCOgA1/r+xJ3JXHJgtP30RfKod6FLoRdl6H/R3abV2XGfahSKBlcsMrFpm7nH2tgs8hbUNZWfCtnpti1LyGy2zBCYra4wWWadmTPWqvwL2ycmI7iTrH3JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757946219; c=relaxed/simple;
	bh=iz4uKvy7SB6UYL7OoAKNHTcq4otez6KpMxNIszYs3JY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lcvNMLxpzZ9ovR8/LbZpTfE9Elga/hp8+VtahT0Z84/pF7Kn9SRnw8Wm8PwXxoFdeV8f14gY9AGOIqcb0j12m/WiF0ckRXFyHQJwa1JuBZrnH6fMw9vBRGc4AoYGEOE8bjg9MOWuIQ44w+/ZTW0vCgeeZCtSnvNi86FRum4bqmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cQRwp4slZz6K5dp;
	Mon, 15 Sep 2025 22:19:06 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id D06951402FB;
	Mon, 15 Sep 2025 22:23:32 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 15 Sep
 2025 16:23:32 +0200
Date: Mon, 15 Sep 2025 15:23:31 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
CC: <nathan.lynch@amd.com>, Vinod Koul <vkoul@kernel.org>, Wei Huang
	<wei.huang2@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>
Subject: Re: [PATCH RFC 09/13] dmaengine: sdxi: Add core device management
 code
Message-ID: <20250915152331.0000246a@huawei.com>
In-Reply-To: <20250905-sdxi-base-v1-9-d0341a1292ba@amd.com>
References: <20250905-sdxi-base-v1-0-d0341a1292ba@amd.com>
 <20250905-sdxi-base-v1-9-d0341a1292ba@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 05 Sep 2025 13:48:32 -0500
Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org> wrote:

> From: Nathan Lynch <nathan.lynch@amd.com>
> 
> Add code that manages device initialization and exit and provides
> entry points for the PCI driver code to come.

I'd prefer a patch series that started with the PCI device and built up
functionality for the stuff found earlier + in this patch on top of it.
Doing that allows each patch to be fully tested and reviewed on it's own.

However not my driver or subsystem so up to others on whether
they care!

One request for more info inline.

> 
> Co-developed-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
> ---


> +
> +/* Refer to "Activation of the SDXI Function by Software". */
> +static int sdxi_fn_activate(struct sdxi_dev *sdxi)
> +{
> +	const struct sdxi_dev_ops *ops = sdxi->dev_ops;
> +	u64 cxt_l2;
> +	u64 cap0;
> +	u64 cap1;
> +	u64 ctl2;

Combine these u64 declarations on one line.

> +	int err;
> +
> +	/*
> +	 * Clear any existing configuration from MMIO_CTL0 and ensure
> +	 * the function is in GSV_STOP state.
> +	 */
> +	sdxi_write64(sdxi, SDXI_MMIO_CTL0, 0);
> +	err = sdxi_dev_stop(sdxi);
> +	if (err)
> +		return err;
> +
> +	/*
> +	 * 1.a. Discover limits and implemented features via MMIO_CAP0
> +	 * and MMIO_CAP1.
> +	 */
> +	cap0 = sdxi_read64(sdxi, SDXI_MMIO_CAP0);
> +	

> +
> +void sdxi_device_exit(struct sdxi_dev *sdxi)
> +{
> +	sdxi_working_cxt_exit(sdxi->dma_cxt);
> +
> +	/* Walk sdxi->cxt_array freeing any allocated rows. */
> +	for (size_t i = 0; i < L2_TABLE_ENTRIES; ++i) {
> +		if (!sdxi->cxt_array[i])
> +			continue;
> +		/* When a context is released its entry in the table should be NULL. */
> +		for (size_t j = 0; j < L1_TABLE_ENTRIES; ++j) {
> +			struct sdxi_cxt *cxt = sdxi->cxt_array[i][j];
> +
> +			if (!cxt)
> +				continue;
> +			if (cxt->id != 0)  /* admin context shutdown is last */
> +				sdxi_working_cxt_exit(cxt);
> +			sdxi->cxt_array[i][j] = NULL;
> +		}
> +		if (i != 0)  /* another special case for admin cxt */
> +			kfree(sdxi->cxt_array[i]);
> +	}
> +
> +	sdxi_working_cxt_exit(sdxi->admin_cxt);
> +	kfree(sdxi->cxt_array[0]);  /* ugh */

The constraints here need to be described a little more clearly.


> +
> +	sdxi_stop(sdxi);
> +	sdxi_error_exit(sdxi);
> +	if (sdxi->dev_ops && sdxi->dev_ops->irq_exit)
> +		sdxi->dev_ops->irq_exit(sdxi);
> +}


