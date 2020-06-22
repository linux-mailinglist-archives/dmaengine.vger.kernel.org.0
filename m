Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDB8A2033B7
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2020 11:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbgFVJmR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 22 Jun 2020 05:42:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:58116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727859AbgFVJmQ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 22 Jun 2020 05:42:16 -0400
Received: from localhost (unknown [171.61.66.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FB542071A;
        Mon, 22 Jun 2020 09:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592818936;
        bh=MbsvdPgrWbZFnywGQTAx5D+GLS+v+EoIPRCjcMAjK9E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wNN7DU7rpU4DBzaiaGjxvy9Z2HbsaUZpOQkCDtdcuL2yBxW9K2UBJljwsmKzAMH8n
         79MWnAaVdzTJKqPUbmN9H1rd9D3FNWM2SS0dL17do4nfvIUwrgG+8cDGxU8fF/huWH
         RNuMYAlhw5GCMtSWkspgbq1KhxyQREoSPItmyKvM=
Date:   Mon, 22 Jun 2020 15:12:09 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Federico Vaga <federico.vaga@cern.ch>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: DMA Engine: Transfer From Userspace
Message-ID: <20200622094209.GH2324254@vkoul-mobl>
References: <5614531.lOV4Wx5bFT@harkonnen>
 <20200622092553.pvspklv5suu6rm7w@cwe-513-vol689.cern.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622092553.pvspklv5suu6rm7w@cwe-513-vol689.cern.ch>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 22-06-20, 11:25, Federico Vaga wrote:
> On Sat, Jun 20, 2020 at 12:47:16AM +0200, Federico Vaga wrote:
> > Hello,
> > 
> > is there the possibility of using a DMA engine channel from userspace?
> > 
> > Something like:
> > - configure DMA using ioctl() (or whatever configuration mechanism)
> > - read() or write() to trigger the transfer
> 
> Let me add one more question related to my case. The dmatest module does not
> perform tests on SLAVEs. why?

For slaves, we need some driver to do the peripheral configuration,
dmatest cannot do that and is suited for memcpy operations

Thanks
-- 
~Vinod
