Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37742438F45
	for <lists+dmaengine@lfdr.de>; Mon, 25 Oct 2021 08:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbhJYGTs (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 25 Oct 2021 02:19:48 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:12820 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbhJYGTr (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 25 Oct 2021 02:19:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1635142642;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=FzGDnxr5iXiYUSz2axj//eT4Wsv8vgWvAfW+iVGHdf8=;
    b=ImfAx+t4NXRYNr0a6G3iB9mT/O1t9DcFUMzYWZCq0RrQVfit2gU8t8CufoZr4KJREm
    Tj/vd6t/Ar//kz7xeq/+leVFICZ6n7YvhaXGJDrAwVMMr9XfqdmMN4Lde9Cob3RCxA+d
    b7Kgfqql2J34Lja18GF8LWH+oBIecqQIV5mAvR7zebGinjWzVKmrQaevOyY+MgnpyXss
    +HtJIthQyLyM8MWe7+9040VAy4+0xDWzjLG5qnh1RGk10jk+OLiOZDrh2HCv23T0ozkC
    M4rgDRPocd8M8FZU6gmDxqOLw4p4YC9h9aQiQlhgLjxXUohPo37WxgeXHDZ7P/Z67q6z
    bYPw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u267FZF9PwpcNKLVrK8+86Y="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 47.33.8 AUTH)
    with ESMTPSA id 301038x9P6HL6Ln
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 25 Oct 2021 08:17:21 +0200 (CEST)
Date:   Mon, 25 Oct 2021 08:17:15 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v3 0/2] dmaengine: qcom: bam_dma: Add "powered remotely"
 mode for BAM-DMUX
Message-ID: <YXZL655lHukjar/x@gerhold.net>
References: <20211018102421.19848-1-stephan@gerhold.net>
 <YXZFGFH5lxDKeenw@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXZFGFH5lxDKeenw@matsya>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Oct 25, 2021 at 11:18:08AM +0530, Vinod Koul wrote:
> On 18-10-21, 12:24, Stephan Gerhold wrote:
> > The BAM Data Multiplexer (BAM-DMUX) provides access to the network data
> > channels of modems integrated into many older Qualcomm SoCs, e.g.
> > Qualcomm MSM8916 or MSM8974.
> > 
> > Shortly said, BAM-DMUX is built using a simple protocol layer on top of
> > a DMA engine (Qualcomm BAM DMA). For BAM-DMUX, the BAM DMA engine runs in
> > a special mode where the modem/remote side is responsible for powering
> > on the BAM when needed but we are responsible to initialize it.
> > The BAM is powered off when unneeded by coordinating power control
> > via bidirectional interrupts from the BAM-DMUX driver.
> > 
> > This series adds one possible solution for handling the "powered remotely"
> > mode in the bam_dma driver.
> 
> This looks good me me. Bhupesh/Stephan what was the conclusion on the
> the discussion you folks had?
> 

Basically I said I would wait if you still want to take this for 5.16. :)
There is a conflict with the DT schema conversion in Bhupesh's series,
but it's trivial to solve no matter which of the patches is applied first.

Since Bhupesh still needs to send v5 as far as I can tell (and has a
much larger series overall), I think it's fine to apply this one first.

Bhupesh, you can just copy-paste this below qcom,controlled-remotely
in your DT schema if Vinod applies this patch first:

  qcom,powered-remotely:
    $ref: /schemas/types.yaml#/definitions/flag
    description:
      Indicates that the bam is powered up by a remote processor
      but must be initialized by the local processor.

Thanks!
Stephan
