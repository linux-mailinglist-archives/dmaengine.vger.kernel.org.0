Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE825A0F0D
	for <lists+dmaengine@lfdr.de>; Thu, 25 Aug 2022 13:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241541AbiHYL2v (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 25 Aug 2022 07:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241510AbiHYL2u (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 25 Aug 2022 07:28:50 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F99A8978;
        Thu, 25 Aug 2022 04:28:48 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id bq23so18756522lfb.7;
        Thu, 25 Aug 2022 04:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=ce6nbuCEQkfDUN004ii4WQCVHmiLgyyRaVFZyhqjD80=;
        b=Z5zrUdyT8aCtiaWzVuW0/mSNNWZwRt4C5ygbVemwyhfyWrRA6KwPgSF784ayIdPGFX
         O+EqBuPLfkom08Me3zq8LdmYRkhqUUMFv3M7NPUkYtLIZ2pcdE9LtUOXNaUXYQWwkiYS
         M4eoFMVF2qi6VfDFsEguUFH7BDeKm0qPunCOcKmxm5HNgyJVRmsF68KwTipUYVUIA0EO
         g38wy0gy01bhTWjlzLulUHxhrt8jMHgxCP7+8pUJzPD5ii8OcUR1WNh3/VDY95Z3cslh
         DG6SCsc5BWtg9RtorlDk0XJZ9CP3VPKDkEZApsMu+dTpE5v4huxa4UcMfkG6XVFgGggL
         4vOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=ce6nbuCEQkfDUN004ii4WQCVHmiLgyyRaVFZyhqjD80=;
        b=MdTl2AAopA2cTz1qyW140wGDNqq0wVykmDwhj4SM8VcAhWfmbF8/iMU+3Tp6MFFDk7
         WP1p5GXxFO/D8oKWVHBzYa/zNb93puEstNsU+ns3Y6yKd7QyYPOfdHHhoJb9bi14Vp3W
         mskjsd0mQCPiM4/mleXXyb6Twb4GCida72M9vBg8uarUrE8ixRtJeIS3um3cMK3hF4kf
         fLo6yYIbIF1dDP4AEVnv5VnS5cQHr9zkuaHiTYO/TvuI8PK7QF64pq3dTCi26C+1kNUa
         xgL4JsHtjyfXNC+f0QKQafRkWg9GknS10XLNHLqYegtY/rwnbB1XgjFvjwf6Ak/8imzX
         4sTQ==
X-Gm-Message-State: ACgBeo2QrJOb6pz4AVfX0buAcWImvdle20MRUiX0PGzebaa1kIk5/gup
        M2MI3XNu3awRrE/9yuuQJ2g=
X-Google-Smtp-Source: AA6agR40HbbQdfBfjFN4McJl9CrRGzhMvWOmm1n4M5QZIGManIpram1mvaS3rvXVfII0Up+MajzCSw==
X-Received: by 2002:a05:6512:3f4:b0:492:f088:45d0 with SMTP id n20-20020a05651203f400b00492f08845d0mr960600lfq.283.1661426926031;
        Thu, 25 Aug 2022 04:28:46 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id p3-20020ac24ec3000000b0048aeafde9b8sm452718lfr.108.2022.08.25.04.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 04:28:45 -0700 (PDT)
Date:   Thu, 25 Aug 2022 14:28:43 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>, Frank Li <Frank.Li@nxp.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v5 00/24] dmaengine: dw-edma: Add RP/EP local DMA
 controllers support
Message-ID: <20220825112843.4pbh37x6wemsdmmp@mobilestation>
References: <20220822185332.26149-1-Sergey.Semin@baikalelectronics.ru>
 <20220823154526.GB6371@thinkpad>
 <20220824140759.7gg7t53z2xi7jxaj@mobilestation>
 <Ywb9r3f+wSkpk7gY@matsya>
 <20220825050457.esxb4oc6yht5kw6o@mobilestation>
 <Ywc2dOk3ChH8M460@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ywc2dOk3ChH8M460@matsya>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Aug 25, 2022 at 02:14:36PM +0530, Vinod Koul wrote:
> On 25-08-22, 08:04, Serge Semin wrote:
> > On Thu, Aug 25, 2022 at 10:12:23AM +0530, Vinod Koul wrote:
> > > On 24-08-22, 17:07, Serge Semin wrote:
> > > > On Tue, Aug 23, 2022 at 09:15:26PM +0530, Manivannan Sadhasivam wrote:
> > > > > On Mon, Aug 22, 2022 at 09:53:08PM +0300, Serge Semin wrote:
> > > 
> > > > > I've tested this series on Qualcomm SM8450 SoC based dev board. So,
> > > > > 
> > > > > Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > > 
> > > > 
> > > > Thanks.
> > > > 
> > > > > Not sure what is the merging strategy for this one but this series should get
> > > > > merged into a single tree. Since the PCI patch is touching the designware
> > > > > driver, merging the series into dmaengine tree might result in conflict later.
> > > > 
> > > > Right, the series
> > > > [PATCH v5 00/20] PCI: dwc: Add generic resources and Baikal-T1 support
> > > > is supposed to be merged in first. Then this one will get to be
> > > > applied with no conflicts. That's what I imply in the head of the
> > > > cover-letter.
> > > 
> > 
> > > I dont see a dependency of dma patches with PCIe patches? I guess they
> > > could go thru the respective trees now..?
> > 
> > There is a backward dependency: the PCIe patch in this series depends
> > on the eDMA patches and the patches in the patchset #3. So should you
> 

> What is the dependency...? Looking at the patches there does not seem to
> be one...

[PATCH RESEND v5 24/24] PCI: dwc: Add DW eDMA engine support:
|
+-> depends on the modifications done in the framework DW eDMA driver
| patchset, for instance the changes introduced in the patch
| [PATCH RESEND v5 22/24] dmaengine: dw-edma: Bypass dma-ranges mapping for the local setup
| make sure the dma-ranges property isn't taken into account for the
| Local CPU/Application setup (See it makes the DW_EDMA_CHIP_LOCAL flag
| used which is enabled for the eDMA embedded into the DW PCIe EP/RP).
| All the DebugFS-related and channels join updates are also required to
| make the DW eDMA driver working in the framework of the DW PCIe RP/EP
| device.
|
+-> at the very least depends on the changes introduced in the patchset #3:
| [PATCH v5 16/20] PCI: dwc: Introduce generic controller capabilities interface
| [PATCH v5 17/20] PCI: dwc: Introduce generic resources getter
| The patch at consideration adds CSR region request procedure in the
| method created and updated in these two patches.

There might be some other dependencies, but what I cited above must be
enough not to split the patchsets up between different branches
otherwise besides not properly working DW PCIe driver you'll have merge
conflicts.

-Sergey

> 
> > merge the eDMA patches via your tree, the later patch in this series
> > and the patchset #3 would have needed to be applied in there too. So
> > the patches can't be split up between different branches. Seeing all
> > the changes (including the DW eDMA part) concern the PCIe device (DW
> > eDMA is a part of either DW PCIe End-point or Root Port) and we
> > already agreed to merge all the changes via the PCIe tree, I would
> > stick to the previous settled agreement.
> > 
> > -Sergey
> > 
> > > 
> > > -- 
> > > ~Vinod
> 
> -- 
> ~Vinod
