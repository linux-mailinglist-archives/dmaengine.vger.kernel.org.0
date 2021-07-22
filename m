Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D33F53D2590
	for <lists+dmaengine@lfdr.de>; Thu, 22 Jul 2021 16:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbhGVNku (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 22 Jul 2021 09:40:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:42884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232228AbhGVNjH (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 22 Jul 2021 09:39:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2FC136100C;
        Thu, 22 Jul 2021 14:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626963567;
        bh=zJ3Zp5AAggyHtuPj8z/ta/IgeTLqyJcK5mtVEx526Q0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NH/3WHZejuDi6QFuAZ3CDOlsO7ym6vhQ+KGckYx4KyI3BhrWNob5JKnuegvMJZh2N
         44o1DlRiPI6HOTtzTmZDh3pqMor0m7HnO8ANSB4ADU9ogIqLVWDc1R29WNle0SrmHL
         mXI3X7zvU2FpPY9tmzocG2o/qpvMogauNNEKDKiU=
Date:   Thu, 22 Jul 2021 16:19:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sanjay R Mehta <sanmehta@amd.com>
Cc:     Sanjay R Mehta <Sanju.Mehta@amd.com>, vkoul@kernel.org,
        dan.j.williams@intel.com, Thomas.Lendacky@amd.com,
        Shyam-sundar.S-k@amd.com, Nehal-bakulchandra.Shah@amd.com,
        robh@kernel.org, mchehab+samsung@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v10 0/3] Add support for AMD PTDMA controller driver
Message-ID: <YPl+bY2z1BfkhQR9@kroah.com>
References: <1624207298-115928-1-git-send-email-Sanju.Mehta@amd.com>
 <5dd9b34f-3e12-6ca1-1d4d-ddc3f82e341f@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5dd9b34f-3e12-6ca1-1d4d-ddc3f82e341f@amd.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Jul 22, 2021 at 07:27:51PM +0530, Sanjay R Mehta wrote:
> 
> 
> On 6/20/2021 10:11 PM, Sanjay R Mehta wrote:
> > From: Sanjay R Mehta <sanju.mehta@amd.com>
> > 
> > This patch series add support for AMD PTDMA controller which
> > performs high bandwidth memory-to-memory and IO copy operation,
> > performs DMA transfer through queue based descriptor management.
> > 
> > AMD Processor has multiple ptdma device instances with each controller
> > having single queue. The driver also adds support for for multiple PTDMA
> > instances, each device will get an unique identifier and uniquely
> > named resources.
> > 
> > v10:
> > 	- modified ISR to return IR_HANDLED only in non-error condition.
> > 	- removed unnecessary prints, variables and made some cosmetic changes.
> > 	- removed pt_ordinal atomic variable and instead using dev_name()
> > 	  for device name.
> > 	- removed the cmdlist dependency and instead using vc.desc_issued list.
> > 	- freeing the desc and list which was missing in the pt_terminate_all()
> > 	  funtion.
> > 	- Added comment for marking PTDMA as DMA_PRIVATE.
> > 	- removed unused pt_debugfs_lock from debufs code.
> > 	- keeping same file permision for all the debug directoris.
> > 
> > v9:
> > 	- Modified the help message in Kconfig as per Randy's comment.
> > 	- reverted the split of code for "pt_handle_active_desc" as there
> > 	  was driver hang being observerd after few iterations.
> > 
> > v8:
> > 	- splitted the code into different functions, one to find active desc 
> > 	  and second to	complete and invoke callback.
> > 	- used FIELD_PREP & FIELD_GET instead of union struct bitfields.
> > 	- modified all style fixes as per the comments.
> > 
> > v7:
> > 	- Fixed module warnings reported ( by kernel test robot <lkp@intel.com> ).
> > 
> > v6:
> > 	- Removed debug artifacts and made the suggested cosmetic changes.
> > 	- implemented and used to_pt_chan and to_pt_desc inline functions.
> > 	- Removed src and dst address check as framework does this.
> > 	- Removed devm_kcalloc() usage and used devm_kzalloc() api.
> > 	- Using framework debugfs directory to store dma info.
> > 
> > v5:
> > 	- modified code to submit next tranction in ISR itself and removed the tasklet.
> > 	- implemented .device_synchronize API.
> > 	- converted debugfs code by using DEFINE_SHOW_ATTRIBUTE()
> > 	- using dbg_dev_root for debugfs root directory.
> > 	- removed dma_status from pt_dma_chan
> > 	- removed module parameter cmd_queue_lenght.
> > 	- removed global device list for multiple devics.
> > 	- removed code related to dynamic adding/deleting to device list
> > 	- removed pt_add_device and pt_del_device functions
> > 
> > v4:
> > 	- modified DMA channel and descriptor management using virt-dma layer
> > 	  instead of list based management.
> > 	- return only status of the cookie from pt_tx_status
> > 	- copyright year changed from 2019 to 2020
> > 	- removed dummy code for suspend & resume
> > 	- used bitmask and genmask
> > 
> > v3:
> >         - Fixed the sparse warnings.
> > 
> > v2:
> >         - Added controller description in cover letter
> >         - Removed "default m" from Kconfig
> >         - Replaced low_address() and high_address() functions with kernel
> >           API's lower_32_bits & upper_32_bits().
> >         - Removed the BH handler function pt_core_irq_bh() and instead
> >           handling transaction in irq handler itself.
> >         - Moved presetting of command queue registers into new function
> >           "init_cmdq_regs()"
> >         - Removed the kernel thread dependency to submit transaction.
> >         - Increased the hardware command queue size to 32 and adding it
> >           as a module parameter.
> >         - Removed backlog command queue handling mechanism.
> >         - Removed software command queue handling and instead submitting
> >           transaction command directly to
> >           hardware command queue.
> >         - Added tasklet structure variable in "struct pt_device".
> >           This is used to invoke pt_do_cmd_complete() upon receiving interrupt
> >           for command completion.
> >         - pt_core_perform_passthru() function parameters are modified and it is
> >           now used to submit command directly to hardware from dmaengine framew
> >         - Removed below structures, enums, macros and functions, as these value
> >           constants. Making command submission simple,
> >            - Removed "union pt_function"  and several macros like PT_VERSION,
> >              PT_BYTESWAP, PT_CMD_* etc..
> >            - enum pt_passthru_bitwise, enum pt_passthru_byteswap, enum pt_memty
> >              struct pt_dma_info, struct pt_data, struct pt_mem, struct pt_passt
> >              struct pt_op,
> > 
> > Links of the review comments for v10:
> > 1. https://lkml.org/lkml/2021/6/8/976
> > 2. https://lkml.org/lkml/2021/6/16/7
> > 3. https://lkml.org/lkml/2021/6/16/65
> > 4. https://lkml.org/lkml/2021/6/16/192
> > 5. https://lkml.org/lkml/2021/6/16/273
> > 6. https://lkml.org/lkml/2021/6/8/1698
> > 7. https://lkml.org/lkml/2021/6/16/8
> > 8. https://lkml.org/lkml/2021/6/9/808
> > 
> > Links of the review comments for v7:
> > 1. https://lkml.org/lkml/2020/11/18/351
> > 2. https://lkml.org/lkml/2020/11/18/384
> > 
> > Links of the review comments for v5:
> > 1. https://lkml.org/lkml/2020/7/3/154
> > 2. https://lkml.org/lkml/2020/8/25/431
> > 3. https://lkml.org/lkml/2020/7/3/177
> > 4. https://lkml.org/lkml/2020/7/3/186
> > 
> > Links of the review comments for v5:
> > 1. https://lkml.org/lkml/2020/5/4/42
> > 2. https://lkml.org/lkml/2020/5/4/45
> > 3. https://lkml.org/lkml/2020/5/4/38
> > 4. https://lkml.org/lkml/2020/5/26/70
> > 
> > Links of the review comments for v4:
> > 1. https://lkml.org/lkml/2020/1/24/12
> > 2. https://lkml.org/lkml/2020/1/24/17
> > 
> > Links of the review comments for v2:
> > 1https://lkml.org/lkml/2019/12/27/630
> > 2. https://lkml.org/lkml/2020/1/3/23
> > 3. https://lkml.org/lkml/2020/1/3/314
> > 4. https://lkml.org/lkml/2020/1/10/100
> > 
> > Links of the review comments for v1:
> > 1. https://lkml.org/lkml/2019/9/24/490
> > 2. https://lkml.org/lkml/2019/9/24/399
> > 3. https://lkml.org/lkml/2019/9/24/862
> > 4. https://lkml.org/lkml/2019/9/24/122
> > 
> > Sanjay R Mehta (3):
> >   dmaengine: ptdma: Initial driver for the AMD PTDMA
> >   dmaengine: ptdma: register PTDMA controller as a DMA resource
> >   dmaengine: ptdma: Add debugfs entries for PTDMA
> > 
> >  MAINTAINERS                         |   6 +
> >  drivers/dma/Kconfig                 |   2 +
> >  drivers/dma/Makefile                |   1 +
> >  drivers/dma/ptdma/Kconfig           |  13 ++
> >  drivers/dma/ptdma/Makefile          |  10 +
> >  drivers/dma/ptdma/ptdma-debugfs.c   | 110 ++++++++++
> >  drivers/dma/ptdma/ptdma-dev.c       | 327 ++++++++++++++++++++++++++++++
> >  drivers/dma/ptdma/ptdma-dmaengine.c | 389 ++++++++++++++++++++++++++++++++++++
> >  drivers/dma/ptdma/ptdma-pci.c       | 245 +++++++++++++++++++++++
> >  drivers/dma/ptdma/ptdma.h           | 334 +++++++++++++++++++++++++++++++
> >  10 files changed, 1437 insertions(+)
> >  create mode 100644 drivers/dma/ptdma/Kconfig
> >  create mode 100644 drivers/dma/ptdma/Makefile
> >  create mode 100644 drivers/dma/ptdma/ptdma-debugfs.c
> >  create mode 100644 drivers/dma/ptdma/ptdma-dev.c
> >  create mode 100644 drivers/dma/ptdma/ptdma-dmaengine.c
> >  create mode 100644 drivers/dma/ptdma/ptdma-pci.c
> >  create mode 100644 drivers/dma/ptdma/ptdma.h
> 
> Hi Vinod, Greg,
> 
> 
> I had re-sent this patch series as per your advice a month ago with all
> the review feedback's addressed.
> 
> Need your guidance and feedback to get this code reviewed and up-streamed.

That is up to the drivers/dma/ maintainer, which is Vinod, not me :)

thanks,

greg k-h
