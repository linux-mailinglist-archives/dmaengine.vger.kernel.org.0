Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B913207024
	for <lists+dmaengine@lfdr.de>; Wed, 24 Jun 2020 11:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389015AbgFXJiH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 Jun 2020 05:38:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:43310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388998AbgFXJiH (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 24 Jun 2020 05:38:07 -0400
Received: from localhost (unknown [171.61.66.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA8D720885;
        Wed, 24 Jun 2020 09:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592991486;
        bh=M17U8InxXE8LD18Sq7wr8yn7Yy1fVJiTNteQrj4tOC8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X3Qh6RONQSKJIXovrL6/xEMD1+9sjPy3PjDngBbFY878WMHZ7n0WhKV9ICBsPQeBx
         cK+gzDnn044pdcWiud7CZ0NGtQwTEOA+2mh/XxGezkceR5PZUvu5RlkSbmAuSXRtve
         zLowjzeJdIz7m2kL/u5QyQoQRJjcRl08OvsDqYmc=
Date:   Wed, 24 Jun 2020 15:08:00 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Thomas Ruf <freelancer@rufusul.de>
Cc:     Federico Vaga <federico.vaga@cern.ch>,
        Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: DMA Engine: Transfer From Userspace
Message-ID: <20200624093800.GV2324254@vkoul-mobl>
References: <5614531.lOV4Wx5bFT@harkonnen>
 <fe199e18-be45-cadc-8bad-4a83ed87bfba@intel.com>
 <20200621072457.GA2324254@vkoul-mobl>
 <20200621203634.y3tejmh6j4knf5iz@cwe-513-vol689.cern.ch>
 <20200622044733.GB2324254@vkoul-mobl>
 <419762761.402939.1592827272368@mailbusiness.ionos.de>
 <20200622155440.GM2324254@vkoul-mobl>
 <1835214773.354594.1592843644540@mailbusiness.ionos.de>
 <2077253476.601371.1592991035969@mailbusiness.ionos.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2077253476.601371.1592991035969@mailbusiness.ionos.de>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 24-06-20, 11:30, Thomas Ruf wrote:

> To make it short - i have two questions:
> - what are the chances to revive DMA_SG?

100%, if we have a in-kernel user

> - what are the chances to get my driver for memcpy like transfers from
> user space using DMA_SG upstream? ("dma-sg-proxy")

pretty bleak IMHO.

-- 
~Vinod
