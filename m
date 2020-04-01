Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A291719A617
	for <lists+dmaengine@lfdr.de>; Wed,  1 Apr 2020 09:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731990AbgDAHTK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 1 Apr 2020 03:19:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51338 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731680AbgDAHTK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 1 Apr 2020 03:19:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DM+6RxETreG8jB5Z0zci89++MHvAKVEobq5nZmICl/c=; b=gORYbjMus4htMoDTAC8/xZT6YR
        BspCS44KNO4g1DsJ01wK5gSuMijhW/RmGsOmyf1cciiATdaVBh1w3SP9Dosj/doF8A25BZ9oX64jO
        3HZ7M+0n6bOIn6tSSyr+kQfNFZhgiUZtNfYwcrrOlgELf166+yAacQdpBiQCqPAsKrrloqyCS3ca6
        XPF+G9ajmocQ1s+5aL2Rn0J9CPxZQl5EG984gcjpKa06M6euPkElzWkONAuarPlRt18e/AmK8VOF+
        K7p4l+WDG4meHvbYgFsEYqTx0WV5kSFB54CjJRnJl8M9ZS8oqtOxhusCFYTGJepEQdS0Sh7Skko3B
        VSrrXOjw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jJXeF-0002WY-Tr; Wed, 01 Apr 2020 07:18:51 +0000
Date:   Wed, 1 Apr 2020 00:18:51 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     vkoul@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, bhelgaas@google.com,
        gregkh@linuxfoundation.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        dmaengine@vger.kernel.org, dan.j.williams@intel.com,
        ashok.raj@intel.com, fenghua.yu@intel.com,
        linux-pci@vger.kernel.org, tony.luck@intel.com, jing.lin@intel.com,
        sanjay.k.kumar@intel.com
Subject: Re: [PATCH 3/6] pci: add PCI quirk cmdmem fixup for Intel DSA device
Message-ID: <20200401071851.GA31076@infradead.org>
References: <158560290392.6059.16921214463585182874.stgit@djiang5-desk3.ch.intel.com>
 <158560362665.6059.11999047251277108233.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158560362665.6059.11999047251277108233.stgit@djiang5-desk3.ch.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Mar 30, 2020 at 02:27:06PM -0700, Dave Jiang wrote:
> Since there is no standard way that defines a PCI device that receives
> descriptors or commands with synchronous write operations, add quirk to set
> cmdmem for the Intel accelerator device that supports it.

Why do we need a quirk for this?  Even assuming a flag is needed in
struct pci_dev (and I don't really understand why that is needed to
start with), it could be set in ->probe.
