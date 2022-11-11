Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 607B96252FE
	for <lists+dmaengine@lfdr.de>; Fri, 11 Nov 2022 06:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbiKKFO0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 11 Nov 2022 00:14:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiKKFOZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 11 Nov 2022 00:14:25 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A47267F48;
        Thu, 10 Nov 2022 21:14:24 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so6817528pjc.3;
        Thu, 10 Nov 2022 21:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=srcaCHFtK2vyQ3fYNkzOxa+xrjkCW1kyZ+JRGVA6Vqw=;
        b=cRiuY95CmfdaeYKVExJSNoKjUYouXQ3xV3kzqphUAITWh0qJx2+k9AXnEDFCuIO8CX
         pJfuRK6yr7Zg/r+f8a9Ndx9EODos+WayBXd5ttHjZk4lc9AOYA2ru1uCptyucnE27rVP
         Am1ZH/Vtd4ui0EmC7heZTJIkHESNCrZ7+apxeWa6BLClgkOxmq/SNiToTSAEZYlCenu3
         3qnllG/zchH4cOEbTz9LHibeIZqwDXs1oStYoAVj6Ei6A3oeNGGHKpINtemdSohVwdyH
         Whczz3pNja1Q9y2FKZ+ojaJX9GWfLqg2SWZSONw2jzosAbUJjfItcDIbgsd439Hc+n2j
         5GRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=srcaCHFtK2vyQ3fYNkzOxa+xrjkCW1kyZ+JRGVA6Vqw=;
        b=IQg9tTdPVqzVzFFliDwjVil5mfIvSIPQPyqQIqmlphDmOiTWAu8wjXoRPmVQ+8C1XO
         GBSKIB/zjjstI/5fVapwASuvCl9//mPSRsAMiUcKpKAUp4VplUu9dkAX3TBP4hWTX0gh
         wgHZAuMQTrlq6JypFujdm0OdIGQdUBFjt06UO+EuQEPw9eP8WGIvkCCFMU9xcJc1d54g
         eBAR8oZMU8r9vK1KcDaPjqh0a8co7ZRVXElOgVJ0uewtBvUNOy9FAVMVvCRO7R5PcVV+
         w7PO/T75CMtqzxZ+VKl8Htk9e3X6Ou19KqvZrQebuOXrSs1O5LVRChx03n6vhbRINJ+D
         fZFg==
X-Gm-Message-State: ANoB5pkKVlkxNqZKV1UfVR/bm4lZEp9hZQvT7QGOGth0zDgI+6XxR064
        CfpUFuTLdK+lR7gfqyJvWTw=
X-Google-Smtp-Source: AA0mqf5doN4b/PD0hm0FXSFDJK8UtY3pGopv/1ZswZyGTJlUqB0S6e8DIRpFvGD+ZCJXkzM1NRiPUw==
X-Received: by 2002:a17:90b:274c:b0:213:e907:5c0d with SMTP id qi12-20020a17090b274c00b00213e9075c0dmr147261pjb.83.1668143663961;
        Thu, 10 Nov 2022 21:14:23 -0800 (PST)
Received: from localhost ([122.172.87.196])
        by smtp.gmail.com with ESMTPSA id x30-20020aa79a5e000000b005618189b0ffsm583785pfj.104.2022.11.10.21.14.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Nov 2022 21:14:23 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 11 Nov 2022 10:44:19 +0530
Message-Id: <CO97KPQTBTVK.2NI3OSQT2BUG7@skynet-linux>
From:   "Sireesh Kodali" <sireeshkodali1@gmail.com>
To:     "Vinod Koul" <vkoul@kernel.org>
Cc:     <andersson@kernel.org>, <agross@kernel.org>,
        <~postmarketos/upstreaming@lists.sr.ht>,
        <linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        "Vladimir Lypak" <vladimir.lypak@gmail.com>,
        "Konrad Dybcio" <konrad.dybcio@somainline.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] dmaengine: qcom: bam_dma: Add support for
 metadata
X-Mailer: aerc 0.13.0
References: <20221027052007.47403-1-sireeshkodali1@gmail.com>
 <20221027052007.47403-2-sireeshkodali1@gmail.com> <Y2UFuvg5sq9tLf83@matsya>
In-Reply-To: <Y2UFuvg5sq9tLf83@matsya>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri Nov 4, 2022 at 5:59 PM IST, Vinod Koul wrote:
> On 27-10-22, 10:50, Sireesh Kodali wrote:
> > From: Vladimir Lypak <vladimir.lypak@gmail.com>
> >=20
> > Add client metadata support for receiving information about transfers.
> > Only type of metadata implemented is amount of transferred bytes. This
> > can be used to know how much data is actually received if information
> > transferred doesn't contain header with size or is aggregated.
> >=20
> > Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
> > Signed-off-by: Sireesh Kodali <sireeshkodali1@gmail.com>
> > ---
> >  drivers/dma/qcom/bam_dma.c       | 57 ++++++++++++++++++++++++++++++++
> >  include/linux/dma/qcom_bam_dma.h |  8 +++++
> >  2 files changed, 65 insertions(+)
> >=20
> > diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
> > index 3135a3e4a167..264a9a2e199f 100644
> > --- a/drivers/dma/qcom/bam_dma.c
> > +++ b/drivers/dma/qcom/bam_dma.c
> > @@ -30,6 +30,7 @@
> >  #include <linux/module.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/dma-mapping.h>
> > +#include <linux/dma/qcom_bam_dma.h>
> >  #include <linux/scatterlist.h>
> >  #include <linux/device.h>
> >  #include <linux/platform_device.h>
> > @@ -70,6 +71,7 @@ struct bam_async_desc {
> >  	u16 flags;
> > =20
> >  	struct bam_desc_hw *curr_desc;
> > +	struct bam_dma_metadata *metadata;
> > =20
> >  	/* list node for the desc in the bam_chan list of descriptors */
> >  	struct list_head desc_node;
> > @@ -418,6 +420,52 @@ static inline void __iomem *bam_addr(struct bam_de=
vice *bdev, u32 pipe,
> >  		r.ee_mult * bdev->ee;
> >  }
> > =20
> > +/**
> > + * bam_update_metadata - update metadata buffer
> > + * @bchan: BAM channel to read metadata from
> > + * @async_desc: BAM async descriptior
> > + *
> > + * Updates metadata buffer (transfer size) based on values
> > + * read from FIFO descriptors at bchan->head
> > + */
> > +
> > +static inline void bam_update_metadata(struct bam_chan *bchan,
> > +				       struct bam_async_desc *async_desc)
> > +{
> > +	unsigned int i, e, len =3D 0;
> > +	struct bam_desc_hw *fifo;
> > +
> > +	if (!async_desc->metadata)
> > +		return;
> > +
> > +	fifo =3D PTR_ALIGN(bchan->fifo_virt, sizeof(struct bam_desc_hw));
> > +	for (i =3D bchan->head, e =3D i + async_desc->xfer_len; i < e; i++)
> > +		len +=3D fifo[i % MAX_DESCRIPTORS].size;
> > +
> > +	async_desc->metadata->xfer_len_bytes +=3D len;
> > +}
> > +
> > +/**
> > + * bam_attach_metadata - attach metadata buffer to the async descripto=
r
> > + * @desc: async descriptor
> > + * @data: buffer pointer
> > + * @len: length of passed buffer
> > + */
> > +static int bam_attach_metadata(struct dma_async_tx_descriptor *desc, v=
oid *data,
> > +			       size_t len)
> > +{
> > +	struct bam_async_desc *async_desc;
> > +
> > +	if (!data || len !=3D sizeof(struct bam_dma_metadata))
> > +		return -EINVAL;
> > +
> > +	async_desc =3D container_of(desc, struct bam_async_desc, vd.tx);
> > +	async_desc->metadata =3D data;
> > +	async_desc->metadata->xfer_len_bytes =3D 0;
> > +
> > +	return 0;
> > +}
> > +
> >  /**
> >   * bam_reset() - reset and initialize BAM registers
> >   * @bdev: bam device
> > @@ -456,6 +504,10 @@ static void bam_reset(struct bam_device *bdev)
> >  	writel_relaxed(BAM_IRQ_MSK, bam_addr(bdev, 0, BAM_IRQ_SRCS_MSK_EE));
> >  }
> > =20
> > +static struct dma_descriptor_metadata_ops metadata_ops =3D {
> > +	.attach =3D bam_attach_metadata,
> > +};
> > +
> >  /**
> >   * bam_reset_channel - Reset individual BAM DMA channel
> >   * @bchan: bam channel
> > @@ -714,6 +766,8 @@ static struct dma_async_tx_descriptor *bam_prep_sla=
ve_sg(struct dma_chan *chan,
> >  		} while (remainder > 0);
> >  	}
> > =20
> > +	async_desc->vd.tx.metadata_ops =3D &metadata_ops;
> > +
> >  	return vchan_tx_prep(&bchan->vc, &async_desc->vd, flags);
> >  }
> > =20
> > @@ -867,6 +921,8 @@ static u32 process_channel_irqs(struct bam_device *=
bdev)
> >  			if (avail < async_desc->xfer_len)
> >  				break;
> > =20
> > +			bam_update_metadata(bchan, async_desc);
> > +
> >  			/* manage FIFO */
> >  			bchan->head +=3D async_desc->xfer_len;
> >  			bchan->head %=3D MAX_DESCRIPTORS;
> > @@ -1347,6 +1403,7 @@ static int bam_dma_probe(struct platform_device *=
pdev)
> >  	bdev->common.residue_granularity =3D DMA_RESIDUE_GRANULARITY_SEGMENT;
> >  	bdev->common.src_addr_widths =3D DMA_SLAVE_BUSWIDTH_4_BYTES;
> >  	bdev->common.dst_addr_widths =3D DMA_SLAVE_BUSWIDTH_4_BYTES;
> > +	bdev->common.desc_metadata_modes =3D DESC_METADATA_CLIENT;
> >  	bdev->common.device_alloc_chan_resources =3D bam_alloc_chan;
> >  	bdev->common.device_free_chan_resources =3D bam_free_chan;
> >  	bdev->common.device_prep_slave_sg =3D bam_prep_slave_sg;
> > diff --git a/include/linux/dma/qcom_bam_dma.h b/include/linux/dma/qcom_=
bam_dma.h
> > index 68fc0e643b1b..8168b0573f45 100644
> > --- a/include/linux/dma/qcom_bam_dma.h
> > +++ b/include/linux/dma/qcom_bam_dma.h
> > @@ -8,6 +8,14 @@
> > =20
> >  #include <asm/byteorder.h>
> > =20
> > +/*
> > + * This data type is used as client metadata buffer in bam driver.
> > + */
> > +struct bam_dma_metadata {
> > +	/* Actual number of bytes transferred by hardware */
> > +	size_t xfer_len_bytes;
>
> Pls implement dmaengine_result() and report that with proper residue
> set...

Sure, I'll update the patch with this change

Regards,
Sireesh
>
> Thanks
>
> --=20
> ~Vinod

