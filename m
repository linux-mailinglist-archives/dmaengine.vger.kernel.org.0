Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F99E14784D
	for <lists+dmaengine@lfdr.de>; Fri, 24 Jan 2020 06:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730461AbgAXFtF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 24 Jan 2020 00:49:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:48818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730424AbgAXFtF (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 24 Jan 2020 00:49:05 -0500
Received: from localhost (unknown [106.200.244.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E90B2075D;
        Fri, 24 Jan 2020 05:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579844945;
        bh=TC5Y+qbSOlR/VxGQVcttwifbgxIO6INuo4aIMaiwB64=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ybw59i52VEL3CKZN4mZQAazoy1VYokWls54o5XP558zi1MlnhnN4r3iMoZaT6hUOa
         ZsdXBqhyvjBuTuUpqXHXJDD0SsMImz2RM9657bJ8zRH/WvTZzKDF51LLgSELZBCExV
         HYUloBELTnPoWqGJrWMhIZcvU3kGJXE/as4DCy8o=
Date:   Fri, 24 Jan 2020 11:18:59 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Zhou Wang <wangzhou1@hisilicon.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        linuxarm@huawei.com, Zhenfa Qiu <qiuzhenfa@hisilicon.com>
Subject: Re: [PATCH v5] dmaengine: hisilicon: Add Kunpeng DMA engine support
Message-ID: <20200124054859.GA2841@vkoul-mobl>
References: <1579155057-80523-1-git-send-email-wangzhou1@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579155057-80523-1-git-send-email-wangzhou1@hisilicon.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 16-01-20, 14:10, Zhou Wang wrote:
> This patch adds a driver for HiSilicon Kunpeng DMA engine. This DMA engine
> which is an PCIe iEP offers 30 channels, each channel has a send queue, a
> complete queue and an interrupt to help to do tasks. This DMA engine can do
> memory copy between memory blocks or between memory and device buffer.

Applied, thanks

-- 
~Vinod
