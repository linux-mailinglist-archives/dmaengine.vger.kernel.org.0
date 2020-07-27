Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 379ED22E95E
	for <lists+dmaengine@lfdr.de>; Mon, 27 Jul 2020 11:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbgG0JpD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Jul 2020 05:45:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:33828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726269AbgG0JpD (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 27 Jul 2020 05:45:03 -0400
Received: from localhost (unknown [122.171.202.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E014206D7;
        Mon, 27 Jul 2020 09:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595843102;
        bh=DLS6vu+tF/Yr4axusONjg1ATVJlwfe6hyJtgwtl3cEc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nb96BsOq2UFJortPd2AwocDDVxbx43ewV+au31xXLCatkujH299GZIJ40VXDICWc+
         jz+AhXxOnYIVA8X5MlTUwOt8yLVgxxdWAZnW0JqsvaWc71gmId1L0LeQOyElEADiYS
         exnlU70eGFczsyRZcdsjPiFSRelD3n2PWlK2mi+w=
Date:   Mon, 27 Jul 2020 15:14:58 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     EastL <EastL.Lee@mediatek.com>
Cc:     Sean Wang <sean.wang@mediatek.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, matthias.bgg@gmail.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        wsd_upstream@mediatek.com, cc.hwang@mediatek.com
Subject: Re: [PATCH v6 2/4] dmaengine: mediatek-cqdma: remove redundant queue
 structure
Message-ID: <20200727094458.GU12965@vkoul-mobl>
References: <1593673564-4425-1-git-send-email-EastL.Lee@mediatek.com>
 <1593673564-4425-3-git-send-email-EastL.Lee@mediatek.com>
 <20200715061957.GA34333@vkoul-mobl>
 <1595471650.22392.12.camel@mtkswgap22>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595471650.22392.12.camel@mtkswgap22>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 23-07-20, 10:34, EastL wrote:
> On Wed, 2020-07-15 at 11:49 +0530, Vinod Koul wrote:
> > On 02-07-20, 15:06, EastL Lee wrote:
> > 
> > >  static enum dma_status mtk_cqdma_tx_status(struct dma_chan *c,
> > >  					   dma_cookie_t cookie,
> > >  					   struct dma_tx_state *txstate)
> > >  {
> > > -	struct mtk_cqdma_vchan *cvc = to_cqdma_vchan(c);
> > > -	struct mtk_cqdma_vdesc *cvd;
> > > -	struct virt_dma_desc *vd;
> > > -	enum dma_status ret;
> > > -	unsigned long flags;
> > > -	size_t bytes = 0;
> > > -
> > > -	ret = dma_cookie_status(c, cookie, txstate);
> > > -	if (ret == DMA_COMPLETE || !txstate)
> > > -		return ret;
> > > -
> > > -	spin_lock_irqsave(&cvc->vc.lock, flags);
> > > -	vd = mtk_cqdma_find_active_desc(c, cookie);
> > > -	spin_unlock_irqrestore(&cvc->vc.lock, flags);
> > > -
> > > -	if (vd) {
> > > -		cvd = to_cqdma_vdesc(vd);
> > > -		bytes = cvd->residue;
> > > -	}
> > > -
> > > -	dma_set_residue(txstate, bytes);
> > 
> > any reason why you want to remove setting residue?
> Because Mediatek CQDMA HW can't support residue.

And previously it did?
-- 
~Vinod
