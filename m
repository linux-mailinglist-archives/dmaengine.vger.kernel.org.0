Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D35241515D6
	for <lists+dmaengine@lfdr.de>; Tue,  4 Feb 2020 07:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbgBDGVY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 4 Feb 2020 01:21:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:47478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725834AbgBDGVX (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 4 Feb 2020 01:21:23 -0500
Received: from localhost (unknown [106.200.229.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 849AD2086A;
        Tue,  4 Feb 2020 06:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580797283;
        bh=waTbpnj8XzyIheuqB898WOEZRqq9Gg076SBnBNB35DM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t0PtyeHIyyOSvIvyTz54NHh1iQjnHNCua/MXv9obJNYWx/rlOVV2kZnjWMs8Y2DwZ
         vR23SNKWMH45gsIyCGTQGiIb9drCrJPDORq8ghGflHr+f+5I2MaCNj7mHnNewN+QSB
         +xXccJzg8pkCsS1bT2Ou9uZd28bXLLHG1UVxnhII=
Date:   Tue, 4 Feb 2020 11:51:18 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        dmaengine <dmaengine@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 0/3] dmaengine: Stear users towards
 dma_request_slave_chan()
Message-ID: <20200204062118.GS2841@vkoul-mobl>
References: <20200203101806.2441-1-peter.ujfalusi@ti.com>
 <CAHp75Vf__isc59YBS9=O+9ApSV62XuZ2nBAWKKD_K7i72P-yFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vf__isc59YBS9=O+9ApSV62XuZ2nBAWKKD_K7i72P-yFg@mail.gmail.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 03-02-20, 12:37, Andy Shevchenko wrote:
> On Mon, Feb 3, 2020 at 12:32 PM Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> 
> > dma_request_slave_channel_reason() no longer have user in mainline, it
> > can be removed.
> >
> > Advise users of dma_request_slave_channel() and
> > dma_request_slave_channel_compat() to move to dma_request_slave_chan()
> 
> How? There are legacy ARM boards you have to care / remove before.
> DMAengine subsystem makes a p*s off decisions without taking care of
> (I'm talking now about dma release callback, for example) end users.

Can you elaborate issue you are seeing with dma_release callback?

-- 
~Vinod
