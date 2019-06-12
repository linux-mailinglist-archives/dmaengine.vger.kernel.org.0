Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56F054203D
	for <lists+dmaengine@lfdr.de>; Wed, 12 Jun 2019 11:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391039AbfFLJGM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 12 Jun 2019 05:06:12 -0400
Received: from mga12.intel.com ([192.55.52.136]:45733 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390115AbfFLJGL (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 12 Jun 2019 05:06:11 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jun 2019 02:06:11 -0700
X-ExtLoop1: 1
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.145])
  by fmsmga007.fm.intel.com with ESMTP; 12 Jun 2019 02:06:10 -0700
Received: from andy by smile with local (Exim 4.92)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1hazCs-00071U-Ag; Wed, 12 Jun 2019 12:06:10 +0300
Date:   Wed, 12 Jun 2019 12:06:10 +0300
From:   "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>
To:     "Kwong, Jonathan" <jon.kwong@intel.com>
Cc:     dmaengine@vger.kernel.org
Subject: Re: dmatest
Message-ID: <20190612090610.GY9224@smile.fi.intel.com>
References: <EF270728DE298848811674C591B01D3D62FB5515@FMSMSX108.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EF270728DE298848811674C591B01D3D62FB5515@FMSMSX108.amr.corp.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

+Cc: DMA engine *public* mailing list, be careful with details

On Tue, Jun 11, 2019 at 10:50:12PM +0000, Kwong, Jonathan wrote:
> Is there some equivalent of dmatest, that handles Mem to MMIO, and MMIO to Mem, please ?

It would be nice to have, though it is tough to achieve since each hardware
requires quite different way to be programmed, besides the fact of DMA req and
DMA ack wires to be connected between DMA engine and hardware in question.
Raw transfer to some MMIO doesn't make any sense and may even be harmful.

Thus, the driver of actual DMA user *is* the test suite at the same time. We
usually are using SPI to test DMA functionality because it's easy to setup and
there are plenty of tools to test transfers in loopback mode.

-- 
With Best Regards,
Andy Shevchenko


