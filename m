Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17AA753178C
	for <lists+dmaengine@lfdr.de>; Mon, 23 May 2022 22:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbiEWTeV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 23 May 2022 15:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbiEWTeB (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 23 May 2022 15:34:01 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1C9C5E62;
        Mon, 23 May 2022 12:19:47 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id j6so14501080pfe.13;
        Mon, 23 May 2022 12:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UVvMn+TgwzQV6NzCLRRDNIopSC8Wahi3SFVLhRftmPM=;
        b=LtGIq59Cjg2YlaVx/41WGKBVuZ7QpD0N6d+shomHDTbJNufa/Dxz7fjuDW/YmTgeTc
         BtRwCi9PdlZRBz8INEkEyn7lQGr3g9HJlqhFoWj8SN1jsrXpfVSWA2xu9aqKtrr5yKyi
         IgL47nfzTEX0aiZ4XzGnh628OToZJCgnVVShSGE0RS7iJU99/u0+VNB/RWfbPfyBSwfU
         Mlrg6UPgilE9O4nH9gbv3gxnLSQJHBuAKSlvWhNxgOqyLSzrsAqen2BFSPYLKG0TSsxy
         jKiEd2LwDxAslfUSrkYbQPcPPbbVUp6ZikYQdIOvb16dyujrnejOk2IZscj4UmTuXyQR
         y2LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UVvMn+TgwzQV6NzCLRRDNIopSC8Wahi3SFVLhRftmPM=;
        b=PGuruI4Tg3NcTgYSsK/hqpcPVyH48IUZOJj8OV/C0wvf1b25kqcx7lmWJpvPnI1Fhf
         PvDJ0nBS6xKOLnPzjKvI4HYiiWkB6aAf6vbNb2mvgMEmD3bAo6g5LIbKlHS5E2jJ3fs/
         rY5eMA781PlIVjCEufVVBu+qeS3IqowrUeoT04Rizz9XIqbEnF6bsUJklNU3q61yhHAG
         nC/0FEX6W2K4Idgv+a46QF4NQsqnMVz6wyJcGEMTYb5x5Od6nGA+snWb4qO/K3Qg4oU2
         4M9sefi2qbyH6thwEk0JhEwKtw7GFCBlMOjrcdjhZ+eBVsoC35bSXIalt/fgVtbsqHUt
         Iqjw==
X-Gm-Message-State: AOAM532aA/vNOtHg/7brj8NFpNW0td7zTH/eLm9PjhB/hDT6THDxQ6GP
        zvNL2gnIeFQ0edjkhONpuTWKezIl0naTwVjfm4o=
X-Google-Smtp-Source: ABdhPJzXoILuD/kw9F5HKch2eMRNj5BWQbb9rEd4EaWnVKxALhJwG/WRYzSiAiaNyp7Jcyt7Zb4byjvyvfVpImfLfCs=
X-Received: by 2002:a63:5960:0:b0:3f2:3f20:4223 with SMTP id
 j32-20020a635960000000b003f23f204223mr21551543pgm.151.1653333586223; Mon, 23
 May 2022 12:19:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220517151915.2212838-9-Frank.Li@nxp.com> <20220523182219.GA168626@bhelgaas>
In-Reply-To: <20220523182219.GA168626@bhelgaas>
From:   Zhi Li <lznuaa@gmail.com>
Date:   Mon, 23 May 2022 14:19:34 -0500
Message-ID: <CAHrpEqSuojypCKdueN-G9c=GQ0zHnPqLb3S6e28V8cchA=qyfA@mail.gmail.com>
Subject: Re: [PATCH v11 8/8] PCI: endpoint: Enable DMA tests for endpoints
 with DMA capabilities
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Frank Li <Frank.Li@nxp.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        hongxing.zhu@nxp.com, Lucas Stach <l.stach@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>, linux-pci@vger.kernel.org,
        dmaengine@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, May 23, 2022 at 1:22 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Tue, May 17, 2022 at 10:19:15AM -0500, Frank Li wrote:
> > Some PCI Endpoints controllers integrate an eDMA (embedded DMA).
> > eDMA only sends once a bus read/write command to complete once
> > data transfer. eDMA can bypass the outbound memory address translation
> > unit to access all RC memory space.
>
> s/Endpoints/Endpoint/
>
> I'm not sure what "only sends once a command to complete once
> transfer" means or why it is revelant here.  I guess it just means
> "the eDMA controller issues a single bus command per data transfer"?
>
> > Add DMA support for pci-epf-test.
>
> It looks like pci-epf-test.c already *has* DMA support, but you're
> adding support for separate RX and TX DMA channels.

pci-epf-test already has memory to memory DMA support.
I added eDMA support.

>
> > EPF test can use, depending on HW availability, eDMA or general system
> > DMA controllers to perform DMA. The test probes the EPF DMA channel
> > capabilities.
> >
> > Separate dma_chan to dma_chan_tx and dma_chan_rx. eDMA channels have
> > higher priority than general DMA channels.
>
> I think the "priority" you refer to is merely that the *test* uses
> eDMA channels if present, not that there's any actual hardware
> priority involved here, right?

Yes,  choose EDMA channel first if it exists,  then choose memory to
memory dma channel.


>
> > If general memory to memory
> > DMA hannels are used, dma_chan_rx = dma_chan_tx.
>
> s/hannels/channels/
>
> > Add dma_addr_t dma_remote in function pci_epf_test_data_transfer()
> > because eDMA using remote RC physical address directly
>
> s/function pci_epf_test_data_transfer()/pci_epf_test_data_transfer()/
> s/eDMA using/eDMA uses/
> s/directly/directly./
>
> (No need to specify "function" since the parens make it obvious that
> pci_epf_test_data_transfer() is a function.  Same thing below.)
>
> > Add enum dma_transfer_direction dir in function pci_epf_test_data_transfer()
> > because eDMA chooses the correct RX/TX channel by dir.
> >
> > The overall steps are
> >
> > 1. Execute dma_request_channel() and filter function to find correct eDMA
> > RX and TX Channel. If a channel does not exist,  fallback to try to allocate
> > general memory to memory DMA  channel.
>
> s/exist,  /exist, /             remove extra space
> s/memory DMA  /memory DMA /     remove extra space again
>
> > 2. Execute dmaengine_slave_config() to configure remote side physical address.
>
> Rewrap to fit in 75 columns.
>
> > 3. Execute dmaengine_prep_slave_single() to create transfer descriptor.
> > 4. Execute tx_submit().
> > 5. Execute dma_async_issue_pending()
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---

Bjorn:  Are you satisfied with the below message?  I will fix the
other code in the next version.

Some PCI Endpoint controllers integrate an eDMA (embedded DMA).
The eDMA controller issues a single bus command per data transfer.
eDMA can bypass the outbound memory address translation unit to
access all RC memory space.

Add eDMA support for pci-epf-test.

EPF test can use, depending on HW availability, eDMA or general system
DMA controllers to perform DMA. The test probes the EPF DMA channel
capabilities.

Separate dma_chan to dma_chan_tx and dma_chan_rx. Search eDMA channel
firstly, then search memory to memory DMA channel if eDMA does not exist.
If general memory to memory channels are used, dma_chan_rx = dma_chan_tx.

Add dma_addr_t dma_remote in pci_epf_test_data_transfer()
because eDMA uses remote RC physical address directly.

Add enum dma_transfer_direction dir in pci_epf_test_data_transfer()
because eDMA chooses the correct RX/TX channel by dir.

The overall steps are

1. Execute dma_request_channel() and filter function to find correct
eDMA RX and TX Channel. If a channel does not exist, fallback to try to
allocate general memory to memory DMA channel.
2. Execute dmaengine_slave_config() to configure remote side physical
address.
3. Execute dmaengine_prep_slave_single() to create transfer descriptor.
4. Execute tx_submit().
5. Execute dma_async_issue_pending()



> > Change from v10 to v11:
> >  - rewrite commit message
> > Change from v9 to v10:
> >  - rewrite commit message
> > Change from v4 to v9:
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
>
> Please update the kernel-doc for these two new parameters.  You can
> use:
>
>   $ make W=1 drivers/pci/endpoint/functions/
>
> to find errors like this.
>
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
>
> These messages should indicate whether the failure was for the
> DEV_TO_MEM channel or the MEM_TO_DEV channel.  Otherwise the failure
> looks the same to the user.
>
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
>
> Wrap to fit in 80 columns, like the rest of the file.  There are a
> couple other cases above (the dev_info() cases are fine since we don't
> want to split info/error message strings).
>
> >               if (ret)
> >                       dev_err(dev, "Data transfer failed\n");
> >               ktime_get_ts64(&end);
> > --
> > 2.35.1
> >
