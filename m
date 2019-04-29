Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6F5DB6C
	for <lists+dmaengine@lfdr.de>; Mon, 29 Apr 2019 07:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbfD2FQB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 29 Apr 2019 01:16:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:34722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbfD2FQB (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 29 Apr 2019 01:16:01 -0400
Received: from localhost (unknown [171.76.113.243])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06D982075E;
        Mon, 29 Apr 2019 05:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556514960;
        bh=ywqvNzApMNOvae9TpnhhdkhMHxC1GaSR3kxRZV7fI2U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HM+cjnKSv64amNbjcm+zSBvQYXTAAAUD2x5n2uzBSmvT/dQDrqQIQRtXymafTZzPK
         qUANHvrQ5rKGq1AYHveE4x8hUePKTadsO81MirCYc/Jx4O2a8VQmNPsKToC8xnTcfY
         84NR/6LkbQoMARlFCA8VIucDFFzqQulBItE1f1ck=
Date:   Mon, 29 Apr 2019 10:45:54 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peng Ma <peng.ma@nxp.com>
Cc:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Leo Li <leoyang.li@nxp.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXT] Re: [PATCH] dmaengine: fsl-qdma: fixed the
 source/destination descriptior format
Message-ID: <20190429051554.GD3845@vkoul-mobl.Dlink>
References: <20190419084629.41742-1-peng.ma@nxp.com>
 <20190426115047.GW28103@vkoul-mobl>
 <VI1PR04MB4431E13D34650C2EE3D25861ED380@VI1PR04MB4431.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <VI1PR04MB4431E13D34650C2EE3D25861ED380@VI1PR04MB4431.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 28-04-19, 02:00, Peng Ma wrote:
> Hi Vinod,
> 
> Thanks your comments.
> Please see my comments inline.
> 
> Best Regards,
> Peng
> 
> >-----Original Message-----
> >From: Vinod Koul <vkoul@kernel.org>
> >Sent: 2019年4月26日 19:51
> >To: Peng Ma <peng.ma@nxp.com>
> >Cc: dan.j.williams@intel.com; Leo Li <leoyang.li@nxp.com>;
> >dmaengine@vger.kernel.org; linux-kernel@vger.kernel.org
> >Subject: [EXT] Re: [PATCH] dmaengine: fsl-qdma: fixed the source/destination
> >descriptior format
> >
> >Caution: EXT Email
> >
> >On 19-04-19, 08:46, Peng Ma wrote:
> >> CMD of Source/Destination descriptior format should be lower of
> >
> >s/descriptior/descriptor
> >
> [Peng Ma] Got it.
> >> struct fsl_qdma_engine number data address.
> >>
> >> Signed-off-by: Peng Ma <peng.ma@nxp.com>
> >> ---
> >>  drivers/dma/fsl-qdma.c |   29 ++++++++++++++++++-----------
> >>  1 files changed, 18 insertions(+), 11 deletions(-)
> >>
> >> diff --git a/drivers/dma/fsl-qdma.c b/drivers/dma/fsl-qdma.c index
> >> aa1d0ae..542765a 100644
> >> --- a/drivers/dma/fsl-qdma.c
> >> +++ b/drivers/dma/fsl-qdma.c
> >> @@ -113,6 +113,7 @@
> >>  /* Field definition for Descriptor offset */
> >>  #define QDMA_CCDF_STATUS             20
> >>  #define QDMA_CCDF_OFFSET             20
> >> +#define QDMA_SDDF_CMD(x)             (((u64)(x)) << 32)
> >>
> >>  /* Field definition for safe loop count*/
> >>  #define FSL_QDMA_HALT_COUNT          1500
> >> @@ -214,6 +215,12 @@ struct fsl_qdma_engine {
> >>
> >>  };
> >>
> >> +static inline void
> >> +qdma_sddf_set_cmd(struct fsl_qdma_format *sddf, u32 val) {
> >> +     sddf->data = QDMA_SDDF_CMD(val); }
> >> +
> >>  static inline u64
> >>  qdma_ccdf_addr_get64(const struct fsl_qdma_format *ccdf)  { @@
> >-341,6
> >> +348,7 @@ static void fsl_qdma_free_chan_resources(struct dma_chan
> >> *chan)  static void fsl_qdma_comp_fill_memcpy(struct fsl_qdma_comp
> >*fsl_comp,
> >>                                     dma_addr_t dst, dma_addr_t
> >src,
> >> u32 len)  {
> >> +     u32 cmd;
> >>       struct fsl_qdma_format *sdf, *ddf;
> >>       struct fsl_qdma_format *ccdf, *csgf_desc, *csgf_src, *csgf_dest;
> >>
> >> @@ -353,6 +361,7 @@ static void fsl_qdma_comp_fill_memcpy(struct
> >> fsl_qdma_comp *fsl_comp,
> >>
> >>       memset(fsl_comp->virt_addr, 0,
> >FSL_QDMA_COMMAND_BUFFER_SIZE);
> >>       memset(fsl_comp->desc_virt_addr, 0,
> >> FSL_QDMA_DESCRIPTOR_BUFFER_SIZE);
> >> +
> >>       /* Head Command Descriptor(Frame Descriptor) */
> >>       qdma_desc_addr_set64(ccdf, fsl_comp->bus_addr + 16);
> >>       qdma_ccdf_set_format(ccdf, qdma_ccdf_get_offset(ccdf)); @@
> >> -369,14 +378,14 @@ static void fsl_qdma_comp_fill_memcpy(struct
> >fsl_qdma_comp *fsl_comp,
> >>       /* This entry is the last entry. */
> >>       qdma_csgf_set_f(csgf_dest, len);
> >>       /* Descriptor Buffer */
> >> -     sdf->data =
> >> -             cpu_to_le64(FSL_QDMA_CMD_RWTTYPE <<
> >> -                         FSL_QDMA_CMD_RWTTYPE_OFFSET);
> >> -     ddf->data =
> >> -             cpu_to_le64(FSL_QDMA_CMD_RWTTYPE <<
> >> -                         FSL_QDMA_CMD_RWTTYPE_OFFSET);
> >> -     ddf->data |=
> >> -             cpu_to_le64(FSL_QDMA_CMD_LWC <<
> >FSL_QDMA_CMD_LWC_OFFSET);
> >> +     cmd = cpu_to_le32(FSL_QDMA_CMD_RWTTYPE <<
> >> +                       FSL_QDMA_CMD_RWTTYPE_OFFSET);
> >> +     qdma_sddf_set_cmd(sdf, cmd);
> >> +
> >> +     cmd = cpu_to_le32(FSL_QDMA_CMD_RWTTYPE <<
> >> +                       FSL_QDMA_CMD_RWTTYPE_OFFSET);
> >> +     cmd |= cpu_to_le32(FSL_QDMA_CMD_LWC <<
> >FSL_QDMA_CMD_LWC_OFFSET);
> >> +     qdma_sddf_set_cmd(ddf, cmd);
> >>  }
> >>
> >>  /*
> >> @@ -701,10 +710,8 @@ static irqreturn_t fsl_qdma_error_handler(int
> >> irq, void *dev_id)
> >>
> >>       intr = qdma_readl(fsl_qdma, status + FSL_QDMA_DEDR);
> >>
> >> -     if (intr) {
> >> +     if (intr)
> >>               dev_err(fsl_qdma->dma_dev.dev, "DMA transaction
> >error!\n");
> >> -             return IRQ_NONE;
> >> -     }
> >
> >this seems unrelated can you explain?
> >
> [Peng Ma] This is an added improvement. When an error occurs we should clean the error reg then to return.
> I forgot to explain it on comments. Should I add this changed to the comments?

Yes and you should make it a separate patch. A patch should do only 1
thing!

-- 
~Vinod
