Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 484401CD7AB
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2020 13:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbgEKLUZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 May 2020 07:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725993AbgEKLUY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 11 May 2020 07:20:24 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7652FC061A0C
        for <dmaengine@vger.kernel.org>; Mon, 11 May 2020 04:20:24 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id r22so2829220pga.12
        for <dmaengine@vger.kernel.org>; Mon, 11 May 2020 04:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RBLnOLN/xGupOJlKhwFOgTtzNiWbEGxrtVsrReg29dM=;
        b=jjww4EQkPVY9N3ZIUCFMHngB3WtP4NTudbcC4nittAotkKcqrHTEBizhEfBsxYUmFp
         sNA5OHHUNLHs2a2RttvGx65LSCdYrGYl6ethzKoz8j8fE5Po003olVGgStHQ697Zm7Wr
         LklK7WR5a62Ndx8vRIAud1MkwuNyAD8OVmQ09PdbAHSBYOIIyGZk5J0wPY/bb14KeOtM
         DXXnQZBCpeYJCJ+7H7Vrf5oI/yFMAwzbXvlA+yJbIjP4fPj2+HQR91dx/fr8c5WVvIiy
         9P/4I1QpbAGK6XG2RjsJUMGO6HOt01jVYQ/SzvxkQuHl9FUPtbyMF6AYC1E5vYV6INeB
         EC/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RBLnOLN/xGupOJlKhwFOgTtzNiWbEGxrtVsrReg29dM=;
        b=lN7DZDcU8k1+R9tZb8kOX/KWWl2h+w/hZds7Tf9DaSc5uEZ30nasue0WXMA5dcH7mN
         j89HcQnoxNPYTYl/wzgz+PZvpbokLAfIWXCUlbnj7pV5SGFRdIuXMnhJJTPfZ7QQFuq8
         AnkffExytRenx6p/1K7egFU2W5904HCwLb8jT8nTYyualNHTgq7EWaM+hpNIKrUt+eqE
         xBxsiKzWUZlnqr8YxMORumAidNiNSxgdJsGMjEj0HXWtBUyaqfk/WGV5Jk/WQKWsBMqc
         1TaT+7FRJJpRU95XCc8mG3O8czHF6CF7dAGlakrzxqdK0in+Py+d5cOCbjY90Ulgmmx4
         SiyA==
X-Gm-Message-State: AGi0PubkSY2sms6xC3iQbEdWQvUe+8kaDQn8H1zDnHFKUgOFSoJT5Qzl
        27KcZTvWoGcc4YA1/kM2u4B8
X-Google-Smtp-Source: APiQypL8r6gRZ4l8eCnXJA+pCEdbAsE/7V+4j2AYFLeau2y3pPOdAUkE7gI7rV/xyf134iuSWun9zQ==
X-Received: by 2002:aa7:819a:: with SMTP id g26mr15560891pfi.193.1589196023626;
        Mon, 11 May 2020 04:20:23 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id 188sm5350690pfx.141.2020.05.11.04.20.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 May 2020 04:20:22 -0700 (PDT)
Date:   Mon, 11 May 2020 16:50:14 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Amit Tomer <amittomer25@gmail.com>
Cc:     Andre Przywara <andre.przywara@arm.com>, vkoul@kernel.org,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        dan.j.williams@intel.com, cristian.ciocaltea@gmail.com,
        dmaengine@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-actions@lists.infradead.org
Subject: Re: [PATCH RFC 1/8] dmaengine: Actions: get rid of bit fields from
 dma descriptor
Message-ID: <20200511112014.GA3322@Mani-XPS-13-9360>
References: <1588761371-9078-1-git-send-email-amittomer25@gmail.com>
 <1588761371-9078-2-git-send-email-amittomer25@gmail.com>
 <20200510155159.GA27924@Mani-XPS-13-9360>
 <CABHD4K_h7wc1gc3wvya1PRTRjMRkDPW==yrAWSk7cCF9ghkUjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABHD4K_h7wc1gc3wvya1PRTRjMRkDPW==yrAWSk7cCF9ghkUjg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, May 11, 2020 at 04:15:57PM +0530, Amit Tomer wrote:
> Hi
> 
> Thanks for the reply.
> 
> > I'm in favor of getting rid of bitfields due to its not so defined way of
> > working (and forgive me for using it in first place) but I don't quite like
> > the current approach.
> 
> Because , its less readable the way we are writing to those different fields ?
> But this can be made more verbose by adding some comments around .
> 

I don't like the way the hw linked lists are accessed (using an array with
enums).

> > Rather I'd like to have custom bitmasks (S900/S700/S500?) for writing to those
> > fields.
> >
> I think S900 and S500 are same as pointed out by Cristian. and I didn't get by
> creating custom bitmasks for it ?
> 
> Did you mean function like:
> 
> lli->hw[OWL_DMADESC_FLEN]= llc_hw_FLEN(len, FCNT_VALUE, FCNT_SHIFT);
> 

I meant to keep using old struct for accessing the linked list and replacing
bitfields with masks as below:

struct owl_dma_lli_hw {
	...
        u32     flen;
        u32     fcnt;
	...
};

hw->flen = len & OWL_S900_DMA_FLEN_MASK;
hw->fcnt = 1 & OWL_S900_DMA_FCNT_MASK;

Then you can use different masks for S700/S900 based on the compatible.

Thanks,
Mani

> Thanks
> -Amit
