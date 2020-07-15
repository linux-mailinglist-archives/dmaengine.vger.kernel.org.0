Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E55D220B93
	for <lists+dmaengine@lfdr.de>; Wed, 15 Jul 2020 13:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbgGOLNU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Jul 2020 07:13:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:51210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726034AbgGOLNU (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 15 Jul 2020 07:13:20 -0400
Received: from localhost (unknown [122.171.202.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21EC220658;
        Wed, 15 Jul 2020 11:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594811600;
        bh=eydGT5vyj3DFkrTR3iGkM6VbuT/mY9iEwObflzBiA5M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uRYxnG5OXQN4sijkPXo4JIQSHo3Qzo2kvJDps2v9dTJ0oqZ96Rea5oLMtoDrybZEf
         YHq/nhv6B7uhMyy7b5+bRM81cLS0YnTrkJlEiNxEi2qoxzVHKehGD6hMe8e5faj4Na
         wjf5BXMWyoj6kPiSBzLZn+xio+Bhagas8hBXFHcQ=
Date:   Wed, 15 Jul 2020 16:43:15 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 04/11] dmaengine: Introduce max SG list entries
 capability
Message-ID: <20200715111315.GK34333@vkoul-mobl>
References: <20200709224550.15539-1-Sergey.Semin@baikalelectronics.ru>
 <20200709224550.15539-5-Sergey.Semin@baikalelectronics.ru>
 <d667adda-6576-623d-6976-30f60ab3c3dc@ti.com>
 <20200710092738.z7zyywe46mp7uuf3@mobilestation>
 <427bc5c8-0325-bc25-8637-a7627bcac26f@ti.com>
 <20200710161445.t6eradkgt4terdr3@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710161445.t6eradkgt4terdr3@mobilestation>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 10-07-20, 19:14, Serge Semin wrote:
> On Fri, Jul 10, 2020 at 02:51:33PM +0300, Peter Ujfalusi wrote:

> > Since we should be able to handle longer lists and this is kind of a
> > hint for clients that above this number of nents the list will be broken
> > up to smaller 'bursts', which when traversing could cause latency.
> > 
> > sg_chunk_len might be another candidate.
> 
> Ok. We've got four candidates:
> - max_sg_nents_burst
> - max_sg_burst
> - max_sg_chain
> - sg_chunk_len
> 
> @Vinod, @Andy, what do you think?

So IIUC your hw supports single sg and in that you would like to publish
the length of each chunk, is that correct? If so sg_chunk_len seems
apt..

-- 
~Vinod
