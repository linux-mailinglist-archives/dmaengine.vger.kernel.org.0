Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68758199A95
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2020 17:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730556AbgCaP7K (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 31 Mar 2020 11:59:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:54998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730366AbgCaP7J (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 31 Mar 2020 11:59:09 -0400
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FAC820784;
        Tue, 31 Mar 2020 15:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585670349;
        bh=MC//hoYmpd3qlEGsMu8iYoZ2PThwGz9fVupiSVrYrZY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=HOiWYx4IZ1s9HEgZ8OfYARFOozK/4tTbAXPzyTMO+v0kfwUCgxa/w6vhmYoUm9/7Y
         ReryPs4ME1CTx+imawDqJ40nquP+qaGjj18C90VuZ9Po4kiuB2TPqhqOqcc6g37atb
         YZWcMk7gTYYBIwzwQhGbGMl1IbMw7cpRqrY9eXUU=
Date:   Tue, 31 Mar 2020 10:59:06 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     vkoul@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, gregkh@linuxfoundation.org,
        arnd@arndb.de, linux-kernel@vger.kernel.org, x86@kernel.org,
        dmaengine@vger.kernel.org, dan.j.williams@intel.com,
        ashok.raj@intel.com, fenghua.yu@intel.com,
        linux-pci@vger.kernel.org, tony.luck@intel.com, jing.lin@intel.com,
        sanjay.k.kumar@intel.com
Subject: Re: [PATCH 3/6] pci: add PCI quirk cmdmem fixup for Intel DSA device
Message-ID: <20200331155906.GA191980@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158560362665.6059.11999047251277108233.stgit@djiang5-desk3.ch.intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Take a look and make yours match (applies to other patches in the
series as well):

  $ git log --oneline drivers/pci/quirks.c
  299bd044a6f3 ("PCI: Add ACS quirk for Zhaoxin Root/Downstream Ports")
  0325837c51cb ("PCI: Add ACS quirk for Zhaoxin multi-function devices")
  2880325bda8d ("PCI: Avoid ASMedia XHCI USB PME# from D0 defect")
  b88bf6c3b6ff ("PCI: Add boot interrupt quirk mechanism for Xeon chipsets")
  5e89cd303e3a ("PCI: Mark AMD Navi14 GPU rev 0xc5 ATS as broken")
  7b90dfc4873b ("PCI: Add DMA alias quirk for PLX PEX NTB")
  09298542cd89 ("PCI: Add nr_devfns parameter to pci_add_dma_alias()")

There's no need to mention "PCI" twice.  Also no need for both "quirk"
and "fixup".  This is all in the interest of putting more information
in the small space of the subject line.

On Mon, Mar 30, 2020 at 02:27:06PM -0700, Dave Jiang wrote:
> Since there is no standard way that defines a PCI device that receives
> descriptors or commands with synchronous write operations, add quirk to set
> cmdmem for the Intel accelerator device that supports it.
>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/pci/quirks.c |   11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 29f473ebf20f..ba0572b9b9c8 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5461,3 +5461,14 @@ static void quirk_reset_lenovo_thinkpad_p50_nvgpu(struct pci_dev *pdev)
>  DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, 0x13b1,
>  			      PCI_CLASS_DISPLAY_VGA, 8,
>  			      quirk_reset_lenovo_thinkpad_p50_nvgpu);
> +
> +/*
> + * Until the PCI Sig defines a standard capaiblity check that indicates a
> + * device has cmdmem with synchronous write capability, we'll add a quirk
> + * for device that supports it.

s/PCI Sig/PCI-SIG/
s/capaiblity/capability/

It's not clear why this would need to be in drivers/pci/quirks.c as
opposed to being in the driver itself.

> + */
> +static void device_cmdmem_fixup(struct pci_dev *pdev)
> +{
> +	pdev->cmdmem = 1;
> +}
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x0b25, device_cmdmem_fixup);
> 
