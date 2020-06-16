Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A10E1FBBCA
	for <lists+dmaengine@lfdr.de>; Tue, 16 Jun 2020 18:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730731AbgFPQcr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 16 Jun 2020 12:32:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:33742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730588AbgFPQcq (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 16 Jun 2020 12:32:46 -0400
Received: from localhost (unknown [171.61.66.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71BD620882;
        Tue, 16 Jun 2020 16:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592325166;
        bh=v1NEVGl2JZ+x6Y+VmJrgJFlKm7OXUpbzQ/E9bGRWjFQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=khGHiJvcszZgXVCQrXtmKy8FXo7lOoT75j/6La/xCYBoAOLJN1hPDEyaIJR5HnaRT
         sqHPvhlOFObJWLZkJwgHKl22dEpyHhpuGCDP5vsMzbL7TaBLKJhd/0qJr6T39obBAq
         TPMUrPJxB7A3wi3RPTHF1GKB013UktuhDufa6KEc=
Date:   Tue, 16 Jun 2020 22:02:42 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Viresh Kumar <vireshk@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Maxim Kaurkin <Maxim.Kaurkin@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Ekaterina Skachko <Ekaterina.Skachko@baikalelectronics.ru>,
        Vadim Vlasov <V.Vlasov@baikalelectronics.ru>,
        Alexey Kolotnikov <Alexey.Kolotnikov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 00/11] dmaengine: dw: Take Baikal-T1 SoC DW DMAC
 peculiarities into account
Message-ID: <20200616163242.GO2324254@vkoul-mobl>
References: <20200529144054.4251-1-Sergey.Semin@baikalelectronics.ru>
 <20200602092734.6oekfmilbpx54y64@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602092734.6oekfmilbpx54y64@mobilestation>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Serge,

On 02-06-20, 12:27, Serge Semin wrote:
> Vinod, Viresh
> 
> Andy's finished his review. So all the patches of the series (except one rather
> decorative, which we have different opinion of) are tagged by him. Since merge
> window is about to be opened please consider to merge the series in. I'll really
> need it to be in the kernel to provide the noLLP-problem fix for the Dw APB SSI
> in 5.8.

Sorry it was too late for 5.8.. merge window is closed now, i will
review it shortly

-- 
~Vinod
