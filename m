Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C468414784E
	for <lists+dmaengine@lfdr.de>; Fri, 24 Jan 2020 06:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725817AbgAXFtt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 24 Jan 2020 00:49:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:49178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbgAXFtt (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 24 Jan 2020 00:49:49 -0500
Received: from localhost (unknown [106.200.244.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFCC82075D;
        Fri, 24 Jan 2020 05:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579844988;
        bh=nwwG9R53jMJ+nkiOV+lIAlkuJpzg3TfbYmeUeqDPxho=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yi3BAOABMYlFUTCkKu/ewJc2XytURw12W/5fat/WIknoCu78gp1NEgfHhccDRwP3p
         uWfflX8Qh8HIfq2bQMcYIFD8mu91OvPlL3i27ZCmhn/HfKAneOlZV13nnp4GdQSyzr
         gMuUOhACo9gwmVV1xpvkWmSGAOz0AcfgRveZh6gI=
Date:   Fri, 24 Jan 2020 11:19:44 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        dan.j.williams@intel.com, tony.luck@intel.com, jing.lin@intel.com,
        ashok.raj@intel.com, sanjay.k.kumar@intel.com, megha.dey@intel.com,
        jacob.jun.pan@intel.com, yi.l.liu@intel.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, fenghua.yu@intel.com, hpa@zytor.com
Subject: Re: [PATCH v5 0/9] idxd driver for Intel Data Streaming Accelerator
Message-ID: <20200124054944.GB2841@vkoul-mobl>
References: <157965011794.73301.15960052071729101309.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157965011794.73301.15960052071729101309.stgit@djiang5-desk3.ch.intel.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 21-01-20, 16:43, Dave Jiang wrote:
> v5:
> Borislav:
> - Fix header spelling and added Ack.

Applied all, thanks
-- 
~Vinod
