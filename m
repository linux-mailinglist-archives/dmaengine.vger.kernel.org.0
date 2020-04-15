Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 687931AADFC
	for <lists+dmaengine@lfdr.de>; Wed, 15 Apr 2020 18:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1415759AbgDOQY4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Apr 2020 12:24:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:38026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1415762AbgDOQYz (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 15 Apr 2020 12:24:55 -0400
Received: from localhost (unknown [106.201.106.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D34A206F9;
        Wed, 15 Apr 2020 16:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586967894;
        bh=VNf/81wGGP9FODB264florKWG9yMJhCSe3hdtUgQsa0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qOyXs0gOfxldG4hj8gpqpa2saBVLrrzKlGHkW39UGS2+XQwfgOLk0te3LFWdJ9JWq
         k72prXZTA1TI0Kzegxa/2Amc4JunKvzHskHRe+snNbLsZLb+wwRXm1HBpKzzE2/QS7
         XwmJsMk4m0MZBOrHQGVpKYvpr9uxpomMwNmNWoEY=
Date:   Wed, 15 Apr 2020 21:54:46 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org
Subject: Re: [PATCH v2] dmaengine: idxd: export hw version through sysfs
Message-ID: <20200415162446.GB72691@vkoul-mobl>
References: <158696714008.39484.13401950732606906479.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158696714008.39484.13401950732606906479.stgit@djiang5-desk3.ch.intel.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 15-04-20, 09:13, Dave Jiang wrote:
> Some user apps would like to know the hardware version in order to
> determine the variation of the hardware. Export the hardware version number
> to userspace via sysfs.

Applied, thanks

-- 
~Vinod
