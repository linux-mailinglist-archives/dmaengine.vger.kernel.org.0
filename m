Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F07595DAC
	for <lists+dmaengine@lfdr.de>; Tue, 20 Aug 2019 13:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbfHTLo7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 20 Aug 2019 07:44:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:46920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728409AbfHTLo7 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 20 Aug 2019 07:44:59 -0400
Received: from localhost (unknown [106.201.62.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96B30214DA;
        Tue, 20 Aug 2019 11:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566301498;
        bh=GKU0MqwQ9Eq5z11rsh56hpHg91nSDePZNnrM6N3PfEg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gQ8+vsWVr97/c7XjDPDGts5rbdcrIM18/Iv9B+D3c6US6KDG8XJUVnV2EAj4JvAKS
         auCfxGnkrfKrRpUM/MRZk7+LwR4XGn9unVB8nc1AYoOzv2VUDR+YLCuAqjgK/a56fH
         xZzIJPWoXBCIzbgl+FTm1RBB8K5Y8Yl+fUYzzh7s=
Date:   Tue, 20 Aug 2019 17:13:46 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Wenwen Wang <wenwen@cs.uga.edu>
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Enrico Weigelt <info@metux.net>,
        "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] dmaengine: ti: dma-crossbar: Fix a memory leak bug
Message-ID: <20190820114346.GX12733@vkoul-mobl.Dlink>
References: <1565938136-7249-1-git-send-email-wenwen@cs.uga.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565938136-7249-1-git-send-email-wenwen@cs.uga.edu>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 16-08-19, 01:48, Wenwen Wang wrote:
> In ti_dra7_xbar_probe(), 'rsv_events' is allocated through kcalloc(). Then
> of_property_read_u32_array() is invoked to search for the property.
> However, if this process fails, 'rsv_events' is not deallocated, leading to
> a memory leak bug. To fix this issue, free 'rsv_events' before returning
> the error.

Applied, thanks

-- 
~Vinod
