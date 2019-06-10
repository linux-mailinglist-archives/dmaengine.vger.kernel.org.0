Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD4673AFD9
	for <lists+dmaengine@lfdr.de>; Mon, 10 Jun 2019 09:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388247AbfFJHpz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 10 Jun 2019 03:45:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:33400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387781AbfFJHpy (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 10 Jun 2019 03:45:54 -0400
Received: from localhost (unknown [122.178.227.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D6C620859;
        Mon, 10 Jun 2019 07:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560152754;
        bh=ENaV0hH+t6dBvquoHYccnSfqO4CQH7u4IkveLe6qZzM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ff8vzlj0sGdqchlj/ZcmdtKkv94kfs1E7RptUp7cFN5X074GV6fliy9+tFCtS5uA6
         R6dIV28R/XdvcvnN9sRoBBtwS6V2yRgi2GLm/EaQcXC721U55GCxvvyTtRZpz+dj61
         o4dZE+9QbQYVzGO60bvF4IKXj0Cg0lhLcKVfSeFc=
Date:   Mon, 10 Jun 2019 13:12:45 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     linux-pci@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v2 0/6] dmaengine: Add Synopsys eDMA IP driver (version 0)
Message-ID: <20190610074245.GM9160@vkoul-mobl.Dlink>
References: <cover.1559654565.git.gustavo.pimentel@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1559654565.git.gustavo.pimentel@synopsys.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 04-06-19, 15:29, Gustavo Pimentel wrote:
> Add Synopsys eDMA IP driver (version 0 and for EP side only) to Linux
> kernel. This IP is generally distributed with Synopsys PCIe EndPoint IP
> (depends of the use and licensing agreement), which supports:
>  - legacy and unroll modes
>  - 16 independent and concurrent channels (8 write + 8 read)
>  - supports linked list (scatter-gather) transfer
>  - each linked list descriptor can transfer from 1 byte to 4 Gbytes
>  - supports cyclic transfer
>  - PCIe EndPoint glue-logic
> 
> This patch series contains:
>  - eDMA core + eDMA core v0 driver (implements the interface with
>  DMAengine controller APIs and interfaces with eDMA HW block)
>  - eDMA PCIe glue-logic reference driver (attaches to Synopsys EP and
>  provides memory access to eDMA core driver)

Applied all, thanks

-- 
~Vinod
