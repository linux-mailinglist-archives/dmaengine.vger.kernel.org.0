Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAFD44D3B45
	for <lists+dmaengine@lfdr.de>; Wed,  9 Mar 2022 21:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237613AbiCIUp3 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 9 Mar 2022 15:45:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237574AbiCIUp2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 9 Mar 2022 15:45:28 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26080C42B3;
        Wed,  9 Mar 2022 12:44:28 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id p15so7710400ejc.7;
        Wed, 09 Mar 2022 12:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HSDYAEOoyovlbsTVfVn/zGpJ8RfXO7E3Phafc2S7OP8=;
        b=AfBSEMncWqDN8AX0I3By6PN6+bMSj44vAsUJzJ7mYsvvrBa26J9CU+nmfU0YzojgDM
         pIGCTwDOzgmI//4wUxohbdI7f0iFoiLfkMD6Eh0odEa7ACL0oDvgVbot1o+9k1Z0c+yL
         PINnvJOPAOvxEMqlPOi6JFQL75XxOuF1m2GVCr+vudkYajjSqvWJeo6vjU3lrU/Z+D1I
         jxPMBCPHb9ENYmQVHTZIsLOHpuL71SQZa31adhsCZp1d133SggdW1/J/RZuxA/MVJKs/
         gX53Y/xG4uhyoJ5Zd+sRiKd+Ba1yH3zp76Aka9EqoJ3GdsnV8rs0Ga9jlD++ezP/Gwpx
         vfEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HSDYAEOoyovlbsTVfVn/zGpJ8RfXO7E3Phafc2S7OP8=;
        b=NDCnK9uuHofaGH351OlZSZSvQeGcrzRyk5RPHPwcarc4SbVXiJtTcacvQLsmVVw9v0
         thfyju+BJl6nVrakrJIYs1BKTkUBsOnn0I+MET7C9vBxvi2hDCDLP82sGRV4Jcm9DreW
         tDQ37dEkfPJNvbjcpCFsAhOAAwePustdrkDIOwo9tf77ARyyvzptcFa9jgxTHdhn9Ime
         c03E4L0xOkVPEAnii6UW1lGfmHn+5KDvZK/NJyJvjDEUBsPYrNr32YR+BEbKFkMolZtx
         yStj+Zpy6io9eZVczOw9K2c9Xz1R/cYufJmT7EbObzYnjwlUBeIfHa3r3fIevNKiIUxA
         KkaQ==
X-Gm-Message-State: AOAM533/ULQv/N0/g/+q5SolKmrLjU5BQuVbnypWJwC+ZF6xl70+GVbv
        ky55mCWlo33daHzNCCktcmvIz08Fa2bzqH9d/nI=
X-Google-Smtp-Source: ABdhPJxTp2pKHHWmzMUPD50NLtGP5fbGdhV+pgEaaedjEFVknG3pzK0VdGFtlRoYWnwWqxqzBeEz/8/k9O+2bhEVPv4=
X-Received: by 2002:a17:906:8d8:b0:6d2:131d:be51 with SMTP id
 o24-20020a17090608d800b006d2131dbe51mr1492394eje.564.1646858666358; Wed, 09
 Mar 2022 12:44:26 -0800 (PST)
MIME-Version: 1.0
References: <20220307224750.18055-1-Frank.Li@nxp.com> <20220307224750.18055-6-Frank.Li@nxp.com>
 <20220309114428.GA134091@thinkpad>
In-Reply-To: <20220309114428.GA134091@thinkpad>
From:   Zhi Li <lznuaa@gmail.com>
Date:   Wed, 9 Mar 2022 14:44:14 -0600
Message-ID: <CAHrpEqS7_QuMXJsyxXU1peKh727R-dqjOOG-kLgB85SJtrDQ+A@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] PCI: endpoint: functions/pci-epf-test: Support PCI
 controller DMA
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Frank Li <Frank.Li@nxp.com>, gustavo.pimentel@synopsys.com,
        hongxing.zhu@nxp.com, Lucas Stach <l.stach@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>, linux-pci@vger.kernel.org,
        dmaengine@vger.kernel.org, vkoul@kernel.org,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Guo <shawnguo@kernel.org>
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

On Wed, Mar 9, 2022 at 5:44 AM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Mon, Mar 07, 2022 at 04:47:50PM -0600, Frank Li wrote:
> > Designware provided DMA support in controller. This enabled use
> > this DMA controller to transfer data.
> >
>
> Please use the term "eDMA (embedded DMA)"
>
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
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> > Resend added dmaengine@vger.kernel.org
> >
> > Change from v1 to v3
> >  - none
> >
> >  drivers/pci/endpoint/functions/pci-epf-test.c | 106 ++++++++++++++++--
> >  1 file changed, 96 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> > index 90d84d3bc868f..22ae420c30693 100644
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
> > @@ -105,14 +107,17 @@ static void pci_epf_test_dma_callback(void *param)
> >   */
> >  static int pci_epf_test_data_transfer(struct pci_epf_test *epf_test,
> >                                     dma_addr_t dma_dst, dma_addr_t dma_src,
> > -                                   size_t len)
> > +                                   size_t len, dma_addr_t remote,
>
> dma_remote to align with other parameters
>
> > +                                   enum dma_transfer_direction dir)
> >  {
> >       enum dma_ctrl_flags flags = DMA_CTRL_ACK | DMA_PREP_INTERRUPT;
> > -     struct dma_chan *chan = epf_test->dma_chan;
> > +     struct dma_chan *chan = (dir == DMA_DEV_TO_MEM) ? epf_test->dma_chan_tx : epf_test->dma_chan_rx;
>
> Move this to top for reverse Xmas tree order
>
> >       struct pci_epf *epf = epf_test->epf;
> >       struct dma_async_tx_descriptor *tx;
> >       struct device *dev = &epf->dev;
> >       dma_cookie_t cookie;
> > +     struct dma_slave_config sconf;
>
> struct dma_slave_config sconf = {}
>
> This can save one memset() below
>
> > +     dma_addr_t local = (dir == DMA_MEM_TO_DEV) ? dma_src : dma_dst;
>
> dma_local?
>
> >       int ret;
> >
> >       if (IS_ERR_OR_NULL(chan)) {
> > @@ -120,7 +125,20 @@ static int pci_epf_test_data_transfer(struct pci_epf_test *epf_test,
> >               return -EINVAL;
> >       }
> >
> > -     tx = dmaengine_prep_dma_memcpy(chan, dma_dst, dma_src, len, flags);
> > +     if (epf_test->dma_private) {
> > +             memset(&sconf, 0, sizeof(sconf));
> > +             sconf.direction = dir;
> > +             if (dir == DMA_MEM_TO_DEV)
> > +                     sconf.dst_addr = remote;
> > +             else
> > +                     sconf.src_addr = remote;
> > +
> > +             dmaengine_slave_config(chan, &sconf);
>
> This could fail
>
> > +             tx = dmaengine_prep_slave_single(chan, local, len, dir, flags);
> > +     } else {
> > +             tx = dmaengine_prep_dma_memcpy(chan, dma_dst, dma_src, len, flags);
> > +     }
> > +
> >       if (!tx) {
> >               dev_err(dev, "Failed to prepare DMA memcpy\n");
> >               return -EIO;
> > @@ -148,6 +166,23 @@ static int pci_epf_test_data_transfer(struct pci_epf_test *epf_test,
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
>
> This will not work when read/write channel counts are greater than 1. You would
> need this patch:
>
> https://git.linaro.org/landing-teams/working/qualcomm/kernel.git/commit/?h=tracking-qcomlt-sdx55-drivers&id=c77ad9d929372b1ff495709714b24486d266a810
>
> Feel free to pick it up in next iteration
>
> > +}
> > +
> >  /**
> >   * pci_epf_test_init_dma_chan() - Function to initialize EPF test DMA channel
> >   * @epf_test: the EPF test device that performs data transfer operation
> > @@ -160,8 +195,42 @@ static int pci_epf_test_init_dma_chan(struct pci_epf_test *epf_test)
> >       struct device *dev = &epf->dev;
> >       struct dma_chan *dma_chan;
> >       dma_cap_mask_t mask;
> > +     struct epf_dma_filter filter;
>
> Please preserve the reverse Xmas tree order
>
> >       int ret;
> >
> > +     filter.dev = epf->epc->dev.parent;
> > +     filter.dma_mask = BIT(DMA_DEV_TO_MEM);
> > +
> > +     dma_cap_zero(mask);
> > +     dma_cap_set(DMA_SLAVE, mask);
> > +     dma_chan = dma_request_channel(mask, epf_dma_filter_fn, &filter);
> > +     if (IS_ERR(dma_chan)) {
>
> dma_request_channel() can return NULL also. So use IS_ERR_OR_NULL() for error
> check
>
> > +             dev_info(dev, "Failure get built-in DMA channel, fail back to try allocate general DMA channel\n");
>
> "Failed to get private DMA channel. Falling back to generic one"
>
> > +             goto fail_back_tx;
> > +     }
> > +
> > +     epf_test->dma_chan_rx = dma_chan;
> > +
> > +     filter.dma_mask = BIT(DMA_MEM_TO_DEV);
> > +     dma_chan = dma_request_channel(mask, epf_dma_filter_fn, &filter);
> > +
> > +     if (IS_ERR(dma_chan)) {
> > +             dev_info(dev, "Failure get built-in DMA channel, fail back to try allocate general DMA channel\n");
>
> "Failed to get private DMA channel. Falling back to generic one"
>
> > +             goto fail_back_rx;
> > +     }
> > +
> > +     epf_test->dma_chan_tx = dma_chan;
> > +     epf_test->dma_private = true;
> > +
> > +     init_completion(&epf_test->transfer_complete);
>
> You could use DECLARE_COMPLETION_ONSTACK() for simplifying the completion handling.

Keep consistent with general DMA code. It'd be better after this patch series.

>
> Thanks,
> Mani
>
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
> > @@ -174,7 +243,7 @@ static int pci_epf_test_init_dma_chan(struct pci_epf_test *epf_test)
> >       }
> >       init_completion(&epf_test->transfer_complete);
> >
> > -     epf_test->dma_chan = dma_chan;
> > +     epf_test->dma_chan_tx = epf_test->dma_chan_rx = dma_chan;
> >
> >       return 0;
> >  }
> > @@ -190,8 +259,17 @@ static void pci_epf_test_clean_dma_chan(struct pci_epf_test *epf_test)
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
> > @@ -280,8 +358,14 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test)
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
> > @@ -363,7 +447,8 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test)
> >
> >               ktime_get_ts64(&start);
> >               ret = pci_epf_test_data_transfer(epf_test, dst_phys_addr,
> > -                                              phys_addr, reg->size);
> > +                                              phys_addr, reg->size,
> > +                                              reg->src_addr, DMA_DEV_TO_MEM);
> >               if (ret)
> >                       dev_err(dev, "Data transfer failed\n");
> >               ktime_get_ts64(&end);
> > @@ -453,8 +538,9 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
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
> > 2.24.0.rc1
> >
