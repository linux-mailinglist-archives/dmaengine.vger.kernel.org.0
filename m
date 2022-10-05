Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EECF65F51FD
	for <lists+dmaengine@lfdr.de>; Wed,  5 Oct 2022 11:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiJEJrv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 5 Oct 2022 05:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiJEJru (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 5 Oct 2022 05:47:50 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDBA6B158;
        Wed,  5 Oct 2022 02:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664963269; x=1696499269;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=SzOBLgxHKniFgGvjcnsU55f0FumWPhC2D5ITWHrm9t4=;
  b=U4XxL666HYOAZhQiYwgeN0pYswvmvMXvtcwdQwjLyeXYORI5RZSMY6l1
   f1rJmAxsfnJv/YOdXfmS2CTs6Zz8hsjEz2ZBMTCyEev35aH8q5IcMb89u
   i3byXXtKmpRd8tT5y3lAnADbDn/BzQSLPQpc3j9HRQQMSxSEpubEyY1aH
   reBt36D7C4Xl+Pob9dWI+4Tgp3SXCRMQpIGHMmgikHAgDF78uN3bxaYo0
   MtSYOIo5AsuhxUmy6O/1ipWvGK20B4dnwU2GUxPANKpsWwZjMNPrvzqlC
   7IC9T7Q67G+2XDrSKQC1pCL13oEiOdPvvs+udzHb5H4eRV/pu4kpUSGjh
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="329533895"
X-IronPort-AV: E=Sophos;i="5.95,159,1661842800"; 
   d="scan'208";a="329533895"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 02:47:48 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10490"; a="749699117"
X-IronPort-AV: E=Sophos;i="5.95,159,1661842800"; 
   d="scan'208";a="749699117"
Received: from mtantera-mobl3.ger.corp.intel.com (HELO refaase-MOBL1.ger.corp.intel.com) ([10.252.39.164])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 02:47:45 -0700
Date:   Wed, 5 Oct 2022 12:47:42 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Lizhi Hou <lizhi.hou@amd.com>
cc:     vkoul@kernel.org, dmaengine@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, trix@redhat.com,
        tumic@gpxsee.org, max.zhen@amd.com, sonal.santan@amd.com,
        larry.liu@amd.com, brian.xu@amd.com
Subject: Re: [PATCH V5 XDMA 1/2] dmaengine: xilinx: xdma: Add xilinx xdma
 driver
In-Reply-To: <a0ab26b3-be2d-c1d6-e8ea-3ab9ad57962b@amd.com>
Message-ID: <ad41afcb-a7b1-bfd9-56af-6f5b7875de8d@linux.intel.com>
References: <1664409507-64079-1-git-send-email-lizhi.hou@amd.com> <1664409507-64079-2-git-send-email-lizhi.hou@amd.com> <6ba2221c-bbc9-a33c-7e62-85c2d87ceeed@linux.intel.com> <56f971da-5116-58dc-2df6-53ed465c8ec4@amd.com> <c86fb070-9d46-9558-f7ee-216fc657cf1a@linux.intel.com>
 <a0ab26b3-be2d-c1d6-e8ea-3ab9ad57962b@amd.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-886140070-1664963268=:1580"
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-886140070-1664963268=:1580
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 4 Oct 2022, Lizhi Hou wrote:

> 
> On 10/4/22 09:43, Ilpo Järvinen wrote:
> > On Tue, 4 Oct 2022, Lizhi Hou wrote:
> > 
> > > On 10/4/22 01:18, Ilpo Järvinen wrote:
> > > > On Wed, 28 Sep 2022, Lizhi Hou wrote:
> > > > 
> > > > > Add driver to enable PCIe board which uses XDMA (the DMA/Bridge
> > > > > Subsystem
> > > > > for PCI Express). For example, Xilinx Alveo PCIe devices.
> > > > >       https://www.xilinx.com/products/boards-and-kits/alveo.html
> > > > > 
> > > > > The XDMA engine support up to 4 Host to Card (H2C) and 4 Card to Host
> > > > > (C2H)
> > > > > channels. Memory transfers are specified on a per-channel basis in
> > > > > descriptor linked lists, which the DMA fetches from host memory and
> > > > > processes. Events such as descriptor completion and errors are
> > > > > signaled
> > > > > using interrupts. The hardware detail is provided by
> > > > >       https://docs.xilinx.com/r/en-US/pg195-pcie-dma/Introduction
> > > > > 
> > > > > This driver implements dmaengine APIs.
> > > > >       - probe the available DMA channels
> > > > >       - use dma_slave_map for channel lookup
> > > > >       - use virtual channel to manage dmaengine tx descriptors
> > > > >       - implement device_prep_slave_sg callback to handle host scatter
> > > > > gather
> > > > >         list
> > > > >       - implement device_config to config device address for DMA
> > > > > transfer
> > > > > 
> > > > > Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> > > > > Signed-off-by: Sonal Santan <sonal.santan@amd.com>
> > > > > Signed-off-by: Max Zhen <max.zhen@amd.com>
> > > > > Signed-off-by: Brian Xu <brian.xu@amd.com>
> > > > > ---
> > > > > +	*chans = devm_kzalloc(&xdev->pdev->dev, sizeof(**chans) *
> > > > > (*chan_num),
> > > > > +			      GFP_KERNEL);
> > > > > +	if (!*chans)
> > > > > +		return -ENOMEM;
> > > > > +
> > > > > +	for (i = 0, j = 0; i < pdata->max_dma_channels; i++) {
> > > > > +		ret = xdma_read_reg(xdev, base + i * XDMA_CHAN_STRIDE,
> > > > > +				    XDMA_CHAN_IDENTIFIER,
> > > > > &identifier);
> > > > > +		if (ret) {
> > > > > +			xdma_err(xdev, "failed to read channel id:
> > > > > %d", ret);
> > > > > +			return ret;
> > > > > +		}
> > > > Is it ok to not rollback the allocation in case of an error occurs?
> > > In this loop, the failures are returned by read/write registers. The
> > > read/write register failure indicates serious hardware issue and the
> > > hardware
> > > may not be rollback in this situation.
> > What I meant is that you allocated memory above (to *chans, see above).
> > Shouldn't that memory be free in case the hw is not working before you
> > return the error from this function?
> > 
> > Check also the other returns below for the same problemx.
> 
> The memory does not need to be freed immediately. And it should not be memory
> leak because devm_* is used.

Ah, sorry. I think I checked exactly that there wasn't m in it but 
clearly there is now that I recheck.


-- 
 i.

--8323329-886140070-1664963268=:1580--
