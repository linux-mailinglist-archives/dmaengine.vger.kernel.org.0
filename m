Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C558D6A8AEF
	for <lists+dmaengine@lfdr.de>; Thu,  2 Mar 2023 22:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjCBVE4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 2 Mar 2023 16:04:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjCBVEy (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 2 Mar 2023 16:04:54 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159E714210;
        Thu,  2 Mar 2023 13:04:53 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id g17so982289lfv.4;
        Thu, 02 Mar 2023 13:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677791091;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gS1aC4OWyRu6SpGrWqYbSYZBwKwvoyr0C7Dc2Ig+DtE=;
        b=ciy68zYbblqXtZCzbcdsaOq6tlhZCjTK7mK6I5dT+QABqd54mWZFHPa7Gq0G2995aT
         Lx3mNKs5jdL+6gejydSvBvSreHoXkTF+4fsnsSQxU7CKHkkZCaZzWzx7CNO40buEapxl
         hQTq+6anL4mXuFsjLkHBdLilcDSB34sXWxbzqBp4yTeHLbDqB4af/2p8LOJTVD5AjEKx
         5m3CB7APEmuXJtbfmW/J/VUI4HRFSXtUUoqiDV1qJ36K6SbcIzDNl/YL+wHKR19ZogPJ
         JOhpOkxtnBxsXWquySj8mFanuFYn7PLTnQNvqCxhj3eeSUOQzI/blBmhLsA5ikmCWPo3
         wgLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677791091;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gS1aC4OWyRu6SpGrWqYbSYZBwKwvoyr0C7Dc2Ig+DtE=;
        b=wUxMuL2tjapbyeNFQg+BYntkFJB+z+CnbfJG6junXP9ApjpO481W3pxjNM2bPb5Q4o
         n3nGcdptDGLYPO/95zwz2nzVrCZm0z1MYsgrNuM8lw5WgfnM/gCrWmrMYNdl7bZppCrH
         zLda4ps/56m+znNdFN/TnthGYKoKuTr9HQY7/ZtOi4EuZy3qjazYiCE+WPq3xVl8mrQT
         Gfn1RSeehNIoi7evo3/zpWuftylmePpahCQFs1z361sTlX0yLQG36o2teaVDAeNh307S
         ZeVf3imguFPL59ZQ8hBeNpwzZRr8OSE+sRnFkuogWnrvOvlCsox9AqZtevg5Go4Bubcm
         IyCQ==
X-Gm-Message-State: AO0yUKXdaoRYROeYrn48uy1apH6nMktmg64g2Yi2eddGrlz7Fd8NBuiA
        KWUquRjvkXYCPj058SrRwSo=
X-Google-Smtp-Source: AK7set9waHOr75BQF+Xh9hJ/6B0B6F1Totg3dY1RUtnEpkGhCM1HqwrSCDvnpy1gNLvKaipOVG4LQg==
X-Received: by 2002:ac2:51c8:0:b0:4dd:9ddc:4461 with SMTP id u8-20020ac251c8000000b004dd9ddc4461mr3380426lfm.17.1677791091115;
        Thu, 02 Mar 2023 13:04:51 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id d3-20020ac25ec3000000b004db9dbe09c6sm77915lfq.89.2023.03.02.13.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 13:04:50 -0800 (PST)
Date:   Fri, 3 Mar 2023 00:04:47 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Cai Huoqing <cai.huoqing@linux.dev>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 4/4] dmaengine: dw-edma: Add HDMA DebugFS support
Message-ID: <20230302210447.fyzqjknew5z4ncdg@mobilestation>
References: <20230221034656.14476-1-cai.huoqing@linux.dev>
 <20230221034656.14476-5-cai.huoqing@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230221034656.14476-5-cai.huoqing@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Feb 21, 2023 at 11:46:55AM +0800, Cai Huoqing wrote:
> From: Cai huoqing <cai.huoqing@linux.dev>
> 
> Add HDMA DebugFS support to show register information
> 
> Signed-off-by: Cai huoqing <cai.huoqing@linux.dev>
> ---
>   v3->v4:
>     1.Add field watermark_en, func_num, qos, msi_watermark,etc.
>     2.Make variables reverse xmas tree order.
>     3.Declare const for 'struct dw_hdma_debugfs_entry'
> 
>   v3 link:
>   https://lore.kernel.org/lkml/20230213132411.65524-5-cai.huoqing@linux.dev/
> 
>  drivers/dma/dw-edma/Makefile             |   3 +-
>  drivers/dma/dw-edma/dw-hdma-v0-core.c    |   2 +
>  drivers/dma/dw-edma/dw-hdma-v0-debugfs.c | 181 +++++++++++++++++++++++
>  drivers/dma/dw-edma/dw-hdma-v0-debugfs.h |  22 +++
>  4 files changed, 207 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-debugfs.c
>  create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-debugfs.h
> 
> diff --git a/drivers/dma/dw-edma/Makefile b/drivers/dma/dw-edma/Makefile
> index b1c91ef2c63d..83ab58f87760 100644
> --- a/drivers/dma/dw-edma/Makefile
> +++ b/drivers/dma/dw-edma/Makefile
> @@ -1,7 +1,8 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
>  obj-$(CONFIG_DW_EDMA)		+= dw-edma.o
> -dw-edma-$(CONFIG_DEBUG_FS)	:= dw-edma-v0-debugfs.o
> +dw-edma-$(CONFIG_DEBUG_FS)	:= dw-edma-v0-debugfs.o	\
> +				   dw-hdma-v0-debugfs.o
>  dw-edma-objs			:= dw-edma-core.o	\
>  				   dw-edma-v0-core.o	\
>  				   dw-hdma-v0-core.o $(dw-edma-y)
> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> index cadc80dc62b2..6850042dbbe0 100644
> --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> @@ -10,6 +10,7 @@
>  #include "dw-edma-core.h"
>  #include "dw-hdma-v0-core.h"
>  #include "dw-hdma-v0-regs.h"
> +#include "dw-hdma-v0-debugfs.h"
>  
>  enum dw_hdma_control {
>  	DW_HDMA_V0_CB					= BIT(0),
> @@ -282,6 +283,7 @@ static void dw_hdma_v0_core_ch_config(struct dw_edma_chan *chan)
>  /* HDMA debugfs callbacks */
>  static void dw_hdma_v0_core_debugfs_on(struct dw_edma *dw)
>  {
> +	dw_hdma_v0_debugfs_on(dw);
>  }
>  
>  static const struct dw_edma_core_ops dw_hdma_v0_core = {
> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-debugfs.c b/drivers/dma/dw-edma/dw-hdma-v0-debugfs.c
> new file mode 100644
> index 000000000000..3a6f70173a03
> --- /dev/null
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-debugfs.c
> @@ -0,0 +1,181 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2023 Cai Huoqing
> + * Synopsys DesignWare HDMA v0 debugfs
> + *
> + * Author: Cai Huoqing <cai.huoqing@linux.dev>
> + */
> +
> +#include <linux/debugfs.h>
> +#include <linux/bitfield.h>
> +
> +#include "dw-hdma-v0-debugfs.h"
> +#include "dw-hdma-v0-regs.h"
> +#include "dw-edma-core.h"
> +
> +#define REGS_ADDR(dw, name)						       \
> +	({								       \
> +		struct dw_hdma_v0_regs __iomem *__regs = (dw)->chip->reg_base; \
> +									       \
> +		(void __iomem *)&__regs->name;				       \
> +	})
> +
> +#define REGS_CH_ADDR(dw, name, _dir, _ch)				       \
> +	({								       \
> +		struct dw_hdma_v0_ch_regs __iomem *__ch_regs;		       \
> +									       \
> +		if (_dir == EDMA_DIR_READ)				       \
> +			__ch_regs = REGS_ADDR(dw, ch[_ch].rd);		       \
> +		else							       \
> +			__ch_regs = REGS_ADDR(dw, ch[_ch].wr);		       \
> +									       \
> +		(void __iomem *)&__ch_regs->name;			       \
> +	})
> +
> +#define CTX_REGISTER(dw, name, dir, ch) \
> +	{ dw, #name, REGS_CH_ADDR(dw, name, dir, ch), dir, ch }
> +
> +#define REGISTER(dw, name) \
> +	{ dw, #name, REGS_ADDR(dw, name) }
> +
> +#define WRITE_STR				"write"
> +#define READ_STR				"read"
> +#define CHANNEL_STR				"channel"
> +#define REGISTERS_STR				"registers"
> +
> +struct dw_hdma_debugfs_entry {
> +	struct dw_edma				*dw;
> +	const char				*name;
> +	void __iomem				*reg;
> +	enum dw_edma_dir			dir;
> +	u16					ch;
> +};
> +
> +static int dw_hdma_debugfs_u32_get(void *data, u64 *val)
> +{

> +	void __iomem *reg = (void __force __iomem *)data;
> +	*val = readl(reg);

A tiny nitpick. Please add newline between the lines above so the code
would look a bit cleaner.

> +
> +	return 0;
> +}
> +DEFINE_DEBUGFS_ATTRIBUTE(fops_x32, dw_hdma_debugfs_u32_get, NULL, "0x%08llx\n");
> +
> +static void dw_hdma_debugfs_create_x32(struct dw_edma *dw,
> +				       const struct dw_hdma_debugfs_entry ini[],
> +				       int nr_entries, struct dentry *dent)
> +{
> +	struct dw_hdma_debugfs_entry *entries;
> +	int i;
> +

> +	entries = devm_kcalloc(dw->chip->dev, nr_entries, sizeof(*entries),
> +			       GFP_KERNEL);

Make sure devm_kcalloc() returns not-null.
https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/tree/drivers/dma/dw-edma/dw-edma-v0-debugfs.c?h=controller/dwc#n108
otherwise you risk to catch the null-dereference.

> +	for (i = 0; i < nr_entries; i++) {
> +		entries[i] = ini[i];
> +
> +		debugfs_create_file_unsafe(entries[i].name, 0444, dent,
> +					   &entries[i], &fops_x32);
> +	}
> +}
> +
> +static void dw_hdma_debugfs_regs_ch(struct dw_edma *dw, enum dw_edma_dir dir,
> +				    u16 ch, struct dentry *dent)
> +{
> +	const struct dw_hdma_debugfs_entry debugfs_regs[] = {
> +		CTX_REGISTER(dw, ch_en, dir, ch),
> +		CTX_REGISTER(dw, doorbell, dir, ch),
> +		CTX_REGISTER(dw, prefetch, dir, ch),
> +		CTX_REGISTER(dw, handshake, dir, ch),
> +		CTX_REGISTER(dw, llp.lsb, dir, ch),
> +		CTX_REGISTER(dw, llp.msb, dir, ch),
> +		CTX_REGISTER(dw, cycle_sync, dir, ch),
> +		CTX_REGISTER(dw, transfer_size, dir, ch),
> +		CTX_REGISTER(dw, sar.lsb, dir, ch),
> +		CTX_REGISTER(dw, sar.msb, dir, ch),
> +		CTX_REGISTER(dw, dar.lsb, dir, ch),
> +		CTX_REGISTER(dw, dar.msb, dir, ch),
> +		CTX_REGISTER(dw, watermark_en, dir, ch),
> +		CTX_REGISTER(dw, control1, dir, ch),
> +		CTX_REGISTER(dw, func_num, dir, ch),
> +		CTX_REGISTER(dw, qos, dir, ch),
> +		CTX_REGISTER(dw, ch_stat, dir, ch),
> +		CTX_REGISTER(dw, int_stat, dir, ch),
> +		CTX_REGISTER(dw, int_setup, dir, ch),
> +		CTX_REGISTER(dw, int_clear, dir, ch),
> +		CTX_REGISTER(dw, msi_stop.lsb, dir, ch),
> +		CTX_REGISTER(dw, msi_stop.msb, dir, ch),
> +		CTX_REGISTER(dw, msi_watermark.lsb, dir, ch),
> +		CTX_REGISTER(dw, msi_watermark.msb, dir, ch),
> +		CTX_REGISTER(dw, msi_abort.lsb, dir, ch),
> +		CTX_REGISTER(dw, msi_abort.msb, dir, ch),
> +		CTX_REGISTER(dw, msi_msgdata, dir, ch),
> +	};
> +	int nr_entries = ARRAY_SIZE(debugfs_regs);
> +
> +	dw_hdma_debugfs_create_x32(dw, debugfs_regs, nr_entries, dent);
> +}
> +
> +static void dw_hdma_debugfs_regs_wr(struct dw_edma *dw, struct dentry *dent)
> +{
> +	struct dentry *regs_dent, *ch_dent;
> +	char name[16];
> +	int i;
> +
> +	regs_dent = debugfs_create_dir(WRITE_STR, dent);

> +	if (!regs_dent)
> +		return;

No need in this check. DebugFS is designed to silently skip the nodes
creation if for some reason the parental dir couldn't be created:
https://elixir.bootlin.com/linux/latest/source/fs/debugfs/inode.c#L422

That's why the check was omitted in the eDMA part:
https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/tree/drivers/dma/dw-edma/dw-edma-v0-debugfs.c?h=controller/dwc#n181

> +
> +	for (i = 0; i < dw->wr_ch_cnt; i++) {
> +		snprintf(name, sizeof(name), "%s:%d", CHANNEL_STR, i);
> +
> +		ch_dent = debugfs_create_dir(name, regs_dent);
> +		if (!ch_dent)
> +			return;
> +
> +		dw_hdma_debugfs_regs_ch(dw, EDMA_DIR_WRITE, i, ch_dent);
> +	}
> +}
> +
> +static void dw_hdma_debugfs_regs_rd(struct dw_edma *dw, struct dentry *dent)
> +{
> +	struct dentry *regs_dent, *ch_dent;
> +	char name[16];
> +	int i;
> +
> +	regs_dent = debugfs_create_dir(READ_STR, dent);

> +	if (!regs_dent)
> +		return;

ditto

> +
> +	for (i = 0; i < dw->rd_ch_cnt; i++) {
> +		snprintf(name, sizeof(name), "%s:%d", CHANNEL_STR, i);
> +
> +		ch_dent = debugfs_create_dir(name, regs_dent);
> +		if (!ch_dent)
> +			return;
> +
> +		dw_hdma_debugfs_regs_ch(dw, EDMA_DIR_READ, i, ch_dent);
> +	}
> +}
> +
> +static void dw_hdma_debugfs_regs(struct dw_edma *dw)
> +{
> +	struct dentry *regs_dent;
> +
> +	regs_dent = debugfs_create_dir(REGISTERS_STR, dw->dma.dbg_dev_root);

> +	if (!regs_dent)
> +		return;

ditto

-Serge(y)

> +
> +	dw_hdma_debugfs_regs_wr(dw, regs_dent);
> +	dw_hdma_debugfs_regs_rd(dw, regs_dent);
> +}
> +
> +void dw_hdma_v0_debugfs_on(struct dw_edma *dw)
> +{
> +	if (!debugfs_initialized())
> +		return;
> +
> +	debugfs_create_u32("mf", 0444, dw->dma.dbg_dev_root, &dw->chip->mf);
> +	debugfs_create_u16("wr_ch_cnt", 0444, dw->dma.dbg_dev_root, &dw->wr_ch_cnt);
> +	debugfs_create_u16("rd_ch_cnt", 0444, dw->dma.dbg_dev_root, &dw->rd_ch_cnt);
> +
> +	dw_hdma_debugfs_regs(dw);
> +}
> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-debugfs.h b/drivers/dma/dw-edma/dw-hdma-v0-debugfs.h
> new file mode 100644
> index 000000000000..e6842c83777d
> --- /dev/null
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-debugfs.h
> @@ -0,0 +1,22 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2023 Cai Huoqing
> + * Synopsys DesignWare HDMA v0 debugfs
> + *
> + * Author: Cai Huoqing <cai.huoqing@linux.dev>
> + */
> +
> +#ifndef _DW_HDMA_V0_DEBUG_FS_H
> +#define _DW_HDMA_V0_DEBUG_FS_H
> +
> +#include <linux/dma/edma.h>
> +
> +#ifdef CONFIG_DEBUG_FS
> +void dw_hdma_v0_debugfs_on(struct dw_edma *dw);
> +#else
> +static inline void dw_hdma_v0_debugfs_on(struct dw_edma *dw)
> +{
> +}
> +#endif /* CONFIG_DEBUG_FS */
> +
> +#endif /* _DW_HDMA_V0_DEBUG_FS_H */
> -- 
> 2.34.1
> 
