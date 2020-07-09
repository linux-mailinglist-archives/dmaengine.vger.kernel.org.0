Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66B6021A076
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2020 15:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgGINGm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 9 Jul 2020 09:06:42 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:35906 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbgGINGm (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 9 Jul 2020 09:06:42 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 069D6aOG118789;
        Thu, 9 Jul 2020 08:06:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1594299996;
        bh=wf4821EC69+aP0BKeLO1uHp0gJaat/DBIbUWaN80s/M=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=drJdZ8WKHTmcxG5IWmoty0GKKU9v48Qb0rKjiFQYkolKQFyOvf1hsg3cQ0QnAIJR7
         AjEG/U9Cbx2MAQ1BWQi30s8yrLYi6roh3wXTJqB85JR7xc1IrmVoFpjS0KEPMVoQPv
         hEzNe8z5YzLi9KNbHLNvw+wyuP9lXI2dMyPU4ujs=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 069D6aPm015214;
        Thu, 9 Jul 2020 08:06:36 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 9 Jul
 2020 08:06:36 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 9 Jul 2020 08:06:36 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 069D6YBD090529;
        Thu, 9 Jul 2020 08:06:34 -0500
Subject: Re: [PATCH v6 2/6] dmaengine: virt-dma: Use lockdep to check locking
 requirements
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        <dmaengine@vger.kernel.org>
CC:     Michal Simek <michal.simek@xilinx.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>,
        Satish Kumar Nagireddy <SATISHNA@xilinx.com>,
        Vinod Koul <vkoul@kernel.org>
References: <20200708201906.4546-1-laurent.pinchart@ideasonboard.com>
 <20200708201906.4546-3-laurent.pinchart@ideasonboard.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
X-Pep-Version: 2.0
Message-ID: <c4ae1bd2-eafd-136e-71f6-1d85149d776a@ti.com>
Date:   Thu, 9 Jul 2020 16:07:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200708201906.4546-3-laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Laurent,

On 08/07/2020 23.19, Laurent Pinchart wrote:
> A few virt-dma functions are documented as requiring the vc.lock to be
> held by the caller. Check this with lockdep.
>=20
> The vchan_vdesc_fini() and vchan_find_desc() functions gain a lockdep

vchan_vdesc_fini() is used outside of held vc->lock via vchan_complete()
and the customized local re-implementation of it in ti/k3-udma.c

This patch did not adds the lockdep_assert_held() to the _fini.
The vchan_complete() can be issue only in  case when the descriptor is
set to DMA_CTRL_REUSE.

> check as well, because, even though they are not documented with this
> requirement (and not documented at all for the latter), they touch
> fields documented as protected by vc.lock. All callers have been
> manually inspected to verify they call the functions with the lock held=
=2E
>=20
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
>  drivers/dma/virt-dma.c |  2 ++
>  drivers/dma/virt-dma.h | 10 ++++++++++
>  2 files changed, 12 insertions(+)
>=20
> diff --git a/drivers/dma/virt-dma.c b/drivers/dma/virt-dma.c
> index 23e33a85f033..1cb36ab3d9c1 100644
> --- a/drivers/dma/virt-dma.c
> +++ b/drivers/dma/virt-dma.c
> @@ -68,6 +68,8 @@ struct virt_dma_desc *vchan_find_desc(struct virt_dma=
_chan *vc,
>  {
>  	struct virt_dma_desc *vd;
> =20
> +	lockdep_assert_held(&vc->lock);
> +
>  	list_for_each_entry(vd, &vc->desc_issued, node)
>  		if (vd->tx.cookie =3D=3D cookie)
>  			return vd;
> diff --git a/drivers/dma/virt-dma.h b/drivers/dma/virt-dma.h
> index e9f5250fbe4d..59d9eabc8b67 100644
> --- a/drivers/dma/virt-dma.h
> +++ b/drivers/dma/virt-dma.h
> @@ -81,6 +81,8 @@ static inline struct dma_async_tx_descriptor *vchan_t=
x_prep(struct virt_dma_chan
>   */
>  static inline bool vchan_issue_pending(struct virt_dma_chan *vc)
>  {
> +	lockdep_assert_held(&vc->lock);
> +
>  	list_splice_tail_init(&vc->desc_submitted, &vc->desc_issued);
>  	return !list_empty(&vc->desc_issued);
>  }
> @@ -96,6 +98,8 @@ static inline void vchan_cookie_complete(struct virt_=
dma_desc *vd)
>  	struct virt_dma_chan *vc =3D to_virt_chan(vd->tx.chan);
>  	dma_cookie_t cookie;
> =20
> +	lockdep_assert_held(&vc->lock);
> +
>  	cookie =3D vd->tx.cookie;
>  	dma_cookie_complete(&vd->tx);
>  	dev_vdbg(vc->chan.device->dev, "txd %p[%x]: marked complete\n",
> @@ -146,6 +150,8 @@ static inline void vchan_terminate_vdesc(struct vir=
t_dma_desc *vd)
>  {
>  	struct virt_dma_chan *vc =3D to_virt_chan(vd->tx.chan);
> =20
> +	lockdep_assert_held(&vc->lock);
> +
>  	list_add_tail(&vd->node, &vc->desc_terminated);
> =20
>  	if (vc->cyclic =3D=3D vd)
> @@ -160,6 +166,8 @@ static inline void vchan_terminate_vdesc(struct vir=
t_dma_desc *vd)
>   */
>  static inline struct virt_dma_desc *vchan_next_desc(struct virt_dma_ch=
an *vc)
>  {
> +	lockdep_assert_held(&vc->lock);
> +
>  	return list_first_entry_or_null(&vc->desc_issued,
>  					struct virt_dma_desc, node);
>  }
> @@ -177,6 +185,8 @@ static inline struct virt_dma_desc *vchan_next_desc=
(struct virt_dma_chan *vc)
>  static inline void vchan_get_all_descriptors(struct virt_dma_chan *vc,=

>  	struct list_head *head)
>  {
> +	lockdep_assert_held(&vc->lock);
> +
>  	list_splice_tail_init(&vc->desc_allocated, head);
>  	list_splice_tail_init(&vc->desc_submitted, head);
>  	list_splice_tail_init(&vc->desc_issued, head);
>=20

- P=C3=A9ter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

