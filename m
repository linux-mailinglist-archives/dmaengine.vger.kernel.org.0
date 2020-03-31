Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8312D199AAC
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2020 18:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731124AbgCaQDN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 31 Mar 2020 12:03:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:56086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730286AbgCaQDN (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 31 Mar 2020 12:03:13 -0400
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2DAD206CC;
        Tue, 31 Mar 2020 16:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585670593;
        bh=QmepX9l5aviOm56/Qd1UErl4TtadKUX+jP7Va2re9AQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=0sVwBCga3J/rLKdy9JyIO5O7ZsKlYOoRniodTOoMOG9aNX3iAwSu60pSrU4xmcRwT
         61j9uncp6v4T8uRPZf9KDeJSEvkc8Z773mlpc7z1mOOpuizkpncoWsBY+7/QG5ESc1
         wf3KF43VHt3cXWC2q7NzYbpMS2FLuwFpcdrmnN7E=
Date:   Tue, 31 Mar 2020 11:03:09 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     vkoul@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, gregkh@linuxfoundation.org,
        arnd@arndb.de, linux-kernel@vger.kernel.org, x86@kernel.org,
        dmaengine@vger.kernel.org, dan.j.williams@intel.com,
        ashok.raj@intel.com, fenghua.yu@intel.com,
        linux-pci@vger.kernel.org, tony.luck@intel.com, jing.lin@intel.com,
        sanjay.k.kumar@intel.com
Subject: Re: [PATCH 2/6] device/pci: add cmdmem cap to pci_dev
Message-ID: <20200331160309.GA194762@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158560362090.6059.1762280705382158736.stgit@djiang5-desk3.ch.intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Mar 30, 2020 at 02:27:00PM -0700, Dave Jiang wrote:
> Since the current accelerator devices do not have standard PCIe capability
> enumeration for accepting ENQCMDS yet, for now an attribute of pdev->cmdmem has
> been added to struct pci_dev.  Currently a PCI quirk must be used for the
> devices that have such cap until the PCI cap is standardized. Add a helper
> function to provide the check if a device supports the cmdmem capability.
> 
> Such capability is expected to be added to PCIe device cap enumeration in
> the future.

This needs some sort of thumbnail description of what "synchronous
write notification" and "cmdmem" mean.

Do you have a pointer to a PCI-SIG ECR or similar?

Your window size seems to be 85 or so.  It would be easier if you used
80 and wrapped the commit log to fit in 75 columns so it looks decent
when "git log" indents it by 4.
