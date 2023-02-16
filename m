Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B74E4699ACC
	for <lists+dmaengine@lfdr.de>; Thu, 16 Feb 2023 18:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjBPRLK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 Feb 2023 12:11:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBPRLI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 16 Feb 2023 12:11:08 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6EB43A0A1;
        Thu, 16 Feb 2023 09:11:03 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id c20so3609296lfv.6;
        Thu, 16 Feb 2023 09:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4f5Guh6O+Er90p8RJpc81QhGfIifglAIud62OdlqqVg=;
        b=PXg2oMtQiUwyIfWKSaIiPCjXtx5SVicibxvae8g+TZUbyDun2Wb3yMt9uQIRKflYmO
         E4RkUohPnoGMfXYtzAEC2UiHvfl2hcpUafLj20Z5AJvZbQtWii/fxHgLDLYOqIoSPbVv
         KKTP9SOiEwu6AnFwnxqIaM2rnsErbTDGKmETbFFQe2ynAQk6TGCoIzZcyqt1fby9mzur
         3FilvTZe4SutefJR6w3PPLBhHpzJdaSCHPdAEpRyok4VUPpausS4lFkMSCfVSyb3oO3t
         9kFlGpSRFTrZDtnChpsNK8GOPXoAfFRRhKp2iWEpqgWSLd64wBdBWp4MusQi7V3Mdjsx
         aeQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4f5Guh6O+Er90p8RJpc81QhGfIifglAIud62OdlqqVg=;
        b=lMnYUf96W6cuhcfd2tzxH4P6AkoV+bYN7MKbLabUmjBE7SCAREksNWUracDSzI3gWG
         56pghbNdchQKkakEzMSwxbGy4xxXmE/Iqxf8tI37IePzj3MQsPn/wwKnGx543/NfdP6M
         g+6sQlLju2dmHVC7+Px94DI8i3dQFvtK+1Rjt7Cj0qd7iw0aTXE6EJ3rAJV80Vp9xzsh
         zjabPt+qUqjGsLmb9C4I60iPaP7fYFGyuWajlFtAZN3r1h4ar9gq1qTb1p3s0EDcTp15
         O+Swt6wLEzdJfj140G0/EN/igr8x4+GAEFfkFjGFmHWOoU0cxb5/xq9BD6aOARQT359n
         q6dw==
X-Gm-Message-State: AO0yUKUMVk2tUOIrzLUG0ftk4Xo3enCNnFzbW1FfwTthgHjTiCEwtqCQ
        ifom7hO9UBu/PNcrmDeBQ9A=
X-Google-Smtp-Source: AK7set9eU/at3h+mo5rSpX2NbkmXo12VKMArpwHeN3uJ5JzyWbSGz7FLFrMPDa0Aiq4xjA1rKFHQKQ==
X-Received: by 2002:ac2:59cf:0:b0:4db:379c:ae15 with SMTP id x15-20020ac259cf000000b004db379cae15mr1880207lfn.57.1676567461897;
        Thu, 16 Feb 2023 09:11:01 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id q14-20020ac246ee000000b004cafa01ebbfsm357268lfo.101.2023.02.16.09.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 09:11:01 -0800 (PST)
Date:   Thu, 16 Feb 2023 20:10:58 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Cai Huoqing <cai.huoqing@linux.dev>
Cc:     Sergey.Semin@baikalelectronics.ru,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 4/4] dmaengine: dw-edma: Add HDMA DebugFS support
Message-ID: <20230216171058.iypslnps5bvlw3qv@mobilestation>
References: <20230213132411.65524-1-cai.huoqing@linux.dev>
 <20230213132411.65524-5-cai.huoqing@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230213132411.65524-5-cai.huoqing@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Feb 13, 2023 at 09:24:09PM +0800, Cai Huoqing wrote:
> From: Cai huoqing <cai.huoqing@linux.dev>
> 
> Add HDMA DebugFS support to show register information
> 
> Signed-off-by: Cai huoqing <cai.huoqing@linux.dev>
> ---
>  drivers/dma/dw-edma/Makefile             |   3 +-
>  drivers/dma/dw-edma/dw-hdma-v0-core.c    |   2 +
>  drivers/dma/dw-edma/dw-hdma-v0-debugfs.c | 175 +++++++++++++++++++++++
>  drivers/dma/dw-edma/dw-hdma-v0-debugfs.h |  22 +++
>  4 files changed, 201 insertions(+), 1 deletion(-)
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
> index 7e4f98987e29..3723d5d8127c 100644
> --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> @@ -9,6 +9,7 @@
>  #include "dw-edma-core.h"
>  #include "dw-hdma-v0-core.h"
>  #include "dw-hdma-v0-regs.h"
> +#include "dw-hdma-v0-debugfs.h"
>  
>  enum dw_hdma_control {
>  	DW_HDMA_V0_CB					= BIT(0),
> @@ -294,6 +295,7 @@ static void dw_hdma_v0_core_ch_config(struct dw_edma_chan *chan)
>  /* HDMA debugfs callbacks */
>  static void dw_hdma_v0_core_debugfs_on(struct dw_edma *dw)
>  {
> +	dw_hdma_v0_debugfs_on(dw);
>  }
>  
>  static const struct dw_edma_core_ops hdma_core = {
> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-debugfs.c b/drivers/dma/dw-edma/dw-hdma-v0-debugfs.c
> new file mode 100644
> index 000000000000..a0fafd788c14
> --- /dev/null
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-debugfs.c
> @@ -0,0 +1,175 @@
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
> +	int nr_entries;

> +	struct dw_hdma_debugfs_entry debugfs_regs[] = {

should be const.

> +		CTX_REGISTER(dw, ch_en, dir, ch),
> +		CTX_REGISTER(dw, doorbell, dir, ch),

Did you intentionally miss the prefetch and handshake fields here?

> +		CTX_REGISTER(dw, llp.lsb, dir, ch),
> +		CTX_REGISTER(dw, llp.msb, dir, ch),
> +		CTX_REGISTER(dw, cycle_sync, dir, ch),
> +		CTX_REGISTER(dw, transfer_size, dir, ch),
> +		CTX_REGISTER(dw, sar.lsb, dir, ch),
> +		CTX_REGISTER(dw, sar.msb, dir, ch),
> +		CTX_REGISTER(dw, dar.lsb, dir, ch),
> +		CTX_REGISTER(dw, dar.msb, dir, ch),

watermark_en field?

> +		CTX_REGISTER(dw, control1, dir, ch),

func_num, qos?

> +		CTX_REGISTER(dw, ch_stat, dir, ch),
> +		CTX_REGISTER(dw, int_stat, dir, ch),
> +		CTX_REGISTER(dw, int_setup, dir, ch),
> +		CTX_REGISTER(dw, int_clear, dir, ch),
> +		CTX_REGISTER(dw, msi_stop.lsb, dir, ch),
> +		CTX_REGISTER(dw, msi_stop.msb, dir, ch),

msi_watermark?

Why did you miss all of these fields? It was no problem to add all
them seeing they are declared in the dw_hdma_v0_ch_regs structure.

> +		CTX_REGISTER(dw, msi_abort.lsb, dir, ch),
> +		CTX_REGISTER(dw, msi_abort.msb, dir, ch),
> +		CTX_REGISTER(dw, msi_msgdata, dir, ch),
> +	};

Use reverse xmas tree order as per the driver convention.

> +
> +	nr_entries = ARRAY_SIZE(debugfs_regs);
> +	dw_hdma_debugfs_create_x32(dw, debugfs_regs, nr_entries, dent);
> +}
> +
> +static void dw_hdma_debugfs_regs_wr(struct dw_edma *dw, struct dentry *dent)
> +{
> +	struct dentry *regs_dent, *ch_dent;
> +	int i;
> +	char name[16];

reverse xmas tree order

> +
> +	regs_dent = debugfs_create_dir(WRITE_STR, dent);
> +	if (!regs_dent)
> +		return;
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
> +	int i;
> +	char name[16];

reverse xmas tree order.

-Serge(y)

> +
> +	regs_dent = debugfs_create_dir(READ_STR, dent);
> +	if (!regs_dent)
> +		return;
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
