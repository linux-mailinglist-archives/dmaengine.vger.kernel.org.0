Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77F19679C7D
	for <lists+dmaengine@lfdr.de>; Tue, 24 Jan 2023 15:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234038AbjAXOuP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 Jan 2023 09:50:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234994AbjAXOuO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 24 Jan 2023 09:50:14 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730A04B18D;
        Tue, 24 Jan 2023 06:49:48 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id bk15so39573644ejb.9;
        Tue, 24 Jan 2023 06:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jZNhfuLiIKppnrm+67M7BDZaXXkVNd2xGPd+4mpUj2E=;
        b=KZUi+29NsyUymM97gRmKL0eZYXQvnGmkiKTtqqCdQlgKey1GXIlEKMIS7VBV6nYSTw
         sU8mDPqhbl/VUn5H6NXV09tKLS8MbxQgtRB4RBwqjriUdBK7motl4xsxAN2AWmvl+5SP
         dfEMUOQK6xZTuhuTPzYxgIFiBjpfaj5JGF4L0SO+/FmlNB4cwhJ4OJ9FmX1vHmgv107R
         dThE1lsjR0YXnl29b3tf28YyEWeUuBxzs5RNv+wnElitYlhhI+3SjlTbsnMQQxrODirj
         eTXAmDbuvbKifgq8QshK9FmP2bibGYk0HPQwhk2Krs8rNqY9Q2tb6kPOps4HSAi2V/2e
         06sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jZNhfuLiIKppnrm+67M7BDZaXXkVNd2xGPd+4mpUj2E=;
        b=LviQ2LbduuIe2lDjmfWrYiSUuq8Uchq48zWRQtKoa395odFyN01QIxh650phSWDcgq
         XdWMdfHGgrhjEXjECe8xYfW/0dGz3CBddvPQSl0lxRyQDfA+7mCjU9KpnphTMk/A1PiI
         P1Fd0dzU4iMhZMZdboznlOZRQt1iDQftYDo91+GDuO78eSUAtveKAhIMAayQAfMI97m2
         fIwnFRgyv+NcRnVvD6bFm9cjWcNvqhfVDcu4womdpMJac6UXB63V+W3r2GfVORnmmgLn
         C6uQ99WD4fQNhRqVgHWIOUB0ZdLC9yjhYsfqG/ZYf7PqEuc5ODgcJq9ZoWsZP/oPO6pF
         IV9g==
X-Gm-Message-State: AFqh2kqeGxB9n3H+f1FzfOjhPfSq4M1Mn1wLNtV0oEUNcAw/hyxHcYI+
        5vozA2IAh0BqLlB4k6JgIBg=
X-Google-Smtp-Source: AMrXdXtUO3WJ2VXA1mMLyZ3kY95FmdC+A4aDlYqkeZ8PUrJb3A78FiMt8Bt5c0f+SpaUu8P+zTTIQA==
X-Received: by 2002:a17:907:d043:b0:870:2cc7:e8df with SMTP id vb3-20020a170907d04300b008702cc7e8dfmr27265339ejc.8.1674571784895;
        Tue, 24 Jan 2023 06:49:44 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id op18-20020a170906bcf200b0084d494b24dcsm978261ejb.161.2023.01.24.06.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 06:49:44 -0800 (PST)
Date:   Tue, 24 Jan 2023 17:49:41 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Robin Murphy <robin.murphy@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>, Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        caihuoqing <caihuoqing@baidu.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 24/27] dmaengine: dw-edma: Relax driver config settings
Message-ID: <20230124144941.42zpgj2p53nvfz36@mobilestation>
References: <20230122001116.jbhttuaed7zuls26@mobilestation>
 <20230123164339.GA892847@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123164339.GA892847@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Jan 23, 2023 at 10:43:39AM -0600, Bjorn Helgaas wrote:
> On Sun, Jan 22, 2023 at 03:11:16AM +0300, Serge Semin wrote:
> > On Fri, Jan 20, 2023 at 04:50:36PM -0600, Bjorn Helgaas wrote:
> > > On Fri, Jan 13, 2023 at 08:14:06PM +0300, Serge Semin wrote:
> > > > Since the DW PCIe RP/EP driver is about to be updated to register the DW
> > > > eDMA-based DMA-engine the drivers build modes must be synchronized.
> > > > Currently the DW PCIe RP/EP driver is always built as a builtin module.
> > > > Meanwhile the DW eDMA driver can be built as a loadable module. Thus in
> > > > the later case the kernel with DW PCIe controllers support will fail to be
> > > > linked due to lacking the DW eDMA probe/remove symbols. At the same time
> > > > forcibly selecting the DW eDMA driver from the DW PCIe RP/EP kconfig will
> > > > effectively eliminate the tristate type of the former driver fixing it to
> > > > just the builtin kernel module.
> > > > 
> > > > Seeing the DW eDMA engine isn't that often met built into the DW PCIe
> > > > Root-ports and End-points let's convert the DW eDMA driver config to being
> > > > more flexible instead of just forcibly selecting the DW eDMA kconfig. In
> > > > order to do that first the DW eDMA PCIe driver config should be converted
> > > > to being depended from the DW eDMA core config instead of selecting the
> > > > one. Second the DW eDMA probe and remove symbols should be referenced only
> > > > if they are reachable by the caller. Thus the user will be able to build
> > > > the DW eDMA core driver with any type, meanwhile the dependent code will
> > > > be either restricted to the same build type (e.g. DW eDMA PCIe driver if
> > > > DW eDMA driver is built as a loadable module) or just won't be able to use
> > > > the eDMA engine registration/de-registration functionality (e.g. DW PCIe
> > > > RP/EP driver if DW eDMA driver is built as a loadable module).
> > > 
> > > I'm trying to write the merge commit log, and I understand the linking
> > > issue, but I'm having a hard time figuring out what the user-visible
> > > scenarios are here.
> > > 
> > > I assume there's something that works when CONFIG_PCIE_DW=y and
> > > CONFIG_DW_EDMA_PCIE=y but does *not* work when CONFIG_PCIE_DW=y and
> > > CONFIG_DW_EDMA_PCIE=m?
> > 
> > No. The DW eDMA code availability (in other words the CONFIG_DW_EDMA
> > config value) determines whether the corresponding driver (DW PCIe
> > RP/EP or DW eDMA PCI) is capable to perform the eDMA engine probe
> > procedure. Additionally both drivers has the opposite dependency from
> > the DW eDMA code.
> > |                |     DW PCIe RP/EP    |     DW eDMA PCIe     |
> > | CONFIG_DW_EDMA +----------------------+----------------------+
> > |                | Probe eDMA | KConfig | Probe eDMA | Kconfig |
> > +----------------+------------+---------+------------+---------+
> > |        y       |     YES    |   y,n   |     YES    |  y,m,n  |
> > |        m       |     NO     |   y,n   |     YES    |    m,n  |
> > |        n       |     NO     |   y,n   |     NO     |      n  |
> > +--------------------------------------------------------------+
> > 
> > Basically it means the DW PCIe RP/EP driver will be able to probe the
> > DW eDMA engine only if the corresponding driver is built into the
> > kernel. At the same time the DW PCIe RP/EP driver doesn't depend on
> > the DW eDMA core module config state. The DW eDMA PCIe driver in
> > opposite depends on the DW eDMA code config state, but will always be
> > able to probe the DW eDMA engine as long as the corresponding code is
> > loaded as either a part of the kernel or as a loadable module.
> > 
> > > If both scenarios worked the same, I would think the existing
> > > dw_edma_pcie_probe() would be enough, and you wouldn't need to call
> > > dw_pcie_edma_detect() from dw_pcie_host_init() and dw_pcie_ep_init().
> > 
> > No. These methods have been implemented for the absolutely different
> > drivers.
> > dw_edma_pcie_probe() is called for an end-point PCIe-device found on a
> > PCIe-bus.
> > dw_pcie_host_init()/dw_pcie_ep_init() and dw_pcie_edma_detect() are
> > called for a platform-device representing a DW PCIe RP/EP controller.
> > In other words dw_pcie_edma_detect() and dw_edma_pcie_probe() are in
> > no means interchangeable.
> 

> The question is what the user-visible difference between
> CONFIG_DW_EDMA_PCIE=y and CONFIG_DW_EDMA_PCIE=m is. 

There will be no difference between them after this commit is applied
from the DW eDMA core driver point of view. CONFIG_DW_EDMA_PCIE now
depends on the CONFIG_DW_EDMA config state (see it's surrounded by
if/endif in the Kconfig file). Without this patch the
CONFIG_DW_EDMA_PCIE config determines the CONFIG_DW_EDMA config state
by forcibly selecting the one. Using the similar approach for the
CONFIG_PCIE_DW driver I found less attractive because it would have
effectively converted the CONFIG_DW_EDMA config tristate to boolean.

That's why instead I decided to convert the CONFIG_DW_EDMA config to
being independent from any other config value. (See the table in the
my previous email message.)

> If there were no
> difference, dw_pcie_host_init() would not need to call
> dw_pcie_edma_detect().

Even if CONFIG_DW_EDMA (not CONFIG_DW_EDMA_PCIE) is set to m or n I
would have still recommended to call dw_pcie_edma_detect() because the
method performs the DW eDMA engine auto-detection independently from the DW
eDMA driver availability. As a result the system log will have a
number of eDMA detected channels if the engine was really found. It's
up to the system administrator to make sure that the eDMA driver is
properly built/loaded then for the engine to be actually available in
the kernel/system.

> 
> Can you give me a one- or two-sentence merge commit comment that
> explains why we want to merge this?  "Relax driver config settings"
> doesn't tell us that.

"Convert the DW eDMA kconfig to being independently selected by the
user in order to preserve the module build options flexibility and fix
the "undefined reference to" error on DW PCIe driver build."

-Serge(y)

> 
> Bjorn
