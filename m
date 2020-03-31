Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E43F19A1FB
	for <lists+dmaengine@lfdr.de>; Wed,  1 Apr 2020 00:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730589AbgCaWeX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 31 Mar 2020 18:34:23 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33770 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727955AbgCaWeW (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 31 Mar 2020 18:34:22 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jJPSQ-0000wr-Sx; Wed, 01 Apr 2020 00:34:07 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 5CA2F103A01; Wed,  1 Apr 2020 00:34:06 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     vkoul@kernel.org, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        gregkh@linuxfoundation.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        dmaengine@vger.kernel.org, dan.j.williams@intel.com,
        ashok.raj@intel.com, fenghua.yu@intel.com,
        linux-pci@vger.kernel.org, tony.luck@intel.com, jing.lin@intel.com,
        sanjay.k.kumar@intel.com
Subject: Re: [PATCH 2/6] device/pci: add cmdmem cap to pci_dev
In-Reply-To: <20200331220006.GA37376@google.com>
References: <20200331220006.GA37376@google.com>
Date:   Wed, 01 Apr 2020 00:34:06 +0200
Message-ID: <87ftdoupb5.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Bjorn Helgaas <helgaas@kernel.org> writes:
> On Tue, Mar 31, 2020 at 10:59:44AM -0700, Dave Jiang wrote:
>> On 3/31/2020 9:03 AM, Bjorn Helgaas wrote:
>> > On Mon, Mar 30, 2020 at 02:27:00PM -0700, Dave Jiang wrote:
>> > > Since the current accelerator devices do not have standard PCIe capability
>> > > enumeration for accepting ENQCMDS yet, for now an attribute of pdev->cmdmem has
>> > > been added to struct pci_dev.  Currently a PCI quirk must be used for the
>> > > devices that have such cap until the PCI cap is standardized. Add a helper
>> > > function to provide the check if a device supports the cmdmem capability.
>> > > 
>> > > Such capability is expected to be added to PCIe device cap enumeration in
>> > > the future.
>> > This needs some sort of thumbnail description of what "synchronous
>> > write notification" and "cmdmem" mean.
>> 
>> I will add more explanation.
>> 
>> > Do you have a pointer to a PCI-SIG ECR or similar?
>> 
>> Deferrable Memory Write (DMWr) ECR
>> 
>> https://members.pcisig.com/wg/PCI-SIG/document/13747
>> 
>> From what I'm told it should be available for public review by EOW.
>
> Please use terminology from the spec instead of things like
> "synchronous write notification".
>
> AIUI, ENQCMDS is an x86 instruction.  That would have no meaning in
> the PCIe domain.
>
> I'm not committing to acking any part of this before the ECR is
> accepted, but if you're adding support for the feature described by
> the ECR, you might as well add support for discovering the DMWr
> capability via Device Capabilities 2 as described in the ECR.

Don't worry. There is nothing to decide and ack before the basic
architecture support for ENQCMD[S] is discussed and accepted. The
patches providing this support have been posted 2 hrs before this pile
hit the mailing lists yesterday.

Thanks,

        tglx

