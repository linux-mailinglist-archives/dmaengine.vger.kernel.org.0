Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64BFA3E2BFD
	for <lists+dmaengine@lfdr.de>; Fri,  6 Aug 2021 15:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235086AbhHFNyO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 6 Aug 2021 09:54:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:49790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234514AbhHFNyM (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 6 Aug 2021 09:54:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BB6D060F70;
        Fri,  6 Aug 2021 13:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628258036;
        bh=VcCl1R8lK1ZTEFaUIf4y5H5DPXIvlRIVYe0RIpCUjVk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n/j5EeDe3Rx1SdOZez9dN5GtF4E2lhFpfo4iwOMSvjYlQx9iPVD7+uXbZN5q38umm
         I0Lxz4bnRFP2wat4EGf1KThhJs5k+0gnyHb7+AFKRr+lSkMs95k1nTLJw7n6i/6pz/
         r527K8hPzYdQ5B8a7GBmbyHKWVS2V7QxPfne3txehCkMrAxSHw+YGJ6Q4ps6M7UsFh
         OTtYMGiJY8M6qF+3dggO1Q9hKhEzq8pEB5Di/btVcG1v3TIaAsFXA3GL3aCSQr6L7v
         Ui94RSHE334TNSy3H9L1a2rupyEmubaKhTFtINfBh76OPqZgfic1VGYut6CsvsMKbL
         E8dyeGWVYVmkw==
Date:   Fri, 6 Aug 2021 19:23:52 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: idxd: clear block on fault flag when clear wq
Message-ID: <YQ0+8J7+hHD5+SHm@matsya>
References: <162803023553.3086015.8158952172068868803.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162803023553.3086015.8158952172068868803.stgit@djiang5-desk3.ch.intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 03-08-21, 15:37, Dave Jiang wrote:
> The block on fault flag is not cleared when we disable or reset wq. This
> causes it to remain set if the user does not clear it on the next
> configuration load. Add clear of flag in dxd_wq_disable_cleanup()
> routine.

Applied, thanks

-- 
~Vinod
