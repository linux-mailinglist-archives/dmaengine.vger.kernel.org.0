Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2A01756AE
	for <lists+dmaengine@lfdr.de>; Mon,  2 Mar 2020 10:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgCBJOe (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 2 Mar 2020 04:14:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:41560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726390AbgCBJOe (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 2 Mar 2020 04:14:34 -0500
Received: from localhost (unknown [171.76.77.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21AEC246B4;
        Mon,  2 Mar 2020 09:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583140474;
        bh=UbuSb7l91NmV7WlYukEACby2rjjpfKz6X4KPoH9f3fM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qgl+4iy5i1PreV+s3vnOUafNyOnJ2mw0E8QyGLfSNJMSJuo4NMbEOYYjPOI6l1woL
         f2z8sROJFu9dxT15jXYC2GIU+tMG+ltGvpFEnQZs5VMiRZ1XzoJfDZhUHHTjAbm0Pe
         PV7BKBJj8S+f8sIeCAup/0SipYJeeMSiSMeibwH4=
Date:   Mon, 2 Mar 2020 14:44:28 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        dan.j.williams@intel.com, grygorii.strashko@ti.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 0/2] dmaengine: ti: k3-udma: Support for per channel atype
Message-ID: <20200302091428.GI4148@vkoul-mobl>
References: <20200218143126.11361-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218143126.11361-1-peter.ujfalusi@ti.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 18-02-20, 16:31, Peter Ujfalusi wrote:
> Hi,
> 
> The series is on top of the 5.6 update patches:
> https://lore.kernel.org/lkml/20200214091441.27535-1-peter.ujfalusi@ti.com/
> 
> UDMA channels have ATYPE property which tells UDMA on how to treat the pointers
> within descriptors (and TRs).
> The ATYPE defined for j721e are:
> 0: pointers are physical addresses (no translation)
> 1: pointers are intermediate addresses (PVU)
> 2: pointers are virtual addresses (SMMU)
> 
> When Linux is booting within a virtualized environment channels must have the
> ATYPE configured correctly to be able to access memory (ATYPE == 0 is not
> allowed).
> The ATYPE can be different for channels and their ATYPE depends on which
> endpoint they are servicing, but it is not hardwired.
> 
> In order to be able to tell the driver the ATYPE for the channel we need to
> extend the dma-cells in case the device is going to be used in virtualized
> setup.
> 
> Non virtualized setups can still use dma-cells == 1.
> 
> If dma-cells == 2, then the UDMA node must have ti,udma-atype property which
> is used for non slave channels (where no DT binding is exist for a channel).

Applied, thanks

-- 
~Vinod
