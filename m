Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7885530C710
	for <lists+dmaengine@lfdr.de>; Tue,  2 Feb 2021 18:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237256AbhBBRJa (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 2 Feb 2021 12:09:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:40490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236641AbhBBRIm (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 2 Feb 2021 12:08:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E900864E08;
        Tue,  2 Feb 2021 17:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612285681;
        bh=Z8cMomjrAYU4z9TUMAf08w8gzIc/ZvDdmZSEWtHFl8w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0aCKKeUCWFNzkU9jARYAHj0g+6nBg6G7Bc86hchJz+tm6O+EybeGgnNLqGEnR+vfp
         7uabR2M/vSMuhMBtfo5svwDaEeVbwTgUMXjmgVBcEjTIL/EUEQ9E4nPRQpLu8EsKPw
         bXDoWHa6qBTlJhN9jS/n77a+1Sy9PRFskdkAk944=
Date:   Tue, 2 Feb 2021 18:07:58 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [RESEND PATCH v3 1/5] misc: Add Synopsys DesignWare xData IP
 driver
Message-ID: <YBmG7qgIDYIveDfX@kroah.com>
References: <cover.1612284945.git.gustavo.pimentel@synopsys.com>
 <2c70018d5965c171c15870638ee717fe5f9483f6.1612284945.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c70018d5965c171c15870638ee717fe5f9483f6.1612284945.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Feb 02, 2021 at 05:56:34PM +0100, Gustavo Pimentel wrote:
> Add Synopsys DesignWare xData IP driver. This driver enables/disables
> the PCI traffic generator module pertain to the Synopsys DesignWare
> prototype.
> 
> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> ---
>  drivers/misc/dw-xdata-pcie.c | 379 +++++++++++++++++++++++++++++++++++++++++++

You are adding sysfs entries but you do not have any Documentation/ABI/
entries for us to be able to properly review this code :(

> +static ssize_t sysfs_write_show(struct kobject *kobj,
> +				struct kobj_attribute *attr, char *buf)
> +{
> +	struct device *dev = kobj2device(kobj);
> +	struct pci_dev *pdev = device2pci_dev(dev);
> +	struct dw_xdata *dw = pci_get_drvdata(pdev);
> +	u64 rate;
> +
> +	dw_xdata_perf(dw, &rate, true);
> +	return sprintf(buf, "%llu MB/s\n", rate);

sysfs_emit()

> +}
> +
> +static ssize_t sysfs_write_store(struct kobject *kobj,
> +				 struct kobj_attribute *attr, const char *buf,
> +				 size_t count)
> +{
> +	struct device *dev = kobj2device(kobj);
> +	struct pci_dev *pdev = device2pci_dev(dev);
> +	struct dw_xdata *dw = pci_get_drvdata(pdev);
> +
> +	pci_dbg(pdev, "xData: requested write transfer\n");
> +	dw_xdata_start(dw, true);
> +
> +	return count;
> +}
> +
> +struct kobj_attribute sysfs_write_attr = __ATTR(write, 0644,
> +						sysfs_write_show,
> +						sysfs_write_store);

__ATTR_RW() please

> +
> +static ssize_t sysfs_read_show(struct kobject *kobj,
> +			       struct kobj_attribute *attr, char *buf)
> +{
> +	struct device *dev = kobj2device(kobj);
> +	struct pci_dev *pdev = device2pci_dev(dev);
> +	struct dw_xdata *dw = pci_get_drvdata(pdev);
> +	u64 rate;
> +
> +	dw_xdata_perf(dw, &rate, false);
> +	return sprintf(buf, "%llu MB/s\n", rate);

sysfs_emit()

> +}
> +
> +static ssize_t sysfs_read_store(struct kobject *kobj,
> +				struct kobj_attribute *attr, const char *buf,
> +				size_t count)
> +{
> +	struct device *dev = kobj2device(kobj);
> +	struct pci_dev *pdev = device2pci_dev(dev);
> +	struct dw_xdata *dw = pci_get_drvdata(pdev);
> +
> +	pci_dbg(pdev, "xData: requested read transfer\n");
> +	dw_xdata_start(dw, false);
> +
> +	return count;
> +}
> +
> +struct kobj_attribute sysfs_read_attr = __ATTR(read, 0644,
> +					       sysfs_read_show,
> +					       sysfs_read_store);

__ATTR_RW()

> +
> +static ssize_t sysfs_stop_store(struct kobject *kobj,
> +				struct kobj_attribute *attr, const char *buf,
> +				size_t count)
> +{
> +	struct device *dev = kobj2device(kobj);

Wait, what???

Why are you creating "raw" kobjects here?  This is a device, use device
attributes.  Use DEVICE_ATTR_RW() for all of the above.

Who reviewed this thing???

> +	struct pci_dev *pdev = device2pci_dev(dev);
> +	struct dw_xdata *dw = pci_get_drvdata(pdev);
> +
> +	pci_dbg(pdev, "xData: requested stop any transfer\n");
> +	dw_xdata_stop(dw);
> +
> +	return count;
> +}
> +
> +struct kobj_attribute sysfs_stop_attr = __ATTR(stop, 0644,
> +					       NULL,
> +					       sysfs_stop_store);
> +
> +static int dw_xdata_pcie_probe(struct pci_dev *pdev,
> +			       const struct pci_device_id *pid)
> +{
> +	const struct dw_xdata_pcie_data *pdata = (void *)pid->driver_data;
> +	struct device *dev = &pdev->dev;
> +	struct dw_xdata *dw;
> +	u64 addr;
> +	int err;
> +
> +	/* Enable PCI device */
> +	err = pcim_enable_device(pdev);
> +	if (err) {
> +		pci_err(pdev, "enabling device failed\n");
> +		return err;
> +	}
> +
> +	/* Mapping PCI BAR regions */
> +	err = pcim_iomap_regions(pdev, BIT(pdata->rg_bar), pci_name(pdev));
> +	if (err) {
> +		pci_err(pdev, "xData BAR I/O remapping failed\n");
> +		return err;
> +	}
> +
> +	pci_set_master(pdev);
> +
> +	/* Allocate memory */
> +	dw = devm_kzalloc(&pdev->dev, sizeof(*dw), GFP_KERNEL);
> +	if (!dw)
> +		return -ENOMEM;
> +
> +	/* Data structure initialization */
> +	dw->rg_region.vaddr = pcim_iomap_table(pdev)[pdata->rg_bar];
> +	if (!dw->rg_region.vaddr)
> +		return -ENOMEM;
> +
> +	dw->rg_region.vaddr += pdata->rg_off;
> +	dw->rg_region.paddr = pdev->resource[pdata->rg_bar].start;
> +	dw->rg_region.paddr += pdata->rg_off;
> +	dw->rg_region.sz = pdata->rg_sz;
> +
> +	dw->max_wr_len = pcie_get_mps(pdev);
> +	dw->max_wr_len >>= 2;
> +
> +	dw->max_rd_len = pcie_get_readrq(pdev);
> +	dw->max_rd_len >>= 2;
> +
> +	dw->pdev = pdev;
> +
> +	writel(0x0, &(__dw_regs(dw)->RAM_addr));
> +	writel(0x0, &(__dw_regs(dw)->RAM_port));
> +
> +	addr = dw->rg_region.paddr + DW_XDATA_EP_MEM_OFFSET;
> +	writel(lower_32_bits(addr), &(__dw_regs(dw)->addr_lsb));
> +	writel(upper_32_bits(addr), &(__dw_regs(dw)->addr_msb));
> +	pci_dbg(pdev, "xData: target address = 0x%.16llx\n", addr);
> +
> +	pci_dbg(pdev, "xData: wr_len=%zu, rd_len=%zu\n",
> +		dw->max_wr_len * 4, dw->max_rd_len * 4);
> +
> +	err = sysfs_create_file(&dev->kobj, &sysfs_write_attr.attr);
> +	if (err)
> +		return err;
> +
> +	err = sysfs_create_file(&dev->kobj, &sysfs_read_attr.attr);
> +	if (err)
> +		return err;
> +
> +	err = sysfs_create_file(&dev->kobj, &sysfs_stop_attr.attr);
> +	if (err)
> +		return err;

By manually creating sysfs files, you just raced with userspace and lost
horribly.

Please never do that, use an attribute group and have the driver core
automatically create/remove your files for you.

Big hint, if you ever find yourself calling sysfs_* in a driver, you are
doing something wrong.

thanks,

greg k-h
