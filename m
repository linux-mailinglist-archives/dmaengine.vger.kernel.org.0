Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2002220F70F
	for <lists+dmaengine@lfdr.de>; Tue, 30 Jun 2020 16:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729989AbgF3OYd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 30 Jun 2020 10:24:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:55792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728909AbgF3OYc (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 30 Jun 2020 10:24:32 -0400
Received: from localhost (unknown [122.182.251.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41D7720672;
        Tue, 30 Jun 2020 14:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593527072;
        bh=ge1JjR8yCKRp2SCQdixfwB2tfDCzu96qp1bblnzo3MY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qq+285ULYVSVmGGKvuGr5XnuXZMuyUROGjNId+dkUNPMw5K1hiSmZev8R46Ydkia1
         Ljkn6bPbDnvHp5z/eiHxGVXQCKTpv/cMXe+gndtgIWRYRL44My8agPHpLIyzAS2MYt
         WrmY7cIyTsbSSEnixH18uvI9PlcMgxoTMDvdf11A=
Date:   Tue, 30 Jun 2020 19:54:27 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Amit Tomer <amittomer25@gmail.com>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        dan.j.williams@intel.com, cristian.ciocaltea@gmail.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-actions@lists.infradead.org
Subject: Re: [PATCH v4 02/10] dmaengine: Actions: Add support for S700 DMA
 engine
Message-ID: <20200630142427.GP2599@vkoul-mobl>
References: <1591697830-16311-1-git-send-email-amittomer25@gmail.com>
 <1591697830-16311-3-git-send-email-amittomer25@gmail.com>
 <20200624061529.GF2324254@vkoul-mobl>
 <CABHD4K-Z7_MkG-j1uAt6XGnz4zWzNYeuEgq=BwE=NXPwY6gb6g@mail.gmail.com>
 <20200629095207.GG2599@vkoul-mobl>
 <CABHD4K9VOWpC7=o2VKrqoxEtMQ2gFv_Qs885dBKL1o+B_fe_3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABHD4K9VOWpC7=o2VKrqoxEtMQ2gFv_Qs885dBKL1o+B_fe_3g@mail.gmail.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 30-06-20, 15:17, Amit Tomer wrote:
> Hi Vinod,
> 
> On Mon, Jun 29, 2020 at 3:22 PM Vinod Koul <vkoul@kernel.org> wrote:
> 
> > If you use of_device_get_match_data() you will not fall into this :)
> 
> But again, of_device_get_match_data() returns void *, and we need
> "uintptr_t" in order to type cast it properly (at-least without
> warning).

Not really, you can cast from void * to you own structure.. btw why do
you need uintptr_t?

> 
> Also, while looking around found the similar warning for other file
> where it uses " of_device_get_match_data()"
> drivers/pci/controller/pcie-iproc-platform.c:56:15: warning: cast to
> smaller integer type 'enum iproc_pcie_type' from 'const void *'
> [-Wvoid-pointer-to-enum-cast]
>         pcie->type = (enum iproc_pcie_type) of_device_get_match_data(dev);

The problem is a pointer to enum conversion :) I think the right way
would be to do would be below

        soc_type =  (enum foo)of_device_get_match_data(dev);

or
        soc_type =  (unsigned long) of_device_get_match_data(dev);

which I think should be fine in gcc, but possibly give you above warning
in clang.. but i thought that was fixed in clang https://reviews.llvm.org/D75758

Thanks
-- 
~Vinod
