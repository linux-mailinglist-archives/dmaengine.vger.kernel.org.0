Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5108E1943FA
	for <lists+dmaengine@lfdr.de>; Thu, 26 Mar 2020 17:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbgCZQGD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 26 Mar 2020 12:06:03 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40144 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgCZQGD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 26 Mar 2020 12:06:03 -0400
Received: by mail-qk1-f193.google.com with SMTP id l25so7124986qki.7;
        Thu, 26 Mar 2020 09:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EOQR43k/SYYoHg5rufoJ36PPPd7ND71XWjJAxPkqHGo=;
        b=qjboFr0PlnmfNyb5hR1EBo/k2d05EyGBFwBoOAuoT6iWA75I4jLUC0rRFI5bxdxbFc
         sKBSbVPfIt5ZlQ67ssS9cnPgAGbUM+cmqdjd/9Dec4EswkwnMaQ1SuwhwhwFkB9iv0NV
         Lx+qiG4/qlxjDlIB4N5PqZyg8aBu147lDy6K3lUgyV4j5AX4p6lnvIHq4uN6TFU8rZ8I
         4x17orm4XufbEHYMBzmP5PLknp3exNPCfn09WT1EHpUE5/Mc9vkhODJ/4gLH/HYfqzoK
         G2S6DbOCC9gAkXJpDKCCzMj9yClsEj0p1BbEgp4QgZG8KNwKEgIhlv8Ey4uZlgzQtxK0
         fwhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EOQR43k/SYYoHg5rufoJ36PPPd7ND71XWjJAxPkqHGo=;
        b=OqJgdMAvMGP6V62HEODA0KCIRKBbFPADbwKjR/aUzse1aJ/lUoUC5QY6B99fV0lYWk
         iYWRnxknz2nEX7rnA64NR23xCqiSHlUFgMfxIHn4cKE2i3osEBqoJ0Ydl50eqTfHS+oj
         cNyGUfTPMyio4Bux6euKwAs3TjDU8KrZrmdcpZZEH/1AeUWguuJoUrMyCdCeFqEVmSYT
         XWRjem5pNnzizrny4sPUIQdUSK5EezoEWZP013/9g3ev8+IUrSSWowZHvHETK1zhuCK7
         UCcF6599672Jc1y2E8CFQO9je3kqZCWKgQbAv3L+bZtPK+sT8e0AH9kunZGvN53JrYIq
         ezNw==
X-Gm-Message-State: ANhLgQ1pH3R7oLAGKrVhfKgTW/Fi+oXbItIUvmnsMPL1BJHy8gu8molY
        riKes9cGp3ixB7hZtKRjgX0/stSlzgypY1LlO0Q=
X-Google-Smtp-Source: ADFU+vtKRUt3UCw7cgfrgdwc9jVo9pwgXXlBmeg/WQfzxfEf6oF11aHjEVYfu0TTUxXrPmW+g159yufEf6E/CgfUD20=
X-Received: by 2002:a37:4fd0:: with SMTP id d199mr8766149qkb.121.1585238762078;
 Thu, 26 Mar 2020 09:06:02 -0700 (PDT)
MIME-Version: 1.0
References: <1579597494-60348-1-git-send-email-Sanju.Mehta@amd.com>
In-Reply-To: <1579597494-60348-1-git-send-email-Sanju.Mehta@amd.com>
From:   Vitaly Mayatskih <v.mayatskih@gmail.com>
Date:   Thu, 26 Mar 2020 12:05:11 -0400
Message-ID: <CAGF4SLg1ogj4O8Lafoby83+gjqtT0nBMd8MBZDJBQY=6UB0zJQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Add AMD PassThru DMA Engine driver
To:     Sanjay R Mehta <Sanju.Mehta@amd.com>
Cc:     vkoul@kernel.org, gregkh@linuxfoundation.org,
        dan.j.williams@intel.com, Thomas.Lendacky@amd.com,
        Shyam-sundar.S-k@amd.com, Nehal-bakulchandra.Shah@amd.com,
        robh@kernel.org, mchehab+samsung@kernel.org, davem@davemloft.net,
        Jonathan.Cameron@huawei.com, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

dmatest measures around 30 MB/s for one ptdma channel in EPYC 7302p
and 11 GB/s for ioatdma channel in Xeon Gold 6248. Is it a driver
limitation?

I run dmatest as modprobe dmatest timeout=10000 transfer_size=512
test_buf_size=1048576 threads_per_chan=1 iterations=1000 run=1 wait=1


On Tue, Jan 21, 2020 at 4:06 AM Sanjay R Mehta <Sanju.Mehta@amd.com> wrote:
>
> From: Sanjay R Mehta <sanju.mehta@amd.com>
>
> This patch series adds support for AMD PassThru DMA Engine which
> performs high bandwidth memory-to-memory and IO copy operation and
> performs DMA transfer through queue based descriptor management.
>
> AMD Processor has multiple ptdma device instances and each engine has
> single queue. The driver also adds support for for multiple PTDMA
> instances, each device will get an unique identifier and uniquely
> named resources.
>
> v3:
>         - Fixed the sparse warnings.
>
> v2:
>         - Added controller description in cover letter
>         - Removed "default m" from Kconfig
>         - Replaced low_address() and high_address() functions with kernel
>           API's lower_32_bits & upper_32_bits().
>         - Removed the BH handler function pt_core_irq_bh() and instead
>           handling transaction in irq handler itself.
>         - Moved presetting of command queue registers into new function
>           "init_cmdq_regs()"
>         - Removed the kernel thread dependency to submit transaction.
>         - Increased the hardware command queue size to 32 and adding it
>           as a module parameter.
>         - Removed backlog command queue handling mechanism.
>         - Removed software command queue handling and instead submitting
>           transaction command directly to
>           hardware command queue.
>         - Added tasklet structure variable in "struct pt_device".
>           This is used to invoke pt_do_cmd_complete() upon receiving interrupt
>           for command completion.
>         - pt_core_perform_passthru() function parameters are modified and it is
>           now used to submit command directly to hardware from dmaengine framework.
>         - Removed below structures, enums, macros and functions, as these values are
>           constants. Making command submission simple,
>            - Removed "union pt_function"  and several macros like PT_VERSION,
>              PT_BYTESWAP, PT_CMD_* etc..
>            - enum pt_passthru_bitwise, enum pt_passthru_byteswap, enum pt_memtype
>              struct pt_dma_info, struct pt_data, struct pt_mem, struct pt_passthru_op,
>              struct pt_op,
>            - Removed functions -> pt_cmd_queue_thread() pt_run_passthru_cmd(),
>              pt_run_cmd(), pt_dev_init(), pt_dequeue_cmd(), pt_do_cmd_backlog(),
>              pt_enqueue_cmd(),
>         - Below functions, stuctures and variables moved from ptdma-ops.c
>            - Moved function pt_alloc_struct() to ptdma-pci.c as its used only there.
>            - Moved "struct pt_tasklet_data" structure to ptdma.h
>            - Moved functions pt_do_cmd_complete(), pt_present(), pt_get_device(),
>              pt_add_device(), pt_del_device(), pt_log_error() and its dependent
>              static variables pt_unit_lock, pt_units, pt_rr_lock, pt_rr, pt_error_codes,
>              pt_ordinal  to ptdma-dev.c as they are used only in that file.
>
> Links of the review comments for v2:
> 1. https://lkml.org/lkml/2019/12/27/630
> 2. https://lkml.org/lkml/2020/1/3/23
> 3. https://lkml.org/lkml/2020/1/3/314
> 4. https://lkml.org/lkml/2020/1/10/100
>
>
> Links of the review comments for v1:
>
> 1. https://lkml.org/lkml/2019/9/24/490
> 2. https://lkml.org/lkml/2019/9/24/399
> 3. https://lkml.org/lkml/2019/9/24/862
> 4. https://lkml.org/lkml/2019/9/24/122
>
> Sanjay R Mehta (3):
>   dmaengine: ptdma: Initial driver for the AMD PassThru DMA engine
>   dmaengine: ptdma: Register pass-through engine as a DMA resource
>   dmaengine: ptdma: Add debugfs entries for PTDMA information
>
>  MAINTAINERS                         |   6 +
>  drivers/dma/Kconfig                 |   2 +
>  drivers/dma/Makefile                |   1 +
>  drivers/dma/ptdma/Kconfig           |   7 +
>  drivers/dma/ptdma/Makefile          |  12 +
>  drivers/dma/ptdma/ptdma-debugfs.c   | 237 ++++++++++++
>  drivers/dma/ptdma/ptdma-dev.c       | 448 +++++++++++++++++++++++
>  drivers/dma/ptdma/ptdma-dmaengine.c | 704 ++++++++++++++++++++++++++++++++++++
>  drivers/dma/ptdma/ptdma-pci.c       | 269 ++++++++++++++
>  drivers/dma/ptdma/ptdma.h           | 378 +++++++++++++++++++
>  10 files changed, 2064 insertions(+)
>  create mode 100644 drivers/dma/ptdma/Kconfig
>  create mode 100644 drivers/dma/ptdma/Makefile
>  create mode 100644 drivers/dma/ptdma/ptdma-debugfs.c
>  create mode 100644 drivers/dma/ptdma/ptdma-dev.c
>  create mode 100644 drivers/dma/ptdma/ptdma-dmaengine.c
>  create mode 100644 drivers/dma/ptdma/ptdma-pci.c
>  create mode 100644 drivers/dma/ptdma/ptdma.h
>
> --
> 2.7.4
>


--
wbr, Vitaly
