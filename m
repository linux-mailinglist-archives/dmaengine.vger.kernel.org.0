Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A31561D4694
	for <lists+dmaengine@lfdr.de>; Fri, 15 May 2020 09:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgEOG6h (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 15 May 2020 02:58:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:32956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726465AbgEOG6h (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 15 May 2020 02:58:37 -0400
Received: from localhost (unknown [122.178.196.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A8CD206F1;
        Fri, 15 May 2020 06:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589525916;
        bh=hUlz/rCkfZ+xgR8DMjnzNDlI1sbpdHErcZSsJkt/seU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1A22I7krsIZihkqwPfAxmtTUF3iKA2KRWFzbmbv1BU0+VUlhk1Kyv+8fqKICg8j9y
         Cjs4kC5ZZfW6vv2hKdXux+tFKprzz0EZSutPWafbt0BHL6jX9qjeZw9zCgoaK/oDB6
         oVPEeYxHfqhyEp6flJG7XqJdUAAaS5Z2GG6lLHug=
Date:   Fri, 15 May 2020 12:28:27 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Amit Tomer <amittomer25@gmail.com>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        dan.j.williams@intel.com, cristian.ciocaltea@gmail.com,
        dmaengine@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-actions@lists.infradead.org
Subject: Re: [PATCH v1 1/9] dmaengine: Actions: get rid of bit fields from
 dma descriptor
Message-ID: <20200515065827.GL333670@vkoul-mobl>
References: <1589472657-3930-1-git-send-email-amittomer25@gmail.com>
 <1589472657-3930-2-git-send-email-amittomer25@gmail.com>
 <20200514182750.GJ14092@vkoul-mobl>
 <CABHD4K8F_sk3Xsevu4pMtR1jEanh5-dSATLYySPKW-nDY9fAvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABHD4K8F_sk3Xsevu4pMtR1jEanh5-dSATLYySPKW-nDY9fAvA@mail.gmail.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 15-05-20, 00:04, Amit Tomer wrote:
> Hi,
> 
> On Thu, May 14, 2020 at 11:58 PM Vinod Koul <vkoul@kernel.org> wrote:
> >
> > On 14-05-20, 21:40, Amit Singh Tomar wrote:
> > > At the moment, Driver uses bit fields to describe registers of the DMA
> > > descriptor structure that makes it less portable and maintainable, and
> > > Andre suugested(and even sketched important bits for it) to make use of
> > > array to describe this DMA descriptors instead. It gives the flexibility
> > > while extending support for other platform such as Actions S700.
> > >
> > > This commit removes the "owl_dma_lli_hw" (that includes bit-fields) and
> > > uses array to describe DMA descriptor.
> >
> > So i see patch 1/9 and 2/9 in my inbox... where are the rest ? No cover
> > to detail out what the rest contains, who should merge them etc etc!

and what is the answer for this..?

> >
> > If you are sending a series to different subsystem please make a habit
> > to CC everyone on cover letter so that we understand details about the
> > series. If not dependent, just send as individual units to subsystems!
> 
> Ok, I would make note of it and Cc everyone on cover letter going forward.
> 
> Thanks
> -Amit

-- 
~Vinod
