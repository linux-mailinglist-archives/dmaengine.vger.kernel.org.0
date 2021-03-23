Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE3A5345D45
	for <lists+dmaengine@lfdr.de>; Tue, 23 Mar 2021 12:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbhCWLpv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 23 Mar 2021 07:45:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:54786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229639AbhCWLpe (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 23 Mar 2021 07:45:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D92E5619AE;
        Tue, 23 Mar 2021 11:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616499933;
        bh=2hu9UGUtgkdJtwnfqQeo8bhL0rW57R10fRJ5pWOBPbs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZDw3p3YXA2i2fW4FOSQ8cz94UDMgnZ9lkbl/2nbA60C9twhpl7HLOTkU1jg00QAlg
         bn3w0y1wAjaAE/fpRJddcHrRDVWkKs6b+ZTH7xZeJ2g1DCNmqWBZyT/uX++8xP9HsF
         o2wO3fGIqquVLlU5OiwXxTKs4aNH8KRUwarhYGOIDPFBHKXpfiN5Qm9rH/9aZuE3gu
         2E9//w0w25kSd3f70j62dykSR60aIF1rfk71zj8u8kkS884sSQl6C96Ylo/AP5UHfq
         hPPs/1aIBAwvTkBZ3N0aa0kKT25lIPZILFdR/owYzEjX7X50RZGXjFuoJFhB/xbWi+
         6bENL0CW8qh8g==
Date:   Tue, 23 Mar 2021 17:15:30 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, dmaengine@vger.kernel.org
Subject: Re: [PATCH v7 0/8] idxd 'struct device' lifetime handling fixes
Message-ID: <YFnU2oqNavQEsmNZ@vkoul-mobl.Dlink>
References: <161645534083.2002542.11583610276394664799.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161645534083.2002542.11583610276394664799.stgit@djiang5-desk3.ch.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Dave,

On 22-03-21, 16:31, Dave Jiang wrote:
> v7:
> - Fix up the 'struct device' setup in char device code (Jason)
> - Split out the char dev fixes (Jason)
> - Split out the DMA dev fixes (Dan)
> - Split out the each of the conf_dev fixes
> - Split out removal of the pcim_* calls
> - Split out removal of the devm_* calls
> - Split out the fixes for interrupt config calls
> - Reviewed by Dan.
> 
> v6:
> - Fix char dev initialization issues (Jason)
> - Fix other 'struct device' initialization issues.
> 
> v5:
> - Rebased against 5.12-rc dmaengine/fixes
> v4:
> - fix up the life time of cdev creation/destruction (Jason)
> - Tested with KASAN and other memory allocation leak detections. (Jason)
> 
> v3:
> - Remove devm_* for irq request and cleanup related bits (Jason)
> v2:
> - Remove all devm_* alloc for idxd_device (Jason)
> - Add kref dep for dma_dev (Jason)
> 
> Vinod,
> The series fixes the various 'struct device' lifetime handling in the
> idxd driver. The devm managed lifetime is incompatible with 'struct device'
> objects that resides in the idxd context. Tested with
> CONFIG_DEBUG_KOBJECT_RELEASE and address all issues from that.

Sorry for not looking into this earlier.. But I would like to check on
the direction idxd is taking. Somehow I get the feel the dmaengine is
not the right place for this. Considering that now we have auxdev merged
in, should the idxd be spilt into smaller function and no dmaengine
parts moved away from dmaengine... I think we do lack a subsystem for
all things accelerator in kernel atm...

Dan what do you think about splitting idxd?

Thanks
-- 
~Vinod
