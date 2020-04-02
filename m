Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB8A219BCDB
	for <lists+dmaengine@lfdr.de>; Thu,  2 Apr 2020 09:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732660AbgDBHkE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 2 Apr 2020 03:40:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39572 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbgDBHkD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 2 Apr 2020 03:40:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CESjO59OG1g2iBZvOj+yXt5mO6YtOWaC54a1TxGlkL8=; b=Z30JqzSUNPZoOt2Ip4bnmbBTjw
        UQg2tbGxU/lEgV84feDe5/QybUVcca6fABh8FqMRIsfdqnV4ne3XZTXN+XiBi2pRw4ldShMGQx+P2
        /zaEiWN9LLGhcoUb6zsvfwAz7Z+rpJ5xq7FlTKL3GDmaoPdnLn2qDzvp55oybIBd2k2TgFA1ZbnHW
        viqKwsdYp6mUbPp1TwTThX+Iw99NExNUDer8PxWNlGd1pxyUzexiK4wYKCAkpjBWXiinrVPFCrwRv
        WVn+ZPUhbIgbSQMxxbKA0ORwMSYurbBIjj0fZ01T4LQq7M28JhcqXqcDNj2Vu2Egf0t2NG4CJyTnW
        zXf0T31w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jJuRw-0007J8-1O; Thu, 02 Apr 2020 07:39:40 +0000
Date:   Thu, 2 Apr 2020 00:39:40 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, dmaengine@vger.kernel.org,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-pci@vger.kernel.org,
        "Luck, Tony" <tony.luck@intel.com>, Jing Lin <jing.lin@intel.com>,
        Sanjay K Kumar <sanjay.k.kumar@intel.com>
Subject: Re: [PATCH 3/6] pci: add PCI quirk cmdmem fixup for Intel DSA device
Message-ID: <20200402073940.GA27871@infradead.org>
References: <158560290392.6059.16921214463585182874.stgit@djiang5-desk3.ch.intel.com>
 <158560362665.6059.11999047251277108233.stgit@djiang5-desk3.ch.intel.com>
 <20200401071851.GA31076@infradead.org>
 <CAPcyv4iE_-g8ymYe75bLKmVUvTVtp8GJm3xqUoiscbyTxoUnbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4iE_-g8ymYe75bLKmVUvTVtp8GJm3xqUoiscbyTxoUnbQ@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Apr 01, 2020 at 07:20:59PM -0700, Dan Williams wrote:
> On Wed, Apr 1, 2020 at 12:19 AM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Mon, Mar 30, 2020 at 02:27:06PM -0700, Dave Jiang wrote:
> > > Since there is no standard way that defines a PCI device that receives
> > > descriptors or commands with synchronous write operations, add quirk to set
> > > cmdmem for the Intel accelerator device that supports it.
> >
> > Why do we need a quirk for this?  Even assuming a flag is needed in
> > struct pci_dev (and I don't really understand why that is needed to
> > start with), it could be set in ->probe.
> 
> The consideration in my mind is whether this new memory type and
> instruction combination warrants a new __attribute__((noderef,
> address_space(X))) separate from __iomem. If it stays a single device
> concept layered on __iomem then yes, I agree it can all live locally
> in the driver. However, when / if this facility becomes wider spread,
> as the PCI ECR in question is trending, it might warrant general
> annotation.
> 
> The enqcmds instruction does not operate on typical x86 mmio
> addresses, only these special device portals offer the ability to have
> non-posted writes with immediate results in the cpu condition code
> flags.

But that is not what this series does at all.  And I think it makes
sense to wait until it gains adoption to think about a different address
space.  In this series we could just trivially kill patches 2-4 and make
it much easier to understand.
