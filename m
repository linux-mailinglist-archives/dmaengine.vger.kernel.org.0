Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA4213A16A9
	for <lists+dmaengine@lfdr.de>; Wed,  9 Jun 2021 16:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233491AbhFIOMF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 9 Jun 2021 10:12:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:38216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232474AbhFIOMF (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 9 Jun 2021 10:12:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A37D261285;
        Wed,  9 Jun 2021 14:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623247810;
        bh=XVSIs8gLCt9INCVjowedsNE35bHNbRG2HRz7YC4IGEA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X8cuFTUdMUT+9okGGDOIiJCiOdAc0FC8MUql48zi2Vdl7aeyAYG1bLOni2EhLTTzR
         0uEXQS6LGkOINcBB8l9n0dI6BZmuflz38/XmUvjbVTS22G2s++0XD+rQuegn/ul5eV
         guyjQCGc7wY+U4V6nqMEysAdOwM+XM5biJdRNPB/QPcenqaM9y3STSK261rgGQJ7Cy
         h1nu1nwmiKwWwq1uxlbyIX5t7nYH+hx6ZY2SKIE8ukjC7aFfdk25oeVGX0I134wBYX
         xiPIMw7TKbq20Nnl8/Z4/DdwYC01EZ4PasoKqhG1au5oUEqueHVMixaDYI8Leo4m5D
         MIWg5e6UvVfvg==
Date:   Wed, 9 Jun 2021 19:40:06 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sanjay R Mehta <Sanju.Mehta@amd.com>
Cc:     gregkh@linuxfoundation.org, dan.j.williams@intel.com,
        Thomas.Lendacky@amd.com, Shyam-sundar.S-k@amd.com,
        Nehal-bakulchandra.Shah@amd.com, robh@kernel.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v9 3/3] dmaengine: ptdma: Add debugfs entries for PTDMA
Message-ID: <YMDLvnCyfo8+StpW@vkoul-mobl>
References: <1622654551-9204-1-git-send-email-Sanju.Mehta@amd.com>
 <1622654551-9204-4-git-send-email-Sanju.Mehta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1622654551-9204-4-git-send-email-Sanju.Mehta@amd.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 02-06-21, 12:22, Sanjay R Mehta wrote:

> +/* DebugFS helpers */
> +#define	MAX_NAME_LEN	20
> +#define	RI_VERSION_NUM	0x0000003F
> +
> +#define	RI_NUM_VQM	0x00078000
> +#define	RI_NVQM_SHIFT	15
> +
> +static DEFINE_MUTEX(pt_debugfs_lock);

unused?

> +
> +static int pt_debugfs_info_show(struct seq_file *s, void *p)
> +{
> +	struct pt_device *pt = s->private;
> +	unsigned int regval;
> +
> +	if (!pt)
> +		return 0;

better return an error code?

> +
> +	seq_printf(s, "Device name: %s\n", pt->name);
> +	seq_printf(s, "   # Queues: %d\n", 1);
> +	seq_printf(s, "     # Cmds: %d\n", pt->cmd_count);
> +
> +	regval = ioread32(pt->io_regs + CMD_PT_VERSION);

how do you ensure your device is not sleeping or you can access iomem
safely?

> +void ptdma_debugfs_setup(struct pt_device *pt)
> +{
> +	struct pt_cmd_queue *cmd_q;
> +	char name[MAX_NAME_LEN + 1];
> +	struct dentry *debugfs_q_instance;
> +
> +	if (!debugfs_initialized())
> +		return;
> +
> +	debugfs_create_file("info", 0400, pt->dma_dev.dbg_dev_root, pt,
> +			    &pt_debugfs_info_fops);
> +
> +	debugfs_create_file("stats", 0600, pt->dma_dev.dbg_dev_root, pt,

why 600 here?
-- 
~Vinod
