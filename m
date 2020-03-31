Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42B8819A187
	for <lists+dmaengine@lfdr.de>; Wed,  1 Apr 2020 00:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730677AbgCaWAJ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 31 Mar 2020 18:00:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:50748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730589AbgCaWAJ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 31 Mar 2020 18:00:09 -0400
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C49E2080C;
        Tue, 31 Mar 2020 22:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585692009;
        bh=uFEXfr40AqoZXAxCEJwdvVfv+OabBqG3OZjMDRScCaQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=vzrV6sPZ7Ml571IhMEX3RIQ4QoKtnw5U+ou6jXlEpDBlmYIn++dHrH1UzlXqf8US2
         JRBcYAuOthBeXYNqjpqW2GWHaDbntt4itk83r9fGLcXGv0WxTOlNXY1pidG/SCgPJJ
         x9vXF1do6BeUn9+xDOyxvX5jIrWCrITmJ/+T+yAg=
Date:   Tue, 31 Mar 2020 17:00:06 -0500
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
Message-ID: <20200331220006.GA37376@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d798a7eb-ceb0-d81e-5422-f9e41058a098@intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Mar 31, 2020 at 10:59:44AM -0700, Dave Jiang wrote:
> On 3/31/2020 9:03 AM, Bjorn Helgaas wrote:
> > On Mon, Mar 30, 2020 at 02:27:00PM -0700, Dave Jiang wrote:
> > > Since the current accelerator devices do not have standard PCIe capability
> > > enumeration for accepting ENQCMDS yet, for now an attribute of pdev->cmdmem has
> > > been added to struct pci_dev.  Currently a PCI quirk must be used for the
> > > devices that have such cap until the PCI cap is standardized. Add a helper
> > > function to provide the check if a device supports the cmdmem capability.
> > > 
> > > Such capability is expected to be added to PCIe device cap enumeration in
> > > the future.
> > This needs some sort of thumbnail description of what "synchronous
> > write notification" and "cmdmem" mean.
> 
> I will add more explanation.
> 
> > Do you have a pointer to a PCI-SIG ECR or similar?
> 
> Deferrable Memory Write (DMWr) ECR
> 
> https://members.pcisig.com/wg/PCI-SIG/document/13747
> 
> From what I'm told it should be available for public review by EOW.

Please use terminology from the spec instead of things like
"synchronous write notification".

AIUI, ENQCMDS is an x86 instruction.  That would have no meaning in
the PCIe domain.

I'm not committing to acking any part of this before the ECR is
accepted, but if you're adding support for the feature described by
the ECR, you might as well add support for discovering the DMWr
capability via Device Capabilities 2 as described in the ECR.

If you have hardware that supports DMWr but doesn't advertise it via
Device Capabilities 2, you can always have a quirk that works around
that lack.
