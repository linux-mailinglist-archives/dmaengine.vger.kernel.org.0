Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 565AE523D34
	for <lists+dmaengine@lfdr.de>; Wed, 11 May 2022 21:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346464AbiEKTMx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 11 May 2022 15:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345686AbiEKTMw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 11 May 2022 15:12:52 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830BF737A5;
        Wed, 11 May 2022 12:12:50 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id t5so3630990edw.11;
        Wed, 11 May 2022 12:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3uzK29iYJTvDTVRda9NakAnnspLjzcAKbKtofwnI2fc=;
        b=BiAxVjAh3uR8nOts58m9jbAlcY4G9EPccU1iBeSe+uRn9TAofdH7t0Uo7yVDRz9zDE
         jcOzu7vNqRitUI0DFAyawKPrCdgbTOEDNayhYbC1311JLUDTPnWU39b0VIQRWqQ9kR7l
         A3Zg+ePAvjBw5Nrd+8/7CA99gU8d4JvgdbIFGu5tLjpUreeT4c0mZFbo1hOXn62UUPR6
         i9uCki/j2Bc6KfeBUxagBPoGWdyrBVbV7E/0/gGwJt7Ndscops/ySGLzplpQT16nQ5lT
         u1TLP6hOp3iQ0UgOS2LhtsipYjaY2sRaTrrn9680Oe0sVIPlLo0WPRam09La9GMAyjmi
         FrIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3uzK29iYJTvDTVRda9NakAnnspLjzcAKbKtofwnI2fc=;
        b=E3irInswqeD00hOIX0wNkMvBeh6OW9lMfRfv/Rs9/sF0qdq6sIKruzBARqy+pFgWIi
         eyGx9gb3eIrWyv5mINvDIVrVGW/TIWz9uwWmTumulLD7dmz2l3zw7GnkchVourpsi+pC
         ZKw/qOUxAXTtpZbskODsE9sGEV+A2VrOD092ptKpkyAunfUuOk5t/sUQRfWjPac1ed9N
         yySaMy3SuXG7de8VjwOQPzxacX9Ae+GRuW2WxbHhXXxRQkZ20xjgGXaesusc8/jiWqlo
         mPOOqljicmVx853P2Erfl89Zor5MPNpa4u7MWChqAj/1XdZWF1S/Pyu3uAfdAfJ6lQrQ
         6Cmw==
X-Gm-Message-State: AOAM533AnHI2TqbN8w3cEztr91GCVrZHwBsTapSc4qUgPTR8AavUSZyO
        B/jKF5FMe39jeSoLH7m/hkGNTfPgnADlpsyKNFxlI9wg0Ty9ygn3
X-Google-Smtp-Source: ABdhPJzs9OPPzNGK0vPRxWROYexho4rTaKFZGTBwfzmoBvGkIF8wvUZLYs7ksYtr9eI/w6NOKK8bS4tPyf307dNEhaI=
X-Received: by 2002:a50:cd08:0:b0:426:1d9b:4b13 with SMTP id
 z8-20020a50cd08000000b004261d9b4b13mr30790039edi.360.1652296368767; Wed, 11
 May 2022 12:12:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220503005801.1714345-1-Frank.Li@nxp.com> <20220503005801.1714345-10-Frank.Li@nxp.com>
 <YnuBtEhttgxBrZD4@lpieralisi> <CAHrpEqTv+QF6QFTAoL8Qd6TNqxc+yXCBaF9xi84MXv1TPxJ9ig@mail.gmail.com>
 <YnvyrSTAxJmGxful@lpieralisi>
In-Reply-To: <YnvyrSTAxJmGxful@lpieralisi>
From:   Zhi Li <lznuaa@gmail.com>
Date:   Wed, 11 May 2022 14:12:37 -0500
Message-ID: <CAHrpEqSHO5aSQWYBqsuwFdQ16aD2dxJKbj99FirA6VtyFzWdxA@mail.gmail.com>
Subject: Re: [PATCH v10 9/9] PCI: endpoint: Enable DMA controller tests for
 endpoints with DMA capabilities
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
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Kishon Vijay Abraham I <kishon@ti.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, May 11, 2022 at 12:30 PM Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Wed, May 11, 2022 at 11:18:20AM -0500, Zhi Li wrote:
> > On Wed, May 11, 2022 at 4:28 AM Lorenzo Pieralisi
> > <lorenzo.pieralisi@arm.com> wrote:
> > >
> > > [+Kishon]
> > >
> > > On Mon, May 02, 2022 at 07:58:01PM -0500, Frank Li wrote:
> > > > Some Endpoints controllers have DMA capabilities.  This DMA controller has
> > > > more efficiency then a general external DMA controller.  And this DMA
> > > > controller can bypass outbound memory address translation unit.
> > >
> > > I am sorry to be pedantic but which DMA controller ?
> > >
> > > Do you mean "DMA controllers embedded in Endpoint controllers" ?
> >
> > Yes.
> >
> > >
> > > This is a bit vague and overall you are patching pci-epf-test.c,
> > > that's the change that has to be explained.
> > >
> > > If Kishon can have a look that would be greatly appreciated too.
> > >
> > > When we agree on a proper commit log I can ACK the patch, the whole
> > > series can then go via the DMA engine tree.
> >
> > How about the below commit message? Is it clear?
>
> It is better but I have some suggestions below.
>
> > PCI: endpoint: Enable DMA controller tests for endpoints with DMA
> > capabilities
>
> "PCI: endpoint: Enable DMA tests for endpoints with DMA capabilities"
>
> > Some PCI Endpoints controllers integrate an eDMA (embedded DMA).
> > eDMA has more efficiency than a general DMA controller.
>
> What does "has more efficiency" means ? You mean it can bypass the
> memory translation unit ?

Generally Memory to memory DMA work as
 - DMA read from DDR into DMA controller FIFO,  AXI Read
 - DMA write to PCI space from DMA controller FIFO, AXI write
 - PCI EP controller converts AXI write to PCI TLP into PCI bus.

EP eDMA works as
 - eDMA read from DDR,
 - Convert PCI TLP into PCI bus.

a AXI write operator saved. so I think efficiency is higher than general DMA.

>
> > And eDMA can bypass
>
> Don't start a sentence with "And".
>
> > outbound memory address translation unit to access all RC memory space.
> >
> > This patch added eDMA support for pci-epf-test.
>
> "Add eDMA support for pci-epf-test".
>
> This patch is doing more than this though, doesn't it ?
>
> I would write (always use imperative statements):
>
> "Add DMA support for pci-epf-test.
>
> EPF endpoints can use, depending on HW availability, eDMA or general
> system DMA controllers to perform DMA.
>
> The test probes the EPF DMA channel capabilities."
>
> Then you can add the description below.
>
> >   - Separate DMA channel to TX and RX. eDMA channels have higher priority than
> >  general DMA channels.  If general memory to memory DMA channels are used,
> >  RX and TX channels are equal.
>
> What does "are equal" mean ? By the way, please remove double spaces

RX = TX.

> after a period. If you need to start a new paragraph add a new line.
>
> >  -  Add dma_addr_t dma_remote in in function
> > pci_epf_test_data_transfer() because
> > eDMA using remote RC physical address directly
> > -  Add enum dma_transfer_direction dir in function
> > pci_epf_test_data_transfer() because
> > eDMA chooses the correct RX/TX channel by dir.
> >
> > The overall steps are
> >
> >  1. Using dma_request_channel() and filter function to find correct
>
> s/Using/Execute
>
> >     eDMA RX and TX Channel. if channel not exist,  fallback to try allocate
>
> "If a channel does not exist"
>
> >     general memory to memory DMA  channel.
> >  2. Using dmaengine_slave_config() config remote side physical address.
>
> s/Using/Execute - "to configure remote"
>
> >  3. Using dmaengine_prep_slave_single() create transfer descriptor.
>
> s/Using/Execute - "to create"
>
>
> >  4. tx_submit();
>
> Execute tx_submit()
>
> >  5. dma_async_issue_pending();
>
> Execute dma_async_issue_pending()
>
> Overall, all you need to do describe is what the patch does, hopefully
> the comments above can help.

Updated commit message:

PCI: endpoint: Enable DMA tests for endpoints with DMA capabilities

Some PCI Endpoints controllers integrate an eDMA (embedded DMA).
eDMA only sends once a bus read/write command to complete once
data transfer. eDMA can bypass the outbound memory address translation
unit to access all RC memory space.

Add DMA support for pci-epf-test.

EPF test can use, depending on HW availability, eDMA or general system DMA
controllers to perform DMA. The test probes the EPF DMA channel capabilities.

Separate dma_chan to dma_chan_tx and dma_chan_rx. eDMA channels have
higher priority than general DMA channels. If general memory to memory DMA
hannels are used, dma_chan_rx = dma_chan_tx.

Add dma_addr_t dma_remote in in function pci_epf_test_data_transfer() because
eDMA using remote RC physical address directly

Add enum dma_transfer_direction dir in function pci_epf_test_data_transfer()
because eDMA chooses the correct RX/TX channel by dir.

The overall steps are

1. Execute dma_request_channel() and filter function to find correct eDMA
RX and TX Channel. If a channel does not exist,  fallback to try to allocate
general memory to memory DMA  channel.
2. Execute dmaengine_slave_config() to configure remote side physical address.
3. Execute dmaengine_prep_slave_single() to create transfer descriptor.
4. Execute tx_submit().
5. Execute  dma_async_issue_pending()




>
> Thanks,
> Lorenzo
>
> > > Thanks,
> > > Lorenzo
> > >
> > > >
> > > > The whole flow use standard DMA usage module
> > > >
> > > >  1. Using dma_request_channel() and filter function to find correct
> > > >     RX and TX Channel. if not exist,  fallback to try allocate
> > > >     general DMA controller channel.
> > > >  2. dmaengine_slave_config() config remote side physcial address.
> > > >  3. using dmaengine_prep_slave_single() create transfer descriptor.
> > > >  4. tx_submit();
> > > >  5. dma_async_issue_pending();
> > > >
> > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > ---
> > > > Change from v9 to v10:
> > > >  - rewrite commit message
> > > > Change from v4 to v9:
> > > >  - none
> > > > Change from v3 to v4:
> > > >  - reverse Xmas tree order
> > > >  - local -> dma_local
> > > >  - change error message
> > > >  - IS_ERR -> IS_ERR_OR_NULL
> > > >  - check return value of dmaengine_slave_config()
> > > > Change from v1 to v2:
> > > >  - none
> > > >
> > > >  drivers/pci/endpoint/functions/pci-epf-test.c | 108 ++++++++++++++++--
> > > >  1 file changed, 98 insertions(+), 10 deletions(-)
> > > >
> > > > diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> > > > index 90d84d3bc868f..f26afd02f3a86 100644
> > > > --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> > > > +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> > > > @@ -52,9 +52,11 @@ struct pci_epf_test {
> > > >       enum pci_barno          test_reg_bar;
> > > >       size_t                  msix_table_offset;
> > > >       struct delayed_work     cmd_handler;
> > > > -     struct dma_chan         *dma_chan;
> > > > +     struct dma_chan         *dma_chan_tx;
> > > > +     struct dma_chan         *dma_chan_rx;
> > > >       struct completion       transfer_complete;
> > > >       bool                    dma_supported;
> > > > +     bool                    dma_private;
> > > >       const struct pci_epc_features *epc_features;
> > > >  };
> > > >
> > > > @@ -105,12 +107,15 @@ static void pci_epf_test_dma_callback(void *param)
> > > >   */
> > > >  static int pci_epf_test_data_transfer(struct pci_epf_test *epf_test,
> > > >                                     dma_addr_t dma_dst, dma_addr_t dma_src,
> > > > -                                   size_t len)
> > > > +                                   size_t len, dma_addr_t dma_remote,
> > > > +                                   enum dma_transfer_direction dir)
> > > >  {
> > > > +     struct dma_chan *chan = (dir == DMA_DEV_TO_MEM) ? epf_test->dma_chan_tx : epf_test->dma_chan_rx;
> > > > +     dma_addr_t dma_local = (dir == DMA_MEM_TO_DEV) ? dma_src : dma_dst;
> > > >       enum dma_ctrl_flags flags = DMA_CTRL_ACK | DMA_PREP_INTERRUPT;
> > > > -     struct dma_chan *chan = epf_test->dma_chan;
> > > >       struct pci_epf *epf = epf_test->epf;
> > > >       struct dma_async_tx_descriptor *tx;
> > > > +     struct dma_slave_config sconf = {};
> > > >       struct device *dev = &epf->dev;
> > > >       dma_cookie_t cookie;
> > > >       int ret;
> > > > @@ -120,7 +125,22 @@ static int pci_epf_test_data_transfer(struct pci_epf_test *epf_test,
> > > >               return -EINVAL;
> > > >       }
> > > >
> > > > -     tx = dmaengine_prep_dma_memcpy(chan, dma_dst, dma_src, len, flags);
> > > > +     if (epf_test->dma_private) {
> > > > +             sconf.direction = dir;
> > > > +             if (dir == DMA_MEM_TO_DEV)
> > > > +                     sconf.dst_addr = dma_remote;
> > > > +             else
> > > > +                     sconf.src_addr = dma_remote;
> > > > +
> > > > +             if (dmaengine_slave_config(chan, &sconf)) {
> > > > +                     dev_err(dev, "DMA slave config fail\n");
> > > > +                     return -EIO;
> > > > +             }
> > > > +             tx = dmaengine_prep_slave_single(chan, dma_local, len, dir, flags);
> > > > +     } else {
> > > > +             tx = dmaengine_prep_dma_memcpy(chan, dma_dst, dma_src, len, flags);
> > > > +     }
> > > > +
> > > >       if (!tx) {
> > > >               dev_err(dev, "Failed to prepare DMA memcpy\n");
> > > >               return -EIO;
> > > > @@ -148,6 +168,23 @@ static int pci_epf_test_data_transfer(struct pci_epf_test *epf_test,
> > > >       return 0;
> > > >  }
> > > >
> > > > +struct epf_dma_filter {
> > > > +     struct device *dev;
> > > > +     u32 dma_mask;
> > > > +};
> > > > +
> > > > +static bool epf_dma_filter_fn(struct dma_chan *chan, void *node)
> > > > +{
> > > > +     struct epf_dma_filter *filter = node;
> > > > +     struct dma_slave_caps caps;
> > > > +
> > > > +     memset(&caps, 0, sizeof(caps));
> > > > +     dma_get_slave_caps(chan, &caps);
> > > > +
> > > > +     return chan->device->dev == filter->dev
> > > > +             && (filter->dma_mask & caps.directions);
> > > > +}
> > > > +
> > > >  /**
> > > >   * pci_epf_test_init_dma_chan() - Function to initialize EPF test DMA channel
> > > >   * @epf_test: the EPF test device that performs data transfer operation
> > > > @@ -158,10 +195,44 @@ static int pci_epf_test_init_dma_chan(struct pci_epf_test *epf_test)
> > > >  {
> > > >       struct pci_epf *epf = epf_test->epf;
> > > >       struct device *dev = &epf->dev;
> > > > +     struct epf_dma_filter filter;
> > > >       struct dma_chan *dma_chan;
> > > >       dma_cap_mask_t mask;
> > > >       int ret;
> > > >
> > > > +     filter.dev = epf->epc->dev.parent;
> > > > +     filter.dma_mask = BIT(DMA_DEV_TO_MEM);
> > > > +
> > > > +     dma_cap_zero(mask);
> > > > +     dma_cap_set(DMA_SLAVE, mask);
> > > > +     dma_chan = dma_request_channel(mask, epf_dma_filter_fn, &filter);
> > > > +     if (IS_ERR_OR_NULL(dma_chan)) {
> > > > +             dev_info(dev, "Failed to get private DMA channel. Falling back to generic one\n");
> > > > +             goto fail_back_tx;
> > > > +     }
> > > > +
> > > > +     epf_test->dma_chan_rx = dma_chan;
> > > > +
> > > > +     filter.dma_mask = BIT(DMA_MEM_TO_DEV);
> > > > +     dma_chan = dma_request_channel(mask, epf_dma_filter_fn, &filter);
> > > > +
> > > > +     if (IS_ERR(dma_chan)) {
> > > > +             dev_info(dev, "Failed to get private DMA channel. Falling back to generic one\n");
> > > > +             goto fail_back_rx;
> > > > +     }
> > > > +
> > > > +     epf_test->dma_chan_tx = dma_chan;
> > > > +     epf_test->dma_private = true;
> > > > +
> > > > +     init_completion(&epf_test->transfer_complete);
> > > > +
> > > > +     return 0;
> > > > +
> > > > +fail_back_rx:
> > > > +     dma_release_channel(epf_test->dma_chan_rx);
> > > > +     epf_test->dma_chan_tx = NULL;
> > > > +
> > > > +fail_back_tx:
> > > >       dma_cap_zero(mask);
> > > >       dma_cap_set(DMA_MEMCPY, mask);
> > > >
> > > > @@ -174,7 +245,7 @@ static int pci_epf_test_init_dma_chan(struct pci_epf_test *epf_test)
> > > >       }
> > > >       init_completion(&epf_test->transfer_complete);
> > > >
> > > > -     epf_test->dma_chan = dma_chan;
> > > > +     epf_test->dma_chan_tx = epf_test->dma_chan_rx = dma_chan;
> > > >
> > > >       return 0;
> > > >  }
> > > > @@ -190,8 +261,17 @@ static void pci_epf_test_clean_dma_chan(struct pci_epf_test *epf_test)
> > > >       if (!epf_test->dma_supported)
> > > >               return;
> > > >
> > > > -     dma_release_channel(epf_test->dma_chan);
> > > > -     epf_test->dma_chan = NULL;
> > > > +     dma_release_channel(epf_test->dma_chan_tx);
> > > > +     if (epf_test->dma_chan_tx == epf_test->dma_chan_rx) {
> > > > +             epf_test->dma_chan_tx = NULL;
> > > > +             epf_test->dma_chan_rx = NULL;
> > > > +             return;
> > > > +     }
> > > > +
> > > > +     dma_release_channel(epf_test->dma_chan_rx);
> > > > +     epf_test->dma_chan_rx = NULL;
> > > > +
> > > > +     return;
> > > >  }
> > > >
> > > >  static void pci_epf_test_print_rate(const char *ops, u64 size,
> > > > @@ -280,8 +360,14 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test)
> > > >                       goto err_map_addr;
> > > >               }
> > > >
> > > > +             if (epf_test->dma_private) {
> > > > +                     dev_err(dev, "Cannot transfer data using DMA\n");
> > > > +                     ret = -EINVAL;
> > > > +                     goto err_map_addr;
> > > > +             }
> > > > +
> > > >               ret = pci_epf_test_data_transfer(epf_test, dst_phys_addr,
> > > > -                                              src_phys_addr, reg->size);
> > > > +                                              src_phys_addr, reg->size, 0, DMA_MEM_TO_MEM);
> > > >               if (ret)
> > > >                       dev_err(dev, "Data transfer failed\n");
> > > >       } else {
> > > > @@ -363,7 +449,8 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test)
> > > >
> > > >               ktime_get_ts64(&start);
> > > >               ret = pci_epf_test_data_transfer(epf_test, dst_phys_addr,
> > > > -                                              phys_addr, reg->size);
> > > > +                                              phys_addr, reg->size,
> > > > +                                              reg->src_addr, DMA_DEV_TO_MEM);
> > > >               if (ret)
> > > >                       dev_err(dev, "Data transfer failed\n");
> > > >               ktime_get_ts64(&end);
> > > > @@ -453,8 +540,9 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
> > > >               }
> > > >
> > > >               ktime_get_ts64(&start);
> > > > +
> > > >               ret = pci_epf_test_data_transfer(epf_test, phys_addr,
> > > > -                                              src_phys_addr, reg->size);
> > > > +                                              src_phys_addr, reg->size, reg->dst_addr, DMA_MEM_TO_DEV);
> > > >               if (ret)
> > > >                       dev_err(dev, "Data transfer failed\n");
> > > >               ktime_get_ts64(&end);
> > > > --
> > > > 2.35.1
> > > >
