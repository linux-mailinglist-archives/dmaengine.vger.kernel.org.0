Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 003D13E14AA
	for <lists+dmaengine@lfdr.de>; Thu,  5 Aug 2021 14:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241335AbhHEMYn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 5 Aug 2021 08:24:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:52618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241334AbhHEMYn (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 5 Aug 2021 08:24:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A923B61131;
        Thu,  5 Aug 2021 12:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628166269;
        bh=xAKsVXMtDsN6WuuEdbzYy00yVMILRU7K1QCm3smm7Yw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iZwoMZWB/JfyLg5LYwLD9usdBVIhng5NbAaXAQh/S9S3Bxtnp8MXRyveVo7+rxMyN
         oIAIDcrweL4e8P6gCe6/N2gTmwWIojJ8A8qU6DGSWb6qq0+6o66xD18xakiLaD3ARc
         07NW3nL8kNWXoMYClP5kv/6fqmp8UW4H1MOqoivc=
Date:   Thu, 5 Aug 2021 14:24:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sanjay R Mehta <Sanju.Mehta@amd.com>
Cc:     vkoul@kernel.org, dan.j.williams@intel.com,
        Thomas.Lendacky@amd.com, Shyam-sundar.S-k@amd.com,
        Nehal-bakulchandra.Shah@amd.com, robh@kernel.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v11 3/3] dmaengine: ptdma: Add debugfs entries for PTDMA
Message-ID: <YQvYeorB7BniIdm2@kroah.com>
References: <1627900375-80812-1-git-send-email-Sanju.Mehta@amd.com>
 <1627900375-80812-4-git-send-email-Sanju.Mehta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1627900375-80812-4-git-send-email-Sanju.Mehta@amd.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Aug 02, 2021 at 05:32:55AM -0500, Sanjay R Mehta wrote:
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
> +	debugfs_create_file("stats", 0400, pt->dma_dev.dbg_dev_root, pt,
> +			    &pt_debugfs_stats_fops);
> +
> +	cmd_q = &pt->cmd_q;
> +
> +	snprintf(name, MAX_NAME_LEN - 1, "q");

You are calling snprintf() to format a string to be "q"?  Why?  You can
just do:

> +
> +	debugfs_q_instance =
> +		debugfs_create_dir(name, pt->dma_dev.dbg_dev_root);

debugfs_create_dir("q", pt->....)

here instead.

thanks,

greg k-h
