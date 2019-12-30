Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A985912CC2E
	for <lists+dmaengine@lfdr.de>; Mon, 30 Dec 2019 04:39:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbfL3Djj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 29 Dec 2019 22:39:39 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:42696 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727081AbfL3Djj (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sun, 29 Dec 2019 22:39:39 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C73592ED2E51E9DDE1FC;
        Mon, 30 Dec 2019 11:39:37 +0800 (CST)
Received: from [127.0.0.1] (10.63.139.185) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Mon, 30 Dec 2019
 11:39:29 +0800
Subject: Re: [PATCH v3] dmaengine: hisilicon: Add Kunpeng DMA engine support
To:     kbuild test robot <lkp@intel.com>
References: <1577533684-152202-1-git-send-email-wangzhou1@hisilicon.com>
 <201912290029.kc8oo1h9%lkp@intel.com>
CC:     <kbuild-all@lists.01.org>, Dan Williams <dan.j.williams@intel.com>,
        "Vinod Koul" <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <linuxarm@huawei.com>, Zhenfa Qiu <qiuzhenfa@hisilicon.com>
From:   Zhou Wang <wangzhou1@hisilicon.com>
Message-ID: <5E097171.1090608@hisilicon.com>
Date:   Mon, 30 Dec 2019 11:39:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <201912290029.kc8oo1h9%lkp@intel.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.63.139.185]
X-CFilter-Loop: Reflected
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 2019/12/29 0:54, kbuild test robot wrote:
> Hi Zhou,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on slave-dma/next]
> [also build test ERROR on linus/master v5.5-rc3 next-20191220]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> 
> url:    https://github.com/0day-ci/linux/commits/Zhou-Wang/dmaengine-hisilicon-Add-Kunpeng-DMA-engine-support/20191228-195257
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/slave-dma.git next
> config: sh-allmodconfig (attached as .config)
> compiler: sh4-linux-gcc (GCC) 7.5.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.5.0 make.cross ARCH=sh 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All error/warnings (new ones prefixed by >>):
> 
>    drivers//dma/hisi_dma.c: In function 'hisi_dma_free_irq_vectors':
>>> drivers//dma/hisi_dma.c:132:2: error: implicit declaration of function 'pci_free_irq_vectors'; did you mean 'pci_alloc_irq_vectors'? [-Werror=implicit-function-declaration]
>      pci_free_irq_vectors(data);
>      ^~~~~~~~~~~~~~~~~~~~
>      pci_alloc_irq_vectors
>    drivers//dma/hisi_dma.c: At top level:
>>> drivers//dma/hisi_dma.c:593:1: warning: data definition has no type or storage class
>     module_pci_driver(hisi_dma_pci_driver);
>     ^~~~~~~~~~~~~~~~~
>>> drivers//dma/hisi_dma.c:593:1: error: type defaults to 'int' in declaration of 'module_pci_driver' [-Werror=implicit-int]
>>> drivers//dma/hisi_dma.c:593:1: warning: parameter names (without types) in function declaration
>    drivers//dma/hisi_dma.c:587:26: warning: 'hisi_dma_pci_driver' defined but not used [-Wunused-variable]
>     static struct pci_driver hisi_dma_pci_driver = {
>                              ^~~~~~~~~~~~~~~~~~~
>    cc1: some warnings being treated as errors
> 
> vim +132 drivers//dma/hisi_dma.c
> 
>    129	
>    130	static void hisi_dma_free_irq_vectors(void *data)
>    131	{
>  > 132		pci_free_irq_vectors(data);
>    133	}
>    134	
> 

Will add PCI_MSI dependency in Kconfig, like: depends on ARM64 || (COMPILE_TEST && PCI_MSI)

Thanks,
Zhou

> ---
> 0-DAY kernel test infrastructure                 Open Source Technology Center
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
> 

