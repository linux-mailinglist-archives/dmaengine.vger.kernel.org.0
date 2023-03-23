Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57D9E6C645D
	for <lists+dmaengine@lfdr.de>; Thu, 23 Mar 2023 11:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjCWKDf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 23 Mar 2023 06:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjCWKDe (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 23 Mar 2023 06:03:34 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1846910D;
        Thu, 23 Mar 2023 03:03:30 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 20so14632122lju.0;
        Thu, 23 Mar 2023 03:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679565808;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sy5b+KDY1QEJL7mnyP5vXspq/Ud8cBYsoJBHH7kWSZU=;
        b=j3XpnyuUTBe2lZwJ4H+ijcbIAV8FMzJN14XtYuGKH10iU51z0wmSLVi/hZzbBRBVmZ
         0wwPNnW1Hrdg3rFQhX9QfDIIcHXNIQMwlKE+DHxEqAScG3fz7X1SAygeUG614ywrt86m
         sJMOF9L1gVrLfus+b5eZMUNkTZNPC0aJD2rUr2F18GqegdPfK6S5DxWl9LcFJ30ofAxu
         i/b8tSmR3Tsj/pRVGElqQ1kVXHEdi39/vtwNBSDl3/NiV9epBAe7PNxwhCh+aAb294vY
         RgluT40KZrAfa0/48NGJkUDn7JIjSIAiQicIT15rqKEg08F2O68L88Ul1OXxU9aCrFTk
         FcQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679565808;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sy5b+KDY1QEJL7mnyP5vXspq/Ud8cBYsoJBHH7kWSZU=;
        b=tVU42xw1EkUcLLzj9zgN07jpHS69WLdOcPz3OvAave0ASJCuGNrD/8Xuj/vN7X4hR2
         J0zfkMRcME3eMbwBYPJIITXQepbKo7qdlj+cI1ndOkuNZCjKero0knmQXH4MiU52vd7/
         PKS3c9asIg9W66O5g1K8A1PEfLXm2/kitdEB35TT3SJNCTHyqwQBqkarePqrd425h6b6
         epk0ivHWz6ghl/TS9U6R9mzlZCZLgDy4FGxSnvsRFjju0pcaCZDE6UfrNcfoHFAXEmv9
         ieeySmBIvN676RtMYYtbyiNDDyRZjsZO+9o26GJG6ooTRSCCxQ98NgdvMFaTzUOG15+y
         U4Qw==
X-Gm-Message-State: AO0yUKVxFw+wDQ/jpw9+1ycVzI3E6wgEnaKq+EzIHYJMUQde5Gy6loT8
        EmvsN97Dh5IaWbguIFkCLx0=
X-Google-Smtp-Source: AK7set8D18UAQZRnHt4bxilF6eKLnimanHWFyClpJP2tW69pSyEtG+Waz44EvJcPmBQ7szAYdYMF8g==
X-Received: by 2002:a2e:7410:0:b0:2a0:4de2:db88 with SMTP id p16-20020a2e7410000000b002a04de2db88mr1843237ljc.44.1679565808245;
        Thu, 23 Mar 2023 03:03:28 -0700 (PDT)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id y26-20020a2e321a000000b002934febffe4sm2930024ljy.128.2023.03.23.03.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 03:03:27 -0700 (PDT)
Date:   Thu, 23 Mar 2023 13:03:25 +0300
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
Subject: Re: [PATCH v8 4/4] dmaengine: dw-edma: Add HDMA DebugFS support
Message-ID: <20230323100325.zltk7emftkyfgsef@mobilestation>
References: <20230323034944.78357-1-cai.huoqing@linux.dev>
 <20230323034944.78357-5-cai.huoqing@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323034944.78357-5-cai.huoqing@linux.dev>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Mar 23, 2023 at 11:49:41AM +0800, Cai Huoqing wrote:
> From: Cai huoqing <cai.huoqing@linux.dev>
> 
> Add HDMA DebugFS support to show register information

s/register information/registers content.

> 
> Signed-off-by: Cai huoqing <cai.huoqing@linux.dev>
> ---
> v7->v8:
>   1.Drop some unused field in dw_hdma_debugfs_entry.
> 
> v7 link:
>   https://lore.kernel.org/lkml/20230315012840.6986-5-cai.huoqing@linux.dev/
> 
> 
>  drivers/dma/dw-edma/Makefile             |   3 +-
>  drivers/dma/dw-edma/dw-hdma-v0-core.c    |   2 +
>  drivers/dma/dw-edma/dw-hdma-v0-debugfs.c | 173 +++++++++++++++++++++++
>  drivers/dma/dw-edma/dw-hdma-v0-debugfs.h |  22 +++
>  4 files changed, 199 insertions(+), 1 deletion(-)
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
> index 22b7b0410deb..00b735a0202a 100644
> --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> @@ -11,6 +11,7 @@
>  #include "dw-edma-core.h"
>  #include "dw-hdma-v0-core.h"
>  #include "dw-hdma-v0-regs.h"
> +#include "dw-hdma-v0-debugfs.h"
>  
>  enum dw_hdma_control {
>  	DW_HDMA_V0_CB					= BIT(0),
> @@ -276,6 +277,7 @@ static void dw_hdma_v0_core_ch_config(struct dw_edma_chan *chan)
>  /* HDMA debugfs callbacks */
>  static void dw_hdma_v0_core_debugfs_on(struct dw_edma *dw)
>  {
> +	dw_hdma_v0_debugfs_on(dw);
>  }
>  
>  static const struct dw_edma_core_ops dw_hdma_v0_core = {
> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-debugfs.c b/drivers/dma/dw-edma/dw-hdma-v0-debugfs.c
> new file mode 100644
> index 000000000000..c1f2c61e941e
> --- /dev/null
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-debugfs.c
> @@ -0,0 +1,173 @@
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
> +	{#name, REGS_CH_ADDR(dw, name, dir, ch)}
> +

> +#define REGISTER(dw, name) \
> +	{ dw, #name, REGS_ADDR(dw, name) }

This macro appears to be unused. Please drop. Other than that the
patch looks good.
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> +
> +#define WRITE_STR				"write"
> +#define READ_STR				"read"
> +#define CHANNEL_STR				"channel"
> +#define REGISTERS_STR				"registers"
> +
> +struct dw_hdma_debugfs_entry {
> +	const char				*name;
> +	void __iomem				*reg;
> +};
> +
> +static int dw_hdma_debugfs_u32_get(void *data, u64 *val)
> +{
> +	struct dw_hdma_debugfs_entry *entry = data;
> +	void __iomem *reg = entry->reg;
> +
> +	*val = readl(reg);
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
> +	if (!entries)
> +		return;
> +
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
> +
> +	for (i = 0; i < dw->wr_ch_cnt; i++) {
> +		snprintf(name, sizeof(name), "%s:%d", CHANNEL_STR, i);
> +
> +		ch_dent = debugfs_create_dir(name, regs_dent);
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
> +
> +	for (i = 0; i < dw->rd_ch_cnt; i++) {
> +		snprintf(name, sizeof(name), "%s:%d", CHANNEL_STR, i);
> +
> +		ch_dent = debugfs_create_dir(name, regs_dent);
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
