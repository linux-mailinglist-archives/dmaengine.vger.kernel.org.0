Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0091D4564
	for <lists+dmaengine@lfdr.de>; Fri, 15 May 2020 07:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgEOFuh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 15 May 2020 01:50:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:51194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbgEOFuh (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 15 May 2020 01:50:37 -0400
Received: from localhost (unknown [122.178.196.30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC26B2054F;
        Fri, 15 May 2020 05:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589521836;
        bh=k015+cPgGFFo+2o33KksJzJrDGM5ILj2xDAoxHV4mb8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i1OJ5v0N6OaLPXwDVBVs8urh0fQB0R8M31Bfhz/zCtZfeRnUGyJaMLRCNWwkhntEl
         dQB4LEV+Vev0nNLngYVd9G+IiBFpOpSQ0U4Ozw3tgth6mS/oECLqiPNPjZgQufEl16
         GNIrXmrLyYkakDpYu9L/YDysQmpf5KNDXd60Kbg4=
Date:   Fri, 15 May 2020 11:20:25 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     =?utf-8?B?UmFmYcWC?= Hibner <rafal.hibner@secom.com.pl>
Cc:     Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>,
        Harini Katakam <harini.katakam@xilinx.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Michal Simek <michal.simek@xilinx.com>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] dma: zynqmp_dma: Move list_del inside
 zynqmp_dma_free_descriptor.
Message-ID: <20200515055025.GA333670@vkoul-mobl>
References: <MW2PR02MB37705416E18413689BFFC7C3C9A60@MW2PR02MB3770.namprd02.prod.outlook.com>
 <20200506102844.2259-1-rafal.hibner@secom.com.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200506102844.2259-1-rafal.hibner@secom.com.pl>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 06-05-20, 12:28, Rafał Hibner wrote:
> List elements are not formally removed from list during zynqmp_dma_reset.

Applied after fixing subsystem name to dmaengine, thanks
-- 
~Vinod
