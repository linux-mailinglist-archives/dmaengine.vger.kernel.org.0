Return-Path: <dmaengine+bounces-6515-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8319BB57FDB
	for <lists+dmaengine@lfdr.de>; Mon, 15 Sep 2025 17:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83DB43A7180
	for <lists+dmaengine@lfdr.de>; Mon, 15 Sep 2025 15:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271192EF660;
	Mon, 15 Sep 2025 15:04:09 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3ED306B23;
	Mon, 15 Sep 2025 15:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757948649; cv=none; b=a2HBtog7mLVkd5KCiefgQNWklF5iv9zT1atFcfGg2bGQdZXDrB602va07yisF4S94KFkpFBK5FFnxxRckjKtl1TU2/0P53rDAKVZh2LS6z4qR9nBxAMWYw+f+0t7z8DxN1O+ZdKT6pDv+lmNKKlGReKyRpVdauB47JbZ2ZyWgeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757948649; c=relaxed/simple;
	bh=Qa6KjDvZQoXxK1Hzlj74tZ7QPvnaoMclXc6g/+myBhY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uGHGCTlGIAlndq01YYclsqKb8pGBbaquF7kwzkoTWTtTK1M7kc7elsNeEobRAoXzdCn9/FpCB85JBTicR8AM1EQLoo+yIOews92DsIj23mF7ExfMEPRL+8GWtbSFRyPxcKJrCN2tBkRNSDsdr8Ei0wVnRmkUB6kP8d2pGabm+7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cQSqW4b0pz6K6P3;
	Mon, 15 Sep 2025 22:59:35 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id D87E11402F5;
	Mon, 15 Sep 2025 23:04:01 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 15 Sep
 2025 17:04:01 +0200
Date: Mon, 15 Sep 2025 16:03:59 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
CC: <nathan.lynch@amd.com>, Vinod Koul <vkoul@kernel.org>, Wei Huang
	<wei.huang2@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>
Subject: Re: [PATCH RFC 10/13] dmaengine: sdxi: Add PCI driver support
Message-ID: <20250915160359.00001dd9@huawei.com>
In-Reply-To: <20250905-sdxi-base-v1-10-d0341a1292ba@amd.com>
References: <20250905-sdxi-base-v1-0-d0341a1292ba@amd.com>
	<20250905-sdxi-base-v1-10-d0341a1292ba@amd.com>
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

On Fri, 05 Sep 2025 13:48:33 -0500
Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org> wrote:

> From: Nathan Lynch <nathan.lynch@amd.com>
> 
> Add support for binding to PCIe-hosted SDXI devices. SDXI requires
> MSI(-X) for PCI implementations, so this code will be gated by
> CONFIG_PCI_MSI in the Makefile.
> 
> Co-developed-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>

I've tried not to overlap too much with other reviewers.
A few comments inline.

> ---
>  drivers/dma/sdxi/pci.c | 216 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 216 insertions(+)
> 
> diff --git a/drivers/dma/sdxi/pci.c b/drivers/dma/sdxi/pci.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..b7f74555395c605c4affffb198ee359accac8521
> --- /dev/null
> +++ b/drivers/dma/sdxi/pci.c

> + * SDXI devices signal message 0 on error conditions, see "Error
> + * Logging Control and Status Registers".
> + */
> +#define ERROR_IRQ_MSG 0
> +
> +/* MMIO BARs */
> +#define MMIO_CTL_REGS_BAR		0x0
> +#define MMIO_DOORBELL_BAR		0x2

> +
> +static void sdxi_pci_unmap(struct sdxi_dev *sdxi)
> +{
> +	struct pci_dev *pdev = sdxi_to_pci_dev(sdxi);
> +
> +	pcim_iounmap(pdev, sdxi->ctrl_regs);
> +	pcim_iounmap(pdev, sdxi->dbs);
> +}
> +
> +static int sdxi_pci_init(struct sdxi_dev *sdxi)
> +{
> +	struct pci_dev *pdev = sdxi_to_pci_dev(sdxi);
> +	struct device *dev = &pdev->dev;
> +	int dma_bits = 64;
> +	int ret;
> +
> +	ret = pcim_enable_device(pdev);
> +	if (ret) {
> +		sdxi_err(sdxi, "pcim_enbale_device failed\n");

enable.

> +		return ret;

For probe stuff I'd suggest not using the sdxi wrapper and instead
using return dev_err_probe(); I guess you could define and sdxi_err_probe()
if you want to.   

> +	}
> +
> +	pci_set_master(pdev);
> +	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(dma_bits));
> +	if (ret) {
> +		sdxi_err(sdxi, "failed to set DMA mask & coherent bits\n");
> +		return ret;
> +	}
> +
> +	ret = sdxi_pci_map(sdxi);
> +	if (ret) {
> +		sdxi_err(sdxi, "failed to map device IO resources\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void sdxi_pci_exit(struct sdxi_dev *sdxi)
> +{
> +	sdxi_pci_unmap(sdxi);
> +}
> +
> +static struct sdxi_dev *sdxi_device_alloc(struct device *dev)
> +{
> +	struct sdxi_dev *sdxi;
> +
> +	sdxi = kzalloc(sizeof(*sdxi), GFP_KERNEL);
	sdxi = devm_kzalloc(dev, sizeof(*sdxi), GFP_KERNEL);
seems like it would be sufficient here

> +	if (!sdxi)
> +		return NULL;
> +
> +	sdxi->dev = dev;
> +
> +	mutex_init(&sdxi->cxt_lock);
For new code, nice to use
	rc = devm_mutex_init(&sdxi->ctx_lock);
	if (rc)
		return ERR_PTR(rc);

Benefit for lock debugging is small, but it's also not particularly
bad wrt to code complexity here.  Up to you.

> +
> +	return sdxi;
> +}
> +
> +static void sdxi_device_free(struct sdxi_dev *sdxi)
> +{
> +	kfree(sdxi);
> +}
If this doesn't get more complex later I'd just take the view
it's obvious that kfree(sdxi) is undoing something done in sdxi_device_alloc()
and just call that inline.  No need for the trivial wrapper.

Or just use devm_kzalloc() and let the automatic stuff clean it up
for you on error or remove.


> +static const struct pci_device_id sdxi_id_table[] = {
> +	{ PCI_DEVICE_CLASS(PCI_CLASS_ACCELERATOR_SDXI, 0xffffff) },
> +	{0, }
	{ }

is fine

> +};
> +MODULE_DEVICE_TABLE(pci, sdxi_id_table);

> 


