Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 337FD30D47A
	for <lists+dmaengine@lfdr.de>; Wed,  3 Feb 2021 08:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbhBCH6v (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 3 Feb 2021 02:58:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbhBCH6u (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 3 Feb 2021 02:58:50 -0500
X-Greylist: delayed 424 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 02 Feb 2021 23:58:09 PST
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [IPv6:2a01:4f8:150:2161:1:b009:f23e:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D02C061573
        for <dmaengine@vger.kernel.org>; Tue,  2 Feb 2021 23:58:09 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id B2F08100DA1A7;
        Wed,  3 Feb 2021 08:51:03 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 82B4A22451; Wed,  3 Feb 2021 08:51:03 +0100 (CET)
Date:   Wed, 3 Feb 2021 08:51:03 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 04/15] PCI: Add pci_find_vsec_capability() to find a
 specific VSEC
Message-ID: <20210203075103.GA18742@wunner.de>
References: <cover.1612269536.git.gustavo.pimentel@synopsys.com>
 <2ecb33dfee5dc05efc05de0731b0cb77bc246f54.1612269537.git.gustavo.pimentel@synopsys.com>
 <20210202180855.GA3571@wunner.de>
 <DM5PR12MB18351689BA7312BF9DFDD6FEDAB49@DM5PR12MB1835.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM5PR12MB18351689BA7312BF9DFDD6FEDAB49@DM5PR12MB1835.namprd12.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Feb 03, 2021 at 01:54:49AM +0000, Gustavo Pimentel wrote:
> On Tue, Feb 2, 2021 at 18:8:55, Lukas Wunner <lukas@wunner.de> wrote:
> > As the name implies, the capability is "vendor-specific", so it is
> > perfectly possible that two vendors use the same VSEC ID for different
> > things.
> > 
> > To make sure you're looking for the right capability, you need to pass
> > a u16 vendor into this function and bail out if dev->vendor is different.
> 
> This function will be called by the driver that will pass the correct 
> device which will be already pointing to the config space associated with 
> the endpoint for instance. Because the driver is already attached to the 
> endpoint through the vendor ID and device ID specified, there is no need 
> to do that validation, it will be redundant.

Okay.  Please amend the kernel-doc to make it explicit that it's the
caller's responsibility to check the vendor ID.

Thanks,

Lukas
