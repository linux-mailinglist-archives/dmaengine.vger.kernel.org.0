Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 807D7D11D9
	for <lists+dmaengine@lfdr.de>; Wed,  9 Oct 2019 16:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729471AbfJIO6R (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 9 Oct 2019 10:58:17 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39107 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728019AbfJIO6Q (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 9 Oct 2019 10:58:16 -0400
Received: by mail-wr1-f68.google.com with SMTP id r3so3428806wrj.6;
        Wed, 09 Oct 2019 07:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bLOSHRRPDzF4u9wV1pAUxn+EtmiKCY8TCQWeWSJQ6Uo=;
        b=OYuPtr1jHzPRfv++Z2pCkoqLuGO/0+qLoBHw9RCheLRJMgSMKtaoTukrtr+lCdWivc
         jE0dSWd/VHkytRBntY3rh029k9/55x66tZhRxtPQCmxtwpvNb6V4J8TRdMP1SGBp1FkB
         e1aKT53MDA9G/4sgbLJzaWAt4ctbVmjqdxlkl0FXWKlk95JNfVajJmpI9ydLJ0n+y/eW
         Du/txE1OMchSZGkIlhVzo7xXk1iNsCsNPZFv+dWmIgtNSCAHdePd+2pTeTEzssDhyiPw
         W1f9LWAFCXKKZ8uFc8+8m/sPYN4lb1DKUYldNzxDewYdpm+wCva3BgwXIhh8dXEjOdyN
         PMWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bLOSHRRPDzF4u9wV1pAUxn+EtmiKCY8TCQWeWSJQ6Uo=;
        b=EcjHdAQB3qd/CBX22jmcyBknx/VPVhi6nMaYyf4PBBUg/SChQKjiZDMfAtdEkqhFfv
         sGthj3iPBe7OQO1OReEtJHt4lnl/a4KPw0ugBesAJ8WiHhK04Pl44E3X3fTTLaEQAHK5
         CiQROq5s/i13PVHnJrTjpb30/0tD4THqqIj/ezdYsd/KWUXK5h1DbKzwJONnAD41896X
         +9e1NHMV/V/lPh+4f6kdodbH6g/0CSuuvERjA+Y8f75zNKPNekyTkNoK/gQkFK1yhBL2
         AgbtwbgAhDs6XXMzEgAZ6Y5kakJlpJsazQw14LFaYtlAj0MXW0Ib5aOVuqlxCo3glrCU
         LAQA==
X-Gm-Message-State: APjAAAUKn/IIDZEV0IH0FNF7Usn+W12KfVw31TDsfYMq5w75j0iWZHpY
        4MeghLOiP1gvGgjC+Ov1fE0=
X-Google-Smtp-Source: APXvYqzhuDvocnI5zvw34t/95cTa0BVorSk8YqtdkDxCZqRGi0eKZU91Ddkfq2+aCFgxSIWAdDvDAA==
X-Received: by 2002:a5d:540d:: with SMTP id g13mr438062wrv.8.1570633094550;
        Wed, 09 Oct 2019 07:58:14 -0700 (PDT)
Received: from AlexGordeev-DPT-VI0092 ([213.86.25.46])
        by smtp.gmail.com with ESMTPSA id n18sm1645825wrq.20.2019.10.09.07.58.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Oct 2019 07:58:14 -0700 (PDT)
Date:   Wed, 9 Oct 2019 16:58:12 +0200
From:   Alexander Gordeev <a.gordeev.box@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        Michael Chen <micchen@altera.com>, dmaengine@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dmaengine: avalon: Intel Avalon-MM DMA Interface
 for PCIe
Message-ID: <20191009145811.GA3823@AlexGordeev-DPT-VI0092>
References: <cover.1570558807.git.a.gordeev.box@gmail.com>
 <3ed3c016b7fbe69e36023e7ee09c53acac8a064c.1570558807.git.a.gordeev.box@gmail.com>
 <20191009121441.GM25098@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009121441.GM25098@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Oct 09, 2019 at 03:14:41PM +0300, Dan Carpenter wrote:
> > +config AVALON_DMA_PCI_VENDOR_ID
> > +	hex "PCI vendor ID"
> > +	default "0x1172"
> > +
> > +config AVALON_DMA_PCI_DEVICE_ID
> > +	hex "PCI device ID"
> > +	default "0xe003"
> 
> This feels wrong.  Why isn't it known in advance.

Because device designers would likely use they own IDs. The ones I
put are just defaults inherited from the (Altera) reference design.

> > +	u32 *rd_flags = hw->dma_desc_table_rd.cpu_addr->flags;
> > +	u32 *wr_flags = hw->dma_desc_table_wr.cpu_addr->flags;
> > +	struct avalon_dma_desc *desc;
> > +	struct virt_dma_desc *vdesc;
> > +	bool rd_done;
> > +	bool wr_done;
> > +
> > +	spin_lock(lock);
> > +
> > +	rd_done = (hw->h2d_last_id < 0);
> > +	wr_done = (hw->d2h_last_id < 0);
> > +
> > +	if (rd_done && wr_done) {
> > +		spin_unlock(lock);
> > +		return IRQ_NONE;
> > +	}
> > +
> > +	do {
> > +		if (!rd_done && rd_flags[hw->h2d_last_id])
> > +			rd_done = true;
> > +
> > +		if (!wr_done && wr_flags[hw->d2h_last_id])
> > +			wr_done = true;
> > +	} while (!rd_done || !wr_done);
> 
> This loop is very strange.  It feels like the last_id indexes needs
> to atomic or protected from racing somehow so we don't do an out of
> bounds read.

My bad. I should have put a comment on this. This polling comes from my
reading of the Intel documentation:

"The MSI interrupt notifies the host when a DMA operation has completed.
After the host receives this interrupt, it can poll the DMA read or write
status table to determine which entry or entries have the done bit set."

"The Descriptor Controller writes a 1 to the done bit of the status DWORD
to indicate successful completion. The Descriptor Controller also sends
an MSI interrupt for the final descriptor. After receiving this MSI,
host software can poll the done bit to determine status."

I sense an ambiguity above. It sounds possible an MSI interrupt could be
delivered before corresponding done bit is set. May be imperfect wording..
Anyway, the loop does look weird and in reality I doubt I observed the
done bit unset even once. So I put this polling just in case.

> > +	struct avalon_dma_chan *chan = to_avalon_dma_chan(dma_chan);
> > +	struct avalon_dma_desc *desc;
> > +	gfp_t gfp_flags = in_interrupt() ? GFP_NOWAIT : GFP_KERNEL;
> > +	dma_addr_t dev_addr;
> > +
> > +	if (direction == DMA_MEM_TO_DEV)
> > +		dev_addr = chan->dst_addr;
> > +	else if (direction == DMA_DEV_TO_MEM)
> > +		dev_addr = chan->src_addr;
> > +	else
> > +		return NULL;
> > +
> > +	desc = kzalloc(sizeof(*desc), gfp_flags);
> 
> Everyone else does GFP_WAIT or GFP_ATOMIC.  Is GFP_KERNEL really okay?

I am not sure why not to use GFP_KERNEL from non-atomic context.
Documentation/driver-api/dmaengine/provider.rst claims always to
use GFP_NOWAIT though:

  - Any allocation you might do should be using the GFP_NOWAIT
    flag, in order not to potentially sleep, but without depleting
    the emergency pool either.

So probably I just should use GFP_NOWAIT.

Thanks, Dan!

> regards,
> dan carpenter
> 
