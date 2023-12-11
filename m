Return-Path: <dmaengine+bounces-439-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D57080C834
	for <lists+dmaengine@lfdr.de>; Mon, 11 Dec 2023 12:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAEFA1F21806
	for <lists+dmaengine@lfdr.de>; Mon, 11 Dec 2023 11:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1C0374DA;
	Mon, 11 Dec 2023 11:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MHY8QewY"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDE62AF13
	for <dmaengine@vger.kernel.org>; Mon, 11 Dec 2023 11:40:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EC12C433C8;
	Mon, 11 Dec 2023 11:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702294857;
	bh=5I0PYKVYM7syKP7JCpCzQG2R4ozPV4d953nCGoVm7Qc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MHY8QewYlY5P5h7xtAty4w70caY2eAemqXWDaem4ihpf0udcp1AGjQ8CJd+0P2Z+H
	 6dFyezMHK0Q5fKGDuoRBXC0LNOxWXG+pbx2C8zRxOTGdfSiK/xCn38jxa4KAIjx0pu
	 FnbuzBKl0Gtar/m4aOQhIY19VB8gtYkrrTjwV/1QQYHakllRcgnXvqbmmmfnzca65j
	 ec0bxle9JdPn42qF8uCK62vdAuDzGpMQocyMpb50gn58+jlbCQPUK6j49NH97yHqlF
	 hbS+mG4Oj0ZbQt/bb8n5zqqLeCyYsoJT6AoeSE/cJTg1Pwd0tMWAlws4RXU5uwQHo4
	 E6LydrTH76M3Q==
Date: Mon, 11 Dec 2023 17:10:53 +0530
From: Vinod Koul <vkoul@kernel.org>
To: liu kaiwei <liukaiwei086@gmail.com>
Cc: Kaiwei Liu <kaiwei.liu@unisoc.com>, Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, Wenming Wu <wenming.wu@unisoc.com>
Subject: Re: [PATCH 1/2] dmaengine: sprd: delete enable opreation in probe
Message-ID: <ZXb1RWaFWHVDx1wV@matsya>
References: <20231102121623.31924-1-kaiwei.liu@unisoc.com>
 <ZWCg9hmfvexyn7xK@matsya>
 <CAOgAA6FzZ4q=rdmh8ySJRhojkGCgyV4PVjT6JAOUix+CF9PFtw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOgAA6FzZ4q=rdmh8ySJRhojkGCgyV4PVjT6JAOUix+CF9PFtw@mail.gmail.com>

On 06-12-23, 17:32, liu kaiwei wrote:
> On Fri, Nov 24, 2023 at 9:11 PM Vinod Koul <vkoul@kernel.org> wrote:
> >
> > On 02-11-23, 20:16, Kaiwei Liu wrote:
> > > From: "kaiwei.liu" <kaiwei.liu@unisoc.com>
> >
> > Typo is subject line
> >
> > >
> > > In the probe of dma, it will allocate device memory and do some
> > > initalization settings. All operations are only at the software
> > > level and don't need the DMA hardware power on. It doesn't need
> > > to resume the device and set the device active as well. here
> > > delete unnecessary operation.
> >
> > Don't you need to read or write to the device? Without enable that wont
> > work right?
> >
> 
> Yes, it doesn't need to read or write to the device in the probe of DMA.
> We will enable the DMA when allocating the DMA channel.

So you will probe even if device is not present! I think it makes sense
to access device registers in probe!

-- 
~Vinod

