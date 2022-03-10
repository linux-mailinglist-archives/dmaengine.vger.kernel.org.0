Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE3F34D44FF
	for <lists+dmaengine@lfdr.de>; Thu, 10 Mar 2022 11:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241490AbiCJKxO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 10 Mar 2022 05:53:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241443AbiCJKxD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 10 Mar 2022 05:53:03 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B263E5D19D;
        Thu, 10 Mar 2022 02:52:00 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id z11so8625472lfh.13;
        Thu, 10 Mar 2022 02:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ehlxZO6HP6oBVOSeNjFQZXVFZH0PFquAat/0g6NFlug=;
        b=nfDL2ZOnuVFVqVn1Ie12pU4naCe/KezvRV/YGrhuywsW6FzQfbZnvsgKG0dKS03Kzy
         xhJ133SnO0EHIddk6KWQm93fAnrwWPvksWei9nDhcgO7rz6It41MYN20EN3atFHM3TPX
         44Ko/PRXyck0z22xmaxS+sUSvoQi/fzsk8S3QUahi1aA2wrbjOwAnnSRp/UWQF70sIUs
         TJcioA9BCJkDVltX6qGXKM0Vw0+3UbbJloVrsv7Hqv8qAcL7MnOLLJ5N38Uh+0h6v9cc
         iYWSSQZG6uGgzWNBliCM9C3Dyzw168p7VufCsxhzh+Takz7hU91GGC9kmZxHKQZTycjX
         uysA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ehlxZO6HP6oBVOSeNjFQZXVFZH0PFquAat/0g6NFlug=;
        b=uNfAWN3PUR3ccoTBOLRHiVrA2mmOeKbOAhgL7itSBWuXJzNSm+H19hmCdQrdNAXfIA
         /FOQajk0QV1AwxqNMe1fp7xcHJU7uJvmq0VvbCI7Z1MW0Uaaq5pDOV32ZBApnfKwuJTv
         AGPVsR7I0ERpMt7Hq1DXDm8zbbamEb1AsCyZobPPtiAxCXhJc6mKZ53WpQGFwQk0p2LZ
         wuOmL3HAdGJWxKZT350mH8kW/zE9gwJYlf35yRdIhr35JnPTB6VxErb+fWe4GIDjmwkm
         0t7WsJ7SaKIv/poFUqLbzquu1FwBgphJN7RqA88S1iV6s09dXr9dRco+iGM4IrhzMekr
         L7fA==
X-Gm-Message-State: AOAM533mk/WU69MzHifSBrcwb+hS58M0oGhJIpZ+hS4cMgaRLQLUFdnN
        PU8IN/L0/ZwP3PmStbfGe/E=
X-Google-Smtp-Source: ABdhPJxXVjQ1cSmlC0bt14adSjyyfBVscqnpfni278dGh3cxiYp4TvOuIzCXCNthgZLuYzagIfu5hA==
X-Received: by 2002:a05:6512:3f90:b0:446:6b95:24aa with SMTP id x16-20020a0565123f9000b004466b9524aamr2739464lfa.610.1646909518832;
        Thu, 10 Mar 2022 02:51:58 -0800 (PST)
Received: from mobilestation ([95.79.188.22])
        by smtp.gmail.com with ESMTPSA id v12-20020a056512096c00b00443c40a6a4csm910810lft.134.2022.03.10.02.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 02:51:57 -0800 (PST)
Date:   Thu, 10 Mar 2022 13:51:31 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Frank Li <Frank.Li@nxp.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        lznuaa@gmail.com, vkoul@kernel.org, lorenzo.pieralisi@arm.com,
        robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        shawnguo@kernel.org
Subject: Re: [PATCH v3 1/6] dmaengine: dw-edma: fix dw_edma_probe() can't be
 call globally
Message-ID: <20220310105131.3eyzyqsrhltpzcco@mobilestation>
References: <20220307224750.18055-1-Frank.Li@nxp.com>
 <20220309133940.3le2ma24aqlhips4@mobilestation>
 <20220309181233.GC134091@thinkpad>
 <20220309190123.dnivojpqhl52o5vc@mobilestation>
 <20220310062242.GB4869@thinkpad>
 <20220310084112.2vhvvnl6pmlkfg36@mobilestation>
 <20220310085632.GE4869@thinkpad>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3zh36tssarhxvq3y"
Content-Disposition: inline
In-Reply-To: <20220310085632.GE4869@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


--3zh36tssarhxvq3y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 10, 2022 at 02:26:32PM +0530, Manivannan Sadhasivam wrote:
> On Thu, Mar 10, 2022 at 11:41:12AM +0300, Serge Semin wrote:
> > On Thu, Mar 10, 2022 at 11:52:42AM +0530, Manivannan Sadhasivam wrote:
> > > On Wed, Mar 09, 2022 at 10:01:23PM +0300, Serge Semin wrote:
> > > 
> > > [...]
> > > 
> > > > > I'm afraid that this will not work for all cases (unless I miss something). As
> > > > > Zhi Li pointed out, there are places where only chip pointer will be passed and
> > > > > we'd need to extract the private data (dw_edma) from it.
> > > > > 
> > > > > Tbh I also considered your idea but because of the above mentioned issue and
> > > > > also referring to other implementations like gpiochip, I settled with Frank's
> > > > > idea of copying the fields.
> > > > 
> > > > What places are these? I see the only obstacle is the dw_edma_remove()
> > > > method. But it's easily fixable.
> > > 
> > > Yeah, right. I overlooked that part.
> > > 
> > > > Except that, everything else is more
> > > > or less straightforward (just a few methods need to have prototypes
> > > > converted to accepting dw_edma instead dw_edma_chip).
> > > > 
> > > > In order to make the code design more coherent, we need to split up
> > > > private data and device/platform info. As I see it dw_edma_chip is
> > > > nothing but a chip info data. The eDMA driver is supposed to mainly
> > > > use and pass it's private data, not the platform info. It will greatly
> > > > improve the code readability and maintainability. Such approach will
> > > > also prevent a temptation of adding new private data fields into the
> > > > dw_edma_chip structure since reaching the pointer to dw_edma will be
> > > > much easier that getting the dw_edma_chip data. In this case
> > > > dw_edma_chip will be something like i2c_board_info in i2c.
> > > > 
> > > > Ideally dw_edma_chip could be a temporarily defined device info, which
> > > > memory after the dw_edma_probe() method invocation could be freed. But
> > > > in order to implement that we'd need a bit more modifications
> > > > introduced.
> > > > 
> > > 
> > 
> > > While at it, we should also consider adding an ops structure for passing the
> > > callbacks from controller drivers. Currently the eDMA driver has the callbacks
> > > defined in v0-core.c but it is used directly instead of as a callback.
> > 
> > Are you saying about DBI/Native IOs? If so seems reasonable. Though in
> > my case it isn't required.) The only problem was a dword-aligned access,
> > which has been created in the DW eDMA driver by default.
> > 
> 
> It is not causing any problem but it doesn't look correct to me.
> 

> Btw, do you have a patch for DWORD access? If so, please share. We are also
> facing the problem and like to see how to are handling it.

There are two types of accessors DW PCIe Host/EP driver defines:
CFG-space and DBI interface. Both of them can be implemented either
with default IO methods, or redefined by the particular platform.
In addition to that the CFG-space IOs are split up into two types:
host/EP own CFG-space and others (peripheral devices) CFG-spaces. In
my case the dword-aligned access is supposed to be performed only for
the DBI-interface and host CFG-space (which basically turns to be
the same registers space). The driver has a bug in this matter, which
I fixed with a patch attached to this email. After that patch is
applied the only thing you'll need is to redefine the
dw_pcie_ops.{read_dbi,write_dbi,write_dbi2} callbacks with the
platform specific ones, which would make sure IOs are dword aligned.
Like this:

static int bt1_pcie_read_mmio(void __iomem *addr, int size, u32 *val)
{       
        unsigned int ofs = (uintptr_t)addr & 0x3;
        
        if (!IS_ALIGNED((uintptr_t)addr, size))
                return PCIBIOS_BAD_REGISTER_NUMBER;
        
        *val = readl(addr - ofs) >> ofs * BITS_PER_BYTE;
        if (size == 4) {
                return PCIBIOS_SUCCESSFUL;
        } else if (size == 2) {
                *val &= 0xffff;
                return PCIBIOS_SUCCESSFUL;
        } else if (size == 1) {
                *val &= 0xff;
                return PCIBIOS_SUCCESSFUL;
        }
        
        return PCIBIOS_BAD_REGISTER_NUMBER;
}

static int bt1_pcie_write_mmio(void __iomem *addr, int size, u32 val)
{       
        unsigned int ofs = (uintptr_t)addr & 0x3;
        u32 tmp, mask;
        
        if (!IS_ALIGNED((uintptr_t)addr, size))
                return PCIBIOS_BAD_REGISTER_NUMBER;
        
        if (size == 4) {
                writel(val, addr);
                return PCIBIOS_SUCCESSFUL; 
        } else if (size == 2 || size == 1) {
                mask = GENMASK(size * BITS_PER_BYTE - 1, 0);
                tmp = readl(addr - ofs) & ~(mask << ofs * BITS_PER_BYTE);
                tmp |= (val & mask) << ofs * BITS_PER_BYTE;
                writel(tmp, addr - ofs);
                return PCIBIOS_SUCCESSFUL;
        }

        return PCIBIOS_BAD_REGISTER_NUMBER;
}

Regarding the peripheral devices CFG-space IOs. I didn't fix it there
since in my case there were no problems with iATU outbound windows.
DBI slave and iATU slave interfaces works differently. The latter in
my case permits non-dword-aligned IOs.

If you are experiencing problems with all the PCIe memory accesses
(not only DBI-space/host CFG-space, but the whole iATU outbound IOs),
then there won't be easy solution for that other than somehow fixing the
read{b,w,l(})/write{b,w,l}() platform-specific internals. In a way so they
would differentiate PCIe and normal MMIO IOs and make sure all of them
are properly aligned. Alternatively you can fix each particular
peripheral device driver. It isn't that good option though.

Regarding DW eDMA driver. It doesn't have the problem in this matter,
since it is designed to call readl/writel methods only for the
controller setups. They are dword-aligned.

Regarding attached patch and my work. I'll send it out after Frank
finishes his eDMA patchset review, since other than the attached patch
I've got some more useful fixes, which need to be rebased on top of the
Frank' work.

-Sergey

> 
> Thanks,
> Mani
> 
> > -Sergey
> > 
> > > 
> > > This should anyway needs to be fixed when another version of the IP get's added.
> > > 
> > > Thanks,
> > > Mani

--3zh36tssarhxvq3y
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-PCI-dwc-Don-t-use-generic-IO-ops-for-DBI-space-acces.patch"

From 0262b9f32ac2626f4febfa56e6a7f9270a363713 Mon Sep 17 00:00:00 2001
From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Date: Thu, 23 Dec 2021 14:43:54 +0300
Subject: [PATCH] PCI: dwc: Don't use generic IO-ops for DBI-space access

Commit c2b0c098fbd1 ("PCI: dwc: Use generic config accessors") replaced
the locally defined DW PCIe host controller config-space accessors with
the generic methods pci_generic_config_read() and
pci_generic_config_write(). It was intended that the corresponding
bus-mapping callback returned a correct virtual address of the passed PCI
config-space register. The problem of the proposed solution was that it
didn't take into account the way the host config-space is accessed on the
DW PCIe. Depending on the DW PCIe IP-core synthesize parameters different
interfaces can be used to access the host and peripheral config/memory
spaces. The former one can be accessed via the DBI interface, while the
later ones is reached via the AHB/AXI application bus. In case if the DW
PCIe controller is configured to have a dedicated DBI interface, the way
it is mapped into the IO-memory turns to be platform-specific. For such
setups the DWC PCIe driver provides a set of the callbacks
dw_pcie_ops.{read_dbi,write_dbi} so the platforms glue-drivers would be
able to take into account the DBI bus IO peculiarities. Since commit
c2b0c098fbd1 ("PCI: dwc: Use generic config accessors") these methods
haven't been utilized during the generic host initialization performed by
the PCIe subsystem code.

I don't really know how come there have been no problems spotted for the
Histb/Exynos/Kirin PCIe controllers so far, but in our case with dword
aligned IO requirement the generic config-space accessors can't be
utilized for the host config-space. Thus in order to make sure the host
config-space is properly accessed via the DBI bus let's get back the
dw_pcie_rd_own_conf() and dw_pcie_wr_own_conf() methods. They are going to
be just wrappers around the already defined
dw_pcie_read_dbi()/dw_pcie_write_dbi() functions with proper arguments
conversion. These methods perform the platform-specific config-space IO if
the DBI accessors are specified, otherwise they call normal MMIO
operations.

Fixes: c2b0c098fbd1 ("PCI: dwc: Use generic config accessors")
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 .../pci/controller/dwc/pcie-designware-host.c | 34 +++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 6beccc195cab..03fb2650c825 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -527,10 +527,40 @@ void __iomem *dw_pcie_own_conf_map_bus(struct pci_bus *bus, unsigned int devfn,
 }
 EXPORT_SYMBOL_GPL(dw_pcie_own_conf_map_bus);
 
+static int dw_pcie_rd_own_conf(struct pci_bus *bus, unsigned int devfn,
+			       int where, int size, u32 *val)
+{
+	struct pcie_port *pp = bus->sysdata;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+
+	if (PCI_SLOT(devfn) > 0) {
+		*val = ~0U;
+		return PCIBIOS_DEVICE_NOT_FOUND;
+	}
+
+	*val = dw_pcie_read_dbi(pci, where, size);
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int dw_pcie_wr_own_conf(struct pci_bus *bus, unsigned int devfn,
+			       int where, int size, u32 val)
+{
+	struct pcie_port *pp = bus->sysdata;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+
+	if (PCI_SLOT(devfn) > 0)
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
+	dw_pcie_write_dbi(pci, where, size, val);
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
 static struct pci_ops dw_pcie_ops = {
 	.map_bus = dw_pcie_own_conf_map_bus,
-	.read = pci_generic_config_read,
-	.write = pci_generic_config_write,
+	.read = dw_pcie_rd_own_conf,
+	.write = dw_pcie_wr_own_conf,
 };
 
 void dw_pcie_setup_rc(struct pcie_port *pp)
-- 
2.35.1


--3zh36tssarhxvq3y--
