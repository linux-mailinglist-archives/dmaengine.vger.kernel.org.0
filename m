Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9224C2315
	for <lists+dmaengine@lfdr.de>; Thu, 24 Feb 2022 05:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbiBXEjd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 23 Feb 2022 23:39:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiBXEjc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 23 Feb 2022 23:39:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D5C1F7671;
        Wed, 23 Feb 2022 20:39:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BC8A3B82284;
        Thu, 24 Feb 2022 04:39:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE59DC340E9;
        Thu, 24 Feb 2022 04:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645677541;
        bh=oI8CPLC1EMfiXlrbW9XX3rNJjWhgOpqXILFLAUtXfEk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RAcPw6/dV//awrcFH0EeVUFrftlPqNPcP9dKYWzG35eh/dQGhtc194DOktlrZOPY4
         jk6bs16cEX0VvpRoTE3ymKKSJegTQC1r67sy/jtkkSug/Y3vKg795WeafFEaSNaJLH
         5nWKk1JpGjvunXCywJFeQfIsfxmBweYe6i+xYARQRQULTFOtYnHQYzetGexzpaLraV
         LIyl4YeG9jOS86F/+QNZPZB75jI4142e0oG+LnfD5H2izAO20S7Kx7N0zRVluV1rsa
         CYVarERFm1Fu4uB3wLnWTd5IMz57u8fXjimcRm3WCpm4Mmgft+ohHV81UmprlH4rW9
         v8t5j1rRIRXHQ==
Date:   Thu, 24 Feb 2022 10:08:57 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Akhil R <akhilrajeev@nvidia.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        Rajesh Gumasta <rgumasta@nvidia.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Pavan Kunapuli <pkunapuli@nvidia.com>
Subject: Re: [PATCH v20 2/2] dmaengine: tegra: Add tegra gpcdma driver
Message-ID: <YhcL4fBYEWo7kpIS@matsya>
References: <20220221153934.5226-1-akhilrajeev@nvidia.com>
 <20220221153934.5226-3-akhilrajeev@nvidia.com>
 <YhUBt20I471s9Bhv@dev-arch.archlinux-ax161>
 <DM5PR12MB1850EF14473F9F941FB12506C03C9@DM5PR12MB1850.namprd12.prod.outlook.com>
 <YhaAZNaav720xXXx@dev-arch.archlinux-ax161>
 <DM5PR12MB1850C245826D8229E63141A0C03D9@DM5PR12MB1850.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM5PR12MB1850C245826D8229E63141A0C03D9@DM5PR12MB1850.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 24-02-22, 04:23, Akhil R wrote:
> > On Wed, Feb 23, 2022 at 03:49:09AM +0000, Akhil R wrote:

> > > I am getting notification for the below warning also.
> > >
> > > >> drivers/dma/tegra186-gpc-dma.c:898:53: warning: shift count >= width of
> > type [-Wshift-count-overflow]
> > >                            FIELD_PREP(TEGRA_GPCDMA_HIGH_ADDR_DST_PTR, (dest >>
> > 32));
> > > https://lore.kernel.org/all/202202230559.bLOEMEUh-lkp@intel.com/
> > >
> > > I suppose, this is because it is compiled against a different ARCH other than
> > arm64.
> > > For arm64, the dma_addr_t is 64 bytes, and this warning does not occur.
> > > Could this be ignored for now? If not, could you suggest a fix, if possible?
> > 
> > I am not really familiar with the DMA API and dma_addr_t so I am not
> > sure about a proper fix.
> > 
> > You could cast dest to u64 to guarantee it is a type that can be shifted
> > by 32 but that might not be right for CONFIG_PHYS_ADDR_T_64BIT=n. If the
> > driver is not expected to run without CONFIG_PHYS_ADDR_T_64BIT, then
> > this is probably fine.
> > 
> > You could mark this driver 'depends on PHYS_ADDR_T_64BIT' if it cannot
> > run with CONFIG_ARCH_TEGRA=y + CONFIG_PHYS_ADDR_T_64BIT=n but I do
> > not
> > see any other drivers that do that, which might mean that is not a
> > proper fix.
> > 
> > Please do not ignore the warning, as it will show up with ARCH=arm
> > allmodconfig, which has -Werror enabled.
> I see some drivers using 'depends on ARM64'. I guess probably we could
> use that to avoid this warning. The driver is only supported for arm64 Tegra
> systems as of now.

dma_addr_t can be different on different arch so yes this 'can'
overflow, but since this driver would never be used on non ARM64, make
sense to put depends.

-- 
~Vinod
