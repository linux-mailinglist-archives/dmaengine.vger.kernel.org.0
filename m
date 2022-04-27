Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D514D511D34
	for <lists+dmaengine@lfdr.de>; Wed, 27 Apr 2022 20:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243635AbiD0RFH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 27 Apr 2022 13:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243766AbiD0RFG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 27 Apr 2022 13:05:06 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552472649;
        Wed, 27 Apr 2022 10:01:53 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id x52so527583pfu.11;
        Wed, 27 Apr 2022 10:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vcgfc5u4bDFWxNJaAqHPlJFUprPyui+gsBymYYXpejg=;
        b=n+ONCgeyEWbWj6JImS9mr3BHBgu98M4V5V8CwY5eamLGOQEtSpo57Z9EhtUKrApzfI
         5LR/Xnn0HB/vfxqC3hKuAiC+5xa7ZHql5ly67byduD4fD39DgNEcTk74ZHPeL0Syowwc
         aFrg1sR+T7bG/V21xKzDEHzFhycy1+M9dBmTP900A+keoEPPxTaYwZZL3U1Cc8e7ySAr
         miSvb1M3x48j1sR6TgqbrMViq5du62oxu3eZTi4G0AfJjjmWCClsDpH5fex73Hfg/RGB
         RVt3p/4ukpE0lSUP//AzXWaNDVUxzT2cTraA5XsP6MZANr2Hn7zChQY+u45WHNMAUwsl
         hPTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vcgfc5u4bDFWxNJaAqHPlJFUprPyui+gsBymYYXpejg=;
        b=ICyVA0YS/yGLe5Azkz1X9/Z6kHckpAmugh99KF2/ewxG3v/R4TUw+3PKvwvqh2QZEF
         mc0DUSOz7uAlI/4v78Im6h2J2a8OJn5BgqLunoLwXeAd8aaKH4oSZaWxWrcW7mJzEsal
         4+iRJQfbQZi8qu+WhOaxEdiFC1yVL5fgG9d47i9tHN/EGeqvUbyhxwWye+xbVkcNLMd8
         zXgFXvmFjH8cE8zCPOHrTl52WKnpAuwuy3dBTSfIBpMSGd+b+pP/XqsqnJNJ/lcguGYd
         5O2jEYr/9gRIj/VNVmjDeLMzYatKdLLCGw9clAzCsxe4erBXztNMO+xsZWXQtUNczBr4
         r8Rg==
X-Gm-Message-State: AOAM533MvvFo+b/mffds1odXv+TckoYxdRk9vg8zh9o9bI+rgAHb4Iu1
        8ZdcOtx6kzaq/vxC6LEi3uEFn9piybVPTJ1/8rs=
X-Google-Smtp-Source: ABdhPJyBOGwjSQJWr8Ex4AIiWgUsaTgtQpXJN2H+3rqDcu+ad5aOpw3PQtidiKq7r+FqqclS0YQi93Bl/SUIo5T7kQY=
X-Received: by 2002:a63:fd04:0:b0:3aa:6473:1859 with SMTP id
 d4-20020a63fd04000000b003aa64731859mr24989439pgh.151.1651078912721; Wed, 27
 Apr 2022 10:01:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220422143643.727871-1-Frank.Li@nxp.com> <20220422143643.727871-10-Frank.Li@nxp.com>
 <YmkNRnkKo/UQT5uX@lpieralisi>
In-Reply-To: <YmkNRnkKo/UQT5uX@lpieralisi>
From:   Zhi Li <lznuaa@gmail.com>
Date:   Wed, 27 Apr 2022 12:01:40 -0500
Message-ID: <CAHrpEqTp6BrUSGqaRZ6wMxHsGttLrqrd+yVKm2xghnQ0RZG0oA@mail.gmail.com>
Subject: Re: [PATCH v9 9/9] PCI: endpoint: Add embedded DMA controller test
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Frank Li <Frank.Li@nxp.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        hongxing.zhu@nxp.com, Lucas Stach <l.stach@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>, linux-pci@vger.kernel.org,
        dmaengine@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Apr 27, 2022 at 4:30 AM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Fri, Apr 22, 2022 at 09:36:43AM -0500, Frank Li wrote:
> > Designware provided eDMA support in controller. This enabled use
> > this eDMA controller to transfer data.
> >
> > The whole flow align with standard DMA usage module
> >
> > 1. Using dma_request_channel() and filter function to find correct
> > RX and TX Channel.
> > 2. dmaengine_slave_config() config remote side physcial address.
> > 3. using dmaengine_prep_slave_single() create transfer descriptor
> > 4. tx_submit();
> > 5. dma_async_issue_pending();
> >
> > Tested at i.MX8DXL platform.
> >
> > root@imx8qmmek:~# /usr/bin/pcitest -d -w
> > WRITE ( 102400 bytes):          OKAY
> > root@imx8qmmek:~# /usr/bin/pcitest -d -r
> > READ ( 102400 bytes):           OKAY
> >
> > WRITE => Size: 102400 bytes DMA: YES  Time: 0.000180145 seconds Rate: 555108 KB/s
> > READ => Size: 102400 bytes  DMA: YES  Time: 0.000194397 seconds Rate: 514411 KB/s
> >
> > READ => Size: 102400 bytes  DMA: NO   Time: 0.013532597 seconds Rate: 7389 KB/s
> > WRITE => Size: 102400 bytes DMA: NO   Time: 0.000857090 seconds Rate: 116673 KB/s
> >
>
> You should rewrite this commit log.
>
> 1) this is not Designware specific
> 2) On what platforms you tested is information for a cover letter but
>    not very useful for a commit log
> 3) The commit log describes why you need the patch and what the patch
>    does.
>    It can be a one liner: "Enable DMA controller tests for endpoints with
>    DMA capabilities". Or something along those lines.

How about write as below

PCI: endpoint: Enable DMA controller tests for endpoints with DMA capabilities

Some Endpoints controllers have DMA capabilities.  This DMA controller has more
efficiency then a general external DMA controller.  And this DMA
controller can bypass
outbound memory address translation unit.

The whole flow use standard DMA usage module

1. Using dma_request_channel() and filter function to find correct
 RX and TX Channel. if not exist,  failure back to try allocate
general DMA controller
channel.
 2. dmaengine_slave_config() config remote side physcial address.
 3. using dmaengine_prep_slave_single() create transfer descriptor
 4. tx_submit();
 5. dma_async_issue_pending();
 .
best regards
Frank Li
>
> Lorenzo
>
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > Change from v6 to v9:
> >  - none
> > Change from v5 to v6:
> >  - change subject
> > Change from v4 to v5:
> >  - none
> > Change from v3 to v4:
> >  - reverse Xmas tree order
> >  - local -> dma_local
> >  - change error message
> >  - IS_ERR -> IS_ERR_OR_NULL
> >  - check return value of dmaengine_slave_config()
> > Change from v1 to v2:
> >  - none
> >
> >  drivers/pci/endpoint/functions/pci-epf-test.c | 108 ++++++++++++++++--
> >  1 file changed, 98 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> > index 90d84d3bc868f..f26afd02f3a86 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> > @@ -52,9 +52,11 @@ struct pci_epf_test {
> >       enum pci_barno          test_reg_bar;
> >       size_t                  msix_table_offset;
> >       struct delayed_work     cmd_handler;
> > -     struct dma_chan         *dma_chan;
> > +     struct dma_chan         *dma_chan_tx;
> > +     struct dma_chan         *dma_chan_rx;
> >       struct completion       transfer_complete;
> >       bool                    dma_supported;
> > +     bool                    dma_private;
> >       const struct pci_epc_features *epc_features;
> >  };
> >
> > @@ -105,12 +107,15 @@ static void pci_epf_test_dma_callback(void *param)
> >   */
> >  static int pci_epf_test_data_transfer(struct pci_epf_test *epf_test,
> >                                     dma_addr_t dma_dst, dma_addr_t dma_src,
> > -                                   size_t len)
> > +                                   size_t len, dma_addr_t dma_remote,
> > +                                   enum dma_transfer_direction dir)
> >  {
> > +     struct dma_chan *chan = (dir == DMA_DEV_TO_MEM) ? epf_test->dma_chan_tx : epf_test->dma_chan_rx;
> > +     dma_addr_t dma_local = (dir == DMA_MEM_TO_DEV) ? dma_src : dma_dst;
> >       enum dma_ctrl_flags flags = DMA_CTRL_ACK | DMA_PREP_INTERRUPT;
> > -     struct dma_chan *chan = epf_test->dma_chan;
> >       struct pci_epf *epf = epf_test->epf;
> >       struct dma_async_tx_descriptor *tx;
> > +     struct dma_slave_config sconf = {};
> >       struct device *dev = &epf->dev;
> >       dma_cookie_t cookie;
> >       int ret;
> > @@ -120,7 +125,22 @@ static int pci_epf_test_data_transfer(struct pci_epf_test *epf_test,
> >               return -EINVAL;
> >       }
> >
> > -     tx = dmaengine_prep_dma_memcpy(chan, dma_dst, dma_src, len, flags);
> > +     if (epf_test->dma_private) {
> > +             sconf.direction = dir;
> > +             if (dir == DMA_MEM_TO_DEV)
> > +                     sconf.dst_addr = dma_remote;
> > +             else
> > +                     sconf.src_addr = dma_remote;
> > +
> > +             if (dmaengine_slave_config(chan, &sconf)) {
> > +                     dev_err(dev, "DMA slave config fail\n");
> > +                     return -EIO;
> > +             }
> > +             tx = dmaengine_prep_slave_single(chan, dma_local, len, dir, flags);
> > +     } else {
> > +             tx = dmaengine_prep_dma_memcpy(chan, dma_dst, dma_src, len, flags);
> > +     }
> > +
> >       if (!tx) {
> >               dev_err(dev, "Failed to prepare DMA memcpy\n");
> >               return -EIO;
> > @@ -148,6 +168,23 @@ static int pci_epf_test_data_transfer(struct pci_epf_test *epf_test,
> >       return 0;
> >  }
> >
> > +struct epf_dma_filter {
> > +     struct device *dev;
> > +     u32 dma_mask;
> > +};
> > +
> > +static bool epf_dma_filter_fn(struct dma_chan *chan, void *node)
> > +{
> > +     struct epf_dma_filter *filter = node;
> > +     struct dma_slave_caps caps;
> > +
> > +     memset(&caps, 0, sizeof(caps));
> > +     dma_get_slave_caps(chan, &caps);
> > +
> > +     return chan->device->dev == filter->dev
> > +             && (filter->dma_mask & caps.directions);
> > +}
> > +
> >  /**
> >   * pci_epf_test_init_dma_chan() - Function to initialize EPF test DMA channel
> >   * @epf_test: the EPF test device that performs data transfer operation
> > @@ -158,10 +195,44 @@ static int pci_epf_test_init_dma_chan(struct pci_epf_test *epf_test)
> >  {
> >       struct pci_epf *epf = epf_test->epf;
> >       struct device *dev = &epf->dev;
> > +     struct epf_dma_filter filter;
> >       struct dma_chan *dma_chan;
> >       dma_cap_mask_t mask;
> >       int ret;
> >
> > +     filter.dev = epf->epc->dev.parent;
> > +     filter.dma_mask = BIT(DMA_DEV_TO_MEM);
> > +
> > +     dma_cap_zero(mask);
> > +     dma_cap_set(DMA_SLAVE, mask);
> > +     dma_chan = dma_request_channel(mask, epf_dma_filter_fn, &filter);
> > +     if (IS_ERR_OR_NULL(dma_chan)) {
> > +             dev_info(dev, "Failed to get private DMA channel. Falling back to generic one\n");
> > +             goto fail_back_tx;
> > +     }
> > +
> > +     epf_test->dma_chan_rx = dma_chan;
> > +
> > +     filter.dma_mask = BIT(DMA_MEM_TO_DEV);
> > +     dma_chan = dma_request_channel(mask, epf_dma_filter_fn, &filter);
> > +
> > +     if (IS_ERR(dma_chan)) {
> > +             dev_info(dev, "Failed to get private DMA channel. Falling back to generic one\n");
> > +             goto fail_back_rx;
> > +     }
> > +
> > +     epf_test->dma_chan_tx = dma_chan;
> > +     epf_test->dma_private = true;
> > +
> > +     init_completion(&epf_test->transfer_complete);
> > +
> > +     return 0;
> > +
> > +fail_back_rx:
> > +     dma_release_channel(epf_test->dma_chan_rx);
> > +     epf_test->dma_chan_tx = NULL;
> > +
> > +fail_back_tx:
> >       dma_cap_zero(mask);
> >       dma_cap_set(DMA_MEMCPY, mask);
> >
> > @@ -174,7 +245,7 @@ static int pci_epf_test_init_dma_chan(struct pci_epf_test *epf_test)
> >       }
> >       init_completion(&epf_test->transfer_complete);
> >
> > -     epf_test->dma_chan = dma_chan;
> > +     epf_test->dma_chan_tx = epf_test->dma_chan_rx = dma_chan;
> >
> >       return 0;
> >  }
> > @@ -190,8 +261,17 @@ static void pci_epf_test_clean_dma_chan(struct pci_epf_test *epf_test)
> >       if (!epf_test->dma_supported)
> >               return;
> >
> > -     dma_release_channel(epf_test->dma_chan);
> > -     epf_test->dma_chan = NULL;
> > +     dma_release_channel(epf_test->dma_chan_tx);
> > +     if (epf_test->dma_chan_tx == epf_test->dma_chan_rx) {
> > +             epf_test->dma_chan_tx = NULL;
> > +             epf_test->dma_chan_rx = NULL;
> > +             return;
> > +     }
> > +
> > +     dma_release_channel(epf_test->dma_chan_rx);
> > +     epf_test->dma_chan_rx = NULL;
> > +
> > +     return;
> >  }
> >
> >  static void pci_epf_test_print_rate(const char *ops, u64 size,
> > @@ -280,8 +360,14 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test)
> >                       goto err_map_addr;
> >               }
> >
> > +             if (epf_test->dma_private) {
> > +                     dev_err(dev, "Cannot transfer data using DMA\n");
> > +                     ret = -EINVAL;
> > +                     goto err_map_addr;
> > +             }
> > +
> >               ret = pci_epf_test_data_transfer(epf_test, dst_phys_addr,
> > -                                              src_phys_addr, reg->size);
> > +                                              src_phys_addr, reg->size, 0, DMA_MEM_TO_MEM);
> >               if (ret)
> >                       dev_err(dev, "Data transfer failed\n");
> >       } else {
> > @@ -363,7 +449,8 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test)
> >
> >               ktime_get_ts64(&start);
> >               ret = pci_epf_test_data_transfer(epf_test, dst_phys_addr,
> > -                                              phys_addr, reg->size);
> > +                                              phys_addr, reg->size,
> > +                                              reg->src_addr, DMA_DEV_TO_MEM);
> >               if (ret)
> >                       dev_err(dev, "Data transfer failed\n");
> >               ktime_get_ts64(&end);
> > @@ -453,8 +540,9 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
> >               }
> >
> >               ktime_get_ts64(&start);
> > +
> >               ret = pci_epf_test_data_transfer(epf_test, phys_addr,
> > -                                              src_phys_addr, reg->size);
> > +                                              src_phys_addr, reg->size, reg->dst_addr, DMA_MEM_TO_DEV);
> >               if (ret)
> >                       dev_err(dev, "Data transfer failed\n");
> >               ktime_get_ts64(&end);
> > --
> > 2.35.1
> >
