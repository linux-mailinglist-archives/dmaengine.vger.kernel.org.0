Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C16E12B192
	for <lists+dmaengine@lfdr.de>; Fri, 27 Dec 2019 06:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbfL0F7A (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 27 Dec 2019 00:59:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:33022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbfL0F7A (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 27 Dec 2019 00:59:00 -0500
Received: from localhost (unknown [106.201.34.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58122206CB;
        Fri, 27 Dec 2019 05:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577426338;
        bh=TDtTVaAQPnyX7yiMWwA/XAmEioTba1QJBhA1RyV3AQ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HTL1JEGWAefaQoOyzScGUS8zs9gkduHf2idO1nhx4Qmx7KYj6WJO0d28dkm+oKcW5
         Vfffis2/nODQWIvHKT5kHnpYGuVyX8gzC2b7V/qcBdQMZGR7ENdJkxhPFba4MtTmne
         jBVwJHm45ecEUVaoi0wxQ79y0je2a65JwiA4Zv3A=
Date:   Fri, 27 Dec 2019 11:28:52 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        dan.j.williams@intel.com, tony.luck@intel.com, jing.lin@intel.com,
        ashok.raj@intel.com, sanjay.k.kumar@intel.com, megha.dey@intel.com,
        jacob.jun.pan@intel.com, yi.l.liu@intel.com, axboe@kernel.dk,
        akpm@linux-foundation.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, fenghua.yu@intel.com, hpa@zytor.com
Subject: Re: [PATCH RFC v3 13/14] dmaengine: idxd: add char driver to expose
 submission portal to userland
Message-ID: <20191227055852.GE3006@vkoul-mobl>
References: <157662541786.51652.7666763291600764054.stgit@djiang5-desk3.ch.intel.com>
 <157662565769.51652.16236917705023398061.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157662565769.51652.16236917705023398061.stgit@djiang5-desk3.ch.intel.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 17-12-19, 16:34, Dave Jiang wrote:
> Create a char device region that will allow acquisition of user portals in
> order to allow applications to submit DMA operations. A char device will be
> created per work queue that gets exposed. The workqueue type "user"
> is used to mark a work queue for user char device. For example if the
> workqueue 0 of DSA device 0 is marked for char device, then a device node
> of /dev/dsa/wq0.0 will be created.

do we really want to create a device specific interface..? why not move
it to dmaengine core and create a dmaengine device for userland to
submit dma operations?

> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/dma/idxd/Makefile |    2 
>  drivers/dma/idxd/cdev.c   |  302 +++++++++++++++++++++++++++++++++++++++++++++
>  drivers/dma/idxd/device.c |    2 
>  drivers/dma/idxd/idxd.h   |   38 ++++++
>  drivers/dma/idxd/init.c   |   10 +
>  drivers/dma/idxd/irq.c    |   18 +++
>  drivers/dma/idxd/submit.c |    4 -
>  drivers/dma/idxd/sysfs.c  |   52 +++++++-
>  8 files changed, 423 insertions(+), 5 deletions(-)
>  create mode 100644 drivers/dma/idxd/cdev.c
> 
> diff --git a/drivers/dma/idxd/Makefile b/drivers/dma/idxd/Makefile
> index a036ba0e77d2..8978b898d777 100644
> --- a/drivers/dma/idxd/Makefile
> +++ b/drivers/dma/idxd/Makefile
> @@ -1,2 +1,2 @@
>  obj-$(CONFIG_INTEL_IDXD) += idxd.o
> -idxd-y := init.o irq.o device.o sysfs.o submit.o dma.o
> +idxd-y := init.o irq.o device.o sysfs.o submit.o dma.o cdev.o
> diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
> new file mode 100644
> index 000000000000..1d7347825b95
> --- /dev/null
> +++ b/drivers/dma/idxd/cdev.c
> @@ -0,0 +1,302 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright(c) 2019 Intel Corporation. All rights rsvd. */
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/device.h>
> +#include <linux/sched/task.h>
> +#include <linux/intel-svm.h>
> +#include <linux/io-64-nonatomic-lo-hi.h>
> +#include <linux/cdev.h>
> +#include <linux/fs.h>
> +#include <linux/poll.h>
> +#include <uapi/linux/idxd.h>
> +#include "registers.h"
> +#include "idxd.h"
> +
> +struct idxd_cdev_context {
> +	const char *name;
> +	dev_t devt;
> +	struct ida minor_ida;
> +};
> +
> +/*
> + * ictx is an array based off of accelerator types. enum idxd_type
> + * is used as index
> + */
> +static struct idxd_cdev_context ictx[IDXD_TYPE_MAX] = {
> +	{ .name = "dsa" },
> +};
> +
> +struct idxd_user_context {
> +	struct idxd_wq *wq;
> +	struct task_struct *task;
> +	unsigned int flags;
> +};
> +
> +enum idxd_cdev_cleanup {
> +	CDEV_NORMAL = 0,
> +	CDEV_FAILED,
> +};
> +
> +static void idxd_cdev_dev_release(struct device *dev)
> +{
> +	dev_dbg(dev, "releasing cdev device\n");
> +	kfree(dev);
> +}
> +
> +static struct device_type idxd_cdev_device_type = {
> +	.name = "idxd_cdev",
> +	.release = idxd_cdev_dev_release,
> +};
> +
> +static inline struct idxd_cdev *inode_idxd_cdev(struct inode *inode)
> +{
> +	struct cdev *cdev = inode->i_cdev;
> +
> +	return container_of(cdev, struct idxd_cdev, cdev);
> +}
> +
> +static inline struct idxd_wq *idxd_cdev_wq(struct idxd_cdev *idxd_cdev)
> +{
> +	return container_of(idxd_cdev, struct idxd_wq, idxd_cdev);
> +}
> +
> +static inline struct idxd_wq *inode_wq(struct inode *inode)
> +{
> +	return idxd_cdev_wq(inode_idxd_cdev(inode));
> +}
> +
> +static int idxd_cdev_open(struct inode *inode, struct file *filp)
> +{
> +	struct idxd_user_context *ctx;
> +	struct idxd_device *idxd;
> +	struct idxd_wq *wq;
> +	struct device *dev;
> +	struct idxd_cdev *idxd_cdev;
> +
> +	wq = inode_wq(inode);
> +	idxd = wq->idxd;
> +	dev = &idxd->pdev->dev;
> +	idxd_cdev = &wq->idxd_cdev;
> +
> +	dev_dbg(dev, "%s called\n", __func__);
> +
> +	if (idxd_wq_refcount(wq) > 1 && wq_dedicated(wq))
> +		return -EBUSY;
> +
> +	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
> +	if (!ctx)
> +		return -ENOMEM;
> +
> +	ctx->wq = wq;
> +	filp->private_data = ctx;
> +	idxd_wq_get(wq);
> +	return 0;
> +}
> +
> +static int idxd_cdev_release(struct inode *node, struct file *filep)
> +{
> +	struct idxd_user_context *ctx = filep->private_data;
> +	struct idxd_wq *wq = ctx->wq;
> +	struct idxd_device *idxd = wq->idxd;
> +	struct device *dev = &idxd->pdev->dev;
> +
> +	dev_dbg(dev, "%s called\n", __func__);
> +	filep->private_data = NULL;
> +
> +	kfree(ctx);
> +	idxd_wq_put(wq);
> +	return 0;
> +}
> +
> +static int check_vma(struct idxd_wq *wq, struct vm_area_struct *vma,
> +		     const char *func)
> +{
> +	struct device *dev = &wq->idxd->pdev->dev;
> +
> +	if ((vma->vm_end - vma->vm_start) > PAGE_SIZE) {
> +		dev_info_ratelimited(dev,
> +				     "%s: %s: mapping too large: %lu\n",
> +				     current->comm, func,
> +				     vma->vm_end - vma->vm_start);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int idxd_cdev_mmap(struct file *filp, struct vm_area_struct *vma)
> +{
> +	struct idxd_user_context *ctx = filp->private_data;
> +	struct idxd_wq *wq = ctx->wq;
> +	struct idxd_device *idxd = wq->idxd;
> +	struct pci_dev *pdev = idxd->pdev;
> +	phys_addr_t base = pci_resource_start(pdev, IDXD_WQ_BAR);
> +	unsigned long pfn;
> +	int rc;
> +
> +	dev_dbg(&pdev->dev, "%s called\n", __func__);
> +	rc = check_vma(wq, vma, __func__);
> +
> +	vma->vm_flags |= VM_DONTCOPY;
> +	pfn = (base + idxd_get_wq_portal_full_offset(wq->id,
> +				IDXD_PORTAL_LIMITED)) >> PAGE_SHIFT;
> +	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> +	vma->vm_private_data = ctx;
> +
> +	return io_remap_pfn_range(vma, vma->vm_start, pfn, PAGE_SIZE,
> +			vma->vm_page_prot);
> +}
> +
> +static __poll_t idxd_cdev_poll(struct file *filp,
> +			       struct poll_table_struct *wait)
> +{
> +	struct idxd_user_context *ctx = filp->private_data;
> +	struct idxd_wq *wq = ctx->wq;
> +	struct idxd_device *idxd = wq->idxd;
> +	struct idxd_cdev *idxd_cdev = &wq->idxd_cdev;
> +	unsigned long flags;
> +	__poll_t out = 0;
> +
> +	poll_wait(filp, &idxd_cdev->err_queue, wait);
> +	spin_lock_irqsave(&idxd->dev_lock, flags);
> +	if (idxd->sw_err.valid)
> +		out = EPOLLIN | EPOLLRDNORM;
> +	spin_unlock_irqrestore(&idxd->dev_lock, flags);
> +
> +	return out;
> +}
> +
> +static const struct file_operations idxd_cdev_fops = {
> +	.owner = THIS_MODULE,
> +	.open = idxd_cdev_open,
> +	.release = idxd_cdev_release,
> +	.mmap = idxd_cdev_mmap,
> +	.poll = idxd_cdev_poll,
> +};
> +
> +int idxd_cdev_get_major(struct idxd_device *idxd)
> +{
> +	return MAJOR(ictx[idxd->type].devt);
> +}
> +
> +static int idxd_wq_cdev_dev_setup(struct idxd_wq *wq)
> +{
> +	struct idxd_device *idxd = wq->idxd;
> +	struct idxd_cdev *idxd_cdev = &wq->idxd_cdev;
> +	struct idxd_cdev_context *cdev_ctx;
> +	struct device *dev;
> +	int minor, rc;
> +
> +	idxd_cdev->dev = kzalloc(sizeof(*idxd_cdev->dev), GFP_KERNEL);
> +	if (!idxd_cdev->dev)
> +		return -ENOMEM;
> +
> +	dev = idxd_cdev->dev;
> +	dev->parent = &idxd->pdev->dev;
> +	dev_set_name(dev, "%s/wq%u.%u", idxd_get_dev_name(idxd),
> +		     idxd->id, wq->id);
> +	dev->bus = idxd_get_bus_type(idxd);
> +
> +	cdev_ctx = &ictx[wq->idxd->type];
> +	minor = ida_simple_get(&cdev_ctx->minor_ida, 0, MINORMASK, GFP_KERNEL);
> +	if (minor < 0) {
> +		rc = minor;
> +		goto ida_err;
> +	}
> +
> +	dev->devt = MKDEV(MAJOR(cdev_ctx->devt), minor);
> +	dev->type = &idxd_cdev_device_type;
> +	rc = device_register(dev);
> +	if (rc < 0) {
> +		dev_err(&idxd->pdev->dev, "device register failed\n");
> +		put_device(dev);
> +		goto dev_reg_err;
> +	}
> +	idxd_cdev->minor = minor;
> +
> +	return 0;
> +
> + dev_reg_err:
> +	ida_simple_remove(&cdev_ctx->minor_ida, MINOR(dev->devt));
> + ida_err:
> +	kfree(dev);
> +	idxd_cdev->dev = NULL;
> +	return rc;
> +}
> +
> +static void idxd_wq_cdev_cleanup(struct idxd_wq *wq,
> +				 enum idxd_cdev_cleanup cdev_state)
> +{
> +	struct idxd_cdev *idxd_cdev = &wq->idxd_cdev;
> +	struct idxd_cdev_context *cdev_ctx;
> +
> +	cdev_ctx = &ictx[wq->idxd->type];
> +	if (cdev_state == CDEV_NORMAL)
> +		cdev_del(&idxd_cdev->cdev);
> +	device_unregister(idxd_cdev->dev);
> +	/*
> +	 * The device_type->release() will be called on the device and free
> +	 * the allocated struct device. We can just forget it.
> +	 */
> +	ida_simple_remove(&cdev_ctx->minor_ida, idxd_cdev->minor);
> +	idxd_cdev->dev = NULL;
> +	idxd_cdev->minor = -1;
> +}
> +
> +int idxd_wq_add_cdev(struct idxd_wq *wq)
> +{
> +	struct idxd_cdev *idxd_cdev = &wq->idxd_cdev;
> +	struct cdev *cdev = &idxd_cdev->cdev;
> +	struct device *dev;
> +	int rc;
> +
> +	rc = idxd_wq_cdev_dev_setup(wq);
> +	if (rc < 0)
> +		return rc;
> +
> +	dev = idxd_cdev->dev;
> +	cdev_init(cdev, &idxd_cdev_fops);
> +	cdev_set_parent(cdev, &dev->kobj);
> +	rc = cdev_add(cdev, dev->devt, 1);
> +	if (rc) {
> +		dev_dbg(&wq->idxd->pdev->dev, "cdev_add failed: %d\n", rc);
> +		idxd_wq_cdev_cleanup(wq, CDEV_FAILED);
> +		return rc;
> +	}
> +
> +	init_waitqueue_head(&idxd_cdev->err_queue);
> +	return 0;
> +}
> +
> +void idxd_wq_del_cdev(struct idxd_wq *wq)
> +{
> +	idxd_wq_cdev_cleanup(wq, CDEV_NORMAL);
> +}
> +
> +int idxd_cdev_register(void)
> +{
> +	int rc, i;
> +
> +	for (i = 0; i < IDXD_TYPE_MAX; i++) {
> +		ida_init(&ictx[i].minor_ida);
> +		rc = alloc_chrdev_region(&ictx[i].devt, 0, MINORMASK,
> +					 ictx[i].name);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	return 0;
> +}
> +
> +void idxd_cdev_remove(void)
> +{
> +	int i;
> +
> +	for (i = 0; i < IDXD_TYPE_MAX; i++) {
> +		unregister_chrdev_region(ictx[i].devt, MINORMASK);
> +		ida_destroy(&ictx[i].minor_ida);
> +	}
> +}
> diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
> index 49638d3a2151..fd33e2985e95 100644
> --- a/drivers/dma/idxd/device.c
> +++ b/drivers/dma/idxd/device.c
> @@ -545,7 +545,7 @@ static int idxd_wq_config_write(struct idxd_wq *wq)
>  	wq->wqcfg.wq_thresh = wq->threshold;
>  
>  	/* byte 8-11 */
> -	wq->wqcfg.priv = 1; /* kernel, therefore priv */
> +	wq->wqcfg.priv = !!(wq->type == IDXD_WQT_KERNEL);
>  	wq->wqcfg.mode = 1;
>  
>  	wq->wqcfg.priority = wq->priority;
> diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
> index fc1634e689cf..23bf12ad0af4 100644
> --- a/drivers/dma/idxd/idxd.h
> +++ b/drivers/dma/idxd/idxd.h
> @@ -7,6 +7,7 @@
>  #include <linux/dmaengine.h>
>  #include <linux/percpu-rwsem.h>
>  #include <linux/wait.h>
> +#include <linux/cdev.h>
>  #include "registers.h"
>  
>  #define IDXD_DRIVER_VERSION	"1.00"
> @@ -63,6 +64,14 @@ enum idxd_wq_flag {
>  enum idxd_wq_type {
>  	IDXD_WQT_NONE = 0,
>  	IDXD_WQT_KERNEL,
> +	IDXD_WQT_USER,
> +};
> +
> +struct idxd_cdev {
> +	struct cdev cdev;
> +	struct device *dev;
> +	int minor;
> +	struct wait_queue_head err_queue;
>  };
>  
>  #define IDXD_ALLOCATED_BATCH_SIZE	128U
> @@ -72,6 +81,7 @@ enum idxd_wq_type {
>  struct idxd_wq {
>  	void __iomem *dportal;
>  	struct device conf_dev;
> +	struct idxd_cdev idxd_cdev;
>  	struct idxd_device *idxd;
>  	int id;
>  	enum idxd_wq_type type;
> @@ -139,6 +149,7 @@ struct idxd_device {
>  	enum idxd_device_state state;
>  	unsigned long flags;
>  	int id;
> +	int major;
>  
>  	struct pci_dev *pdev;
>  	void __iomem *reg_base;
> @@ -192,11 +203,29 @@ struct idxd_desc {
>  #define confdev_to_idxd(dev) container_of(dev, struct idxd_device, conf_dev)
>  #define confdev_to_wq(dev) container_of(dev, struct idxd_wq, conf_dev)
>  
> +extern struct bus_type dsa_bus_type;
> +
>  static inline bool wq_dedicated(struct idxd_wq *wq)
>  {
>  	return test_bit(WQ_FLAG_DEDICATED, &wq->flags);
>  }
>  
> +enum idxd_portal_prot {
> +	IDXD_PORTAL_UNLIMITED = 0,
> +	IDXD_PORTAL_LIMITED,
> +};
> +
> +static inline int idxd_get_wq_portal_offset(enum idxd_portal_prot prot)
> +{
> +	return prot * 0x1000;
> +}
> +
> +static inline int idxd_get_wq_portal_full_offset(int wq_id,
> +						 enum idxd_portal_prot prot)
> +{
> +	return ((wq_id * 4) << PAGE_SHIFT) + idxd_get_wq_portal_offset(prot);
> +}
> +
>  static inline void idxd_set_type(struct idxd_device *idxd)
>  {
>  	struct pci_dev *pdev = idxd->pdev;
> @@ -229,6 +258,7 @@ int idxd_setup_sysfs(struct idxd_device *idxd);
>  void idxd_cleanup_sysfs(struct idxd_device *idxd);
>  int idxd_register_driver(void);
>  void idxd_unregister_driver(void);
> +struct bus_type *idxd_get_bus_type(struct idxd_device *idxd);
>  
>  /* device interrupt control */
>  irqreturn_t idxd_irq_handler(int vec, void *data);
> @@ -267,4 +297,12 @@ void idxd_unregister_dma_device(struct idxd_device *idxd);
>  int idxd_register_dma_channel(struct idxd_wq *wq);
>  void idxd_unregister_dma_channel(struct idxd_wq *wq);
>  void idxd_parse_completion_status(u8 status, enum dmaengine_tx_result *res);
> +
> +/* cdev */
> +int idxd_cdev_register(void);
> +void idxd_cdev_remove(void);
> +int idxd_cdev_get_major(struct idxd_device *idxd);
> +int idxd_wq_add_cdev(struct idxd_wq *wq);
> +void idxd_wq_del_cdev(struct idxd_wq *wq);
> +
>  #endif
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index b2e887508078..b247ef57f5c1 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -188,6 +188,7 @@ static int idxd_setup_internals(struct idxd_device *idxd)
>  		mutex_init(&wq->wq_lock);
>  		atomic_set(&wq->dq_count, 0);
>  		init_waitqueue_head(&wq->submit_waitq);
> +		wq->idxd_cdev.minor = -1;
>  		rc = percpu_init_rwsem(&wq->submit_lock);
>  		if (rc < 0) {
>  			idxd_wqs_free_lock(idxd);
> @@ -321,6 +322,8 @@ static int idxd_probe(struct idxd_device *idxd)
>  		goto err_idr_fail;
>  	}
>  
> +	idxd->major = idxd_cdev_get_major(idxd);
> +
>  	dev_dbg(dev, "IDXD device %d probed successfully\n", idxd->id);
>  	return 0;
>  
> @@ -519,6 +522,10 @@ static int __init idxd_init_module(void)
>  	if (err < 0)
>  		goto err_idxd_driver_register;
>  
> +	err = idxd_cdev_register();
> +	if (err)
> +		goto err_cdev_register;
> +
>  	err = pci_register_driver(&idxd_pci_driver);
>  	if (err)
>  		goto err_pci_register;
> @@ -526,6 +533,8 @@ static int __init idxd_init_module(void)
>  	return 0;
>  
>  err_pci_register:
> +	idxd_cdev_remove();
> +err_cdev_register:
>  	idxd_unregister_driver();
>  err_idxd_driver_register:
>  	idxd_unregister_bus_type();
> @@ -536,6 +545,7 @@ module_init(idxd_init_module);
>  static void __exit idxd_exit_module(void)
>  {
>  	pci_unregister_driver(&idxd_pci_driver);
> +	idxd_cdev_remove();
>  	idxd_unregister_bus_type();
>  }
>  module_exit(idxd_exit_module);
> diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
> index b4adeb2817d1..442f21eeb0fb 100644
> --- a/drivers/dma/idxd/irq.c
> +++ b/drivers/dma/idxd/irq.c
> @@ -89,6 +89,24 @@ irqreturn_t idxd_misc_thread(int vec, void *data)
>  			idxd->sw_err.bits[i] = ioread64(idxd->reg_base +
>  					IDXD_SWERR_OFFSET + i * sizeof(u64));
>  		iowrite64(IDXD_SWERR_ACK, idxd->reg_base + IDXD_SWERR_OFFSET);
> +
> +		if (idxd->sw_err.valid && idxd->sw_err.wq_idx_valid) {
> +			int id = idxd->sw_err.wq_idx;
> +			struct idxd_wq *wq = &idxd->wqs[id];
> +
> +			if (wq->type == IDXD_WQT_USER)
> +				wake_up_interruptible(&wq->idxd_cdev.err_queue);
> +		} else {
> +			int i;
> +
> +			for (i = 0; i < idxd->max_wqs; i++) {
> +				struct idxd_wq *wq = &idxd->wqs[i];
> +
> +				if (wq->type == IDXD_WQT_USER)
> +					wake_up_interruptible(&wq->idxd_cdev.err_queue);
> +			}
> +		}
> +
>  		spin_unlock_bh(&idxd->dev_lock);
>  		val |= IDXD_INTC_ERR;
>  
> diff --git a/drivers/dma/idxd/submit.c b/drivers/dma/idxd/submit.c
> index f7baa1bbb0c7..0e6dea34edc9 100644
> --- a/drivers/dma/idxd/submit.c
> +++ b/drivers/dma/idxd/submit.c
> @@ -71,17 +71,19 @@ static int idxd_submit_desc(struct idxd_wq *wq, struct idxd_desc *desc,
>  {
>  	struct idxd_device *idxd = wq->idxd;
>  	int vec = desc->hw->int_handle;
> +	void __iomem *portal;
>  
>  	if (idxd->state != IDXD_DEV_ENABLED)
>  		return -EIO;
>  
> +	portal = wq->dportal + idxd_get_wq_portal_offset(IDXD_PORTAL_UNLIMITED);
>  	/*
>  	 * The wmb() flushes writes to coherent DMA data before possibly
>  	 * triggering a DMA read. The wmb() is necessary even on UP because
>  	 * the recipient is a device.
>  	 */
>  	wmb();
> -	iosubmit_cmds512(wq->dportal, desc->hw, 1);
> +	iosubmit_cmds512(portal, desc->hw, 1);
>  
>  	/*
>  	 * Pending the descriptor to the lockless list for the irq_entry
> diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
> index bcbd6020c8ee..4d0480ec97f7 100644
> --- a/drivers/dma/idxd/sysfs.c
> +++ b/drivers/dma/idxd/sysfs.c
> @@ -13,6 +13,7 @@
>  static char *idxd_wq_type_names[] = {
>  	[IDXD_WQT_NONE]		= "none",
>  	[IDXD_WQT_KERNEL]	= "kernel",
> +	[IDXD_WQT_USER]		= "user",
>  };
>  
>  static void idxd_conf_device_release(struct device *dev)
> @@ -63,6 +64,11 @@ static inline bool is_idxd_wq_dmaengine(struct idxd_wq *wq)
>  	return false;
>  }
>  
> +static inline bool is_idxd_wq_cdev(struct idxd_wq *wq)
> +{
> +	return wq->type == IDXD_WQT_USER ? true : false;
> +}
> +
>  static int idxd_config_bus_match(struct device *dev,
>  				 struct device_driver *drv)
>  {
> @@ -109,6 +115,9 @@ static int idxd_config_bus_probe(struct device *dev)
>  			return -EBUSY;
>  		}
>  
> +		if (!try_module_get(THIS_MODULE))
> +			return -ENXIO;
> +
>  		spin_lock_irqsave(&idxd->dev_lock, flags);
>  
>  		/* Perform IDXD configuration and enabling */
> @@ -216,6 +225,13 @@ static int idxd_config_bus_probe(struct device *dev)
>  				mutex_unlock(&wq->wq_lock);
>  				return rc;
>  			}
> +		} else if (is_idxd_wq_cdev(wq)) {
> +			rc = idxd_wq_add_cdev(wq);
> +			if (rc < 0) {
> +				dev_dbg(dev, "Cdev creation failed\n");
> +				mutex_unlock(&wq->wq_lock);
> +				return rc;
> +			}
>  		}
>  
>  		mutex_unlock(&wq->wq_lock);
> @@ -241,6 +257,8 @@ static void disable_wq(struct idxd_wq *wq)
>  
>  	if (is_idxd_wq_dmaengine(wq))
>  		idxd_unregister_dma_channel(wq);
> +	else if (is_idxd_wq_cdev(wq))
> +		idxd_wq_del_cdev(wq);
>  
>  	if (idxd_wq_refcount(wq))
>  		dev_warn(dev, "Clients has claim on wq %d: %d\n",
> @@ -295,10 +313,12 @@ static int idxd_config_bus_remove(struct device *dev)
>  		spin_lock_irqsave(&idxd->dev_lock, flags);
>  		rc = idxd_device_disable(idxd);
>  		spin_unlock_irqrestore(&idxd->dev_lock, flags);
> +		module_put(THIS_MODULE);
>  		if (rc < 0)
>  			dev_warn(dev, "Device disable failed\n");
>  		else
>  			dev_info(dev, "Device %s disabled\n", dev_name(dev));
> +
>  	}
>  
>  	return 0;
> @@ -309,7 +329,7 @@ static void idxd_config_bus_shutdown(struct device *dev)
>  	dev_dbg(dev, "%s called\n", __func__);
>  }
>  
> -static struct bus_type dsa_bus_type = {
> +struct bus_type dsa_bus_type = {
>  	.name = "dsa",
>  	.match = idxd_config_bus_match,
>  	.probe = idxd_config_bus_probe,
> @@ -334,7 +354,7 @@ static struct idxd_device_driver *idxd_drvs[] = {
>  	&dsa_drv
>  };
>  
> -static struct bus_type *idxd_get_bus_type(struct idxd_device *idxd)
> +struct bus_type *idxd_get_bus_type(struct idxd_device *idxd)
>  {
>  	return idxd_bus_types[idxd->type];
>  }
> @@ -956,6 +976,9 @@ static ssize_t wq_type_show(struct device *dev,
>  	case IDXD_WQT_KERNEL:
>  		return sprintf(buf, "%s\n",
>  			       idxd_wq_type_names[IDXD_WQT_KERNEL]);
> +	case IDXD_WQT_USER:
> +		return sprintf(buf, "%s\n",
> +			       idxd_wq_type_names[IDXD_WQT_USER]);
>  	case IDXD_WQT_NONE:
>  	default:
>  		return sprintf(buf, "%s\n",
> @@ -978,6 +1001,8 @@ static ssize_t wq_type_store(struct device *dev,
>  	old_type = wq->type;
>  	if (sysfs_streq(buf, idxd_wq_type_names[IDXD_WQT_KERNEL]))
>  		wq->type = IDXD_WQT_KERNEL;
> +	else if (sysfs_streq(buf, idxd_wq_type_names[IDXD_WQT_USER]))
> +		wq->type = IDXD_WQT_USER;
>  	else
>  		wq->type = IDXD_WQT_NONE;
>  
> @@ -1020,6 +1045,17 @@ static ssize_t wq_name_store(struct device *dev,
>  static struct device_attribute dev_attr_wq_name =
>  		__ATTR(name, 0644, wq_name_show, wq_name_store);
>  
> +static ssize_t wq_cdev_minor_show(struct device *dev,
> +				  struct device_attribute *attr, char *buf)
> +{
> +	struct idxd_wq *wq = container_of(dev, struct idxd_wq, conf_dev);
> +
> +	return sprintf(buf, "%d\n", wq->idxd_cdev.minor);
> +}
> +
> +static struct device_attribute dev_attr_wq_cdev_minor =
> +		__ATTR(cdev_minor, 0444, wq_cdev_minor_show, NULL);
> +
>  static struct attribute *idxd_wq_attributes[] = {
>  	&dev_attr_wq_clients.attr,
>  	&dev_attr_wq_state.attr,
> @@ -1029,6 +1065,7 @@ static struct attribute *idxd_wq_attributes[] = {
>  	&dev_attr_wq_priority.attr,
>  	&dev_attr_wq_type.attr,
>  	&dev_attr_wq_name.attr,
> +	&dev_attr_wq_cdev_minor.attr,
>  	NULL,
>  };
>  
> @@ -1242,6 +1279,16 @@ static ssize_t token_limit_store(struct device *dev,
>  }
>  static DEVICE_ATTR_RW(token_limit);
>  
> +static ssize_t cdev_major_show(struct device *dev,
> +			       struct device_attribute *attr, char *buf)
> +{
> +	struct idxd_device *idxd =
> +		container_of(dev, struct idxd_device, conf_dev);
> +
> +	return sprintf(buf, "%u\n", idxd->major);
> +}
> +static DEVICE_ATTR_RO(cdev_major);
> +
>  static struct attribute *idxd_device_attributes[] = {
>  	&dev_attr_max_groups.attr,
>  	&dev_attr_max_work_queues.attr,
> @@ -1257,6 +1304,7 @@ static struct attribute *idxd_device_attributes[] = {
>  	&dev_attr_errors.attr,
>  	&dev_attr_max_tokens.attr,
>  	&dev_attr_token_limit.attr,
> +	&dev_attr_cdev_major.attr,
>  	NULL,
>  };
>  

-- 
~Vinod
