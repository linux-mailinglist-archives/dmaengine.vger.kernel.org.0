Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35CBB1CBA46
	for <lists+dmaengine@lfdr.de>; Fri,  8 May 2020 23:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbgEHV5l (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 8 May 2020 17:57:41 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:36138 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727774AbgEHV5l (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 8 May 2020 17:57:41 -0400
X-IronPort-AV: E=Sophos;i="5.73,369,1583190000"; 
   d="scan'208";a="448862514"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 May 2020 23:57:17 +0200
Date:   Fri, 8 May 2020 23:57:17 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     sean.wang@mediatek.com, vkoul@kernel.org, matthias.bgg@gmail.com
cc:     dmaengine@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Nic Volanschi <eugene.volanschi@inria.fr>
Subject: question about drivers/dma/mediatek/mtk-cqdma.c
Message-ID: <alpine.DEB.2.21.2005082352340.6525@hadrien>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello,

The function mtk_cqdma_find_active_desc contains the following code:

        struct virt_dma_desc *vd;
        unsigned long flags;

        spin_lock_irqsave(&cvc->pc->lock, flags);
        list_for_each_entry(vd, &cvc->pc->queue, node)
                if (vd->tx.cookie == cookie) {
                        spin_unlock_irqrestore(&cvc->pc->lock, flags);
                        return vd;
                }

That is, from a &cvc->pc->queue there is an iteration over elements of
type virt_dma_desc.  But other uses of &cvc->pc->queue, such as in
mtk_cqdma_is_vchan_active, seem to indicate that the elements of this list
have type mtk_cqdma_vdesc.  It is not clear to me how the body of the loop
should be updated to account for this.

thanks,
julia
