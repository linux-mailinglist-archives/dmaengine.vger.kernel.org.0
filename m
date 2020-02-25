Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B91E16EB10
	for <lists+dmaengine@lfdr.de>; Tue, 25 Feb 2020 17:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730028AbgBYQOM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 25 Feb 2020 11:14:12 -0500
Received: from mga18.intel.com ([134.134.136.126]:21367 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728065AbgBYQOM (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 25 Feb 2020 11:14:12 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Feb 2020 08:14:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,484,1574150400"; 
   d="scan'208";a="438112379"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga006.fm.intel.com with ESMTP; 25 Feb 2020 08:14:07 -0800
Subject: Re: [PATCH] dmaengine: idxd: remove set but unused 'rc'
To:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
References: <20200225081459.4117512-1-vkoul@kernel.org>
From:   Dave Jiang <dave.jiang@intel.com>
Message-ID: <701657fb-bba5-2733-05ef-fa181d562223@intel.com>
Date:   Tue, 25 Feb 2020 09:14:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200225081459.4117512-1-vkoul@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 2/25/20 1:14 AM, Vinod Koul wrote:
> The driver assigns result of check_vma() to rc and never checks the
> result, so remove the assignment
> 
> drivers/dma/idxd/cdev.c: In function ‘idxd_cdev_mmap’:
> drivers/dma/idxd/cdev.c:136:6: warning: variable ‘rc’ set but not used [-Wunused-but-set-variable]
>    136 |  int rc;
>        |      ^~
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
> 
> Dave, if you want the result of the check_vma() to be checked, feel free to
> send the patch for that

Yes I will send a fix. Mistake from several code merges. Oops.

> 
>   drivers/dma/idxd/cdev.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
> index 8dfdbe37e381..82b19eed6561 100644
> --- a/drivers/dma/idxd/cdev.c
> +++ b/drivers/dma/idxd/cdev.c
> @@ -133,10 +133,9 @@ static int idxd_cdev_mmap(struct file *filp, struct vm_area_struct *vma)
>   	struct pci_dev *pdev = idxd->pdev;
>   	phys_addr_t base = pci_resource_start(pdev, IDXD_WQ_BAR);
>   	unsigned long pfn;
> -	int rc;
>   
>   	dev_dbg(&pdev->dev, "%s called\n", __func__);
> -	rc = check_vma(wq, vma, __func__);
> +	check_vma(wq, vma, __func__);
>   
>   	vma->vm_flags |= VM_DONTCOPY;
>   	pfn = (base + idxd_get_wq_portal_full_offset(wq->id,
> 
