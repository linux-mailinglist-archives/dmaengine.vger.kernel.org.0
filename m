Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2792F283031
	for <lists+dmaengine@lfdr.de>; Mon,  5 Oct 2020 07:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725857AbgJEFp5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 5 Oct 2020 01:45:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:50270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbgJEFp4 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 5 Oct 2020 01:45:56 -0400
Received: from localhost (unknown [171.61.67.142])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 822D820795;
        Mon,  5 Oct 2020 05:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601876756;
        bh=4wXKrAm4LmWP+MX9nM3ErKUXb9+vggWVvupKW3/kZYs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yre/emjTTF4MrLbMdLWc70CMONsCWlVuzSlgbaRPUWMRWs26R9PoEz42TQZ89aspn
         dc6V7TdT5tV/023IkOrTKZ6bWXDg8luhmrmc6CMAUhnLDVtjUlvhRwfsNp8vTFBqUC
         RkPDyIAx65Clh9lpQhqX4xkztlp4OgGyPZ4hmJn4=
Date:   Mon, 5 Oct 2020 11:15:52 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dan.j.williams@intel.com, tony.luck@intel.com, jing.lin@intel.com,
        ashok.raj@intel.com, sanjay.k.kumar@intel.com,
        fenghua.yu@intel.com, kevin.tian@intel.com,
        David.Laight@aculab.com, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/5] dmaengine: idxd: Clean up descriptors with fault
 error
Message-ID: <20201005054552.GN2968@vkoul-mobl>
References: <20200924180041.34056-1-dave.jiang@intel.com>
 <20200924180041.34056-5-dave.jiang@intel.com>
 <20201005044213.GF2968@vkoul-mobl>
 <47c6fa6b-8bbe-ee9d-e6e0-b27d8828a6d9@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47c6fa6b-8bbe-ee9d-e6e0-b27d8828a6d9@intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 04-10-20, 21:55, Dave Jiang wrote:
> > > +static bool process_fault(struct idxd_desc *desc, u64 fault_addr)
> > > +{
> > > +	if ((u64)desc->hw == fault_addr ||
> > > +	    (u64)desc->completion == fault_addr) {
> > 
> > you are casting descriptor address and completion, I can understand
> > former, but later..? Can you explain this please
> > 
> 
> It is possible to fail on the completion writeback address if the completion
> address programmed into the descriptor is bad.

Okay thanks for clarifying, maybe would help to add a comment.

-- 
~Vinod
